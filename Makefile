SHELL=/bin/bash

build:
	@./build.sh

clean:
	@./clean.sh

install:
	@flatpak install -y --user redream.flatpak

uninstall:
	@flatpak remove -y --user io.recompiled.redream