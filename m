Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765D31AA94
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578533; cv=none; b=mh9CfNuHj5htwgszj+/3G8LfIgobXc9+CG/Q6XlI0tG0bAYfYxAXwuZIlAleMxheFh1nowU1wNwAYZpEm4vJLgP5L6d/RIfdbVJK36eW69Pn+VsX4anyQkyrdORlyOxHpHyyn32qovMW/r1AYf4mDuh8+lJYpxQvB5S291RsG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578533; c=relaxed/simple;
	bh=c0bcUrqxTAhpVsVdOM1IdfI5ERYKTWdcRBr8Y09X0PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4sNfnNg/P+5yDVAed/5pkXFZp+5MKRyzwB3LRsScqmEC8Z39P6oO8Yj4V7t6+fiGpBU84dyU5piP8wkRWvFKuP8ziTXUzdzFRf9mrTjW9BCNt75WP6+c1kq/cW2ApBf8TbSI3K5oYg3uUEOPHgGn7pJgi4sttMvi3GbMPKQgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MxlQIsyQ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MxlQIsyQ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202602200908461a95b6070900020730
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9+gj4ZZ58AxzYgYBXkZqWPShHNfqQG14yBb4L0f6JmI=;
 b=MxlQIsyQdWH6Gy2KS1z1Z8NycJvFLYGdTVcLUOeGV7pAp+JpljmxIOceHgMgBUzOHQUVEd
 2XXpBH3qwLMxdbhaKi7urUyWLT7y0KKzyc4z1k5q9eZZ3/Hw8RyxSgrai8UOiQu/xO9cEhX6
 h6QHnvwTEekGbmGWaj/a8DMDLJ76RCNpKTBCzl5BgX6vw6PYrIGJlk8EPl8+VbWfZCSWUdBv
 J4FtezEh5caWFtL7A/y2/RoTISkhPePYk06oATcn1dXkLDicrKI+2iM9Yx+Za+sKisiuCJK/
 6CoIVi5/LA4wjYbgXoEOujOyTvZW+YvDiGV5TqJHPh/0Y8AmwDnyVQPw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:50 +0100
Subject: [PATCH 07/20] lib/cobalt: cond: Move all time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-7-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement with some minor adjustments to the doxygen headers.
All services should remain in the cobalt_api_cond group.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/cond.c            | 87 ------------------------------------------
 lib/cobalt/wrappers_time64.c | 90 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 7be7fca01f53930f8504945206b2ee6ba6be1ba5..fb700f4500a6f1e7a0331954f7a5f5a8a3bf1052 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -282,93 +282,6 @@ COBALT_IMPL(int, pthread_cond_wait, (pthread_cond_t *cond, pthread_mutex_t *mute
 	return -err ?: -c.err;
 }
 
-/**
- * Wait a bounded time on a condition variable.
- *
- * This service is equivalent to pthread_cond_wait(), except that the calling
- * thread remains blocked on the condition variable @a cnd only until the
- * timeout specified by @a abstime expires.
- *
- * The timeout @a abstime is expressed as an absolute value of the @a clock
- * attribute passed to pthread_cond_init(). By default, @a CLOCK_REALTIME is
- * used.
- *
- * @param cond the condition variable to wait for;
- *
- * @param mutex the mutex associated with @a cnd;
- *
- * @param abstime the timeout, expressed as an absolute value of the clock
- * attribute passed to pthread_cond_init().
- *
- * @return 0 on success,
- * @return an error number if:
- * - EPERM, the caller context is invalid;
- * - EPERM, the specified condition variable is not process-shared and does not
- *   belong to the current process;
- * - EINVAL, the specified condition variable, mutex or timeout is invalid;
- * - EINVAL, another thread is currently blocked on @a cnd using another mutex
- *   than @a mx;
- * - EPERM, the specified mutex is not owned by the caller;
- * - ETIMEDOUT, the specified timeout expired.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/pthread_cond_timedwait.html">
- * Specification.</a>
- *
- * @apitags{xthread-only, switch-primary}
- */
-COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
-		   (pthread_cond_t *cond, pthread_mutex_t *mutex,
-		    const struct timespec *abstime))
-{
-	struct cobalt_cond_shadow *_cnd = &((union cobalt_cond_union *)cond)->shadow_cond;
-	struct cobalt_mutex_shadow *_mx =
-		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
-	struct cobalt_cond_cleanup_t c = {
-		.cond = _cnd,
-		.mutex = _mx,
-	};
-	int err, oldtype;
-
-	if (_mx->magic != COBALT_MUTEX_MAGIC)
-		return EINVAL;
-
-	err = cobalt_cond_autoinit((union cobalt_cond_union *)cond);
-	if (err)
-		return err;
-
-	if (_mx->attr.type == PTHREAD_MUTEX_ERRORCHECK) {
-		xnhandle_t cur = cobalt_get_current();
-
-		if (cur == XN_NO_HANDLE)
-			return EPERM;
-
-		if (xnsynch_fast_owner_check(mutex_get_ownerp(_mx), cur))
-			return EPERM;
-	}
-
-	c.count = _mx->lockcnt;
-
-	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-	err = do_sc_cond_wait_prologue(_cnd, _mx, &c.err, 1, abstime);
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	pthread_cleanup_pop(0);
-
-	while (err == -EINTR) {
-		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, _cnd, _mx);
-		pthread_testcancel();
-	}
-
-	_mx->lockcnt = c.count;
-
-	return -err ?: -c.err;
-}
-
 /**
  * Signal a condition variable.
  *
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index b50599b066f7e1141422e059dd9912307242d0af..8e70e0bb351d9fe18a68495383ed5a6a77dd5c18 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -5,6 +5,7 @@
  * time_t.
  */
 
+#include "cond.h"
 #include "internal.h"
 
 #include <asm/xenomai/syscall.h>
@@ -331,3 +332,92 @@ COBALT_IMPL_TIME64(time_t, time, __time64, (time_t *t))
 		*t = ts.tv_sec;
 	return ts.tv_sec;
 }
+
+/**
+ * Wait a bounded time on a condition variable.
+ * @ingroup cobalt_api_cond
+ *
+ * This service is equivalent to pthread_cond_wait(), except that the calling
+ * thread remains blocked on the condition variable @a cnd only until the
+ * timeout specified by @a abstime expires.
+ *
+ * The timeout @a abstime is expressed as an absolute value of the @a clock
+ * attribute passed to pthread_cond_init(). By default, @a CLOCK_REALTIME is
+ * used.
+ *
+ * @param cond the condition variable to wait for;
+ *
+ * @param mutex the mutex associated with @a cnd;
+ *
+ * @param abstime the timeout, expressed as an absolute value of the clock
+ * attribute passed to pthread_cond_init().
+ *
+ * @return 0 on success,
+ * @return an error number if:
+ * - EPERM, the caller context is invalid;
+ * - EPERM, the specified condition variable is not process-shared and does not
+ *   belong to the current process;
+ * - EINVAL, the specified condition variable, mutex or timeout is invalid;
+ * - EINVAL, another thread is currently blocked on @a cnd using another mutex
+ *   than @a mx;
+ * - EPERM, the specified mutex is not owned by the caller;
+ * - ETIMEDOUT, the specified timeout expired.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/pthread_cond_timedwait.html">
+ * Specification.</a>
+ *
+ * @apitags{xthread-only, switch-primary}
+ */
+COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
+		   (pthread_cond_t *cond, pthread_mutex_t *mutex,
+		    const struct timespec *abstime))
+{
+	struct cobalt_cond_shadow *_cnd =
+		&((union cobalt_cond_union *)cond)->shadow_cond;
+	struct cobalt_mutex_shadow *_mx =
+		&((union cobalt_mutex_union *)mutex)->shadow_mutex;
+	struct cobalt_cond_cleanup_t c = {
+		.cond = _cnd,
+		.mutex = _mx,
+	};
+	int err, oldtype;
+
+	if (_mx->magic != COBALT_MUTEX_MAGIC)
+		return EINVAL;
+
+	err = cobalt_cond_autoinit((union cobalt_cond_union *)cond);
+	if (err)
+		return err;
+
+	if (_mx->attr.type == PTHREAD_MUTEX_ERRORCHECK) {
+		xnhandle_t cur = cobalt_get_current();
+
+		if (cur == XN_NO_HANDLE)
+			return EPERM;
+
+		if (xnsynch_fast_owner_check(mutex_get_ownerp(_mx), cur))
+			return EPERM;
+	}
+
+	c.count = _mx->lockcnt;
+
+	pthread_cleanup_push(&__pthread_cond_cleanup, &c);
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	err = do_sc_cond_wait_prologue(_cnd, _mx, &c.err, 1, abstime);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	pthread_cleanup_pop(0);
+
+	while (err == -EINTR) {
+		err = XENOMAI_SYSCALL2(sc_cobalt_cond_wait_epilogue, _cnd, _mx);
+		pthread_testcancel();
+	}
+
+	_mx->lockcnt = c.count;
+
+	return -err ?: -c.err;
+}

-- 
2.53.0

