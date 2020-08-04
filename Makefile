package = delimcc
version = 1.0
chez = scheme
out =

build :
	echo "(compile-library \"delimcc.sls\")" | $(chez) -q

check : build
	echo "(import (delimcc)) (load \"delimcc-tests.scm\")" | $(chez) --libdirs "." -q

install :
	mkdir -p $(out)
	cp -r *.so $(out)

clean:
	find . -name "*.so" -exec rm {} \;
	find . -name "*~" -exec rm {} \;
