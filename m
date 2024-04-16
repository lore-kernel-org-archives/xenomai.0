Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B2127B73
	for <xenomai@lists.linux.dev>; Tue, 16 Apr 2024 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263096; cv=none; b=Q1dqiS2twXBUjiOb4T/2LC+jMPh+FlEupfKrxvLz3gt202cFE29xt1QssiA/RuTXIbqgO+oUZ4k2/sv+suxBZITwhCoXtp/6m7/f0y8QmA47DNOvsqJHvhulnAkL92OWAL1dYM9kxEiDRIgFP4FeOJ+fMgWiVsNWGzrdJJeva5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263096; c=relaxed/simple;
	bh=+FPjnx+TvI0tJf22SmMXVVu294tDL4nG5f/0sTxeOsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4GtcCMciAblwoMIyEuSMz0642jjWnKe7AxswUMah/nEuHr8V063acKTNd5yYZKjV/otWnNq8yQvtEi4ug2ak4p6kR+HhkWEhAYRn3oTTBHIFKglvn1FmsA7daWmrkd/q890sdSTmShoUQbT1+QoKuYfPqy8uLKE5DFUElLhuW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=dnXM1NL5; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="dnXM1NL5"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240416102444096c482a778f736374
        for <xenomai@lists.linux.dev>;
        Tue, 16 Apr 2024 12:24:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+pC4JsGjZQZ2R691k1DZ46AOA74rknkL2W6t4gCndOY=;
 b=dnXM1NL5BDA2PLOAIqI0HY+96jB7OqTl7KyiRWUQLn8OKsT8uTtXfwrBrLgIDlH4ux5Y8B
 Nvk0I2FGGrIDAKmakFEuW5e2u+PFiRDcwcJIPJeEWiFBQ8j0nI8NhxHCVCZZhZzuRBxmkwqj
 78gVhXIy0z5x0mifbnvqCIV2eXlsQ=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org
Cc: xenomai@lists.linux.dev,
	jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 6.8, 6.6, 6.1] x86: dovetail: Fix compat syscall handling, account for new IDT entry
Date: Tue, 16 Apr 2024 12:24:36 +0200
Message-Id: <20240416102436.550147-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following upstream commit introduces a new IDTENTRY for handling
compat syscall. As that commit is now backported into stable trees it
broke compat syscall handling for dovetail.

be5341eb0d43 ("x86/entry: Convert INT 0x80 emulation to IDTENTRY")

We no longer end up in do_int80_syscall_32() which has the dovetail
specific bits. We need the same handling in asm_int80_emulation().

The problematic part in asm_int80_emulation() is the call to
do_syscall_32_irqs_on() which basically overwrites regs->ax
unconditionally. Linux does not know about the co-kernel syscalls, so
we get -ENOSYS for each syscall result.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/entry/common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 0220ca163a32..42e8cb036fff 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -212,9 +212,21 @@ DEFINE_IDTENTRY_RAW(int80_emulation)
 
 	local_irq_enable();
 	nr = syscall_enter_from_user_mode_work(regs, nr);
+
+	if (dovetailing()) {
+		if (nr == EXIT_SYSCALL_OOB) {
+			hard_local_irq_disable();
+			return;
+		}
+		if (nr == EXIT_SYSCALL_TAIL)
+			goto done;
+	}
+
 	do_syscall_32_irqs_on(regs, nr);
 
 	instrumentation_end();
+
+done:
 	syscall_exit_to_user_mode(regs);
 }
 #else /* CONFIG_IA32_EMULATION */
-- 
2.39.2

