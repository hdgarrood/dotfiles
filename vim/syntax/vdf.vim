" Vim syntax file
" Language:     Visual DataFlex 
" Maintainer:   Harry Garrood   
" Last Change:  March 2012  
" Vim URL:      http://www.vim.org/lang.html


" Setup Syntax:
if version < 600
  "  Clear old syntax settings
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn region  comment         start="//" keepend end="$" 
syn region  string          start=+"+ end=+"+ oneline
syn region  string          start=+'+ end=+'+ oneline
syn match   number          "\<\d\+U\=L\=\>"
syn match   constant        "@_\w*"
syn keyword statement       Class End_Class Object End_Object Virtual_Structure End_Virtual_Structure Virtual_Field
syn keyword operator        of to is a an eq ne ge gt le lt and or not
syn match   operator        "\(=\|<\|>\|-\|+\|\.\|*\)"
syn keyword include         use use_file use_extend declare_datafile
syn keyword conditional     if ifnot else begin end while loop for repeat until case break
syn keyword type            integer string variant boolean date sysdate sysdate4 handle pointer dword float bigint decimal datetime char currency
syn keyword function        function procedure end_function end_procedure register_function register_procedure register_object
syn keyword function        function_return procedure_return property returns
syn keyword function        move get set send broadcast delegate forward
syn keyword function        abort runprogram wait import_class_protocol self find by index append extract_field_nr
syn match   preproc         "#[^\/]*"
