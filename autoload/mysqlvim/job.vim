let s:save_cpo = &cpo
set cpo&vim

function! s:JobHandler(job_id,data,event) abort
      if a:event == 'stdout'
        let str = ' stdout: '.join(a:data)
      elseif a:event == 'stderr'
        let str = ' stderr: '.join(a:data)
      else
        let str = ' exited'
      endif
      echo a:event
endfunction

let s:callbacks = {
            \ 'on_stdout': function('s:JobHandler'),
            \ 'on_stderr': function('s:JobHandler'),
            \ 'on_exit': function('s:JobHandler')
            \ }

let job2 = jobstart(['java','Foo'], s:callbacks)

let &cpo = s:save_cpo
unlet s:save_cpo
