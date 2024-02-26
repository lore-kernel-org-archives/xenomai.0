Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78512F39C
	for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964965; cv=none; b=pOBwAmWPSJYswTCiGItNfO+ElXsPzEBMtDNFeg/0svDUGNGNTxvgI3zoEMU5mO6y5YHavK461JN5a3BABydpNuH1w73elo1sKEjMlEfuaKGBinNWfCqrkbM6xKPDQSMOEGlcGxl/3ciDRLtzfPieNpTdN3x8g6VTut7D/5tDo/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964965; c=relaxed/simple;
	bh=GzLmEvPdUIO6iMSYw3X9hBYUrDlMd1GnCww7DUVo5i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3oz2JLwUBkSK/zQj021LQ26U0H0KEs+EBBY0U5sCaMaZotZNPl0TeiOdQMDl9N1gPMBnylETgBCTrbvMqLgU5vU11NgGzwQDDMWtIzZE9npSizWDS2yKiuacrKSvztFRAjBbWH2+sZ/oqFHTqVIL3rUfzQlJfGJICMkQv0aKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KAwKqwrq; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KAwKqwrq"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024022616291558b42c6080bdd5f713
        for <xenomai@lists.linux.dev>;
        Mon, 26 Feb 2024 17:29:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=e+ipakxS97nfi7sNL3sQjlYng8qlIOo9TXC7ktr51mM=;
 b=KAwKqwrq+CsaxCduxvw9P9Qp3sIptDjNX93jKi0Af404sNpP4V5vqT8LYPWZEB9TGKJZGh
 8G5c37CA+XHhmRI8Y+8vSUFWDSF32sUdWbM61f2vqZH/wm1I+iZrl3Y2UjFlPEE488sjD9l7
 C12H7ELL0qbCcMCgMLWGYNmkoseac=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 26 Feb 2024 17:29:14 +0100
Subject: [PATCH dovetail 6.7-6.1 2/2] dovetail: x86: Fix fetching of the
 first syscall argument from compat tasks
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-v6-7-dovetail-rebase-v1-2-2962213b5e9c@siemens.com>
References: <20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com>
In-Reply-To: <20240226-v6-7-dovetail-rebase-v1-0-2962213b5e9c@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On x86 there is a small difference in the ABI (= register) where the
first syscall argument is supplied between the x86_64 (native) and
compat (i386) case.

On x86_64 the DI register is being used, while i386 used the BX
register.

The same problem exists for further arguments - handled by
syscall_get_arguments() - as well. syscall_get_arg0() is dovetail
specific and is now in sync with syscall_get_arguments().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 arch/arm/include/asm/syscall.h   |  3 ++-
 arch/arm64/include/asm/syscall.h |  3 ++-
 arch/x86/include/asm/syscall.h   | 10 ++++++++--
 kernel/dovetail.c                |  5 ++++-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 0cc501cf999b..5407d2de9e73 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -80,7 +80,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->ARM_r0 + 1, 5 * sizeof(args[0]));
 }
 
-static inline unsigned long syscall_get_arg0(struct pt_regs *regs)
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
 {
 	return regs->ARM_ORIG_r0;
 }
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index d130f413e236..3cf5646340c3 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -73,7 +73,8 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	memcpy(args, &regs->regs[1], 5 * sizeof(args[0]));
 }
 
-static inline unsigned long syscall_get_arg0(struct pt_regs *regs)
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
 {
 	return regs->orig_x0;
 }
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2ce747bf1c42..6c0ad921abcd 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -118,9 +118,15 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	}
 }
 
-static inline unsigned long syscall_get_arg0(struct pt_regs *regs)
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
 {
-	return regs->di;
+#ifdef CONFIG_IA32_EMULATION
+	if (task->thread_info.status & TS_COMPAT)
+		return regs->bx;
+	else
+#endif
+		return regs->di;
 }
 
 static inline int syscall_get_arch(struct task_struct *task)
diff --git a/kernel/dovetail.c b/kernel/dovetail.c
index 79fd75918b37..2e92d0b0c0ef 100644
--- a/kernel/dovetail.c
+++ b/kernel/dovetail.c
@@ -170,6 +170,8 @@ int __pipeline_syscall(struct pt_regs *regs)
 
 static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
 {
+	struct task_struct *tsk = current;
+
 	/*
 	 * Check whether the companion core might be interested in the
 	 * syscall call. If the old syscall form is handled, pass the
@@ -182,7 +184,8 @@ static inline bool maybe_oob_syscall(unsigned int nr, struct pt_regs *regs)
 			return true;
 	}
 
-	return arch_dovetail_is_syscall(nr) && syscall_get_arg0(regs) & __OOB_SYSCALL_BIT;
+	return arch_dovetail_is_syscall(nr) &&
+	       syscall_get_arg0(tsk, regs) & __OOB_SYSCALL_BIT;
 }
 
 int pipeline_syscall(unsigned int nr, struct pt_regs *regs)

-- 
2.39.2

