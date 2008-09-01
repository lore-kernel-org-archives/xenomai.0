Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22C.6080402@domain.hid>
Message-ID: <48BBADB0.5020508@domain.hid>
Date: Mon, 01 Sep 2008 10:54:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid>
In-Reply-To: <48BBA9E6.5070400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC][PATCH 5/9] Allow lock stealing via
	pthread_mutex_trylock
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

By calling into the kernel in the contended case and exploiting
XN_NONBLOCK for xnsynch_sleep_on, this patch adds lock stealing support
to pthread_mutex_trylock.

The latter part may change if we decide to go for a dedicates xnsynch
trylock service. Maybe we are even lucky and able to implement lock
stealing purely with the help of the fast lock algorithm. But we first
have to merge fast locks into xnsynch to see clearer.

---
 include/posix/syscall.h    |    2 -
 ksrc/skins/posix/cond.c    |    3 +-
 ksrc/skins/posix/mutex.c   |   24 +++++++++++++----------
 ksrc/skins/posix/mutex.h   |   11 +++-------
 ksrc/skins/posix/syscall.c |   46 +++++++++++++++++++++++++++++++++++----------
 src/skins/posix/mutex.c    |    6 ++++-
 6 files changed, 62 insertions(+), 30 deletions(-)

Index: b/ksrc/skins/posix/cond.c
===================================================================
--- a/ksrc/skins/posix/cond.c
+++ b/ksrc/skins/posix/cond.c
@@ -345,7 +345,8 @@ int pse51_cond_timedwait_epilogue(xnthre
 
 	cond = shadow->cond;
 
-	err = pse51_mutex_timedlock_internal(cur, mutex, count, 0, XN_INFINITE);
+	err = pse51_mutex_timedlock_internal(cur, mutex, count, XN_RELATIVE,
+					     XN_INFINITE);
 
 	if (err == -EINTR)
 		goto unlock_and_return;
Index: b/ksrc/skins/posix/mutex.c
===================================================================
--- a/ksrc/skins/posix/mutex.c
+++ b/ksrc/skins/posix/mutex.c
@@ -283,7 +283,7 @@ int pthread_mutex_destroy(pthread_mutex_
 }
 
 int pse51_mutex_timedlock_break(struct __shadow_mutex *shadow,
-				int timed, xnticks_t abs_to)
+				xntmode_t timeout_mode, xnticks_t timeout)
 {
 	xnthread_t *cur = xnpod_current_thread();
 	pse51_mutex_t *mutex;
@@ -294,7 +294,8 @@ int pse51_mutex_timedlock_break(struct _
 	if (!xnthread_handle(cur))
 		return -EPERM;
 
-	err = pse51_mutex_timedlock_internal(cur, shadow, 1, timed, abs_to);
+	err = pse51_mutex_timedlock_internal(cur, shadow, 1, timeout_mode,
+					     timeout);
 	if (err != -EBUSY)
 		goto unlock_and_return;
 
@@ -306,12 +307,8 @@ int pse51_mutex_timedlock_break(struct _
 		xnlock_get_irqsave(&nklock, s);
 		for (;;) {
 			++mutex->sleepers;
-			if (timed)
-				xnsynch_sleep_on(&mutex->synchbase,
-						 abs_to, XN_REALTIME);
-			else
-				xnsynch_sleep_on(&mutex->synchbase,
-						 XN_INFINITE, XN_RELATIVE);
+			xnsynch_sleep_on(&mutex->synchbase, timeout,
+					 timeout_mode);
 			--mutex->sleepers;
 
 			if (xnthread_test_info(cur, XNBREAK)) {
@@ -407,6 +404,12 @@ int pthread_mutex_trylock(pthread_mutex_
 				err = 0;
 			}
 		}
+	} else {
+		err =
+		    -pse51_mutex_timedlock_internal(cur, shadow, 1,
+						    XN_RELATIVE, XN_NONBLOCK);
+		if (err == ETIMEDOUT)
+			err = EBUSY;
 	}
 
 	cb_read_unlock(&shadow->lock, s);
@@ -461,7 +464,8 @@ int pthread_mutex_lock(pthread_mutex_t *
 		return EINVAL;
 
 	do {
-		err = pse51_mutex_timedlock_break(shadow, 0, XN_INFINITE);
+		err = pse51_mutex_timedlock_break(shadow, XN_RELATIVE,
+						  XN_INFINITE);
 	} while (err == -EINTR);
 
 	cb_read_unlock(&shadow->lock, s);
@@ -514,7 +518,7 @@ int pthread_mutex_timedlock(pthread_mute
 		return EINVAL;
 
 	do {
-		err = pse51_mutex_timedlock_break(shadow, 1,
+		err = pse51_mutex_timedlock_break(shadow, XN_REALTIME,
 						  ts2ticks_ceil(to) + 1);
 	} while (err == -EINTR);
 
Index: b/ksrc/skins/posix/mutex.h
===================================================================
--- a/ksrc/skins/posix/mutex.h
+++ b/ksrc/skins/posix/mutex.h
@@ -71,7 +71,7 @@ void pse51_mutex_pkg_cleanup(void);
 
 /* Internal mutex functions, exposed for use by syscall.c. */
 int pse51_mutex_timedlock_break(struct __shadow_mutex *shadow,
-				int timed, xnticks_t to);
+				xntmode_t timeout_mode, xnticks_t timeout);
 
 int pse51_mutex_check_init(struct __shadow_mutex *shadow,
 			   const pthread_mutexattr_t *attr);
@@ -120,8 +120,8 @@ pse51_mutex_trylock_internal(xnthread_t
 static inline int pse51_mutex_timedlock_internal(xnthread_t *cur,
 						 struct __shadow_mutex *shadow,
 						 unsigned count,
-						 int timed,
-						 xnticks_t abs_to)
+						 xntmode_t timeout_mode,
+						 xnticks_t timeout)
 
 {
 	pse51_mutex_t *mutex;
@@ -173,10 +173,7 @@ static inline int pse51_mutex_timedlock_
 
 	xnsynch_set_owner(&mutex->synchbase, owner);
 	++mutex->sleepers;
-	if (timed)
-		xnsynch_sleep_on(&mutex->synchbase, abs_to, XN_REALTIME);
-	else
-		xnsynch_sleep_on(&mutex->synchbase, XN_INFINITE, XN_RELATIVE);
+	xnsynch_sleep_on(&mutex->synchbase, timeout, timeout_mode);
 	--mutex->sleepers;
 
 	if (xnthread_test_info(cur, XNBREAK)) {
Index: b/ksrc/skins/posix/syscall.c
===================================================================
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -957,7 +957,8 @@ static int __pthread_mutex_lock(struct p
 	if (unlikely(cb_try_read_lock(&mx.shadow_mutex.lock, s)))
 		return -EINVAL;
 
-	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, 0, XN_INFINITE);
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, XN_REALTIVE,
+					  XN_INFINITE);
 
 	cb_read_unlock(&mx.shadow_mutex.lock, s);
 
@@ -991,8 +992,8 @@ static int __pthread_mutex_timedlock(str
 	if (unlikely(cb_try_read_lock(&mx.shadow_mutex.lock, s)))
 		return -EINVAL;
 
-	err = pse51_mutex_timedlock_break(&mx.shadow_mutex,
-					  1, ts2ticks_ceil(&ts) + 1);
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, XN_REALTIME,
+					  ts2ticks_ceil(&ts) + 1);
 
 	cb_read_unlock(&mx.shadow_mutex.lock, s);
 
@@ -1214,7 +1215,8 @@ static int __pthread_mutex_lock(struct p
 
 	shadow = &mx.shadow_mutex;
 
-	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, 0, XN_INFINITE);
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, XN_RELATIVE,
+					  XN_INFINITE);
 
 	if (!err &&
 	    __xn_safe_copy_to_user((void __user *)
@@ -1247,8 +1249,8 @@ static int __pthread_mutex_timedlock(str
 
 	shadow = &mx.shadow_mutex;
 
-	err = pse51_mutex_timedlock_break(&mx.shadow_mutex,
-					    1, ts2ticks_ceil(&ts) + 1);
+	err = pse51_mutex_timedlock_break(&mx.shadow_mutex, XN_REALTIME,
+					  ts2ticks_ceil(&ts) + 1);
 
 	if (!err &&
 	    __xn_safe_copy_to_user((void __user *)
@@ -1260,6 +1262,31 @@ static int __pthread_mutex_timedlock(str
 	return err;
 }
 
+static int __pthread_mutex_trylock(struct pt_regs *regs)
+{
+	xnthread_t *cur = xnpod_current_thread();
+	union __xeno_mutex mx, *umx;
+	int err;
+
+	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
+
+	if (__xn_safe_copy_from_user(&mx.shadow_mutex,
+				     (void __user *)&umx->shadow_mutex,
+				     sizeof(mx.shadow_mutex)))
+		return -EFAULT;
+
+	err = pse51_mutex_timedlock_internal(cur, &mx.shadow_mutex, 1,
+					     XN_RELATIVE, XN_NONBLOCK);
+
+	if (!err &&
+	    __xn_safe_copy_to_user((void __user *)&umx->shadow_mutex.lockcnt,
+				   &mx.shadow_mutex.lockcnt,
+				   sizeof(umx->shadow_mutex.lockcnt)))
+		return -EFAULT;
+
+	return err;
+}
+
 static int __pthread_mutex_unlock(struct pt_regs *regs)
 {
 	xnthread_t *cur = xnpod_current_thread();
@@ -2695,11 +2722,7 @@ static xnsysent_t __systab[] = {
 	[__pse51_mutex_lock] = {&__pthread_mutex_lock, __xn_exec_primary},
 	[__pse51_mutex_timedlock] =
 	    {&__pthread_mutex_timedlock, __xn_exec_primary},
-#ifndef CONFIG_XENO_FASTSEM
 	[__pse51_mutex_trylock] = {&__pthread_mutex_trylock, __xn_exec_primary},
-#else
-        [__pse51_check_init] = {&__pthread_mutex_check_init, __xn_exec_any},
-#endif
 	[__pse51_mutex_unlock] = {&__pthread_mutex_unlock, __xn_exec_primary|__xn_exec_norestart},
 	[__pse51_cond_init] = {&__pthread_cond_init, __xn_exec_any},
 	[__pse51_cond_destroy] = {&__pthread_cond_destroy, __xn_exec_any},
@@ -2763,6 +2786,9 @@ static xnsysent_t __systab[] = {
 	[__pse51_condattr_setpshared] =
 	    {&__pthread_condattr_setpshared, __xn_exec_any},
 	[__pse51_select] = {&__select, __xn_exec_primary},
+#ifdef CONFIG_XENO_FASTSEM
+        [__pse51_check_init] = {&__pthread_mutex_check_init, __xn_exec_any},
+#endif
 };
 
 static void __shadow_delete_hook(xnthread_t *thread)
Index: b/src/skins/posix/mutex.c
===================================================================
--- a/src/skins/posix/mutex.c
+++ b/src/skins/posix/mutex.c
@@ -301,7 +301,11 @@ int __wrap_pthread_mutex_trylock(pthread
 			++shadow->lockcnt;
 			err = 0;
 		}
-	}
+	} else
+		do {
+			err = XENOMAI_SKINCALL1(__pse51_muxid,
+						__pse51_mutex_trylock, shadow);
+		} while (err == -EINTR);
 
   out:
 	cb_read_unlock(&shadow->lock, s);
Index: b/include/posix/syscall.h
===================================================================
--- a/include/posix/syscall.h
+++ b/include/posix/syscall.h
@@ -46,7 +46,6 @@
 #define __pse51_mutex_lock            20
 #define __pse51_mutex_timedlock       21
 #define __pse51_mutex_trylock         22
-#define __pse51_check_init            __pse51_mutex_trylock
 #define __pse51_mutex_unlock          23
 #define __pse51_cond_init             24
 #define __pse51_cond_destroy          25
@@ -102,6 +101,7 @@
 #define __pse51_thread_getschedparam  75
 #define __pse51_thread_kill           76
 #define __pse51_select                77
+#define __pse51_check_init            78
 
 #ifdef __KERNEL__
 


