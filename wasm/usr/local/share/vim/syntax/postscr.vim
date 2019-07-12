if exists("b:current_syntax")
finish
endif
syn case match
setlocal iskeyword=33-127,^(,^),^<,^>,^[,^],^{,^},^/,^%
syn keyword postscrTodo contained  TODO
syn match postscrComment        "%.*$" contains=postscrTodo,@Spell
syn match postscrDSCComment    	"^%!PS-Adobe-\d\+\.\d\+\s*.*$"
syn match postscrDSCComment    	"^%%\u\+.*$" contains=@postscrString,@postscrNumber,@Spell
syn match  postscrDSCComment    "^%%+ *.*$" contains=@postscrString,@postscrNumber,@Spell
syn match postscrName           "\k\+"
syn match postscrIdentifierError "/\{1,2}[[:space:]\[\]{}]"me=e-1
syn match postscrIdentifier     "/\{1,2}\k\+" contains=postscrConstant,postscrBoolean,postscrCustConstant
syn case ignore
syn match postscrHex            "^[[:xdigit:]][[:xdigit:][:space:]]*$"
syn match postscrInteger        "\<[+-]\=\d\+\>"
syn match postscrRadix          "\d\+#\x\+\>"
syn match postscrFloat          "[+-]\=\d\+\.\>"
syn match postscrFloat          "[+-]\=\d\+\.\d*\(e[+-]\=\d\+\)\=\>"
syn match postscrFloat          "[+-]\=\.\d\+\(e[+-]\=\d\+\)\=\>"
syn match postscrFloat          "[+-]\=\d\+e[+-]\=\d\+\>"
syn cluster postscrNumber       contains=postscrInteger,postscrRadix,postscrFloat
syn case match
syn match postscrSpecialChar    contained "\\[nrtbf\\()]"
syn match postscrSpecialCharError contained "\\[^nrtbf\\()]"he=e-1
syn match postscrSpecialChar    contained "\\\o\{1,3}"
syn region postscrASCIIString   start=+(+ end=+)+ skip=+([^)]*)+ contains=postscrSpecialChar,postscrSpecialCharError,@Spell
syn match postscrASCIIStringError ")"
syn match postscrHexCharError   contained "[^<>[:xdigit:][:space:]]"
syn region postscrHexString     start=+<\($\|[^<]\)+ end=+>+ contains=postscrHexCharError
syn match postscrHexString      "<>"
syn match postscrASCII85CharError contained "[^<>\~!-uz[:space:]]"
syn region postscrASCII85String start=+<\~+ end=+\~>+ contains=postscrASCII85CharError
syn cluster postscrString       contains=postscrASCIIString,postscrHexString,postscrASCII85String
if !exists("postscr_level")
let postscr_level = 2
endif
syn keyword postscrOperator     pop exch dup copy index roll clear count mark cleartomark counttomark
syn keyword postscrMathOperator add div idiv mod mul sub abs neg ceiling floor round truncate sqrt atan cos
syn keyword postscrMathOperator sin exp ln log rand srand rrand
syn match postscrOperator       "[\[\]{}]"
syn keyword postscrOperator     array length get put getinterval putinterval astore aload copy
syn keyword postscrRepeat       forall
syn keyword postscrOperator     dict maxlength begin end def load store known where currentdict
syn keyword postscrOperator     countdictstack dictstack cleardictstack internaldict
syn keyword postscrConstant     $error systemdict userdict statusdict errordict
syn keyword postscrOperator     string anchorsearch search token
syn keyword postscrLogicalOperator eq ne ge gt le lt and not or
if exists("postscr_andornot_binaryop")
syn keyword postscrBinaryOperator and or not
else
syn keyword postscrLogicalOperator and not or
endif
syn keyword postscrBinaryOperator xor bitshift
syn keyword postscrBoolean      true false
syn keyword postscrConstant     arraytype booleantype conditiontype dicttype filetype fonttype gstatetype
syn keyword postscrConstant     integertype locktype marktype nametype nulltype operatortype
syn keyword postscrConstant     packedarraytype realtype savetype stringtype
syn keyword postscrConditional  if ifelse
syn keyword postscrRepeat       for repeat loop
syn keyword postscrOperator     exec exit stop stopped countexecstack execstack quit
syn keyword postscrProcedure    start
syn keyword postscrOperator     type cvlit cvx xcheck executeonly noaccess readonly rcheck wcheck cvi cvn cvr
syn keyword postscrOperator     cvrs cvs
syn keyword postscrOperator     file closefile read write readhexstring writehexstring readstring writestring
syn keyword postscrOperator     bytesavailable flush flushfile resetfile status run currentfile print
syn keyword postscrOperator     stack pstack readline deletefile setfileposition fileposition renamefile
syn keyword postscrRepeat       filenameforall
syn keyword postscrProcedure    = ==
syn keyword postscrOperator     save restore
syn keyword postscrOperator     bind null usertime executive echo realtime
syn keyword postscrConstant     product revision serialnumber version
syn keyword postscrProcedure    prompt
syn keyword postscrOperator     gsave grestore grestoreall initgraphics setlinewidth setlinecap currentgray
syn keyword postscrOperator     currentlinejoin setmiterlimit currentmiterlimit setdash currentdash setgray
syn keyword postscrOperator     sethsbcolor currenthsbcolor setrgbcolor currentrgbcolor currentlinewidth
syn keyword postscrOperator     currentlinecap setlinejoin setcmykcolor currentcmykcolor
syn keyword postscrOperator     setscreen currentscreen settransfer currenttransfer setflat currentflat
syn keyword postscrOperator     currentblackgeneration setblackgeneration setundercolorremoval
syn keyword postscrOperator     setcolorscreen currentcolorscreen setcolortransfer currentcolortransfer
syn keyword postscrOperator     currentundercolorremoval
syn keyword postscrOperator     matrix initmatrix identmatrix defaultmatrix currentmatrix setmatrix translate
syn keyword postscrOperator     concat concatmatrix transform dtransform itransform idtransform invertmatrix
syn keyword postscrOperator     scale rotate
syn keyword postscrOperator     newpath currentpoint moveto rmoveto lineto rlineto arc arcn arcto curveto
syn keyword postscrOperator     closepath flattenpath reversepath strokepath charpath clippath pathbbox
syn keyword postscrOperator     initclip clip eoclip rcurveto
syn keyword postscrRepeat       pathforall
syn keyword postscrOperator     erasepage fill eofill stroke image imagemask colorimage
syn keyword postscrOperator     showpage copypage nulldevice
syn keyword postscrProcedure    findfont
syn keyword postscrConstant     FontDirectory ISOLatin1Encoding StandardEncoding
syn keyword postscrOperator     definefont scalefont makefont setfont currentfont show ashow
syn keyword postscrOperator     stringwidth kshow setcachedevice
syn keyword postscrOperator     setcharwidth widthshow awidthshow findencoding cshow rootfont setcachedevice2
syn keyword postscrOperator     vmstatus cachestatus setcachelimit
syn keyword postscrConstant     contained Gray Red Green Blue All None DeviceGray DeviceRGB
syn keyword postscrConstant     contained ASCIIHexDecode ASCIIHexEncode ASCII85Decode ASCII85Encode LZWDecode
syn keyword postscrConstant     contained RunLengthDecode RunLengthEncode SubFileDecode NullEncode
syn keyword postscrConstant     contained GIFDecode PNGDecode LZWEncode
syn keyword postscrConstant     contained DCTEncode DCTDecode Colors HSamples VSamples QuantTables QFactor
syn keyword postscrConstant     contained HuffTables ColorTransform
syn keyword postscrConstant     contained CCITTFaxEncode CCITTFaxDecode Uncompressed K EndOfLine
syn keyword postscrConstant     contained Columns Rows EndOfBlock Blacks1 DamagedRowsBeforeError
syn keyword postscrConstant     contained EncodedByteAlign
syn keyword postscrConstant     contained FormType XUID BBox Matrix PaintProc Implementation
syn keyword postscrProcedure    handleerror
syn keyword postscrConstant     contained  configurationerror dictfull dictstackunderflow dictstackoverflow
syn keyword postscrConstant     contained  execstackoverflow interrupt invalidaccess
syn keyword postscrConstant     contained  invalidcontext invalidexit invalidfileaccess invalidfont
syn keyword postscrConstant     contained  invalidid invalidrestore ioerror limitcheck nocurrentpoint
syn keyword postscrConstant     contained  rangecheck stackoverflow stackunderflow syntaxerror timeout
syn keyword postscrConstant     contained  typecheck undefined undefinedfilename undefinedresource
syn keyword postscrConstant     contained  undefinedresult unmatchedmark unregistered VMerror
if exists("postscr_fonts")
syn keyword postscrConstant   contained Symbol Times-Roman Times-Italic Times-Bold Times-BoldItalic
syn keyword postscrConstant   contained Helvetica Helvetica-Oblique Helvetica-Bold Helvetica-BoldOblique
syn keyword postscrConstant   contained Courier Courier-Oblique Courier-Bold Courier-BoldOblique
endif
if exists("postscr_display")
syn keyword postscrOperator   currentcontext fork join detach lock monitor condition wait notify yield
syn keyword postscrOperator   viewclip eoviewclip rectviewclip initviewclip viewclippath deviceinfo
syn keyword postscrOperator   sethalftonephase currenthalftonephase wtranslation defineusername
endif
if exists("postscr_encodings")
syn keyword postscrConstant   contained .notdef
syn keyword postscrConstant   contained space exclam quotedbl numbersign dollar percent ampersand quoteright
syn keyword postscrConstant   contained parenleft parenright asterisk plus comma hyphen period slash zero
syn keyword postscrConstant   contained one two three four five six seven eight nine colon semicolon less
syn keyword postscrConstant   contained equal greater question at
syn keyword postscrConstant   contained bracketleft backslash bracketright asciicircum underscore quoteleft
syn keyword postscrConstant   contained braceleft bar braceright asciitilde
syn keyword postscrConstant   contained exclamdown cent sterling fraction yen florin section currency
syn keyword postscrConstant   contained quotesingle quotedblleft guillemotleft guilsinglleft guilsinglright
syn keyword postscrConstant   contained fi fl endash dagger daggerdbl periodcentered paragraph bullet
syn keyword postscrConstant   contained quotesinglbase quotedblbase quotedblright guillemotright ellipsis
syn keyword postscrConstant   contained perthousand questiondown grave acute circumflex tilde macron breve
syn keyword postscrConstant   contained dotaccent dieresis ring cedilla hungarumlaut ogonek caron emdash
syn keyword postscrConstant   contained AE ordfeminine Lslash Oslash OE ordmasculine ae dotlessi lslash
syn keyword postscrConstant   contained oslash oe germandbls
syn keyword postscrConstant   contained universal existential suchthat asteriskmath minus
syn keyword postscrConstant   contained congruent Alpha Beta Chi Delta Epsilon Phi Gamma Eta Iota theta1
syn keyword postscrConstant   contained Kappa Lambda Mu Nu Omicron Pi Theta Rho Sigma Tau Upsilon sigma1
syn keyword postscrConstant   contained Omega Xi Psi Zeta therefore perpendicular
syn keyword postscrConstant   contained radicalex alpha beta chi delta epsilon phi gamma eta iota phi1
syn keyword postscrConstant   contained kappa lambda mu nu omicron pi theta rho sigma tau upsilon omega1
syn keyword postscrConstant   contained Upsilon1 minute lessequal infinity club diamond heart spade
syn keyword postscrConstant   contained arrowboth arrowleft arrowup arrowright arrowdown degree plusminus
syn keyword postscrConstant   contained second greaterequal multiply proportional partialdiff divide
syn keyword postscrConstant   contained notequal equivalence approxequal arrowvertex arrowhorizex
syn keyword postscrConstant   contained aleph Ifraktur Rfraktur weierstrass circlemultiply circleplus
syn keyword postscrConstant   contained emptyset intersection union propersuperset reflexsuperset notsubset
syn keyword postscrConstant   contained propersubset reflexsubset element notelement angle gradient
syn keyword postscrConstant   contained registerserif copyrightserif trademarkserif radical dotmath
syn keyword postscrConstant   contained logicalnot logicaland logicalor arrowdblboth arrowdblleft arrowdblup
syn keyword postscrConstant   contained arrowdblright arrowdbldown omega xi psi zeta similar carriagereturn
syn keyword postscrConstant   contained lozenge angleleft registersans copyrightsans trademarksans summation
syn keyword postscrConstant   contained parenlefttp parenleftex parenleftbt bracketlefttp bracketleftex
syn keyword postscrConstant   contained bracketleftbt bracelefttp braceleftmid braceleftbt braceex euro
syn keyword postscrConstant   contained angleright integral integraltp integralex integralbt parenrighttp
syn keyword postscrConstant   contained parenrightex parenrightbt bracketrighttp bracketrightex
syn keyword postscrConstant   contained bracketrightbt bracerighttp bracerightmid bracerightbt
syn keyword postscrConstant   contained brokenbar copyright registered twosuperior threesuperior
syn keyword postscrConstant   contained onesuperior onequarter onehalf threequarters
syn keyword postscrConstant   contained Agrave Aacute Acircumflex Atilde Adieresis Aring Ccedilla Egrave
syn keyword postscrConstant   contained Eacute Ecircumflex Edieresis Igrave Iacute Icircumflex Idieresis
syn keyword postscrConstant   contained Eth Ntilde Ograve Oacute Ocircumflex Otilde Odieresis Ugrave Uacute
syn keyword postscrConstant   contained Ucircumflex Udieresis Yacute Thorn
syn keyword postscrConstant   contained agrave aacute acircumflex atilde adieresis aring ccedilla egrave
syn keyword postscrConstant   contained eacute ecircumflex edieresis igrave iacute icircumflex idieresis
syn keyword postscrConstant   contained eth ntilde ograve oacute ocircumflex otilde odieresis ugrave uacute
syn keyword postscrConstant   contained ucircumflex udieresis yacute thorn ydieresis
syn keyword postscrConstant   contained zcaron exclamsmall Hungarumlautsmall dollaroldstyle dollarsuperior
syn keyword postscrConstant   contained ampersandsmall Acutesmall parenleftsuperior parenrightsuperior
syn keyword postscrConstant   contained twodotenleader onedotenleader zerooldstyle oneoldstyle twooldstyle
syn keyword postscrConstant   contained threeoldstyle fouroldstyle fiveoldstyle sixoldstyle sevenoldstyle
syn keyword postscrConstant   contained eightoldstyle nineoldstyle commasuperior
syn keyword postscrConstant   contained threequartersemdash periodsuperior questionsmall asuperior bsuperior
syn keyword postscrConstant   contained centsuperior dsuperior esuperior isuperior lsuperior msuperior
syn keyword postscrConstant   contained nsuperior osuperior rsuperior ssuperior tsuperior ff ffi ffl
syn keyword postscrConstant   contained parenleftinferior parenrightinferior Circumflexsmall hyphensuperior
syn keyword postscrConstant   contained Gravesmall Asmall Bsmall Csmall Dsmall Esmall Fsmall Gsmall Hsmall
syn keyword postscrConstant   contained Ismall Jsmall Ksmall Lsmall Msmall Nsmall Osmall Psmall Qsmall
syn keyword postscrConstant   contained Rsmall Ssmall Tsmall Usmall Vsmall Wsmall Xsmall Ysmall Zsmall
syn keyword postscrConstant   contained colonmonetary onefitted rupiah Tildesmall exclamdownsmall
syn keyword postscrConstant   contained centoldstyle Lslashsmall Scaronsmall Zcaronsmall Dieresissmall
syn keyword postscrConstant   contained Brevesmall Caronsmall Dotaccentsmall Macronsmall figuredash
syn keyword postscrConstant   contained hypheninferior Ogoneksmall Ringsmall Cedillasmall questiondownsmall
syn keyword postscrConstant   contained oneeighth threeeighths fiveeighths seveneighths onethird twothirds
syn keyword postscrConstant   contained zerosuperior foursuperior fivesuperior sixsuperior sevensuperior
syn keyword postscrConstant   contained eightsuperior ninesuperior zeroinferior oneinferior twoinferior
syn keyword postscrConstant   contained threeinferior fourinferior fiveinferior sixinferior seveninferior
syn keyword postscrConstant   contained eightinferior nineinferior centinferior dollarinferior periodinferior
syn keyword postscrConstant   contained commainferior Agravesmall Aacutesmall Acircumflexsmall
syn keyword postscrConstant   contained Atildesmall Adieresissmall Aringsmall AEsmall Ccedillasmall
syn keyword postscrConstant   contained Egravesmall Eacutesmall Ecircumflexsmall Edieresissmall Igravesmall
syn keyword postscrConstant   contained Iacutesmall Icircumflexsmall Idieresissmall Ethsmall Ntildesmall
syn keyword postscrConstant   contained Ogravesmall Oacutesmall Ocircumflexsmall Otildesmall Odieresissmall
syn keyword postscrConstant   contained OEsmall Oslashsmall Ugravesmall Uacutesmall Ucircumflexsmall
syn keyword postscrConstant   contained Udieresissmall Yacutesmall Thornsmall Ydieresissmall Black Bold Book
syn keyword postscrConstant   contained Light Medium Regular Roman Semibold
syn keyword postscrConstant   contained trademark Scaron Ydieresis Zcaron scaron softhyphen overscore
syn keyword postscrConstant   contained graybox Sacute Tcaron Zacute sacute tcaron zacute Aogonek Scedilla
syn keyword postscrConstant   contained Zdotaccent aogonek scedilla Lcaron lcaron zdotaccent Racute Abreve
syn keyword postscrConstant   contained Lacute Cacute Ccaron Eogonek Ecaron Dcaron Dcroat Nacute Ncaron
syn keyword postscrConstant   contained Ohungarumlaut Rcaron Uring Uhungarumlaut Tcommaaccent racute abreve
syn keyword postscrConstant   contained lacute cacute ccaron eogonek ecaron dcaron dcroat nacute ncaron
syn keyword postscrConstant   contained ohungarumlaut rcaron uring uhungarumlaut tcommaaccent Gbreve
syn keyword postscrConstant   contained Idotaccent gbreve blank apple
endif
if postscr_level == 2 || postscr_level == 3
syn match postscrL2Operator     "\(<<\|>>\)"
syn keyword postscrL2Operator   undef
syn keyword postscrConstant   globaldict shareddict
syn keyword postscrL2Operator   setpagedevice currentpagedevice
syn keyword postscrL2Operator   rectclip setbbox uappend ucache upath ustrokepath arct
syn keyword postscrL2Operator   rectfill rectstroke ufill ueofill ustroke
syn keyword postscrL2Operator   currentpacking setpacking packedarray
syn keyword postscrL2Operator   languagelevel
syn keyword postscrL2Operator   infill ineofill instroke inufill inueofill inustroke
syn keyword postscrL2Operator   gstate setgstate currentgstate setcolor
syn keyword postscrL2Operator   setcolorspace currentcolorspace setstrokeadjust currentstrokeadjust
syn keyword postscrL2Operator   currentcolor
syn keyword postscrL2Operator   sethalftone currenthalftone setoverprint currentoverprint
syn keyword postscrL2Operator   setcolorrendering currentcolorrendering
syn keyword postscrL2Constant   GlobalFontDirectory SharedFontDirectory
syn keyword postscrL2Operator   glyphshow selectfont
syn keyword postscrL2Operator   addglyph undefinefont xshow xyshow yshow
syn keyword postscrL2Operator   makepattern setpattern execform
syn keyword postscrL2Operator   defineresource undefineresource findresource resourcestatus
syn keyword postscrL2Repeat     resourceforall
syn keyword postscrL2Operator   filter printobject writeobject setobjectformat currentobjectformat
syn keyword postscrL2Operator   currentshared setshared defineuserobject execuserobject undefineuserobject
syn keyword postscrL2Operator   gcheck scheck startjob currentglobal setglobal
syn keyword postscrConstant   UserObjects
syn keyword postscrL2Operator   setucacheparams setvmthreshold ucachestatus setsystemparams
syn keyword postscrL2Operator   setuserparams currentuserparams setcacheparams currentcacheparams
syn keyword postscrL2Operator   currentdevparams setdevparams vmreclaim currentsystemparams
syn keyword postscrConstant   contained DeviceCMYK Pattern Indexed Separation Cyan Magenta Yellow Black
syn keyword postscrConstant   contained CIEBasedA CIEBasedABC CIEBasedDEF CIEBasedDEFG
syn keyword postscrConstant   contained newerror errorname command errorinfo ostack estack dstack
syn keyword postscrConstant   contained recordstacks binary
syn keyword postscrConstant   contained DefineResource UndefineResource FindResource ResourceStatus
syn keyword postscrConstant   contained ResourceForAll Category InstanceType ResourceFileName
syn keyword postscrConstant   contained Font Encoding Form Pattern ProcSet ColorSpace Halftone
syn keyword postscrConstant   contained ColorRendering Filter ColorSpaceFamily Emulator IODevice
syn keyword postscrConstant   contained ColorRenderingType FMapType FontType FormType HalftoneType
syn keyword postscrConstant   contained ImageType PatternType Category Generic
syn keyword postscrConstant   contained PageSize MediaColor MediaWeight MediaType InputAttributes ManualFeed
syn keyword postscrConstant   contained OutputType OutputAttributes NumCopies Collate Duplex Tumble
syn keyword postscrConstant   contained Separations HWResolution Margins NegativePrint MirrorPrint
syn keyword postscrConstant   contained CutMedia AdvanceMedia AdvanceDistance ImagingBBox
syn keyword postscrConstant   contained Policies Install BeginPage EndPage PolicyNotFound PolicyReport
syn keyword postscrConstant   contained ManualSize OutputFaceUp Jog
syn keyword postscrConstant   contained Bind BindDetails Booklet BookletDetails CollateDetails
syn keyword postscrConstant   contained DeviceRenderingInfo ExitJamRecovery Fold FoldDetails Laminate
syn keyword postscrConstant   contained ManualFeedTimeout Orientation OutputPage
syn keyword postscrConstant   contained PostRenderingEnhance PostRenderingEnhanceDetails
syn keyword postscrConstant   contained PreRenderingEnhance PreRenderingEnhanceDetails
syn keyword postscrConstant   contained Signature SlipSheet Staple StapleDetails Trim
syn keyword postscrConstant   contained ProofSet REValue PrintQuality ValuesPerColorComponent AntiAlias
syn keyword postscrConstant   contained Selector LanguageFamily LanguageVersion
syn keyword postscrConstant   contained HalftoneType HalftoneName
syn keyword postscrConstant   contained AccurateScreens ActualAngle Xsquare Ysquare AccurateFrequency
syn keyword postscrConstant   contained Frequency SpotFunction Angle Width Height Thresholds
syn keyword postscrConstant   contained RedFrequency RedSpotFunction RedAngle RedWidth RedHeight
syn keyword postscrConstant   contained GreenFrequency GreenSpotFunction GreenAngle GreenWidth GreenHeight
syn keyword postscrConstant   contained BlueFrequency BlueSpotFunction BlueAngle BlueWidth BlueHeight
syn keyword postscrConstant   contained GrayFrequency GrayAngle GraySpotFunction GrayWidth GrayHeight
syn keyword postscrConstant   contained GrayThresholds BlueThresholds GreenThresholds RedThresholds
syn keyword postscrConstant   contained TransferFunction
syn keyword postscrConstant   contained RangeA DecodeA MatrixA RangeABC DecodeABC MatrixABC BlackPoint
syn keyword postscrConstant   contained RangeLMN DecodeLMN MatrixLMN WhitePoint RangeDEF DecodeDEF RangeHIJ
syn keyword postscrConstant   contained RangeDEFG DecodeDEFG RangeHIJK Table
syn keyword postscrConstant   contained ColorRenderingType EncodeLMB EncodeABC RangePQR MatrixPQR
syn keyword postscrConstant   contained AbsoluteColorimetric RelativeColorimetric Saturation Perceptual
syn keyword postscrConstant   contained TransformPQR RenderTable
syn keyword postscrConstant   contained PatternType PaintType TilingType XStep YStep
syn keyword postscrConstant   contained ImageType ImageMatrix MultipleDataSources DataSource
syn keyword postscrConstant   contained BitsPerComponent Decode Interpolate
syn keyword postscrConstant   contained FontType FontMatrix FontName FontInfo LanguageLevel WMode Encoding
syn keyword postscrConstant   contained UniqueID StrokeWidth Metrics Metrics2 CDevProc CharStrings Private
syn keyword postscrConstant   contained FullName Notice version ItalicAngle isFixedPitch UnderlinePosition
syn keyword postscrConstant   contained FMapType Encoding FDepVector PrefEnc EscChar ShiftOut ShiftIn
syn keyword postscrConstant   contained WeightVector Blend $Blend CIDFontType sfnts CIDSystemInfo CodeMap
syn keyword postscrConstant   contained CMap CIDFontName CIDSystemInfo UIDBase CIDDevProc CIDCount
syn keyword postscrConstant   contained CIDMapOffset FDArray FDBytes GDBytes GlyphData GlyphDictionary
syn keyword postscrConstant   contained SDBytes SubrMapOffset SubrCount BuildGlyph CIDMap FID MIDVector
syn keyword postscrConstant   contained Ordering Registry Supplement CMapName CMapVersion UIDOffset
syn keyword postscrConstant   contained SubsVector UnderlineThickness FamilyName FontBBox CurMID
syn keyword postscrConstant   contained Weight
syn keyword postscrConstant   contained MaxFontItem MinFontCompress MaxUPathItem MaxFormItem MaxPatternItem
syn keyword postscrConstant   contained MaxScreenItem MaxOpStack MaxDictStack MaxExecStack MaxLocalVM
syn keyword postscrConstant   contained VMReclaim VMThreshold
syn keyword postscrConstant   contained SystemParamsPassword StartJobPassword BuildTime ByteOrder RealFormat
syn keyword postscrConstant   contained MaxFontCache CurFontCache MaxOutlineCache CurOutlineCache
syn keyword postscrConstant   contained MaxUPathCache CurUPathCache MaxFormCache CurFormCache
syn keyword postscrConstant   contained MaxPatternCache CurPatternCache MaxScreenStorage CurScreenStorage
syn keyword postscrConstant   contained MaxDisplayList CurDisplayList
syn keyword postscrConstant   contained Predictor
syn keyword postscrL2Operator   letter lettersmall legal ledger 11x17 a4 a3 a4small b5 note
syn keyword postscrL2Operator   lettertray legaltray ledgertray a3tray a4tray b5tray 11x17tray
syn keyword postscrL2Operator   sccbatch sccinteractive setsccbatch setsccinteractive
syn keyword postscrL2Operator   duplexmode firstside newsheet setduplexmode settumble tumble
syn keyword postscrL2Operator   devdismount devformat devmount devstatus
syn keyword postscrL2Repeat     devforall
syn keyword postscrL2Operator   accuratescreens checkscreen pagemargin pageparams setaccuratescreens setpage
syn keyword postscrL2Operator   setpagemargin setpageparams
syn keyword postscrL2Operator   appletalktype buildtime byteorder checkpassword defaulttimeouts diskonline
syn keyword postscrL2Operator   diskstatus manualfeed manualfeedtimeout margins mirrorprint pagecount
syn keyword postscrL2Operator   pagestackorder printername processcolors sethardwareiomode setjobtimeout
syn keyword postscrL2Operator   setpagestockorder setprintername setresolution doprinterrors dostartpage
syn keyword postscrL2Operator   hardwareiomode initializedisk jobname jobtimeout ramsize realformat resolution
syn keyword postscrL2Operator   setdefaulttimeouts setdoprinterrors setdostartpage setdosysstart
syn keyword postscrL2Operator   setuserdiskpercent softwareiomode userdiskpercent waittimeout
syn keyword postscrL2Operator   setsoftwareiomode dosysstart emulate setmargins setmirrorprint
endif " PS2 highlighting
if postscr_level == 3
syn keyword postscrL3Operator setsmoothness currentsmoothness shfill
syn keyword postscrL3Operator clipsave cliprestore
syn keyword postscrL3Operator setpage setpageparams
syn keyword postscrL3Operator findcolorrendering
syn keyword postscrL3Operator composefont
syn keyword postscrConstant   contained DeviceN TrappingDetailsType
syn keyword postscrConstant   contained DeferredMediaSelection ImageShift InsertSheet LeadingEdge MaxSeparations
syn keyword postscrConstant   contained MediaClass MediaPosition OutputDevice PageDeviceName PageOffset ProcessColorModel
syn keyword postscrConstant   contained RollFedMedia SeparationColorNames SeparationOrder Trapping TrappingDetails
syn keyword postscrConstant   contained TraySwitch UseCIEColor
syn keyword postscrConstant   contained ColorantDetails ColorantName ColorantType NeutralDensity TrappingOrder
syn keyword postscrConstant   contained ColorantSetName
syn keyword postscrConstant   contained BlackColorLimit BlackDensityLimit BlackWidth ColorantZoneDetails
syn keyword postscrConstant   contained SlidingTrapLimit StepLimit TrapColorScaling TrapSetName TrapWidth
syn keyword postscrConstant   contained ImageResolution ImageToObjectTrapping ImageTrapPlacement
syn keyword postscrConstant   contained StepLimit TrapColorScaling Enabled ImageInternalTrapping
syn keyword postscrConstant   contained ReusableStreamDecode CloseSource CloseTarget UnitSize LowBitFirst
syn keyword postscrConstant   contained FlateEncode FlateDecode DecodeParams Intent AsyncRead
syn keyword postscrConstant   contained Height2 Width2
syn keyword postscrConstant   contained FunctionType Domain Range Order BitsPerSample Encode Size C0 C1 N
syn keyword postscrConstant   contained Functions Bounds
syn keyword postscrConstant   contained InterleaveType MaskDict DataDict MaskColor
syn keyword postscrConstant   contained Shading ShadingType Background ColorSpace Coords Extend Function
syn keyword postscrConstant   contained VerticesPerRow BitsPerCoordinate BitsPerFlag
syn keyword postscrConstant   contained XOrigin YOrigin UnpaintedPath PixelCopy
syn keyword postscrProcedure  GetHalftoneName GetPageDeviceName GetSubstituteCRD
syn keyword postscrProcedure  beginbfchar beginbfrange begincidchar begincidrange begincmap begincodespacerange
syn keyword postscrProcedure  beginnotdefchar beginnotdefrange beginrearrangedfont beginusematrix
syn keyword postscrProcedure  endbfchar endbfrange endcidchar endcidrange endcmap endcodespacerange
syn keyword postscrProcedure  endnotdefchar endnotdefrange endrearrangedfont endusematrix
syn keyword postscrProcedure  StartData usefont usecmp
syn keyword postscrProcedure  settrapparams currenttrapparams settrapzone
syn keyword postscrProcedure  removeall removeglyphs
if exists("postscr_fonts")
syn keyword postscrConstant contained AlbertusMT AlbertusMT-Italic AlbertusMT-Light Apple-Chancery Apple-ChanceryCE
syn keyword postscrConstant contained AntiqueOlive-Roman AntiqueOlive-Italic AntiqueOlive-Bold AntiqueOlive-Compact
syn keyword postscrConstant contained AntiqueOliveCE-Roman AntiqueOliveCE-Italic AntiqueOliveCE-Bold AntiqueOliveCE-Compact
syn keyword postscrConstant contained ArialMT Arial-ItalicMT Arial-LightMT Arial-BoldMT Arial-BoldItalicMT
syn keyword postscrConstant contained ArialCE ArialCE-Italic ArialCE-Light ArialCE-Bold ArialCE-BoldItalic
syn keyword postscrConstant contained AvantGarde-Book AvantGarde-BookOblique AvantGarde-Demi AvantGarde-DemiOblique
syn keyword postscrConstant contained AvantGardeCE-Book AvantGardeCE-BookOblique AvantGardeCE-Demi AvantGardeCE-DemiOblique
syn keyword postscrConstant contained Bodoni Bodoni-Italic Bodoni-Bold Bodoni-BoldItalic Bodoni-Poster Bodoni-PosterCompressed
syn keyword postscrConstant contained BodoniCE BodoniCE-Italic BodoniCE-Bold BodoniCE-BoldItalic BodoniCE-Poster BodoniCE-PosterCompressed
syn keyword postscrConstant contained Bookman-Light Bookman-LightItalic Bookman-Demi Bookman-DemiItalic
syn keyword postscrConstant contained BookmanCE-Light BookmanCE-LightItalic BookmanCE-Demi BookmanCE-DemiItalic
syn keyword postscrConstant contained Carta Chicago ChicagoCE Clarendon Clarendon-Light Clarendon-Bold
syn keyword postscrConstant contained ClarendonCE ClarendonCE-Light ClarendonCE-Bold CooperBlack CooperBlack-Italic
syn keyword postscrConstant contained Copperplate-ThirtyTwoBC CopperPlate-ThirtyThreeBC Coronet-Regular CoronetCE-Regular
syn keyword postscrConstant contained CourierCE CourierCE-Oblique CourierCE-Bold CourierCE-BoldOblique
syn keyword postscrConstant contained Eurostile Eurostile-Bold Eurostile-ExtendedTwo Eurostile-BoldExtendedTwo
syn keyword postscrConstant contained Eurostile EurostileCE-Bold EurostileCE-ExtendedTwo EurostileCE-BoldExtendedTwo
syn keyword postscrConstant contained Geneva GenevaCE GillSans GillSans-Italic GillSans-Bold GillSans-BoldItalic GillSans-BoldCondensed
syn keyword postscrConstant contained GillSans-Light GillSans-LightItalic GillSans-ExtraBold
syn keyword postscrConstant contained GillSansCE-Roman GillSansCE-Italic GillSansCE-Bold GillSansCE-BoldItalic GillSansCE-BoldCondensed
syn keyword postscrConstant contained GillSansCE-Light GillSansCE-LightItalic GillSansCE-ExtraBold
syn keyword postscrConstant contained Goudy Goudy-Italic Goudy-Bold Goudy-BoldItalic Goudy-ExtraBould
syn keyword postscrConstant contained HelveticaCE HelveticaCE-Oblique HelveticaCE-Bold HelveticaCE-BoldOblique
syn keyword postscrConstant contained Helvetica-Condensed Helvetica-Condensed-Oblique Helvetica-Condensed-Bold Helvetica-Condensed-BoldObl
syn keyword postscrConstant contained HelveticaCE-Condensed HelveticaCE-Condensed-Oblique HelveticaCE-Condensed-Bold
syn keyword postscrConstant contained HelveticaCE-Condensed-BoldObl Helvetica-Narrow Helvetica-Narrow-Oblique Helvetica-Narrow-Bold
syn keyword postscrConstant contained Helvetica-Narrow-BoldOblique HelveticaCE-Narrow HelveticaCE-Narrow-Oblique HelveticaCE-Narrow-Bold
syn keyword postscrConstant contained HelveticaCE-Narrow-BoldOblique HoeflerText-Regular HoeflerText-Italic HoeflerText-Black
syn keyword postscrConstant contained HoeflerText-BlackItalic HoeflerText-Ornaments HoeflerTextCE-Regular HoeflerTextCE-Italic
syn keyword postscrConstant contained HoeflerTextCE-Black HoeflerTextCE-BlackItalic
syn keyword postscrConstant contained JoannaMT JoannaMT-Italic JoannaMT-Bold JoannaMT-BoldItalic
syn keyword postscrConstant contained JoannaMTCE JoannaMTCE-Italic JoannaMTCE-Bold JoannaMTCE-BoldItalic
syn keyword postscrConstant contained LetterGothic LetterGothic-Slanted LetterGothic-Bold LetterGothic-BoldSlanted
syn keyword postscrConstant contained LetterGothicCE LetterGothicCE-Slanted LetterGothicCE-Bold LetterGothicCE-BoldSlanted
syn keyword postscrConstant contained LubalinGraph-Book LubalinGraph-BookOblique LubalinGraph-Demi LubalinGraph-DemiOblique
syn keyword postscrConstant contained LubalinGraphCE-Book LubalinGraphCE-BookOblique LubalinGraphCE-Demi LubalinGraphCE-DemiOblique
syn keyword postscrConstant contained Marigold Monaco MonacoCE MonaLisa-Recut Oxford Symbol Tekton
syn keyword postscrConstant contained NewCennturySchlbk-Roman NewCenturySchlbk-Italic NewCenturySchlbk-Bold NewCenturySchlbk-BoldItalic
syn keyword postscrConstant contained NewCenturySchlbkCE-Roman NewCenturySchlbkCE-Italic NewCenturySchlbkCE-Bold
syn keyword postscrConstant contained NewCenturySchlbkCE-BoldItalic NewYork NewYorkCE
syn keyword postscrConstant contained Optima Optima-Italic Optima-Bold Optima-BoldItalic
syn keyword postscrConstant contained OptimaCE OptimaCE-Italic OptimaCE-Bold OptimaCE-BoldItalic
syn keyword postscrConstant contained Palatino-Roman Palatino-Italic Palatino-Bold Palatino-BoldItalic
syn keyword postscrConstant contained PalatinoCE-Roman PalatinoCE-Italic PalatinoCE-Bold PalatinoCE-BoldItalic
syn keyword postscrConstant contained StempelGaramond-Roman StempelGaramond-Italic StempelGaramond-Bold StempelGaramond-BoldItalic
syn keyword postscrConstant contained StempelGaramondCE-Roman StempelGaramondCE-Italic StempelGaramondCE-Bold StempelGaramondCE-BoldItalic
syn keyword postscrConstant contained TimesCE-Roman TimesCE-Italic TimesCE-Bold TimesCE-BoldItalic
syn keyword postscrConstant contained TimesNewRomanPSMT TimesNewRomanPS-ItalicMT TimesNewRomanPS-BoldMT TimesNewRomanPS-BoldItalicMT
syn keyword postscrConstant contained TimesNewRomanCE TimesNewRomanCE-Italic TimesNewRomanCE-Bold TimesNewRomanCE-BoldItalic
syn keyword postscrConstant contained Univers Univers-Oblique Univers-Bold Univers-BoldOblique
syn keyword postscrConstant contained UniversCE-Medium UniversCE-Oblique UniversCE-Bold UniversCE-BoldOblique
syn keyword postscrConstant contained Univers-Light Univers-LightOblique UniversCE-Light UniversCE-LightOblique
syn keyword postscrConstant contained Univers-Condensed Univers-CondensedOblique Univers-CondensedBold Univers-CondensedBoldOblique
syn keyword postscrConstant contained UniversCE-Condensed UniversCE-CondensedOblique UniversCE-CondensedBold UniversCE-CondensedBoldOblique
syn keyword postscrConstant contained Univers-Extended Univers-ExtendedObl Univers-BoldExt Univers-BoldExtObl
syn keyword postscrConstant contained UniversCE-Extended UniversCE-ExtendedObl UniversCE-BoldExt UniversCE-BoldExtObl
syn keyword postscrConstant contained Wingdings-Regular ZapfChancery-MediumItalic ZapfChanceryCE-MediumItalic ZapfDingBats
endif " Font names
endif " PS LL3 highlighting
if exists("postscr_ghostscript")
syn keyword postscrGSOperator   .setaccuratecurves .currentaccuratecurves .setclipoutside
syn keyword postscrGSOperator   .setdashadapt .currentdashadapt .setdefaultmatrix .setdotlength
syn keyword postscrGSOperator   .currentdotlength .setfilladjust2 .currentfilladjust2
syn keyword postscrGSOperator   .currentclipoutside .setcurvejoin .currentcurvejoin
syn keyword postscrGSOperator   .setblendmode .currentblendmode .setopacityalpha .currentopacityalpha .setshapealpha .currentshapealpha
syn keyword postscrGSOperator   .setlimitclamp .currentlimitclamp .setoverprintmode .currentoverprintmode
syn keyword postscrGSOperator   .dashpath .rectappend
syn keyword postscrGSOperator   .setrasterop .currentrasterop .setsourcetransparent
syn keyword postscrGSOperator   .settexturetransparent .currenttexturetransparent
syn keyword postscrGSOperator   .currentsourcetransparent
syn keyword postscrGSOperator   .charboxpath .type1execchar %Type1BuildChar %Type1BuildGlyph
syn keyword postscrGSMathOperator arccos arcsin
syn keyword postscrGSOperator   .dicttomark .forceput .forceundef .knownget .setmaxlength
syn keyword postscrGSOperator   .type1encrypt .type1decrypt
syn keyword postscrGSOperator   .bytestring .namestring .stringmatch
syn keyword postscrGSMathOperator max min
syn keyword postscrGSOperator   findlibfile unread writeppmfile
syn keyword postscrGSOperator   .filename .fileposition .peekstring .unread
syn keyword postscrGSOperator   .forgetsave
syn keyword postscrGSOperator   copydevice .getdevice makeimagedevice makewordimagedevice copyscanlines
syn keyword postscrGSOperator   setdevice currentdevice getdeviceprops putdeviceprops flushpage
syn keyword postscrGSOperator   finddevice findprotodevice .getbitsrect
syn keyword postscrGSOperator   getenv .makeoperator .setdebug .oserrno .oserror .execn
syn keyword postscrGSOperator   .begintransparencygroup .discardtransparencygroup .endtransparencygroup
syn keyword postscrGSOperator   .begintransparencymask .discardtransparencymask .endtransparencymask .inittransparencymask
syn keyword postscrGSOperator   .settextknockout .currenttextknockout
syn keyword postscrConstant   contained BCPEncode BCPDecode eexecEncode eexecDecode PCXDecode
syn keyword postscrConstant   contained PixelDifferenceEncode PixelDifferenceDecode
syn keyword postscrConstant   contained PNGPredictorDecode TBCPEncode TBCPDecode zlibEncode
syn keyword postscrConstant   contained zlibDecode PNGPredictorEncode PFBDecode
syn keyword postscrConstant   contained MD5Encode
syn keyword postscrConstant   contained InitialCodeLength FirstBitLowOrder BlockData DecodedByteAlign
syn keyword postscrConstant   contained BitsPerPixel .HWMargins HWSize Name GrayValues
syn keyword postscrConstant   contained ColorValues TextAlphaBits GraphicsAlphaBits BufferSpace
syn keyword postscrConstant   contained OpenOutputFile PageCount BandHeight BandWidth BandBufferSpace
syn keyword postscrConstant   contained ViewerPreProcess GreenValues BlueValues OutputFile
syn keyword postscrConstant   contained MaxBitmap RedValues
endif " GhostScript highlighting
hi def link postscrComment         Comment
hi def link postscrConstant        Constant
hi def link postscrString          String
hi def link postscrASCIIString     postscrString
hi def link postscrHexString       postscrString
hi def link postscrASCII85String   postscrString
hi def link postscrNumber          Number
hi def link postscrInteger         postscrNumber
hi def link postscrHex             postscrNumber
hi def link postscrRadix           postscrNumber
hi def link postscrFloat           Float
hi def link postscrBoolean         Boolean
hi def link postscrIdentifier      Identifier
hi def link postscrProcedure       Function
hi def link postscrName            Statement
hi def link postscrConditional     Conditional
hi def link postscrRepeat          Repeat
hi def link postscrL2Repeat        postscrRepeat
hi def link postscrOperator        Operator
hi def link postscrL1Operator      postscrOperator
hi def link postscrL2Operator      postscrOperator
hi def link postscrL3Operator      postscrOperator
hi def link postscrMathOperator    postscrOperator
hi def link postscrLogicalOperator postscrOperator
hi def link postscrBinaryOperator  postscrOperator
hi def link postscrDSCComment      SpecialComment
hi def link postscrSpecialChar     SpecialChar
hi def link postscrTodo            Todo
hi def link postscrError           Error
hi def link postscrSpecialCharError postscrError
hi def link postscrASCII85CharError postscrError
hi def link postscrHexCharError    postscrError
hi def link postscrASCIIStringError postscrError
hi def link postscrIdentifierError postscrError
if exists("postscr_ghostscript")
hi def link postscrGSOperator      postscrOperator
hi def link postscrGSMathOperator  postscrMathOperator
else
hi def link postscrGSOperator      postscrError
hi def link postscrGSMathOperator  postscrError
endif
let b:current_syntax = "postscr"
