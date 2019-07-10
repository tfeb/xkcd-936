######################## -*- Mode: Makefile-Bsdmake -*- #######################
## File		    - Makefile
## Description	    - Convert & install Python 3 variants
## Author	    - Tim Bradshaw (tfb at tfeb.org)
## Created On	    - Wed Apr 29 09:33:39 2015
## Status	    - Unknown
##
## $Format:(@:%H)$
###############################################################################

# Currently the Python 3 versions are made from the Pythin 2.7
# versions: in due course this will stop being the case and these will
# become the master.  That will happen when every machine I need to
# use has a Python 3 by default.
#

PREFIX		= $(HOME)
BIN		= $(PREFIX)/bin
TOOLS		= random-password random-passphrase
TWO		= 2.7
TWOTOTHREE	= 2to3-$(TWO)
TWODIR		= ../python-$(TWO)

.PHONY: install convert clean

install: $(TOOLS)
	mkdir -p $(BIN)
	install -C -m 555 $? $(BIN)
	rm -f $(TOOLS)

convert: $(TOOLS)

clean:
	rm -f $(TOOLS)

$(TOOLS): %: $(TWODIR)/%
	sed -e 's:^#!/usr/bin/env python2\.7:#!/usr/bin/env python3:' < $< > $@
	$(TWOTOTHREE) -n --no-diffs -w $@
	chmod +x $@
