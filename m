Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523338F633
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444302; cv=none; b=Q+RNiXgdfZNFXMX7jSf5okiNbLXa6L0n7Uj1yrAn/XFsPh/DjffAOQLr2oQrygB0bu+ngmLrhqfLU4UKlpHNxsYh0xc83XmRfJEbTwEFI+91LSKiCEoKXTjUF9VOlV11cs+KDWFx3UNgUJ+ds9GMVn0z0GaQgkyB468NS/i0KeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444302; c=relaxed/simple;
	bh=aURKLpI+9xD9cQEIHAeWUgdUmRnaGH7H+3mdxvU/Edc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzxr8eOSyejkpR+K4bOFPmuOMXExJ69vcu+dv7sd/INp8mXK+Q+TSdbhy3TI2peCHx0rtOVQ6C+WBjKCjgJsKGhuYI2SzZUz5JErWUCIB0+9ZTJtzSAyeWax+xR2G95pFqIX96Gza3IVjBKHur4YK9/SSm7fBnp64fz/Qkes0Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Jad4qdkD; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Jad4qdkD"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026030209380902dedab2df0002074d
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bFiGxkcqDU3vuw3rKyiBFfJ3fH20ZUgfUrJEqqnbmVw=;
 b=Jad4qdkD/I5GeJAmo8vY6mmUFaDUqbdXb3CbmLnaaDg3gm0LMPE3mD7D6bbMLZm5wuo44k
 s5K/S9cgEiLwsm368apQUOZeHcx6ecrYL6EpipB6wINHWuBrttCtqriVRyxnFQACw29igh8E
 tLY0uY72zeUGFOkYawW6L6yBsC1izLLDwcN97O+4ctIffkv3FQ33sgHdVEJgioduNcpFXkN3
 aTknH4YdIQ+wiYUDWGzoi0kkAXzEf1SqHcpcwe8ulGCZMweOmyApExbsVC+5G6888Jy2pk5V
 IYU2HdB3MoRVHgw23+KEFnHGZCyZeRNbKrGLg/gIJjKLKKuZVH5/IJ+A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:12 +0100
Subject: [PATCH v2 13/20] lib/cobalt: semaphore: Move time64 related
 services to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-13-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
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
index 524d2774d3dad551e599de30aea4919967719bab..fd5ee105aa03c1e9d5b3c80236aa3a789656bfda 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -848,3 +848,65 @@ COBALT_IMPL_TIME64(int, select, __select64,
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

