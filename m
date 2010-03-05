Message-ID: <4B90ED0A.40101@domain.hid>
Date: Fri, 05 Mar 2010 12:37:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH] Allow for deregistering current mode
	user space address
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This adds __xn_sys_drop_u_mode, a syscall to deregister the u_mode user
space address passed on shadow creation for the current thread. We need
this in order to safely shut down a thread that wants to release its
u_mode memory (either malloc'ed or TLS-allocated). So far, the kernel
might have touched this memory even after the release which caused
subtle corruptions.

After we released u_mode, we can no longer make reliable decisions based
on it. For the fast mutex use case, we then assume the worst case, ie.
we enforce syscall-based acquisitions unconditionally. For the
assert_nrt case, we simply acquire the required information via
__xn_sys_current_info.

---
 include/asm-generic/bits/current.h |   24 ++++++++----
 include/asm-generic/syscall.h      |    1 +
 include/nucleus/thread.h           |    2 +
 ksrc/nucleus/shadow.c              |   14 +++++++
 src/rtdk/assert_context.c          |    9 +++-
 src/skins/common/current.c         |   72 ++++++++++++++++++++++++++++--------
 6 files changed, 95 insertions(+), 27 deletions(-)

diff --git a/include/asm-generic/bits/current.h b/include/asm-generic/bits/current.h
index 0c3166b..f0e569c 100644
--- a/include/asm-generic/bits/current.h
+++ b/include/asm-generic/bits/current.h
@@ -2,7 +2,9 @@
 #define _XENO_ASM_GENERIC_CURRENT_H
 
 #include <pthread.h>
-#include <nucleus/types.h>
+#include <nucleus/thread.h>
+
+extern pthread_key_t xeno_current_mode_key;
 
 #ifdef HAVE___THREAD
 extern __thread xnhandle_t xeno_current __attribute__ ((tls_model ("initial-exec")));
@@ -19,15 +21,13 @@ static inline unsigned long xeno_get_current_mode(void)
 	return xeno_current_mode;
 }
 
-static inline unsigned long *xeno_init_current_mode(void)
+static inline int xeno_primary_mode(void)
 {
-	return &xeno_current_mode;
+	return xeno_current_mode & XNRELAX;
 }
 
-#define xeno_init_current_keys() do { } while (0)
 #else /* ! HAVE___THREAD */
 extern pthread_key_t xeno_current_key;
-extern pthread_key_t xeno_current_mode_key;
 
 static inline xnhandle_t xeno_get_current(void)
 {
@@ -41,14 +41,22 @@ static inline xnhandle_t xeno_get_current(void)
 
 static inline unsigned long xeno_get_current_mode(void)
 {
-	return *(unsigned long *)pthread_getspecific(xeno_current_mode_key);
+	unsigned long *mode = pthread_getspecific(xeno_current_mode_key);
+
+	return mode ? *mode : -1;
 }
 
-unsigned long *xeno_init_current_mode(void);
+static inline int xeno_primary_mode(void)
+{
+	unsigned long *mode = pthread_getspecific(xeno_current_mode_key);
 
-void xeno_init_current_keys(void);
+	return mode ? (*mode & XNRELAX) : 0;
+}
 #endif /* ! HAVE___THREAD */
 
 void xeno_set_current(void);
 
+unsigned long *xeno_init_current_mode(void);
+void xeno_init_current_keys(void);
+
 #endif /* _XENO_ASM_GENERIC_CURRENT_H */
diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 315822e..62f7aa2 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -46,6 +46,7 @@
 #define __xn_sys_current	8	/* threadh = xnthread_handle(cur) */
 #define __xn_sys_current_info	9	/* r = xnshadow_current_info(&info) */
 #define __xn_sys_get_next_sigs 10	/* only unqueue pending signals. */
+#define __xn_sys_drop_u_mode   11	/* stop updating thread->u_mode */
 
 #define XENOMAI_LINUX_DOMAIN  0
 #define XENOMAI_XENO_DOMAIN   1
diff --git a/include/nucleus/thread.h b/include/nucleus/thread.h
index b2baccb..cb772f7 100644
--- a/include/nucleus/thread.h
+++ b/include/nucleus/thread.h
@@ -328,6 +328,8 @@ typedef struct xnthread {
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	unsigned long __user *u_mode;	/* Thread mode variable in userland. */
 
+	unsigned long u_mode_dump;	/* u_mode points here once userland dropped it. */
+
 	unsigned u_sigpending;		/* One bit per skin */
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d82d6c7..8431025 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1967,6 +1967,18 @@ static int xnshadow_sys_get_next_sigs(struct pt_regs *regs)
 	return -EINTR;
 }
 
+static int xnshadow_sys_drop_u_mode(struct pt_regs *regs)
+{
+	xnthread_t *cur = xnshadow_thread(current);
+
+	if (!cur)
+		return -EPERM;
+
+	cur->u_mode = (unsigned long __user*)&cur->u_mode_dump;
+
+	return 0;
+}
+
 static xnsysent_t __systab[] = {
 	[__xn_sys_migrate] = {&xnshadow_sys_migrate, __xn_exec_current},
 	[__xn_sys_arch] = {&xnshadow_sys_arch, __xn_exec_any},
@@ -1981,6 +1993,8 @@ static xnsysent_t __systab[] = {
 		{&xnshadow_sys_current_info, __xn_exec_shadow},
 	[__xn_sys_get_next_sigs] = 
 		{&xnshadow_sys_get_next_sigs, __xn_exec_conforming},
+	[__xn_sys_drop_u_mode] =
+		{&xnshadow_sys_drop_u_mode, __xn_exec_shadow},
 };
 
 static void post_ppd_release(struct xnheap *h)
diff --git a/src/rtdk/assert_context.c b/src/rtdk/assert_context.c
index f67bcd8..bad19f3 100644
--- a/src/rtdk/assert_context.c
+++ b/src/rtdk/assert_context.c
@@ -30,9 +30,12 @@ void assert_nrt(void)
 	xnthread_info_t info;
 	int err;
 
-	if (unlikely(xeno_get_current() != XN_NO_HANDLE &&
-		     !(xeno_get_current_mode() & XNRELAX))) {
+	if (xeno_get_current() != XN_NO_HANDLE)
+		return;
 
+	info.state = xeno_get_current_mode();
+
+	if (unlikely(!(info.state & XNRELAX) || info.state == -1)) {
 		err = XENOMAI_SYSCALL1(__xn_sys_current_info, &info);
 
 		if (err) {
@@ -41,7 +44,7 @@ void assert_nrt(void)
 			return;
 		}
 
-		if (info.state & XNTRAPSW)
+		if ((info.state & (XNRELAX | XNTRAPSW)) == XNTRAPSW)
 			pthread_kill(pthread_self(), SIGXCPU);
 	}
 }
diff --git a/src/skins/common/current.c b/src/skins/common/current.c
index 2922d6e..1b09390 100644
--- a/src/skins/common/current.c
+++ b/src/skins/common/current.c
@@ -1,10 +1,13 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <pthread.h>
 
 #include <asm/xenomai/syscall.h>
 #include <nucleus/types.h>
 
+pthread_key_t xeno_current_mode_key;
+
 #ifdef HAVE___THREAD
 __thread __attribute__ ((tls_model ("initial-exec")))
 xnhandle_t xeno_current = XN_NO_HANDLE;
@@ -16,36 +19,62 @@ static inline void __xeno_set_current(xnhandle_t current)
 	xeno_current = current;
 }
 #else /* !HAVE___THREAD */
-#include <pthread.h>
-
 pthread_key_t xeno_current_key;
-pthread_key_t xeno_current_mode_key;
 
 static inline void __xeno_set_current(xnhandle_t current)
 {
 	pthread_setspecific(xeno_current_key, (void *)current);
 }
+#endif /* !HAVE___THREAD */
 
-unsigned long *xeno_init_current_mode(void)
+static void free_current_mode(void *key)
 {
-	unsigned long *mode = malloc(sizeof(unsigned long));
-	pthread_setspecific(xeno_current_mode_key, mode);
-	return mode;
+	unsigned long *mode = key;
+	int err;
+
+	*mode = -1;
+
+	err = XENOMAI_SYSCALL0(__xn_sys_drop_u_mode);
+
+#ifndef HAVE___THREAD
+	if (err) {
+		static int warned;
+
+		if (!warned) {
+			warned = 1;
+			fprintf(stderr,
+				"\nXenomai: WARNING, this Xenomai kernel can "
+					"cause spurious application\n"
+				"         crashes on thread termination.\n"
+				"         To reduce the probality, we will "
+					"leak a few bytes heap now.\n"
+				);
+		}
+	} else
+		free(mode);
+#endif /* !HAVE___THREAD */
 }
 
 static void init_current_keys(void)
 {
-	int err = pthread_key_create(&xeno_current_key, NULL);
+	int err;
+
+#ifndef HAVE___THREAD
+	err = pthread_key_create(&xeno_current_key, NULL);
 	if (err)
 		goto error_exit;
+#endif /* !HAVE___THREAD */
 
-	err = pthread_key_create(&xeno_current_mode_key, free);
-	if (err) {
-	  error_exit:
-		fprintf(stderr, "Xenomai: error creating TSD key: %s\n",
-			strerror(err));
-		exit(EXIT_FAILURE);
-	}
+	err = pthread_key_create(&xeno_current_mode_key, free_current_mode);
+	if (err)
+		goto error_exit;
+
+	return;
+
+  error_exit:
+	fprintf(stderr, "Xenomai: error creating TSD key: %s\n",
+		strerror(err));
+	exit(EXIT_FAILURE);
 }
 
 void xeno_init_current_keys(void)
@@ -53,7 +82,6 @@ void xeno_init_current_keys(void)
 	static pthread_once_t xeno_init_current_keys_once = PTHREAD_ONCE_INIT;
 	pthread_once(&xeno_init_current_keys_once, init_current_keys);
 }
-#endif /* !HAVE___THREAD */
 
 void xeno_set_current(void)
 {
@@ -68,3 +96,15 @@ void xeno_set_current(void)
 	}
 	__xeno_set_current(current);
 }
+
+unsigned long *xeno_init_current_mode(void)
+{
+#ifdef HAVE___THREAD
+	unsigned long *mode = &xeno_current_mode;
+#else /* !HAVE___THREAD */
+	unsigned long *mode = malloc(sizeof(unsigned long));
+#endif /* !HAVE___THREAD */
+
+	pthread_setspecific(xeno_current_mode_key, mode);
+	return mode;
+}
-- 
1.6.0.2

