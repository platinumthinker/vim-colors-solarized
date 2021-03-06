" Toggle Background
" Modified:     2011 Apr 29
" Maintainer:   Ethan Schoonover
" License:      OSI approved MIT license

if exists("g:loaded_togglebg")
    finish
endif
let g:loaded_togglebg = 1
let g:solarized_background = &background
" noremap is a bit misleading here if you are unused to vim mapping.
" in fact, there is remapping, but only of script locally defined remaps, in 
" this case <SID>TogBG. The <script> argument modifies the noremap scope in 
" this regard (and the noremenu below).
nnoremap <unique> <script> <Plug>ToggleBackground <SID>TogBG
inoremap <unique> <script> <Plug>ToggleBackground <ESC><SID>TogBG<ESC>a
vnoremap <unique> <script> <Plug>ToggleBackground <ESC><SID>TogBG<ESC>gv
nnoremenu <script> Window.Toggle\ Background <SID>TogBG
inoremenu <script> Window.Toggle\ Background <ESC><SID>TogBG<ESC>a
vnoremenu <script> Window.Toggle\ Background <ESC><SID>TogBG<ESC>gv
tmenu Window.Toggle\ Background Toggle light and dark background modes
nnoremenu <script> ToolBar.togglebg <SID>TogBG
inoremenu <script> ToolBar.togglebg <ESC><SID>TogBG<ESC>a
vnoremenu <script> ToolBar.togglebg <ESC><SID>TogBG<ESC>gv
tmenu ToolBar.togglebg Toggle light and dark background modes
noremap <SID>TogBG  :call <SID>TogBG()<CR>

function! s:TogBG()
    if g:solarized_background == "dark"
        let g:solarized_background = "light"
    else
        let g:solarized_background = "dark"
    endif

    if exists("g:colors_name")
        let l:colors_name = g:colors_name
        let &background = g:solarized_background
        let g:colors_name = l:colors_name
        exe "colorscheme " . l:colors_name
    endif
endfunction

"if !has('gui_running')
    ":call s:TogBG()
"endif

if !exists(":ToggleBG")
    command ToggleBG :call s:TogBG()
endif

function! togglebg#map(mapActivation)
    try
        exe "silent! nmap <unique> ".a:mapActivation." <Plug>ToggleBackground"
        exe "silent! imap <unique> ".a:mapActivation." <Plug>ToggleBackground"
        exe "silent! vmap <unique> ".a:mapActivation." <Plug>ToggleBackground"
    finally
        return 0
    endtry
endfunction

if !exists("no_plugin_maps") && !hasmapto('<Plug>ToggleBackground')
    call togglebg#map("<F5>")
endif
