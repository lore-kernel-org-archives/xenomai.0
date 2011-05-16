Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 May 2011 15:27:03 +0200
Message-ID: <89B30389DB4AE240AC1227F3FDBB7CCF029B910F@ontex.i.omicron.de>
In-Reply-To: <4DD107AD.5000307@domain.hid>
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>	<4DCD2EE8.2010904@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>
	<4DD102DA.9080206@domain.hid> <4DD107AD.5000307@domain.hid>
From: "Koenig, Florian" <F.Koenig@domain.hid>
Subject: Re: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,
i started from new and have done the following:


i deleted /opt/eldk-4.2 and installed it new with:
$ ./install -d /opt/eldk-4.2 ppc_4xx

Then i setup env-vars and goto /usr/src/xenomai-2.5.6:
$ export ARCH=3Dpowerpc
$ export DESTDIR=3D/opt/eldk-4.2/ppc_4xx
$ export PATH=3D$PATH:/opt/eldk-4.2/usr/bin:/opt/eldk-4.2/bin

Then i configured xenomai userspace with:
$ ./configure --host=3Dpowerpc-linux      (without --prefix=3D)
$ make
$ make install

Then i goto /usr/src/xenomai/examples and run:
$ make XENO=3D/opt/eldk-4.2/ppc_4xx/usr/xenomai/bin

And then it returns, where it searches for includes in
-I/lib/modules/2.6.32-5-686/build/include/xenomai/posix
Which is my local x86 kernel, not the powerpc kernel?


make XENO=3D/opt/eldk-4.2/ppc_4xx/usr/xenomai/
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead =
--xeno-ldflags
is deprecated, use --skin=3Dname --ldflags instead
make[1]: Entering directory =
`/usr/src/xenomai-2.5.6/examples/rtdm/driver-api'
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   =
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
-lxenomai -lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  tut01-skeleton-app.c   -o
tut01-skeleton-app
tut01-skeleton-app.c:54: warning: second argument of 'main' should be =
'char
**'
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead =
--xeno-ldflags
is deprecated, use --skin=3Dname --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   =
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
-lxenomai -lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  tut02-skeleton-app.c   -o
tut02-skeleton-app
make -C /lib/modules/2.6.32-5-686/build
SUBDIRS=3D/usr/src/xenomai-2.5.6/examples/rtdm/driver-api modules
make: Entering an unknown directory
make: *** /lib/modules/2.6.32-5-686/build: Datei oder Verzeichnis nicht
gefunden.  Schluss.
make: Leaving an unknown directory
make[1]: *** [all] Fehler 2
make[1]: Leaving directory =
`/usr/src/xenomai-2.5.6/examples/rtdm/driver-api'
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead =
--xeno-ldflags
is deprecated, use --skin=3Dname --ldflags instead
make[1]: Entering directory
`/usr/src/xenomai-2.5.6/examples/rtdm/profiles/serial'
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   =
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
-lxenomai -lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  cross-link.c   -o cross-link
make[1]: Leaving directory
`/usr/src/xenomai-2.5.6/examples/rtdm/profiles/serial'
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
make[1]: Entering directory
`/usr/src/xenomai-2.5.6/examples/rtdm/profiles/can'
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -Xlinker -rpath -Xlinker /opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
rtcan_rtt.c   -o rtcan_rtt
make[1]: Leaving directory
`/usr/src/xenomai-2.5.6/examples/rtdm/profiles/can'
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
make[1]: Entering directory
`/usr/src/xenomai-2.5.6/examples/rtdm/profiles/ipc'
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -lrtdk -Xlinker -rpath -Xlinker =
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
xddp-echo.c   -o xddp-echo
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -lrtdk -Xlinker -rpath -Xlinker =
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
xddp-label.c   -o xddp-label
xddp-label.c: In function 'realtime_thread1':
xddp-label.c:99: warning: unused variable 'len'
xddp-label.c: In function 'realtime_thread2':
xddp-label.c:161: warning: unused variable 'buf'
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -lrtdk -Xlinker -rpath -Xlinker =
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
xddp-stream.c   -o xddp-stream
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -lrtdk -Xlinker -rpath -Xlinker =
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
iddp-sendrecv.c   -o iddp-sendrecv
iddp-sendrecv.c: In function 'client':
iddp-sendrecv.c:103: warning: unused variable 'buf'
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -lrtdk -Xlinker -rpath -Xlinker =
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
iddp-label.c   -o iddp-label
iddp-label.c: In function 'client':
iddp-label.c:124: warning: unused variable 'buf'
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -lrtdk -Xlinker -rpath -Xlinker =
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
bufp-readwrite.c   -o bufp-readwrite
bufp-readwrite.c: In function 'client':
bufp-readwrite.c:97: warning: unused variable 'buf'
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-lrtdm -lrtdk -Xlinker -rpath -Xlinker =
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
bufp-label.c   -o bufp-label
bufp-label.c: In function 'client':
bufp-label.c:119: warning: unused variable 'buf'
make[1]: Leaving directory
`/usr/src/xenomai-2.5.6/examples/rtdm/profiles/ipc'
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead =
--xeno-ldflags
is deprecated, use --skin=3Dname --ldflags instead
make[1]: Entering directory `/usr/src/xenomai-2.5.6/examples/native'
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   =
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
-lxenomai -lpthread  -lnative -Xlinker -rpath -Xlinker
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  trivial-periodic.c   -o
trivial-periodic
trivial-periodic.c: In function 'main':
trivial-periodic.c:72: warning: control reaches end of non-void function
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead =
--xeno-ldflags
is deprecated, use --skin=3Dname --ldflags instead
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   =
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
-lxenomai -lpthread  -lnative -Xlinker -rpath -Xlinker
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  sigdebug.c   -o sigdebug
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead =
--xeno-ldflags
is deprecated, use --skin=3Dname --ldflags instead powerpc-linux-gcc
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT =
-Wall
-pipe -D__XENO__  rtprint.c -L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib =
-lxenomai
-lpthread  -lnative -Xlinker -rpath -Xlinker
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lrtdk -o rtprint
make[1]: Leaving directory `/usr/src/xenomai-2.5.6/examples/native'
--xeno-cflags is deprecated, use --skin=3Dname --cflags instead =
--xeno-ldflags
is deprecated, use --skin=3Dname --ldflags instead
make[1]: Entering directory `/usr/src/xenomai-2.5.6/examples/common'
powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include =
-D_GNU_SOURCE
-D_REENTRANT -Wall -pipe -D__XENO__   =
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
-lxenomai -lpthread  -O -Xlinker -rpath -Xlinker
/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  hw_direct_io.c   -o hw_direct_io
In file included from hw_direct_io.c:23:
/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix/pthread.h:469: warning:
'struct sched_param_ex' declared inside parameter list
/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix/pthread.h:469: warning: =
its
scope is only this definition or declaration, which is probably not what =
you
want
/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix/pthread.h:473: warning:
'struct sched_param_ex' declared inside parameter list
make[1]: Leaving directory `/usr/src/xenomai-2.5.6/examples/common'
sed: kann /lib/modules/2.6.32-5-686/build/Makefile nicht lesen: Datei =
oder
Verzeichnis nicht gefunden --posix-cflags is deprecated, use =
--skin=3Dposix
--cflags instead
make: *** /lib/modules/2.6.32-5-686/build: Datei oder Verzeichnis nicht
gefunden.  Schluss.
--posix-ldflags is deprecated, use --skin=3Dposix --ldflags instead
make[1]: Entering directory `/usr/src/xenomai-2.5.6/examples/posix'
powerpc-linux-gcc -DCONSUMER -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-I/lib/modules/2.6.32-5-686/build/include/xenomai
-I/lib/modules/2.6.32-5-686/build/include/xenomai/compat
-I/lib/modules/2.6.32-5-686/build/include/xenomai/posix
-Wl,@/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib/posix.wrappers
-L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread =
-lrt
-Xlinker -rpath -Xlinker /opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  satch.c  =
 -o
satch
--posix-cflags is deprecated, use --skin=3Dposix --cflags instead
make: *** /lib/modules/2.6.32-5-686/build: Datei oder Verzeichnis nicht
gefunden.  Schluss.
powerpc-linux-gcc -DCONSUMER -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include
-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__
-I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include/posix
-I/lib/modules/2.6.32-5-686/build/include/xenomai
-I/lib/modules/2.6.32-5-686/build/include/xenomai/compat
-I/lib/modules/2.6.32-5-686/build/include/xenomai/posix   -c -o satch.o
satch.c
make[1]: Leaving directory `/usr/src/xenomai-2.5.6/examples/posix'


After copying trivial-periodic to 405GP cpu, it returns illegal =
instruction.



Is /opt/eldk-4.2 meant to be the rootfs of the 405GP cpu ? I use a =
initramfs,
which is placed in /usr/src/initramfs, so i only copy the xenomai lib/ =
folder
from /opt/eldk-4.2/ppc_4xx/lib into my initramfs/lib folder.

Florian



-----Urspr=FCngliche Nachricht-----
Von: Wolfgang Grandegger [mailto:wg@domain.hid
Gesendet: Montag, 16. Mai 2011 13:17
An: Koenig, Florian
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] build xenomai userspace app, illegal =
instruction

On 05/16/2011 12:56 PM, Wolfgang Grandegger wrote:
> On 05/16/2011 12:23 PM, Koenig, Florian wrote:
>> Hi,
>>
>> i installed eldk into /opt/eldk-4.2, then i installed (make install)
xenomai
>> user-space into /opt/eldk-4.2/ppc_4xx .
>>
>> Now when i try to build the xenomai examples with
>>
>> $ make XENO=3D/opt/eldk-4.2/usr/xenomai-2.5.6/bin
>>
>> It uses /lib/modules/2.6.32-5-686 from the local kernel, so i used
>>
>> $ make XENO=3D/opt/eldk-4.2/usr/xenomai-2.5.6/bin =
KSRC=3D/usr/src/linux-2.6.36
>=20
> For building kernel space modules you need to specifiy KSRC as well, =
but
> not for user space apps.
>=20
>> But then it returns:
>> make[1]: Entering directory `/usr/src/xenomai-2.5.6/examples/native'
>> powerpc-linux-gcc -I/usr/xenomai-2.5.6/include -D_GNU_SOURCE =
-D_REENTRANT
>> -Wall -pipe -D__XENO__   -L/usr/xenomai-2.5.6/lib -lxenomai -lpthread
>> -lnative -Xlinker -rpath -Xlinker /usr/xenomai-2.5.6/lib
trivial-periodic.c
>> -o trivial-periodic
>> trivial-periodic.c: In function 'main':
>> trivial-periodic.c:72: warning: control reaches end of non-void =
function
>=20
> I think you didn't specify DESTDIR? Or did you install xenomai-2.5.6
> into /usr ? Normally you do:
>=20
>   cd xenomai-2.5.6
>   ./configure --host=3Dpowerpc-linux --prefix=3D/usr/xenomai
>   make
>   export DESTDIR=3D/opt/eldk/ppc_4xx
>   make install
>=20
> You also need the DESTDIR for building your apps.
>=20
>> When i now use trivial-periodic on the 405GP cpu, it also returns: =
illegal
>> instruction
>>
>> When i try to build the hello_world app with your command it returns:
>>
>> powerpc-linux-gcc -o test test.c
>> 'XENO=3D/opt/eldk-4.2/ppc_4xx/usr/xenomai-2.5.6/bin/xeno-config =
--skin
native
>> --cflags --ldflags' -lrtdk
>> powerpc-linux-gcc:
>> XENO=3D/opt/eldk-4.2/ppc_4xx/usr/xenomai-2.5.6/bin/xeno-config --skin =
native
>> --cflags --ldflags: No such file or directory
>>
>> Why is xenomai using local /lib/modules/2.6.32-5-686 directory ? what =
do i
>> wrong with xenomai userspace part ?
>=20
> See above? Hope it helps.

Just to be sure. The installed Xenomai programs from the test suite like
"latency" or "cyclictest" do work fine, right?

Wolfgang.

-------------------------------------------------------------------------=
---------------------------------------------------
Omicron NanoTechnology GmbH
Limburger Str. 75
65232 Taunusstein, GERMANY=20
Registration: HRB Nr.: 16116, Amtsgericht Wiesbaden, VAT no. DE111361420
Gesch=E4ftsf=FChrer / Managing Director: Norbert Nold               =
www.omicron.de=20


