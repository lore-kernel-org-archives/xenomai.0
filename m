Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73741199951
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016427; cv=none; b=mDiQht0mS43mgZdWmd1w3YUu3DPlPVUutxXpIWU8jGBzIbnuKBsn/XpsacAJj1tdmqAVA+v0vTmcSlIZeKSCDUzaYrNIU0GOOwNsk+ffDvUdDEmzes8SxuuTvI7jByTwTIPw+Je5XUuw1ZZIhsJzo6cc/SMWgZakmhsoXXr0iLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016427; c=relaxed/simple;
	bh=l8+kajZqsdkYXQEVPxdtAtYOcieah/nvix4KGGnbryY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSOdHn/MowourWdoByF0ebveT1kMEy1yB/nJQuP+iaLoyyVZQuW/vFnc+lkNpp/i1xDz0tegj0Td8Qr83etFjF+FVmFcRyvIgUu5K4rUZtLDtctf+cZ1KjYiLiyf1Bo55Z0nDamLYwbAVi2QDRrVBBb5dedsb6Vp/2gCJ8vuOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=eOvhPF4V; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="eOvhPF4V"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240830111334b71ddee85bd8c5b958
        for <xenomai@lists.linux.dev>;
        Fri, 30 Aug 2024 13:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yn8/cue9bcNeGoKHVj4iN2K7wjoisbk4tamw2uTc16k=;
 b=eOvhPF4VnDmkS/VfmJIG6Tqisbf+XJfd2LzH/4tjJdwsBSj7thQOCFIX+tqcpW+02g2VUo
 lVhYicTD1t6rHX8yNBCAHBJAbUOEClqfQhGOXq2A/7RFJZP/GBWVznxjIdt1rh4J6uGtZEVU
 c3tcAZKDfPpCuYHKeZfv4hk3eD9exNDlQdqpiDlNcyPA6Wa8yMDraKplJvjhuFGjjgc2+Dmx
 3OBcqrqbx0AyJM9Gxdx/9uj+xeFcrlBBUf1VJn6hjdNyXGnv2GY0X/U0Jxkz7s8DY4xB+R+L
 kPnpXmHprjui2UvZYCbMaJ8tAr7gMD7Z6zxBpTGWrdQxQrFBqUTldU7Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: JerryJun <jerryjun123@163.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/3] cobalt: Move relax related lostage_wakeup work from stack to thread
Date: Fri, 30 Aug 2024 13:13:31 +0200
Message-ID: <95ccd795ec5db6c2d4d867b0f29fae964cffcf82.1725016413.git.jan.kiszka@siemens.com>
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

We cannot rely on the lostage_wakeup work being scheduled only
synchronously over the CPU of the relaxing thread. It thread might have
a CPU migration and other wakeup events pending and resume on different
CPU. As the lostage_wakeup work is currently on the stack, it can become
corrupt when xnthread_relax leaves earlier on the new CPU than the work
was processed on the old one - ugly crashes ahead as seen in [1].

Analogously to the signal wakeups, move the relax work into the xnthread
structure to avoid such corruptions. We intentionally refrain from
using irq_work_sync in the relaxation exit path to avoid starting to
wait a CPU that is already busy again with a lengthy RT task.

[1] https://lore.kernel.org/xenomai/770b1e4bc42cfa1ba5f4f37cc854956f3e78bb60.camel@siemens.com/T/#t

Reported-by: JerryJun <jerryjun123@163.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h |  6 ++++++
 kernel/cobalt/thread.c         | 15 +++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 7f9a37d29a..22ed61168c 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -64,6 +64,11 @@ struct lostage_signal {
 	int signo, sigval;
 };
 
+struct lostage_wakeup {
+	struct pipeline_inband_work inband_work; /* Must be first. */
+	struct task_struct *task;
+};
+
 struct xnthread_init_attr {
 	struct xnthread_personality *personality;
 	cpumask_t affinity;
@@ -214,6 +219,7 @@ struct xnthread {
 	u32 proghash;		/* Hash value for exe_path */
 #endif
 	struct lostage_signal sigarray[XNTHREAD_MAX_SIGNALS];
+	struct lostage_wakeup relax_work;
 };
 
 static inline int xnthread_get_state(const struct xnthread *thread)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 8738fadfce..7dffb081bd 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1974,11 +1974,6 @@ int xnthread_harden(void)
 }
 EXPORT_SYMBOL_GPL(xnthread_harden);
 
-struct lostage_wakeup {
-	struct pipeline_inband_work inband_work; /* Must be first. */
-	struct task_struct *task;
-};
-
 static void lostage_task_wakeup(struct pipeline_inband_work *inband_work)
 {
 	struct lostage_wakeup *rq;
@@ -2052,10 +2047,6 @@ void __xnthread_propagate_schedparam(struct xnthread *curr)
 void xnthread_relax(int notify, int reason)
 {
 	struct task_struct *p = current;
-	struct lostage_wakeup wakework = {
-		.inband_work = PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup),
-		.task = p,
-	};
 	struct xnthread *thread = xnthread_current();
 	int cpu __maybe_unused, suspension;
 	kernel_siginfo_t si;
@@ -2069,6 +2060,10 @@ void xnthread_relax(int notify, int reason)
 	 */
 	trace_cobalt_shadow_gorelax(reason);
 
+	thread->relax_work.inband_work = (struct pipeline_inband_work)
+		PIPELINE_INBAND_WORK_INITIALIZER(lostage_task_wakeup);
+	thread->relax_work.task = p;
+
 	/*
 	 * If you intend to change the following interrupt-free
 	 * sequence, /first/ make sure to check the special handling
@@ -2081,7 +2076,7 @@ void xnthread_relax(int notify, int reason)
 	 */
 	splmax();
 	trace_cobalt_lostage_request("wakeup", p);
-	pipeline_post_inband_work(&wakework);
+	pipeline_post_inband_work(&thread->relax_work);
 	/*
 	 * Grab the nklock to synchronize the Linux task state
 	 * manipulation with handle_sigwake_event. This lock will be
-- 
2.43.0

