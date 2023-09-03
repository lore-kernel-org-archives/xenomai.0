Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD13FE3
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:09 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202309031505009f2751c79985941743
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xKmKbcstD8UjdwFseX4wsddQV5vilRVX5W7SH1GWOz4=;
 b=AIZJlmUa+Snf3JVY4CNSpnpfk5dhRzfdCdlFk4D/G38fTSXMhzqSrwS64vLvGBWODyEYki
 QabtGRHbtmHIQG2/XDxh162YXNzofx9Ps/LsrmgnzHB9fKFnfWwXcDYAfLa+Sxjfov3O3evi
 8+A167qpYMsx69fHahAL5Z64TVeeE=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 11/20] kernel/cobalt: Remove archcall syscall stub
Date: Sun,  3 Sep 2023 17:04:48 +0200
Message-Id: <a1535357f8511f25962c4217ac7e2849b093417e.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
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

This was returning ENOSYS only anyway.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/uapi/syscall.h                          | 2 +-
 kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h   | 9 ---------
 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h | 9 ---------
 kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h   | 8 --------
 kernel/cobalt/posix/syscall.c                          | 8 --------
 kernel/cobalt/trace/cobalt-posix.h                     | 1 -
 6 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
index 3e65efaabe..f27988f552 100644
--- a/include/cobalt/uapi/syscall.h
+++ b/include/cobalt/uapi/syscall.h
@@ -109,7 +109,7 @@
 #define sc_cobalt_select			86
 #define sc_cobalt_fcntl				87
 #define sc_cobalt_migrate			88
-#define sc_cobalt_archcall			89
+/* 89: formerly archcall */
 #define sc_cobalt_trace				90
 #define sc_cobalt_corectl			91
 #define sc_cobalt_get_current			92
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 2490e7fe81..1721977251 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -77,15 +77,6 @@ static inline int __xn_interrupted_p(struct pt_regs *regs)
 	return __xn_reg_rval(regs) == -EINTR;
 }
 
-static inline
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			unsigned long a3, unsigned long a4,
-			unsigned long a5)
-{
-	/* We need none of these with Dovetail. */
-	return -ENOSYS;
-}
-
 #define pipeline_get_syscall_args pipeline_get_syscall_args
 static inline void pipeline_get_syscall_args(struct task_struct *task,
 					     struct pt_regs *regs,
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index 0f1d1eaf8d..26e4ed8c32 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -51,13 +51,4 @@ static inline int __xn_interrupted_p(struct pt_regs *regs)
 	return __xn_reg_rval(regs) == -EINTR;
 }
 
-static inline
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			unsigned long a3, unsigned long a4,
-			unsigned long a5)
-{
-	/* We need none of these with Dovetail. */
-	return -ENOSYS;
-}
-
 #endif /* !_COBALT_ARM64_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
index b2e158247f..f60aed0132 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -74,12 +74,4 @@ static inline int __xn_interrupted_p(struct pt_regs *regs)
 	return __xn_reg_rval(regs) == -EINTR;
 }
 
-static inline
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			 unsigned long a3, unsigned long a4,
-			 unsigned long a5)
-{
-	return -ENOSYS;
-}
-
 #endif /* !_COBALT_X86_ASM_SYSCALL_H */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 46c4998e4c..6193098bab 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -205,14 +205,6 @@ static COBALT_SYSCALL(ftrace_puts, current,
 	return 0;
 }
 
-static COBALT_SYSCALL(archcall, current,
-		      (unsigned long a1, unsigned long a2,
-		       unsigned long a3, unsigned long a4,
-		       unsigned long a5))
-{
-	return xnarch_local_syscall(a1, a2, a3, a4, a5);
-}
-
 static COBALT_SYSCALL(get_current, current,
 		      (xnhandle_t __user *u_handle))
 {
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 47dc77e1cd..1c93023240 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -144,7 +144,6 @@
 		__cobalt_symbolic_syscall(select),			\
 		__cobalt_symbolic_syscall(fcntl),			\
 		__cobalt_symbolic_syscall(migrate),			\
-		__cobalt_symbolic_syscall(archcall),			\
 		__cobalt_symbolic_syscall(trace),			\
 		__cobalt_symbolic_syscall(corectl),			\
 		__cobalt_symbolic_syscall(get_current),			\
-- 
2.35.3

