# OS detected
ifeq ($(OS),Windows_NT)
	ifneq ($(findstring .exe,$(SHELL)),)
    OS_TYPE := Windows
	else
    OS_TYPE := Cygwin
	endif
else
    OS_TYPE := $(shell uname -s)
endif

all:unpack example doc

unpack:FORCE
	make -C ./husttrans unpack

example ./husttrans/husttrans-example.pdf:
	make -C ./husttrans example

doc ./husttrans/husttrans.pdf:
	make -C ./husttrans doc

clean:
	make -C ./husttrans clean

reallyclean:
	make -C ./husttrans reallyclean

install:unpack ./husttrans/husttrans-example.pdf ./husttrans/husttrans.pdf
ifeq ($(OS_TYPE),Windows)
	./install/win32.bat install
else
	./install/unix.sh install
endif

uninstall:
ifeq ($(OS_TYPE),Windows)
	./install/win32.bat uninstall
else
	./install/unix.sh uninstall
endif

checksum:FORCE
	make -C ./husttrans checksum

FORCE:
.PHONY:all unpack example doc install uninstall clean reallyclean checksum FORCE
