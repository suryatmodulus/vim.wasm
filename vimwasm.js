export const VIM_VERSION="8.1.1661";export const VIM_FEATURE="normal";function noop(){}let debug=noop;const STATUS_NOTIFY_KEY=1;const STATUS_NOTIFY_RESIZE=2;const STATUS_NOTIFY_OPEN_FILE_BUF_COMPLETE=3;const STATUS_NOTIFY_CLIPBOARD_WRITE_COMPLETE=4;const STATUS_REQUEST_CMDLINE=5;const STATUS_REQUEST_SHARED_BUF=6;const STATUS_NOTIFY_ERROR_OUTPUT=7;export function checkBrowserCompatibility(){function notSupported(feat){return`${feat} is not supported by this browser. If you're using Firefox or Safari, please enable feature flag.`}if(typeof SharedArrayBuffer==="undefined"){return notSupported("SharedArrayBuffer")}if(typeof Atomics==="undefined"){return notSupported("Atomics API")}return undefined};export class VimWorker{constructor(scriptPath,onMessage,onError){this.worker=new Worker(scriptPath);this.worker.onmessage=this.recvMessage.bind(this);this.worker.onerror=this.recvError.bind(this);this.sharedBuffer=new Int32Array(new SharedArrayBuffer(Int32Array.BYTES_PER_ELEMENT*128));this.onMessage=onMessage;this.onError=onError;this.onOneshotMessage=new Map;this.debug=false}terminate(){this.worker.terminate();this.worker.onmessage=null;debug("Terminated worker thread. Thank you for working hard!")}sendStartMessage(msg){this.worker.postMessage(msg);debug("Sent start message",msg)}notifyOpenFileBufComplete(filename,bufId){let idx=1;this.sharedBuffer[idx++]=bufId;idx=this.encodeStringToBuffer(filename,idx);debug("Encoded open file buf complete event with",idx*4,"bytes. bufID:",bufId);this.awakeWorkerThread(STATUS_NOTIFY_OPEN_FILE_BUF_COMPLETE)}notifyClipboardWriteComplete(cannotSend,bufId){this.sharedBuffer[1]=+cannotSend;this.sharedBuffer[2]=bufId;debug("Encoded open file buf complete event. bufID:",bufId);this.awakeWorkerThread(STATUS_NOTIFY_CLIPBOARD_WRITE_COMPLETE)}notifyKeyEvent(key,keyCode,ctrl,shift,alt,meta){let idx=1;this.sharedBuffer[idx++]=keyCode;this.sharedBuffer[idx++]=+ctrl;this.sharedBuffer[idx++]=+shift;this.sharedBuffer[idx++]=+alt;this.sharedBuffer[idx++]=+meta;idx=this.encodeStringToBuffer(key,idx);debug("Encoded key event with",idx*4,"bytes");this.awakeWorkerThread(STATUS_NOTIFY_KEY);debug("Sent key event:",key,keyCode,ctrl,shift,alt,meta)}notifyResizeEvent(width,height){let idx=1;this.sharedBuffer[idx++]=width;this.sharedBuffer[idx++]=height;debug("Encoded resize event with",idx*4,"bytes");this.awakeWorkerThread(STATUS_NOTIFY_RESIZE);debug("Sent resize event:",width,height)}async requestSharedBuffer(byteLength){this.sharedBuffer[1]=byteLength;this.awakeWorkerThread(STATUS_REQUEST_SHARED_BUF);debug("Encoded shared buffer request event. Size:",byteLength);const msg=await this.waitForOneshotMessage("shared-buf:response");if(msg.buffer.byteLength!==byteLength){throw new Error(`Size of shared buffer from worker ${msg.buffer.byteLength} bytes mismatches to requested size ${byteLength} bytes`)}return[msg.bufId,msg.buffer]}notifyClipboardError(){this.notifyClipboardWriteComplete(true,0);debug("Reading clipboard failed. Notify it to worker")}async responseClipboardText(text){const encoded=(new TextEncoder).encode(text);const[bufId,buffer]=await this.requestSharedBuffer(encoded.byteLength+1);new Uint8Array(buffer).set(encoded);this.notifyClipboardWriteComplete(false,bufId);debug("Wrote clipboard",encoded.byteLength,"bytes text and notified to worker")}async requestCmdline(cmdline){if(cmdline.length===0){throw new Error("Specified command line is empty")}const idx=this.encodeStringToBuffer(cmdline,1);debug("Encoded request cmdline event with",idx*4,"bytes");this.awakeWorkerThread(STATUS_REQUEST_CMDLINE);const msg=await this.waitForOneshotMessage("cmdline:response");debug("Result of command",cmdline,":",msg.success);if(!msg.success){throw Error(`Command '${cmdline}' was invalid and not accepted by Vim`)}}async notifyErrorOutput(message){const encoded=(new TextEncoder).encode(message);const[bufId,buffer]=await this.requestSharedBuffer(encoded.byteLength);new Uint8Array(buffer).set(encoded);this.sharedBuffer[1]=bufId;this.awakeWorkerThread(STATUS_NOTIFY_ERROR_OUTPUT);debug("Sent error message output:",message)}async waitForOneshotMessage(kind){return new Promise(resolve=>{this.onOneshotMessage.set(kind,resolve)})}encodeStringToBuffer(s,startIdx){let idx=startIdx;const len=s.length;this.sharedBuffer[idx++]=len;for(let i=0;i<len;++i){this.sharedBuffer[idx++]=s.charCodeAt(i)}return idx}awakeWorkerThread(event){if(this.debug){const status=Atomics.load(this.sharedBuffer,0);if(status!==0){console.error("INVARIANT ERROR! Status byte must be zero cleared:",status)}}Atomics.store(this.sharedBuffer,0,event);Atomics.notify(this.sharedBuffer,0,1);debug("Notified status event",event,"to worker")}recvMessage(e){const msg=e.data;const handler=this.onOneshotMessage.get(msg.kind);if(handler!==undefined){this.onOneshotMessage.delete(msg.kind);handler(msg);return}this.onMessage(msg)}recvError(e){debug("Received an error from worker:",e);const msg=`${e.message} (${e.filename}:${e.lineno}:${e.colno})`;this.onError(new Error(msg))}};export class ResizeHandler{constructor(domWidth,domHeight,canvas,worker){this.canvas=canvas;this.worker=worker;this.elemHeight=domHeight;this.elemWidth=domWidth;const dpr=window.devicePixelRatio||1;this.canvas.width=domWidth*dpr;this.canvas.height=domHeight*dpr;this.bounceTimerToken=null;this.onResize=this.onResize.bind(this)}onVimInit(){window.addEventListener("resize",this.onResize,{passive:true})}onVimExit(){window.removeEventListener("resize",this.onResize)}doResize(){const rect=this.canvas.getBoundingClientRect();debug("Resize Vim:",rect);this.elemWidth=rect.width;this.elemHeight=rect.height;const res=window.devicePixelRatio||1;this.canvas.width=rect.width*res;this.canvas.height=rect.height*res;this.worker.notifyResizeEvent(rect.width,rect.height)}onResize(){if(this.bounceTimerToken!==null){window.clearTimeout(this.bounceTimerToken)}this.bounceTimerToken=window.setTimeout(()=>{this.bounceTimerToken=null;this.doResize()},500)}};export class InputHandler{constructor(worker,input){this.worker=worker;this.elem=input;this.onKeydown=this.onKeydown.bind(this);this.onBlur=this.onBlur.bind(this);this.onFocus=this.onFocus.bind(this);this.focus()}setFont(name,size){this.elem.style.fontFamily=name;this.elem.style.fontSize=size+"px"}focus(){this.elem.focus()}onVimInit(){this.elem.addEventListener("keydown",this.onKeydown,{capture:true});this.elem.addEventListener("blur",this.onBlur);this.elem.addEventListener("focus",this.onFocus)}onVimExit(){this.elem.removeEventListener("keydown",this.onKeydown);this.elem.removeEventListener("blur",this.onBlur);this.elem.removeEventListener("focus",this.onFocus)}onKeydown(event){event.preventDefault();event.stopPropagation();debug("onKeydown():",event,event.key,event.keyCode);let key=event.key;const ctrl=event.ctrlKey;const shift=event.shiftKey;const alt=event.altKey;const meta=event.metaKey;if(key.length>1){if(key==="Unidentified"||ctrl&&key==="Control"||shift&&key==="Shift"||alt&&key==="Alt"||meta&&key==="Meta"){debug("Ignore key input",key);return}}if(key==="¥"||!shift&&key==="|"&&event.code==="IntlYen"){key="\\"}this.worker.notifyKeyEvent(key,event.keyCode,ctrl,shift,alt,meta)}onFocus(){debug("onFocus()")}onBlur(event){debug("onBlur():",event);event.preventDefault()}};export class ScreenCanvas{constructor(worker,canvas,input){this.worker=worker;this.canvas=canvas;const ctx=this.canvas.getContext("2d",{alpha:false});if(ctx===null){throw new Error("Cannot get 2D context for <canvas>")}this.ctx=ctx;const rect=this.canvas.getBoundingClientRect();const res=window.devicePixelRatio||1;this.canvas.width=rect.width*res;this.canvas.height=rect.height*res;this.canvas.addEventListener("click",this.onClick.bind(this),{capture:true,passive:true});this.input=new InputHandler(this.worker,input);this.resizer=new ResizeHandler(rect.width,rect.height,canvas,worker);this.onAnimationFrame=this.onAnimationFrame.bind(this);this.queue=[];this.rafScheduled=false;this.perf=false}onVimInit(){this.input.onVimInit();this.resizer.onVimInit()}onVimExit(){this.input.onVimExit();this.resizer.onVimExit()}draw(msg){if(!this.rafScheduled){window.requestAnimationFrame(this.onAnimationFrame);this.rafScheduled=true}this.queue.push(msg)}focus(){this.input.focus()}getDomSize(){return{width:this.resizer.elemWidth,height:this.resizer.elemHeight}}setPerf(enabled){this.perf=enabled}setColorFG(name){this.fgColor=name}setColorBG(_name){}setColorSP(name){this.spColor=name}setFont(name,size){this.fontName=name;this.input.setFont(name,size)}drawRect(x,y,w,h,color,filled){const dpr=window.devicePixelRatio||1;x=Math.floor(x*dpr);y=Math.floor(y*dpr);w=Math.floor(w*dpr);h=Math.floor(h*dpr);this.ctx.fillStyle=color;if(filled){this.ctx.fillRect(x,y,w,h)}else{this.ctx.rect(x,y,w,h)}}drawText(text,ch,lh,cw,x,y,bold,underline,undercurl,strike){const dpr=window.devicePixelRatio||1;ch=ch*dpr;lh=lh*dpr;cw=cw*dpr;x=x*dpr;y=y*dpr;let font=Math.floor(ch)+"px "+this.fontName;if(bold){font="bold "+font}this.ctx.font=font;this.ctx.textBaseline="bottom";this.ctx.fillStyle=this.fgColor;const descent=(lh-ch)/2;const yi=Math.floor(y+lh-descent);for(let i=0;i<text.length;++i){const c=text[i];if(c===" "){continue}this.ctx.fillText(c,Math.floor(x+cw*i),yi)}if(underline){this.ctx.strokeStyle=this.fgColor;this.ctx.lineWidth=1*dpr;this.ctx.setLineDash([]);this.ctx.beginPath();const underlineY=Math.floor(y+lh-descent-1*dpr);this.ctx.moveTo(Math.floor(x),underlineY);this.ctx.lineTo(Math.floor(x+cw*text.length),underlineY);this.ctx.stroke()}else if(undercurl){this.ctx.strokeStyle=this.spColor;this.ctx.lineWidth=1*dpr;const curlWidth=Math.floor(cw/3);this.ctx.setLineDash([curlWidth,curlWidth]);this.ctx.beginPath();const undercurlY=Math.floor(y+lh-descent-1*dpr);this.ctx.moveTo(Math.floor(x),undercurlY);this.ctx.lineTo(Math.floor(x+cw*text.length),undercurlY);this.ctx.stroke()}else if(strike){this.ctx.strokeStyle=this.fgColor;this.ctx.lineWidth=1*dpr;this.ctx.beginPath();const strikeY=Math.floor(y+lh/2);this.ctx.moveTo(Math.floor(x),strikeY);this.ctx.lineTo(Math.floor(x+cw*text.length),strikeY);this.ctx.stroke()}}invertRect(x,y,w,h){const dpr=window.devicePixelRatio||1;x=Math.floor(x*dpr);y=Math.floor(y*dpr);w=Math.floor(w*dpr);h=Math.floor(h*dpr);const img=this.ctx.getImageData(x,y,w,h);const data=img.data;const len=data.length;for(let i=0;i<len;++i){data[i]=255-data[i];++i;data[i]=255-data[i];++i;data[i]=255-data[i];++i}this.ctx.putImageData(img,x,y)}imageScroll(x,sy,dy,w,h){const dpr=window.devicePixelRatio||1;x=Math.floor(x*dpr);sy=Math.floor(sy*dpr);dy=Math.floor(dy*dpr);w=Math.floor(w*dpr);h=Math.floor(h*dpr);this.ctx.drawImage(this.canvas,x,sy,w,h,x,dy,w,h)}onClick(){this.input.focus()}onAnimationFrame(){debug("Rendering",this.queue.length,"events on animation frame");this.perfMark("raf");for(const[method,args]of this.queue){this.perfMark("draw");this[method].apply(this,args);this.perfMeasure("draw",`draw:${method}`)}this.queue.length=0;this.rafScheduled=false;this.perfMeasure("raf")}perfMark(m){if(this.perf){performance.mark(m)}}perfMeasure(m,n){if(this.perf){performance.measure(n||m,m);performance.clearMarks(m)}}};export class VimWasm{constructor(opts){const script=opts.workerScriptPath||"./vim.js";this.handleError=this.handleError.bind(this);this.worker=new VimWorker(script,this.onMessage.bind(this),this.handleError);if("canvas"in opts&&"input"in opts){this.screen=new ScreenCanvas(this.worker,opts.canvas,opts.input)}else if("screen"in opts){this.screen=opts.screen}else{throw new Error("Invalid options for VimWasm construction: "+JSON.stringify(opts))}this.perf=false;this.debug=false;this.perfMessages={};this.running=false;this.end=false}start(opts){if(this.running||this.end){throw new Error("Cannot start Vim twice")}const o=opts||{clipboard:navigator.clipboard!==undefined};if(o.debug){debug=console.log.bind(console,"main:");this.worker.debug=true}this.perf=!!o.perf;this.debug=!!o.debug;this.screen.setPerf(this.perf);this.running=true;this.perfMark("init");const{width:width,height:height}=this.screen.getDomSize();const msg={kind:"start",buffer:this.worker.sharedBuffer,canvasDomWidth:width,canvasDomHeight:height,debug:this.debug,perf:this.perf,clipboard:!!o.clipboard,files:o.files||{},dirs:o.dirs||[],persistent:o.persistentDirs||[],cmdArgs:o.cmdArgs||[]};this.worker.sendStartMessage(msg);debug("Started with drawer",this.screen)}async dropFile(name,contents){if(!this.running){throw new Error("Cannot open file since Vim is not running")}debug("Handling to open file",name,contents);const[bufId,buffer]=await this.worker.requestSharedBuffer(contents.byteLength);new Uint8Array(buffer).set(new Uint8Array(contents));this.worker.notifyOpenFileBufComplete(name,bufId);debug("Wrote file",name,"to",contents.byteLength,"bytes buffer and notified it to worker")}async dropFiles(files){const reader=new FileReader;for(const file of files){const[name,contents]=await this.readFile(reader,file);await this.dropFile(name,contents)}}resize(pixelWidth,pixelHeight){this.worker.notifyResizeEvent(pixelWidth,pixelHeight)}sendKeydown(key,keyCode,modifiers){const{ctrl:ctrl=false,shift:shift=false,alt:alt=false,meta:meta=false}=modifiers||{};if(key.length>1){if(key==="Unidentified"||ctrl&&key==="Control"||shift&&key==="Shift"||alt&&key==="Alt"||meta&&key==="Meta"){debug("Ignore key input",key);return}}this.worker.notifyKeyEvent(key,keyCode,ctrl,shift,alt,meta)}cmdline(cmdline){return this.worker.requestCmdline(cmdline)}isRunning(){return this.running}focus(){this.screen.focus()}showError(message){return this.worker.notifyErrorOutput(message)}async readFile(reader,file){return new Promise((resolve,reject)=>{reader.onload=(f=>{debug("Read file",file.name,"from D&D:",f);resolve([file.name,reader.result])});reader.onerror=(()=>{reader.abort();reject(new Error(`Error on loading file ${file}`))});reader.readAsArrayBuffer(file)})}async evalJS(path,contents){debug("Evaluating JavaScript file",path,"with size",contents.byteLength,"bytes");const dec=new TextDecoder;const src=dec.decode(contents);const globalEval=eval;try{globalEval(src)}catch(err){debug("Failed to evaluate",path,"with error:",err);await this.showError(`${err.message}\n\n${err.stack}`)}}onMessage(msg){if(this.perf&&msg.timestamp!==undefined){const duration=Date.now()-msg.timestamp;const name=msg.kind==="draw"?`draw:${msg.event[0]}`:msg.kind;const timestamps=this.perfMessages[name];if(timestamps===undefined){this.perfMessages[name]=[duration]}else{this.perfMessages[name].push(duration)}}switch(msg.kind){case"draw":this.screen.draw(msg.event);debug("draw event",msg.event);break;case"title":if(this.onTitleUpdate){debug("title was updated:",msg.title);this.onTitleUpdate(msg.title)}break;case"read-clipboard:request":if(this.readClipboard){this.readClipboard().then(text=>this.worker.responseClipboardText(text)).catch(err=>{debug("Cannot read clipboard:",err);this.worker.notifyClipboardError()})}else{debug("Cannot read clipboard because VimWasm.readClipboard is not set");this.worker.notifyClipboardError()}break;case"write-clipboard":debug("Handle writing text",msg.text,"to clipboard with",this.onWriteClipboard);if(this.onWriteClipboard){this.onWriteClipboard(msg.text)}break;case"export":debug("Exporting file",msg.path,"with size",msg.contents.byteLength,"bytes with",this.onFileExport);if(this.onFileExport!==undefined){this.onFileExport(msg.path,msg.contents)}break;case"eval":this.evalJS(msg.path,msg.contents).catch(this.handleError);break;case"started":this.screen.onVimInit();if(this.onVimInit){this.onVimInit()}this.perfMeasure("init");debug("Vim started");break;case"exit":this.screen.onVimExit();this.printPerfs();this.worker.terminate();if(this.onVimExit){this.onVimExit(msg.status)}debug("Vim exited with status",msg.status);this.perf=false;this.debug=false;this.screen.setPerf(false);this.running=false;this.end=true;break;case"error":debug("Vim threw an error:",msg.message);this.handleError(new Error(msg.message));this.worker.terminate();break;default:throw new Error(`Unexpected message from worker: ${JSON.stringify(msg)}`)}}handleError(err){if(this.onError){this.onError(err)}}printPerfs(){if(!this.perf){return}{const measurements=new Map;for(const e of performance.getEntries()){const ms=measurements.get(e.name);if(ms===undefined){measurements.set(e.name,[e])}else{ms.push(e)}}const averages={};const amounts={};const timings=[];for(const[name,ms]of measurements){if(ms.length===1&&ms[0].entryType!=="measure"){timings.push(ms[0]);continue}console.log(`%c${name}`,"color: green; font-size: large");console.table(ms,["duration","startTime"]);const total=ms.reduce((a,m)=>a+m.duration,0);averages[name]=total/ms.length;amounts[name]=total}console.log("%cTimings (ms)","color: green; font-size: large");console.table(timings,["name","entryType","startTime","duration"]);console.log("%cAmount: Perf Mark Durations (ms)","color: green; font-size: large");console.table(amounts);console.log("%cAverage: Perf Mark Durations (ms)","color: green; font-size: large");console.table(averages);performance.clearMarks();performance.clearMeasures()}{const averages={};for(const name of Object.keys(this.perfMessages)){const durations=this.perfMessages[name];const total=durations.reduce((a,d)=>a+d,0);averages[name]=total/durations.length}console.log("%cAverage: Inter-thread Messages Duration (ms)","color: green; font-size: large");console.table(averages);this.perfMessages={}}}perfMark(m){if(this.perf){performance.mark(m)}}perfMeasure(m){if(this.perf){performance.measure(m,m);performance.clearMarks(m)}}};