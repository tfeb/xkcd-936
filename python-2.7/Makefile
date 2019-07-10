######################## -*- Mode: Makefile-Bsdmake -*- #######################
## File		    - Makefile
## Description	    - Tool installer
## Author	    - Tim Bradshaw (tfb at tfeb.org)
## Created On	    - Wed Apr 29 09:33:39 2015
## Status	    - Unknown
##
## $Format:(@:%H)$
###############################################################################


PREFIX		= $(HOME)
BIN		= $(PREFIX)/bin
TOOLS		= random-password random-passphrase

.PHONY: install wc

install: $(TOOLS)
	mkdir -p $(BIN)
	install -C -m 555 $? $(BIN)

wc: $(TOOLS)
	@wc $(TOOLS)
