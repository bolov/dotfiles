" Maintainer:	Henrique C. Alves (hcarvalhoalves@gmail.com)
" Version:      1.0
" Last Change:	September 25 2008
" Modified: bolov: changed SpecialKey

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "mustang-bolov"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#2d2d2d ctermbg=236
  hi CursorColumn guibg=#2d2d2d ctermbg=236
  hi MatchParen guifg=#d0ffc0 guibg=#2f2f2f gui=bold ctermfg=157 ctermbg=237 cterm=bold
  hi Pmenu 		guifg=#ffffff guibg=#444444 ctermfg=255 ctermbg=238
  hi PmenuSel 	guifg=#000000 guibg=#b1d631 ctermfg=0 ctermbg=148
endif

" General colors
hi Cursor 		guifg=NONE    guibg=#626262 gui=none ctermbg=241
hi Normal 		guifg=#e2e2e5 guibg=#202020 gui=none ctermfg=253 ctermbg=234
hi NonText 		guifg=#808080 guibg=#303030 gui=none ctermfg=244 ctermbg=235
hi LineNr 		guifg=#808080 guibg=#000000 gui=none ctermfg=244 ctermbg=232
hi StatusLine 	guifg=#d3d3d5 guibg=#444444 gui=italic ctermfg=253 ctermbg=238 cterm=italic
hi StatusLineNC guifg=#939395 guibg=#444444 gui=none ctermfg=246 ctermbg=238
hi VertSplit 	guifg=#444444 guibg=#444444 gui=none ctermfg=238 ctermbg=238
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none ctermbg=4 ctermfg=248
hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold ctermfg=254 cterm=bold
hi Visual		guifg=#faf4c6 guibg=#3c414c gui=none ctermfg=254 ctermbg=4
" hi SpecialKey	guifg=#808080 guibg=#343434 gui=none ctermfg=244 ctermbg=236
hi SpecialKey	guifg=#404040 guibg=#202020 gui=none ctermfg=244 ctermbg=236

" Syntax highlighting
hi Comment 		guifg=#808080 gui=italic ctermfg=244
hi Todo 		guifg=#8f8f8f gui=italic ctermfg=245
hi Boolean      guifg=#b1d631 gui=none ctermfg=148
hi String 		guifg=#b1d631 gui=italic ctermfg=148
hi Identifier 	guifg=#b1d631 gui=none ctermfg=148
hi Function 	guifg=#ffffff gui=bold ctermfg=255
hi Type 		guifg=#7e8aa2 gui=none ctermfg=103
hi Statement 	guifg=#7e8aa2 gui=none ctermfg=103
hi Keyword		guifg=#ff9800 gui=none ctermfg=208
hi Constant 	guifg=#ff9800 gui=none  ctermfg=208
hi Number		guifg=#ff9800 gui=none ctermfg=208
hi Special		guifg=#ff9800 gui=none ctermfg=208
hi PreProc 		guifg=#faf4c6 gui=none ctermfg=230
hi Todo         guifg=#000000 guibg=#e6ea50 gui=italic

" Clighter colors

hi clighterTestRed			guifg=red
hi clighterTestGreen		guifg=green
hi clighterTestBlue			guifg=blue

hi clighterNamespaceDecl	guifg=#8CBD6C
hi clighterNamespaceRef		guifg=#8CBD6C

hi clighterStructDecl		guifg=#C9F5AB
hi clighterClassDecl		guifg=#C9F5AB
hi clighterUnionDecl		guifg=#C9F5AB
hi clighterEnumDecl			guifg=#D9B64E
hi clighterTypedefDecl		guifg=#C9F5AB

hi clighterStructRef		guifg=#C9F5AB
hi clighterClassRef			guifg=#C9F5AB
hi clighterUnionRef			guifg=#C9F5AB
hi clighterEnumRef			guifg=#D9B64E
hi clighterOtherTypeRef		guifg=#8CA6D4

hi link clighterEnumConstantDecl Constant
hi link clighterEnumConstantRef Constant

hi cligherTemplateTypeParamDecl guifg=#C9F5AB gui=bold
hi cligherTemplateTypeParamRef guifg=#C9F5AB gui=bold

hi cligherTemplateNonTypeParamDecl guifg=#ff9800
hi cligherTemplateNonTypeParamRef guifg=#ff9800

hi cligherClassTemplateDecl guifg=#C9F5AB gui=bold
hi cligherClassTemplateRef guifg=#C9F5AB gui=bold

hi cligherClassTemplatePartialSpecDecl guifg=#C9F5AB gui=bold
hi cligherClassTemplatePartialSpecRef guifg=#C9F5AB gui=bold


hi cligherFunctionTemplateDecl guifg=#50ADCC gui=bold
hi cligherFunctionTemplateRef guifg=#50ADCC gui=bold


hi clighterMethodDecl		guifg=#77BF96
hi clighterMethodRef		guifg=#77BF96

hi clighterCtorDecl 		guifg=#77BF96 gui=bold
hi clighterCtorRef  		guifg=#77BF96 gui=bold

hi clighterDtorDecl 		guifg=#77BF96 gui=bold
hi clighterDtorRef  		guifg=#77BF96 gui=bold

hi clighterDataMemberDecl	guifg=#BBD459
hi clighterDataMemberRef	guifg=#BBD459

hi clighterFunctionDecl		guifg=#50ADCC
hi clighterFunctionRef		guifg=#50ADCC

hi clighterParamDecl		guifg=#824A4A
hi clighterParamRef			guifg=#824A4A

hi clighterVarDecl			guifg=#BD4F4F
hi clighterVarRef			guifg=#BD4F4F

" Code-specific colors
hi pythonOperator guifg=#7e8aa2 gui=none ctermfg=103

