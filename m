Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79F13A26B
	for <xenomai@lists.linux.dev>; Sat, 12 Oct 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728816; cv=none; b=nxCHpDotnSPqp98EOAkoUEe2sDFA6nT6lvH2mQ9RtaShA0pF3KluG8PYC18VXIdB5EbIpOkZ54gXYxArmc2aOjQoqQsp/d8g4l3cgaAuvosEc6OC/8kIkP8H8+v7/UkTEjUFLASTgh1pyVR0n7nG+MeRBUQ18wqlaUMYSAlqPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728816; c=relaxed/simple;
	bh=5B4vIR9IaOizy8vRJGnBOnZ57nTFh46tbvX8MT9OIIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFzSAXvpcNs3wHxh8CI/ug9Y7Sf4nXmdufZafZA0W9TMQHkrVvXmLa0632anJioc/WqMlixJv/g2skCD5OjyJvBI9Gj8CYuaE4bLAS2IiMOq2pMltYWom4NupHFSdBuDsCevtCj5zM0zll0Xd6xc3XYIlh07gsG9DNUNjDkUFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=KvBEwf9U; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KvBEwf9U"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024101210264494e956fe3ef456b780
        for <xenomai@lists.linux.dev>;
        Sat, 12 Oct 2024 12:26:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=u6X+SqdizsT4i3GOOawYPUPv9zromU9ORgwxV++agXM=;
 b=KvBEwf9Ucn66tDYIQ2vkp7IcK9oD/4EW5SCONPGpAibHqhKQF8wnDGlt893id8FvBjMsee
 Dbp/amfWNd+5xCnEQtJmmAcs5Iq6lNbzO3biHnUI0GEy6314q6JMez8dzp7v0N80UG7cgqCN
 uNzmIkdNftP593NncJEUeS09LzANN6v7NZoOOqTqPWPJAxcoDHEbFqRJEnrUex+T8ohpzeIh
 ooFdNxsOlplLhN+D0GONWLG5quyvEeTDB73sqDfpzaSBzkW0mk0hWPYNhlTwymLUU/MVhcU8
 Uud/JzGAHvvluugB0xTmIxxL5puiLX4/1YD3ipgsl3svVQdSDmZ4SDFA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 12 Oct 2024 12:26:44 +0200
Subject: [PATCH 5/7] cobalt: sycall API: Remove architecture specific
 implementations
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-flo-cleanup-before-release-v1-5-df05bfa0ac80@siemens.com>
References: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
In-Reply-To: <20241012-flo-cleanup-before-release-v1-0-df05bfa0ac80@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Adding compat support for the arm64 architecture had the nice side
effect that all supported architectures now follow the Linux calling
convention regarding syscalls.

That allows us to drop architecture specific code and migrate to
syscall() provided by libc.

This is a preparation step for a possible migration to a prctl() based
syscall API. The migration is getting way simpler as no architecture
specific code has to be taken into account.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/Makefile.am                         |   3 +-
 include/cobalt/syscall.h                           |  56 ++++++
 .../arch/arm/include/asm/xenomai/Makefile.am       |   3 +-
 lib/cobalt/arch/arm/include/asm/xenomai/syscall.h  | 122 ------------
 .../arch/arm64/include/asm/xenomai/Makefile.am     |   3 +-
 .../arch/arm64/include/asm/xenomai/syscall.h       | 104 ----------
 .../arch/x86/include/asm/xenomai/Makefile.am       |   3 +-
 lib/cobalt/arch/x86/include/asm/xenomai/syscall.h  | 216 ---------------------
 lib/cobalt/clock.c                                 |   3 +-
 lib/cobalt/cond.c                                  |   3 +-
 lib/cobalt/current.c                               |   3 +-
 lib/cobalt/init.c                                  |   5 +-
 lib/cobalt/internal.c                              |   5 +-
 lib/cobalt/mq.c                                    |   2 +-
 lib/cobalt/mutex.c                                 |   3 +-
 lib/cobalt/rtdm.c                                  |   3 +-
 lib/cobalt/sched.c                                 |   3 +-
 lib/cobalt/select.c                                |   2 +-
 lib/cobalt/semaphore.c                             |   3 +-
 lib/cobalt/signal.c                                |   2 +-
 lib/cobalt/sigshadow.c                             |   3 +-
 lib/cobalt/thread.c                                |   3 +-
 lib/cobalt/timer.c                                 |   3 +-
 lib/cobalt/timerfd.c                               |   3 +-
 lib/cobalt/trace.c                                 |   6 +-
 testsuite/smokey/y2038/syscall-tests.c             |   2 +-
 testsuite/switchtest/switchtest.c                  |   2 +-
 27 files changed, 96 insertions(+), 473 deletions(-)

diff --git a/include/cobalt/Makefile.am b/include/cobalt/Makefile.am
index 19e96112e..ff2a11e87 100644
--- a/include/cobalt/Makefile.am
+++ b/include/cobalt/Makefile.am
@@ -18,7 +18,8 @@ includesub_HEADERS =	\
 	wrappers.h
 
 noinst_HEADERS =	\
-	arith.h
+	arith.h		\
+	syscall.h
 
 SUBDIRS =		\
 	boilerplate	\
diff --git a/include/cobalt/syscall.h b/include/cobalt/syscall.h
new file mode 100644
index 000000000..036b7642c
--- /dev/null
+++ b/include/cobalt/syscall.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Cobalt syscall API
+ *
+ * Copyright (c) Siemens AG 2024
+ *
+ * Authors:
+ *  Florian Bezdeka <florian.bezdeka@siemens.com>
+ *
+ */
+
+/*
+ * We include xeno_config.h first here as <cobalt/uapi/syscall.h>
+ * uses CONFIG_SMP for feature flag definitions.
+ *
+ * CONFIG_SMP might come from the kernel configuration (kernel build) or from
+ * xeno_config.h (libcobalt build).
+ *
+ * Result: The order of includes in .c files does not matter.
+ */
+#include <xeno_config.h>
+
+#include <errno.h>
+#include <cobalt/uapi/syscall.h>
+#include <unistd.h>
+
+#ifndef _COBALT_SYSCALL_H
+#define _COBALT_SYSCALL_H
+
+#define XENOMAI_SYSCALL(op, ...)                                               \
+	({                                                                     \
+		int old_errno = errno;                                         \
+		long sc;                                                       \
+                                                                               \
+		sc = syscall(op | __COBALT_SYSCALL_BIT, __VA_ARGS__);          \
+		if (sc < 0) {                                                  \
+			sc = -errno;                                           \
+			errno = old_errno;                                     \
+		}                                                              \
+                                                                               \
+		sc;                                                            \
+	})
+
+#define XENOMAI_SYSCALL0(op) XENOMAI_SYSCALL(op, 0, 0, 0, 0, 0, 0)
+#define XENOMAI_SYSCALL1(op, arg0) XENOMAI_SYSCALL(op, arg0, 0, 0, 0, 0, 0)
+#define XENOMAI_SYSCALL2(op, arg0, arg1)                                       \
+	XENOMAI_SYSCALL(op, arg0, arg1, 0, 0, 0, 0)
+#define XENOMAI_SYSCALL3(op, arg0, arg1, arg2)                                 \
+	XENOMAI_SYSCALL(op, arg0, arg1, arg2, 0, 0, 0)
+#define XENOMAI_SYSCALL4(op, arg0, arg1, arg2, arg3)                           \
+	XENOMAI_SYSCALL(op, arg0, arg1, arg2, arg3, 0, 0)
+#define XENOMAI_SYSCALL5(op, arg0, arg1, arg2, arg3, arg4)                     \
+	XENOMAI_SYSCALL(op, arg0, arg1, arg2, arg3, arg4, 0)
+
+#endif /* !_COBALT_SYSCALL_H */
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
index a7dd09043..796c46dd6 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
@@ -1,4 +1,3 @@
 
 noinst_HEADERS =	\
-	features.h	\
-	syscall.h
+	features.h
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
deleted file mode 100644
index 105bf9faf..000000000
--- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,122 +0,0 @@
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
-#ifndef _LIB_COBALT_ARM_SYSCALL_H
-#define _LIB_COBALT_ARM_SYSCALL_H
-
-#include <xeno_config.h>
-#include <errno.h>
-#include <cobalt/uapi/syscall.h>
-
-#ifndef __ARM_EABI__
-#error "ARM OABI support has been removed with Xenomai 3.3.x"
-#endif
-
-/*
- * Some of the following macros have been adapted from Linux's
- * implementation of the syscall mechanism in <asm-arm/unistd.h>:
- */
-#if defined(HAVE_TLS) && __GNUC__ == 4 && __GNUC_MINOR__ >= 3
-#error TLS support (__thread) is broken with GCC >= 4.3, use --disable-tls when configuring
-#endif
-
-#define LOADARGS_0(syscode, arg1...)
-#define LOADARGS_1(syscode, arg1)	\
-	LOADARGS_0(syscode, arg1);	\
-	__a0 = (unsigned long) (arg1)
-#define LOADARGS_2(syscode, arg1, arg2)	\
-	LOADARGS_1(syscode, arg1);	\
-	__a1 = (unsigned long) (arg2)
-#define LOADARGS_3(syscode, arg1, arg2, arg3)	\
-	LOADARGS_2(syscode,  arg1, arg2);	\
-	__a2 = (unsigned long) (arg3)
-#define LOADARGS_4(syscode,  arg1, arg2, arg3, arg4)	\
-	LOADARGS_3(syscode,  arg1, arg2, arg3);		\
-	__a3 = (unsigned long) (arg4)
-#define LOADARGS_5(syscode, arg1, arg2, arg3, arg4, arg5)	\
-	LOADARGS_4(syscode, arg1, arg2, arg3, arg4);		\
-	__a4 = (unsigned long) (arg5)
-
-#define CLOBBER_REGS_0
-#define CLOBBER_REGS_1 "r0"
-#define CLOBBER_REGS_2 CLOBBER_REGS_1, "r1"
-#define CLOBBER_REGS_3 CLOBBER_REGS_2, "r2"
-#define CLOBBER_REGS_4 CLOBBER_REGS_3, "r3"
-#define CLOBBER_REGS_5 CLOBBER_REGS_4, "r4"
-
-#define LOADREGS_0
-#define LOADREGS_1 __r0 = __a0
-#define LOADREGS_2 LOADREGS_1; __r1 = __a1
-#define LOADREGS_3 LOADREGS_2; __r2 = __a2
-#define LOADREGS_4 LOADREGS_3; __r3 = __a3
-#define LOADREGS_5 LOADREGS_4; __r4 = __a4
-
-#define ASM_INDECL_0							\
-	register unsigned long __r0  __asm__ ("r0");
-#define ASM_INDECL_1 ASM_INDECL_0;					\
-	unsigned long __a0;
-#define ASM_INDECL_2 ASM_INDECL_1;					\
-	unsigned long __a1; register unsigned long __r1  __asm__ ("r1")
-#define ASM_INDECL_3 ASM_INDECL_2;					\
-	unsigned long __a2; register unsigned long __r2  __asm__ ("r2")
-#define ASM_INDECL_4 ASM_INDECL_3;					\
-	unsigned long __a3; register unsigned long __r3  __asm__ ("r3")
-#define ASM_INDECL_5 ASM_INDECL_4;					\
-	unsigned long __a4; register unsigned long __r4  __asm__ ("r4")
-
-#define ASM_INPUT_0 "r" (__r7)
-#define ASM_INPUT_1 ASM_INPUT_0, "0" (__r0)
-#define ASM_INPUT_2 ASM_INPUT_1, "r" (__r1)
-#define ASM_INPUT_3 ASM_INPUT_2, "r" (__r2)
-#define ASM_INPUT_4 ASM_INPUT_3, "r" (__r3)
-#define ASM_INPUT_5 ASM_INPUT_4, "r" (__r4)
-
-#define XENOMAI_DO_SYSCALL(nr, op, args...)				\
-	({								\
-		ASM_INDECL_##nr;					\
-		unsigned long __r7 = __xn_syscode(op);			\
-		LOADARGS_##nr(__xn_syscode(op), args);			\
-		__asm__ __volatile__ ("" : /* */ : /* */ :		\
-				      CLOBBER_REGS_##nr);		\
-		LOADREGS_##nr;						\
-		__asm__ __volatile__ (					\
-			"push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"	\
-			: "=r" (__r0)					\
-			: ASM_INPUT_##nr, [__r7] "r" (__r7)		\
-			: "memory");					\
-		(int) __r0;						\
-	})
-
-#define XENOMAI_SYSCALL0(op)			\
-	XENOMAI_DO_SYSCALL(0,op)
-#define XENOMAI_SYSCALL1(op,a1)			\
-	XENOMAI_DO_SYSCALL(1,op,a1)
-#define XENOMAI_SYSCALL2(op,a1,a2)		\
-	XENOMAI_DO_SYSCALL(2,op,a1,a2)
-#define XENOMAI_SYSCALL3(op,a1,a2,a3)		\
-	XENOMAI_DO_SYSCALL(3,op,a1,a2,a3)
-#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)	\
-	XENOMAI_DO_SYSCALL(4,op,a1,a2,a3,a4)
-#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5)	\
-	XENOMAI_DO_SYSCALL(5,op,a1,a2,a3,a4,a5)
-#define XENOMAI_SYSBIND(breq)			\
-	XENOMAI_DO_SYSCALL(1,sc_cobalt_bind,breq)
-
-#endif /* !_LIB_COBALT_ARM_SYSCALL_H */
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
index a7dd09043..796c46dd6 100644
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
@@ -1,4 +1,3 @@
 
 noinst_HEADERS =	\
-	features.h	\
-	syscall.h
+	features.h
diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
deleted file mode 100644
index d89697712..000000000
--- a/lib/cobalt/arch/arm64/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * Copyright (C) 2015 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) Siemens AG, 2021
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
-#ifndef _LIB_COBALT_ARM64_SYSCALL_H
-#define _LIB_COBALT_ARM64_SYSCALL_H
-
-#include <xeno_config.h>
-#include <errno.h>
-#include <cobalt/uapi/syscall.h>
-
-#define __xn_syscall_args0
-#define __xn_syscall_args1 , unsigned long __a1
-#define __xn_syscall_args2 __xn_syscall_args1, unsigned long __a2
-#define __xn_syscall_args3 __xn_syscall_args2, unsigned long __a3
-#define __xn_syscall_args4 __xn_syscall_args3, unsigned long __a4
-#define __xn_syscall_args5 __xn_syscall_args4, unsigned long __a5
-
-#define __emit_syscall0(__args...)					\
-	register unsigned int __scno __asm__("w8") = __xn_syscode(__op); \
-	register unsigned long __res __asm__("x0");			\
-	__asm__ __volatile__ (						\
-		"svc 0;\n\t"						\
-		: "=r" (__res)						\
-		: "r" (__scno), ##__args				\
-		: "cc", "memory");					\
-	return __res
-#define __emit_syscall1(__args...)					\
-	register unsigned long __x0 __asm__("x0") = __a1;		\
-	__emit_syscall0("r" (__x0),  ##__args)
-#define __emit_syscall2(__args...)					\
-	register unsigned long __x1 __asm__("x1") = __a2;		\
-	__emit_syscall1("r" (__x1), ##__args)
-#define __emit_syscall3(__args...)					\
-	register unsigned long __x2 __asm__("x2") = __a3;		\
-	__emit_syscall2("r" (__x2), ##__args)
-#define __emit_syscall4(__args...)					\
-	register unsigned long __x3 __asm__("x3") = __a4;		\
-	__emit_syscall3("r" (__x3), ##__args)
-#define __emit_syscall5(__args...)	\
-	register unsigned long __x4 __asm__("x4") = __a5;		\
-	__emit_syscall4("r" (__x4), ##__args)
-
-#define DEFINE_XENOMAI_SYSCALL(__argnr)					\
-static inline long __attribute__((always_inline))			\
-__xenomai_do_syscall##__argnr(unsigned int __op				\
-			      __xn_syscall_args##__argnr)		\
-{									\
-	__emit_syscall##__argnr();					\
-}
-
-DEFINE_XENOMAI_SYSCALL(0)
-DEFINE_XENOMAI_SYSCALL(1)
-DEFINE_XENOMAI_SYSCALL(2)
-DEFINE_XENOMAI_SYSCALL(3)
-DEFINE_XENOMAI_SYSCALL(4)
-DEFINE_XENOMAI_SYSCALL(5)
-
-#define XENOMAI_SYSCALL0(__op)					\
-	__xenomai_do_syscall0(__op)
-#define XENOMAI_SYSCALL1(__op, __a1)				\
-	__xenomai_do_syscall1(__op,				\
-			      (unsigned long)__a1)
-#define XENOMAI_SYSCALL2(__op, __a1, __a2)			\
-	__xenomai_do_syscall2(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2)
-#define XENOMAI_SYSCALL3(__op, __a1, __a2, __a3)		\
-	__xenomai_do_syscall3(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2,		\
-			      (unsigned long)__a3)
-#define XENOMAI_SYSCALL4(__op, __a1, __a2, __a3, __a4)		\
-	__xenomai_do_syscall4(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2,		\
-			      (unsigned long)__a3,		\
-			      (unsigned long)__a4)
-#define XENOMAI_SYSCALL5(__op, __a1, __a2, __a3, __a4, __a5)	\
-	__xenomai_do_syscall5(__op,				\
-			      (unsigned long)__a1,		\
-			      (unsigned long)__a2,		\
-			      (unsigned long)__a3,		\
-			      (unsigned long)__a4,		\
-			      (unsigned long)__a5)
-#define XENOMAI_SYSBIND(__breq)					\
-	__xenomai_do_syscall1(sc_cobalt_bind,			\
-			      (unsigned long)__breq)
-
-#endif /* !_LIB_COBALT_ARM64_SYSCALL_H */
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
index a7dd09043..796c46dd6 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
@@ -1,4 +1,3 @@
 
 noinst_HEADERS =	\
-	features.h	\
-	syscall.h
+	features.h
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
deleted file mode 100644
index 79bf17ee7..000000000
--- a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,216 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2007 Philippe Gerum <rpm@xenomai.org>.
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
-#ifndef _LIB_COBALT_X86_SYSCALL_H
-#define _LIB_COBALT_X86_SYSCALL_H
-
-#include <xeno_config.h>
-#include <cobalt/uapi/syscall.h>
-
-/* Some code pulled from glibc's inline syscalls. */
-
-#ifdef __i386__
-
-#ifdef CONFIG_XENO_X86_VSYSCALL
-/*
- * This form relies on the kernel's vsyscall support in order to use
- * the most appropriate syscall entry instruction the CPU supports. We
- * also depend on the NPTL providing us a pointer to the vsyscall DSO
- * entry point, to which we branch to instead of issuing a trap.
- * We assume this pointer to be available at %gs:0x10.
- */
-#define DOSYSCALL  "call *%%gs:0x10\n\t"
-#else /* CONFIG_XENO_X86_VSYSCALL */
-#define DOSYSCALL  "int $0x80\n\t"
-#endif /* CONFIG_XENO_X86_VSYSCALL */
-
-/* The one that cannot fail. */
-#define DOSYSCALLSAFE  "int $0x80\n\t"
-
-asm (".L__X'%ebx = 1\n\t"
-     ".L__X'%ecx = 2\n\t"
-     ".L__X'%edx = 2\n\t"
-     ".L__X'%eax = 3\n\t"
-     ".L__X'%esi = 3\n\t"
-     ".L__X'%edi = 3\n\t"
-     ".L__X'%ebp = 3\n\t"
-     ".L__X'%esp = 3\n\t"
-     ".macro bpushl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "pushl %ebx\n\t"
-     ".else\n\t"
-     "xchgl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t"
-     ".macro bpopl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "popl %ebx\n\t"
-     ".else\n\t"
-     "xchgl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t"
-     ".macro bmovl name reg\n\t"
-     ".if 1 - \\name\n\t"
-     ".if 2 - \\name\n\t"
-     "movl \\reg, %ebx\n\t"
-     ".endif\n\t"
-     ".endif\n\t"
-     ".endm\n\t");
-
-#define XENOMAI_DO_SYSCALL(nr, op, args...)			\
-({								\
-	unsigned __resultvar;					\
-	asm volatile (						\
-		LOADARGS_##nr					\
-		"movl %1, %%eax\n\t"				\
-		DOSYSCALL					\
-		RESTOREARGS_##nr				\
-		: "=a" (__resultvar)				\
-		: "g" (__xn_syscode(op)) ASMFMT_##nr(args)	\
-		: "memory", "cc");				\
-	(int) __resultvar;					\
-})
-
-#define XENOMAI_DO_SYSCALL_SAFE(nr, op, args...)		\
-({								\
-	unsigned __resultvar;					\
-	asm volatile (						\
-		LOADARGS_##nr					\
-		"movl %1, %%eax\n\t"				\
-		DOSYSCALLSAFE					\
-		RESTOREARGS_##nr				\
-		: "=a" (__resultvar)				\
-		: "g" (__xn_syscode(op)) ASMFMT_##nr(args)	\
-		: "memory", "cc");				\
-	(int) __resultvar;					\
-})
-
-#define LOADARGS_0
-#define LOADARGS_1 \
-	"bpushl .L__X'%k2, %k2\n\t" \
-	"bmovl .L__X'%k2, %k2\n\t"
-#define LOADARGS_2	LOADARGS_1
-#define LOADARGS_3	LOADARGS_1
-#define LOADARGS_4	LOADARGS_1
-#define LOADARGS_5	LOADARGS_1
-
-#define RESTOREARGS_0
-#define RESTOREARGS_1 \
-	"bpopl .L__X'%k2, %k2\n\t"
-#define RESTOREARGS_2	RESTOREARGS_1
-#define RESTOREARGS_3	RESTOREARGS_1
-#define RESTOREARGS_4	RESTOREARGS_1
-#define RESTOREARGS_5	RESTOREARGS_1
-
-#define ASMFMT_0()
-#define ASMFMT_1(arg1) \
-	, "acdSD" (arg1)
-#define ASMFMT_2(arg1, arg2) \
-	, "adSD" (arg1), "c" (arg2)
-#define ASMFMT_3(arg1, arg2, arg3) \
-	, "aSD" (arg1), "c" (arg2), "d" (arg3)
-#define ASMFMT_4(arg1, arg2, arg3, arg4) \
-	, "aD" (arg1), "c" (arg2), "d" (arg3), "S" (arg4)
-#define ASMFMT_5(arg1, arg2, arg3, arg4, arg5) \
-	, "a" (arg1), "c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5)
-
-#define XENOMAI_SYSBIND(breq) \
-	XENOMAI_DO_SYSCALL_SAFE(1, sc_cobalt_bind, breq)
-
-#else /* x86_64 */
-
-#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 3)
-#define LOAD_ARGS_0()	asm volatile ("" : /* */ : /* */ : "memory");
-#else
-#define LOAD_ARGS_0()
-#endif
-#define LOAD_REGS_0
-#define ASM_ARGS_0
-
-#define LOAD_ARGS_1(a1)					\
-	long int __arg1 = (long) (a1);			\
-	LOAD_ARGS_0()
-#define LOAD_REGS_1					\
-	register long int _a1 asm ("rdi") = __arg1;	\
-	LOAD_REGS_0
-#define ASM_ARGS_1	ASM_ARGS_0, "r" (_a1)
-
-#define LOAD_ARGS_2(a1, a2)				\
-	long int __arg2 = (long) (a2);			\
-	LOAD_ARGS_1(a1)
-#define LOAD_REGS_2					\
-	register long int _a2 asm ("rsi") = __arg2;	\
-	LOAD_REGS_1
-#define ASM_ARGS_2	ASM_ARGS_1, "r" (_a2)
-
-#define LOAD_ARGS_3(a1, a2, a3)				\
-	long int __arg3 = (long) (a3);			\
-	LOAD_ARGS_2 (a1, a2)
-#define LOAD_REGS_3					\
-	register long int _a3 asm ("rdx") = __arg3;	\
-	LOAD_REGS_2
-#define ASM_ARGS_3	ASM_ARGS_2, "r" (_a3)
-
-#define LOAD_ARGS_4(a1, a2, a3, a4)			\
-	long int __arg4 = (long) (a4);			\
-	LOAD_ARGS_3 (a1, a2, a3)
-#define LOAD_REGS_4					\
-	register long int _a4 asm ("r10") = __arg4;	\
-	LOAD_REGS_3
-#define ASM_ARGS_4	ASM_ARGS_3, "r" (_a4)
-
-#define LOAD_ARGS_5(a1, a2, a3, a4, a5)			\
-	long int __arg5 = (long) (a5);			\
-	LOAD_ARGS_4 (a1, a2, a3, a4)
-#define LOAD_REGS_5					\
-	register long int _a5 asm ("r8") = __arg5;	\
-	LOAD_REGS_4
-#define ASM_ARGS_5	ASM_ARGS_4, "r" (_a5)
-
-#define DO_SYSCALL(name, nr, args...)			\
-({							\
-	unsigned long __resultvar;			\
-	LOAD_ARGS_##nr(args)				\
-	LOAD_REGS_##nr					\
-	asm volatile (					\
-		"syscall\n\t"				\
-		: "=a" (__resultvar)			\
-		: "0" (name) ASM_ARGS_##nr		\
-		: "memory", "cc", "r11", "cx");		\
-	(int) __resultvar;				\
-})
-
-#define XENOMAI_DO_SYSCALL(nr, op, args...) \
-	DO_SYSCALL(__xn_syscode(op), nr, args)
-
-#define XENOMAI_SYSBIND(breq) \
-	XENOMAI_DO_SYSCALL(1, sc_cobalt_bind, breq)
-
-#endif /* x86_64 */
-
-#define XENOMAI_SYSCALL0(op)			XENOMAI_DO_SYSCALL(0,op)
-#define XENOMAI_SYSCALL1(op,a1)			XENOMAI_DO_SYSCALL(1,op,a1)
-#define XENOMAI_SYSCALL2(op,a1,a2)		XENOMAI_DO_SYSCALL(2,op,a1,a2)
-#define XENOMAI_SYSCALL3(op,a1,a2,a3)		XENOMAI_DO_SYSCALL(3,op,a1,a2,a3)
-#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)	XENOMAI_DO_SYSCALL(4,op,a1,a2,a3,a4)
-#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5)	XENOMAI_DO_SYSCALL(5,op,a1,a2,a3,a4,a5)
-
-#endif /* !_LIB_COBALT_X86_SYSCALL_H */
diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index 65abf5eac..297249d22 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -16,13 +16,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <string.h>
 #include <errno.h>
 #include <pthread.h>
 #include <unistd.h>
 #include <time.h>
 #include <sys/time.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 301dabdca..a48395e71 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -16,10 +16,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <errno.h>
 #include <string.h>
 #include <pthread.h>
-#include <asm/xenomai/syscall.h>
+
 #include "current.h"
 #include "internal.h"
 
diff --git a/lib/cobalt/current.c b/lib/cobalt/current.c
index 1e1535004..3520732b6 100644
--- a/lib/cobalt/current.c
+++ b/lib/cobalt/current.c
@@ -16,10 +16,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <string.h>
 #include <pthread.h>
-#include <asm/xenomai/syscall.h>
 #include <boilerplate/list.h>
+
 #include "current.h"
 #include "internal.h"
 
diff --git a/lib/cobalt/init.c b/lib/cobalt/init.c
index 84f37999d..0f6a4f5da 100644
--- a/lib/cobalt/init.c
+++ b/lib/cobalt/init.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <stdio.h>
@@ -30,8 +31,8 @@
 #include <semaphore.h>
 #include <boilerplate/setup.h>
 #include <cobalt/tunables.h>
-#include <asm/xenomai/syscall.h>
 #include <xenomai/init.h>
+
 #include "umm.h"
 #include "internal.h"
 
@@ -148,7 +149,7 @@ static void low_init(void)
 	if (__cobalt_control_bind)
 		breq.feat_req |= __xn_feat_control;
 	breq.abi_rev = XENOMAI_ABI_REV;
-	ret = XENOMAI_SYSBIND(&breq);
+	ret = XENOMAI_SYSCALL1(sc_cobalt_bind, &breq);
 
 	signal(SIGILL, old_sigill_handler);
 
diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
index dd3da0855..5858c2bf6 100644
--- a/lib/cobalt/internal.c
+++ b/lib/cobalt/internal.c
@@ -21,6 +21,8 @@
  * respect to object validity, callers have to take care of this.
  */
 
+#include <cobalt/sys/cobalt.h>
+#include <cobalt/syscall.h>
 #include <sys/types.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -29,8 +31,7 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <pthread.h>
-#include <asm/xenomai/syscall.h>
-#include <cobalt/sys/cobalt.h>
+
 #include "internal.h"
 
 int cobalt_extend(unsigned int magic)
diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 88e6e9fbf..58ff7af40 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -16,13 +16,13 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <mqueue.h>
-#include <asm/xenomai/syscall.h>
 
 /**
  * @ingroup cobalt_api
diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index 62cdb462d..d91276510 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -16,10 +16,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <errno.h>
 #include <string.h>
 #include <pthread.h>
-#include <asm/xenomai/syscall.h>
+
 #include "current.h"
 #include "internal.h"
 
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 00c1aaf4b..ba0c84823 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -17,6 +17,7 @@
   USA.
  */
 
+#include <cobalt/syscall.h>
 #include <errno.h>
 #include <string.h>
 #include <stdarg.h>
@@ -27,8 +28,6 @@
 #include <sys/socket.h>
 #include <sys/mman.h>
 #include <rtdm/rtdm.h>
-#include <cobalt/uapi/syscall.h>
-#include <asm/xenomai/syscall.h>
 
 /* support for very old c libraries not supporting O_TMPFILE */
 #ifndef O_TMPFILE
diff --git a/lib/cobalt/sched.c b/lib/cobalt/sched.c
index 6e61ee407..42662d382 100644
--- a/lib/cobalt/sched.c
+++ b/lib/cobalt/sched.c
@@ -16,11 +16,12 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <stddef.h>
 #include <errno.h>
 #include <unistd.h>
 #include <pthread.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
index be8cf34b2..997977d27 100644
--- a/lib/cobalt/select.c
+++ b/lib/cobalt/select.c
@@ -16,10 +16,10 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <errno.h>
 #include <pthread.h>
 #include <sys/select.h>
-#include <asm/xenomai/syscall.h>
 
 #if __USE_TIME_BITS64 && __TIMESIZE == 32
 /*
diff --git a/lib/cobalt/semaphore.c b/lib/cobalt/semaphore.c
index 0c1a245cd..e148f5579 100644
--- a/lib/cobalt/semaphore.c
+++ b/lib/cobalt/semaphore.c
@@ -16,13 +16,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <stdlib.h>		/* For malloc & free. */
 #include <stdarg.h>
 #include <errno.h>
 #include <fcntl.h>		/* For O_CREAT. */
 #include <pthread.h>		/* For pthread_setcanceltype. */
 #include <semaphore.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
index 6e40a3680..8d6542f81 100644
--- a/lib/cobalt/signal.c
+++ b/lib/cobalt/signal.c
@@ -16,12 +16,12 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <pthread.h>
 #include <signal.h>
-#include <asm/xenomai/syscall.h>
 
 COBALT_IMPL(int, sigwait, (const sigset_t *set, int *sig))
 {
diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
index 092cadb08..3a7a6c8ed 100644
--- a/lib/cobalt/sigshadow.c
+++ b/lib/cobalt/sigshadow.c
@@ -16,9 +16,10 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <pthread.h>
 #include <signal.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 #if !HAVE_BACKTRACE
diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index dee39a8d4..41227ba33 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <stddef.h>
 #include <string.h>
 #include <errno.h>
@@ -23,7 +24,7 @@
 #include <pthread.h>
 #include <sys/types.h>
 #include <semaphore.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index a9f91dfc9..a7e315264 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -16,9 +16,10 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <errno.h>
 #include <time.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 /**
diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index 70e9a4e07..18bca4348 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -16,10 +16,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
+#include <cobalt/syscall.h>
 #include <errno.h>
 #include <unistd.h>
 #include <sys/timerfd.h>
-#include <asm/xenomai/syscall.h>
+
 #include "internal.h"
 
 COBALT_IMPL(int, timerfd_create, (int clockid, int flags))
diff --git a/lib/cobalt/trace.c b/lib/cobalt/trace.c
index 8d9c18902..ae3933f75 100644
--- a/lib/cobalt/trace.c
+++ b/lib/cobalt/trace.c
@@ -16,11 +16,11 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
  */
 
-#include <errno.h>
-#include <stdio.h>
+#include <cobalt/syscall.h>
 #include <cobalt/uapi/kernel/trace.h>
 #include <cobalt/trace.h>
-#include <asm/xenomai/syscall.h>
+#include <errno.h>
+#include <stdio.h>
 
 int xntrace_max_begin(unsigned long v)
 {
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index b452b642b..506e9b52f 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -8,7 +8,7 @@
  *  Florian Bezdeka <florian.bezdeka@siemens.com>
  */
 
-#include <asm/xenomai/syscall.h>
+#include <cobalt/syscall.h>
 #include <smokey/smokey.h>
 #include <sys/timerfd.h>
 #include <sys/utsname.h>
diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 434004450..f7a5414cd 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -37,9 +37,9 @@
 #include <getopt.h>
 #include <asm/unistd.h>
 #include <asm/xenomai/features.h>
-#include <asm/xenomai/syscall.h>
 #include <asm/xenomai/uapi/fptest.h>
 #include <cobalt/trace.h>
+#include <cobalt/uapi/syscall.h>
 #include <rtdm/testing.h>
 #include <sys/cobalt.h>
 #include <xenomai/init.h>

-- 
2.39.5

