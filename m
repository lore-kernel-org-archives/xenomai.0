Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD91CC89F
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575085; cv=none; b=YWDEFCYPhuD7ye0lmDcB0V1OfsHTjgf7Fm/cvLM0CeTxAQP0cRq9b3jt5m9zUc6ETciToIF8ueE1iK+QQhHn6dlFkmQvsrF545TLb6w4mkESAmcMFQbxo1Digy6YezeH1GohslndMI4lBx2kRbLKQEWZAibY6pwrGToLKWVuggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575085; c=relaxed/simple;
	bh=UL828gSMZ2ztEqAEckCN0IU9RhAD7Vr7GWWhYMA4KEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ED+TfzXFRmJye3T3R2ucuIe8A3/Z3DoHGKNO3RNQ6WdzBTwOLyO/s2B10ioDF1CEGvKrtGyUn1DIeeDmPqkFZBYQeBEdModMqzfmJp7udR+6UVzEJ1V3pHI5IOykt2YeSPWEQwhjXVwnTIqiW9qt9y3SyIYBOH9xL+BSDyDkGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nvkOxXAJ; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nvkOxXAJ"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241010154433a52710dfe439e2b3db
        for <xenomai@lists.linux.dev>;
        Thu, 10 Oct 2024 17:44:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CZYuLhJZvjvfj1pyCWvdry7sx3WzJ1rNiSDeaJLQn5E=;
 b=nvkOxXAJIyuG5K6TJeCkeYRuFQRogwDr0NJLlsZHCtj9Y74TkrKW0hjCog9lc8oXgbA/83
 DEZm14S5rjQEIbiM2skoQt+LB/Osl7fKf3kzsaw/L3Nr2RVF987o0rpzjKOMP8061ZBwevYn
 861ljzmLfLt3S8ps0fpsM+9d4yk04AyXm3CH/yqTTSY2c2DeXDsTuyAriGiEPxA0fET1nQhh
 RJgsw29hkM0tmC6/84l02i6Vkz8nVEBY1rimvWYFiwH2pmsWZTM6x/R3nTWs7wq7kLjcJxak
 y2MBeSv1oHq/kNfKYmxZ8bC3qkBvDif7FCIegGKda2j2PVyVoWEN4x+g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org
Cc: xenomai@lists.linux.dev,
	jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH dovetail 6.x] x86: dovetail: Fix inband IRQ state corruption on out-of-band compat syscall
Date: Thu, 10 Oct 2024 17:44:21 +0200
Message-Id: <20241010154421.23303-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following kernel splat was found when running the Xenomai 3
testsuite in compat on dovetail enabled kernels:

[  513.620975] IRQ pipeline: some code running in oob context 'Xenomai'
                             called an in-band only routine
[  513.620998] CPU: 0 PID: 510 Comm: smokey Not tainted 6.10.0+ #76
[  513.621003] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  513.621005] IRQ stage: Xenomai
[  513.621007] Call Trace:
[  513.621011]  <TASK>
[  513.621015]  dump_stack_lvl+0x6f/0xd0
[  513.621202]  __inband_irq_enable+0xb/0x60
[  513.621249]  do_int80_emulation+0x68/0x160
[  513.621265]  asm_int80_emulation+0x1a/0x20
[  513.621285] RIP: 0023:0xf7f692ba
[  513.621288] Code: Unable to access opcode bytes at 0xf7f69290.
[  513.621303] RSP: 002b:00000000ffeedf40 EFLAGS: 00000282 ORIG_RAX: 0000000000000127
[  513.621307] RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000ffeedfa0
[  513.621309] RDX: 0000000000088000 RSI: 0000000000000000 RDI: 00000000f7f7aff4
[  513.621311] RBP: 00000000ffeedf88 R08: 0000000000000000 R09: 0000000000000000
[  513.621313] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  513.621315] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  513.621319]  </TASK>

When entering the low level entry code from the out-of-band stage
the in-band IRQ state was changed. That is now avoided by calling
syscall_enter_from_user_enable_irqs() as all other entry points do.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 467e2511df2e..13589f1ca89b 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -259,7 +259,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 
 	nr = syscall_32_enter(regs);
 
-	local_irq_enable_full();
+	syscall_enter_from_user_enable_irqs();
 	nr = syscall_enter_from_user_mode_work(regs, nr);
 
 	if (dovetailing()) {
-- 
2.46.2

