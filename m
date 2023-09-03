Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267703D60
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:07 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230903150459c3ce73e43a84847974
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:04:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Gfx6lCBkl/eX67pAPoWTGUt1bfOHFCMfAZcrIi+LHS4=;
 b=NV1wfJC/NXuHtd2tD0L9xGQcv96TgKgft0q3sTO2jqm/365Mi86NZlEWb6oTqYLwVxH3do
 lufSJb+tHmAJyGXDiF7ibopjYhmypo4vvoiBl/k1a861TcKFm0DU8zOKqgfwufnIaUaLIlFT
 kQGStu+nrT/nhzhZsFRroIQehdbcs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 01/20] cobalt: Drop self element from lostage_signal
Date: Sun,  3 Sep 2023 17:04:38 +0200
Message-Id: <fa0f7672881caa4e820289551622615cc54c71de.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This was only needed for I-pipe which was dropped.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h | 1 -
 kernel/cobalt/thread.c         | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index b79cb84296..7f9a37d29a 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -62,7 +62,6 @@ struct lostage_signal {
 	struct pipeline_inband_work inband_work; /* Must be first. */
 	struct task_struct *task;
 	int signo, sigval;
-	struct lostage_signal *self; /* Revisit: I-pipe requirement */
 };
 
 struct xnthread_init_attr {
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 41804b24fc..cf3b4dbb0e 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2162,11 +2162,6 @@ static void lostage_task_signal(struct pipeline_inband_work *inband_work)
 	spl_t s;
 
 	rq = container_of(inband_work, struct lostage_signal, inband_work);
-	/*
-	 * Revisit: I-pipe requirement. It passes a copy of the original work
-	 * struct, so retrieve the original one first in order to update is.
-	 */
-	rq = rq->self;
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -2396,7 +2391,6 @@ void __xnthread_signal(struct xnthread *thread, int sig, int arg)
 	sigwork->task = xnthread_host_task(thread);
 	sigwork->signo = sig;
 	sigwork->sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg;
-	sigwork->self = sigwork; /* Revisit: I-pipe requirement */
 
 	trace_cobalt_lostage_request("signal", sigwork->task);
 
-- 
2.35.3

