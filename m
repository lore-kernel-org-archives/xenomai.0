Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC5199FB9
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 06:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628706; cv=none; b=Yr/cTnoZ5Cr37gC1JT3wc20jnH0uMAJzWQDd3y0UyTAraLbvNFLDvYQRhzvX/Ln5TTBtRqAm8JRrlpaVLAnNdCHEd9R/0KgSY21m6VpWNypdpWOwNPIrRLMwFgAIZ6WgyknIq84D+fg7wffEQM72sL8I1gOX1Lms3wFhJ5ZDNDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628706; c=relaxed/simple;
	bh=xZGbaO+oeFbSn64AwwjrcEAtyi41sNP3rgO9Ed1lC9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KETNUtW1OGLhbEzYOHLvYmSJW9TJJMdb7ujJ9OQnCJawGHxV4v/rr9n3M32BvvKLeGbb4NLBO3ltmba4G9BFyunCBvZPDvsIDpPw/7g1rqOffxDBnwHZkAJnq4xk8y/29D3ljub2QUyZAxqG5d/qsXpdnNlBqmzdjbdhIejVlNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxoaxVQc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxoaxVQc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c71603217so15641195ad.3
        for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 23:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628703; x=1729233503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al3QxsYpIZmYAvYYeFR/WYflIJdYWV8P+f2boBUiTJc=;
        b=IxoaxVQcQN1QYI45WyitcJSCnCZwTsz/G5cseL/2tzyCSgyKZ9yC/tX+bbK938qcYQ
         jAqd86F1/1K4ft1N1dDGAkwvKZZXAeEuLBzLr4qx7dJrxp4thUVzjIcpKOa86LG9IJ30
         +VaAA9LF/xl1Yp1ChXLfrZjZWa9sNl5kQRA6BGroGhJDTHdDbWTwZaVxy61Xk7cP8Rlc
         UunnNmNyVwib/YYIeTshjd825qqdLNg1R94/2VN8m52Egytez5h9bdrjUkq3avScGIzh
         xt7PsI3ATAuQmwGLvNXs58jiaXDHaDtAmfdeWSmB3R/xNHgkZNJXRISXImEZKUgsgJdf
         gYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628703; x=1729233503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=al3QxsYpIZmYAvYYeFR/WYflIJdYWV8P+f2boBUiTJc=;
        b=IcsSdL9djQ2B/WEGNQ9sWOy1EERdwN/WVx7mKJnk7eNidNUCa6vphKt4eya7xTwuPA
         WxK5+vOw8YUVpEnnLZUTinusPc/5IGFfLnrZ9IA0WGPJwvoEdFeq0rdxaTHf2kW33cpk
         bNXUEUzBczpeP95B117X8K9ATTG+pX6T8+PkDzVGObT4I307yW1BqN62xLmohIH1e7qy
         dFXeDslj4vWmHq32vD8MoObALyEL/IYdT0Fs1IElT2jKozTgzIT5JisZs6KR64meQAqE
         GxFMC/DrcCHGHShEqPlTOZY41lZfNZ8dsF4DOUQlH8EPIuc+KgpzqZ7TkGN7DmVAhqZ9
         xw+w==
X-Gm-Message-State: AOJu0YyF7pZTmYeVmnvyQ08hIyhtoCj5P9fN7oD9RL9gWe4uDLC2AY0E
	lnMhnROmCXGbUjuFacLT4lBlqX11z20r+Nea3R0ewV3hswqlkrkiLOOa7xnqnQI=
X-Google-Smtp-Source: AGHT+IGZqQumiWGQQkXJf24YOrQRQNu2yF/TKz8FBO/oIKSCWn4WxKv4FhHLixEGzGbALCOKqn6siw==
X-Received: by 2002:a17:902:ec8f:b0:20b:5645:d860 with SMTP id d9443c01a7336-20ca1677f4amr20366135ad.36.1728628703029;
        Thu, 10 Oct 2024 23:38:23 -0700 (PDT)
Received: from 43c7c7756ed8.. ([117.129.58.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1b9f3sm18241865ad.76.2024.10.10.23.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:38:22 -0700 (PDT)
From: shannmu <shanmu1901@gmail.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH 3/3] riscv/evl: Port evl patch to riscv (just compile pass)
Date: Fri, 11 Oct 2024 06:37:30 +0000
Message-Id: <20241011063730.310568-4-shanmu1901@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011063730.310568-1-shanmu1901@gmail.com>
References: <20241011063730.310568-1-shanmu1901@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds some functions and structures after apply evl-6.6.y-rebase
patch to pass the compile.

Signed-off-by: shannmu <shanmu1901@gmail.com>
---
 arch/riscv/include/asm/evl/calibration.h  | 12 +++++++++
 arch/riscv/include/asm/evl/fptest.h       | 26 +++++++++++++++++++
 arch/riscv/include/asm/evl/syscall.h      | 31 +++++++++++++++++++++++
 arch/riscv/include/asm/evl/thread.h       | 11 ++++++++
 arch/riscv/include/asm/thread_info.h      | 22 +++++++++++++---
 arch/riscv/include/dovetail/irq.h         | 11 ++++++++
 arch/riscv/include/dovetail/mm_info.h     |  7 +++++
 arch/riscv/include/dovetail/netdevice.h   |  7 +++++
 arch/riscv/include/dovetail/poll.h        |  7 +++++
 arch/riscv/include/dovetail/thread_info.h |  7 +++++
 arch/riscv/include/uapi/asm/evl/fptest.h  | 29 +++++++++++++++++++++
 11 files changed, 167 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/include/asm/evl/calibration.h
 create mode 100644 arch/riscv/include/asm/evl/fptest.h
 create mode 100644 arch/riscv/include/asm/evl/syscall.h
 create mode 100644 arch/riscv/include/asm/evl/thread.h
 create mode 100644 arch/riscv/include/dovetail/irq.h
 create mode 100644 arch/riscv/include/dovetail/mm_info.h
 create mode 100644 arch/riscv/include/dovetail/netdevice.h
 create mode 100644 arch/riscv/include/dovetail/poll.h
 create mode 100644 arch/riscv/include/dovetail/thread_info.h
 create mode 100644 arch/riscv/include/uapi/asm/evl/fptest.h

diff --git a/arch/riscv/include/asm/evl/calibration.h b/arch/riscv/include/asm/evl/calibration.h
new file mode 100644
index 000000000000..572882e8bd68
--- /dev/null
+++ b/arch/riscv/include/asm/evl/calibration.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_RISCV_ASM_CALIBRATION_H
+#define _EVL_RISCV_ASM_CALIBRATION_H
+
+#include <linux/kconfig.h>
+
+static inline unsigned int evl_get_default_clock_gravity(void)
+{
+	return 3000;
+}
+
+#endif /* !_EVL_RISCV_ASM_CALIBRATION_H */
diff --git a/arch/riscv/include/asm/evl/fptest.h b/arch/riscv/include/asm/evl/fptest.h
new file mode 100644
index 000000000000..0467b1548289
--- /dev/null
+++ b/arch/riscv/include/asm/evl/fptest.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_RISCV_ASM_FPTEST_H
+#define _EVL_RISCV_ASM_FPTEST_H
+
+#include <linux/cpufeature.h>
+#include <uapi/asm/evl/fptest.h>
+
+static inline bool evl_begin_fpu(void)
+{
+	return false;
+}
+
+static inline void evl_end_fpu(void)
+{
+}
+
+static inline u32 evl_detect_fpu(void)
+{
+	u32 features = 0;
+
+	// TODO:
+
+	return features;
+}
+
+#endif /* _EVL_RISCV_ASM_FPTEST_H */
diff --git a/arch/riscv/include/asm/evl/syscall.h b/arch/riscv/include/asm/evl/syscall.h
new file mode 100644
index 000000000000..18962fd004ff
--- /dev/null
+++ b/arch/riscv/include/asm/evl/syscall.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_RISCV_ASM_SYSCALL_H
+#define _EVL_RISCV_ASM_SYSCALL_H
+
+#include <linux/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ptrace.h>
+#include <uapi/asm-generic/dovetail.h>
+
+#define raw_put_user(src, dst)  __put_user(src, dst)
+#define raw_get_user(dst, src)  __get_user(dst, src)
+
+static inline bool
+is_valid_inband_syscall(unsigned int nr)
+{
+	return nr < NR_syscalls;
+}
+
+#ifdef CONFIG_COMPAT
+static inline bool is_compat_oob_call(void)
+{
+	return is_compat_task();
+}
+#else
+static inline bool is_compat_oob_call(void)
+{
+	return false;
+}
+#endif
+
+#endif /* !_EVL_RISCV_ASM_SYSCALL_H */
diff --git a/arch/riscv/include/asm/evl/thread.h b/arch/riscv/include/asm/evl/thread.h
new file mode 100644
index 000000000000..631ea3177fa5
--- /dev/null
+++ b/arch/riscv/include/asm/evl/thread.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_RISCV_ASM_THREAD_H
+#define _EVL_RISCV_ASM_THREAD_H
+
+static inline bool evl_is_breakpoint(int trapnr)
+{
+	// TODO: Check if the trap number is a breakpoint trap
+	return trapnr == 0 || trapnr == 1;
+}
+
+#endif /* !_EVL_RISCV_ASM_THREAD_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index d18ce0113ca1..60d02bdbe073 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -36,6 +36,7 @@
 
 #include <asm/processor.h>
 #include <asm/csr.h>
+#include <dovetail/thread_info.h>
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -47,6 +48,7 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	unsigned long		local_flags;	/* local (synchronous) flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
 	/*
 	 * These stack pointers are overwritten on every system call or
@@ -57,6 +59,7 @@ struct thread_info {
 	long			user_sp;	/* User stack pointer */
 	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
+	struct oob_thread_state	oob_state;
 };
 
 /*
@@ -73,6 +76,8 @@ struct thread_info {
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
+#define ti_local_flags(__ti)	((__ti)->local_flags)
+
 #endif /* !__ASSEMBLY__ */
 
 /*
@@ -90,15 +95,26 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 #define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
 #define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
 #define TIF_32BIT		11	/* compat-mode 32bit process */
-
+#define TIF_RETUSER		7	/* INBAND_TASK_RETUSER is pending */
+#define TIF_MAYDAY		29	/* Emergency trap pending */
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
-
+#define _TIF_RETUSER		(1 << TIF_RETUSER)
+#define _TIF_MAYDAY		(1 << TIF_MAYDAY)
 #define _TIF_WORK_MASK \
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
+	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE | _TIF_RETUSER)
+
+
+/*
+ * Local (synchronous) thread flags.
+ */
+#define _TLF_OOB		0x0001
+#define _TLF_DOVETAIL		0x0002
+#define _TLF_OFFSTAGE		0x0004
+#define _TLF_OOBTRAP		0x0008
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/include/dovetail/irq.h b/arch/riscv/include/dovetail/irq.h
new file mode 100644
index 000000000000..f214e2f6ee2b
--- /dev/null
+++ b/arch/riscv/include/dovetail/irq.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_IRQ_H
+#define _EVL_DOVETAIL_IRQ_H
+
+#ifdef CONFIG_EVL
+#include <asm-generic/evl/irq.h>
+#else
+#include_next <dovetail/irq.h>
+#endif
+
+#endif /* !_EVL_DOVETAIL_IRQ_H */
diff --git a/arch/riscv/include/dovetail/mm_info.h b/arch/riscv/include/dovetail/mm_info.h
new file mode 100644
index 000000000000..13087687d61a
--- /dev/null
+++ b/arch/riscv/include/dovetail/mm_info.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_MM_INFO_H
+#define _EVL_DOVETAIL_MM_INFO_H
+
+#include <asm-generic/evl/mm_info.h>
+
+#endif /* !_EVL_DOVETAIL_MM_INFO_H */
diff --git a/arch/riscv/include/dovetail/netdevice.h b/arch/riscv/include/dovetail/netdevice.h
new file mode 100644
index 000000000000..bc7ac6769530
--- /dev/null
+++ b/arch/riscv/include/dovetail/netdevice.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_NETDEVICE_H
+#define _EVL_DOVETAIL_NETDEVICE_H
+
+#include <asm-generic/evl/netdevice.h>
+
+#endif /* !_EVL_DOVETAIL_NETDEVICE_H */
diff --git a/arch/riscv/include/dovetail/poll.h b/arch/riscv/include/dovetail/poll.h
new file mode 100644
index 000000000000..76e51be38a40
--- /dev/null
+++ b/arch/riscv/include/dovetail/poll.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_POLL_H
+#define _EVL_DOVETAIL_POLL_H
+
+#include <asm-generic/evl/poll.h>
+
+#endif /* !_EVL_DOVETAIL_POLL_H */
diff --git a/arch/riscv/include/dovetail/thread_info.h b/arch/riscv/include/dovetail/thread_info.h
new file mode 100644
index 000000000000..4253b13fe47f
--- /dev/null
+++ b/arch/riscv/include/dovetail/thread_info.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EVL_DOVETAIL_THREAD_INFO_H
+#define _EVL_DOVETAIL_THREAD_INFO_H
+
+#include <asm-generic/evl/thread_info.h>
+
+#endif /* !_EVL_DOVETAIL_THREAD_INFO_H */
diff --git a/arch/riscv/include/uapi/asm/evl/fptest.h b/arch/riscv/include/uapi/asm/evl/fptest.h
new file mode 100644
index 000000000000..f1f069cf384d
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/evl/fptest.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _EVL_RISCV_ASM_UAPI_FPTEST_H
+#define _EVL_RISCV_ASM_UAPI_FPTEST_H
+
+#include <linux/types.h>
+
+#define evl_riscv_fpsimd 0x1
+#define evl_ricsv_sve 0x2
+
+// TODO: Check and set FP registers
+/*
+ * CAUTION: keep this code strictly inlined in macros: we don't want
+ * GCC to apply any callee-saved logic to fpsimd registers in
+ * evl_set_fpregs() before evl_check_fpregs() can verify their
+ * contents, but we still want GCC to know about the registers we have
+ * clobbered.
+ */
+
+#define evl_set_fpregs(__features, __val) \
+	do {                              \
+	} while (0)
+
+#define evl_check_fpregs(__features, __val, __bad) \
+	({                                         \
+		unsigned int __result = (__val);   \
+		__result;                          \
+	})
+
+#endif /* !_EVL_ARM64_ASM_UAPI_FPTEST_H */
-- 
2.34.1

