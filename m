Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63A38F62A
	for <xenomai@lists.linux.dev>; Mon,  2 Mar 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444300; cv=none; b=hXamuMIclPCgUpAfFXb0Grdt4Bbtp37JvuPCc7S+b0vS1k0I+RUBK9aAJKqSLGowD7pZtr3benbICSNTO+pUJNB6Z01BjoBPC6oCsDY0UkGvCRagj3LCrtdCqT28HXMTqGD7iY6Afs5HinbRHvs3zzsEFpKyF6SOYD8JIRrbHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444300; c=relaxed/simple;
	bh=Lk98MqifRlxBB3a7Y5uRmb8O0ebLGIptLK/nzKiLvqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwK/sVJxlemy6kQuC0aQ5pUQQq/X3pxNbWPD6XYGW9Y5lkOnFulnB1fIwv5hNPap1NG4x/8Fz/igXSyIENAiWiX2pDfdT9zMvtXUaU3J605Rmn+ev9k0is2LZr05XDhiTWX7TMQiIiySIhBU5qUWw/SPRVvI4EKsNF7MxYMxnTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KOwqbfQf; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KOwqbfQf"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202603020938082327c515ab000207ae
        for <xenomai@lists.linux.dev>;
        Mon, 02 Mar 2026 10:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IRQbu34c+51i+grNJEM/5ap32UekwccNUHU/+9Wq29Y=;
 b=KOwqbfQfT+qcDG+c6yCcGLZ1TF0M/UwLgHm/2TRZ4Wt2dPk0VayOJ03+EGscNsMZC84nlN
 t4xsD+g0xw0AjWNp2556m9giGse7mQZS9lCSYY1mYB45WLZqUL1SEs2ivHg7J8pCeHUI48+p
 crwBEqR46JuV17qtydugqtHdhLNhV0n6jbTZbPjOVse3ZguHitcydsFsEg/TNXFW/JLpKgpn
 TRbgA4CMf2RX1f0xQStHMXsxyNDEXqC9VVE1Ew+vWVjOyl0be40VTljjf8ZHkKEE15dl56rd
 mLoQgFlPSctuFTciQN6bgLqDCyolnBq/qnJwsnuqtUHtwM83jKrrWNKw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 02 Mar 2026 10:38:07 +0100
Subject: [PATCH v2 08/20] lib/cobalt: mq: Move all time64 related services
 to wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-wip-flo-fix-time64-32bit-native-v2-8-7caefce29bcd@siemens.com>
References: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
In-Reply-To: <20260302-wip-flo-fix-time64-32bit-native-v2-0-7caefce29bcd@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Code movement with some minor adjustments to the doxygen headers.
All services should remain in the cobalt_api_mq group.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/mq.c              | 121 -----------------------------------------
 lib/cobalt/wrappers_time64.c | 125 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 121 deletions(-)

diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 72d419d6cfac0097ba7ed61941e7b8a92e3bc673..0997d396d06e08407741f4b5d6b373284f219f97 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -345,64 +345,6 @@ COBALT_IMPL(int, mq_send, (mqd_t q, const char *buffer, size_t len, unsigned pri
 	return -1;
 }
 
-/**
- * Attempt, during a bounded time, to send a message to a message queue.
- *
- * This service is equivalent to mq_send(), except that if the message queue is
- * full and the flag @a O_NONBLOCK is not set for the descriptor @a fd, the
- * calling thread is only suspended until the timeout specified by @a
- * abs_timeout expires.
- *
- * @param q message queue descriptor;
- *
- * @param buffer pointer to the message to be sent;
- *
- * @param len length of the message;
- *
- * @param prio priority of the message;
- *
- * @param timeout the timeout, expressed as an absolute value of the
- * CLOCK_REALTIME clock.
- *
- * @return 0 and send a message on success;
- * @return -1 with no message sent and @a errno set if:
- * - EBADF, @a fd is not a valid message queue descriptor open for writing;
- * - EMSGSIZE, the message length exceeds the @a mq_msgsize attribute of the
- *   message queue;
- * - EAGAIN, the flag O_NONBLOCK is set for the descriptor @a fd and the message
- *   queue is full;
- * - EPERM, the caller context is invalid;
- * - ETIMEDOUT, the specified timeout expired;
- * - EINTR, the service was interrupted by a signal.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/mq_timedsend.html">
- * Specification.</a>
- *
- * @apitags{xthread-only, switch-primary}
- */
-COBALT_IMPL_TIME64(int, mq_timedsend, __mq_timedsend_time64,
-		   (mqd_t q, const char *buffer, size_t len, unsigned prio,
-		    const struct timespec *timeout))
-{
-	int err, oldtype;
-
-	if (timeout == NULL)
-		return -EFAULT;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-	err = __do_mq_timesend(q, buffer, len, prio, timeout);
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	if (!err)
-		return 0;
-
-	errno = -err;
-	return -1;
-}
-
 /**
  * Receive a message from a message queue.
  *
@@ -461,69 +403,6 @@ COBALT_IMPL(ssize_t, mq_receive, (mqd_t q, char *buffer, size_t len, unsigned *p
 	return -1;
 }
 
-/**
- * Attempt, during a bounded time, to receive a message from a message queue.
- *
- * This service is equivalent to mq_receive(), except that if the flag @a
- * O_NONBLOCK is not set for the descriptor @a fd and the message queue is
- * empty, the calling thread is only suspended until the timeout @a abs_timeout
- * expires.
- *
- * @param q the queue descriptor;
- *
- * @param buffer the address where the received message will be stored on
- * success;
- *
- * @param len @a buffer length;
- *
- * @param prio address where the priority of the received message will be
- * stored on success.
- *
- * @param timeout the timeout, expressed as an absolute value of the
- * CLOCK_REALTIME clock.
- *
- * @return the message length, and copy a message at the address @a buffer on
- * success;
- * @return -1 with no message unqueued and @a errno set if:
- * - EBADF, @a fd is not a valid descriptor open for reading;
- * - EMSGSIZE, the length @a len is lesser than the message queue @a mq_msgsize
- *   attribute;
- * - EAGAIN, the queue is empty, and the flag @a O_NONBLOCK is set for the
- *   descriptor @a fd;
- * - EPERM, the caller context is invalid;
- * - EINTR, the service was interrupted by a signal;
- * - ETIMEDOUT, the specified timeout expired.
- *
- * @see
- * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/mq_timedreceive.html">
- * Specification.</a>
- *
- * @apitags{xthread-only, switch-primary}
- */
-COBALT_IMPL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
-		   (mqd_t q, char *__restrict__ buffer, size_t len,
-		    unsigned *__restrict__ prio,
-		    const struct timespec *__restrict__ timeout))
-{
-	ssize_t rlen = (ssize_t) len;
-	int err, oldtype;
-
-	if (timeout == NULL)
-		return -EFAULT;
-
-	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
-
-	err = __do_mq_timedreceive(q, buffer, &rlen, prio, timeout);
-
-	pthread_setcanceltype(oldtype, NULL);
-
-	if (!err)
-		return rlen;
-
-	errno = -err;
-	return -1;
-}
-
 /**
  * @brief Enable notification on message arrival
  *
diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
index ef2fb9869976fa9a60f45dab0a6ded1606ebf21d..09930ab018104dcc2a54c354b4b756230cfda029 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -14,11 +14,13 @@
 
 #include "cond.h"
 #include "internal.h"
+#include "mq.h"
 
 #include <asm/xenomai/syscall.h>
 #include <cobalt/uapi/syscall.h>
 
 #include <errno.h>
+#include <mqueue.h>
 #include <pthread.h>
 #include <sys/time.h>
 #include <time.h>
@@ -428,3 +430,126 @@ COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
 
 	return -err ?: -c.err;
 }
+
+/**
+ * Attempt, during a bounded time, to send a message to a message queue.
+ * @ingroup cobalt_api_mq
+ *
+ * This service is equivalent to mq_send(), except that if the message queue is
+ * full and the flag @a O_NONBLOCK is not set for the descriptor @a fd, the
+ * calling thread is only suspended until the timeout specified by @a
+ * abs_timeout expires.
+ *
+ * @param q message queue descriptor;
+ *
+ * @param buffer pointer to the message to be sent;
+ *
+ * @param len length of the message;
+ *
+ * @param prio priority of the message;
+ *
+ * @param timeout the timeout, expressed as an absolute value of the
+ * CLOCK_REALTIME clock.
+ *
+ * @return 0 and send a message on success;
+ * @return -1 with no message sent and @a errno set if:
+ * - EBADF, @a fd is not a valid message queue descriptor open for writing;
+ * - EMSGSIZE, the message length exceeds the @a mq_msgsize attribute of the
+ *   message queue;
+ * - EAGAIN, the flag O_NONBLOCK is set for the descriptor @a fd and the message
+ *   queue is full;
+ * - EPERM, the caller context is invalid;
+ * - ETIMEDOUT, the specified timeout expired;
+ * - EINTR, the service was interrupted by a signal.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/mq_timedsend.html">
+ * Specification.</a>
+ *
+ * @apitags{xthread-only, switch-primary}
+ */
+COBALT_IMPL_TIME64(int, mq_timedsend, __mq_timedsend_time64,
+		   (mqd_t q, const char *buffer, size_t len, unsigned prio,
+		    const struct timespec *timeout))
+{
+	int err, oldtype;
+
+	if (timeout == NULL)
+		return -EFAULT;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	err = __do_mq_timesend(q, buffer, len, prio, timeout);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (!err)
+		return 0;
+
+	errno = -err;
+	return -1;
+}
+
+/**
+ * Attempt, during a bounded time, to receive a message from a message queue.
+ * @ingroup cobalt_api_mq
+ *
+ * This service is equivalent to mq_receive(), except that if the flag @a
+ * O_NONBLOCK is not set for the descriptor @a fd and the message queue is
+ * empty, the calling thread is only suspended until the timeout @a abs_timeout
+ * expires.
+ *
+ * @param q the queue descriptor;
+ *
+ * @param buffer the address where the received message will be stored on
+ * success;
+ *
+ * @param len @a buffer length;
+ *
+ * @param prio address where the priority of the received message will be
+ * stored on success.
+ *
+ * @param timeout the timeout, expressed as an absolute value of the
+ * CLOCK_REALTIME clock.
+ *
+ * @return the message length, and copy a message at the address @a buffer on
+ * success;
+ * @return -1 with no message unqueued and @a errno set if:
+ * - EBADF, @a fd is not a valid descriptor open for reading;
+ * - EMSGSIZE, the length @a len is lesser than the message queue @a mq_msgsize
+ *   attribute;
+ * - EAGAIN, the queue is empty, and the flag @a O_NONBLOCK is set for the
+ *   descriptor @a fd;
+ * - EPERM, the caller context is invalid;
+ * - EINTR, the service was interrupted by a signal;
+ * - ETIMEDOUT, the specified timeout expired.
+ *
+ * @see
+ * <a href="http://www.opengroup.org/onlinepubs/000095399/functions/mq_timedreceive.html">
+ * Specification.</a>
+ *
+ * @apitags{xthread-only, switch-primary}
+ */
+COBALT_IMPL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
+		   (mqd_t q, char *__restrict__ buffer, size_t len,
+		    unsigned *__restrict__ prio,
+		    const struct timespec *__restrict__ timeout))
+{
+	ssize_t rlen = (ssize_t) len;
+	int err, oldtype;
+
+	if (timeout == NULL)
+		return -EFAULT;
+
+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
+
+	err = __do_mq_timedreceive(q, buffer, &rlen, prio, timeout);
+
+	pthread_setcanceltype(oldtype, NULL);
+
+	if (!err)
+		return rlen;
+
+	errno = -err;
+	return -1;
+}

-- 
2.53.0

