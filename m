Message-ID: <48F49540.3060507@domain.hid>
Date: Tue, 14 Oct 2008 14:49:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3C3E4.4020801@domain.hid>
	<48F45847.3030704@domain.hid>	<48F461A6.6010600@domain.hid>
	<48F4634B.3030002@domain.hid>	<48F465DD.6020505@domain.hid>
	<48F46954.6050704@domain.hid> <48F473A2.1050104@domain.hid>
	<48F48E2E.2050004@domain.hid>
In-Reply-To: <48F48E2E.2050004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __thread instead of pthread_get/setspecific
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

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> It will always remain orders of magnitude heavier than __thread
>>>> variables which are a) inlined and b) should only need two memory
>>>> accesses at worst. Moreover, it is clearly the future, while the
>>>> importance of pthread_getspecific will decrease over the time. The
>>>> __thread storage class is C99 standard (though its implementation
>>>> remains a separate topic).
>>> You are exagerating a bit: pthread_getspecific is pretty efficient
>>> already (from the few things that I have timed on ARM, it is the only
>>> one which takes under the microsecond). That you will gain something
>>> with __thread is not guaranteed by the C99 standard either: in fact the
>>> implementation could use exactly the same functions.
>> As long as we do not loose anything (performance or portability),
> 
> You loose portability. But I agree that we do not care much.

The fallback remains - must remain in order to obtain true optimization
from the TLS-based version without locking out some corner-case usage.
Find a proposal below (on top of handle-based xeno_get_current).

We have to set initial-exec as TLS model, otherwise we end up with a
dynamic lookup similar (maybe still faster, dunno) to the pthread
service. This model requires start-time linking, will not work with
dlopen (I strongly assume the linker will bail out). But I consider
runtime loading of Xenomai libs as a uncommon corner case, and the user
can still re-enable it via --without-__thread.

Jan

---
 configure.in                       |   23 +++++++++++++++++++
 include/asm-generic/bits/bind.h    |   44 ++++++++++++++++++++++++++-----------
 include/asm-generic/bits/current.h |   13 +++++++++-
 3 files changed, 66 insertions(+), 14 deletions(-)

Index: b/configure.in
===================================================================
--- a/configure.in
+++ b/configure.in
@@ -762,6 +762,29 @@ LIBS="$LIBS -lrt"
 AC_CHECK_FUNCS([shm_open shm_unlink])
 LIBS="$save_LIBS"
 
+AC_ARG_WITH([__thread],
+	    AC_HELP_STRING([--without-__thread],
+			   [do not use TLS features (allows for dlopen'ing Xenomai libs)]),
+	    [use__thread=$withval],
+	    [use__thread=yes])
+
+dnl Check whether the compiler supports the __thread keyword.
+if test "x$use__thread" != xno; then
+	AC_CACHE_CHECK([for __thread], libc_cv_gcc___thread,
+	[cat > conftest.c <<\EOF
+__thread int a __attribute__ ((tls_model ("initial-exec"))) = 42;
+EOF
+	if AC_TRY_COMMAND([${CC-cc} $CFLAGS $CPPFLAGS -c conftest.c >&AS_MESSAGE_LOG_FD]); then
+		libc_cv_gcc___thread=yes
+	else
+		libc_cv_gcc___thread=no
+	fi
+	rm -f conftest*])
+	if test "$libc_cv_gcc___thread" = yes; then
+		AC_DEFINE(HAVE___THREAD,1,[config])
+	fi
+fi
+
 dnl
 dnl Build the Makefiles
 dnl
Index: b/include/asm-generic/bits/bind.h
===================================================================
--- a/include/asm-generic/bits/bind.h
+++ b/include/asm-generic/bits/bind.h
@@ -11,26 +11,26 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <nucleus/types.h>
 #include <asm/xenomai/syscall.h>
 
+#ifdef HAVE___THREAD
+__thread xnhandle_t xeno_current __attribute__ ((tls_model ("initial-exec"))) =
+	XN_NO_HANDLE;
+
+static inline void __xeno_set_current(xnhandle_t current)
+{
+	xeno_current = current;
+}
+#else /* !HAVE___THREAD */
 __attribute__ ((weak))
 pthread_key_t xeno_current_key;
 __attribute__ ((weak))
 pthread_once_t xeno_init_current_key_once = PTHREAD_ONCE_INIT;
 
-__attribute__ ((weak))
-void xeno_set_current(void)
+static inline void __xeno_set_current(xnhandle_t current)
 {
-	void *kthread_cb;
-	int err;
-
-	err = XENOMAI_SYSCALL1(__xn_sys_current, &kthread_cb);
-	if (err) {
-		fprintf(stderr, "Xenomai: error obtaining handle for current "
-			"thread: %s\n", strerror(err));
-		exit(1);
-	}
-	pthread_setspecific(xeno_current_key, kthread_cb);
+	pthread_setspecific(xeno_current_key, (void *)current);
 }
 
 static void init_current_key(void)
@@ -42,6 +42,22 @@ static void init_current_key(void)
 		exit(1);
 	}
 }
+#endif /* !HAVE___THREAD */
+
+__attribute__ ((weak))
+void xeno_set_current(void)
+{
+	xnhandle_t current;
+	int err;
+
+	err = XENOMAI_SYSCALL1(__xn_sys_current, &current);
+	if (err) {
+		fprintf(stderr, "Xenomai: error obtaining handle for current "
+			"thread: %s\n", strerror(err));
+		exit(1);
+	}
+	__xeno_set_current(current);
+}
 
 #ifdef CONFIG_XENO_FASTSYNCH
 __attribute__ ((weak))
@@ -175,7 +191,9 @@ xeno_bind_skin(unsigned skin_magic, cons
 	sa.sa_flags = 0;
 	sigaction(SIGXCPU, &sa, NULL);
 
+#ifndef HAVE___THREAD
 	pthread_once(&xeno_init_current_key_once, &init_current_key);
+#endif /* !HAVE___THREAD */
 
 #ifdef CONFIG_XENO_FASTSYNCH
 	/* In case we forked, we need to map the new local semaphore heap */
@@ -251,7 +269,9 @@ xeno_bind_skin_opt(unsigned skin_magic,
 	xeno_arch_features_check();
 #endif /* xeno_arch_features_check */
 
+#ifndef HAVE___THREAD
 	pthread_once(&xeno_init_current_key_once, &init_current_key);
+#endif /* !HAVE___THREAD */
 
 #ifdef CONFIG_XENO_FASTSYNCH
 	/* In case we forked, we need to map the new local semaphore heap */
Index: b/include/asm-generic/bits/current.h
===================================================================
--- a/include/asm-generic/bits/current.h
+++ b/include/asm-generic/bits/current.h
@@ -4,13 +4,22 @@
 #include <pthread.h>
 #include <nucleus/types.h>
 
-extern pthread_key_t xeno_current_key;
+#ifdef HAVE___THREAD
+extern __thread xnhandle_t xeno_current __attribute__ ((tls_model ("initial-exec")));
 
-extern void xeno_set_current(void);
+static inline xnhandle_t xeno_get_current(void)
+{
+	return xeno_current;
+}
+#else /* ! HAVE___THREAD */
+extern pthread_key_t xeno_current_key;
 
 static inline xnhandle_t xeno_get_current(void)
 {
 	return (xnhandle_t)pthread_getspecific(xeno_current_key);
 }
+#endif /* ! HAVE___THREAD */
+
+extern void xeno_set_current(void);
 
 #endif /* _XENO_ASM_GENERIC_CURRENT_H */

