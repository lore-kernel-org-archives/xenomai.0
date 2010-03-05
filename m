Message-ID: <4B91290C.7070005@domain.hid>
Date: Fri, 05 Mar 2010 16:53:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B90ED0A.40101@domain.hid> <4B90F2D3.8020508@domain.hid>
In-Reply-To: <4B90F2D3.8020508@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH v2] Allow for deregistering current mode
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

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> This adds __xn_sys_drop_u_mode, a syscall to deregister the u_mode user
>> space address passed on shadow creation for the current thread. We need
>> this in order to safely shut down a thread that wants to release its
>> u_mode memory (either malloc'ed or TLS-allocated). So far, the kernel
>> might have touched this memory even after the release which caused
>> subtle corruptions.
>>
>> After we released u_mode, we can no longer make reliable decisions based
>> on it. For the fast mutex use case, we then assume the worst case, ie.
>> we enforce syscall-based acquisitions unconditionally. For the
>> assert_nrt case, we simply acquire the required information via
>> __xn_sys_current_info.
> 
> As usual, you are firing patches too fast:
> - you are lacking the exit syscall trap.

Don't worry, my memory is not yet _that_ bad. :)

> - the patch is not correct and will cause kernel-space addresses to be
> passed to put_user, which probably yields bugs when the kernel is
> compiled with proper debug flags;

Right, e.g. ARM requires set_fs() fiddling in addition. But then a simple
NULL-check is way better. Fixed.

> - I do not see the point where the new syscall is called with __thread,
> but I am not sure it is missing, and if it is missing, you will get the
> rightfull warning when hitting the exit syscall.

Destructor of (now unconditionally used) xeno_current_mode_key.

> - the user-space users of the function to get current_mode are still
> cluttered with special cases to handle the invalid state. And
> illustrating nicely the deficiency of this approach, you have forgot one
> user.

My impression is that you are still a bit biased due to TLS limitations
on ARM.

And nope, I didn't forget to address it, I just forgot to mention that
there is nothing to address (the torture test does not use
xeno_get_current_mode from within a TSD destructor, thus potentially
after drop_u_mode).

> 
> I am not going to make my version before tomorrow, so you have plenty of
> time to send me an at least correct version which would take into
> account all of our discussions.

Well... what should I reply?

> 
> Please also consider that your "patch machinegun" way of working is not
> really sane. When there are so many often untested patches to review
> coming from you, we sometime let some errors slip through. And from a
> user point of view, seeing so many buggy patches refused is not really
> reassuring.

Please don't make me cite counter examples for issues with different
workflows we also experienced.

The key of an open development process is open discussion, and that
ideally based on code, even if it is not yet perfect. I can't imagine
you want Xenomai being developed in closed chambers (or even just a
single one). If you are afraid of imperfect patches being posted or even
merged into some software, you shouldn't use e.g. the Linux kernel as
well.

Jan

------>

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
__xn_sys_current_info. The mutex torture test requires no special care
as it cannot retrieve invalid u_mode states.

---

Changes in v2:
 - Drop non-working redirection of u_mode after release, just check for
   NULL u_mode before writing to it
 - Trap exit syscall to clear u_mode if user space failed to
 - Add/improve warnings about too old user/kernel space
 - Code refactorings to avoid new #ifdefs

 include/asm-generic/bits/current.h |   24 +++++++----
 include/asm-generic/syscall.h      |    1 +
 ksrc/nucleus/shadow.c              |   51 +++++++++++++++++++++---
 src/rtdk/assert_context.c          |    9 +++-
 src/skins/common/current.c         |   78 +++++++++++++++++++++++++++++++----
 5 files changed, 137 insertions(+), 26 deletions(-)

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
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d82d6c7..8a50cbb 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1018,7 +1018,8 @@ redo:
 		/* Grab the request token. */
 		return -ERESTARTSYS;
 
-	__xn_put_user(0, thread->u_mode);
+	if (thread->u_mode)
+		__xn_put_user(0, thread->u_mode);
 
 	preempt_disable();
 
@@ -1208,7 +1209,8 @@ void xnshadow_relax(int notify, int reason)
 	/* "current" is now running into the Linux domain on behalf of the
 	   root thread. */
 
-	__xn_put_user(XNRELAX, thread->u_mode);
+	if (thread->u_mode)
+		__xn_put_user(XNRELAX, thread->u_mode);
 
 	trace_mark(xn_nucleus, shadow_relaxed,
 		  "thread %p thread_name %s comm %s",
@@ -1382,7 +1384,8 @@ int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_completion,
 	if (ret)
 		return ret;
 
-	__xn_put_user(XNRELAX, u_mode);
+	if (thread->u_mode)
+		__xn_put_user(XNRELAX, u_mode);
 
 	ret = xnshadow_harden();
 
@@ -1967,6 +1970,18 @@ static int xnshadow_sys_get_next_sigs(struct pt_regs *regs)
 	return -EINTR;
 }
 
+static int xnshadow_sys_drop_u_mode(struct pt_regs *regs)
+{
+	xnthread_t *cur = xnshadow_thread(current);
+
+	if (!cur)
+		return -EPERM;
+
+	cur->u_mode = NULL;
+
+	return 0;
+}
+
 static xnsysent_t __systab[] = {
 	[__xn_sys_migrate] = {&xnshadow_sys_migrate, __xn_exec_current},
 	[__xn_sys_arch] = {&xnshadow_sys_arch, __xn_exec_any},
@@ -1981,6 +1996,8 @@ static xnsysent_t __systab[] = {
 		{&xnshadow_sys_current_info, __xn_exec_shadow},
 	[__xn_sys_get_next_sigs] = 
 		{&xnshadow_sys_get_next_sigs, __xn_exec_conforming},
+	[__xn_sys_drop_u_mode] =
+		{&xnshadow_sys_drop_u_mode, __xn_exec_shadow},
 };
 
 static void post_ppd_release(struct xnheap *h)
@@ -2034,8 +2051,30 @@ static struct xnskin_props __props = {
 	.module = NULL
 };
 
-static inline int substitute_linux_syscall(struct pt_regs *regs)
+static void handle_shadow_exit(xnthread_t *thread)
 {
+	static int warned;
+
+	/*
+	 * If user space did not deregister u_mode at this point, we
+	 * are confronted with old libraries and should warn about
+	 * potential instabilities.
+	 */
+	if (thread->u_mode && !warned) {
+		warned = 1;
+		printk(KERN_WARNING
+		       "Xenomai: old Xenomai libs detected which may crash "
+		       "on thread termination\n");
+	}
+	thread->u_mode = NULL;
+}
+
+static inline int
+substitute_linux_syscall(xnthread_t *thread, struct pt_regs *regs)
+{
+	if (unlikely(__xn_reg_mux(regs) == __NR_exit))
+		handle_shadow_exit(thread);
+
 	/* No real-time replacement for now -- let Linux handle this call. */
 	return 0;
 }
@@ -2204,7 +2243,7 @@ static inline int do_hisyscall_event(unsigned event, unsigned domid, void *data)
 	 * From now on, we know that we have a valid shadow thread
 	 * pointer.
 	 */
-	if (substitute_linux_syscall(regs))
+	if (substitute_linux_syscall(thread, regs))
 		/*
 		 * This is a Linux syscall issued on behalf of a
 		 * shadow thread running inside the Xenomai
@@ -2265,7 +2304,7 @@ static inline int do_losyscall_event(unsigned event, unsigned domid, void *data)
 	if (__xn_reg_mux_p(regs))
 		goto xenomai_syscall;
 
-	if (!thread || !substitute_linux_syscall(regs))
+	if (!thread || !substitute_linux_syscall(thread, regs))
 		/* Fall back to Linux syscall handling. */
 		return RTHAL_EVENT_PROPAGATE;
 
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
index 2922d6e..7db66c0 100644
--- a/src/skins/common/current.c
+++ b/src/skins/common/current.c
@@ -1,45 +1,98 @@
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
 __thread __attribute__ ((tls_model ("initial-exec")))
 unsigned long xeno_current_mode;
 
+static inline int create_current_key(void) { return 0; }
+
 static inline void __xeno_set_current(xnhandle_t current)
 {
 	xeno_current = current;
 }
+
+static inline unsigned long *create_current_mode(void)
+{
+	return &xeno_current_mode;
+}
+
+static inline void free_current_mode(unsigned long *mode) { }
+
+#define XENO_MODE_LEAK_WARNING ""
+
 #else /* !HAVE___THREAD */
-#include <pthread.h>
 
 pthread_key_t xeno_current_key;
-pthread_key_t xeno_current_mode_key;
+
+static inline int create_current_key(void)
+{
+	return pthread_key_create(&xeno_current_key, NULL);
+}
 
 static inline void __xeno_set_current(xnhandle_t current)
 {
 	pthread_setspecific(xeno_current_key, (void *)current);
 }
 
-unsigned long *xeno_init_current_mode(void)
+static inline unsigned long *create_current_mode(void)
 {
-	unsigned long *mode = malloc(sizeof(unsigned long));
-	pthread_setspecific(xeno_current_mode_key, mode);
-	return mode;
+	return malloc(sizeof(unsigned long));
+}
+
+static inline void free_current_mode(unsigned long *mode)
+{
+	free(mode);
+}
+
+#define XENO_MODE_LEAK_WARNING \
+	"         To reduce the probality, we leak a few bytes of heap " \
+	"per thread.\n"
+
+#endif /* !HAVE___THREAD */
+
+static void cleanup_current_mode(void *key)
+{
+	unsigned long *mode = key;
+	int err;
+
+	*mode = -1;
+
+	err = XENOMAI_SYSCALL0(__xn_sys_drop_u_mode);
+
+	if (err) {
+		static int warned;
+
+		if (!warned) {
+			warned = 1;
+			fprintf(stderr,
+				"\nXenomai: WARNING, this Xenomai kernel can "
+					"cause spurious application\n"
+				"         crashes on thread termination. "
+					"Upgrade is highly recommended.\n%s\n",
+				XENO_MODE_LEAK_WARNING);
+		}
+	} else
+		free_current_mode(mode);
 }
 
 static void init_current_keys(void)
 {
-	int err = pthread_key_create(&xeno_current_key, NULL);
+	int err = create_current_key();
+
 	if (err)
 		goto error_exit;
 
-	err = pthread_key_create(&xeno_current_mode_key, free);
+	err = pthread_key_create(&xeno_current_mode_key, cleanup_current_mode);
 	if (err) {
 	  error_exit:
 		fprintf(stderr, "Xenomai: error creating TSD key: %s\n",
@@ -53,7 +106,6 @@ void xeno_init_current_keys(void)
 	static pthread_once_t xeno_init_current_keys_once = PTHREAD_ONCE_INIT;
 	pthread_once(&xeno_init_current_keys_once, init_current_keys);
 }
-#endif /* !HAVE___THREAD */
 
 void xeno_set_current(void)
 {
@@ -68,3 +120,11 @@ void xeno_set_current(void)
 	}
 	__xeno_set_current(current);
 }
+
+unsigned long *xeno_init_current_mode(void)
+{
+	unsigned long *mode = create_current_mode();
+
+	pthread_setspecific(xeno_current_mode_key, mode);
+	return mode;
+}
-- 
1.6.0.2

