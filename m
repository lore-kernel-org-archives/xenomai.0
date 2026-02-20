Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB131B10B
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578545; cv=none; b=O3IyafnNWDp5FTdADFrCeQCSmsbOGz3Y8S55Q+g7R4hG+DfwkrKprLIfhrqNiN9vpI+CfHgKwHG8+LZuYcBkLebn+NHchYVwEgznDVK6RqVd+9m1p6nFvKOYaLkE2cIfKiCAxpMIjo6aBiVk1P7Q4qVlrQB2DACcKzSLZ38SWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578545; c=relaxed/simple;
	bh=aONCVPA+CdRO9WXrMkymItu6PnWz3sGFriozg5pZpu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swDlpRlOZWo8sFpfZSZeFLeExCZVTur3LWNZdR6vuFlPHqsvLSC6BBnT7UepkYvCoWqv+M/OXzQ5BnzzOB5OVtTYjsMlQAGUgjUPuRLuYVTsIUY2r8zmLl3Ui81M4IPS9oSsosPp52aH1c+XHZ85p21CB8fu8sRnPmsKu0sS0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=OxrIsqXY; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OxrIsqXY"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260220090846646b29811b00020724
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 10:08:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=07+M44U6+FCVdDQBIfw5l8drd2zxjGwD92JUrVjHAEo=;
 b=OxrIsqXYZ2DRITncpgxQlf4McqssNrgzyqIRYuWefo3DpSUM6YC/LKkfLYrbkw3bXb6SU8
 mpy+VDHqdTDMcurU5CNfiKKqlmjdVVaYuTTa/Op7Iu5aFi7thSkxa04F3kbxgiL5lExKBTfT
 SgbksTO1EN56fgkBl+FKqO55HvqgmjWMm0tR5uqV+lyPCXQsQisBCSzSbsmwoV1rajC699Gb
 p8qWvWbZUIkgrGdaE64gxggg0nFy5afm2asSjwr4CXj6REKCZ3hNMNwZelrvPUr7lWrAZsVO
 11Rv1YnXIMW5f1Ugqw/aQyoctyGvHw5+tYTJ+DeiTJoIYa3VaeMjyLmw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 10:08:51 +0100
Subject: [PATCH 08/20] lib/cobalt: mq: Move all time64 related services to
 wrappers_time64.c
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-fix-time64-32bit-native-v1-8-731c773e72cc@siemens.com>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
In-Reply-To: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
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
index 8e70e0bb351d9fe18a68495383ed5a6a77dd5c18..46463560593a05a206e8b60b531c62ca21e209e0 100644
--- a/lib/cobalt/wrappers_time64.c
+++ b/lib/cobalt/wrappers_time64.c
@@ -7,11 +7,13 @@
 
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
@@ -421,3 +423,126 @@ COBALT_IMPL_TIME64(int, pthread_cond_timedwait, __pthread_cond_timedwait64,
 
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

