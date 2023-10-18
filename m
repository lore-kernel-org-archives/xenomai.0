Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA748156E9
	for <xenomai@lists.linux.dev>; Wed, 18 Oct 2023 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="lPix1+9A"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202310180818164b1bd5044d86409012
        for <xenomai@lists.linux.dev>;
        Wed, 18 Oct 2023 10:18:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=l4LABn8CSx0T9EUq7vzbYuHb/5nGLFIYNYqSaQ6QAuM=;
 b=lPix1+9Az1PWd8yPheR2boMptNXsZ2XTqZmdIGxfBgM44VNxjIcCmjUKjRUxAOrt+rqq29
 ynMGnX4lYbgo6bTFhMPrC3P5znUMCucOFbAAwYH6H/TrUbnhvMEHm5WZKPda80cZueZfQQ/t
 TocvpYxvYinOWN12iLNEyy4LFVB7s=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [RFC PATCH v1] cobalt/arm: Remove arm OABI support
Date: Wed, 18 Oct 2023 10:18:03 +0200
Message-Id: <20231018081803.298461-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

As OABI is marked as obsolete since gcc > 4.6.4 (~2013) and Debian
stopped shipping OABI toolchains long time ago, OABI support is dropped
from Xenomai. Therefore, the kernel option OABI_COMPAT should not be
used anymore.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 doc/asciidoc/TROUBLESHOOTING.COBALT.adoc      |  9 +++----
 .../arch/arm/include/asm/xenomai/syscall.h    | 24 ++++++-------------
 2 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
index 778e74f96..14a4d53c6 100644
--- a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
+++ b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
@@ -219,12 +219,9 @@ support.
 
 Although the program in question may be present, this message may
 happen on ARM platforms when a mismatch exists between the kernel and
-user library configurations with respect to EABI support. Typically,
-if user libraries are compiled with a toolchain generating OABI code,
-the result won't run over a kernel not enabling the
-+CONFIG_OABI_COMPAT+ option. Conversely, the product of a compilation
-with an EABI toolchain won't run on a kernel not enabling the
-+CONFIG_AEABI+ option.
+user library configurations with respect to EABI support. The product
+of a compilation with an EABI toolchain won't run on a kernel not
+enabling the +CONFIG_AEABI+ option.
 
 === incompatible feature set
 
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 0941e6c84..864330490 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -25,6 +25,10 @@
 #include <errno.h>
 #include <cobalt/uapi/syscall.h>
 
+#ifndef __ARM_EABI__
+#error "ARM OABI support has been removed with Xenomai 3.3.x"
+#endif
+
 /*
  * Some of the following macros have been adapted from Linux's
  * implementation of the syscall mechanism in <asm-arm/unistd.h>:
@@ -85,32 +89,18 @@
 #define ASM_INPUT_4 ASM_INPUT_3, "r" (__r4)
 #define ASM_INPUT_5 ASM_INPUT_4, "r" (__r5)
 
-#define __sys2(x)	#x
-#define __sys1(x)	__sys2(x)
-
-#ifdef __ARM_EABI__
-#define __SYS_REG_DECL unsigned long __r7 = XENO_ARM_SYSCALL
-#define __SYS_REG_INPUT , [__r7] "r" (__r7)
-#define __SYS_CALLOP "push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"
-#else
-#define __SYS_REG_DECL
-#define __SYS_REG_INPUT
-#define __NR_OABI_SYSCALL_BASE	0x900000
-#define __SYS_CALLOP "swi\t" __sys1(__NR_OABI_SYSCALL_BASE + XENO_ARM_SYSCALL) ""
-#endif
-
 #define XENOMAI_DO_SYSCALL(nr, op, args...)				\
 	({								\
 		ASM_INDECL_##nr;					\
-		__SYS_REG_DECL;						\
+		unsigned long __r7 = XENO_ARM_SYSCALL;			\
 		LOADARGS_##nr(__xn_syscode(op), args);			\
 		__asm__ __volatile__ ("" : /* */ : /* */ :		\
 				      CLOBBER_REGS_##nr);		\
 		LOADREGS_##nr;						\
 		__asm__ __volatile__ (					\
-			__SYS_CALLOP					\
+			"push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"	\
 			: "=r" (__r0)					\
-			: ASM_INPUT_##nr __SYS_REG_INPUT		\
+			: ASM_INPUT_##nr, [__r7] "r" (__r7)		\
 			: "memory");					\
 		(int) __r0;						\
 	})
-- 
2.39.2

