import{VimWasm,checkBrowserCompatibility,VIM_VERSION,VIM_FEATURE}from"./vimwasm.js";const queryParams=new URLSearchParams(window.location.search);const debugging=queryParams.has("debug");const perf=queryParams.has("perf");const cmdArgs=["/home/web_user/tryit.js"].concat(queryParams.getAll("arg"));const clipboardAvailable=navigator.clipboard!==undefined;let vimIsRunning=false;function fatal(err){if(typeof err==="string"){err=new Error(err)}alert("FATAL: "+err.message);throw err}{const compatMessage=checkBrowserCompatibility();if(compatMessage!==undefined){fatal(compatMessage)}}const screenCanvasElement=document.getElementById("vim-screen");const vim=new VimWasm({canvas:screenCanvasElement,input:document.getElementById("vim-input")});screenCanvasElement.addEventListener("dragover",e=>{e.stopPropagation();e.preventDefault();if(e.dataTransfer){e.dataTransfer.dropEffect="copy"}},false);screenCanvasElement.addEventListener("drop",e=>{e.stopPropagation();e.preventDefault();if(e.dataTransfer===null){return}vim.dropFiles(e.dataTransfer.files).catch(fatal)},false);vim.onVimInit=(()=>{vimIsRunning=true});if(!perf){vim.onVimExit=(status=>{vimIsRunning=false;alert(`Vim exited with status ${status}`)})}if(!perf&&!debugging){window.addEventListener("beforeunload",e=>{if(vimIsRunning){e.preventDefault();e.returnValue=""}})}vim.onFileExport=((fullpath,contents)=>{const slashIdx=fullpath.lastIndexOf("/");const filename=slashIdx!==-1?fullpath.slice(slashIdx+1):fullpath;const blob=new Blob([contents],{type:"application/octet-stream"});const url=URL.createObjectURL(blob);const a=document.createElement("a");a.style.display="none";a.href=url;a.rel="noopener";a.download=filename;document.body.appendChild(a);a.click();document.body.removeChild(a);URL.revokeObjectURL(url)});function clipboardSupported(){if(clipboardAvailable){return undefined}alert("Clipboard API is not supported by this browser. Clipboard register is not available");return Promise.reject()}vim.readClipboard=(()=>{return clipboardSupported()||navigator.clipboard.readText()});vim.onWriteClipboard=(text=>{return clipboardSupported()||navigator.clipboard.writeText(text)});vim.onTitleUpdate=(title=>{document.title=title});vim.onError=fatal;vim.start({debug:debugging,perf:perf,clipboard:clipboardAvailable,persistentDirs:["/home/web_user/.vim"],cmdArgs:cmdArgs});if(debugging){window.vim=vim;console.log("main: Vim version:",VIM_VERSION);console.log("main: Vim feature:",VIM_FEATURE)}