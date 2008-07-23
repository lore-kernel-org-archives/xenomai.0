Date: Wed, 23 Jul 2008 11:17:00 +0200 (MEST)
Message-Id: <200807230917.m6N9H0tZ028205@domain.hid>
From: "Christian Volk" <linux.kernel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Errors while static linking of Xenomai
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

Hi,

when I try to compile Xenomai and link it satically i get some 'undefined r=
eference' errors while compiling the cyclictest programm from the testsuite=
.
I'm using Xenomai 2.4.4 with uclibc and try to compile for a ppc-arch board=
 (Freescale MPC8343 processor).

Heres the line which I use to configure Xenomai:
./configure --host=3Dpowerpc-generic-linux-uclibc CC=3D/opt/powerpc-linux-u=
clibc/bin/powerpc-generic-linux-uclibc-gcc CXX=3D/opt/powerpc-linux-uclibc/=
bin/powerpc-generic-linux-uclibc-g++ LD=3D/opt/powerpc-linux-uclibc/bin/pow=
erpc-generic-linux-uclibc-ld --enable-shared=3Dno LDFLAGS=3D--static=20

And thats the output I get when compiling cyclictest:

Making install in cyclic
make[3]: Entering directory `/home/develop/Download/xenomai-2.4.4/src/tests=
uite/cyclic'
/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-gcc -DHAVE_CONFI=
G_H -I. -I../../../src/include  -I../../../include/posix -O2 -D_GNU_SOURCE =
-D_REENTRANT -Wall -pipe -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -DIPI=
PE_TRACE=3D1 -I../../../include    -MT cyclictest-cyclictest.o -MD -MP -MF =
.deps/cyclictest-cyclictest.Tpo -c -o cyclictest-cyclictest.o `test -f 'cyc=
lictest.c' || echo './'`cyclictest.c
mv -f .deps/cyclictest-cyclictest.Tpo .deps/cyclictest-cyclictest.Po
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dlink /opt/powerpc-linux-ucli=
bc/bin/powerpc-generic-linux-uclibc-gcc   -Wl,@/home/develop/Download/xenom=
ai-2.4.4/src/skins/posix/posix.wrappers  --static -o cyclictest cyclictest-=
cyclictest.o ../../skins/posix/libpthread_rt.la -lpthread -lrt
mkdir .libs
/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-gcc -Wl,@/home/d=
evelop/Download/xenomai-2.4.4/src/skins/posix/posix.wrappers --static -o cy=
clictest cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.a -=
lpthread -lrt
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x3f4): undefined reference to `__wrap_pth=
read_condattr_destroy'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x3f8): undefined reference to `__wrap_pth=
read_condattr_init'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x3fc): undefined reference to `__wrap_pth=
read_cond_broadcast'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x400): undefined reference to `__wrap_pth=
read_cond_destroy'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x404): undefined reference to `__wrap_pth=
read_cond_init'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x408): undefined reference to `__wrap_pth=
read_cond_signal'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x40c): undefined reference to `__wrap_pth=
read_cond_wait'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(pthread.os):(.data.rel+0x464): undefined reference to `__wrap_pth=
read_cond_timedwait'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(mutex.os): In function `__pthread_once_fork_child':
mutex.c:(.text+0x1fc): undefined reference to `__wrap_pthread_cond_init'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(mutex.os): In function `pthread_once':
mutex.c:(.text+0x490): undefined reference to `__wrap_pthread_cond_wait'
mutex.c:(.text+0x534): undefined reference to `__wrap_pthread_cond_broadcas=
t'
/opt/powerpc-linux-uclibc/powerpc-generic-linux-uclibc/sys-root/usr/lib/lib=
pthread.a(mutex.os): In function `pthread_once_cancelhandler':
mutex.c:(.text+0x58c): undefined reference to `__wrap_pthread_cond_broadcas=
t'
collect2: ld returned 1 exit status
make[3]: *** [cyclictest] Fehler 1


Any hints and/or help to solve this problem is appreciated.

Thanks in advance.

regards,
Christian  

