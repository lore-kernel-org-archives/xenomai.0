Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0F1E573F
	for <xenomai@lists.linux.dev>; Fri,  8 Nov 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068107; cv=none; b=Zfe4i+bfpki/0dRuOFShdKl9B9LlQ9TVgW/3JY/fxcPedGSEj8yUCnoMfbbwWZiJSvlZb2Cxo9XO+aMYlawPzwsLUXu3+mlWsdMrvwnLa/wVW5mD/2/BWnRG7FM9cXYJtCtj7UZn8mhcp5lin3zyruUu7QX2sENPFOng4xBfxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068107; c=relaxed/simple;
	bh=requw1wqbRBaOoLcnjS2H7wcinyc12jAf4TKjgfqhiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OVFF4VjO/7s1rdJAQSjmO46tiH1lul3i6DEEuLKrnCI5/syUzzYVuyoa4Xx9RSNH0LmOvBeLg7ojky9bKg9lqrwgdEaZpbFbXQWSmIvq1TA11OyXEXt5mGXxQsLt6TluasGTKPHJWA/Uq85jiXy1CEeLWSlNw+bLLyHsCqcb3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZLSuYOZt; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZLSuYOZt"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202411081214532a352704c6c5f5b04b
        for <xenomai@lists.linux.dev>;
        Fri, 08 Nov 2024 13:14:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Xn6vNx/KNgNZG31VozYiSEgYIYtwS8y9K6QMH3v8YF8=;
 b=ZLSuYOZt+68yMqkjUC1pDdpMs/DlSHPfQPcb53g9lvIztyQCVEEqr18zETEyoaObXn9wnK
 HXvWmrZR9V0sobjkWMpllwnznJXn1Lek2fXiUsqULymFJflbKvyntpK0UaULVzzYiN4QcNyE
 YfYWd5GgxRrvaiI2E3vh5DLtJOIqZQ3WUTGMJ/+6InEvA77sfWX9VlJCzHpdOVM0tEhMMK6w
 MQMW/imjAq3LVmvNiIPNtA9lwWqCeekwlc33BGYZtlIqK68vaVcF+aYxKWFT27y9xgp28fpG
 v+Sg++LreA9FotHC1tk86zx0CoFaZxJVtsJo1fdkeDLyJcRCBv1R6i8w==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] cobalt: Remove __xnsched_run_handler(), no longer needed for dovetail
Date: Fri,  8 Nov 2024 13:14:50 +0100
Message-Id: <20241108121450.3950604-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

__xnsched_run_handler() was unused as the parameter of
pipeline_request_resched_ipi() was unused as well. That parameter was
only necessary / in use for the old - and meanwhile removed - ipipe
abstraction.

Cleaning up to avoid confusion.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/pipeline.h | 4 ++--
 include/cobalt/kernel/sched.h                      | 2 --
 kernel/cobalt/sched.c                              | 8 +-------
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 478580fc2..2e6e66a2d 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -36,7 +36,7 @@ typedef unsigned long spl_t;
 
 irqreturn_t pipeline_reschedule_ipi_handler(int irq, void *dev_id);
 
-static inline int pipeline_request_resched_ipi(void (*handler)(void))
+static inline int pipeline_request_resched_ipi(void)
 {
 	if (num_possible_cpus() == 1)
 		return 0;
@@ -75,7 +75,7 @@ static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
 
 #else  /* !CONFIG_SMP */
 
-static inline int pipeline_request_resched_ipi(void (*handler)(void))
+static inline int pipeline_request_resched_ipi(void)
 {
 	return 0;
 }
diff --git a/include/cobalt/kernel/sched.h b/include/cobalt/kernel/sched.h
index aa24d5442..e0b4249a4 100644
--- a/include/cobalt/kernel/sched.h
+++ b/include/cobalt/kernel/sched.h
@@ -294,8 +294,6 @@ static inline int xnsched_threading_cpu(int cpu)
 
 int ___xnsched_run(struct xnsched *sched);
 
-void __xnsched_run_handler(void);
-
 static inline int __xnsched_run(struct xnsched *sched)
 {
 	/*
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index 62db291a7..f1c799bba 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -235,7 +235,7 @@ void xnsched_init_all(void)
 		xnsched_init(sched, cpu);
 	}
 
-	pipeline_request_resched_ipi(__xnsched_run_handler);
+	pipeline_request_resched_ipi();
 }
 
 static void xnsched_destroy(struct xnsched *sched)
@@ -888,12 +888,6 @@ static inline void leave_root(struct xnthread *root)
 #endif
 }
 
-void __xnsched_run_handler(void) /* hw interrupts off. */
-{
-	trace_cobalt_schedule_remote(xnsched_current());
-	xnsched_run();
-}
-
 static inline void do_lazy_user_work(struct xnthread *curr)
 {
 	xnthread_commit_ceiling(curr);
-- 
2.39.5

