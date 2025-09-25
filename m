Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53A20F09C
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805560; cv=none; b=jfNDLnaH3ZI8U9LASMYVuuap+0JKnPq1LQyqS2Ms/699IZe/qkzcOf2eMz4glsq88BE6j/g91DPHGCZcF4BYtQ7SOoTxz7ldc+8RGRK+26KEzYY8khdxdUxM/BzlHhrcaAVcqWTuuhBF+HoAozRMMojhzRGD/B1D8QtGhEQoNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805560; c=relaxed/simple;
	bh=L+yj1wc6NlYCfI7nxIvoL6pjRQL3ULceKgoccfkt/jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cL2yZQieNWVnbZFGENvZEwhsGBgdjsUtZjtxvNN9aZwYtafbHS3hQoiLRI9Z7YVWpXNv3YPXCsN7dn1auIWbMU6ax+ih9AIsLT+sbvgnHfuib/8at03i1d9crJQ748qTMFOJ9vRUqSaZhC/3042NttBoHWN+XH8fEQtT+wNikFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pYErL6BZ; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pYErL6BZ"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250925130548b4a1dbb4dc00020723
        for <xenomai@lists.linux.dev>;
        Thu, 25 Sep 2025 15:05:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AIZstEZ6Ia1UIRpsLuzcWeJgkPW2od0fhsM5FIiX7/k=;
 b=pYErL6BZpXQ1U28CGaSj5addoxlN6ULHA1El0ljkOZwHoNVeCreu+c8qjEddeGxFTUqtel
 gHzEilMoug2QHaXCDy1kG0BIopGbsC6HUlyd5WR7YpOkeUwdK/2Wp2f8AxG6LHwiZJRK0yQE
 eNNz85SS2jgD79uZh+J43/RJ0uiIyzYohJYgeZ56JtKeg1wdESH9TUBWbFZlqh/Te9FaNUUE
 I1huQEuogCdW1+e3yFuXfUKscE/VZIpOZZ9YekCqPQjJk+aHwwAvbUCSxWhK5zxvF1eeaN4M
 9hHDwFkg61W1nWsRC3/9rj0cY1Lc97aQMQmOnhA3mRuiZjrypDq89FGw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 25 Sep 2025 15:05:47 +0200
Subject: [PATCH RFC Dovetail 6.16 1/5] kernel/entry: irq_pipeline: Do not
 leave .noinstr.text section
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-wip-flo-cleanups-based-on-6-16-v1-1-8c4ac7b52cd8@siemens.com>
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
In-Reply-To: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixing the following warning by moving the call to irqentry_syncstage()
into a instrumentation_begin() section.

vmlinux.o: warning: objtool: irqentry_exit+0xab: call to synchronize_pipeline() leaves .noinstr.text section

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/entry/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 583dcef13c7c0..284d41cb1c918 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -393,6 +393,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		return;
 	}
 
+	instrumentation_begin();
 	synchronized = irqentry_syncstage(state);
 
 	if (irqexit_may_preempt_schedule(state, regs)) {
@@ -402,7 +403,6 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * and RCU as the return to user mode path.
 		 */
 		if (state.exit_rcu) {
-			instrumentation_begin();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
@@ -412,7 +412,6 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 			goto out;
 		}
 
-		instrumentation_begin();
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
 
@@ -420,6 +419,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		trace_hardirqs_on();
 		instrumentation_end();
 	} else {
+		instrumentation_end();
 		/*
 		 * IRQ flags state is correct already. Just tell RCU if it
 		 * was not watching on entry.

-- 
2.39.5

