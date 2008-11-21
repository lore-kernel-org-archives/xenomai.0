Message-ID: <4926E9C5.9020506@domain.hid>
Date: Fri, 21 Nov 2008 18:03:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Refactor management of auto-shadowing,
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
To: xenomai-core <xenomai@xenomai.org>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

This patch implements my suggestion to replace configures's
--without-__thread switch with a more focused one: --enable-dlopen-skins
When enabled, initial-exec TLS support is turned off as well as
auto-shadowing done by the POSIX skin lib. This avoids bad interaction
with the context of dlopen and the already running process in general,
while also clarifying the actual choice here.

Jan

PS: Patch might be best applied in two steps, but I was too lazy to
split up now.

---
 ChangeLog              |    6 ++++++
 configure.in           |   19 +++++++++++++------
 src/skins/posix/init.c |   45 +++++++++++++++++++++++++++++----------------
 3 files changed, 48 insertions(+), 22 deletions(-)

Index: xenomai/configure.in
===================================================================
--- xenomai.orig/configure.in
+++ xenomai/configure.in
@@ -763,14 +763,21 @@ AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS="$save_LIBS"
 
 XENO_DLOPEN_CONSTRAINT=
-AC_ARG_WITH([__thread],
-	    AC_HELP_STRING([--without-__thread],
-			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
-	    [use__thread=$withval],
-	    [use__thread=yes])
+AC_MSG_CHECKING(whether to enable dlopen support for skin libraries)
+AC_ARG_ENABLE(dlopen-skins,
+	AC_HELP_STRING([--enable-dlopen-skins], [Disable TLS features and automatic
+main thread mapping by the POSIX skin to allows dlopen'ing Xenomai libs.]),
+	[case "$enableval" in
+	y | yes) CONFIG_XENO_LIBS_DLOPEN=y ;;
+	*) unset CONFIG_XENO_LIBS_DLOPEN ;;
+	esac])
+AC_MSG_RESULT(${CONFIG_XENO_LIBS_DLOPEN:-no})
+if test x$CONFIG_XENO_LIBS_DLOPEN = xy; then
+	AC_DEFINE(CONFIG_XENO_LIBS_DLOPEN,1,[config])
+fi
 
 dnl Check whether the compiler supports the __thread keyword.
-if test "x$use__thread" != xno; then
+if test "x$CONFIG_XENO_LIBS_DLOPEN" != xy; then
 	AC_CACHE_CHECK([for __thread], libc_cv_gcc___thread,
 	[cat > conftest.c <<\EOF
 __thread int a __attribute__ ((tls_model ("initial-exec"))) = 42;
Index: xenomai/src/skins/posix/init.c
===================================================================
--- xenomai.orig/src/skins/posix/init.c
+++ xenomai/src/skins/posix/init.c
@@ -47,7 +47,6 @@ void pse51_clock_init(int);
 static __attribute__ ((constructor))
 void __init_posix_interface(void)
 {
-	struct sched_param parm;
 	int muxid, err;
 
 	muxid =
@@ -67,28 +66,42 @@ void __init_posix_interface(void)
 								 __rtdm_fdcount);
 	}
 
-	/* Shadow the main thread. mlock the whole memory for the time of the
-	   syscall, in order to avoid the SIGXCPU signal. */
+#ifdef CONFIG_XENO_LIBS_DLOPEN
+	/* Don't use auto-shadowing if we are likely invoked from dlopen, but
+	   take care of auto-mlockall. */
+#ifndef CONFIG_XENO_POSIX_AUTO_MLOCKALL
 	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
 		perror("Xenomai Posix skin init: mlockall");
 		exit(EXIT_FAILURE);
 	}
-
-	parm.sched_priority = 0;
-	err = __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,
-					   &parm);
-	if (err) {
-		fprintf(stderr, "Xenomai Posix skin init: "
-			"pthread_setschedparam: %s\n", strerror(err));
-		exit(EXIT_FAILURE);
-	}
+#endif /* !CONFIG_XENO_POSIX_AUTO_MLOCKALL */
+#else /* !CONFIG_XENO_LIBS_DLOPEN */
+	{
+		struct sched_param parm = { .sched_priority = 0 };
+
+		/* Shadow the main thread. mlock the whole memory for the time
+		   of the syscall, in order to avoid the SIGXCPU signal. */
+		if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
+			perror("Xenomai Posix skin init: mlockall");
+			exit(EXIT_FAILURE);
+		}
+
+		err = __wrap_pthread_setschedparam(pthread_self(), SCHED_OTHER,
+						   &parm);
+		if (err) {
+			fprintf(stderr, "Xenomai Posix skin init: "
+				"pthread_setschedparam: %s\n", strerror(err));
+			exit(EXIT_FAILURE);
+		}
 
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
 
 	if (!fork_handler_registered) {
 		err = pthread_atfork(NULL, NULL, &__init_posix_interface);
Index: xenomai/ChangeLog
===================================================================
--- xenomai.orig/ChangeLog
+++ xenomai/ChangeLog
@@ -1,5 +1,11 @@
 2008-11-21  Jan Kiszka  <jan.kiszka@domain.hid>
 
+	* configure.in: Convert --without-__thread into
+	--enable-dlopen-skins.
+
+	* src/skins/posix/init.c: Don't perform auto-shadowing if we may
+	be loaded via dlopen.
+
 	* configure.in, src/skins/*/Makefile.am: Mark libs with nodlopen
 	if initial-exec __thread variables are used.
 
-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

