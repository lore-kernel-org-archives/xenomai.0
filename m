Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 May 2007 15:15:25 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>, xenomai@xenomai.org

Perrine Martignoni wrote:
> Sorry for the details.
> I work on an ARM and I use the cross compiler ELDK version 4.1 (build =
: 2007-01-22-uclibc).
>
>When I compile sources of xenomai, I have this error message :=20
>
> -Wl,shm_unlink -Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap =
cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.a =
-lpthread -lrt=20
../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In =
function `__wrap_shm_open':
shm.c:(.text+0x74): undefined reference to `shm_open'
../../skins/posix/.libs/libpthread_rt.a(libpthread_rt_la-shm.o): In =
function `__wrap_shm_unlink':
shm.c:(.text+0xdc): undefined reference to `shm_unlink'
collect2: ld returned 1 exit status
make[3]: *** [cyclictest] Erreur 1
make[3]: Leaving directory `/usr/src/xenomai-2.3.1/src/testsuite/cyclic'
make[2]: *** [all-recursive] Erreur 1
make[2]: Leaving directory `/usr/src/xenomai-2.3.1/src/testsuite'
make[1]: *** [all-recursive] Erreur 1
make[1]: Leaving directory `/usr/src/xenomai-2.3.1/src'
make: *** [all-recursive] Erreur 1

Fixed by this patch:
https://mail.gna.org/public/xenomai-core/2007-03/msg00104.html

You may also need this patch:

--- skins/native/task.c 20 Mar 2007 08:16:41 -0000      1.1.1.1
+++ skins/native/task.c 28 Mar 2007 13:53:03 -0000      1.2
@@ -135,7 +135,12 @@
        pthread_attr_setstacksize(&thattr, stksize);
        if (!(mode & T_JOINABLE))
                pthread_attr_setdetachstate(&thattr, =
PTHREAD_CREATE_DETACHED);
-       if (prio > 0) {
+       /* There's a limitation in libpthread
+        * that returns EPERM upon SCHED_FIFO
+        * for non priviledged users.
+        * So workaround this for now. FIXME (in uClibc/pthread).
+        */
+       if (prio > 0 && geteuid() =3D=3D 0) {
                pthread_attr_setschedpolicy(&thattr, SCHED_FIFO);
                param.sched_priority =3D =
sched_get_priority_max(SCHED_FIFO);
        }

--=20
Stephane

