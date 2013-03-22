Message-ID: <514C8FD5.90507@geomar.de>
Date: Fri, 22 Mar 2013 18:07:33 +0100
From: mwollatz-vogt <mwollatz-vogt@geomar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problems Crosscompiling for Foxboard G20
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi List,

I?m following the howto http://www.federicololli.com/xenomaifoxg20.htm

i?m working with ubuntu 12 in a virtual-box.
i downloaded linux-2.6.35.9 and patched it with Federico?s patch
then i run make to compile the kernel.
i got the uImage
to get the armel-root i run the gen_root3.sh
(btw. i had to change in gen_root3.sh the rep?s in archieve and also add=20
mkdir etc and mkdir dev )

i installed xenomai-2.5.6 (this worked only after adding CFLAGS "-marm"
so i run
./configure --host=3Darm-linux-gnueabi --enable-arm-eabi=20
--enable-arm-mach=3Dat91sam89 --disable-arm-tsc *CFLAGS=3D"-marm"*
and
make DESTDIR=3D/ install
now i got in /usr/xenomai the files

now i want to compile the examples
so i followed the http://www.xenomai.org/index.php/Examples

*question:*
how to crosscompile the examples?

i tried this:

DESTDIR=3D/ make XENO=3D/usr/xenomai ARCH=3DARM KSRC=3D/home/martin/xenomai=
/xenomai-2.5.6/ksrc

and this:

DESTDIR=3D/ make XENO=3D/usr/xenomai ARCH=3DARM CROSS_COMPILE=3Darm-none-li=
nux KSRC=3D/home/martin/xenomai/xenomai-2.5.6/ksrc

it is compiling with errors :

root@martin-VirtualBox:/home/martin/xenomai/xenomai-head/examples# DESTDIR=
=3D/
make XENO=3D/usr/xenomai ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi
KSRC=3D/home/martin/xenomai/xenomai-2.5.6/ksrc
make[1]: Betrete Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/common'
make[1]: F=C31/4r das Ziel =C2=BBall=C2=AB ist nichts zu tun.
make[1]: Verlasse Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/common'
make[1]: Betrete Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/native'
arm-linux-gnueabi-gcc  -I//usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO__    rtprint.c -Xlinker -rpath -Xlinker
-//usr/xenomai/lib -lnative -L//usr/xenomai/lib -lxenomai -lpthread -o
-//rtprint
/tmp/ccDtXhmB.o: In function `task2_func':
rtprint.c:(.text+0x20): undefined reference to `rt_printf'
rtprint.c:(.text+0x48): undefined reference to `rt_print_buffer_name'
rtprint.c:(.text+0x68): undefined reference to `rt_fprintf'
/tmp/ccDtXhmB.o: In function `main':
rtprint.c:(.text+0xb0): undefined reference to `rt_print_auto_init'
rtprint.c:(.text+0xbc): undefined reference to `rt_print_init'
rtprint.c:(.text+0x124): undefined reference to `rt_print_buffer_name'
rtprint.c:(.text+0x144): undefined reference to `rt_printf'
collect2: ld returned 1 exit status
make[1]: *** [rtprint] Fehler 1
make[1]: Verlasse Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/native'
make[1]: Betrete Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/posix'
echo make -C /home/martin/xenomai/xenomai-2.5.6/ksrc ARCH=3Darm
CROSS_COMPILE=3Darm-linux-gnueabi
SUBDIRS=3D/home/martin/xenomai/xenomai-head/examples/posix modules
make -C /home/martin/xenomai/xenomai-2.5.6/ksrc ARCH=3Darm
CROSS_COMPILE=3Darm-linux-gnueabi
SUBDIRS=3D/home/martin/xenomai/xenomai-head/examples/posix modules
make -C /home/martin/xenomai/xenomai-2.5.6/ksrc ARCH=3Darm
CROSS_COMPILE=3Darm-linux-gnueabi
SUBDIRS=3D/home/martin/xenomai/xenomai-head/examples/posix modules
make[2]: Betrete Verzeichnis '/home/martin/xenomai/xenomai-2.5.6/ksrc'
Makefile:18: /Rules.make: Datei oder Verzeichnis nicht gefunden
make[2]: *** Keine Regel, um =C2=BB/Rules.make=C2=AB zu erstellen.  Schluss.
make[2]: Verlasse Verzeichnis '/home/martin/xenomai/xenomai-2.5.6/ksrc'
make[1]: *** [all] Fehler 2
make[1]: Verlasse Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/posix'
make[1]: Betrete Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/driver-api'
make -C /home/martin/xenomai/xenomai-2.5.6/ksrc
SUBDIRS=3D/home/martin/xenomai/xenomai-head/examples/rtdm/driver-api modules
make[2]: Betrete Verzeichnis '/home/martin/xenomai/xenomai-2.5.6/ksrc'
Makefile:18: /Rules.make: Datei oder Verzeichnis nicht gefunden
make[2]: *** Keine Regel, um =C2=BB/Rules.make=C2=AB zu erstellen.  Schluss.
make[2]: Verlasse Verzeichnis '/home/martin/xenomai/xenomai-2.5.6/ksrc'
make[1]: *** [all] Fehler 2
make[1]: Verlasse Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/driver-api'
make[1]: Betrete Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/profiles/ipc'
arm-linux-gnueabi-gcc -I//usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -D__XENO__ -I//usr/xenomai/include/posix    -Xlinker -rpath
--Xlinker //usr/xenomai/lib  xddp-echo.c
---Wl,@//usr/xenomai/lib/posix.wrappers -L//usr/xenomai/lib -lpthread_rt
----lxenomai -lpthread -lrt  -lrtdm -L//usr/xenomai/lib -lxenomai -lpthread
-----o xddp-echo
xddp-echo.c: In function =E2=80=98realtime_thread=E2=80=99:
xddp-echo.c:115: error: =E2=80=98SOL_XDDP=E2=80=99 undeclared (first use in=
 this function)
xddp-echo.c:115: error: (Each undeclared identifier is reported only once
xddp-echo.c:115: error: for each function it appears in.)
xddp-echo.c:115: error: =E2=80=98XDDP_POOLSZ=E2=80=99 undeclared (first use=
 in this
function)
make[1]: *** [xddp-echo] Fehler 1
make[1]: Verlasse Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/profiles/ipc'
make[1]: Betrete Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/profiles/serial'
make[1]: F=C31/4r das Ziel =C2=BBall=C2=AB ist nichts zu tun.
make[1]: Verlasse Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/profiles/serial'
make[1]: Betrete Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/profiles/can'
make[1]: F=C31/4r das Ziel =C2=BBall=C2=AB ist nichts zu tun.
make[1]: Verlasse Verzeichnis
'/home/martin/xenomai/xenomai-head/examples/rtdm/profiles/can'


I?m following the howto http://www.federicololli.com/xenomaifoxg20.htm

i?m working with ubuntu 12 in a virtual-box.
i downloaded linux-2.6.35.9 and patched it with Federico?s patch
then i run make to compile the kernel.
i got the uImage
to get the armel-root i run the gen_root3.sh
(btw. i had to change in gen_root3.sh the rep?s in archieve and also add=20
mkdir etc and mkdir dev )

i installed xenomai-2.5.6 (this worked only after adding CFLAGS "-marm"
so i run
./configure --host=3Darm-linux-gnueabi --enable-arm-eabi=20
--enable-arm-mach=3Dat91sam89 --disable-arm-tsc *CFLAGS=3D"-marm"*
and
make DESTDIR=3D/ install
now i got in /usr/xenomai the files

now i want to compile the examples
so i followed the http://www.xenomai.org/index.php/Examples
