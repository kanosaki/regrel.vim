" vim:set sw=2 sts=2 ts=2:


" ---------------------------------
"  Syntax Initialization
" ---------------------------------
" For version 5.x: Clear all syntax items.
" For version 6.x: Quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim


syn match   regrelComment           "//.*$" contains=regrelToDo
syn keyword regrelToDo              FIXME NOTE NOTES TODO XXX contained

syn keyword regrelKeywords          _lhs _rhs /: _ ! ? ?/ &
syn match   regrelPreprocessor      "@[a-zA-Z][_a-zA-Z0-9]*"
syn match   regrelVariables         "[A-Z][a-zA-Z]*"
syn match   regrelRefer             "#[_a-zA-Z0-9]*"
syn match   regrelRule              "->"
  " syn match   regrelRelations     "==\|~\|!~\|<=\|?/\|?\|#_\|!\|/:"


syn match   regrelGraph             "\([^()<>{}:]\+\s*\)\%((\)\@=" nextgroup=regrelGraphRegion skipwhite skipnl

syn region  regrelGraphRegion       start=/(/ end=/)/ contains=regrelArc,regrelGraph,regrelGraphRegion,regrelFn,regrelFnRegion
syn match   regrelArc               "\i\+\s*\%(:\)\@=" containedin=regrelGraphRegion,regrelFnArgRegion

syn match   regrelFn                "\([^()<>{}:]\+\s*\)\%(<\)\@=" nextgroup=regrelGraphRegion skipwhite skipnl
syn region  regrelFnArgRegion       start=/</ end=/>/ contains=regrelArc,regrelGraph,regrelGraphRegion,regrelFn,regrelFnRegion

" Define default highlighting

if version >= 508 || !exists("did_regrel_inits")
  if version < 508
    let did_regrel_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink regrelComment        Comment
  HiLink regrelToDo           Todo
  HiLink regrelRule           Operator
  HiLink regrelPreprocessor   PreProc
  HiLink regrelGraph          Identifier
  HiLink regrelFn             Function
  HiLink regrelArc            Type

  delcommand HiLink
endif


" ---------------------------------
"  Syntax Finalization
" ---------------------------------
let b:current_syntax = "regrel"

let &cpo = s:cpo_save
unlet s:cpo_save
