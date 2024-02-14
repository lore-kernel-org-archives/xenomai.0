Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C560240
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927677; cv=none; b=OtJmA7u427SlpkF1n/NH6Jwm1yw6N7j0BqiwUiHz6uwFxMyS2qXQs3Au7g4htfSwQ981IiGIlYqADExjO58mP8sbWA/S/Tv/H2yXMlYh/FdT66onxgJGOyAknyljewt1NS4xXS4XlBe8bQw5V4lb6jkIQ/lrepGmklSWoXzU4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927677; c=relaxed/simple;
	bh=8f4lhVcfdwuY3X7HXSceZwdMNbWDcTBARsxp9Xzm7WA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ItDRQd/IZ0cmggwcbBoIvAHr80CiNNQljIXFBRlThMYkHcKUz/64/Wv+nlfOZrX2Mtc/nOVwS/3LZK2MDpEkwl3/5cPJJpn9kMAfgq+OXD/Ax+A68ZOtsMTg/2Y0hT6LyI1x3ZOdnN0jBJQQkKv53SUJ2mDGN/NwShde1RKw678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=BapXF/hV; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="BapXF/hV"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202402141621041efd16bd0167484682
        for <xenomai@lists.linux.dev>;
        Wed, 14 Feb 2024 17:21:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uyuVhq5Yc+SyRIbylvW2/FyvL2MrjeI9x3dOasMsbq0=;
 b=BapXF/hVMvWvF/1iqG4si42kkOk5P+Aw/gVmaUPfMbXQB8EId+qm8DvBheopuVsUZReE7w
 rZnt4QSY7MvW399AS5RfDClUOnsQC8jd8JKyokYtALdawa6ojdf7N06bUg7I4zFmhyNZ6DDz
 V1YhLuAZD4F2+9qHmrkc8avtqqFAQ=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v3 1/6] compat support: cobalt: Move 32-bit compat files to generic
Date: Wed, 14 Feb 2024 17:20:40 +0100
Message-Id: <20240214162045.2017832-2-clara.kowalsky@siemens.com>
In-Reply-To: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
References: <20240214162045.2017832-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

In preparation for the 32-bit compat support for arm64, the compat files
from x86 are moved to the asm-generic directory. This allows us to use
these files also for arm64.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../arch/arm/include/asm/xenomai/syscall32.h  |   8 +-
 .../arm64/include/asm/xenomai/syscall32.h     |  12 ---
 .../arch/x86/include/asm/xenomai/syscall32.h  | 102 ------------------
 .../asm-generic}/xenomai/syscall32-table.h    |   6 +-
 .../include/asm-generic/xenomai/syscall32.h   |  78 +++++++++++++-
 kernel/cobalt/posix/syscall.c                 |  12 +--
 kernel/cobalt/posix/syscall.h                 |   2 +-
 kernel/cobalt/trace/cobalt-posix.h            |   4 +-
 8 files changed, 93 insertions(+), 131 deletions(-)
 delete mode 100644 kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
 delete mode 100644 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
 rename kernel/cobalt/{arch/x86/include/asm => include/asm-generic}/xenomai/syscall32-table.h (94%)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h
index 95c5a1168..11587bd71 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h
@@ -19,6 +19,12 @@
 #ifndef _COBALT_ARM_ASM_SYSCALL32_H
 #define _COBALT_ARM_ASM_SYSCALL32_H
 
-#include <asm-generic/xenomai/syscall32.h>
+#define __COBALT_CALL32_INITHAND(__handler)
+
+#define __COBALT_CALL32_INITMODE(__mode)
+
+#define __COBALT_CALL32_ENTRY(__name, __handler)
+
+#define __COBALT_CALL_COMPAT(__reg)	0
 
 #endif /* !_COBALT_ARM_ASM_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
deleted file mode 100644
index 13aa8a761..000000000
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2014 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_ARM64_SYSCALL32_H
-#define _COBALT_ARM64_SYSCALL32_H
-
-#include <asm-generic/xenomai/syscall32.h>
-
-#endif /* !_COBALT_ARM64_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
deleted file mode 100644
index f023de354..000000000
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * Copyright (C) 2014 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_X86_ASM_SYSCALL32_H
-#define _COBALT_X86_ASM_SYSCALL32_H
-
-#include <asm/unistd.h>
-
-#ifdef CONFIG_IA32_EMULATION
-
-#define __COBALT_IA32_BASE		256 /* Power of two. */
-
-#define __COBALT_SYSNR32emu(__reg)					\
-	({								\
-		long __nr = __reg;					\
-		if (in_ia32_syscall())					\
-			__nr += __COBALT_IA32_BASE;			\
-		__nr;							\
-	})
-
-#define __COBALT_COMPAT32emu(__reg)					\
-	(in_ia32_syscall() ? __COBALT_COMPAT_BIT : 0)
-
-#if __NR_COBALT_SYSCALLS > __COBALT_IA32_BASE
-#error "__NR_COBALT_SYSCALLS > __COBALT_IA32_BASE"
-#endif
-
-#define __syshand32emu__(__name)	\
-	((cobalt_syshand)(void (*)(void))(CoBaLt32emu_ ## __name))
-
-#define __COBALT_CALL32emu_INITHAND(__handler)	\
-	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
-
-#define __COBALT_CALL32emu_INITMODE(__mode)	\
-	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
-
-/* ia32 default entry (no thunk) */
-#define __COBALT_CALL32emu_ENTRY(__name, __handler)		\
-	[sc_cobalt_ ## __name + __COBALT_IA32_BASE] = __handler,
-
-/* ia32 thunk installation */
-#define __COBALT_CALL32emu_THUNK(__name)	\
-	__COBALT_CALL32emu_ENTRY(__name, __syshand32emu__(__name))
-
-/* ia32 thunk implementation. */
-#define COBALT_SYSCALL32emu(__name, __mode, __args)	\
-	long CoBaLt32emu_ ## __name __args
-
-/* ia32 thunk declaration. */
-#define COBALT_SYSCALL32emu_DECL(__name, __args)	\
-	long CoBaLt32emu_ ## __name __args
-
-#else /* !CONFIG_IA32_EMULATION */
-
-/* ia32 emulation support disabled. */
-
-#define __COBALT_SYSNR32emu(__reg)	(__reg)
-
-#define __COBALT_COMPAT32emu(__reg)	0
-
-#define __COBALT_CALL32emu_INITHAND(__handler)
-
-#define __COBALT_CALL32emu_INITMODE(__mode)
-
-#define __COBALT_CALL32emu_ENTRY(__name, __handler)
-
-#define __COBALT_CALL32emu_THUNK(__name)
-
-#define COBALT_SYSCALL32emu_DECL(__name, __args)
-
-#endif /* !CONFIG_IA32_EMULATION */
-
-#define __COBALT_CALL32_ENTRY(__name, __handler)	\
-	__COBALT_CALL32emu_ENTRY(__name, __handler)
-
-#define __COBALT_CALL32_INITHAND(__handler)	\
-	__COBALT_CALL32emu_INITHAND(__handler)
-
-#define __COBALT_CALL32_INITMODE(__mode)	\
-	__COBALT_CALL32emu_INITMODE(__mode)
-
-/* Already checked for __COBALT_SYSCALL_BIT */
-#define __COBALT_CALL32_SYSNR(__reg)	__COBALT_SYSNR32emu(__reg)
-
-#define __COBALT_CALL_COMPAT(__reg)	__COBALT_COMPAT32emu(__reg)
-
-#endif /* !_COBALT_X86_ASM_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/include/asm-generic/xenomai/syscall32-table.h
similarity index 94%
rename from kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
rename to kernel/cobalt/include/asm-generic/xenomai/syscall32-table.h
index 3d64c46a7..91a65235f 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall32-table.h
@@ -16,8 +16,8 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#ifndef _COBALT_X86_ASM_SYSCALL32_TABLE_H
-#define _COBALT_X86_ASM_SYSCALL32_TABLE_H
+#ifndef _COBALT_ASM_SYSCALL32_TABLE_H
+#define _COBALT_ASM_SYSCALL32_TABLE_H
 
 /*
  * CAUTION: This file is read verbatim into the main syscall
@@ -59,4 +59,4 @@ __COBALT_CALL32emu_THUNK(mq_timedreceive64)
 __COBALT_CALL32emu_THUNK(sigtimedwait64)
 __COBALT_CALL32emu_THUNK(recvmmsg64)
 
-#endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */
+#endif /* !_COBALT_ASM_SYSCALL32_TABLE_H */
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall32.h b/kernel/cobalt/include/asm-generic/xenomai/syscall32.h
index b0c6f4a7c..3e1fcab8f 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall32.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall32.h
@@ -19,12 +19,82 @@
 #ifndef _COBALT_ASM_GENERIC_SYSCALL32_H
 #define _COBALT_ASM_GENERIC_SYSCALL32_H
 
-#define __COBALT_CALL32_INITHAND(__handler)
+#ifdef CONFIG_XENO_ARCH_SYS3264
 
-#define __COBALT_CALL32_INITMODE(__mode)
+#define __COBALT_COMPAT32_BASE		256 /* Power of two. */
 
-#define __COBALT_CALL32_ENTRY(__name, __handler)
+#define __COBALT_SYSNR32emu(__reg)					\
+	({								\
+		long __nr = __reg;					\
+		if (in_compat_syscall())				\
+			__nr += __COBALT_COMPAT32_BASE;			\
+		__nr;							\
+	})
 
-#define __COBALT_CALL_COMPAT(__reg)	0
+#define __COBALT_COMPAT32emu(__reg)					\
+	(in_compat_syscall() ? __COBALT_COMPAT_BIT : 0)
+
+#if __NR_COBALT_SYSCALLS > __COBALT_COMPAT32_BASE
+#error "__NR_COBALT_SYSCALLS > __COBALT_COMPAT32_BASE"
+#endif
+
+#define __syshand32emu__(__name)	\
+	((cobalt_syshand)(void (*)(void))(CoBaLt32emu_ ## __name))
+
+#define __COBALT_CALL32emu_INITHAND(__handler)	\
+	[__COBALT_COMPAT32_BASE ... __COBALT_COMPAT32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
+
+#define __COBALT_CALL32emu_INITMODE(__mode)	\
+	[__COBALT_COMPAT32_BASE ... __COBALT_COMPAT32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
+
+/* compat default entry (no thunk) */
+#define __COBALT_CALL32emu_ENTRY(__name, __handler)		\
+	[sc_cobalt_ ## __name + __COBALT_COMPAT32_BASE] = __handler,
+
+/* compat thunk installation */
+#define __COBALT_CALL32emu_THUNK(__name)	\
+	__COBALT_CALL32emu_ENTRY(__name, __syshand32emu__(__name))
+
+/* compat thunk implementation. */
+#define COBALT_SYSCALL32emu(__name, __mode, __args)	\
+	long CoBaLt32emu_ ## __name __args
+
+/* compat thunk declaration. */
+#define COBALT_SYSCALL32emu_DECL(__name, __args)	\
+	long CoBaLt32emu_ ## __name __args
+
+#else /* !CONFIG_XENO_ARCH_SYS3264 */
+
+/* compat support disabled. */
+
+#define __COBALT_SYSNR32emu(__reg)	(__reg)
+
+#define __COBALT_COMPAT32emu(__reg)	0
+
+#define __COBALT_CALL32emu_INITHAND(__handler)
+
+#define __COBALT_CALL32emu_INITMODE(__mode)
+
+#define __COBALT_CALL32emu_ENTRY(__name, __handler)
+
+#define __COBALT_CALL32emu_THUNK(__name)
+
+#define COBALT_SYSCALL32emu_DECL(__name, __args)
+
+#endif /* !CONFIG_XENO_ARCH_SYS3264 */
+
+#define __COBALT_CALL32_ENTRY(__name, __handler)	\
+	__COBALT_CALL32emu_ENTRY(__name, __handler)
+
+#define __COBALT_CALL32_INITHAND(__handler)	\
+	__COBALT_CALL32emu_INITHAND(__handler)
+
+#define __COBALT_CALL32_INITMODE(__mode)	\
+	__COBALT_CALL32emu_INITMODE(__mode)
+
+/* Already checked for __COBALT_SYSCALL_BIT */
+#define __COBALT_CALL32_SYSNR(__reg)	__COBALT_SYSNR32emu(__reg)
+
+#define __COBALT_CALL_COMPAT(__reg)	__COBALT_COMPAT32emu(__reg)
 
 #endif /* !_COBALT_ASM_GENERIC_SYSCALL32_H */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 66dd1aec8..6e1f15ea5 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -371,12 +371,12 @@ static int CoBaLt_ni(void)
  * handler for a 32bit architecture), optionally followed by a set of
  * 32bit syscall entries offset by an arch-specific base index, which
  * default to the native calls. These nitty-gritty details are defined
- * by <asm/xenomai/syscall32.h>. 32bit architectures - or 64bit ones
+ * by <asm-generic/xenomai/syscall32.h>. 32bit architectures - or 64bit ones
  * for which we don't support any 32bit ABI model - will simply define
  * __COBALT_CALL32_ENTRY() as an empty macro.
  *
  * - finally, 32bit thunk entries are generated by including
- * <asm/xenomai/syscall32-table.h>, overriding the default handlers
+ * <asm-generic/xenomai/syscall32-table.h>, overriding the default handlers
  * installed during the previous step.
  *
  * For instance, with CONFIG_IA32_EMULATION support enabled in an
@@ -385,7 +385,7 @@ static int CoBaLt_ni(void)
  *
  * [sc_cobalt_mq_timedreceive] = CoBaLt_mq_timedreceive,
  * ...
- * [sc_cobalt_mq_timedreceive + __COBALT_IA32_BASE] = CoBaLt32emu_mq_timedreceive,
+ * [sc_cobalt_mq_timedreceive + __COBALT_COMPAT32_BASE] = CoBaLt32emu_mq_timedreceive,
  *
  * CoBaLt32emu_mq_timedreceive() would do the required thunking for
  * dealing with the 32<->64bit conversion of arguments. On the other
@@ -395,10 +395,10 @@ static int CoBaLt_ni(void)
  *
  * [sc_cobalt_sched_yield] = CoBaLt_sched_yield,
  * ...
- * [sc_cobalt_sched_yield + __COBALT_IA32_BASE] = CoBaLt_sched_yield,
+ * [sc_cobalt_sched_yield + __COBALT_COMPAT32_BASE] = CoBaLt_sched_yield,
  *
  * Accordingly, applications targeting the ia32 model issue syscalls
- * in the range [__COBALT_IA32_BASE..__COBALT_IA32_BASE +
+ * in the range [__COBALT_COMPAT32_BASE..__COBALT_COMPAT32_BASE +
  * __NR_COBALT_SYSCALLS-1], whilst native (32/64bit) ones issue
  * syscalls in the range [0..__NR_COBALT_SYSCALLS-1].
  *
@@ -444,7 +444,7 @@ static const cobalt_syshand cobalt_syscalls[] = {
 	__COBALT_CALL_NI
 	__COBALT_CALL_ENTRIES
 #ifdef CONFIG_XENO_ARCH_SYS3264
-#include <asm/xenomai/syscall32-table.h>
+#include <asm-generic/xenomai/syscall32-table.h>
 #endif
 };
 
diff --git a/kernel/cobalt/posix/syscall.h b/kernel/cobalt/posix/syscall.h
index 3a4c98d7a..e43f8d991 100644
--- a/kernel/cobalt/posix/syscall.h
+++ b/kernel/cobalt/posix/syscall.h
@@ -30,7 +30,7 @@ struct pt_regs;
 #define COBALT_SYSCALL_DECL(__name, __args)	\
 	long CoBaLt_ ## __name __args
 
-#include <asm/xenomai/syscall32.h>
+#include <asm-generic/xenomai/syscall32.h>
 
 int handle_head_syscall(bool caller_is_relaxed,
 			struct pt_regs *regs);
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 1c9302324..fc8e72e39 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -42,8 +42,8 @@
 #define __timespec_args(__name)					\
 	(long long)__entry->tv_sec_##__name, __entry->tv_nsec_##__name
 
-#ifdef CONFIG_IA32_EMULATION
-#define __sc_compat(__name)	, { sc_cobalt_##__name + __COBALT_IA32_BASE, "compat-" #__name }
+#ifdef CONFIG_XENO_ARCH_SYS3264
+#define __sc_compat(__name)	, { sc_cobalt_##__name + __COBALT_COMPAT32_BASE, "compat-" #__name }
 #else
 #define __sc_compat(__name)
 #endif
-- 
2.39.2

