Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B31350EC
	for <xenomai@lists.linux.dev>; Mon, 26 Feb 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988029; cv=none; b=kO5L5r5mISNMQpVREv4ktaDzzyyjoPW5Zk0TgE/osaZRhpzkt5xnuSs84CsMFO0oqrtfGS4SmSNd0jIV7BF0oTQR4/0/INGTJNBw3z0uqTQ4yTMkPAC2oo17evfqrxNwmisMIvFwB79H057vxfbHvxrMw4wDHIPHxplGupgsAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988029; c=relaxed/simple;
	bh=OYBdni4Enl+50rGkh2/A3LkqFZ/fnZXS6cUliQytQA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAi0+9V2+Imc2q38G7Wu9/jl7Ot56SRH+uRBKEOpd7kB52JnAlf+uVnFRjZ7rvQNftEvUVqhbJSVjPajSTp7StShU52o6z5ku79IDyA035IPtPXm0slEGoYCYuf+2V7XjeDwoa3EBRBBk+fmD7GBbjsXHE+genESO2cUQ0NOpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KcXML8jc; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KcXML8jc"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024022622534276ff6d4e757c0b6c0c
        for <xenomai@lists.linux.dev>;
        Mon, 26 Feb 2024 23:53:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qS25mJxVJjZX2448yuWE45oP30qaz4/yBwfhUJ4zq0w=;
 b=KcXML8jcWIdLPMvYc1uvuAcftoMENNPjRApiQOzIBGQ1bqZVM1+VZy4PA28plGFtdllYwm
 zLLjhS0HBjqOpRF2m5Bm7PpTYySrM7wT3ZXTZA5p8gSFecFDtttdVEJTnoYbTMksNqTDUwLz
 gid52XxQERp/xPdMeteK+jT/gOua0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 26 Feb 2024 23:53:42 +0100
Subject: [PATCH dovetail 6.7-6.1 v2 2/2] dovetail: x86: Fix fetching of the
 first syscall argument from compat tasks
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-v6-7-dovetail-rebase-v2-2-7d457d60d376@siemens.com>
References: <20240226-v6-7-dovetail-rebase-v2-0-7d457d60d376@siemens.com>
In-Reply-To: <20240226-v6-7-dovetail-rebase-v2-0-7d457d60d376@siemens.com>
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
 arch/arm/include/asm/syscall.h   | 3 ++-
 arch/arm64/include/asm/syscall.h | 3 ++-
 arch/x86/include/asm/syscall.h   | 7 ++++++-
 kernel/dovetail.c                | 5 ++++-
 4 files changed, 14 insertions(+), 4 deletions(-)

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
index 2ce747bf1c42..e7c558f2ad70 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -118,8 +118,13 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	}
 }
 
-static inline unsigned long syscall_get_arg0(struct pt_regs *regs)
+static inline unsigned long syscall_get_arg0(struct task_struct *task,
+					     struct pt_regs *regs)
 {
+	if (IS_ENABLED(CONFIG_IA32_EMULATION) &&
+	    task->thread_info.status & TS_COMPAT)
+		return regs->bx;
+
 	return regs->di;
 }
 
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

