ARCHS=amd64 x32 i386 win32 win64 mips mipsel mips64 mips64el
all: $(ARCHS:%=arch-detect-%)

clean:
	rm -f *.o arch-detect-* core *.core

arch-detect-amd64: amd64.s
	x86_64-linux-gnu-as $^ -o amd64.o
	x86_64-linux-gnu-ld -s amd64.o -o $@

arch-detect-x32: x32.s
	x86_64-linux-gnu-as --x32 $^ -o x32.o
	x86_64-linux-gnu-ld -melf32_x86_64 -s x32.o -o $@

arch-detect-i386: i386.s
	x86_64-linux-gnu-as --32 $^ -o i386.o
	x86_64-linux-gnu-ld -melf_i386 -s i386.o -o $@

arch-detect-win32: generic.c
	i686-w64-mingw32-gcc $^ -s -o $@

arch-detect-win64: generic.c
	x86_64-w64-mingw32-gcc $^ -s -o $@

arch-detect-mips: mips.s
	mips-linux-gnu-as -32 -EB $^ -o mips.o
	mips-linux-gnu-ld -melf32btsmip -s mips.o -o $@

arch-detect-mipsel: mips.s
	mips-linux-gnu-as -32 -EL $^ -o mipsel.o
	mips-linux-gnu-ld -melf32ltsmip -s mipsel.o -o $@

arch-detect-mips64: mips64.s
	mips-linux-gnu-as -64 -EB $^ -o mips64.o
	mips-linux-gnu-ld -melf64btsmip -s mips64.o -o $@

arch-detect-mips64el: mips64.s
	mips-linux-gnu-as -64 -EL $^ -o mips64el.o
	mips-linux-gnu-ld -melf64ltsmip -s mips64el.o -o $@