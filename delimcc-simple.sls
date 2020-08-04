(library (delimcc-simple)
  (export reset*
	  shift*
	  reset
	  shift)
  (import (except (chezscheme) reset))
  (include "delimcc-simple.scm")
; Execute a thunk in the empty environment -- at the bottom of the stack --
; and pass the result, too encapsulated as a thunk, to the
; continuation at the top of pstack. The top-most pstack frame is
; removed.
;
; We rely on the insight that the capture of a delimited continuation
; can be reduced to the capture of the undelimited one. We invoke 
; (go th) to execute the thunk th in the delimited context. 
; The call to 'go' is evaluated almost in the empty context
; (near the `bottom of the stack'). Therefore,
; any call/cc operation encountered during the evaluation of th
; will capture at most the context established by the 'go' call, NOT
; including the context of go's caller. Informally, invoking (go th)
; creates a new stack segment; continuations captured by call/cc
; cannot span the segment boundaries, and are hence delimited.
; 
; This emulation of delimited control is efficient providing that
; call/cc is implemented efficiently, with the hybrid heap/stack or
; stack segment strategies.
  (let ((v
	(call/cc
	  (lambda (k)
	    (set! go k)
	    (k #f)))))
  (if v
    (let* ((r (v))
	   (h (car pstack))
	   (_ (set! pstack (cdr pstack))))
      (h r))	; does not return
    )))
