Message-ID: <4B8FC11F.6050905@domain.hid>
Date: Thu, 04 Mar 2010 15:18:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC] Native: Add fixed syscalls for rt_cond_wait
	services
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

This is specifically RFC as I don't know what your plan regarding
replace or add is. This version adds new calls for new libnatives, of
course it would be much simpler if if only had to replace the existing
ones.

Jan

---
 include/native/cond.h       |    8 +++
 include/native/syscall.h    |    2 +
 ksrc/skins/native/syscall.c |  101 ++++++++++++++++++++++++++++++++++---------
 src/skins/native/cond.c     |   82 ++++++++++++++++++++++++-----------
 src/skins/native/init.c     |    4 ++
 5 files changed, 151 insertions(+), 46 deletions(-)

diff --git a/include/native/cond.h b/include/native/cond.h
index 1d38b2c..bca7a63 100644
--- a/include/native/cond.h
+++ b/include/native/cond.h
@@ -38,6 +38,14 @@ typedef struct rt_cond_placeholder {
 
 } RT_COND_PLACEHOLDER;
 
+typedef struct rt_cond_waitstate {
+
+    unsigned lockcnt;
+
+    int prologue_err;
+
+} RT_COND_WAITSTATE;
+
 #if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_CPP)
 
 #include <nucleus/synch.h>
diff --git a/include/native/syscall.h b/include/native/syscall.h
index 2e3d7ec..59f0ce4 100644
--- a/include/native/syscall.h
+++ b/include/native/syscall.h
@@ -128,6 +128,8 @@
 #define __native_buffer_inquire     102
 #define __native_queue_flush        103
 #define __native_cond_wait_epilogue 104
+#define __native_cond_wait_prologue2 105
+#define __native_cond_wait_epilogue2 106
 
 struct rt_arg_bulk {
 
diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
index ee6c829..771efef 100644
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -1825,19 +1825,11 @@ static int __rt_cond_delete(struct pt_regs *regs)
 	return err;
 }
 
-/*
- * int __rt_cond_wait_prologue(RT_COND_PLACEHOLDER *cph,
- *                    	       RT_MUTEX_PLACEHOLDER *mph,
- *		      	       unsigned *plockcnt,
- *                    	       xntmode_t timeout_mode,
- *                    	       RTIME *timeoutp)
- */
-
-static int __rt_cond_wait_prologue(struct pt_regs *regs)
+static int
+__rt_cond_wait_prologue_inner(struct pt_regs *regs, RT_COND_WAITSTATE *state)
 {
 	RT_COND_PLACEHOLDER cph, mph;
 	xntmode_t timeout_mode;
-	unsigned lockcnt;
 	RT_MUTEX *mutex;
 	RT_COND *cond;
 	RTIME timeout;
@@ -1867,16 +1859,15 @@ static int __rt_cond_wait_prologue(struct pt_regs *regs)
 				     sizeof(timeout)))
 		return -EFAULT;
 
-	err = rt_cond_wait_prologue(cond, mutex, &lockcnt, timeout_mode, timeout);
+	err = rt_cond_wait_prologue(cond, mutex, &state->lockcnt,
+				    timeout_mode, timeout);
 
-	/* Old user space prevents that we can return -EINTR (it would loop
-	   forever if we did). So drop this error. */
-	xnpod_current_thread()->errcode = err != -EINTR ? err : 0;
+	state->prologue_err = err;
 
 	/* Reacquire the mutex if it was unlocked in the prologue and we were
 	   not interrupted. */
-	if (lockcnt && err != -EINTR) {
-		epilogue_err = rt_cond_wait_epilogue(mutex, lockcnt);
+	if (state->lockcnt && err != -EINTR) {
+		epilogue_err = rt_cond_wait_epilogue(mutex, state->lockcnt);
 
 		/* Only overwrite the prologue if we need to signal -EINTR or
 		   the previous error was "less fatal". */
@@ -1885,24 +1876,65 @@ static int __rt_cond_wait_prologue(struct pt_regs *regs)
 			err = epilogue_err;
 	}
 
+	return err;
+}
+
+/*
+ * int __rt_cond_wait_prologue(RT_COND_PLACEHOLDER *cph,
+ *                    	       RT_MUTEX_PLACEHOLDER *mph,
+ *		      	       unsigned *plockcnt,
+ *                    	       xntmode_t timeout_mode,
+ *                    	       RTIME *timeoutp)
+ */
+
+static int __rt_cond_wait_prologue(struct pt_regs *regs)
+{
+	RT_COND_WAITSTATE state;
+	int err;
+
+	err = __rt_cond_wait_prologue_inner(regs, &state);
+
+	/* Old user space prevents that we can return -EINTR (it would loop
+	   forever if we did). So drop this error. */
+	xnpod_current_thread()->errcode =
+		(state.prologue_err != -EINTR) ? state.prologue_err : 0;
+
 	if (err == -EINTR && __xn_reg_arg3(regs)
 	    && __xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
-				      &lockcnt, sizeof(lockcnt)))
+				      &state.lockcnt, sizeof(state.lockcnt)))
 		return -EFAULT;
 
 	return err;
 }
 
 /*
- * int __rt_cond_wait_epilogue(RT_MUTEX_PLACEHOLODER *mph, unsigned lockcnt)
+ * int __rt_cond_wait_prologue2(RT_COND_PLACEHOLDER *cph,
+ * 				RT_MUTEX_PLACEHOLDER *mph,
+ * 				RT_COND_WAITSTATE *waitstate,
+ * 				xntmode_t timeout_mode,
+ * 				RTIME *timeoutp)
  */
 
-static int __rt_cond_wait_epilogue(struct pt_regs *regs)
+static int __rt_cond_wait_prologue2(struct pt_regs *regs)
+{
+	RT_COND_WAITSTATE state;
+	int err;
+
+	err = __rt_cond_wait_prologue_inner(regs, &state);
+
+	if (err == -EINTR
+	    && __xn_safe_copy_to_user((void __user *)__xn_reg_arg3(regs),
+				      &state, sizeof(state)))
+		return -EFAULT;
+
+	return err;
+}
+
+static int __rt_cond_wait_epilogue_inner(struct pt_regs *regs)
 {
 	RT_COND_PLACEHOLDER mph;
 	unsigned lockcnt;
 	RT_MUTEX *mutex;
-	int prologue_err, err;
 
 	if (__xn_safe_copy_from_user(&mph, (void __user *)__xn_reg_arg1(regs),
 				     sizeof(mph)))
@@ -1914,8 +1946,20 @@ static int __rt_cond_wait_epilogue(struct pt_regs *regs)
 		return -ESRCH;
 
 	lockcnt = __xn_reg_arg2(regs);
+	return rt_cond_wait_epilogue(mutex, lockcnt);
+}
+
+/*
+ * int __rt_cond_wait_epilogue(RT_MUTEX_PLACEHOLODER *mph, unsigned lockcnt)
+ *
+ * Used with __rt_cond_wait_prologue.
+ */
+
+static int __rt_cond_wait_epilogue(struct pt_regs *regs)
+{
+	int prologue_err, err;
 
-	err = rt_cond_wait_epilogue(mutex, lockcnt);
+	err = __rt_cond_wait_epilogue_inner(regs);
 	if (err == -EINTR)
 		return err;
 
@@ -1925,6 +1969,17 @@ static int __rt_cond_wait_epilogue(struct pt_regs *regs)
 }
 
 /*
+ * int __rt_cond_wait_epilogue2(RT_MUTEX_PLACEHOLODER *mph, unsigned lockcnt)
+ *
+ * Used with __rt_cond_wait_prologue2.
+ */
+
+static int __rt_cond_wait_epilogue2(struct pt_regs *regs)
+{
+	return __rt_cond_wait_epilogue_inner(regs);
+}
+
+/*
  * int __rt_cond_signal(RT_COND_PLACEHOLDER *ph)
  */
 
@@ -4113,6 +4168,10 @@ static xnsysent_t __systab[] = {
 		{&__rt_cond_wait_prologue, __xn_exec_primary},
 	[__native_cond_wait_epilogue] = 
 		{&__rt_cond_wait_epilogue, __xn_exec_primary},
+	[__native_cond_wait_prologue2] = 
+		{&__rt_cond_wait_prologue2, __xn_exec_primary},
+	[__native_cond_wait_epilogue2] = 
+		{&__rt_cond_wait_epilogue2, __xn_exec_primary},
 	[__native_cond_signal] = {&__rt_cond_signal, __xn_exec_any},
 	[__native_cond_broadcast] = {&__rt_cond_broadcast, __xn_exec_any},
 	[__native_cond_inquire] = {&__rt_cond_inquire, __xn_exec_any},
diff --git a/src/skins/native/cond.c b/src/skins/native/cond.c
index f874678..7c5c101 100644
--- a/src/skins/native/cond.c
+++ b/src/skins/native/cond.c
@@ -22,6 +22,8 @@
 
 extern int __native_muxid;
 
+static int have_new_cond_syscalls;
+
 int rt_cond_create(RT_COND *cond, const char *name)
 {
 	return XENOMAI_SKINCALL2(__native_muxid, __native_cond_create, cond,
@@ -39,16 +41,16 @@ int rt_cond_delete(RT_COND *cond)
 	return XENOMAI_SKINCALL1(__native_muxid, __native_cond_delete, cond);
 }
 
-int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
+static int rt_cond_wait_old(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout,
+			    xntmode_t timeout_mode)
 {
-	int saved_lockcnt, err;
-
+	int err;
 #ifdef CONFIG_XENO_FASTSYNCH
-	saved_lockcnt = mutex->lockcnt;
+	int saved_lockcnt = mutex->lockcnt;
 
 	err = XENOMAI_SKINCALL5(__native_muxid,
 				__native_cond_wait_prologue, cond, mutex,
-				NULL, XN_RELATIVE, &timeout);
+				NULL, timeout_mode, &timeout);
 
 	while (err == -EINTR)
 		err = XENOMAI_SKINCALL2(__native_muxid,
@@ -60,7 +62,7 @@ int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 #else /* !CONFIG_XENO_FASTSYNCH */
 	err = XENOMAI_SKINCALL5(__native_muxid,
 				 __native_cond_wait_prologue, cond, mutex,
-				 &saved_lockcnt, XN_RELATIVE, &timeout);
+				 &saved_lockcnt, timeout_mode, &timeout);
 
 	while (err == -EINTR)
 		err = XENOMAI_SKINCALL2(__native_muxid,
@@ -72,36 +74,56 @@ int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
 	return err;
 }
 
-int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
+static int rt_cond_wait_new(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout,
+			    xntmode_t timeout_mode)
 {
-	int saved_lockcnt, err;
+	RT_COND_WAITSTATE state;
+	int saved_lockcnt;
+	int err;
 
 #ifdef CONFIG_XENO_FASTSYNCH
 	saved_lockcnt = mutex->lockcnt;
+#endif
 
 	err = XENOMAI_SKINCALL5(__native_muxid,
-				__native_cond_wait_prologue, cond, mutex,
-				NULL, XN_REALTIME, &timeout);
-
-	while (err == -EINTR)
-		err = XENOMAI_SKINCALL2(__native_muxid,
-					__native_cond_wait_epilogue, mutex,
-					saved_lockcnt);
+				__native_cond_wait_prologue2, cond, mutex,
+				&state, timeout_mode, &timeout);
+
+	if (err == -EINTR) {
+#ifndef CONFIG_XENO_FASTSYNCH
+		saved_lockcnt = state.lockcnt;
+#endif
+		do {
+			err = XENOMAI_SKINCALL2(__native_muxid,
+						__native_cond_wait_epilogue2,
+						mutex, saved_lockcnt);
+		} while (err == -EINTR);
+
+		if (!err || state.prologue_err != -EIDRM)
+			err = state.prologue_err;
+	}
 
+#ifdef CONFIG_XENO_FASTSYNCH
 	mutex->lockcnt = saved_lockcnt;
+#endif
 
-#else /* !CONFIG_XENO_FASTSYNCH */
-	err = XENOMAI_SKINCALL5(__native_muxid,
-				__native_cond_wait_prologue, cond, mutex,
-				&saved_lockcnt, XN_REALTIME, &timeout);
+	return err;
+}
 
-	while (err == -EINTR)
-		err = XENOMAI_SKINCALL2(__native_muxid,
-					__native_cond_wait_epilogue, mutex,
-					saved_lockcnt);
-#endif /* !CONFIG_XENO_FASTSYNCH */
+int rt_cond_wait(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
+{
+	if (have_new_cond_syscalls)
+		return rt_cond_wait_new(cond, mutex, timeout, XN_RELATIVE);
+	else
+		return rt_cond_wait_old(cond, mutex, timeout, XN_RELATIVE);
+}
 
-	return err;
+int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
+{
+	if (have_new_cond_syscalls)
+		return rt_cond_wait_new(cond, mutex, timeout, XN_REALTIME);
+	else
+		return rt_cond_wait_old(cond, mutex, timeout, XN_REALTIME);
 }
 
 int rt_cond_signal(RT_COND *cond)
@@ -119,3 +141,13 @@ int rt_cond_inquire(RT_COND *cond, RT_COND_INFO *info)
 	return XENOMAI_SKINCALL2(__native_muxid, __native_cond_inquire, cond,
 				 info);
 }
+
+void __native_cond_init(void)
+{
+	int err = XENOMAI_SKINCALL5(__native_muxid,
+				    __native_cond_wait_prologue2, NULL, NULL,
+				    NULL, XN_REALTIME, NULL);
+
+	have_new_cond_syscalls = (err != -ENOSYS);
+}
+
diff --git a/src/skins/native/init.c b/src/skins/native/init.c
index e85784a..c4b94c0 100644
--- a/src/skins/native/init.c
+++ b/src/skins/native/init.c
@@ -28,6 +28,8 @@
 
 int __native_muxid = -1;
 
+void __native_cond_init(void);
+
 #ifndef HAVE___THREAD
 pthread_key_t __native_tskey;
 
@@ -56,4 +58,6 @@ void __init_xeno_interface(void)
 		xeno_bind_skin(XENO_SKIN_MAGIC, "native", "xeno_native", NULL);
 
 	__native_muxid = __xn_mux_shifted_id(__native_muxid);
+
+	__native_cond_init();
 }

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

