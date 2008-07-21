Date: Mon, 21 Jul 2008 14:54:58 +0200 (MEST)
Message-Id: <200807211254.m6LCswrS024819@domain.hid>
From: "Christian Volk" <linux.kernel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Errors while compiling the testsuite
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

Hi all,

while building xenomai, i get an "unresolved reference error" in clocktest.=
c
Here are the appropriate lines from the output:

Making all in clocktest
make[3]: Entering directory `/home/develop/Download/xenomai-2.4.4/src/tests=
uite/clocktest'
/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-gcc-4.2.3 -DHAVE=
_CONFIG_H -I. -I../../../src/include  -I../../../include/posix -O2 -D_GNU_S=
OURCE -D_REENTRANT -Wall -pipe -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes=
 -I../../../include    -MT clocktest-clocktest.o -MD -MP -MF .deps/clocktes=
t-clocktest.Tpo -c -o clocktest-clocktest.o `test -f 'clocktest.c' || echo =
'./'`clocktest.c
clocktest.c: In function 'check_time_warps':
clocktest.c:129: warning: implicit declaration of function 'pthread_spin_lo=
ck'
clocktest.c:133: warning: implicit declaration of function 'pthread_spin_un=
lock'
clocktest.c: In function 'main':
clocktest.c:203: warning: implicit declaration of function 'pthread_spin_in=
it'
mv -f .deps/clocktest-clocktest.Tpo .deps/clocktest-clocktest.Po
/bin/sh ../../../libtool --tag=3DCC   --mode=3Dlink /opt/powerpc-linux-ucli=
bc/bin/powerpc-generic-linux-uclibc-gcc-4.2.3   -Wl,@/home/develop/Download=
/xenomai-2.4.4/src/skins/posix/posix.wrappers   -o clocktest clocktest-cloc=
ktest.o ../../skins/posix/libpthread_rt.la -lpthread -lrt
mkdir .libs
/opt/powerpc-linux-uclibc/bin/powerpc-generic-linux-uclibc-gcc-4.2.3 -Wl,@/=
home/develop/Download/xenomai-2.4.4/src/skins/posix/posix.wrappers -o .libs=
/clocktest clocktest-clocktest.o  ../../skins/posix/.libs/libpthread_rt.so =
-lpthread -lrt -Wl,--rpath -Wl,/usr/xenomai/lib
clocktest-clocktest.o: In function `main':
clocktest.c:(.text+0x10c): undefined reference to `pthread_spin_init'
clocktest-clocktest.o: In function `check_time_warps':
clocktest.c:(.text+0x36c): undefined reference to `pthread_spin_lock'
clocktest.c:(.text+0x3b8): undefined reference to `pthread_spin_unlock'
clocktest.c:(.text+0x3c8): undefined reference to `pthread_spin_lock'
clocktest.c:(.text+0x3f0): undefined reference to `pthread_spin_unlock'
clocktest.c:(.text+0x44c): undefined reference to `pthread_spin_unlock'
collect2: ld returned 1 exit status
make[3]: *** [clocktest] Fehler 1
make[3]: Leaving directory `/home/develop/Download/xenomai-2.4.4/src/testsu=
ite/clocktest'

This happens when I try to compile for powerpc with uclibc.

Can anyone tell me where to search for the error??

The second question I have is, while configuring i need to specify --build =
and --host. The --host option means the architecture I'm compiling Xenomai =
for and --build means the system I'm building on. But what are the values I=
 have to specify there??
Could someone pleas give me an example??

Thanks in advance.

regards,

Christian=20
 

