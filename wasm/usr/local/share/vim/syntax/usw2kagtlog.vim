if exists("b:current_syntax")
finish
endif
syn match usw2kagtlog_Date /\u\l\l \u\l\l\s\{1,2}\d\{1,2} \d\d:\d\d:\d\d \d\d\d\d/
syn match usw2kagtlog_MsgD /Msg #\(Agt\|PC\|Srv\)\d\{4,5}D/ nextgroup=usw2kagtlog_Process skipwhite
syn match usw2kagtlog_MsgE /Msg #\(Agt\|PC\|Srv\)\d\{4,5}E/ nextgroup=usw2kagtlog_Process skipwhite
syn match usw2kagtlog_MsgI /Msg #\(Agt\|PC\|Srv\)\d\{4,5}I/ nextgroup=usw2kagtlog_Process skipwhite
syn match usw2kagtlog_MsgW /Msg #\(Agt\|PC\|Srv\)\d\{4,5}W/ nextgroup=usw2kagtlog_Process skipwhite
syn region usw2kagtlog_Process start="(" end=")" contained
syn region usw2kagtlog_Process start="Starting the processing for a \zs\"" end="\ze client"
syn region usw2kagtlog_Process start="Ending the processing for a \zs\"" end="\ze client"
syn match usw2kagtlog_IPaddr / \d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}/
syn match usw2kagtlog_Profile /Profile name \zs\"\S\{1,8}\"/
syn match usw2kagtlog_Profile / Profile: \zs\S\{1,8}/
syn match usw2kagtlog_Profile /  Profile: \zs\S\{1,8}\ze, /
syn match upstreamlog_Profile /Backup Profile: \zs\S\{1,8}\ze Version date/
syn match upstreamlog_Profile /Backup profile: \zs\S\{1,8}\ze  Version date/
syn match usw2kagtlog_Profile /Full of \zs\S\{1,8}\ze$/
syn match usw2kagtlog_Profile /Incr. of \zs\S\{1,8}\ze$/
syn match usw2kagtlog_Profile /profile name "\zs\S\{1,8}\ze"/
syn region usw2kagtlog_Target start="Computer: \zs" end="\ze[\]\)]" 
syn region usw2kagtlog_Target start="Computer name \zs\"" end="\"\ze" 
syn keyword usw2kagtlog_Agentword opened closed
hi def link usw2kagtlog_Date		Underlined
hi def link usw2kagtlog_MsgD		Type
hi def link usw2kagtlog_MsgE		Error
hi def link usw2kagtlog_MsgW		Constant
hi def link usw2kagtlog_Process		Statement
hi def link usw2kagtlog_IPaddr		Identifier
hi def link usw2kagtlog_Profile		Identifier
hi def link usw2kagtlog_Target		Identifier
hi def link usw2kagtlog_Agentword	Special
let b:current_syntax = "usw2kagentlog"
