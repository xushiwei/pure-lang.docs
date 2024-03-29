
# Package name and version number:
dist = pure-docs-$(version)
version = 0.56

# Try to guess the installation prefix:
prefix = $(patsubst %/bin/pure,%,$(shell which pure 2>/dev/null))
ifeq ($(strip $(prefix)),)
# Fall back to /usr/local.
prefix = /usr/local
endif

# Installation goes into $(libdir)/pure, you can also set this directly
# instead of $(prefix).
libdir = $(prefix)/lib

htmlfiles = $(wildcard *.html) $(wildcard *.js)
tmfiles = $(wildcard *.tm)
pdffiles = $(wildcard *.pdf)

datadir = $(libdir)/pure/docs

.PHONY: all help install uninstall dist

all: help

help:
	@echo "Run 'make install' to install, 'make uninstall' to uninstall this package."

install:
	rm -rf $(DESTDIR)$(datadir)
	test -d $(DESTDIR)$(datadir) || mkdir -p $(DESTDIR)$(datadir)
	cp -r _images _sources _static $(htmlfiles) $(DESTDIR)$(datadir)

# Run this too if you also want to install the documentation in texmacs format.
install-tm:
	cp -r $(tmfiles) $(DESTDIR)$(datadir)

uninstall:
	rm -rf $(DESTDIR)$(datadir)

distfiles = Makefile debian/* _images/* _sources/* _static/* $(htmlfiles) $(tmfiles) $(pdffiles)

dist:
	rm -rf $(dist)
	mkdir $(dist) && mkdir $(dist)/debian && mkdir $(dist)/_images && mkdir $(dist)/_sources && mkdir $(dist)/_static
	for x in $(distfiles); do ln -sf $$PWD/$$x $(dist)/$$x; done
	rm -f $(dist).tar.gz
	tar cfzh $(dist).tar.gz $(dist)
	rm -rf $(dist)

debsrc = $(shell echo $(dist) | sed -e 's/-$(version)/_$(version)/').orig.tar.gz

deb: $(debsrc) dist
	tar xfz $(dist).tar.gz
	cd $(dist) && debuild $(DEBUILD_FLAGS)
	rm -rf $(dist)

$(debsrc):
	wget -nv http://pure-lang.googlecode.com/files/$(dist).tar.gz -O $@
