PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
SHAREDIR ?= $(PREFIX)/share

.PHONY: clean install upload

clean:
	rm -f create-changelog.1* NEWS README

install: lib/* bin/* create-changelog.1 NEWS README
	install -d $(DESTDIR)$(SHAREDIR)/create-changelog/lib/
	install -d $(DESTDIR)$(SHAREDIR)/create-changelog/bin/
	install -m 755 lib/* $(DESTDIR)$(SHAREDIR)/create-changelog/lib/
	install -m 755 bin/* $(DESTDIR)$(SHAREDIR)/create-changelog/bin/
	install -d $(DESTDIR)$(MANDIR)/man1
	install -m 644 create-changelog.1 $(DESTDIR)$(MANDIR)/man1
	rm -f create-changelog.1

create-changelog.1: README.md make-manpage.sh
	./make-manpage.sh README.md create-changelog.1

NEWS: NEWS.md
	pandoc NEWS.md -t plain -o NEWS

README: README.md
	pandoc README.md -t plain -o README
	
upload:
	debuild -S
	dput ppa:bovender/bovender ../create-changelog_*_source.changes
	rm ../create-changelog_*
