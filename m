Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DE196DB1
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684033; cv=none; b=qHYx5PFIytRl064yePHol2+6VHH5skYuMPYTGy78M2Asp2RQjaqe3tyIMDCsijah54DGCMguqIvjOwdohzMgkpaf7q5bGiMmsQA1SpHOS+SQMj8WSRSx56Te5tKhipyQOSA93SJ8YpXJuEt3IopQapr+j5SMwE6XouuCYQueM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684033; c=relaxed/simple;
	bh=zqQlhdAVj/bYQu1dRPIaX175hKbNjIFqtJqti3PVICk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HRBZT7gKDqQVh/f6rie1E9BJJ+Fw4PdYpuPGsXC5T9VEo8imnnI60Pk9lvxMdXmGHzCjFJ/1/blBJ2mvH3oD2of0X1zNmqYEg+NdrA6xZLQ74Z2m24h3uFf/HfzjkpA0mribBp7P7xkb/GZ+Cu1DPutWNY8AbDttbS5jI7fU22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=bLHJhFzL; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="bLHJhFzL"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20241011220019813eac7727436f6e53
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 00:00:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xqKq7/daCPleTmLSEpOSEgut6oH5Uu5rLZnJHGt+sbQ=;
 b=bLHJhFzL+yWo+emkRcsugFiCYiWFx1lrKOQQrNJaXeJ5JMUQTBItPFiuJi7JVTA9N4198L
 ZvaPewlDH6ld7Fd5wV0eH4dUeUnReYk4grlH7IFrG9AG208BNY7rE+fhWTKGvUWNNGbUIj2N
 HCjw13qewQvLHKYufmCVg55newM0IUFKIwu8oXw/0LQWX6qjZKUAGyi+xyoRIG2dDN3GsRpW
 e28tsrlL0e7KvnEic60k0JEVkl9HbKiiptpbHvSy4/224U5F59zzFmrc+jncZFNTFZnkzzmj
 Tvm1PN9fCxb+6tZSY6ADqtsp1tmR+JbPN3Vk3Q5xoceQXHwXeDzwb9iQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org
Cc: xenomai@lists.linux.dev,
	jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 dovetail 6.6, 6.1] x86: dovetail: Fix inband IRQ state corruption on out-of-band compat syscall
Date: Sat, 12 Oct 2024 00:00:04 +0200
Message-Id: <20241011220004.1141774-1-florian.bezdeka@siemens.com>
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

Once again, sorry for breaking the 6.1 and 6.6 builds. I had two local
branches named v6.{1,6} which actually contained 6.10...

I decided to move syscall_enter_from_user_enable_irqs() into the same
location as it is for 6.10/6.11. This way we can keep the
__always_inline flag and avoid an additional function call in the low
level entry code.

Florian

 arch/x86/entry/common.c      |  2 +-
 include/linux/entry-common.h | 23 +++++++++++++++++++++++
 kernel/entry/common.c        | 24 ------------------------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 259aba6167e9..f32db1cc14ba 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -210,7 +210,7 @@ __visible noinstr void do_int80_emulation(struct pt_regs *regs)
 
 	nr = syscall_32_enter(regs);
 
-	local_irq_enable_full();
+	syscall_enter_from_user_enable_irqs();
 	nr = syscall_enter_from_user_mode_work(regs, nr);
 
 	if (dovetailing()) {
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index eaa309d92bfa..84e633be9bef 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -150,6 +150,29 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  */
 long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
 
+static __always_inline void syscall_enter_from_user_enable_irqs(void)
+{
+	if (running_inband()) {
+		/*
+		 * If pipelining interrupts, prepare for emulating a
+		 * stall -> unstall transition (we are currently
+		 * unstalled), fixing up the IRQ trace state in order
+		 * to keep lockdep happy (and silent).
+		 */
+		stall_inband_nocheck();
+		hard_cond_local_irq_enable();
+		local_irq_enable();
+	} else {
+		/*
+		 * We are running on the out-of-band stage, don't mess
+		 * with the in-band interrupt state. This is none of
+		 * our business. We may manipulate the hardware state
+		 * only.
+		 */
+		hard_local_irq_enable();
+	}
+}
+
 /**
  * syscall_enter_from_user_mode - Establish state and check and handle work
  *				  before invoking a syscall
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 7067dfef9fd9..b812b32a573e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -92,30 +92,6 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	return ret ? : syscall;
 }
 
-static __always_inline void
-syscall_enter_from_user_enable_irqs(void)
-{
-	if (running_inband()) {
-		/*
-		 * If pipelining interrupts, prepare for emulating a
-		 * stall -> unstall transition (we are currently
-		 * unstalled), fixing up the IRQ trace state in order
-		 * to keep lockdep happy (and silent).
-		 */
-		stall_inband_nocheck();
-		hard_cond_local_irq_enable();
-		local_irq_enable();
-	} else {
-		/*
-		 * We are running on the out-of-band stage, don't mess
-		 * with the in-band interrupt state. This is none of
-		 * our business. We may manipulate the hardware state
-		 * only.
-		 */
-		hard_local_irq_enable();
-	}
-}
-
 static __always_inline long
 __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
-- 
2.39.5

