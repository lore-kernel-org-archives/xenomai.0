Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E05539A
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:09 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202309031504593d7d147a728174778a
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:04:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=e2XKXRg6zqtchk2sSwNvaGV/4IfQoS03ufomaCEHGOI=;
 b=gE1XtiJNv5xa1V4BCQFBbO4YbZFagsOHPfEFJjGLw+J+9Z97KvqLtmC3NjrnzKBWO9bwZh
 DlPujrJGU/tFvkO9upEUNrb9g8sMLYaV1kHU5PXGZ+fz5L3XzDQhNoytBNYdkudMKsfefHTq
 OGQMnYN+xHkBnPWyDeR3vUHQzyurs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 03/20] cobalt: Drop not longer supported CONFIG_XENO_OPT_STATS_IRQS
Date: Sun,  3 Sep 2023 17:04:40 +0200
Message-Id: <5cc0ad828e9e7e2c4ba7dc7dfc0e3a54694b607d.1693753497.git.jan.kiszka@siemens.com>
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

This was I-pipe-only, and I-pipe is gone.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/intr.h | 30 ---------------------
 kernel/cobalt/Kconfig        | 12 ---------
 kernel/cobalt/sched.c        | 51 ++----------------------------------
 3 files changed, 2 insertions(+), 91 deletions(-)

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index 393ad96830..060edc8a57 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -84,10 +84,6 @@ struct xnintr {
 	const char *name;
 	/** Descriptor maintenance lock. */
 	raw_spinlock_t lock;
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-	/** Statistics. */
-	struct xnirqstat *stats;
-#endif
 };
 
 struct xnintr_iterator {
@@ -126,32 +122,6 @@ void xnintr_disable(struct xnintr *intr);
 
 int xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask);
 
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-
-int xnintr_query_init(struct xnintr_iterator *iterator);
-
-int xnintr_get_query_lock(void);
-
-void xnintr_put_query_lock(void);
-
-int xnintr_query_next(int irq, struct xnintr_iterator *iterator,
-		      char *name_buf);
-
-#else /* !CONFIG_XENO_OPT_STATS_IRQS */
-
-static inline int xnintr_query_init(struct xnintr_iterator *iterator)
-{
-	return 0;
-}
-
-static inline int xnintr_get_query_lock(void)
-{
-	return 0;
-}
-
-static inline void xnintr_put_query_lock(void) {}
-#endif /* !CONFIG_XENO_OPT_STATS_IRQS */
-
 /** @} */
 
 #endif /* !_COBALT_KERNEL_INTR_H */
diff --git a/kernel/cobalt/Kconfig b/kernel/cobalt/Kconfig
index 3233de1b18..6ba4cdc5db 100644
--- a/kernel/cobalt/Kconfig
+++ b/kernel/cobalt/Kconfig
@@ -135,18 +135,6 @@ config XENO_OPT_STATS
 	per-thread runtime statistics, which are accessible through
 	the /proc/xenomai/sched/stat interface.
 
-config XENO_OPT_STATS_IRQS
-	bool "Account IRQ handlers separatly"
-	depends on XENO_OPT_STATS && IPIPE
-	default y
-	help
-	When enabled, the runtime of interrupt handlers is accounted
-	separately from the threads they interrupt. Also, the
-	occurrence of shared interrupts is accounted on a per-handler
-	basis.
-
-	This option is available to legacy I-pipe builds only.
-
 config XENO_OPT_SHIRQ
 	bool "Shared interrupts"
 	help
diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
index aa65fd7f5d..62db291a71 100644
--- a/kernel/cobalt/sched.c
+++ b/kernel/cobalt/sched.c
@@ -1121,11 +1121,6 @@ static spl_t vfile_schedstat_lock_s;
 
 static int vfile_schedstat_get_lock(struct xnvfile *vfile)
 {
-	int ret;
-
-	ret = xnintr_get_query_lock();
-	if (ret < 0)
-		return ret;
 	xnlock_get_irqsave(&nklock, vfile_schedstat_lock_s);
 	return 0;
 }
@@ -1133,7 +1128,6 @@ static int vfile_schedstat_get_lock(struct xnvfile *vfile)
 static void vfile_schedstat_put_lock(struct xnvfile *vfile)
 {
 	xnlock_put_irqrestore(&nklock, vfile_schedstat_lock_s);
-	xnintr_put_query_lock();
 }
 
 static struct xnvfile_lock_ops vfile_schedstat_lockops = {
@@ -1177,7 +1171,6 @@ static struct xnvfile_snapshot schedstat_vfile = {
 static int vfile_schedstat_rewind(struct xnvfile_snapshot_iterator *it)
 {
 	struct vfile_schedstat_priv *priv = xnvfile_iterator_priv(it);
-	int irqnr;
 
 	/*
 	 * The activity numbers on each valid interrupt descriptor are
@@ -1185,9 +1178,8 @@ static int vfile_schedstat_rewind(struct xnvfile_snapshot_iterator *it)
 	 */
 	priv->curr = list_first_entry(&nkthreadq, struct xnthread, glink);
 	priv->irq = 0;
-	irqnr = xnintr_query_init(&priv->intr_it) * num_online_cpus();
 
-	return irqnr + cobalt_nrthreads;
+	return cobalt_nrthreads;
 }
 
 static int vfile_schedstat_next(struct xnvfile_snapshot_iterator *it,
@@ -1201,11 +1193,7 @@ static int vfile_schedstat_next(struct xnvfile_snapshot_iterator *it,
 	int __maybe_unused ret;
 
 	if (priv->curr == NULL)
-		/*
-		 * We are done with actual threads, scan interrupt
-		 * descriptors.
-		 */
-		goto scan_irqs;
+		return 0; /* We are done. */
 
 	thread = priv->curr;
 	if (list_is_last(&thread->glink, &nkthreadq))
@@ -1242,41 +1230,6 @@ static int vfile_schedstat_next(struct xnvfile_snapshot_iterator *it,
 	thread->stat.lastperiod.start = sched->last_account_switch;
 
 	return 1;
-
-scan_irqs:
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-	if (priv->irq >= PIPELINE_NR_IRQS)
-		return 0;	/* All done. */
-
-	ret = xnintr_query_next(priv->irq, &priv->intr_it, p->name);
-	if (ret) {
-		if (ret == -EAGAIN)
-			xnvfile_touch(it->vfile); /* force rewind. */
-		priv->irq++;
-		return VFILE_SEQ_SKIP;
-	}
-
-	if (!xnsched_supported_cpu(priv->intr_it.cpu))
-		return VFILE_SEQ_SKIP;
-
-	p->cpu = priv->intr_it.cpu;
-	p->csw = priv->intr_it.hits;
-	p->exectime_period = priv->intr_it.exectime_period;
-	p->account_period = priv->intr_it.account_period;
-	p->exectime_total = priv->intr_it.exectime_total;
-	p->pid = 0;
-	p->state =  0;
-	p->ssw = 0;
-	p->xsc = 0;
-	p->pf = 0;
-	p->sched_class = &xnsched_class_idle;
-	p->cprio = 0;
-	p->period = 0;
-
-	return 1;
-#else /* !CONFIG_XENO_OPT_STATS_IRQS */
-	return 0;
-#endif /* !CONFIG_XENO_OPT_STATS_IRQS */
 }
 
 static int vfile_schedstat_show(struct xnvfile_snapshot_iterator *it,
-- 
2.35.3

