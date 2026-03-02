Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F238F631
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444301; cv=none; b=bC7vq+7i5UGzWvxgReC+7Sszi7aYF2dO6UXuF/jwNlR9m/3hUdBXFJXeN3xrzfMNghZv/qOKSZ0fWckYhuC8Q4mzV8wrgKQsN7hA1VY+/8OBln1UsS7tNCsUtUXbQazOZ2/7pLVsgBmJztopNZt5lkucW0Qlo6vf32wvM2C4WKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444301; c=relaxed/simple;
	bh=MHQh/6XaOtv2wKWCYl2W92acIKJIJ4JJNYfz0UbdGn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv+Ws49s9wYe78b0WW9bwYT5z0ytrKioU4TA3UqPEt0T7j9HlGh4ou3lKReEYdlcy9dOnllvQJvPkOqe0jI78rGLU5BGid7vAWV2+lwSEV6mnA6KSEuHiPs8/ma9SQ8QXzYTre0ge+k6WOEF38geLMbd0zeCVy+efzh940iEdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KkGYCxk6; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KkGYCxk6"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260302093810e6426785b500020718
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lSS/OnbuVhhORQXvFpEKiCnxDeciJu/AwSW4t4sz10Q=;
 b=KkGYCxk6S/JLpu855mvNMxe6mhSIMpChnNXroJRGZAfXFttJ6eaIL3Uc6lcYfFo3PXxTmv
 joHJo8oC/6wPPlczUmoLAy8GIloRdHE6bzxLslrfeZdhavSMcSHV3qNo3u63unI+zSKkbQ7t
 57aC5mckAM/PJWsv7zLWPR3dFNtzunHROgFMAdM/jK0RYu3pDgkAUTbcXlcIZdi0vCBoqxJX
 AgYLcBE2itSmsi5qxDlj+o3L8fwExmbZ4F9wDcmP7aIg226BpneS3YKXVYjOK6QTsmjYnvuL
 BFQBnz8BrgxgQXWFAQc6bi1GuJOsOjnOdKgl+lK+yCtOjTZ0gwzdtUmw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:14 +0100
Subject: [PATCH v2 15/20] lib/cobalt: timer: Move all time64 related
 services to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-15-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement with some minor adjustments to the doxygen headers.
All services should remain in the cobalt_api_time group.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timer.c           | 121 ++-----------------------------------------
 lib/cobalt/wrappers_time64.c | 118 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 117 deletions(-)

diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index a9f91dfc99cc81373ac176c65685f14a545a46c9..0294953f8e69b63e55fe06fe4f7bbbd2b72a1e8d 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -16,10 +16,12 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include "internal.h"
+
+#include <asm/xenomai/syscall.h>
+
 #include <errno.h>
 #include <time.h>
-#include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 /**
  * @addtogroup cobalt_api_time
@@ -116,121 +118,6 @@ COBALT_IMPL(int, timer_delete, (timer_t timerid))
 	return -1;
 }
 
-/**
- * @fn timer_settime(timer_t timerid, int flags, const struct itimerspec *__restrict__ value, struct itimerspec *__restrict__ ovalue)
- * @brief Start or stop a timer
- *
- * This service sets a timer expiration date and reload value of the
- * timer @a timerid. If @a ovalue is not @a NULL, the current
- * expiration date and reload value are stored at the address @a
- * ovalue as with timer_gettime().
- *
- * If the member @a it_value of the @b itimerspec structure at @a
- * value is zero, the timer is stopped, otherwise the timer is
- * started. If the member @a it_interval is not zero, the timer is
- * periodic. The current thread must be a Cobalt thread (created with
- * pthread_create()) and will be notified via signal of timer
- * expirations.
- *
- * When starting the timer, if @a flags is TIMER_ABSTIME, the expiration value
- * is interpreted as an absolute date of the clock passed to the timer_create()
- * service. Otherwise, the expiration value is interpreted as a time interval.
- *
- * Expiration date and reload value are rounded to an integer count of
- * nanoseconds.
- *
- * @param timerid identifier of the timer to be started or stopped;
- *
- * @param flags one of 0 or TIMER_ABSTIME;
- *
- * @param value address where the specified timer expiration date and reload
- * value are read;
- *
- * @param ovalue address where the specified timer previous expiration date and
- * reload value are stored if not @a NULL.
- *
- * @retval 0 on success;
- * @retval -1 with @a errno set if:
- * - EINVAL, the specified timer identifier, expiration date or reload value is
- *   invalid. For @a timerid to be valid, it must belong to the current process.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/timer_settime.html">
- * Specification.</a>
- *
- * @apitags{xcontext, switch-primary}
- */
-COBALT_IMPL_TIME64(int, timer_settime, __timer_settime64,
-		   (timer_t timerid, int flags,
-		    const struct itimerspec *__restrict__ value,
-		    struct itimerspec *__restrict__ ovalue))
-{
-	int ret;
-
-#ifdef XN_USE_TIME64_SYSCALL
-	long sc_nr = sc_cobalt_timer_settime64;
-#else
-	long sc_nr = sc_cobalt_timer_settime;
-#endif
-
-	ret = -XENOMAI_SYSCALL4(sc_nr, timerid, flags, value, ovalue);
-	if (ret == 0)
-		return 0;
-
-	errno = ret;
-
-	return -1;
-}
-
-/**
- * @fn int timer_gettime(timer_t timerid, struct itimerspec *value)
- * @brief Get timer next expiration date and reload value.
- *
- * This service stores, at the address @a value, the expiration date
- * (member @a it_value) and reload value (member @a it_interval) of
- * the timer @a timerid. The values are returned as time intervals,
- * and as multiples of the system clock tick duration (see note in
- * section @ref cobalt_api_time "Clocks and timers services" for details
- * on the duration of the system clock tick). If the timer was not
- * started, the returned members @a it_value and @a it_interval of @a
- * value are zero.
- *
- * @param timerid timer identifier;
- *
- * @param value address where the timer expiration date and reload value are
- * stored on success.
- *
- * @retval 0 on success;
- * @retval -1 with @a errno set if:
- * - EINVAL, @a timerid is invalid. For @a timerid to be valid, it
- * must belong to the current process.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/timer_gettime.html">
- * Specification.</a>
- *
- * @apitags{unrestricted}
- */
-COBALT_IMPL_TIME64(int, timer_gettime, __timer_gettime64,
-		   (timer_t timerid, struct itimerspec *value))
-{
-	int ret;
-
-#ifdef XN_USE_TIME64_SYSCALL
-	long sc_nr = sc_cobalt_timer_gettime64;
-#else
-	long sc_nr = sc_cobalt_timer_gettime;
-#endif
-
-	ret = -XENOMAI_SYSCALL2(sc_nr, timerid, value);
-	if (ret == 0)
-		return 0;
-
-	errno = ret;
-
-	return -1;
-}
-
 /**
  * Get expiration overruns count since the most recent timer expiration
  * signal delivery.
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 42f8088922286ed991a8ba9bdb3f63c19e51a0ee..138058b55adb0e735452c09a745920726dd6ec0f 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -933,3 +933,121 @@ COBALT_IMPL_TIME64(int, sigtimedwait, __sigtimedwait64,
 
 	return ret;
 }
+
+/**
+ * @fn timer_settime(timer_t timerid, int flags, const struct itimerspec *__restrict__ value, struct itimerspec *__restrict__ ovalue)
+ * @brief Start or stop a timer
+ * @ingroup cobalt_api_time
+ *
+ * This service sets a timer expiration date and reload value of the
+ * timer @a timerid. If @a ovalue is not @a NULL, the current
+ * expiration date and reload value are stored at the address @a
+ * ovalue as with timer_gettime().
+ *
+ * If the member @a it_value of the @b itimerspec structure at @a
+ * value is zero, the timer is stopped, otherwise the timer is
+ * started. If the member @a it_interval is not zero, the timer is
+ * periodic. The current thread must be a Cobalt thread (created with
+ * pthread_create()) and will be notified via signal of timer
+ * expirations.
+ *
+ * When starting the timer, if @a flags is TIMER_ABSTIME, the expiration value
+ * is interpreted as an absolute date of the clock passed to the timer_create()
+ * service. Otherwise, the expiration value is interpreted as a time interval.
+ *
+ * Expiration date and reload value are rounded to an integer count of
+ * nanoseconds.
+ *
+ * @param timerid identifier of the timer to be started or stopped;
+ *
+ * @param flags one of 0 or TIMER_ABSTIME;
+ *
+ * @param value address where the specified timer expiration date and reload
+ * value are read;
+ *
+ * @param ovalue address where the specified timer previous expiration date and
+ * reload value are stored if not @a NULL.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EINVAL, the specified timer identifier, expiration date or reload value is
+ *   invalid. For @a timerid to be valid, it must belong to the current process.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/timer_settime.html">
+ * Specification.</a>
+ *
+ * @apitags{xcontext, switch-primary}
+ */
+COBALT_IMPL_TIME64(int, timer_settime, __timer_settime64,
+		   (timer_t timerid, int flags,
+		    const struct itimerspec *__restrict__ value,
+		    struct itimerspec *__restrict__ ovalue))
+{
+	int ret;
+
+#ifdef XN_USE_TIME64_SYSCALL
+	long sc_nr = sc_cobalt_timer_settime64;
+#else
+	long sc_nr = sc_cobalt_timer_settime;
+#endif
+
+	ret = -XENOMAI_SYSCALL4(sc_nr, timerid, flags, value, ovalue);
+	if (ret == 0)
+		return 0;
+
+	errno = ret;
+
+	return -1;
+}
+
+
+/**
+ * @fn int timer_gettime(timer_t timerid, struct itimerspec *value)
+ * @brief Get timer next expiration date and reload value.
+ * @ingroup cobalt_api_time
+ *
+ * This service stores, at the address @a value, the expiration date
+ * (member @a it_value) and reload value (member @a it_interval) of
+ * the timer @a timerid. The values are returned as time intervals,
+ * and as multiples of the system clock tick duration (see note in
+ * section @ref cobalt_api_time "Clocks and timers services" for details
+ * on the duration of the system clock tick). If the timer was not
+ * started, the returned members @a it_value and @a it_interval of @a
+ * value are zero.
+ *
+ * @param timerid timer identifier;
+ *
+ * @param value address where the timer expiration date and reload value are
+ * stored on success.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EINVAL, @a timerid is invalid. For @a timerid to be valid, it
+ * must belong to the current process.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/timer_gettime.html">
+ * Specification.</a>
+ *
+ * @apitags{unrestricted}
+ */
+COBALT_IMPL_TIME64(int, timer_gettime, __timer_gettime64,
+		   (timer_t timerid, struct itimerspec *value))
+{
+	int ret;
+
+#ifdef XN_USE_TIME64_SYSCALL
+	long sc_nr = sc_cobalt_timer_gettime64;
+#else
+	long sc_nr = sc_cobalt_timer_gettime;
+#endif
+
+	ret = -XENOMAI_SYSCALL2(sc_nr, timerid, value);
+	if (ret == 0)
+		return 0;
+
+	errno = ret;
+
+	return -1;
+}

-- 
2.53.0

