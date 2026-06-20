Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9AC1E7C2E
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781973899; cv=none; b=Qb1b0eGgg4xZPt2bSV9zePXzhqUcr0CXeECfakQqzc/iytYNDpNHXU/k9kIrN1Z5g7wznyK31R7gudB1DBGU/1DnKUhqtn6Yen+AcFoHugoVw9xRfBVWYJ3/MS++koEiEypXgTRxPcSmM1Y4r2MJxundlpiPFpOrT9P5adxSJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781973899; c=relaxed/simple;
	bh=OlyrQ0+sBQOgcg2wctVveBlTBdDfyqSjYDg4Qmp6+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWyzeXXDZQ8mR+3W+6TuLA+gB9JXCtcauh4PWYc2VFLFU1ScCz16s8h8Si+OfXg/xkRw2K6m+hYhQXhMt8vQUNPNJQkPMML7aciVkPBlKfMnjvcEeDavGIRW7aQ6R/6wFw+W5ljR8S2nAP9x+M6bg/M1HrHZ78/k0He8N1dH7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=mm3835w1; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="mm3835w1"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 379EF5806EF
	for <xenomai@lists.linux.dev>; Sat, 20 Jun 2026 16:16:36 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8ADF63F5D6;
	Sat, 20 Jun 2026 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781972189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmSMwBEwFVGx/Ucz3pjmWVqoc+cxYMOil4IGj/rav34=;
	b=mm3835w1TAC5vLbn8Ku6dpP0XmMmHUUWfH5p1PBdW4qWt8F0AdPv30s8ZjBiMLlcr3Ms96
	4xGpDdnoCz76y8ir3lSZyVg8ZBtyytbBS7J57m7RGaWKFUQ6W7EvVR2WPynIT0hL0ksmbQ
	4O3nWu9i2PO5isJhu8Pvo+YfUV1KZnWySqGcfRIORgf5mfDRT9MuwPucSA89YVQpF9h733
	GL6ez3Z/DtT7jmw6eIBqL2IANXfHrnxZ5xBNCftdoRJ5maeGi9fduJ2HROWbBNdm9zvwE8
	TyuSnDs9Wc6YNMKClzhKlQGP38ijhAA3xlbgPs06Zn7qSv2aU/Xw6A5Xyh6GUg==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v3 1/2] evl/sched: core: introduce schedule out handler
Date: Sat, 20 Jun 2026 18:08:44 +0200
Message-ID: <20260620161531.422484-2-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620161531.422484-1-rpm@xenomai.org>
References: <20260620161531.422484-1-rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: 0
X-GND-Cause: dmFkZTGJIOk+bsa8eEvzf5ba91NsFllY1F9SyzOk+wdiJoIXYRgkUZdgljX6L/B05YAUCUQxZyYiCVoN6I+pr4QXc4Vic0ckXXQzWzUE0dJO8IWtvv/xGA9qJVxpxej/UcSoJsch28ZkMBS7fmK9HusZhbHKUTprhUBWnUyefF7vHShr1Z4Shx1TIt7zRli7j7lfZtJ8dfWq+pL4zynA7uu6rCSQzluqVUBoNabcq5d5nJqZjHZGiLeizcu/oM39ezvYEbqYl7+kdpYGUI/ekuWzjYNopWN/27VGiwOuSWVmR/Az5kYgP0esYIKtxlqCVjiaRzYMr0jbVsYCQ0pyHWaGOsgDf4kMNmzOzJUUlyAEVuwx0/ShNotvLP59Clzc5uPsoVbducOncqNYJv4ZiwGmDE0imjlZbjDf2E8sHnKgIRDTFDFy0ERUQhQjTs+uGkTQ+IFTfqB2QS0WAq/eC/khQGkO2OSy5rCEY/VcEiRVBWiY6AfJKAjie9TTCjgNil1U4O+ME+D+LZZNpYuHXFj8gg8nTLLOrPuiMLOk8JXJRZyBCY3tgZ6u73xUo/AK/PC1J1Vu1VqLCVlN5OCfGijZAhb0aP6ewAcbUms9N80371L8v8dM4PyhfB60LBZSuSUGpBxwpij7oj2OLwNICLCcT7nrHOWxq/PI9bo0bB6gqGUUHg
X-GND-State: clean

From: Philippe Gerum <rpm@xenomai.org>

Some scheduling classes may need a way to perform specific
fixup/accounting work for a thread which is being scheduled out.  We
cannot rely on the sched_pick() handler for this since the first one
to successfully pick a thread prevents other handlers down the class
hierarchy to run.

To address this issue, we introduce the sched_out() handler which is
called for the current thread when scheduled out. This handler is
invoked unconditionally when present prior to picking a new thread.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/evl/sched.h     |  1 +
 kernel/evl/sched/core.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/evl/sched.h b/include/evl/sched.h
index ae9690860146..cc824c28004b 100644
--- a/include/evl/sched.h
+++ b/include/evl/sched.h
@@ -120,6 +120,7 @@ struct evl_sched_class {
 	void (*sched_dequeue)(struct evl_thread *thread);
 	void (*sched_requeue)(struct evl_thread *thread);
 	struct evl_thread *(*sched_pick)(struct evl_rq *rq);
+	void (*sched_out)(struct evl_thread *thread);
 	void (*sched_yield)(struct evl_thread *thread);
 	void (*sched_migrate)(struct evl_thread *thread,
 			      struct evl_rq *rq);
diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
index d1d025e06a5d..f4c0ab0e8812 100644
--- a/kernel/evl/sched/core.c
+++ b/kernel/evl/sched/core.c
@@ -773,7 +773,8 @@ static inline void set_next_running(struct evl_rq *rq,
 		evl_stop_timer(&rq->rrbtimer);
 }
 
-static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
+static __always_inline struct evl_thread *
+__pick_next_thread(struct evl_rq *rq)
 {
 	struct evl_sched_class *sched_class;
 	struct evl_thread *curr = rq->curr;
@@ -821,8 +822,14 @@ static struct evl_thread *__pick_next_thread(struct evl_rq *rq)
 /* rq->curr->lock + rq->lock held, hard irqs off. */
 static struct evl_thread *pick_next_thread(struct evl_rq *rq)
 {
-	struct evl_thread *next = __pick_next_thread(rq);
+	struct evl_thread *next, *prev = rq->curr;
+	struct evl_sched_class *prev_class = prev->sched_class;
 
+	if (prev_class->sched_out)
+		prev_class->sched_out(prev);
+
+	next = __pick_next_thread(rq);
+	trace_evl_pick_thread(next);
 	set_next_running(rq, next);
 
 	return next;
@@ -973,7 +980,6 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
 	}
 
 	next = pick_next_thread(this_rq);
-	trace_evl_pick_thread(next);
 	if (next == curr) {
 		if (unlikely(next->state & EVL_T_ROOT)) {
 			if (this_rq->local_flags & RQ_TPROXY)
-- 
2.54.0

