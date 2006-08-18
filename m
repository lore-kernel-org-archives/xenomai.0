Message-ID: <44E5ACFA.50905@domain.hid>
Date: Fri, 18 Aug 2006 14:05:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig330FD6DD62F50BC8469B5E42"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] speed up building of posix apps
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig330FD6DD62F50BC8469B5E42
Content-Type: multipart/mixed; boundary="------------010707030602070806000307"

This is a multi-part message in MIME format.
--------------010707030602070806000307
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

with the growing number of wrapped posix applications also their fairly
slow build process became visible. It somehow scaled badly.

I had the idea to pass all wrapping commands to the linker via a file
for quite some time. Now I tried it and it gives a nice speedup of
roughly 400% for me when building typical single-file apps (mileage may
vary, I'm building on vmware box...). Moreover, it beautifies the
compiler output.

Tested on various setups, no regressions known so far.

Jan


PS: What about the silence-libtool patch? I've heard neither ack nor
nack so far.

--------------010707030602070806000307
Content-Type: text/plain;
 name="wrapping-speedup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="wrapping-speedup.patch"

Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in	(revision 1453)
+++ configure.in	(working copy)
@@ -525,8 +525,7 @@ XENO_USER_APP_CFLAGS=3D$XENO_USER_CFLAGS
 XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS -D__IN_XENO__ -Wstrict-prototypes"=

 XENO_USER_APP_LDFLAGS=3D$XENO_USER_LDFLAGS
=20
-XENO_POSIX_WRAPPERS=3D`while read symbol; do echo -n "-Wl,--wrap,$symbol=
 "; done \
-        < $srcdir/src/skins/posix/posix.wrappers`
+XENO_POSIX_WRAPPERS=3D"-Wl,@`cd $srcdir && pwd`/src/skins/posix/posix.wr=
appers"
=20
 AC_MSG_CHECKING(whether POSIX skin library automatically calls mlockall)=

 AC_ARG_ENABLE(posix-auto-mlockall,
Index: src/skins/posix/posix.wrappers
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/posix.wrappers	(revision 1453)
+++ src/skins/posix/posix.wrappers	(working copy)
@@ -1,89 +1,89 @@
-pthread_create
-pthread_detach
-pthread_setschedparam
-pthread_getschedparam
-pthread_yield
-sched_yield
-sem_init
-sem_destroy
-sem_post
-sem_timedwait
-sem_wait
-sem_trywait
-sem_getvalue
-sem_open
-sem_close
-sem_unlink
-clock_getres
-clock_gettime
-clock_settime
-clock_nanosleep
-nanosleep
-pthread_mutexattr_init
-pthread_mutexattr_destroy
-pthread_mutexattr_gettype
-pthread_mutexattr_settype
-pthread_mutexattr_getprotocol
-pthread_mutexattr_setprotocol
-pthread_mutexattr_getpshared
-pthread_mutexattr_setpshared
-pthread_mutex_init
-pthread_mutex_destroy
-pthread_mutex_lock
-pthread_mutex_trylock
-pthread_mutex_timedlock
-pthread_mutex_unlock
-pthread_condattr_init
-pthread_condattr_destroy
-pthread_condattr_getclock
-pthread_condattr_setclock
-pthread_condattr_getpshared
-pthread_condattr_setpshared
-pthread_cond_init
-pthread_cond_destroy
-pthread_cond_wait
-pthread_cond_timedwait
-pthread_cond_signal
-pthread_cond_broadcast
-mq_open
-mq_close
-mq_unlink
-mq_getattr
-mq_setattr
-mq_send
-mq_timedsend
-mq_receive
-mq_timedreceive
-mq_notify
-open
-socket
-close
-ioctl
-read
-write
-recvmsg
-sendmsg
-recvfrom
-sendto
-recv
-send
-getsockopt
-setsockopt
-bind
-connect
-listen
-accept
-getsockname
-getpeername
-shutdown
-timer_create
-timer_delete
-timer_settime
-timer_getoverrun
-timer_gettime
-ftruncate
-close
-shm_open
-shm_unlink
-mmap
-munmap
+--wrap pthread_create
+--wrap pthread_detach
+--wrap pthread_setschedparam
+--wrap pthread_getschedparam
+--wrap pthread_yield
+--wrap sched_yield
+--wrap sem_init
+--wrap sem_destroy
+--wrap sem_post
+--wrap sem_timedwait
+--wrap sem_wait
+--wrap sem_trywait
+--wrap sem_getvalue
+--wrap sem_open
+--wrap sem_close
+--wrap sem_unlink
+--wrap clock_getres
+--wrap clock_gettime
+--wrap clock_settime
+--wrap clock_nanosleep
+--wrap nanosleep
+--wrap pthread_mutexattr_init
+--wrap pthread_mutexattr_destroy
+--wrap pthread_mutexattr_gettype
+--wrap pthread_mutexattr_settype
+--wrap pthread_mutexattr_getprotocol
+--wrap pthread_mutexattr_setprotocol
+--wrap pthread_mutexattr_getpshared
+--wrap pthread_mutexattr_setpshared
+--wrap pthread_mutex_init
+--wrap pthread_mutex_destroy
+--wrap pthread_mutex_lock
+--wrap pthread_mutex_trylock
+--wrap pthread_mutex_timedlock
+--wrap pthread_mutex_unlock
+--wrap pthread_condattr_init
+--wrap pthread_condattr_destroy
+--wrap pthread_condattr_getclock
+--wrap pthread_condattr_setclock
+--wrap pthread_condattr_getpshared
+--wrap pthread_condattr_setpshared
+--wrap pthread_cond_init
+--wrap pthread_cond_destroy
+--wrap pthread_cond_wait
+--wrap pthread_cond_timedwait
+--wrap pthread_cond_signal
+--wrap pthread_cond_broadcast
+--wrap mq_open
+--wrap mq_close
+--wrap mq_unlink
+--wrap mq_getattr
+--wrap mq_setattr
+--wrap mq_send
+--wrap mq_timedsend
+--wrap mq_receive
+--wrap mq_timedreceive
+--wrap mq_notify
+--wrap open
+--wrap socket
+--wrap close
+--wrap ioctl
+--wrap read
+--wrap write
+--wrap recvmsg
+--wrap sendmsg
+--wrap recvfrom
+--wrap sendto
+--wrap recv
+--wrap send
+--wrap getsockopt
+--wrap setsockopt
+--wrap bind
+--wrap connect
+--wrap listen
+--wrap accept
+--wrap getsockname
+--wrap getpeername
+--wrap shutdown
+--wrap timer_create
+--wrap timer_delete
+--wrap timer_settime
+--wrap timer_getoverrun
+--wrap timer_gettime
+--wrap ftruncate
+--wrap close
+--wrap shm_open
+--wrap shm_unlink
+--wrap mmap
+--wrap munmap
Index: scripts/xeno-config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/xeno-config.in	(revision 1453)
+++ scripts/xeno-config.in	(working copy)
@@ -89,14 +89,10 @@ while test $# -gt 0; do
             ;;
         --posix-ldflags)
             if test \! -r $XENO_POSIX_WRAPPERS; then
-	       echo "POSIX support is not available" >&2
-	       exit 1
-	    fi
-	    wrappers=3D`cat $XENO_POSIX_WRAPPERS | \
-	    while read symbol; do \
-                echo -n "-Wl,--wrap,$symbol " ; \
-	     done`
-            echo "$wrappers $XENO_POSIX_LDFLAGS"
+               echo "POSIX support is not available" >&2
+               exit 1
+            fi
+            echo "-Wl,@$XENO_POSIX_WRAPPERS $XENO_POSIX_LDFLAGS"
             ;;
         --lib*-dir|--libdir|--user-libdir)
             echo $XENO_LIBRARY_DIR
Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(revision 1453)
+++ ChangeLog	(working copy)
@@ -1,7 +1,14 @@
+2006-08-18  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* src/skins/posix/posix.wrappers, configure.in,
+	scripts/xeno-config.in: Read wrapping options from file instead of
+	passing them via command line.
+
 2006-08-16  Sebastian Smolorz  <Sebastian.Smolorz@domain.hid>
=20
 	* include/rtdm/rtcan.h, ksrc/drivers/can/rtcan_{module,socket,raw}.c:
-	Get rid of RTCAN_TIMEOUT_* defines and replace them with RTDM_TIMEOUT_*=

+	Get rid of RTCAN_TIMEOUT_* defines and replace them with
+	RTDM_TIMEOUT_*.
=20
 2006-08-16  Jan Kiszka  <jan.kiszka@domain.hid>
=20
@@ -36,8 +43,8 @@
=20
 2006-08-12  Ulrich Schwab  <schwab@domain.hid>
 =20
- 	* ksrc/arch/i386/smi.c added id of Intel ICH7 to list of SMI chipsets
- =09
+	* ksrc/arch/i386/smi.c added id of Intel ICH7 to list of SMI chipsets
+
 2006-08-12  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
=20
 	* ksrc/skins/posix/thread.c (thread_destroy): Do not assume that

--------------010707030602070806000307--

--------------enig330FD6DD62F50BC8469B5E42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5az+niDOoMHTA+kRAkMaAJ4mIlavzTd6SgbUWkPA6VkT6DNYIwCfehEm
BV5LRDDCvBzSW7lQCvtxn5o=
=bTw4
-----END PGP SIGNATURE-----

--------------enig330FD6DD62F50BC8469B5E42--

