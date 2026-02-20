Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90F7478
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578534; cv=none; b=RP7mNnZk2qJo3fX0GXDSkWbRWJGsCa2TM0GLBpOjkj4GhqXxBzYNkxn6hvlO1K37nGkRzwoazaN4tkdcQkVb1OkickeT8mbZwTYi2OQoYa8U2Co7jOQQiswOiN4GiPy2yMOxhROCvjg9hzZKYmFWJxYwzxHx3IDCz0KD8aVjPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578534; c=relaxed/simple;
	bh=iCbru8rLXTWcOlKyJO5XtopZKgd+W0Csb2aLNQ2YqiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luncYFT8Fx988hM0vwZJYYBYSyYmv7GpohkRLztPPejiHzbKoKtz4AdZNwel3kuV6TO21yqGWd6lYyx7NUzK46LZGK4BskiZHExgcer93lhxnk/GRS3HtztmTi0E8a6DIBWAjySwQYw1zfVgHrry440sU9HQaRDf6uvC39Oi830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Ij/rP+wS; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Ij/rP+wS"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202602200908475f83d1000b000207f4
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+6wm+KnneBlyNWvXSG7XvS4yFnOnQv5v2oJsbuDSVOw=;
 b=Ij/rP+wS2/G9epGgykKB2RPk4WMOrLX8ZEPqZC6qnD/bFMocvh2nhsb/PLO3rBrQpotFpm
 wB+DgriMgun7xGuCOkZsmYoMf3mXxBb1w31p3RfRntDlmBQ/Hza6L/ucJSvm0JYLOl4aUhqA
 5OatXeMEMEdC8wfanA+DAdT3v96FSNeQH8saCTRS2UC5Cpen0be9aMeVTS87D8noTxf5sVXG
 iJLT/z73+9mj0qcedbVJ6wm/55mHofIdBnBtCMPaYLe+ETXbQuaqw7rAsLuFERmFbOYDfsmI
 SnjSjJLKPpNfKeN2/pSQYCnz9FtNVb4+KVGyoQZQc+0FwNU8YUBdaaVg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:56 +0100
Subject: [PATCH 13/20] lib/cobalt: semaphore: Move time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-13-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement with some minor adjustments to the doxygen headers.
All services should remain in the cobalt_api_sem group.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/semaphore.c       | 67 +++-----------------------------------------
 lib/cobalt/wrappers_time64.c | 62 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 63 deletions(-)

diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index 0c1a245cd40f7e2b0e0c883f317a3bbccde5187d..1fe3581df1cb30748ed780e57cd212827dd0f4c9 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -16,14 +16,16 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include "internal.h"
+
+#include <asm/xenomai/syscall.h>
+
 #include <stdlib.h>		/* For malloc & free. */
 #include <stdarg.h>
 #include <errno.h>
 #include <fcntl.h>		/* For O_CREAT. */
 #include <pthread.h>		/* For pthread_setcanceltype. */
 #include <semaphore.h>
-#include <asm/xenomai/syscall.h>
-#include "internal.h"
 
 /**
  * @ingroup cobalt_api
@@ -329,67 +331,6 @@ COBALT_IMPL(int, sem_wait, (sem_t *sem))
 	return 0;
 }
 
-/**
- * @fn int sem_timedwait(sem_t *sem, const struct timespec *abs_timeout)
- * @brief Attempt to decrement a semaphore with a time limit
- *
- * This service is equivalent to sem_wait(), except that the caller is only
- * blocked until the timeout @a abs_timeout expires.
- *
- * @param sem the semaphore to be decremented;
- *
- * @param abs_timeout the timeout, expressed as an absolute value of
- * the relevant clock for the semaphore, either CLOCK_MONOTONIC if
- * SEM_RAWCLOCK was mentioned via sem_init_np(), or CLOCK_REALTIME
- * otherwise.
- *
- * @retval 0 on success;
- * @retval -1 with @a errno set if:
- * - EPERM, the caller context is invalid;
- * - EINVAL, the semaphore is invalid or uninitialized;
- * - EINVAL, the specified timeout is invalid;
- * - EPERM, the semaphore @a sm is not process-shared and does not belong to the
- *   current process;
- * - EINTR, the caller was interrupted by a signal while blocked in this
- *   service;
- * - ETIMEDOUT, the semaphore could not be decremented and the
- *   specified timeout expired.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/sem_timedwait.html">
- * Specification.</a>
- *
- * @apitags{xthread-only, switch-primary}
- */
-COBALT_IMPL_TIME64(int, sem_timedwait, __sem_timedwait64,
-		   (sem_t *sem, const struct timespec *abs_timeout))
-{
-	struct cobalt_sem_shadow *_sem = &((union cobalt_sem_union *)sem)->shadow_sem;
-	int ret, oldtype;
-
-	ret = __RT(sem_trywait(sem));
-	if (ret != -1 || errno != EAGAIN)
-		return ret;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-#ifdef __USE_TIME_BITS64
-	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, _sem,
-			       abs_timeout);
-#else
-	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait, _sem, abs_timeout);
-#endif
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	if (ret) {
-		errno = -ret;
-		return -1;
-	}
-
-	return 0;
-}
-
 /**
  * @fn int sem_getvalue(sem_t sem, int *sval_r)
  * @brief Get the value of a semaphore.
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index 7b634976eb07d7ae143b4567983dbea7f4ddebea..1a4a3c463543e078e43eddd9ccd056ad10f69e97 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -840,3 +840,65 @@ COBALT_IMPL_TIME64(int, select, __select64,
 {
 	return do_select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
 }
+
+/**
+ * @fn int sem_timedwait(sem_t *sem, const struct timespec *abs_timeout)
+ * @brief Attempt to decrement a semaphore with a time limit
+ * @ingroup cobalt_api_sem
+ *
+ * This service is equivalent to sem_wait(), except that the caller is only
+ * blocked until the timeout @a abs_timeout expires.
+ *
+ * @param sem the semaphore to be decremented;
+ *
+ * @param abs_timeout the timeout, expressed as an absolute value of
+ * the relevant clock for the semaphore, either CLOCK_MONOTONIC if
+ * SEM_RAWCLOCK was mentioned via sem_init_np(), or CLOCK_REALTIME
+ * otherwise.
+ *
+ * @retval 0 on success;
+ * @retval -1 with @a errno set if:
+ * - EPERM, the caller context is invalid;
+ * - EINVAL, the semaphore is invalid or uninitialized;
+ * - EINVAL, the specified timeout is invalid;
+ * - EPERM, the semaphore @a sm is not process-shared and does not belong to the
+ *   current process;
+ * - EINTR, the caller was interrupted by a signal while blocked in this
+ *   service;
+ * - ETIMEDOUT, the semaphore could not be decremented and the
+ *   specified timeout expired.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/sem_timedwait.html">
+ * Specification.</a>
+ *
+ * @apitags{xthread-only, switch-primary}
+ */
+COBALT_IMPL_TIME64(int, sem_timedwait, __sem_timedwait64,
+		   (sem_t *sem, const struct timespec *abs_timeout))
+{
+	struct cobalt_sem_shadow *_sem =
+		&((union cobalt_sem_union *)sem)->shadow_sem;
+	int ret, oldtype;
+
+	ret = __RT(sem_trywait(sem));
+	if (ret != -1 || errno != EAGAIN)
+		return ret;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+#ifdef __USE_TIME_BITS64
+	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, _sem, abs_timeout);
+#else
+	ret = XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait, _sem, abs_timeout);
+#endif
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (ret) {
+		errno = -ret;
+		return -1;
+	}
+
+	return 0;
+}

-- 
2.53.0

