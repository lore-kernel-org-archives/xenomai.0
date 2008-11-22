Message-ID: <4927FE13.50808@domain.hid>
Date: Sat, 22 Nov 2008 13:41:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4926E9C5.9020506@domain.hid> <492700CD.2050300@domain.hid>
In-Reply-To: <492700CD.2050300@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE60ADCA0E542E0AFF784FCED"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Refactor management of auto-shadowing,
	TLS and dlopen
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE60ADCA0E542E0AFF784FCED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> +#ifndef CONFIG_XENO_POSIX_AUTO_MLOCKALL
>>  	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
>>  		perror("Xenomai Posix skin init: mlockall");
>>  		exit(EXIT_FAILURE);
>>  	}
>=20
> Errr... I do not get it, the mlockall should take place if AUTO_MLOCKAL=
L
> is set, no ?

Typo. Noticed it before posting, but I forgot to include the refreshed
patch.

>=20
> +		struct sched_param parm =3D { .sched_priority =3D 0 };
>=20
> I do not like the everything-on-one-line style. And are we sure this
> will work if sched_priority is a macro ?

If parm.sched_priority can be referenced (and that's what the spec
requires), the above works as well, even if sched_priority resolves to
something like "__hidden_struct.__prio".

Regarding detection of denied dlopen: The 'nodlopen' marker my other
patch introduces will give an error message like "libpthread_rt.so.1:
shared object cannot be dlopen()ed" - if the caller is clever enough to
use dlerror. We can't configure that message (it linker generated), all
we could do is to add a few words about it to the TROUBLESHOOTING guide.

Jan

---
 ChangeLog              |    6 ++++++
 configure.in           |   19 +++++++++++++------
 src/skins/posix/init.c |   45 +++++++++++++++++++++++++++++-------------=
---
 3 files changed, 48 insertions(+), 22 deletions(-)

Index: xenomai/configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/configure.in
+++ xenomai/configure.in
@@ -763,14 +763,21 @@ AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS=3D"$save_LIBS"
=20
 XENO_DLOPEN_CONSTRAINT=3D
-AC_ARG_WITH([__thread],
-	    AC_HELP_STRING([--without-__thread],
-			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
-	    [use__thread=3D$withval],
-	    [use__thread=3Dyes])
+AC_MSG_CHECKING(whether to enable dlopen support for skin libraries)
+AC_ARG_ENABLE(dlopen-skins,
+	AC_HELP_STRING([--enable-dlopen-skins], [Disable TLS features and autom=
atic
+main thread mapping by the POSIX skin to allows dlopen'ing Xenomai libs.=
]),
+	[case "$enableval" in
+	y | yes) CONFIG_XENO_LIBS_DLOPEN=3Dy ;;
+	*) unset CONFIG_XENO_LIBS_DLOPEN ;;
+	esac])
+AC_MSG_RESULT(${CONFIG_XENO_LIBS_DLOPEN:-no})
+if test x$CONFIG_XENO_LIBS_DLOPEN =3D xy; then
+	AC_DEFINE(CONFIG_XENO_LIBS_DLOPEN,1,[config])
+fi
=20
 dnl Check whether the compiler supports the __thread keyword.
-if test "x$use__thread" !=3D xno; then
+if test "x$CONFIG_XENO_LIBS_DLOPEN" !=3D xy; then
 	AC_CACHE_CHECK([for __thread], libc_cv_gcc___thread,
 	[cat > conftest.c <<\EOF
 __thread int a __attribute__ ((tls_model ("initial-exec"))) =3D 42;
Index: xenomai/src/skins/posix/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/init.c
+++ xenomai/src/skins/posix/init.c
@@ -47,7 +47,6 @@ void pse51_clock_init(int);
 static __attribute__ ((constructor))
 void __init_posix_interface(void)
 {
-	struct sched_param parm;
 	int muxid, err;
=20
 	muxid =3D
@@ -67,28 +66,42 @@ void __init_posix_interface(void)
 								 __rtdm_fdcount);
 	}
=20
-	/* Shadow the main thread. mlock the whole memory for the time of the
-	   syscall, in order to avoid the SIGXCPU signal. */
+#ifdef CONFIG_XENO_LIBS_DLOPEN
+	/* Don't use auto-shadowing if we are likely invoked from dlopen, but
+	   take care of auto-mlockall. */
+#ifdef CONFIG_XENO_POSIX_AUTO_MLOCKALL
 	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
 		perror("Xenomai Posix skin init: mlockall");
 		exit(EXIT_FAILURE);
 	}
-
-	parm.sched_priority =3D 0;
-	err =3D __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,
-					   &parm);
-	if (err) {
-		fprintf(stderr, "Xenomai Posix skin init: "
-			"pthread_setschedparam: %s\n", strerror(err));
-		exit(EXIT_FAILURE);
-	}
+#endif /* CONFIG_XENO_POSIX_AUTO_MLOCKALL */
+#else /* !CONFIG_XENO_LIBS_DLOPEN */
+	{
+		struct sched_param parm =3D { .sched_priority =3D 0 };
+
+		/* Shadow the main thread. mlock the whole memory for the time
+		   of the syscall, in order to avoid the SIGXCPU signal. */
+		if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
+			perror("Xenomai Posix skin init: mlockall");
+			exit(EXIT_FAILURE);
+		}
+
+		err =3D __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,
+						   &parm);
+		if (err) {
+			fprintf(stderr, "Xenomai Posix skin init: "
+				"pthread_setschedparam: %s\n", strerror(err));
+			exit(EXIT_FAILURE);
+		}
=20
 #ifndef CONFIG_XENO_POSIX_AUTO_MLOCKALL
-	if (munlockall()) {
-		perror("Xenomai Posix skin init: munlockall");
-		exit(EXIT_FAILURE);
-	}
+		if (munlockall()) {
+			perror("Xenomai Posix skin init: munlockall");
+			exit(EXIT_FAILURE);
+		}
 #endif /* !CONFIG_XENO_POSIX_AUTO_MLOCKALL */
+	}
+#endif /* !CONFIG_XENO_LIBS_DLOPEN */
=20
 	if (!fork_handler_registered) {
 		err =3D pthread_atfork(NULL, NULL, &__init_posix_interface);
Index: xenomai/ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -1,5 +1,11 @@
 2008-11-21  Jan Kiszka  <jan.kiszka@domain.hid>
=20
+	* configure.in: Convert --without-__thread into
+	--enable-dlopen-skins.
+
+	* src/skins/posix/init.c: Don't perform auto-shadowing if we may
+	be loaded via dlopen.
+
 	* configure.in, src/skins/*/Makefile.am: Mark libs with nodlopen
 	if initial-exec __thread variables are used.
=20


--------------enigE60ADCA0E542E0AFF784FCED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkkn/hcACgkQniDOoMHTA+lwaACZATS7yktyr3IeWDhuUrvlw3co
u4IAn3zWkslHpHPNo8bA1EaBVDFhJ7jl
=PMHq
-----END PGP SIGNATURE-----

--------------enigE60ADCA0E542E0AFF784FCED--

