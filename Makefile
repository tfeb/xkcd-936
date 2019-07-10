######################## -*- Mode: Makefile-Bsdmake -*- #######################
## File		    - Makefile
## Description	    - Install xkcd-936 tools
## Author	    - Tim Bradshaw (tfb at kingston.local)
## Created On	    - Wed Jul 10 14:12:32 2019
## Status	    - Unknown
##
## $Format:(@:%H)$
###############################################################################

PYTHONVER = 2.7

.PHONY: install

install:
	$(MAKE) -C python-$(PYTHONVER) install
