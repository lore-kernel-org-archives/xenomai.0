Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BD31B110
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578544; cv=none; b=S+ZT9mzCP5BDn0rYzKT1tagiDm3jiIrOSXar/+0WtLLToYaDTn8WWW8ORlpxmIAyQHxq/bKUBjusCNkMkpWhc9Nw8cr+WKP+33joc5/J9ysJrr+Zcom0ZbObYA5fkBj+tKTWKA0HcCzJ3BqsNYwIqvh1Hz2rdOuFwnz8Ry4UhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578544; c=relaxed/simple;
	bh=wGeg6aTRPysCScxugvUu6d0ff5QizzGSnrC0P+vdn3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3JDrupqAyRDMkc3KLnR0IZeeUWUPzDYo4k8guOSBRnbjO5f6M5+5mHpN2XU1jppxNcqSeKRnZMgr6ZnegUZVp/EhfEH7J0a7FhyzbAWC67CZnc6vYIrrJjT53pK3VZe8O3wyClC3MzZDajg6063sF1M8fO5CtZTNu8mhSW7h48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ugg2w5mh; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ugg2w5mh"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260220090848cf838b383200020708
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GO/Fi9uxH16oY9DRHcsJLJaFldOD+TLsIJSwFsVFmOk=;
 b=Ugg2w5mhPESmPhD5yrcsxa9evBz6zLdymo2S0qkNr01M0EXfT69wV1zbYxs84rHYBebB+O
 DqOXd8PfJDAogI5uEPye1XCLsRekzDy0BD4I3i0l1rwOka8cKgdY0ewIBzZ6zROPMsFPIg2v
 c80SZppJQnm5qaF7OJs48n8zUWfqqr2Llaj8piDKrhXY4PPQjKPm3GTiGTKzcMIkJNo1w6SI
 fLkSpu7Rvti/e5id3biAsgkMXo1PsQv5j5MfH30ZmVy84oEF3NdRDa1ZmJhD+oL5s7IOCRq/
 bcreVL0fp1v07ysSVNlj/E7W9XS5OcotSw7mfqCVTISKVBzB/cI2OFsA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:58 +0100
Subject: [PATCH 15/20] lib/cobalt: timer: Move all time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-15-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
index 5219802c408cecde50d4088a8cd692d4354346ab..b4714f22ce3d632cf11456838854df9093b83902 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -925,3 +925,121 @@ COBALT_IMPL_TIME64(int, sigtimedwait, __sigtimedwait64,
 
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

