Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9350238F92D
	for <xenomai@lists.linux.dev>; Thu, 18 Jun 2026 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771745; cv=none; b=fHbXK5iLqc73F5It7CWpNQNt/fBNMebRBQaKQTFWfIl0/j5L5R5LUVez7fXr8Q1EzYCGEJEVn1KGbY64mcfAlDDJK9qsEG0D8dvsgJI4QOkPON68UcCY1nHrQZoE145fcpxRPlTYduD1wSIJFEEK7115RvDm/8lYeDztpSaxyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771745; c=relaxed/simple;
	bh=OlyrQ0+sBQOgcg2wctVveBlTBdDfyqSjYDg4Qmp6+zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNcfnck0Rt2bwg+HZmaKl5/An6Li/TqK7spG0fOL7wGOamE42AHMdzzYQc3ridRwksKEYGS1Znk+uIvq8mpzQ4VFHa51amML0JHMD+h0eAkBkdD0UQw+LJXQ2WdqHiU8Hg231c+tckpFKkYy+qhN3GME8h5bNCbPtwaZeY+h3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=LCQKoFwG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="LCQKoFwG"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCCF71FCF3;
	Thu, 18 Jun 2026 08:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781771741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmSMwBEwFVGx/Ucz3pjmWVqoc+cxYMOil4IGj/rav34=;
	b=LCQKoFwGgo+cN5zEnjcJzzcdKYtMWflkVO6l5G8kzp+OxIm1WYx4COjiA0vqy4rr/UUyb4
	us9hSJz/3HtdHwwY19rCr0Mh8kSFkManzpZWIf1Ckm+P2q9yDocHgh/FAiosKFIMCqPsM+
	wOmCOsxAe25Pu5iFe6T4L2YHPAmoxvcYpnvtQ15bnYAdOuSgGZrYE+7EQu7wuHT0d4Yt0F
	SC4GaaWbyFXJvz+0C3WxTDjhzhPd9iFCNiueaSpm/E9WLmLfq3aZ0pD7FGU5p71hVcJqF2
	1080kBL9NW/9G1V2gOUhJrbpgmqmFVx+oIoa3TycbBdBIygv4d8HRp2p/1kqWQ==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v2 1/2] evl/sched: core: introduce schedule out handler
Date: Thu, 18 Jun 2026 10:33:23 +0200
Message-ID: <20260618083524.253860-2-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618083524.253860-1-rpm@xenomai.org>
References: <20260618083524.253860-1-rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFukAoSMPn+zck6wPVZylajpGTRxkfFNbRPLhNZJ7nNOeAPO5x4KHWb6ssDT8ZNJ/oAlmj/pq/GmN3qdVOoXSWjBqRsTwXOKJ/Tc3svFwxLLrlSc6jVwJ1akqX0Y3Tb1E4hcO8c1XxIsOdu3+lzCMHy5Ov5C052XFRt0sSiRlPz2QugL816a795gWVLkv0AfoVGsuGXz8l1jwlkS31jbJdwKCKEoZH0nqmRRqHh+0mdiaJbAWVoyXy7HeAm7fRZgt2riEu3q5O9D5Bwp7C/jgr2UU1WrHiLFT3b/K8/qFG/defYkjs9by8MIDbfky8CIt0yy6uK72au71OCqVJh33issg3AmL9ckfsy1Rw6hEDnV9P77kRFe+nw5xnuWFhBN0bL7y3shneW5FNeQqXfCV3Kt5umgmc+wOQWQrDJRo7tJw01ya2QSfcGySDaObKLnQHQeXXKYag4/BhGVTY5Fx1heqk0iB2zhOpVzzhVD/S7Hwa7h+z9pgtBfLvSsHx4IQFqVWxVntoRWFn4lH9ICcFeKaLyi0Wnd9xffNnN65fUeRXUKnNk4Uc8cFElQEpnkttYxfMR+hlf3VVAySzu/ywAdJ10p/aYSCVEXwSKAU/ZqLJqGG7LOVFcEF/7PYnO0YtUbE/XlN3ZTFvOdDCr8kM1mUu7G4k1p8E+inDAx0EzxA

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

