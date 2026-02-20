Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F231AF25
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578542; cv=none; b=eUol+I9pzW5XUaD3ALxHHx7I0zPTROxQZQSWb49PS+KNeUKPPAHHJad1qeT31/XZuc8P4FUWFluyX57v63AGk1Hb7RotIJHNjSVgmT9Ndeo/OGasfPMsm10++Hoy7dzUyTHI5/9WSfegrKYNEmjf7bg15lt/llhp9osPHLQnPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578542; c=relaxed/simple;
	bh=0GN/k4fMKZYiwOgEuyuGE+d2k2erun/HsIqp+2rj6B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKVmggFzo2VZ0O/akOLx+Z+LWoLBOiTIMx4e7HgsgiJ1NGFzjHz9tlSI4ShN2OUe3OBgFQ7G5yFU3QI63ZU74zXTRzYZ2Y4kwZqsS79XGmQPxhxUNuJWX8yiibEBnwIY684PRQoMUfgUOnhwfOzqTM2MXMlb6dPaR5hqAZCsa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MSYl5KzZ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MSYl5KzZ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260220090846078b8e731800020797
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AtiJCecL4DO8HfM1VJ+/jQPdSplHxx5XDBrSev816Ow=;
 b=MSYl5KzZPjLZJikkVafVq/FrKPImed3UxCcGBdaChBukWO+K55AlWDEaDqv449sGyWYo98
 N2TDHIl8sV6nvV6BKAl5kY2jq/P6JbyXYRR2l9yIm+zpBXG+3Wn6Ifc/oPisfqQ5qiN+HHuz
 0EhIBCs/IqjGDsjP4pRNG1yoHjHIs5CnU/jYvBUCTyvfuSZo1o9jLieDBg83ZQLXUD9fqyE+
 FsLOzdB1AX1yXAKmw0RFIHTJHfpdg+gS36U5jmQfBjlM5CBHTo/qjcAfTssen3wUV1SOnZTo
 VRTlJhEhcWncbpwxYQLbNi998BDNavS+4s8MJwcpp7d+XfxIXEvcC9wQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:49 +0100
Subject: [PATCH 06/20] lib/cobalt: clock: Move all time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-6-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement with some minor adjustments to the doxygen headers.
All services should remain in the cobalt_api_time group.

Some comments have been changed from /* to /** to reflect the doxygen
style. I think those doc information was not properly processed in the
past.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/clock.c           | 309 +---------------------------------------
 lib/cobalt/wrappers_time64.c | 327 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 328 insertions(+), 308 deletions(-)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 65abf5eacf5185e944915fecc44ff7760202ab19..9551bd5f1a5be21eaec1f5c611396f545eb84eb2 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -20,9 +20,7 @@
 #include <errno.h>
 #include <pthread.h>
 #include <unistd.h>
-#include <time.h>
-#include <sys/time.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 /**
@@ -65,284 +63,6 @@
  *@{
  */
 
-/**
- * Get the resolution of the specified clock.
- *
- * This service returns, at the address @a res, if it is not @a NULL, the
- * resolution of the clock @a clock_id.
- *
- * For both CLOCK_REALTIME and CLOCK_MONOTONIC, this resolution is the duration
- * of one system clock tick. No other clock is supported.
- *
- * @param clock_id clock identifier, either CLOCK_REALTIME or CLOCK_MONOTONIC;
- *
- * @param tp the address where the resolution of the specified clock will be
- * stored on success.
- *
- * @retval 0 on success;
- * @retval -1 with @a errno set if:
- * - EINVAL, @a clock_id is invalid;
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_getres.html">
- * Specification.</a>
- *
- * @apitags{unrestricted}
- */
-COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
-		   (clockid_t clock_id, struct timespec *tp))
-{
-	int ret;
-
-#ifdef __USE_TIME_BITS64
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_getres64, clock_id, tp);
-#else
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_getres, clock_id, tp);
-#endif
-
-	if (ret) {
-		errno = ret;
-		return -1;
-	}
-
-	return 0;
-}
-
-static int __do_clock_gettime(clockid_t clock_id, struct timespec *tp)
-{
-#ifdef __USE_TIME_BITS64
-	return -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime64, clock_id, tp);
-#else
-	return -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
-#endif
-}
-
-/**
- * Read the specified clock.
- *
- * This service returns, at the address @a tp the current value of the clock @a
- * clock_id. If @a clock_id is:
- * - CLOCK_REALTIME, the clock value represents the amount of time since the
- *   Epoch, with a precision of one system clock tick;
- * - CLOCK_MONOTONIC or CLOCK_MONOTONIC_RAW, the clock value is given
- *   by an architecture-dependent high resolution counter, with a
- *   precision independent from the system clock tick duration.
- * - CLOCK_HOST_REALTIME, the clock value as seen by the host, typically
- *   Linux. Resolution and precision depend on the host, but it is guaranteed
- *   that both, host and Cobalt, see the same information.
- *
- * @param clock_id clock identifier, either CLOCK_REALTIME, CLOCK_MONOTONIC,
- *        or CLOCK_HOST_REALTIME;
- *
- * @param tp the address where the value of the specified clock will be stored.
- *
- * @retval 0 on success;
- * @retval -1 with @a errno set if:
- * - EINVAL, @a clock_id is invalid.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_gettime.html">
- * Specification.</a>
- *
- * @apitags{unrestricted}
- */
-COBALT_IMPL_TIME64(int, clock_gettime, __clock_gettime64,
-		   (clockid_t clock_id, struct timespec *tp))
-{
-	int ret;
-
-	switch (clock_id) {
-	case CLOCK_REALTIME:
-	case CLOCK_HOST_REALTIME:
-		ret = __cobalt_vdso_gettime(CLOCK_REALTIME, tp);
-		break;
-	case CLOCK_MONOTONIC:
-	case CLOCK_MONOTONIC_RAW:
-		ret = __cobalt_vdso_gettime(clock_id, tp);
-		break;
-	default:
-		ret = __do_clock_gettime(clock_id, tp);
-	}
-
-	if (ret) {
-		errno = ret;
-		return -1;
-	}
-
-	return 0;
-}
-
-/**
- * Set the specified clock.
- *
- * Set the CLOCK_REALTIME or Cobalt-specific clocks.
- *
- * @param clock_id the id of the clock to be set. CLOCK_REALTIME,
- * and Cobalt-specific clocks are supported.
- *
- * @param tp the address of a struct timespec specifying the new date.
- *
- * @retval 0 on success;
- * @retval -1 with @a errno set if:
- * - EINVAL, @a clock_id is undefined;
- * - EINVAL, the date specified by @a tp is invalid.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_settime.html">
- * Specification.</a>
- *
- * @note Setting CLOCK_REALTIME may cause the caller to switch to
- * secondary mode.
- *
- * @apitags{unrestricted, switch-secondary}
- */
-COBALT_IMPL_TIME64(int, clock_settime, __clock_settime64,
-		   (clockid_t clock_id, const struct timespec *tp))
-{
-	int ret;
-
-	if (clock_id == CLOCK_REALTIME)
-		return __STD(clock_settime(CLOCK_REALTIME, tp));
-
-#ifdef __USE_TIME_BITS64
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime64, clock_id, tp);
-#else
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
-#endif
-	if (ret) {
-		errno = ret;
-		return -1;
-	}
-
-	return 0;
-}
-
-/* @apitags{unrestricted} */
-
-COBALT_IMPL_TIME64(int, clock_adjtime, __clock_adjtime64,
-		   (clockid_t clock_id, struct timex *tx))
-{
-	int ret;
-
-#ifdef XN_USE_TIME64_SYSCALL
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime64, clock_id, tx);
-#else
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime, clock_id, tx);
-#endif
-
-	if (ret < 0) {
-		errno = ret;
-		return -1;
-	}
-
-	return ret;
-}
-
-/**
- * Sleep some amount of time.
- *
- * This service suspends the calling thread until the wakeup time specified by
- * @a rqtp, or a signal is delivered to the caller. If the flag TIMER_ABSTIME is
- * set in the @a flags argument, the wakeup time is specified as an absolute
- * value of the clock @a clock_id. If the flag TIMER_ABSTIME is not set, the
- * wakeup time is specified as a time interval.
- *
- * If this service is interrupted by a signal, the flag TIMER_ABSTIME is not
- * set, and @a rmtp is not @a NULL, the time remaining until the specified
- * wakeup time is returned at the address @a rmtp.
- *
- * The resolution of this service is one system clock tick.
- *
- * @param clock_id clock identifier, either CLOCK_REALTIME or CLOCK_MONOTONIC.
- *
- * @param flags one of:
- * - 0 meaning that the wakeup time @a rqtp is a time interval;
- * - TIMER_ABSTIME, meaning that the wakeup time is an absolute value of the
- *   clock @a clock_id.
- *
- * @param rqtp address of the wakeup time.
- *
- * @param rmtp address where the remaining time before wakeup will be stored if
- * the service is interrupted by a signal.
- *
- * @return 0 on success;
- * @return an error number if:
- * - EPERM, the caller context is invalid;
- * - ENOTSUP, the specified clock is unsupported;
- * - EINVAL, the specified wakeup time is invalid;
- * - EINTR, this service was interrupted by a signal.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_nanosleep.html">
- * Specification.</a>
- *
- * @apitags{xthread-only, switch-primary}
- */
-COBALT_IMPL_TIME64(int, clock_nanosleep, __clock_nanosleep_time64,
-		   (clockid_t clock_id, int flags, const struct timespec *rqtp,
-		    struct timespec *rmtp))
-{
-	int ret, oldtype;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-#ifdef __USE_TIME_BITS64
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep64,
-				clock_id, flags, rqtp, rmtp);
-#else
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep,
-				clock_id, flags, rqtp, rmtp);
-#endif
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	return ret;
-}
-
-/**
- * Sleep some amount of time.
- *
- * This service suspends the calling thread until the wakeup time specified by
- * @a rqtp, or a signal is delivered. The wakeup time is specified as a time
- * interval.
- *
- * If this service is interrupted by a signal and @a rmtp is not @a NULL, the
- * time remaining until the specified wakeup time is returned at the address @a
- * rmtp.
- *
- * The resolution of this service is one system clock tick.
- *
- * @param rqtp address of the wakeup time.
- *
- * @param rmtp address where the remaining time before wakeup will be stored if
- * the service is interrupted by a signal.
- *
- * @retval 0 on success;
- * @retval -1 with @a errno set if:
- * - EPERM, the caller context is invalid;
- * - EINVAL, the specified wakeup time is invalid;
- * - EINTR, this service was interrupted by a signal.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/nanosleep.html">
- * Specification.</a>
- *
- * @apitags{xthread-only, switch-primary}
- */
-COBALT_IMPL_TIME64(int, nanosleep, __nanosleep64,
-		   (const struct timespec *rqtp, struct timespec *rmtp))
-{
-	int ret;
-
-	ret = __WRAP(clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp));
-	if (ret) {
-		errno = ret;
-		return -1;
-	}
-
-	return 0;
-}
-
 /* @apitags{thread-unrestricted, switch-primary} */
 
 COBALT_IMPL(unsigned int, sleep, (unsigned int seconds))
@@ -376,31 +96,4 @@ COBALT_IMPL(int, usleep, (useconds_t usec))
 	return __WRAP(clock_nanosleep(CLOCK_MONOTONIC, 0, &rqt, NULL));
 }
 
-/* @apitags{unrestricted} */
-
-COBALT_IMPL_TIME64(int, gettimeofday, __gettimeofday64,
-		   (struct timeval *tv, struct timezone *tz))
-{
-	struct timespec ts;
-	int ret = __WRAP(clock_gettime(CLOCK_REALTIME, &ts));
-	if (ret == 0) {
-		tv->tv_sec = ts.tv_sec;
-		tv->tv_usec = ts.tv_nsec / 1000;
-	}
-	return ret;
-}
-
-/* @apitags{unrestricted} */
-
-COBALT_IMPL_TIME64(time_t, time, __time64, (time_t *t))
-{
-	struct timespec ts;
-	int ret = __WRAP(clock_gettime(CLOCK_REALTIME, &ts));
-	if (ret)
-		return (time_t)-1;
-
-	if (t)
-		*t = ts.tv_sec;
-	return ts.tv_sec;
-}
 /** @} */
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 4c4e0db0650b49f46cbd6d9ecf7cd656bb04bbe4..b50599b066f7e1141422e059dd9912307242d0af 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -4,3 +4,330 @@
  * and requested. The first time with time64_t and a second time with native
  * time_t.
  */
+
+#include "internal.h"
+
+#include <asm/xenomai/syscall.h>
+#include <cobalt/uapi/syscall.h>
+
+#include <errno.h>
+#include <pthread.h>
+#include <sys/time.h>
+#include <time.h>
+
+/**
+ * Get the resolution of the specified clock.
+ * @ingroup cobalt_api_time
+ *
+ * This service returns, at the address @a res, if it is not @a NULL, the
+ * resolution of the clock @a clock_id.
+ *
+ * For both CLOCK_REALTIME and CLOCK_MONOTONIC, this resolution is the duration
+ * of one system clock tick. No other clock is supported.
+ *
+ * @param clock_id clock identifier, either CLOCK_REALTIME or CLOCK_MONOTONIC;
+ *
+ * @param tp the address where the resolution of the specified clock will be
+ * stored on success.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EINVAL, @a clock_id is invalid;
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_getres.html">
+ * Specification.</a>
+ *
+ * @apitags{unrestricted}
+ */
+COBALT_IMPL_TIME64(int, clock_getres, __clock_getres64,
+		   (clockid_t clock_id, struct timespec *tp))
+{
+	int ret;
+
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_getres64, clock_id, tp);
+#else
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_getres, clock_id, tp);
+#endif
+
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int __do_clock_gettime(clockid_t clock_id, struct timespec *tp)
+{
+#ifdef __USE_TIME_BITS64
+	return -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime64, clock_id, tp);
+#else
+	return -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+#endif
+}
+
+/**
+ * Read the specified clock.
+ * @ingroup cobalt_api_time
+ *
+ * This service returns, at the address @a tp the current value of the clock @a
+ * clock_id. If @a clock_id is:
+ * - CLOCK_REALTIME, the clock value represents the amount of time since the
+ *   Epoch, with a precision of one system clock tick;
+ * - CLOCK_MONOTONIC or CLOCK_MONOTONIC_RAW, the clock value is given
+ *   by an architecture-dependent high resolution counter, with a
+ *   precision independent from the system clock tick duration.
+ * - CLOCK_HOST_REALTIME, the clock value as seen by the host, typically
+ *   Linux. Resolution and precision depend on the host, but it is guaranteed
+ *   that both, host and Cobalt, see the same information.
+ *
+ * @param clock_id clock identifier, either CLOCK_REALTIME, CLOCK_MONOTONIC,
+ *        or CLOCK_HOST_REALTIME;
+ *
+ * @param tp the address where the value of the specified clock will be stored.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EINVAL, @a clock_id is invalid.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_gettime.html">
+ * Specification.</a>
+ *
+ * @apitags{unrestricted}
+ */
+COBALT_IMPL_TIME64(int, clock_gettime, __clock_gettime64,
+		   (clockid_t clock_id, struct timespec *tp))
+{
+	int ret;
+
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+	case CLOCK_HOST_REALTIME:
+		ret = __cobalt_vdso_gettime(CLOCK_REALTIME, tp);
+		break;
+	case CLOCK_MONOTONIC:
+	case CLOCK_MONOTONIC_RAW:
+		ret = __cobalt_vdso_gettime(clock_id, tp);
+		break;
+	default:
+		ret = __do_clock_gettime(clock_id, tp);
+	}
+
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * Set the specified clock.
+ * @ingroup cobalt_api_time
+ *
+ * Set the CLOCK_REALTIME or Cobalt-specific clocks.
+ *
+ * @param clock_id the id of the clock to be set. CLOCK_REALTIME,
+ * and Cobalt-specific clocks are supported.
+ *
+ * @param tp the address of a struct timespec specifying the new date.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EINVAL, @a clock_id is undefined;
+ * - EINVAL, the date specified by @a tp is invalid.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_settime.html">
+ * Specification.</a>
+ *
+ * @note Setting CLOCK_REALTIME may cause the caller to switch to
+ * secondary mode.
+ *
+ * @apitags{unrestricted, switch-secondary}
+ */
+COBALT_IMPL_TIME64(int, clock_settime, __clock_settime64,
+		   (clockid_t clock_id, const struct timespec *tp))
+{
+	int ret;
+
+	if (clock_id == CLOCK_REALTIME)
+		return __STD(clock_settime(CLOCK_REALTIME, tp));
+
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime64, clock_id, tp);
+#else
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
+#endif
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * @ingroup cobalt_api_time
+ * @apitags{unrestricted}
+ */
+COBALT_IMPL_TIME64(int, clock_adjtime, __clock_adjtime64,
+		   (clockid_t clock_id, struct timex *tx))
+{
+	int ret;
+
+#ifdef XN_USE_TIME64_SYSCALL
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime64, clock_id, tx);
+#else
+	ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime, clock_id, tx);
+#endif
+
+	if (ret < 0) {
+		errno = ret;
+		return -1;
+	}
+
+	return ret;
+}
+
+/**
+ * Sleep some amount of time.
+ * @ingroup cobalt_api_time
+ *
+ * This service suspends the calling thread until the wakeup time specified by
+ * @a rqtp, or a signal is delivered to the caller. If the flag TIMER_ABSTIME is
+ * set in the @a flags argument, the wakeup time is specified as an absolute
+ * value of the clock @a clock_id. If the flag TIMER_ABSTIME is not set, the
+ * wakeup time is specified as a time interval.
+ *
+ * If this service is interrupted by a signal, the flag TIMER_ABSTIME is not
+ * set, and @a rmtp is not @a NULL, the time remaining until the specified
+ * wakeup time is returned at the address @a rmtp.
+ *
+ * The resolution of this service is one system clock tick.
+ *
+ * @param clock_id clock identifier, either CLOCK_REALTIME or CLOCK_MONOTONIC.
+ *
+ * @param flags one of:
+ * - 0 meaning that the wakeup time @a rqtp is a time interval;
+ * - TIMER_ABSTIME, meaning that the wakeup time is an absolute value of the
+ *   clock @a clock_id.
+ *
+ * @param rqtp address of the wakeup time.
+ *
+ * @param rmtp address where the remaining time before wakeup will be stored if
+ * the service is interrupted by a signal.
+ *
+ * @return 0 on success;
+ * @return an error number if:
+ * - EPERM, the caller context is invalid;
+ * - ENOTSUP, the specified clock is unsupported;
+ * - EINVAL, the specified wakeup time is invalid;
+ * - EINTR, this service was interrupted by a signal.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/clock_nanosleep.html">
+ * Specification.</a>
+ *
+ * @apitags{xthread-only, switch-primary}
+ */
+COBALT_IMPL_TIME64(int, clock_nanosleep, __clock_nanosleep_time64,
+		   (clockid_t clock_id, int flags, const struct timespec *rqtp,
+		    struct timespec *rmtp))
+{
+	int ret, oldtype;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+#ifdef __USE_TIME_BITS64
+	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep64, clock_id, flags,
+				rqtp, rmtp);
+#else
+	ret = -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep, clock_id, flags,
+				rqtp, rmtp);
+#endif
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	return ret;
+}
+
+/**
+ * Sleep some amount of time.
+ * @ingroup cobalt_api_time
+ *
+ * This service suspends the calling thread until the wakeup time specified by
+ * @a rqtp, or a signal is delivered. The wakeup time is specified as a time
+ * interval.
+ *
+ * If this service is interrupted by a signal and @a rmtp is not @a NULL, the
+ * time remaining until the specified wakeup time is returned at the address @a
+ * rmtp.
+ *
+ * The resolution of this service is one system clock tick.
+ *
+ * @param rqtp address of the wakeup time.
+ *
+ * @param rmtp address where the remaining time before wakeup will be stored if
+ * the service is interrupted by a signal.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EPERM, the caller context is invalid;
+ * - EINVAL, the specified wakeup time is invalid;
+ * - EINTR, this service was interrupted by a signal.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/nanosleep.html">
+ * Specification.</a>
+ *
+ * @apitags{xthread-only, switch-primary}
+ */
+COBALT_IMPL_TIME64(int, nanosleep, __nanosleep64,
+		   (const struct timespec *rqtp, struct timespec *rmtp))
+{
+	int ret;
+
+	ret = __WRAP(clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp));
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * @apitags{unrestricted}
+ * @ingroup cobalt_api_time
+ */
+COBALT_IMPL_TIME64(int, gettimeofday, __gettimeofday64,
+		   (struct timeval *tv, struct timezone *tz))
+{
+	struct timespec ts;
+	int ret = __WRAP(clock_gettime(CLOCK_REALTIME, &ts));
+	if (ret == 0) {
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+	return ret;
+}
+
+/**
+ * @apitags{unrestricted}
+ * @ingroup cobalt_api_time
+ */
+COBALT_IMPL_TIME64(time_t, time, __time64, (time_t *t))
+{
+	struct timespec ts;
+	int ret = __WRAP(clock_gettime(CLOCK_REALTIME, &ts));
+	if (ret)
+		return (time_t)-1;
+
+	if (t)
+		*t = ts.tv_sec;
+	return ts.tv_sec;
+}

-- 
2.53.0

