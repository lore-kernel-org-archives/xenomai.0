Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6222C11F9
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771368879; cv=none; b=GQTd5pNU7iD999ha94hQf6cqGuyNf+OKusK9Waz7t8JRBZTh4YBBfeXUfGGG2Sdo9TgMUae94AmHYapw6Jcs9MP95BMfzfrBrOXh2fQGTaX+Eca1jkl5Q+24yYMX5TLs20t6mqDDfE4vfZ8WxMeFkuA47v9UlywzfSKHk27EIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771368879; c=relaxed/simple;
	bh=h/aUpWMdgi5u2MPhJY8CaSkY6qgaBxwKiwBPWaiymDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuqD2kJbJVap4BxHQkKTllPUZSfVTLmP8HCfonvUiPL10IfZH2hDKdsGOFWqoVOAm1fj8ZC/7IcZVLWsfGuJR3SDrngtnN15K0aprsHvmvqo2/evIxbpUORbAVEEFOyfVs3T3b89mqQtM9LUCFYPPwN35c6p+FiHI7R/zEXYQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EUlx4zTa; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EUlx4zTa"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260217225427495319759500020795
        for <xenomai@lists.linux.dev>;
        Tue, 17 Feb 2026 23:54:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5C30AkIa3EoPwQ84iqtffRjYVuYO9hchXfDEEkMOg7g=;
 b=EUlx4zTaJS6a6mhHg3/0JJPiZj00Dx3JJimOXKtfg9al/nJ964B+qtaG+B4WiMRrRZLWb0
 ck03UEop1pyay9x2xpaf15Mle7zKHDQ2iEJOTGWjwln3MWNatSfHBpU2J6vMb95U8lXHhE5S
 WshEkdjSH1W2FA75pvHrimh/e7HTdarnhoXvGPbXWpVtsm2iHEoxp0Kvh5jSboDZQASZ4LgB
 nTto1RWXnXCoOzlCzSeNgzNRe5QX3/W3gGRzVdCZ+PI8VMM1ifa6xoEhb4LlpVhypnDRQ+j/
 gFM/SZiQ7OJQbri/pVmcpKUA5KNURZmWqyQpCr0MAo1QNMJsDYShl/ig==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 17 Feb 2026 23:54:28 +0100
Subject: [PATCH Dovetail v2 2/2] arm64: irq_pipeline: Cleanup demotion
 check for el1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-wip-flo-v6-19-dovetail-rebase-v2-2-45fc326a166a@siemens.com>
References: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
In-Reply-To: <20260217-wip-flo-v6-19-dovetail-rebase-v2-0-45fc326a166a@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

While reviewing some of the low level pipeline code I realized that
the checks for task demotion are confusing on arm64.

el0: There is no demotion check as arm6_exit_to_user_mode() will
     already do the right thing. No need to update that path.

el1: The demotion check was unnecessary and "inactive" as
     user_mode(regs) is never true on el1, we are serving an IRQ over
     kernel mode. Removing the check to avoid further confusion.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm64/kernel/entry-common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 07fa70713ce04eaf3df9223354babcecde923280..2337987b7edd88d36703071ba0ac9880d043b5e5 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -90,10 +90,6 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
 		prevd = handle_irq_pipelined_prepare(regs);
 		do_interrupt_handler(regs, handler);
 		handle_irq_pipelined_finish(prevd, regs);
-		if (running_inband() && user_mode(regs)) {
-			stall_inband_nocheck();
-			irqentry_exit_to_user_mode(regs);
-		}
 		instrumentation_end();
 		mte_check_tfsr_exit();
 		return;

-- 
2.53.0

