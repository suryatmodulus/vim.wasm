if exists("b:current_syntax")
finish
endif
syn case ignore
syn match	tildeFunction	"\~[a-z_0-9]\+"ms=s+1
syn region	tildeParen	start="(" end=")" contains=tildeString,tildeNumber,tildeVariable,tildeField,tildeSymtab,tildeFunction,tildeParen,tildeHexNumber,tildeOperator
syn region	tildeString	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ keepend
syn region	tildeString	contained start=+'+ skip=+\\\\\|\\"+ end=+'+ keepend
syn match	tildeNumber	"\d" contained
syn match	tildeOperator	"or\|and" contained
syn match	tildeHexNumber  "0x[a-z0-9]\+" contained
syn match	tildeVariable	"$[a-z_0-9]\+" contained
syn match	tildeField	"%[a-z_0-9]\+" contained
syn match	tildeSymtab	"@[a-z_0-9]\+" contained
syn match	tildeComment	"^#.*"
syn region	tildeCurly	start=+{+ end=+}+ contained contains=tildeLG,tildeString,tildeNumber,tildeVariable,tildeField,tildeFunction,tildeSymtab,tildeHexNumber
syn match	tildeLG		"=>" contained
hi def link	tildeComment	Comment
hi def link	tildeFunction	Operator
hi def link	tildeOperator	Operator
hi def link	tildeString	String
hi def link	tildeNumber	Number
hi def link	tildeHexNumber	Number
hi def link	tildeVariable	Identifier
hi def link	tildeField	Identifier
hi def link	tildeSymtab	Identifier
hi def link	tildeError	Error
let b:current_syntax = "tilde"
