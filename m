Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0718E37B
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016427; cv=none; b=ebL+8euOQCmnWI975mnnfMvMagLKwaVqtc5adc5V/rk4P1gXM4PV/DV5xZKTe64jkiSIzCDGxf0MODOHuTSwVEzxu7xbdl154Mulhpc5TQjN6bFk7iewdDxoaIw3ai5urqVG0M38rPCmOjN/YxHevChl3DZxJJFrp2PoP0ScxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016427; c=relaxed/simple;
	bh=sIUybY6W2aXinnXe3sTnjFjdKEE0236iINoVUj2VDd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7e3Oza7gH3fIbDH1k1m8Lkymk2iQnlyG6plCAYlZDXWBMOpeQ+q6y8b2vYUvj0KVi7cxAbGMCKwc8KLfR9Jn5e3My5a8Q3X9okKAd+Bs5sbnScr0ZmeRFvSahE6b4tVkNPH3lnzvpTUW39T/YM3TfKRchALJWRXSr/sGVs9SjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Af2qNauP; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Af2qNauP"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202408301113347b66e2b4eddaa0cf4c
        for <xenomai@lists.linux.dev>;
        Fri, 30 Aug 2024 13:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PHoy1Eqi3tPgOli9QdkFBwt0qJ4O2rbvMpnsuQHyC+8=;
 b=Af2qNauPLy6/ALpPlaZrKq06pQn5kpgsDJsFxCIUwSxQH+TGdsmjaMcoCzoR5xxY3Vjl88
 yI9gMU1vNrBrqyhGUJy/wke9sUPQWKBrHlL43Ro3SlAIlG6OLT/82BjT7Px4mqh6pxzD5SvS
 ZQYdQTvSXpx6Afkk3PKooi4lpyssq0SCbcPmJ1ZiTNrWQpWhkNvK0XLDPuHxTO3wRqBz9PRD
 +aTeFnJkg97WtAtg5FxepyrxXV18pCocNQcmrsRlrnnD/exSzGBXhC5+NA8WQ7nWgGHwoRzw
 qrAZUR+pkXbSE+qBZJBZ109ADmvim7XvXrCUNgEIXcWNWCo7L5pQDlMg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: JerryJun <jerryjun123@163.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 2/3] cobalt: Drop obsolete pipeline_inband_work abstraction
Date: Fri, 30 Aug 2024 13:13:32 +0200
Message-ID: <201c05b5d126b2d6193ca7b2b5125b1d16126e5c.1725016413.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725016413.git.jan.kiszka@siemens.com>
References: <cover.1725016413.git.jan.kiszka@siemens.com>
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

We are now dovetail-only and can use irq_work directly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../kernel/dovetail/pipeline/inband_work.h    | 28 -------------------
 include/cobalt/kernel/rtdm/driver.h           |  9 +++---
 include/cobalt/kernel/thread.h                |  6 ++--
 kernel/cobalt/rtdm/drvlib.c                   | 15 ++++------
 kernel/cobalt/rtdm/fd.c                       | 13 ++++-----
 kernel/cobalt/thread.c                        | 24 +++++++---------
 kernel/drivers/udd/udd.c                      | 12 ++++----
 7 files changed, 33 insertions(+), 74 deletions(-)
 delete mode 100644 include/cobalt/kernel/dovetail/pipeline/inband_work.h

diff --git a/include/cobalt/kernel/dovetail/pipeline/inband_work.h b/include/cobalt/kernel/dovetail/pipeline/inband_work.h
deleted file mode 100644
index a69bf651f0..0000000000
--- a/include/cobalt/kernel/dovetail/pipeline/inband_work.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_KERNEL_DOVETAIL_INBAND_WORK_H
-#define _COBALT_KERNEL_DOVETAIL_INBAND_WORK_H
-
-#include <linux/irq_work.h>
-
-/*
- * This field must be named inband_work and appear first in the
- * container work struct.
- */
-struct pipeline_inband_work {
-	struct irq_work work;
-};
-
-#define PIPELINE_INBAND_WORK_INITIALIZER(__handler)			\
-	{								\
-		.work = IRQ_WORK_INIT((void (*)(struct irq_work *))__handler), \
-	}
-
-#define pipeline_post_inband_work(__work)				\
-			irq_work_queue(&(__work)->inband_work.work)
-
-#endif /* !_COBALT_KERNEL_DOVETAIL_INBAND_WORK_H */
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 8fb326b1cf..604d54b2b7 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -28,13 +28,13 @@
 
 #include <asm/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/irq_work.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
 #include <linux/wait.h>
 #include <linux/notifier.h>
 #include <pipeline/lock.h>
-#include <pipeline/inband_work.h>
 #include <xenomai/version.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/sched.h>
@@ -909,7 +909,7 @@ typedef struct rtdm_nrtsig rtdm_nrtsig_t;
 typedef void (*rtdm_nrtsig_handler_t)(rtdm_nrtsig_t *nrt_sig, void *arg);
 
 struct rtdm_nrtsig {
-	struct pipeline_inband_work inband_work; /* Must be first */
+	struct irq_work inband_work;
 	rtdm_nrtsig_handler_t handler;
 	void *arg;
 };
@@ -918,13 +918,12 @@ void rtdm_schedule_nrt_work(struct work_struct *lostage_work);
 /** @} rtdm_nrtsignal */
 
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
-void __rtdm_nrtsig_execute(struct pipeline_inband_work *inband_work);
+void __rtdm_nrtsig_execute(struct irq_work *inband_work);
 
 static inline void rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig,
 				    rtdm_nrtsig_handler_t handler, void *arg)
 {
-	nrt_sig->inband_work = (struct pipeline_inband_work)
-		PIPELINE_INBAND_WORK_INITIALIZER(__rtdm_nrtsig_execute);
+	nrt_sig->inband_work = IRQ_WORK_INIT(__rtdm_nrtsig_execute);
 	nrt_sig->handler = handler;
 	nrt_sig->arg = arg;
 }
diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 22ed61168c..04fad0e491 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -19,11 +19,11 @@
 #ifndef _COBALT_KERNEL_THREAD_H
 #define _COBALT_KERNEL_THREAD_H
 
+#include <linux/irq_work.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <pipeline/thread.h>
-#include <pipeline/inband_work.h>
 #include <cobalt/kernel/list.h>
 #include <cobalt/kernel/stat.h>
 #include <cobalt/kernel/timer.h>
@@ -59,13 +59,13 @@ struct xnthread_personality;
 struct completion;
 
 struct lostage_signal {
-	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct irq_work inband_work;
 	struct task_struct *task;
 	int signo, sigval;
 };
 
 struct lostage_wakeup {
-	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct irq_work inband_work;
 	struct task_struct *task;
 };
 
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index e6e658c8c4..86788743fe 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -31,7 +31,6 @@
 #include <linux/anon_inodes.h>
 #include <rtdm/driver.h>
 #include <rtdm/compat.h>
-#include <pipeline/inband_work.h>
 #include "internal.h"
 #include <trace/events/cobalt-rtdm.h>
 
@@ -1616,7 +1615,7 @@ int rtdm_nrtsig_init(rtdm_nrtsig_t *nrt_sig, rtdm_nrtsig_handler_t handler,
 void rtdm_nrtsig_destroy(rtdm_nrtsig_t *nrt_sig);
 #endif /* DOXYGEN_CPP */
 
-void __rtdm_nrtsig_execute(struct pipeline_inband_work *inband_work)
+void __rtdm_nrtsig_execute(struct irq_work *inband_work)
 {
 	struct rtdm_nrtsig *nrt_sig;
 
@@ -1634,14 +1633,14 @@ EXPORT_SYMBOL_GPL(__rtdm_nrtsig_execute);
  */
 void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig)
 {
-	pipeline_post_inband_work(nrt_sig);
+	irq_work_queue(&nrt_sig->inband_work);
 }
 EXPORT_SYMBOL_GPL(rtdm_nrtsig_pend);
 
 static LIST_HEAD(nrt_work_list);
 DEFINE_PRIVATE_XNLOCK(nrt_work_lock);
 
-static void lostage_schedule_work(struct pipeline_inband_work *inband_work)
+static void lostage_schedule_work(struct irq_work *inband_work)
 {
 	struct work_struct *lostage_work;
 	spl_t s;
@@ -1663,11 +1662,7 @@ static void lostage_schedule_work(struct pipeline_inband_work *inband_work)
 	xnlock_put_irqrestore(&nrt_work_lock, s);
 }
 
-static struct lostage_trigger_work {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-} nrt_work =  {
-	.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(lostage_schedule_work),
-};
+static DEFINE_IRQ_WORK(nrt_work, lostage_schedule_work);
 
 /**
  * Put a work task in Linux non real-time global workqueue from primary mode.
@@ -1686,7 +1681,7 @@ void rtdm_schedule_nrt_work(struct work_struct *lostage_work)
 	xnlock_get_irqsave(&nrt_work_lock, s);
 
 	list_add_tail(&lostage_work->entry, &nrt_work_list);
-	pipeline_post_inband_work(&nrt_work);
+	irq_work_queue(&nrt_work);
 
 	xnlock_put_irqrestore(&nrt_work_lock, s);
 }
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 29555cb213..d5813a16c2 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -17,6 +17,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
+#include <linux/irq_work.h>
 #include <linux/list.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -29,7 +31,6 @@
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/ppd.h>
 #include <cobalt/kernel/time.h>
-#include <pipeline/inband_work.h>
 #include <trace/events/cobalt-rtdm.h>
 #include <rtdm/compat.h>
 #include <rtdm/fd.h>
@@ -297,16 +298,12 @@ static int fd_cleanup_thread(void *data)
 	return 0;
 }
 
-static void lostage_trigger_close(struct pipeline_inband_work *inband_work)
+static void lostage_trigger_close(struct irq_work *inband_work)
 {
 	up(&rtdm_fd_cleanup_sem);
 }
 
-static struct lostage_trigger_close {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-} fd_closework =  {
-	.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(lostage_trigger_close),
-};
+static DEFINE_IRQ_WORK(fd_closework, lostage_trigger_close);
 
 static void __put_fd(struct rtdm_fd *fd, spl_t s)
 {
@@ -331,7 +328,7 @@ static void __put_fd(struct rtdm_fd *fd, spl_t s)
 		xnlock_put_irqrestore(&fdtree_lock, s);
 
 		if (trigger)
-			pipeline_post_inband_work(&fd_closework);
+			irq_work_queue(&fd_closework);
 	}
 }
 
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 7dffb081bd..bdd0531404 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -40,7 +40,6 @@
 #include <cobalt/kernel/lock.h>
 #include <cobalt/kernel/thread.h>
 #include <pipeline/kevents.h>
-#include <pipeline/inband_work.h>
 #include <pipeline/sched.h>
 #include <trace/events/cobalt-core.h>
 #include "debug.h"
@@ -86,12 +85,12 @@ static inline void enlist_new_thread(struct xnthread *thread)
 }
 
 struct kthread_arg {
-	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct irq_work inband_work;
 	struct xnthread *thread;
 	struct completion *done;
 };
 
-static void do_parent_wakeup(struct pipeline_inband_work *inband_work)
+static void do_parent_wakeup(struct irq_work *inband_work)
 {
 	struct kthread_arg *ka;
 
@@ -150,9 +149,8 @@ static int map_kthread(struct xnthread *thread, struct kthread_arg *ka)
 
 	trace_cobalt_lostage_request("wakeup", current);
 
-	ka->inband_work = (struct pipeline_inband_work)
-		PIPELINE_INBAND_WORK_INITIALIZER(do_parent_wakeup);
-	pipeline_post_inband_work(ka);
+	ka->inband_work = IRQ_WORK_INIT(do_parent_wakeup);
+	irq_work_queue(&ka->inband_work);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -1974,7 +1972,7 @@ int xnthread_harden(void)
 }
 EXPORT_SYMBOL_GPL(xnthread_harden);
 
-static void lostage_task_wakeup(struct pipeline_inband_work *inband_work)
+static void lostage_task_wakeup(struct irq_work *inband_work)
 {
 	struct lostage_wakeup *rq;
 	struct task_struct *p;
@@ -2060,8 +2058,7 @@ void xnthread_relax(int notify, int reason)
 	 */
 	trace_cobalt_shadow_gorelax(reason);
 
-	thread->relax_work.inband_work = (struct pipeline_inband_work)
-		PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup);
+	thread->relax_work.inband_work = IRQ_WORK_INIT(lostage_task_wakeup);
 	thread->relax_work.task = p;
 
 	/*
@@ -2076,7 +2073,7 @@ void xnthread_relax(int notify, int reason)
 	 */
 	splmax();
 	trace_cobalt_lostage_request("wakeup", p);
-	pipeline_post_inband_work(&thread->relax_work);
+	irq_work_queue(&thread->relax_work.inband_work);
 	/*
 	 * Grab the nklock to synchronize the Linux task state
 	 * manipulation with handle_sigwake_event. This lock will be
@@ -2154,7 +2151,7 @@ void xnthread_relax(int notify, int reason)
 }
 EXPORT_SYMBOL_GPL(xnthread_relax);
 
-static void lostage_task_signal(struct pipeline_inband_work *inband_work)
+static void lostage_task_signal(struct irq_work *inband_work)
 {
 	struct lostage_signal *rq;
 	struct task_struct *p;
@@ -2387,15 +2384,14 @@ void __xnthread_signal(struct xnthread *thread, int sig, int arg)
 	if (sigwork->task)
 		return;
 
-	sigwork->inband_work = (struct pipeline_inband_work)
-			PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_signal);
+	sigwork->inband_work = IRQ_WORK_INIT(lostage_task_signal);
 	sigwork->task = xnthread_host_task(thread);
 	sigwork->signo = sig;
 	sigwork->sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg;
 
 	trace_cobalt_lostage_request("signal", sigwork->task);
 
-	pipeline_post_inband_work(sigwork);
+	irq_work_queue(&sigwork->inband_work);
 }
 
 void xnthread_signal(struct xnthread *thread, int sig, int arg)
diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index b1efcebd0f..c7b8f5c7bf 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -17,6 +17,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -24,7 +26,6 @@
 #include <rtdm/cobalt.h>
 #include <rtdm/driver.h>
 #include <rtdm/udd.h>
-#include <pipeline/inband_work.h>
 
 struct udd_context {
 	u32 event_count;
@@ -516,13 +517,13 @@ void udd_notify_event(struct udd_device *udd)
 EXPORT_SYMBOL_GPL(udd_notify_event);
 
 struct irqswitch_work {
-	struct pipeline_inband_work inband_work;
+	struct irq_work inband_work;
 	rtdm_irq_t *irqh;
 	int enabled;
 	rtdm_event_t *done;
 };
 
-static void lostage_irqswitch_line(struct pipeline_inband_work *inband_work)
+static void lostage_irqswitch_line(struct irq_work *inband_work)
 {
 	struct irqswitch_work *rq;
 
@@ -550,8 +551,7 @@ static void switch_irq_line(rtdm_irq_t *irqh, int enable, rtdm_event_t *done)
 	if (WARN_ON(rq == NULL))
 		return;
 
-	rq->inband_work = (struct pipeline_inband_work)
-		PIPELINE_INBAND_WORK_INITIALIZER(lostage_irqswitch_line);
+	rq->inband_work = IRQ_WORK_INIT(lostage_irqswitch_line);
 	rq->irqh = irqh;
 	rq->enabled = enable;
 	rq->done = done;
@@ -561,7 +561,7 @@ static void switch_irq_line(rtdm_irq_t *irqh, int enable, rtdm_event_t *done)
 	 * enabling/disabling IRQ lines from primary mode. Defer this
 	 * to the root context.
 	 */
-	pipeline_post_inband_work(rq);
+	irq_work_queue(&rq->inband_work);
 }
 
 /**
-- 
2.43.0

