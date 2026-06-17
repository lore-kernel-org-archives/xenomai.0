Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9354071D9
	for <xenomai@lists.linux.dev>; Wed, 17 Jun 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706128; cv=none; b=GRWh71NI6fzp32biBzB3aPwVLT4rhDHZ6MeojKNI3LBPufdO6W1Qa9TyXW3ir77WA9iIbmpHw2XuM1cwrD7B7UTM9+qHbQcRMIRrNIkLpXgwo8pwhRD0mczn6evnOHhIZSKLlm5KMd39VHHRVMCRof7sLIhcbjPNqlw5OnhVU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706128; c=relaxed/simple;
	bh=LszCbHS94ZM4W6yLYN5b5oXOuH4LE9MW6P/UVMzEc6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9G4fki0j0gpTfQi/IKNL0sU9+HG0Flpb66kgnQrxWF/Z8ArZNqNp3d8RoWSUcUhl/AZ8dozcr3/449D0EhU/FAyJosIZxMFyBR8rPTKP/k1N9AgrccrtSRSIquzh1zcO1A5DtzUNZD3TuJjN1oklr2OKdjbediq0UZE5HB0UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=pFSGT5Jd; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="pFSGT5Jd"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E9343F685;
	Wed, 17 Jun 2026 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781706124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=umQpWzFiqbkHxVI7t62Pi2WKJ+5tWubTDAr37TnU1iQ=;
	b=pFSGT5JdADEVfKlJ65fdSQR+WwapY8uDf2fUfjtYI0UN4kwvCQ/jQ+3+JvESBnvDcSs8gD
	AtwiANAhUxHQ7DRIwplqmJUq7fJViFEcJOJQPeXbUEXibxxYCZSO3tV+XYdsgBBm+I8xSq
	LOJCQvl8jof/oLcjeal85Y23o7GkNo0LpJfH1dJmtPGHGGnswGyaPcGJSoURSEwSPiBbh2
	Jhq8yhZmik52HnqXHNjGfZPA6FJZOD1861BermrJAoCTy5x+EN70QLf2f9dhqT5Kv/8VWa
	CW51gbi/D14Y0YqF2WlvivAmkU/qCrfWYVwuW6n1C/W9f6qUFy0qwBRkqcQRhA==
From: Philippe  Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH v1 1/2] evl/sched: core: introduce schedule out handler
Date: Wed, 17 Jun 2026 16:20:10 +0200
Message-ID: <20260617142050.477809-2-rpm@xenomai.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617142050.477809-1-rpm@xenomai.org>
References: <20260617142050.477809-1-rpm@xenomai.org>
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
X-GND-Cause: dmFkZTGR7hyYjOdxNq2ptItqlpE9Fjbt3R5pGb4raq26QTWFV0pLFigsJ/a5itzfbI5ezwPI9EfR/MXPoqPlDwjbLD55ReP1cCmbyz5jDPKbXFTGCyUVvzRL9GyUu+QIr08bFM3h4EnT9h2nd1/tZPNVMhIa6MGuqw0C9UQvAObs0c9Ou6OgxcoF2wRWu+YbNeTtfYL9idd6tW43MCbEzt5KGOO17tZS9td9nbUKknd/CNKkld2rGDTexEE3ZXaVkb/VOOqcKhKenysSTQVRFPM5Q3eZcmlkK+p/OUeYlcY4zkH0q/Xs3I/ykqwA4IcLHkx109WZHaMG/teG3OS0MajVnihnjmuUS8JePe87U3EP7n/kmwhiE14sBFehztRLUHJSYUtS00oTIGpwPgWetZGyrUzC5wUqRASw3OopijBXKvXfXatE4l+MuW8smvRPKr2B56fnUc/5D+HjXgnVcEsEj7nz2RPl2s3WJ4A6S4j/7upDatm+VH61P2EdRb2w5Fp209qtGZEYEc+X9K4UbC0xWqYIN1BAVQJN30MAE3XVCPbjtiN64l+FesD0l9+EM8TSFR9CEUmIUzlVqR8Vyw/yJDho/ujJW1LaqZbI9dd1r9988i6bTrZETKk6gNiiZ4i3cOog5C7b61Dq94WiZI8ehfEhT2S1Jwrg6DWAMnHhjq0d2g

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
 kernel/evl/sched/core.c | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

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
index d1d025e06a5d..7127d4e52df9 100644
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
@@ -972,21 +979,20 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
 		return;
 	}
 
+	prev = curr;
 	next = pick_next_thread(this_rq);
-	trace_evl_pick_thread(next);
-	if (next == curr) {
-		if (unlikely(next->state & EVL_T_ROOT)) {
+	if (next == prev) {
+		if (unlikely(prev->state & EVL_T_ROOT)) {
 			if (this_rq->local_flags & RQ_TPROXY)
 				evl_notify_proxy_tick(this_rq);
 			if (this_rq->local_flags & RQ_TDEFER)
 				evl_program_local_tick(&evl_mono_clock);
 		}
 		raw_spin_unlock(&this_rq->lock);
-		raw_spin_unlock_irqrestore(&curr->lock, flags);
+		raw_spin_unlock_irqrestore(&prev->lock, flags);
 		return;
 	}
 
-	prev = curr;
 	this_rq->curr = next;
 	leaving_inband = false;
 
-- 
2.54.0

