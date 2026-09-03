Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ECA24CEEA
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435201; cv=none; b=c2o/+B8JONJPtR4bQvMYFEYDg8H7avwWiN6FXJb94DsSr+nLOUvd6KmYehkn/W8LoVmfstEMlY9FPlxUrOU+NNkAXhXnEriPqjm2o/2l32RfTvqxJLP1GTH1W4sAwOhhgYbhru3YirbhGBmD/WcSN7lhAJk1DctJkitmq0HD+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435201; c=relaxed/simple;
	bh=i0hskhoYK9MHph8ivVSaDSwSRPkLRC5W08L5obcO6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZW8Um8Izx6ucgzinggN4jFBGJDocm6F/aVIzikfEcKtyzFdMo5fxJsAjaUv0UOTdQdyz6LYOygWYMesTT1NYoDC98yR2bcmFO4i4I49KyzoOxVEqcPQ3cb0+KrIFnGiHcTIi4VV17jNFdFyH8QD+zq2A8MfhqLAqaEheA7/xKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=M3uHbI/+; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="M3uHbI/+"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026090311331378ba0121f90002077d
        for <xenomai@lists.linux.dev>;
        Thu, 03 Sep 2026 13:33:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=q4Ks2bZR3gm8TroG+KOBOeGBscWqA681yObHokeHf9I=;
 b=M3uHbI/+w8CPHnhDz6TqU9+rPvC3HMQgTGxqrrvmxDOwnO68cIFQ5CmLYMs9458JruEP6W
 iPqdLgqatiWJAsVgZfZXqq0iK9MGyliF8li5BQU+ak12ubMTRefqsx4gprisZVRMjGZRGMPV
 ikBA2sVKaU46FZfpphCzBVo3DHiTgcyO68YJbPvcknrt5h8DwOpZ/oIGwbBq9Rt/7OAaNkIu
 tPbdtvX1g9cUXewUZHM/RlVhzaHxWwJUL2DhowIpf0ct8PB+iPwMr+msINt5XUPMEzVy2WQi
 rH87DiLGxlu0gGGqqz603zI5YxlHxxcIezhV4CNsD5TXEssuE9bxN8IQ==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 1/2] docs: Match actual return type for RTDM doxygen declarations
Date: Thu,  3 Sep 2026 13:33:03 +0200
Message-ID: <20260903113304.2425313-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The RTDM doxygen-only declarations were corrected to match the actual
return semantics (int instead void).

This fixes warnings such as

kernel/cobalt/rtdm/core.c:420: warning: found documented return type for rtdm_timedwait that does not return anything

See #18.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/rtdm/core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/cobalt/rtdm/core.c b/kernel/cobalt/rtdm/core.c
index f30055a79..002fb51cf 100644
--- a/kernel/cobalt/rtdm/core.c
+++ b/kernel/cobalt/rtdm/core.c
@@ -414,7 +414,7 @@ rtdm_timedwait_condition(struct rtdm_wait_queue *wq, C_expr condition,
 			 nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
 
 /**
- * @fn void rtdm_timedwait(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
+ * @fn int rtdm_timedwait(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
  * @brief Timed sleep on a waitqueue unconditionally
  *
  * The calling task is put to sleep until the waitqueue is signaled by
@@ -443,11 +443,11 @@ rtdm_timedwait_condition(struct rtdm_wait_queue *wq, C_expr condition,
  *
  * @coretags{primary-only, might-switch}
  */
-void rtdm_timedwait(struct rtdm_wait_queue *wq,
+int rtdm_timedwait(struct rtdm_wait_queue *wq,
 		    nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
 
 /**
- * @fn void rtdm_timedwait_locked(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
+ * @fn int rtdm_timedwait_locked(struct rtdm_wait_queue *wq, nanosecs_rel_t timeout, rtdm_toseq_t *toseq)
  * @brief Timed sleep on a locked waitqueue unconditionally
  *
  * The calling task is put to sleep until the waitqueue is signaled by
@@ -481,7 +481,7 @@ void rtdm_timedwait(struct rtdm_wait_queue *wq,
  *
  * @coretags{primary-only, might-switch}
  */
-void rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
+int rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
 			   nanosecs_rel_t timeout, rtdm_toseq_t *toseq);
 
 /**
@@ -509,7 +509,7 @@ void rtdm_timedwait_locked(struct rtdm_wait_queue *wq,
 rtdm_wait_condition(struct rtdm_wait_queue *wq, C_expr condition);
 
 /**
- * @fn void rtdm_wait(struct rtdm_wait_queue *wq)
+ * @fn int rtdm_wait(struct rtdm_wait_queue *wq)
  * @brief Sleep on a waitqueue unconditionally
  *
  * The calling task is put to sleep until the waitqueue is signaled by
@@ -526,10 +526,10 @@ rtdm_wait_condition(struct rtdm_wait_queue *wq, C_expr condition);
  *
  * @coretags{primary-only, might-switch}
  */
-void rtdm_wait(struct rtdm_wait_queue *wq);
+int rtdm_wait(struct rtdm_wait_queue *wq);
 
 /**
- * @fn void rtdm_wait_locked(struct rtdm_wait_queue *wq)
+ * @fn int rtdm_wait_locked(struct rtdm_wait_queue *wq)
  * @brief Sleep on a locked waitqueue unconditionally
  *
  * The calling task is put to sleep until the waitqueue is signaled by
@@ -551,7 +551,7 @@ void rtdm_wait(struct rtdm_wait_queue *wq);
  *
  * @coretags{primary-only, might-switch}
  */
-void rtdm_wait_locked(struct rtdm_wait_queue *wq);
+int rtdm_wait_locked(struct rtdm_wait_queue *wq);
 
 /**
  * @fn void rtdm_waitqueue_lock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context)
@@ -585,7 +585,7 @@ void rtdm_waitqueue_lock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
 void rtdm_waitqueue_unlock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
 
 /**
- * @fn void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq)
+ * @fn int rtdm_waitqueue_signal(struct rtdm_wait_queue *wq)
  * @brief Signal a waitqueue
  *
  * Signals the waitqueue @a wq, waking up a single waiter (if
@@ -598,10 +598,10 @@ void rtdm_waitqueue_unlock(struct rtdm_wait_queue *wq, rtdm_lockctx_t context);
  *
  * @coretags{unrestricted, might-switch}
  */
-void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
+int rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
 
 /**
- * @fn void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq)
+ * @fn int rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq)
  * @brief Broadcast a waitqueue
  *
  * Broadcast the waitqueue @a wq, waking up all waiters. Each
@@ -614,10 +614,10 @@ void rtdm_waitqueue_signal(struct rtdm_wait_queue *wq);
  *
  * @coretags{unrestricted, might-switch}
  */
-void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
+int rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
 
 /**
- * @fn void rtdm_waitqueue_flush(struct rtdm_wait_queue *wq)
+ * @fn int rtdm_waitqueue_flush(struct rtdm_wait_queue *wq)
  * @brief Flush a waitqueue
  *
  * Flushes the waitqueue @a wq, unblocking all waiters with an error
@@ -630,7 +630,7 @@ void rtdm_waitqueue_broadcast(struct rtdm_wait_queue *wq);
  *
  * @coretags{unrestricted, might-switch}
  */
-void rtdm_waitqueue_flush(struct rtdm_wait_queue *wq);
+int rtdm_waitqueue_flush(struct rtdm_wait_queue *wq);
 
 /**
  * @fn void rtdm_waitqueue_wakeup(struct rtdm_wait_queue *wq, rtdm_task_t waiter)
-- 
2.55.0

