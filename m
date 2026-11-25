Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642478;
	b=LVzBSXsDTOLFDnSkl545hgowDyL5bvgJ3X5tVSoWNsxX2ymGgi7wpMj1k5iQmWQPN+4U
	 mV3z8xDNAZysBe75fpiHduq5Xp2loXMoLvbP69w5CUIN0Uns2MvlbB7k6TOQTr7RQ2pUr
	 G7AQs22MbkYwSmWO+Osp6i7KusTA/eFF81JV0h2e/LqsozCxbm2l3FLpPIriA6tIFwruj
	 SYhuTJ8mPrIO+YFJp2Bclyc6aOltSiUTbz7JQPCf+73gbMUervAJ5DJio7wWQn+4pAWsX
	 O5eme00xleKC4yCKam0hDIbsmc+Rr8F99vPcFS1iqgPg+ziweeWg7HwTW8UPQIXpiKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P3cFt9hF7ELLjUPkcWT/X9GvkKqXtNPW/b4JeY/Nn28=;
	b=uNHHDexvF5aS1hGsBzDR/+2VUmvq2moD1TtpsO+k1xZUnf+uECxqoUNpI7tCdlTYephq
	 RwxfWBygEa4ZJOT/ZL3MsXVET4Xg7RZKeavd6PjCpstIo4wppjcvvGoIG5HOqODfOZ5kw
	 ajLvPhd0mhja0EL/3FiISnihy0Jrc7x3/9fnPbbBF8JUbGCPU1wry8Jn6yVvEuOqbLqN8
	 CvXVmJ9s7auVv65BEFKIOFwnFfl+6e0C4b3bgMkfbbBSKDDQx+t6cWnqCuQPElxVE5YeD
	 PkJuc0BPKiPraasyUfXgMEupdO2EF2bE4bY8PaUyKhj8PnQPiW3vlH+ihyU0ZM+88Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYcHm2Mj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B7606A327
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYcHm2Mj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722EF1F000C4;
	Wed, 25 Nov 2026 21:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642477;
	bh=P3cFt9hF7ELLjUPkcWT/X9GvkKqXtNPW/b4JeY/Nn28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYcHm2Mj/1seceOnNS3nPILPDuAAdwblM8sbG5XZmDAGaHJr/hNufibVTKrWDqWKU
	 MlPavTNAOJNzfXEnvjgoALH3gcgQ2lsqeYz7T+u6rCPrB/+od39Kx1dzUEOGDHZM/3
	 BIGmLAf19q2ECOrpMBAt9yCwAyzk9y/Aeeuw6B1PvlwiTdKIl9x8B0ou60CsMWZWy1
	 iMJOJ4cp4arMbeX61EKHcP8tjCVIjjSwTNzsTHbLH/cz8dP23qUvHi3yajsL1obGDg
	 Zh/M1Lh+3iSCSPMaXYMqV5mVuQGVR4sLPidVLZ5grhQo/YMQ5JyXErCV0FcHOwIInz
	 W15CdJQ0OfzCQ==
From: "Richard Weinberger (sigma star gmbh)" <rw@kernel.org>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/7] lib/alchemy: Require a Xenomai task only when actually waiting
Date: Wed, 25 Nov 2026 22:34:18 +0100
Message-ID: <20261125213419.2363742-7-rw@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125213419.2363742-1-rw@kernel.org>
References: <20261125213419.2363742-1-rw@kernel.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Weinberger <richard@nod.at>

The queue, buffer and heap services refuse non-polling calls from
threads without a Copperplate TCB upfront, even if the request can be
satisfied immediately. The TCB is only needed to wait, so check for it
there.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 lib/alchemy/buffer.c | 24 ++++++++++++++----------
 lib/alchemy/heap.c   | 12 +++++++-----
 lib/alchemy/queue.c  | 24 ++++++++++++++----------
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/lib/alchemy/buffer.c b/lib/alchemy/buffer.c
index 4f826fb27..66e37413c 100644
--- a/lib/alchemy/buffer.c
+++ b/lib/alchemy/buffer.c
@@ -424,8 +424,8 @@ out:
  * waiting for data. In such event, @a bf is no more valid upon return
  * of this service.
  *
- * - -EPERM is returned if this service was not called from a Xenomai
- * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
+ * - -EPERM is returned if this service should block, but was not
+ * called from a Xenomai task.
  *
  * @note A short read (i.e. fewer bytes returned than requested by @a
  * len) may happen whenever a pathological use of the buffer is
@@ -468,9 +468,6 @@ ssize_t rt_buffer_read_timed(RT_BUFFER *bf,
 	if (len == 0)
 		return 0;
 
-	if (!threadobj_current_p() && !alchemy_poll_mode(abs_timeout))
-		return -EPERM;
-
 	CANCEL_DEFER(svc);
 
 	bcb = get_alchemy_buffer(bf, &syns, &ret);
@@ -547,6 +544,11 @@ redo:
 			goto redo;
 		}
 
+		if (!threadobj_current_p()) {
+			ret = -EPERM;
+			goto done;
+		}
+
 		if (wait == NULL)
 			wait = threadobj_prepare_wait(struct alchemy_buffer_wait);
 
@@ -664,8 +666,8 @@ out:
  * waiting for buffer space. In such event, @a bf is no more valid
  * upon return of this service.
  *
- * - -EPERM is returned if this service was not called from a Xenomai
- * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
+ * - -EPERM is returned if this service should block, but was not
+ * called from a Xenomai task.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -687,9 +689,6 @@ ssize_t rt_buffer_write_timed(RT_BUFFER *bf,
 	if (len == 0)
 		return 0;
 
-	if (!threadobj_current_p() && !alchemy_poll_mode(abs_timeout))
-		return -EPERM;
-
 	CANCEL_DEFER(svc);
 
 	bcb = get_alchemy_buffer(bf, &syns, &ret);
@@ -754,6 +753,11 @@ ssize_t rt_buffer_write_timed(RT_BUFFER *bf,
 			goto done;
 		}
 
+		if (!threadobj_current_p()) {
+			ret = -EPERM;
+			goto done;
+		}
+
 		if (wait == NULL)
 			wait = threadobj_prepare_wait(struct alchemy_buffer_wait);
 
diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
index fb3424f5f..06f2598ef 100644
--- a/lib/alchemy/heap.c
+++ b/lib/alchemy/heap.c
@@ -408,8 +408,8 @@ out:
  * waiting for a block. In such event, @a heap is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service was not called from a Xenomai
- * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
+ * - -EPERM is returned if this service should block, but was not
+ * called from a Xenomai task.
  *
  * @apitags{xthread-nowait, switch-primary}
  *
@@ -431,9 +431,6 @@ int rt_heap_alloc_timed(RT_HEAP *heap,
 	void *p = NULL;
 	int ret = 0;
 
-	if (!threadobj_current_p() && !alchemy_poll_mode(abs_timeout))
-		return -EPERM;
-
 	CANCEL_DEFER(svc);
 
 	hcb = get_alchemy_heap(heap, &syns, &ret);
@@ -468,6 +465,11 @@ int rt_heap_alloc_timed(RT_HEAP *heap,
 		goto done;
 	}
 
+	if (!threadobj_current_p()) {
+		ret = -EPERM;
+		goto done;
+	}
+
 	wait = threadobj_prepare_wait(struct alchemy_heap_wait);
 	wait->size = size;
 
diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
index e91973920..18ef51f39 100644
--- a/lib/alchemy/queue.c
+++ b/lib/alchemy/queue.c
@@ -792,8 +792,8 @@ out:
  * waiting for a message. In such event, @a q is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service was not called from a Xenomai
- * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
+ * - -EPERM is returned if this service should block, but was not
+ * called from a Xenomai task.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -808,9 +808,6 @@ ssize_t rt_queue_receive_timed(RT_QUEUE *queue, void **bufp,
 	ssize_t ret;
 	int err = 0;
 
-	if (!threadobj_current_p() && !alchemy_poll_mode(abs_timeout))
-		return -EPERM;
-
 	CANCEL_DEFER(svc);
 
 	qcb = get_alchemy_queue(queue, &syns, &err);
@@ -834,6 +831,11 @@ wait:
 		goto done;
 	}
 
+	if (!threadobj_current_p()) {
+		ret = -EPERM;
+		goto done;
+	}
+
 	wait = threadobj_prepare_wait(struct alchemy_queue_wait);
 	wait->local_bufsz = 0;
 
@@ -952,8 +954,8 @@ out:
  * waiting for a message. In such event, @a q is no more valid upon
  * return of this service.
  *
- * - -EPERM is returned if this service was not called from a Xenomai
- * task, unless @a abs_timeout is { .tv_sec = 0, .tv_nsec = 0 }.
+ * - -EPERM is returned if this service should block, but was not
+ * called from a Xenomai task.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -969,9 +971,6 @@ ssize_t rt_queue_read_timed(RT_QUEUE *queue,
 	ssize_t ret;
 	int err = 0;
 
-	if (!threadobj_current_p() && !alchemy_poll_mode(abs_timeout))
-		return -EPERM;
-
 	if (size == 0)
 		return 0;
 
@@ -995,6 +994,11 @@ wait:
 		goto done;
 	}
 
+	if (!threadobj_current_p()) {
+		ret = -EPERM;
+		goto done;
+	}
+
 	wait = threadobj_prepare_wait(struct alchemy_queue_wait);
 	wait->local_buf = buf;
 	wait->local_bufsz = size;
-- 
2.55.0

