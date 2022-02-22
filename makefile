CFLAGS=`pkg-config --cflags --libs libusb-1.0`
INSTALL_PREFIX=/usr/local
INSTALL_LIBDIR=$(INSTALL_PREFIX)/lib

j2534: j2534.o
	clang -arch arm64 -g -dynamiclib j2534.o $(CFLAGS) -o mac-tactrix-openport-driver.dylib
j2534.o: j2534.c
	clang -arch arm64 -g -c j2534.c $(CFLAGS)
tags: j2534.c
	ctags --c-kinds=+cl * /usr/include/libusb-1.0/libusb.h
clean:
	rm -f j2534.o j2534.dylib
install: j2534
	mkdir -p $(INSTALL_LIBDIR)
	mkdir -p $(INSTALL_PREFIX)/include/
	cp j2534.h $(INSTALL_PREFIX)/include/
	cp j2534.pc /usr/lib/pkgconfig/
	cp j2534.so $(INSTALL_LIBDIR)/mac-tactrix-openport-driver.dylib
