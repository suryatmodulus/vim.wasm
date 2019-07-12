if exists("b:current_syntax")
finish
endif
syn case ignore
syn keyword formType		global local
syn keyword formHeaderStatement	symbol symbols cfunction cfunctions
syn keyword formHeaderStatement	function functions vector vectors
syn keyword formHeaderStatement tensor tensors ctensor ctensors
syn keyword formHeaderStatement	set sets index indices table ctable
syn keyword formHeaderStatement	dimension dimensions unittrace
syn keyword formConditional	if else elseif endif while
syn keyword formConditional	repeat endrepeat label goto
syn keyword formConditional     argument endargument exit
syn keyword formConditional     inexpression inside term
syn keyword formConditional     endinexpression endinside endterm
syn keyword formStatement       abrackets also antibrackets antisymmetrize
syn keyword formStatement       argexplode argimplode apply auto autodeclare
syn keyword formStatement       brackets chainin chainout chisholm cleartable
syn keyword formStatement       collect commuting compress contract
syn keyword formStatement       cyclesymmetrize deallocatetable delete
syn keyword formStatement       dimension discard disorder drop factarg fill
syn keyword formStatement       fillexpression fixindex format funpowers hide
syn keyword formStatement       identify idnew idold ifmatch inparallel
syn keyword formStatement       insidefirst keep load makeinteger many metric
syn keyword formStatement       moduleoption modulus multi multiply ndrop
syn keyword formStatement       nfunctions nhide normalize notinparallel
syn keyword formStatement       nprint nskip ntable ntensors nunhide nwrite
syn keyword formStatement       off on once only polyfun pophide print
syn keyword formStatement       printtable propercount pushhide ratio
syn keyword formStatement       rcyclesymmetrize redefine renumber
syn keyword formStatement       replaceinarg replaceloop save select
syn keyword formStatement       setexitflag skip slavepatchsize sort splitarg
syn keyword formStatement       splitfirstarg splitlastarg sum symmetrize
syn keyword formStatement       tablebase testuse threadbucketsize totensor
syn keyword formStatement       tovector trace4 tracen tryreplace unhide
syn keyword formStatement       unittrace vectors write
syn keyword formStatement       id bracket count match traceN
syn keyword formStatement       abs_ bernoulli_ binom_ conjg_ count_
syn keyword formStatement       d_ dd_ delta_ deltap_ denom_ distrib_
syn keyword formStatement       dum_ dummy_ dummyten_ e_ exp_ fac_
syn keyword formStatement       factorin_ firstbracket_ g5_ g6_ g7_
syn keyword formStatement       g_ gcd_ gi_ integer_ invfac_ match_
syn keyword formStatement       max_ maxpowerof_ min_ minpowerof_
syn keyword formStatement       mod_ nargs_ nterms_ pattern_ poly_
syn keyword formStatement       polyadd_ polydiv_ polygcd_ polyintfac_
syn keyword formStatement       polymul_ polynorm_ polyrem_ polysub_
syn keyword formStatement       replace_ reverse_ root_ setfun_ sig_
syn keyword formStatement       sign_ sum_ sump_ table_ tbl_ term_
syn keyword formStatement       termsin_ termsinbracket_ theta_ thetap_ 
syn keyword formStatement	5_ 6_ 7_
syn keyword formReserved        sqrt_ ln_ sin_ cos_ tan_ asin_ acos_
syn keyword formReserved        atan_ atan2_ sinh_ cosh_ tanh_ asinh_
syn keyword formReserved        acosh_ atanh_ li2_ lin_ 
syn keyword formTodo            contained TODO FIXME XXX
syn match   formSpecial         display contained "\\\(n\|t\|b\|\\\|\"\)"
syn match   formSpecial         display contained "%\(%\|e\|E\|s\|f\|\$\)"
syn match   formSpecial         "\<N\d\+_[?]"
syn match   formComment		"^\ *\*.*$" contains=formTodo
syn match   formComment		"\;\ *\*.*$" contains=formTodo
syn region  formString		start=+"+  end=+"+ contains=formSpecial
syn region  formString		start=+'+  end=+'+
syn region  formNestedString	start=+`+  end=+'+ contains=formNestedString
syn match   formPreProc		"^\=\#[a-zA-Z][a-zA-Z0-9]*\>"
syn match   formNumber		"\<\d\+\>"
syn match   formNumber		"\<\d\+\.\d*\>"
syn match   formNumber		"\.\d\+\>"
syn match   formNumber		"-\d" contains=Number
syn match   formNumber		"-\.\d" contains=Number
syn match   formNumber		"i_\+\>"
syn match   formNumber		"fac_\+\>"
syn match   formNumber		"?[a-zA-Z0-9]*"
syn match   formNumber		"\\$[a-zA-Z0-9]*"
syn match   formNumber		"^\=[a-zA-Z][a-zA-Z0-9]*\.[a-zA-Z][a-zA-Z0-9]*\>"
syn match   formDirective	"^\=\.[a-zA-Z][a-zA-Z0-9]*\>"
syn sync ccomment formComment minlines=10
hi def link formConditional	Conditional
hi def link formNumber		Number
hi def link formStatement		Statement
hi def link formComment		Comment
hi def link formPreProc		PreProc
hi def link formDirective		PreProc
hi def link formType		Type
hi def link formString		String
hi def link formNestedString	String
hi def link formReserved           Error
hi def link formTodo               Todo
hi def link formSpecial            SpecialChar
if !exists("form_enhanced_color")
hi def link formHeaderStatement	Statement
else
hi def link formHeaderStatement	HeaderStatement
if &background == "dark"
hi HeaderStatement term=underline ctermfg=LightGreen guifg=LightGreen gui=bold
else
hi HeaderStatement term=underline ctermfg=DarkGreen guifg=SeaGreen gui=bold
endif
if has("gui_running") && &background == "dark"
hi Conditional guifg=LightBlue gui=bold
hi Statement guifg=LightYellow
endif
endif
let b:current_syntax = "form"
