Date: Thu, 15 May 2008 10:36:11 +0200
Message-Id: <1164134085@domain.hid>
MIME-Version: 1.0
From: Paradoxxa2001@domain.hid
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] at91sam9263 and user-space support compile fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

im trying to compile the user-space with following instructions:

cd xenobuild
../xenomai-2.4.3/configure --build=3Di686-pc-linux-gnu --host=3Darm-elf --enab=
le-arm-mach=3Dat91sam926x
make

Here is the output that make generate:
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F
Making all in src
make[1]: Entering directory `/home/paradoxxa/xenobuild/src'
Making all in include
make[2]: Entering directory `/home/paradoxxa/xenobuild/src/include'
make  all-am
make[3]: Entering directory `/home/paradoxxa/xenobuild/src/include'
make[3]: F=FCr das Ziel =BBall-am=AB ist nichts zu tun.
make[3]: Leaving directory `/home/paradoxxa/xenobuild/src/include'
make[2]: Leaving directory `/home/paradoxxa/xenobuild/src/include'
Making all in rtdk
make[2]: Entering directory `/home/paradoxxa/xenobuild/src/rtdk'
/bin/sh ../../libtool --tag=3DCC   --mode=3Dcompile arm-elf-gcc -DHAVE=5FCONFIG=5F=
H -I. -I../../src/include -I../../../xenomai-2.4.3/src/rtdk  -O2 -D=5FGNU=5FSO=
URCE -D=5FREENTRANT -Wall -pipe -march=3Darmv5 -D=5F=5FXENO=5F=5F -D=5F=5FIN=5FXENO=5F=5F -Wstri=
ct-prototypes -I../../../xenomai-2.4.3/include    -MT librtdk=5Fla-rt=5Fprint.=
lo -MD -MP -MF .deps/librtdk=5Fla-rt=5Fprint.Tpo -c -o librtdk=5Fla-rt=5Fprint.lo =
`test -f 'rt=5Fprint.c' || echo '../../../xenomai-2.4.3/src/rtdk/'`rt=5Fprint.=
c
 arm-elf-gcc -DHAVE=5FCONFIG=5FH -I. -I../../src/include -I../../../xenomai-2.=
4.3/src/rtdk -O2 -D=5FGNU=5FSOURCE -D=5FREENTRANT -Wall -pipe -march=3Darmv5 -D=5F=5FX=
ENO=5F=5F -D=5F=5FIN=5FXENO=5F=5F -Wstrict-prototypes -I../../../xenomai-2.4.3/include -=
MT librtdk=5Fla-rt=5Fprint.lo -MD -MP -MF .deps/librtdk=5Fla-rt=5Fprint.Tpo -c ../=
../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c -o librtdk=5Fla-rt=5Fprint.o
In file included from ../../src/include/asm/xenomai/system.h:134,
                 from ../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:30:
../../../xenomai-2.4.3/include/nucleus/system.h:23:20: error: memory.h: No=
 such file or directory
../../../xenomai-2.4.3/include/nucleus/system.h:25:23: error: asm/param.h:=
 No such file or directory
In file included from ../../src/include/asm/xenomai/atomic.h:77,
                 from ../../../xenomai-2.4.3/include/nucleus/system.h:26,
                 from ../../src/include/asm/xenomai/system.h:134,
                 from ../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:30:
../../src/include/asm/xenomai/syscall.h:229:22: error: sys/mman.h: No such=
 file or directory
In file included from ../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:30:
../../src/include/asm/xenomai/system.h:135:28: error: bits/local=5Flim.h: No=
 such file or directory
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:68: error: expected '=3D', ',', '=
;', 'asm' or '=5F=5Fattribute=5F=5F' before '=5F=5Fbuffer=5Flock'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:69: error: expected '=3D', ',', '=
;', 'asm' or '=5F=5Fattribute=5F=5F' before '=5F=5Fbuffer=5Fkey'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function 'rt=5Fvfprintf':
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:78: warning: implicit declarati=
on of function 'pthread=5Fgetspecific'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:78: error: '=5F=5Fbuffer=5Fkey' undec=
lared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:78: error: (Each undeclared ide=
ntifier is reported only once
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:78: error: for each function it=
 appears in.)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:78: warning: initialization mak=
es pointer from integer without a cast
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:95: warning: assignment makes p=
ointer from integer without a cast
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function 'set=5Fbuffer=5Fname':=

../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:206: warning: implicit declarat=
ion of function 'pthread=5Fself'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function 'rt=5Fprint=5Finit':
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:216: error: '=5F=5Fbuffer=5Fkey' unde=
clared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:216: warning: initialization ma=
kes pointer from integer without a cast
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:253: warning: implicit declarat=
ion of function 'pthread=5Fmutex=5Flock'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:253: error: '=5F=5Fbuffer=5Flock' und=
eclared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:260: warning: implicit declarat=
ion of function 'pthread=5Fmutex=5Funlock'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:262: warning: implicit declarat=
ion of function 'pthread=5Fsetspecific'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function 'rt=5Fprint=5Fcleanup'=
:
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:274: error: '=5F=5Fbuffer=5Fkey' unde=
clared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:274: warning: passing argument =
1 of 'cleanup=5Fbuffer' makes pointer from integer without a cast
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function 'rt=5Fprint=5Fbuffer=5Fn=
ame':
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:279: error: '=5F=5Fbuffer=5Fkey' unde=
clared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:279: warning: initialization ma=
kes pointer from integer without a cast
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:290: warning: assignment makes =
pointer from integer without a cast
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function 'cleanup=5Fbuffer':
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:303: error: '=5F=5Fbuffer=5Fkey' unde=
clared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:305: error: '=5F=5Fbuffer=5Flock' und=
eclared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function 'printer=5Fthread':
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:387: warning: implicit declarat=
ion of function 'nanosleep'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:389: error: '=5F=5Fbuffer=5Flock' und=
eclared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c: In function '=5F=5Frt=5Fprint=5Finit':=

../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:399: error: 'pthread=5Ft' undecla=
red (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:399: error: expected ';' before=
 'thread'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:400: error: 'pthread=5Fattr=5Ft' un=
declared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:400: error: expected ';' before=
 'thattr'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:432: warning: implicit declarat=
ion of function 'pthread=5Fmutex=5Finit'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:432: error: '=5F=5Fbuffer=5Flock' und=
eclared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:433: warning: implicit declarat=
ion of function 'pthread=5Fkey=5Fcreate'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:433: error: '=5F=5Fbuffer=5Fkey' unde=
clared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:435: warning: implicit declarat=
ion of function 'pthread=5Fattr=5Finit'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:435: error: 'thattr' undeclared=
 (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:436: warning: implicit declarat=
ion of function 'pthread=5Fattr=5Fsetstacksize'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:436: error: 'PTHREAD=5FSTACK=5FMIN'=
 undeclared (first use in this function)
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:437: warning: implicit declarat=
ion of function 'pthread=5Fcreate'
../../../xenomai-2.4.3/src/rtdk/rt=5Fprint.c:437: error: 'thread' undeclared=
 (first use in this function)
make[2]: *** [librtdk=5Fla-rt=5Fprint.lo] Fehler 1
make[2]: Leaving directory `/home/paradoxxa/xenobuild/src/rtdk'
make[1]: *** [all-recursive] Fehler 1
make[1]: Leaving directory `/home/paradoxxa/xenobuild/src'
make: *** [all-recursive] Fehler 1
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F

It says me that the files memory.h and asm/param.h couldn't be found.=20
Im wondering why=3F I also tried it like the example in the README.INSTALL 2=
.6 Building for ARM
but with the same result. Do anyone know how to fix this=3F

Regards,
Thomas





=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten!=20
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/=3Fmc=3D021114


