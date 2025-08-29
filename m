Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59026981E
	for <xenomai@lists.linux.dev>; Fri, 29 Aug 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483184; cv=none; b=rAa21G+S7axMWVrBri+yjcAY8KfpITXCf4lIMhUowwcYdWypMHXqLW597j5rnNRkbcsrh01uPcCbHnCHTswpgABdBpxNiJcY2DNvA2/zJVoKy30QWUhE4/k8GlLUOWVmD4swFqesZOQbjslFXt2cnM9+sCafFToe8Ity6hlROcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483184; c=relaxed/simple;
	bh=IzZ2ifUVGlOw+Fcm6m0nCGn0IrjNgVOgXOggq2uHBC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z3O6B+FuhfO5E5/pCDbFTmNhjo6/uGLKOk651LP20hI/BkhrNP5+Q7GiF+ZQfRj7tq/C/JlxVBQzB1/kIkNhRfj40hnBBGgZczvaUdfZfRqqZwldU1aLwOZoHnJq0usTLxbB2FXL57kl/k56iBEnK2yZBdHcHw6uWxd6T8eCSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UuaMwkym; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UuaMwkym"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250829155930995c91eb8b00020768
        for <xenomai@lists.linux.dev>;
        Fri, 29 Aug 2025 17:59:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=u0RVDQbsWgVH639hB0MXF7/kOc5SiAVnpIlzytpnqXE=;
 b=UuaMwkymCmp5sOpYDMMFrF88AiV1IHhNRr71cX/N6zkw8Pb7OVRn+upVaV9snyQaIoWObM
 9CzfGWVnMn5LyL7yRkrw2Sk9IogR6/0kt7ewUfykNF5/bEJyeIx+iApJ4xTXsl2LYIIjhOSa
 cx4SWYTNe8wj1k0jQQY4EUjTVSJq09Ed0vTRGK3HWRuFNfLThNdyh3o90qcyqhUkDsgfl35H
 32VPdbGGjO889RZJZ7uQzJjfP7XZ4WOT6z2VEX9N5yrXs4Gtx0JNywC7iMYM0hY7LdyofCw6
 bedaRYgSITfrIljaOI56+Yxv1JLnStHrh3F4sU0n9Lj70Tn6aF7P5mrQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 29 Aug 2025 17:59:29 +0200
Subject: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
X-B4-Tracking: v=1; b=H4sIAGDOsWgC/x2NQQrDIBAAvxL23AVjCST9SulBzZostWpX0xRC/
 l7pceYwc0AhYSpw6w4Q+nDhFBv0lw7cauJCyHNj0EoPatQT7pzRh4QvXsRUQpesCRUzZ8KakOW
 Ne5InXofJut4rM84ErWZNIbRioltbL24hNJmFPH//+/vjPH/lWJY2jgAAAA==
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Recent Dovetail versions complained about an invalid wait context in
xnpipe_wakeup_proc(). It turned out that this warning is correct as this
function is called from the inband IRQ context (while syncing the IRQ
log) with hard IRQs enabled and inband stage stalled.

The call graph looks like that:
xnpipe_wakeup_proc()
    wake_up_interruptible()
        __wake_up_common_lock()
	    spin_lock_irqsave() <-- might sleep on PREEMPT_RT

As confirmed by Philippe in the discussion linked below, we have to
migrate the wakeup code from using a synthetic IRQ to irq_work to address
that issue.

The log splat report:
[  151.574032]
[  151.574039] =============================
[  151.574043] [ BUG: Invalid wait context ]
[  151.574046] 6.15.0 #1 Not tainted
[  151.574048] -----------------------------
[  151.574048] swapper/0/0 is trying to lock:
[  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
[  151.574063] other info that might help us debug this:
[  151.574064] context-{2:2}
[  151.574065] no locks held by swapper/0/0.
[  151.574066] stack backtrace:
[  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full)
[  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[  151.574079] IRQ stage: Linux
[  151.574083] Call Trace:
[  151.574086]  <IRQ>
[  151.574088]  dump_stack_lvl+0x79/0xe0
[  151.574095]  __lock_acquire+0x942/0xbf0
[  151.574104]  lock_acquire+0xe2/0x2f0
[  151.574107]  ? __wake_up+0x21/0x60
[  151.574111]  ? find_held_lock+0x2b/0x80
[  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
[  151.574120]  ? __wake_up+0x21/0x60
[  151.574122]  __wake_up+0x21/0x60
[  151.574125]  xnpipe_wakeup_proc+0x152/0x590
[  151.574132]  handle_synthetic_irq+0xc2/0x250
[  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
[  151.574141]  </IRQ>
[  151.574142]  <TASK>
[  151.574144]  sync_current_irq_stage+0xaa/0x110
[  151.574147]  inband_irq_enable+0x42/0x60
[  151.574151]  cpuidle_idle_call+0x17d/0x200
[  151.574155]  do_idle+0x89/0xd0
[  151.574158]  cpu_startup_entry+0x29/0x30
[  151.574160]  rest_init+0xf0/0x190
[  151.574164]  start_kernel+0x632/0x700
[  151.574179]  x86_64_start_reservations+0x18/0x30
[  151.574185]  x86_64_start_kernel+0x78/0x80
[  151.574188]  common_startup_64+0x13e/0x148
[  151.574198]  </TASK>

Link: https://lore.kernel.org/xenomai/87349may4v.fsf@xenomai.org/T/#t
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/pipe.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 7519f3165..5ab561384 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -48,7 +48,7 @@ static LIST_HEAD(xnpipe_sleepq);
 
 static LIST_HEAD(xnpipe_asyncq);
 
-static int xnpipe_wakeup_virq;
+static struct irq_work xnpipe_wakeup_work;
 
 static struct class *xnpipe_class;
 
@@ -147,7 +147,7 @@ static inline void xnpipe_dequeue_all(struct xnpipe_state *state, int mask)
 	__sigpending;							\
 })
 
-static irqreturn_t xnpipe_wakeup_proc(int sirq, void *dev_id)
+static void xnpipe_wakeup_proc(struct irq_work *work)
 {
 	struct xnpipe_state *state;
 	unsigned long rbits;
@@ -221,13 +221,11 @@ check_async:
 	}
 out:
 	xnlock_put_irqrestore(&nklock, s);
-
-	return IRQ_HANDLED;
 }
 
 static inline void xnpipe_schedule_request(void) /* hw IRQs off */
 {
-	pipeline_post_sirq(xnpipe_wakeup_virq);
+	irq_work_queue(&xnpipe_wakeup_work);
 }
 
 static inline ssize_t xnpipe_flush_bufq(void (*fn)(void *buf, void *xstate),
@@ -1149,6 +1147,8 @@ int xnpipe_mount(void)
 		state->nroutq = 0;
 	}
 
+	init_irq_work(&xnpipe_wakeup_work, xnpipe_wakeup_proc);
+
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
 	xnpipe_class = class_create("rtpipe");
 #else
@@ -1180,13 +1180,6 @@ int xnpipe_mount(void)
 		return -EBUSY;
 	}
 
-	xnpipe_wakeup_virq = pipeline_create_inband_sirq(xnpipe_wakeup_proc);
-	if (xnpipe_wakeup_virq < 0) {
-		printk(XENO_ERR
-		       "unable to reserve synthetic IRQ for message pipes\n");
-		return xnpipe_wakeup_virq;
-	}
-
 	return 0;
 }
 
@@ -1194,8 +1187,6 @@ void xnpipe_umount(void)
 {
 	int i;
 
-	pipeline_delete_inband_sirq(xnpipe_wakeup_virq);
-
 	unregister_chrdev(XNPIPE_DEV_MAJOR, "rtpipe");
 
 	for (i = 0; i < XNPIPE_NDEVS; i++)

---
base-commit: ccdceccd2508596ebd114981890b5b47b650058a
change-id: 20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-359bc1f0a8de

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

