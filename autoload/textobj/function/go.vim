" textobj-function - Text objects for functions
" Version: 0.4.0
" Copyright (C) 2014 Kana Natsuno <http://whileimautomaton.net/>
" License: MIT license
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"

function! textobj#function#go#select(object_type)
  return s:select_{a:object_type}()
endfunction

function! s:select_a()
  let s = getpos('.')
  while 1
    normal ^
    if search('^func\|^// func\|go func(\|// go func(\|\S.*=.*func(\|\sfunc(\|\s// func(', 'cbW') != 0
      let b = getpos('.')
      if search('{$', 'cW') != 0
        normal %
        let e = getpos('.')
        if s[1] >= b[1] && s[1] <= e[1]
          return ['V', b, e]
        else
          call setpos('.', b)
          normal k
        endif
      endif
    else
      return 0
    endif
  endwhile
endfunction

function! s:select_i()
  let s = getpos('.')
  while 1
    normal ^
    if search('^func\|^// func\|go func(\|// go func(\|\S.*=.*func(\|\sfunc(\|\s// func(', 'cbW') != 0
      let b = getpos('.')
      if search('{$', 'cW') != 0
        normal %
        let e = getpos('.')
        if s[1] >= b[1] && s[1] <= e[1]
          if 1 < e[1] - b[1]
            call setpos('.', b)
            normal j0
            let b = getpos('.')
            call setpos('.', e)
            normal k$
            let e = getpos('.')
            return ['V', b, e]
          else
            return 0
          endif
        else
          call setpos('.', b)
          normal k
        endif
      endif
    else
      return 0
    endif
  endwhile
endfunction

" __END__
" vim: foldmethod=marker
