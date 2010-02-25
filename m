Message-ID: <4B86FCBB.10203@domain.hid>
Date: Thu, 25 Feb 2010 23:42:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>
	<4B86EDC2.7010905@domain.hid>
In-Reply-To: <4B86EDC2.7010905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig72A66244F388DD99C86225F9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72A66244F388DD99C86225F9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Charlton, John wrote:
>> I have a xenomai application that runs without problems with xenomai-2=
=2E4.6.1/linux-2.6.27.7. When run under xenomai-2.5.1/linux-2.6.32.7 it f=
ails with the warning: Xenomai: process memory not locked (missing mlocka=
ll?).  I verified that mlockall() is being called before any xenomai call=
s are made as follows with out error:
>>
>=20
> I'm afraid that warning is misleading.

And this should fix the error reporting (without any signal handler
installed, your application will still terminate, though):

------>

From: Jan Kiszka <jan.kiszka@domain.hid>

Avoid false error reports of xeno_handle_mlock_alert

We already propagate the SIGDEBUG reason to user space. Use it to tell
SIGDEBUG_NOMLOCK apart from other triggers of this signal, e.g. the
watchdog. This also allows to drop xeno_sigxcpu_no_mlock.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/bits/bind.h        |    6 +++---
 include/asm-generic/bits/mlock_alert.h |    7 ++-----
 src/skins/native/task.c                |   15 ---------------
 src/skins/posix/thread.c               |    9 ---------
 4 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/include/asm-generic/bits/bind.h b/include/asm-generic/bits/b=
ind.h
index 7267e0d..1aeffb5 100644
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -9,7 +9,7 @@ union xnsiginfo;
=20
 typedef void xnsighandler(union xnsiginfo *si);
=20
-void xeno_handle_mlock_alert(int sig);
+void xeno_handle_mlock_alert(int sig, siginfo_t *si, void *context);
=20
 int=20
 xeno_bind_skin_opt(unsigned skin_magic, const char *skin,=20
@@ -29,9 +29,9 @@ xeno_bind_skin(unsigned skin_magic, const char *skin,
 		exit(EXIT_FAILURE);
 	}
=20
-	sa.sa_handler =3D &xeno_handle_mlock_alert;
+	sa.sa_sigaction =3D xeno_handle_mlock_alert;
 	sigemptyset(&sa.sa_mask);
-	sa.sa_flags =3D 0;
+	sa.sa_flags =3D SA_SIGINFO;
 	sigaction(SIGXCPU, &sa, NULL);
=20
 	return muxid;
diff --git a/include/asm-generic/bits/mlock_alert.h b/include/asm-generic=
/bits/mlock_alert.h
index 6c7217d..eded3c1 100644
--- a/include/asm-generic/bits/mlock_alert.h
+++ b/include/asm-generic/bits/mlock_alert.h
@@ -6,15 +6,12 @@
 #include <signal.h>
 #include <pthread.h>
=20
-__attribute__ ((weak))
-int xeno_sigxcpu_no_mlock =3D 1;
-
 __attribute__ ((weak, visibility ("internal")))
-void xeno_handle_mlock_alert(int sig)
+void xeno_handle_mlock_alert(int sig, siginfo_t *si, void *context)
 {
 	struct sigaction sa;
=20
-	if (xeno_sigxcpu_no_mlock) {
+	if (si->si_value.sival_int =3D=3D SIGDEBUG_NOMLOCK) {
 		fprintf(stderr, "Xenomai: process memory not locked "
 			"(missing mlockall?)\n");
 		fflush(stderr);
diff --git a/src/skins/native/task.c b/src/skins/native/task.c
index ba04a27..6312f2f 100644
--- a/src/skins/native/task.c
+++ b/src/skins/native/task.c
@@ -41,7 +41,6 @@ extern pthread_key_t __native_tskey;
 #endif /* !HAVE___THREAD */
=20
 extern int __native_muxid;
-extern int xeno_sigxcpu_no_mlock;
=20
 /* Public Xenomai interface. */
=20
@@ -97,9 +96,6 @@ static void *rt_task_trampoline(void *cookie)
=20
 	xeno_set_current();
=20
-	if (iargs->mode & T_WARNSW)
-		xeno_sigxcpu_no_mlock =3D 0;
-
 	/* Wait on the barrier for the task to be started. The barrier
 	   could be released in order to process Linux signals while the
 	   Xenomai shadow is still dormant; in such a case, resume wait. */
@@ -231,9 +227,6 @@ int rt_task_shadow(RT_TASK *task, const char *name, i=
nt prio, int mode)
=20
 	xeno_set_current();
=20
-	if (mode & T_WARNSW)
-		xeno_sigxcpu_no_mlock =3D 0;
-
 	return 0;
=20
   fail:
@@ -347,14 +340,6 @@ int rt_task_set_mode(int clrmask, int setmask, int *=
oldmode)
 				__native_task_set_mode, clrmask, setmask,
 				oldmode);
=20
-	/* Silently deactivate our internal handler for SIGXCPU. At that
-	   point, we know that the process memory has been properly
-	   locked, otherwise we would have caught the latter signal upon
-	   thread creation. */
-
-	if (!err && xeno_sigxcpu_no_mlock)
-		xeno_sigxcpu_no_mlock =3D !(setmask & T_WARNSW);
-
 	return err;
 }
=20
diff --git a/src/skins/posix/thread.c b/src/skins/posix/thread.c
index d565d52..8084a20 100644
--- a/src/skins/posix/thread.c
+++ b/src/skins/posix/thread.c
@@ -330,20 +330,11 @@ int pthread_wait_np(unsigned long *overruns_r)
=20
 int pthread_set_mode_np(int clrmask, int setmask)
 {
-	extern int xeno_sigxcpu_no_mlock;
 	int err;
=20
 	err =3D -XENOMAI_SKINCALL2(__pse51_muxid,
 				 __pse51_thread_set_mode, clrmask, setmask);
=20
-	/* Silently deactivate our internal handler for SIGXCPU. At that
-	   point, we know that the process memory has been properly
-	   locked, otherwise we would have caught the latter signal upon
-	   thread creation. */
-
-	if (!err && xeno_sigxcpu_no_mlock)
-		xeno_sigxcpu_no_mlock =3D !(setmask & PTHREAD_WARNSW);
-
 	return err;
 }
=20
--=20
1.6.0.2


--------------enig72A66244F388DD99C86225F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuG/L8ACgkQitSsb3rl5xRygwCg5He0Bb67q2GdBAkn/V+E4a6g
Z1gAn33mQR6rwJ1NiqfPQVxgsROYrQKW
=zRF7
-----END PGP SIGNATURE-----

--------------enig72A66244F388DD99C86225F9--

