Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C538F628
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444303; cv=none; b=AZsiXUuwsoRzX2KexEBQYn3DPlcXCu2wzC5Jh1as2ShLuvZhIvU0HbJR1nOVN0cJ+0nXjvkExXpANHYIwT84wCIlP1t/ukS5lsPE+6XZlb1iwK0eRopLMxy0LGsVe4de7S57p53P70PDxF3n3plTmEnv11z22qiWw/SzAKJtwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444303; c=relaxed/simple;
	bh=yrM7oJdQhipCh77CuGmPRWAPV7Z1+kL4LWlhaXkn0f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSq1Fvdee/wu68Wvbe/AlIoL2N7Z0eWP8O0YKS8hY3e9gwKOc8jgN337YsqRiEYIvZamPhxiK9t9ZUzmlEN10DB+QylWj7+lui3gmBWoxxrutdUaUy+7sL2+MwOH0Ubpc1DRTS4614VL2eharh/tXntqxWJw3kUNtkKpyFEceKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=F+DQI5Qj; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="F+DQI5Qj"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202603020938088e8a439ee300020795
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/PM9QSHojz0qRi42GrCt7D8NLknfdKaAC2tu9hldHic=;
 b=F+DQI5Qj2ajcQkC76uFq7L/aoDkc44Kk2q2MJeDyqrHXvhWnqEZwTje6T4NEUZbgs35tO5
 doueJZX5lmXkB1Q152JWDUx/Hj0m6X4XK+XmKsWHPzRaSjyqFEXNhwTG22aUyTT3q4oHmDt+
 dmO7Oq0+tOze/4zYumU5oCXGHL0XEm8MzhhfTAuZ/f6fjn7Pe1oeyG40FWRij60KQZV10qhw
 0WknxSo8slk+zpe9nS/ns5tVWP0rIRwmvltsZWPXbL9ASz/YbRiCDbc+NxeMcgPVZMW/XaE1
 cYD2bFhEFXfVXCreM3wVpOT3Hy4PDUFoUNZ6VN3ba8TctL0Yfrkt1JcA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:08 +0100
Subject: [PATCH v2 09/20] lib/cobalt: mutex: Move all time64 related
 services to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-9-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
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
index 09930ab018104dcc2a54c354b4b756230cfda029..25581fd6f0b2b0405d575435a0ba81c397244aad 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -15,6 +15,7 @@
 #include "cond.h"
 #include "internal.h"
 #include "mq.h"
+#include "mutex.h"
 
 #include <asm/xenomai/syscall.h>
 #include <cobalt/uapi/syscall.h>
@@ -553,3 +554,128 @@ COBALT_IMPL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
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

