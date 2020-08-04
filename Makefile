package = delimcc
version = 1.0
chez = scheme --libdirs "." -q
out =

build :
	echo "(compile-library \"delimcc.sls\")" | $(chez)
	echo "(compile-library \"delimcc-simple.sls\")" | $(chez)

check : build
	echo "(import (delimcc)) (load \"delimcc-tests.scm\")" | $(chez)
	echo "(import (delimcc-simple)) (load \"delimcc-simple-tests.scm\")" | $(chez)
	echo "(import (delimcc-simple)) (load \"bench-nondet.scm\")" | $(chez)

install :
	mkdir -p $(out)
	cp -r *.so $(out)

clean:
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
