(library (delimcc)
  (export new-prompt
	  push-prompt
	  abortP
	  take-subcont
	  push-subcont
	  push-delim-subcont
	  shift
	  shift0
	  control
	  prompt-set?)
  (import (chezscheme))
  (include "delimcc.scm")
  (let ((v
	(call/cc
	  (lambda (k)
	    (set! go k)
	    (k #f)))))
  (if v
    (let* ((r (v))
	   (h (car pstack))
	   (_ (set! pstack (cdr pstack))))
      ((cdr h) (lambda () r)))	; does not return
    )))
