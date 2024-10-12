Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A315443C
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728817; cv=none; b=Cb40jPhBJUyfzvSDXWe2n63hRvHcm3IPY1rmDjeqHfuVEY53UEYTSTk0VRKlGkhrRYbcjUJxwxUgE4tor21ypYjbRFQruvwJ9dO9PygY2yNkqUkQExR2ja2tjQgqNnHIhZHg/BFzL5HkwdOH9asSxVUaW9rtgKtHWvz5E4uN/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728817; c=relaxed/simple;
	bh=mJST6nmvc9qP2A4+dNuHMsVnOQZNyGqLX4ovxJPmEz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlX6DKmk+JVUC7lWw7dzuV1Z8JLKtYz+1j1jw40+lB40H4+wbgduMoiuFwwLKL8e8zJUVvVs68j5/W8a9akZPJnLrlJFqXQvNSnMlLGUh4MiEr6SsiTdte/ZiHKMdt9Y4wRI1gks9gN6m37KB7qcAk4ljBQcsY/xUuJwLybOIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=F5ozx5jQ; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="F5ozx5jQ"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241012102645d9dd805f35d50e9207
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xtdbBR286hXFsspbA+hrzwkTHgk7LluGF2oCjXqMD9I=;
 b=F5ozx5jQ3Td7A5Cbojb9pBzX2SRIoEFULO3kAF0wxlXCcPRIqjdtO5Essmvno78W5xPgsh
 4dOajMVhp1pbeid6BpHffOk1Z+vSxS6/bmIgmd6zNTY6R87Y38aCBEkTyp1e++g59WX3Mysi
 8eoBjoD1M0vBlKeMPJFymvy0BgIa/wWDBq6HOjmgGRFNcVSGIV//P1/eTzibCB35hYdMWSvA
 cXMmEsxsnjJlUIdkbD1z5LwlpcMyF6njNq7oKrd0+FBVi+WeH+4QGdmxpArJguwaq/JPrFsJ
 EprAVUE/HEXWkXd95Bw9vblNVOEEilLyKHsIFN3uGdeaeJCnnBQ9ZCaw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 12 Oct 2024 12:26:46 +0200
Subject: [PATCH 7/7] cobalt: syscall API: Remove architecture specific
 parts
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-flo-cleanup-before-release-v1-7-df05bfa0ac80@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

As all supported architectures follow the Linux syscall API now we can
remove most of the architecture specific syscall bits and migrate to
Linux APIs for fetching syscall number and syscall arguments.

The same applies to the other direction. Writing the syscall result
into architecture specific registers is now handled by the Linux APIs
as well.

The architecture specific API is now limited to one function, namely
arch_is_valid_linux_sycall(). armhf needs additional checking here.

With that refactoring and cleanup applied the transition to a prctl()
based syscall API should be easy.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../kernel/dovetail/pipeline/vdso_fallback.h       | 19 +++---
 include/cobalt/kernel/rtdm/fd.h                    |  1 -
 include/cobalt/uapi/asm-generic/syscall.h          |  1 -
 .../cobalt/arch/arm/include/asm/xenomai/syscall.h  | 51 ++--------------
 .../arch/arm/include/asm/xenomai/uapi/syscall.h    | 28 ---------
 .../arch/arm64/include/asm/xenomai/syscall.h       | 47 ++-------------
 .../arch/arm64/include/asm/xenomai/uapi/syscall.h  | 28 ---------
 .../cobalt/arch/x86/include/asm/xenomai/syscall.h  | 53 ++--------------
 .../arch/x86/include/asm/xenomai/uapi/syscall.h    | 23 -------
 kernel/cobalt/dovetail/syscall.c                   | 34 +++++++++--
 .../cobalt/include/asm-generic/xenomai/syscall.h   | 26 ++++++++
 .../cobalt/include/asm-generic/xenomai/syscall32.h | 20 ++-----
 kernel/cobalt/posix/syscall.c                      | 70 +++++++++++-----------
 kernel/cobalt/posix/syscall.h                      |  7 ++-
 kernel/cobalt/rtdm/fd.c                            |  7 ++-
 15 files changed, 122 insertions(+), 293 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h b/include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h
index 07de643e4..9e2a02b22 100644
--- a/include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h
+++ b/include/cobalt/kernel/dovetail/pipeline/vdso_fallback.h
@@ -20,25 +20,21 @@
 #define is_clock_gettime64(__nr)	((__nr) == __NR_clock_gettime64)
 #endif
 
-static __always_inline bool 
-pipeline_handle_vdso_fallback(int nr, struct pt_regs *regs)
+static __always_inline bool pipeline_handle_vdso_fallback(struct pt_regs *regs,
+							  unsigned int nr,
+							  unsigned long *args)
 {
 	struct __kernel_old_timespec __user *u_old_ts;
 	struct __kernel_timespec uts, __user *u_uts;
 	struct __kernel_old_timespec old_ts;
 	struct timespec64 ts64;
-	int clock_id, ret = 0;
-	unsigned long args[6];
+	int clock_id;
+	int error;
+	int ret = 0;
 
 	if (!is_clock_gettime(nr) && !is_clock_gettime64(nr))
 		return false;
 
-	/*
-	 * We need to fetch the args again because not all archs use the same
-	 * calling convention for Linux and Xenomai syscalls.
-	 */
-	syscall_get_arguments(current, regs, args);
-
 	clock_id = (int)args[0];
 	switch (clock_id) {
 	case CLOCK_MONOTONIC:
@@ -65,7 +61,8 @@ pipeline_handle_vdso_fallback(int nr, struct pt_regs *regs)
 			ret = -EFAULT;
 	}
 
-	__xn_status_return(regs, ret);
+	error = IS_ERR_VALUE((long)ret) ? ret : 0;
+	syscall_set_return_value(current, regs, error, ret);
 
 	return true;
 }
diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 176c67e22..80f07627b 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -24,7 +24,6 @@
 #include <linux/socket.h>
 #include <linux/file.h>
 #include <cobalt/kernel/tree.h>
-#include <asm-generic/xenomai/syscall.h>
 
 struct vm_area_struct;
 struct rtdm_fd;
diff --git a/include/cobalt/uapi/asm-generic/syscall.h b/include/cobalt/uapi/asm-generic/syscall.h
index b38b241ec..0af24f125 100644
--- a/include/cobalt/uapi/asm-generic/syscall.h
+++ b/include/cobalt/uapi/asm-generic/syscall.h
@@ -20,7 +20,6 @@
 
 #include <linux/types.h>
 #include <asm/xenomai/uapi/features.h>
-#include <asm/xenomai/uapi/syscall.h>
 
 #define __COBALT_SYSCALL_BIT	0x10000000
 
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 0cd59380d..9f8b2a181 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -22,57 +22,14 @@
 #ifndef _COBALT_ARM_SYSCALL_H
 #define _COBALT_ARM_SYSCALL_H
 
-#include <linux/errno.h>
-#include <linux/uaccess.h>
+#include <asm/syscall.h>
 #include <asm/unistd.h>
-#include <asm/ptrace.h>
 #include <asm-generic/xenomai/syscall.h>
+#include <linux/types.h>
 
-/*
- * Cobalt syscall and Linux syscall numbers can be fetched directly from
- * ARM_r7. Since we have to work with Dovetail whilst remaining binary
- * compatible with applications built for the I-pipe, the syscall signature
- * is possibly ORed with __COBALT_SYSCALL_BIT by Dovetail (IPIPE_COMPAT
- * mode).
- *
- * FIXME: We also have __COBALT_SYSCALL_BIT (equal to
- * __OOB_SYSCALL_BIT) present in the actual syscall number in r0,
- * which is pretty much useless. Oh, well...  When support for the
- * I-pipe is dropped, we may switch back to the regular convention
- * Dovetail abides by, with the actual syscall number into r7 ORed
- * with __OOB_SYSCALL_BIT, freeing r0 for passing a call argument.
- */
-#define __xn_reg_sys(__regs)	((__regs)->ARM_r7)
-#define __xn_syscall_p(__regs)	((__regs)->ARM_r7 & __COBALT_SYSCALL_BIT)
-#define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
-
-/*
- * Root syscall number with predicate (valid only if
- * !__xn_syscall_p(__regs)).
- */
-#define __xn_rootcall_p(__regs, __code)					\
-	({								\
-		*(__code) = (__regs)->ARM_r7;				\
-		*(__code) < NR_syscalls || *(__code) >= __ARM_NR_BASE;	\
-	})
-
-#define __xn_reg_rval(__regs)	((__regs)->ARM_r0)
-#define __xn_reg_pc(__regs)	((__regs)->ARM_ip)
-#define __xn_reg_sp(__regs)	((__regs)->ARM_sp)
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, long v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
+static inline bool arch_is_valid_linux_syscall(unsigned int nr)
 {
-	return __xn_reg_rval(regs) == -EINTR;
+	return nr < NR_syscalls || nr >= __ARM_NR_BASE;
 }
 
 #endif /* !_COBALT_ARM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
deleted file mode 100644
index c9561e030..000000000
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_ARM_ASM_UAPI_SYSCALL_H
-#define _COBALT_ARM_ASM_UAPI_SYSCALL_H
-
-#define __xn_syscode(__nr)	(__COBALT_SYSCALL_BIT | (__nr))
-
-#define XENOMAI_SYSARCH_TSCINFO      4
-
-#endif /* !_COBALT_ARM_ASM_UAPI_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index 42057e986..6db6dbe45 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -8,51 +8,12 @@
 #ifndef _COBALT_ARM64_SYSCALL_H
 #define _COBALT_ARM64_SYSCALL_H
 
-#include <linux/errno.h>
-#include <asm/ptrace.h>
+#include <asm/unistd.h>
 #include <asm-generic/xenomai/syscall.h>
+#include <linux/types.h>
 
-/*
- * Cobalt and Linux syscall numbers can be fetched from syscallno,
- * masking out the __COBALT_SYSCALL_BIT marker.
- */
-#define __xn_reg_sys(__regs)	((unsigned long)(__regs)->syscallno)
-#define __xn_syscall_p(regs)	((__xn_reg_sys(regs) & __COBALT_SYSCALL_BIT) != 0)
-
-#ifdef CONFIG_XENO_ARCH_SYS3264
-#define __xn_syscall(__regs)    __COBALT_SYSNR32emu(__xn_reg_sys(__regs)	\
-				    & ~__COBALT_SYSCALL_BIT)
-#else
-#define __xn_syscall(__regs)	((unsigned long)(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT))
-#endif
-
-#define __xn_reg_rval(__regs)	((__regs)->regs[0])
-#define __xn_reg_pc(__regs)	((__regs)->pc)
-#define __xn_reg_sp(__regs)	((__regs)->sp)
-
-/*
- * Root syscall number with predicate (valid only if
- * !__xn_syscall_p(__regs)).
- */
-#define __xn_rootcall_p(__regs, __code)			\
-	({						\
-		*(__code) = __xn_reg_sys(__regs);	\
-		*(__code) < NR_syscalls;		\
-	})
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
+static inline bool arch_is_valid_linux_syscall(unsigned int nr)
 {
-	__xn_reg_rval(regs) = v;
+	return nr < NR_syscalls;
 }
-
-static inline void __xn_status_return(struct pt_regs *regs, long v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) == -EINTR;
-}
-
 #endif /* !_COBALT_ARM64_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/syscall.h
deleted file mode 100644
index 5b319d6a0..000000000
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/uapi/syscall.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_ARM64_ASM_UAPI_SYSCALL_H
-#define _COBALT_ARM64_ASM_UAPI_SYSCALL_H
-
-#define __xn_syscode(__nr)	(__COBALT_SYSCALL_BIT | (__nr))
-
-#define XENOMAI_SYSARCH_TSCINFO		0
-
-#endif /* !_COBALT_ARM64_ASM_UAPI_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
index f60aed013..c2666e978 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -19,59 +19,14 @@
 #ifndef _COBALT_X86_ASM_SYSCALL_H
 #define _COBALT_X86_ASM_SYSCALL_H
 
-#include <linux/errno.h>
-#include <asm/ptrace.h>
+#include <asm/unistd.h>
 #include <asm-generic/xenomai/syscall.h>
+#include <linux/types.h>
 
-/*
- * Cobalt and Linux syscall numbers can be fetched from ORIG_AX,
- * masking out the __COBALT_SYSCALL_BIT marker.
- */
-#define __xn_reg_sys(regs)    ((regs)->orig_ax)
-#define __xn_reg_rval(regs)   ((regs)->ax)
-#define __xn_reg_pc(regs)     ((regs)->ip)
-#define __xn_reg_sp(regs)     ((regs)->sp)
-
-#define __xn_syscall_p(regs)  (__xn_reg_sys(regs) & __COBALT_SYSCALL_BIT)
-#ifdef CONFIG_XENO_ARCH_SYS3264
-#define __xn_syscall(regs)    __COBALT_CALL32_SYSNR(__xn_reg_sys(regs)	\
-				    & ~__COBALT_SYSCALL_BIT)
-#else
-#define __xn_syscall(regs)    (__xn_reg_sys(regs) & ~__COBALT_SYSCALL_BIT)
-#endif
-
-#ifdef CONFIG_IA32_EMULATION
-#define __xn_nr_root_syscalls						\
-	({								\
-		struct thread_info *__ti = current_thread_info();	\
-		__ti->status & TS_COMPAT ? IA32_NR_syscalls : NR_syscalls; \
-	})
-#else
-#define __xn_nr_root_syscalls	NR_syscalls
-#endif
-/*
- * Root syscall number with predicate (valid only if
- * !__xn_syscall_p(__regs)).
- */
-#define __xn_rootcall_p(__regs, __code)			\
-	({						\
-		*(__code) = __xn_reg_sys(__regs);	\
-		*(__code) < __xn_nr_root_syscalls;	\
-	})
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, long v)
+static inline bool arch_is_valid_linux_syscall(unsigned int nr)
 {
-	__xn_reg_rval(regs) = v;
+	return nr < NR_syscalls;
 }
 
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) == -EINTR;
-}
 
 #endif /* !_COBALT_X86_ASM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
deleted file mode 100644
index 500d16936..000000000
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright (C) 2001-2014 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_X86_ASM_UAPI_SYSCALL_H
-#define _COBALT_X86_ASM_UAPI_SYSCALL_H
-
-#define __xn_syscode(__nr)	(__COBALT_SYSCALL_BIT | __nr)
-
-#endif /* !_COBALT_X86_ASM_UAPI_SYSCALL_H */
diff --git a/kernel/cobalt/dovetail/syscall.c b/kernel/cobalt/dovetail/syscall.c
index 7d92ccd3a..ede39cae6 100644
--- a/kernel/cobalt/dovetail/syscall.c
+++ b/kernel/cobalt/dovetail/syscall.c
@@ -8,19 +8,43 @@
 #include <linux/dovetail.h>
 #include <linux/irqstage.h>
 #include <pipeline/pipeline.h>
-#include <pipeline/kevents.h>
-#include <cobalt/kernel/assert.h>
 #include <xenomai/posix/syscall.h>
 
+static unsigned int collect_syscall_args(struct pt_regs *regs,
+					 unsigned long *args)
+{
+	struct task_struct *tsk = current;
+	unsigned int nr;
+
+	nr = syscall_get_nr(tsk, regs);
+
+	syscall_get_arguments(tsk, regs, args);
+
+	if (!(cobalt_syscall_is_valid(nr)))
+		return nr; // Linux syscall
+
+	return nr;
+}
+
 int handle_pipelined_syscall(struct irq_stage *stage, struct pt_regs *regs)
 {
+	unsigned long args[6];
+	unsigned int nr;
+
+	nr = collect_syscall_args(regs, args);
+
 	if (unlikely(running_inband()))
-		return handle_root_syscall(regs);
+		return handle_root_syscall(regs, nr, args);
 
-	return handle_head_syscall(stage == &inband_stage, regs);
+	return handle_head_syscall(stage == &inband_stage, regs, nr, args);
 }
 
 int handle_oob_syscall(struct pt_regs *regs)
 {
-	return handle_head_syscall(false, regs);
+	unsigned long args[6];
+	unsigned int nr;
+
+	nr = collect_syscall_args(regs, args);
+
+	return handle_head_syscall(false, regs, nr, args);
 }
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index facc60bcc..9766644da 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -19,6 +19,7 @@
 #ifndef _COBALT_ASM_GENERIC_SYSCALL_H
 #define _COBALT_ASM_GENERIC_SYSCALL_H
 
+#include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/version.h>
 #include <linux/uaccess.h>
@@ -28,6 +29,8 @@
 #include <cobalt/uapi/asm-generic/syscall.h>
 #include <cobalt/uapi/kernel/types.h>
 
+#include "syscall32.h"
+
 #define __xn_copy_from_user(dstP, srcP, n)	raw_copy_from_user(dstP, srcP, n)
 #define __xn_copy_to_user(dstP, srcP, n)	raw_copy_to_user(dstP, srcP, n)
 #define __xn_put_user(src, dstP)		__put_user(src, dstP)
@@ -161,6 +164,29 @@ cobalt_timespec64_to_timeval(const struct timespec64 *src)
 	return tv;
 }
 
+static inline unsigned int cobalt_syscall_get_offset(unsigned int nr)
+{
+	if (in_compat_syscall())
+		nr += __COBALT_COMPAT32_BASE;
+
+	return nr;
+}
+
+static inline unsigned int cobalt_syscall_get_nr(unsigned int nr)
+{
+	return nr & ~__COBALT_SYSCALL_BIT;
+}
+
+static inline bool cobalt_syscall_is_valid(unsigned int nr)
+{
+	return nr & __COBALT_SYSCALL_BIT;
+}
+
+static inline int cobalt_syscall_get_compat_flag(unsigned int nr)
+{
+	return in_compat_syscall() ? __COBALT_SYSCALL_BIT : 0;
+}
+
 /* 32bit syscall emulation */
 #define __COBALT_COMPAT_BIT	0x1
 /* 32bit syscall emulation - extended form */
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall32.h b/kernel/cobalt/include/asm-generic/xenomai/syscall32.h
index 3e1fcab8f..0c2cc7ef2 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall32.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall32.h
@@ -21,18 +21,9 @@
 
 #ifdef CONFIG_XENO_ARCH_SYS3264
 
-#define __COBALT_COMPAT32_BASE		256 /* Power of two. */
-
-#define __COBALT_SYSNR32emu(__reg)					\
-	({								\
-		long __nr = __reg;					\
-		if (in_compat_syscall())				\
-			__nr += __COBALT_COMPAT32_BASE;			\
-		__nr;							\
-	})
+#include <cobalt/uapi/syscall.h>
 
-#define __COBALT_COMPAT32emu(__reg)					\
-	(in_compat_syscall() ? __COBALT_COMPAT_BIT : 0)
+#define __COBALT_COMPAT32_BASE		256 /* Power of two. */
 
 #if __NR_COBALT_SYSCALLS > __COBALT_COMPAT32_BASE
 #error "__NR_COBALT_SYSCALLS > __COBALT_COMPAT32_BASE"
@@ -67,6 +58,8 @@
 
 /* compat support disabled. */
 
+#define __COBALT_COMPAT32_BASE		0
+
 #define __COBALT_SYSNR32emu(__reg)	(__reg)
 
 #define __COBALT_COMPAT32emu(__reg)	0
@@ -92,9 +85,4 @@
 #define __COBALT_CALL32_INITMODE(__mode)	\
 	__COBALT_CALL32emu_INITMODE(__mode)
 
-/* Already checked for __COBALT_SYSCALL_BIT */
-#define __COBALT_CALL32_SYSNR(__reg)	__COBALT_SYSNR32emu(__reg)
-
-#define __COBALT_CALL_COMPAT(__reg)	__COBALT_COMPAT32emu(__reg)
-
 #endif /* !_COBALT_ASM_GENERIC_SYSCALL32_H */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index a26da154c..a6590c830 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -93,9 +93,9 @@ static void prepare_for_signal(struct task_struct *p,
 
 	if (xnthread_test_info(thread, XNKICKED)) {
 		if (signal_pending(p)) {
-			__xn_error_return(regs,
+			syscall_set_return_value(p, regs,
 					  (sysflags & __xn_exec_norestart) ?
-					  -EINTR : -ERESTARTSYS);
+					  -EINTR : -ERESTARTSYS, 0);
 			notify = !xnthread_test_state(thread, XNSSTEP);
 			xnthread_clear_info(thread, XNBREAK);
 		}
@@ -470,28 +470,29 @@ static inline int allowed_syscall(struct cobalt_process *process,
 	return cap_raised(current_cap(), CAP_SYS_NICE);
 }
 
-int handle_head_syscall(bool caller_is_relaxed, struct pt_regs *regs)
+int handle_head_syscall(bool caller_is_relaxed, struct pt_regs *regs,
+			unsigned int nr, unsigned long *args)
 {
 	struct cobalt_process *process;
 	int switched, sigs, sysflags;
 	struct xnthread *thread;
 	cobalt_syshand handler;
 	struct task_struct *p;
-	unsigned long args[6];
-	unsigned int nr, code;
+	unsigned int offset;
 	long ret;
 
-	if (!__xn_syscall_p(regs))
+	if (!cobalt_syscall_is_valid(nr))
 		goto linux_syscall;
 
 	thread = xnthread_current();
-	code = __xn_syscall(regs);
-	if (code >= ARRAY_SIZE(cobalt_syscalls))
-		goto bad_syscall;
 
-	nr = code & (__NR_COBALT_SYSCALLS - 1);
+	nr = cobalt_syscall_get_nr(nr);
+	offset = cobalt_syscall_get_offset(nr);
+
+	if (nr >= ARRAY_SIZE(cobalt_syscalls))
+		goto bad_syscall;
 
-	trace_cobalt_head_sysentry(code);
+	trace_cobalt_head_sysentry(nr);
 
 	process = cobalt_current_process();
 	if (process == NULL) {
@@ -499,7 +500,8 @@ int handle_head_syscall(bool caller_is_relaxed, struct pt_regs *regs)
 		cobalt_set_process(process);
 	}
 
-	handler = cobalt_syscalls[code];
+	p = current;
+	handler = cobalt_syscalls[offset];
 	sysflags = cobalt_sysmodes[nr];
 
 	/*
@@ -515,7 +517,7 @@ int handle_head_syscall(bool caller_is_relaxed, struct pt_regs *regs)
 			printk(XENO_WARNING
 			       "syscall <%d> denied to %s[%d]\n",
 			       nr, current->comm, task_pid_nr(current));
-		__xn_error_return(regs, -EPERM);
+		syscall_set_return_value(p, regs, -EPERM, 0);
 		goto ret_handled;
 	}
 
@@ -584,9 +586,6 @@ restart:
 	 * handler (lostage ones), or rejected by allowed_syscall().
 	 */
 
-	p = current;
-	syscall_get_arguments(p, regs, args);
-
 	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
 		if (switched) {
@@ -603,7 +602,7 @@ restart:
 		goto restart;
 	}
 done:
-	__xn_status_return(regs, ret);
+	syscall_set_return_value(p, regs, ret, 0);
 	sigs = 0;
 	if (!xnsched_root_p()) {
 		if (signal_pending(p) ||
@@ -630,7 +629,7 @@ ret_handled:
 		xnthread_sync_window(thread);
 	}
 
-	trace_cobalt_head_sysexit(__xn_reg_rval(regs));
+	trace_cobalt_head_sysexit(syscall_get_return_value(p, regs));
 
 	return KEVENT_STOP;
 
@@ -644,10 +643,10 @@ linux_syscall:
 		 */
 		return KEVENT_PROPAGATE;
 
-	if (!__xn_rootcall_p(regs, &code))
+	if (!arch_is_valid_linux_syscall(nr))
 		goto bad_syscall;
 
-	if (pipeline_handle_vdso_fallback(code, regs))
+	if (pipeline_handle_vdso_fallback(regs, nr, args))
 		return KEVENT_STOP;
 
 	/*
@@ -661,21 +660,21 @@ linux_syscall:
 	return KEVENT_PROPAGATE;
 
 bad_syscall:
-	printk(XENO_WARNING "bad syscall <%#x>\n", code);
+	printk(XENO_WARNING "bad syscall <%u>\n", nr);
 
-	__xn_error_return(regs, -ENOSYS);
+	syscall_set_return_value(p, regs, -ENOSYS, 0);
 
 	return KEVENT_STOP;
 }
 
-int handle_root_syscall(struct pt_regs *regs)
+int handle_root_syscall(struct pt_regs *regs, unsigned int nr,
+			unsigned long *args)
 {
 	int sysflags, switched, sigs;
 	struct xnthread *thread;
 	cobalt_syshand handler;
 	struct task_struct *p;
-	unsigned long args[6];
-	unsigned int nr, code;
+	unsigned int offset;
 	long ret;
 
 	/*
@@ -686,20 +685,20 @@ int handle_root_syscall(struct pt_regs *regs)
 	 */
 	xnthread_test_cancel();
 
-	if (!__xn_syscall_p(regs))
+	if (!cobalt_syscall_is_valid(nr))
 		/* Fall back to Linux syscall handling. */
 		return KEVENT_PROPAGATE;
 
 	thread = xnthread_current();
-	/* code has already been checked in the head domain handler. */
-	code = __xn_syscall(regs);
-	nr = code & (__NR_COBALT_SYSCALLS - 1);
 
-	trace_cobalt_root_sysentry(code);
+	/* nr has already been checked in the head domain handler. */
+	nr = cobalt_syscall_get_nr(nr);
+	offset = cobalt_syscall_get_offset(nr);
 
-	/* Processing a Xenomai syscall. */
+	trace_cobalt_root_sysentry(nr);
 
-	handler = cobalt_syscalls[code];
+	/* Processing a Xenomai syscall. */
+	handler = cobalt_syscalls[offset];
 	sysflags = cobalt_sysmodes[nr];
 
 	if (thread && (sysflags & __xn_exec_conforming))
@@ -719,7 +718,7 @@ restart:
 		 */
 		ret = xnthread_harden();
 		if (ret) {
-			__xn_error_return(regs, ret);
+			syscall_set_return_value(p, regs, ret, 0);
 			goto ret_handled;
 		}
 		switched = 1;
@@ -734,7 +733,6 @@ restart:
 	}
 
 	p = current;
-	syscall_get_arguments(p, regs, args);
 
 	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
@@ -748,7 +746,7 @@ restart:
 		goto restart;
 	}
 
-	__xn_status_return(regs, ret);
+	syscall_set_return_value(p, regs, ret, 0);
 
 	sigs = 0;
 	if (!xnsched_root_p()) {
@@ -776,7 +774,7 @@ ret_handled:
 		xnthread_sync_window(thread);
 	}
 
-	trace_cobalt_root_sysexit(__xn_reg_rval(regs));
+	trace_cobalt_root_sysexit(syscall_get_return_value(p, regs));
 
 	return KEVENT_STOP;
 }
diff --git a/kernel/cobalt/posix/syscall.h b/kernel/cobalt/posix/syscall.h
index e43f8d991..4cc3fbbc0 100644
--- a/kernel/cobalt/posix/syscall.h
+++ b/kernel/cobalt/posix/syscall.h
@@ -32,9 +32,10 @@ struct pt_regs;
 
 #include <asm-generic/xenomai/syscall32.h>
 
-int handle_head_syscall(bool caller_is_relaxed,
-			struct pt_regs *regs);
+int handle_head_syscall(bool caller_is_relaxed, struct pt_regs *regs,
+			unsigned int nr, unsigned long *args);
 
-int handle_root_syscall(struct pt_regs *regs);
+int handle_root_syscall(struct pt_regs *regs, unsigned int nr,
+			unsigned long *args);
 
 #endif /* !_COBALT_POSIX_SYSCALL_H */
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index d5813a16c..c9a9e8059 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -133,13 +133,16 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
 static inline void set_compat_bit(struct rtdm_fd *fd)
 {
 	struct pt_regs *regs;
+	int nr;
 
 	if (cobalt_ppd_get(0) == &cobalt_kernel_ppd)
 		fd->compat = 0;
 	else {
 		regs = task_pt_regs(current);
-		XENO_BUG_ON(COBALT, !__xn_syscall_p(regs));
-		fd->compat = __COBALT_CALL_COMPAT(__xn_reg_sys(regs));
+		nr = syscall_get_nr(current, regs);
+
+		XENO_BUG_ON(COBALT, !cobalt_syscall_is_valid(nr));
+		fd->compat = cobalt_syscall_get_compat_flag(nr);
 	}
 }
 

-- 
2.39.5

