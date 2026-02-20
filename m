Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDFE31B100
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578540; cv=none; b=AVVJjnZHbLOaiUy6m+jnVdLshFvUvBnDEIuZjj3DbT61zBrmMmnU1xfpIkiPIONSutb4xppAIqqIeqJiEJBbv0h6CmHedeWrRBh+1snkfsAw4YzYKw0M2JPIyoVXijKItRM4GyZgpESVqlhtji2rGjGov6+UC3eXx7r+bWuvYPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578540; c=relaxed/simple;
	bh=2pm5+jS/cvA2vOdeXkV5U5bHJVLP1KyNwaQfuA7LLZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cq9HX4xAQf5/ohtSAGr/izb36dH73wjBpFtsr6grhnFkVLrSsXMr72IHtHpSLsOK7aI13BWyS/9NddMqsmbBa5vsTlWwJmpt/XEEEZRDMQ4oo8eC9I1aEEzkCvurrZa1ISCs6ujvgQ1FDciHWJCbZPzJCWbNP2CifnOFkj7qspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=M/lC6+xF; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="M/lC6+xF"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202602200908473500df18b50002079b
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=U3OELTDKKC1Lgk/UXdFtpqLHsn0nXlS1SeKESOA49Bk=;
 b=M/lC6+xF/N6ETARCC6XT7C/ipTw1v9JEcsdByBVj5bLbgbWIH5Fuj081I7J0NZh7r1z5F5
 Ta1635wHl2pX30VQOi4FhVK88JP3a8sVIMUA7jQeMRgwhQzr7EMcVq+SZeWRK7aHYtxVIFBN
 MlgMRiTAhS429EtXlC49JKaPSvKFNHqzxH1j5yqqQTK8NIzlPjkoJgBhGKpAUAZkWdKLIh/A
 IfyZC0nWNyrc0BWNMs+yYul3iObNdGxW4Bea7WMkIiOXmZMW0VbNSL+ul2h6JdF95/kxHBd0
 8y+aqYMgs9PPPpbTNVfaA4WInheiv2584FIxRaH0StTeDYlOkJEouEBw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:52 +0100
Subject: [PATCH 09/20] lib/cobalt: mutex: Move all time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-9-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement with some minor adjustments to the doxygen headers.
All services should remain in the cobalt_api_mutex group.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/mutex.c           | 131 ++-----------------------------------------
 lib/cobalt/wrappers_time64.c | 126 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 127 deletions(-)

diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 390305cddc94985ebed354c895783e24652c1025..edc4e46c065d2dd3695b74923f6758c512ce6909 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -16,15 +16,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <string.h>
-#include <pthread.h>
-#include <asm/xenomai/syscall.h>
-
 #include "current.h"
 #include "internal.h"
 #include "mutex.h"
 
+#include <asm/xenomai/syscall.h>
+
+#include <pthread.h>
+
 /**
  * @ingroup cobalt_api
  * @defgroup cobalt_api_mutex Mutual exclusion
@@ -328,128 +327,6 @@ int pthread_mutex_lock_interruptible_np(pthread_mutex_t *mutex)
 	return __pthread_mutex_lock(mutex);
 }
 
-/**
- * Attempt, during a bounded time, to lock a mutex.
- *
- * This service is equivalent to pthread_mutex_lock(), except that if the mutex
- * @a mx is locked by another thread than the current one, this service only
- * suspends the current thread until the timeout specified by @a to expires.
- *
- * @param mutex the mutex to be locked;
- *
- * @param to the timeout, expressed as an absolute value of the CLOCK_REALTIME
- * clock.
- *
- * @return 0 on success;
- * @return an error number if:
- * - EPERM, the caller is not allowed to perform the operation;
- * - EINVAL, the mutex @a mx is invalid;
- * - EPERM, the mutex is not process-shared and does not belong to the current
- *   process;
- * - ETIMEDOUT, the mutex could not be locked and the specified timeout
- *   expired;
- * - EDEADLK, the mutex is of the @a PTHREAD_MUTEX_ERRORCHECK type and the mutex
- *   was already locked by the current thread;
- * - EAGAIN, the mutex is of the @a PTHREAD_MUTEX_RECURSIVE type and the maximum
- *   number of recursive locks has been exceeded.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_timedlock.html">
- * Specification.</a>
- *
- * @apitags{xthread-only, switch-primary}
- */
-static int __pthread_mutex_timedlock(pthread_mutex_t *mutex, const struct timespec *to)
-{
-	struct cobalt_mutex_shadow *_mutex =
-		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
-	struct xnthread_user_window *u_window;
-	int status, ret, lazy_protect = 0;
-	xnhandle_t cur;
-
-	cur = cobalt_get_current();
-	if (cur == XN_NO_HANDLE)
-		return EPERM;
-
-	ret = cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
-	if (ret)
-		return ret;
-
-	/* See __cobalt_pthread_mutex_lock() */
-	status = cobalt_get_current_mode();
-	if ((status & (XNRELAX|XNWEAK|XNDEBUG)) == 0) {
-		if (_mutex->attr.protocol == PTHREAD_PRIO_PROTECT)
-			goto protect;
-fast_path:
-		ret = xnsynch_fast_acquire(mutex_get_ownerp(_mutex), cur);
-		if (ret == 0) {
-			_mutex->lockcnt = 1;
-			return 0;
-		}
-	} else {
-slow_path:
-		ret = xnsynch_fast_owner_check(mutex_get_ownerp(_mutex), cur);
-		if (ret == 0)
-			ret = -EBUSY;
-	}
-
-	if (ret == -EBUSY) {
-		if (lazy_protect)
-			u_window->pp_pending = XN_NO_HANDLE;
-			
-		switch(_mutex->attr.type) {
-		case PTHREAD_MUTEX_NORMAL:
-			break;
-
-		case PTHREAD_MUTEX_ERRORCHECK:
-			return EDEADLK;
-
-		case PTHREAD_MUTEX_RECURSIVE:
-			if (_mutex->lockcnt == UINT32_MAX)
-				return EAGAIN;
-
-			++_mutex->lockcnt;
-			return 0;
-		}
-	}
-
-#ifdef __USE_TIME_BITS64
-	ret = XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock64, _mutex, to);
-#else
-	ret = XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock, _mutex, to);
-#endif
-
-	if (ret == 0)
-		_mutex->lockcnt = 1;
-	return -ret;
-protect:	
-	u_window = cobalt_get_current_window();
-	/*
-	 * Can't nest lazy ceiling requests, have to take the slow
-	 * path when this happens.
-	 */
-	if (u_window->pp_pending != XN_NO_HANDLE)
-		goto slow_path;
-	u_window->pp_pending = _mutex->handle;
-	lazy_protect = 1;
-	goto fast_path;
-}
-
-COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
-		   (pthread_mutex_t *mutex, const struct timespec *to))
-{
-	int ret;
-	do
-		ret = __pthread_mutex_timedlock(mutex, to);
-	while (ret == EINTR);
-	return ret;
-}
-
-int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex, const struct timespec *to)
-{
-	return __pthread_mutex_timedlock(mutex, to);
-}
-
 /**
  * Attempt to lock a mutex.
  *
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 46463560593a05a206e8b60b531c62ca21e209e0..8f37e310eb19f783199681fc167883b72ebdfa1f 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -7,6 +7,7 @@
 
 #include "cond.h"
 #include "internal.h"
+#include "mutex.h"
 #include "mq.h"
 
 #include <asm/xenomai/syscall.h>
@@ -546,3 +547,128 @@ COBALT_IMPL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
 	errno = -err;
 	return -1;
 }
+
+/**
+ * Attempt, during a bounded time, to lock a mutex.
+ * @ingroup cobalt_api_mutex
+ *
+ * This service is equivalent to pthread_mutex_lock(), except that if the mutex
+ * @a mx is locked by another thread than the current one, this service only
+ * suspends the current thread until the timeout specified by @a to expires.
+ *
+ * @param mutex the mutex to be locked;
+ *
+ * @param to the timeout, expressed as an absolute value of the CLOCK_REALTIME
+ * clock.
+ *
+ * @return 0 on success;
+ * @return an error number if:
+ * - EPERM, the caller is not allowed to perform the operation;
+ * - EINVAL, the mutex @a mx is invalid;
+ * - EPERM, the mutex is not process-shared and does not belong to the current
+ *   process;
+ * - ETIMEDOUT, the mutex could not be locked and the specified timeout
+ *   expired;
+ * - EDEADLK, the mutex is of the @a PTHREAD_MUTEX_ERRORCHECK type and the mutex
+ *   was already locked by the current thread;
+ * - EAGAIN, the mutex is of the @a PTHREAD_MUTEX_RECURSIVE type and the maximum
+ *   number of recursive locks has been exceeded.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/pthread_mutex_timedlock.html">
+ * Specification.</a>
+ *
+ * @apitags{xthread-only, switch-primary}
+ */
+static int __pthread_mutex_timedlock(pthread_mutex_t *mutex,
+				     const struct timespec *to)
+{
+	struct cobalt_mutex_shadow *_mutex =
+		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
+	struct xnthread_user_window *u_window;
+	int status, ret, lazy_protect = 0;
+	xnhandle_t cur;
+
+	cur = cobalt_get_current();
+	if (cur == XN_NO_HANDLE)
+		return EPERM;
+
+	ret = cobalt_mutex_autoinit((union cobalt_mutex_union *)mutex);
+	if (ret)
+		return ret;
+
+	/* See __cobalt_pthread_mutex_lock() */
+	status = cobalt_get_current_mode();
+	if ((status & (XNRELAX | XNWEAK | XNDEBUG)) == 0) {
+		if (_mutex->attr.protocol == PTHREAD_PRIO_PROTECT)
+			goto protect;
+	fast_path:
+		ret = xnsynch_fast_acquire(mutex_get_ownerp(_mutex), cur);
+		if (ret == 0) {
+			_mutex->lockcnt = 1;
+			return 0;
+		}
+	} else {
+	slow_path:
+		ret = xnsynch_fast_owner_check(mutex_get_ownerp(_mutex), cur);
+		if (ret == 0)
+			ret = -EBUSY;
+	}
+
+	if (ret == -EBUSY) {
+		if (lazy_protect)
+			u_window->pp_pending = XN_NO_HANDLE;
+
+		switch (_mutex->attr.type) {
+		case PTHREAD_MUTEX_NORMAL:
+			break;
+
+		case PTHREAD_MUTEX_ERRORCHECK:
+			return EDEADLK;
+
+		case PTHREAD_MUTEX_RECURSIVE:
+			if (_mutex->lockcnt == UINT32_MAX)
+				return EAGAIN;
+
+			++_mutex->lockcnt;
+			return 0;
+		}
+	}
+
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock64, _mutex, to);
+#else
+	ret = XENOMAI_SYSCALL2(sc_cobalt_mutex_timedlock, _mutex, to);
+#endif
+
+	if (ret == 0)
+		_mutex->lockcnt = 1;
+	return -ret;
+protect:
+	u_window = cobalt_get_current_window();
+	/*
+	 * Can't nest lazy ceiling requests, have to take the slow
+	 * path when this happens.
+	 */
+	if (u_window->pp_pending != XN_NO_HANDLE)
+		goto slow_path;
+	u_window->pp_pending = _mutex->handle;
+	lazy_protect = 1;
+	goto fast_path;
+}
+
+COBALT_IMPL_TIME64(int, pthread_mutex_timedlock, __pthread_mutex_timedlock64,
+		   (pthread_mutex_t * mutex, const struct timespec *to))
+{
+	int ret;
+	do
+		ret = __pthread_mutex_timedlock(mutex, to);
+	while (ret == EINTR);
+	return ret;
+}
+
+int pthread_timedmutex_lock_interruptible_np(pthread_mutex_t *mutex,
+					     const struct timespec *to)
+{
+	return __pthread_mutex_timedlock(mutex, to);
+}

-- 
2.53.0

