Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11033F8E1
	for <xenomai@lists.linux.dev>; Mon, 22 Jan 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939913; cv=none; b=J3TqRLLjsFPQWSonip4uG50voSJ2FoQcnXEMrKMnkAQOSKE/zzBkk/2kKPoXKMwk0NCxg+TC6IONvUhsphBqtvP3j3HNhxl9dMrWFzt1jWf0kc1XYXni47vS2AefAL0Wqw1n/eoc32r3v5AtQooTKGHzosRQ8b50xKgTLaU6rjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939913; c=relaxed/simple;
	bh=pG1bQwNiCvzX56agkSy3SN9ouHc+ggsNnviCx2EMYOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ahTzUCgY+LBuh1jschSoJW8VRaZlt8VU1hi9a1TCDYV4oKipCOEjkCDb/nkkHzsQ1kGw2PDTyBYcueXc74Makuklph+giiyTWItUqmYnpqaRYPDm+cQ9ZvhX50gnECQ7PwASuiVn8FAZyXsKGVFmSS1UrrGkHqZSNMZPcM3WsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=PURPG9M8; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="PURPG9M8"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024012216013708a9102ff6e99965e3
        for <xenomai@lists.linux.dev>;
        Mon, 22 Jan 2024 17:01:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xNH90aAzXcRqOiEVi0fJUGlM2SRx2Tea4weFex/SNls=;
 b=PURPG9M8+ks3027LgEQGDMT9Dd1RuGXJXnUHXXCywM7S+dOWtxGXaEjrpMrJuGwL1mWXjQ
 hMD/HhCYYZ2ZP5EqzmrvwGzyQPF0ASeTY1lhRPHexCRpuZfOvQ/s9v0jo5AcIF04wxi9HcIK
 /HxRlXw18XKyf8Uly7l0Q2J1M/xik=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v1 2/7] compat support: cobalt/arm: Refactor registers
Date: Mon, 22 Jan 2024 17:01:00 +0100
Message-Id: <20240122160105.2452024-3-clara.kowalsky@siemens.com>
In-Reply-To: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
References: <20240122160105.2452024-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

For EABI, the syscall number has to be loaded into r7.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../arch/arm/include/asm/xenomai/syscall.h    |  4 +-
 .../arch/arm/include/asm/xenomai/syscall.h    | 65 +++++++++----------
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 172197725..a46f0e94b 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -44,8 +44,8 @@
  * Dovetail abides by, with the actual syscall number into r7 ORed
  * with __OOB_SYSCALL_BIT, freeing r0 for passing a call argument.
  */
-#define __xn_reg_sys(__regs)	((__regs)->ARM_ORIG_r0)
-#define __xn_syscall_p(__regs)	(((__regs)->ARM_r7 & ~__COBALT_SYSCALL_BIT) == XENO_ARM_SYSCALL)
+#define __xn_reg_sys(__regs)	((__regs)->ARM_r7)
+#define __xn_syscall_p(__regs)	((__regs)->ARM_r7 & __COBALT_SYSCALL_BIT)
 #define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
 
 /*
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 864330490..105bf9faf 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -37,62 +37,61 @@
 #error TLS support (__thread) is broken with GCC >= 4.3, use --disable-tls when configuring
 #endif
 
-#define LOADARGS_0(syscode, dummy...)	\
-	__a0 = (unsigned long) (syscode)
+#define LOADARGS_0(syscode, arg1...)
 #define LOADARGS_1(syscode, arg1)	\
-	LOADARGS_0(syscode);		\
-	__a1 = (unsigned long) (arg1)
+	LOADARGS_0(syscode, arg1);	\
+	__a0 = (unsigned long) (arg1)
 #define LOADARGS_2(syscode, arg1, arg2)	\
 	LOADARGS_1(syscode, arg1);	\
-	__a2 = (unsigned long) (arg2)
+	__a1 = (unsigned long) (arg2)
 #define LOADARGS_3(syscode, arg1, arg2, arg3)	\
 	LOADARGS_2(syscode,  arg1, arg2);	\
-	__a3 = (unsigned long) (arg3)
+	__a2 = (unsigned long) (arg3)
 #define LOADARGS_4(syscode,  arg1, arg2, arg3, arg4)	\
 	LOADARGS_3(syscode,  arg1, arg2, arg3);		\
-	__a4 = (unsigned long) (arg4)
+	__a3 = (unsigned long) (arg4)
 #define LOADARGS_5(syscode, arg1, arg2, arg3, arg4, arg5)	\
 	LOADARGS_4(syscode, arg1, arg2, arg3, arg4);		\
-	__a5 = (unsigned long) (arg5)
+	__a4 = (unsigned long) (arg5)
 
-#define CLOBBER_REGS_0 "r0"
-#define CLOBBER_REGS_1 CLOBBER_REGS_0, "r1"
-#define CLOBBER_REGS_2 CLOBBER_REGS_1, "r2"
-#define CLOBBER_REGS_3 CLOBBER_REGS_2, "r3"
-#define CLOBBER_REGS_4 CLOBBER_REGS_3, "r4"
-#define CLOBBER_REGS_5 CLOBBER_REGS_4, "r5"
+#define CLOBBER_REGS_0
+#define CLOBBER_REGS_1 "r0"
+#define CLOBBER_REGS_2 CLOBBER_REGS_1, "r1"
+#define CLOBBER_REGS_3 CLOBBER_REGS_2, "r2"
+#define CLOBBER_REGS_4 CLOBBER_REGS_3, "r3"
+#define CLOBBER_REGS_5 CLOBBER_REGS_4, "r4"
 
-#define LOADREGS_0 __r0 = __a0
-#define LOADREGS_1 LOADREGS_0; __r1 = __a1
-#define LOADREGS_2 LOADREGS_1; __r2 = __a2
-#define LOADREGS_3 LOADREGS_2; __r3 = __a3
-#define LOADREGS_4 LOADREGS_3; __r4 = __a4
-#define LOADREGS_5 LOADREGS_4; __r5 = __a5
+#define LOADREGS_0
+#define LOADREGS_1 __r0 = __a0
+#define LOADREGS_2 LOADREGS_1; __r1 = __a1
+#define LOADREGS_3 LOADREGS_2; __r2 = __a2
+#define LOADREGS_4 LOADREGS_3; __r3 = __a3
+#define LOADREGS_5 LOADREGS_4; __r4 = __a4
 
 #define ASM_INDECL_0							\
-	unsigned long __a0; register unsigned long __r0  __asm__ ("r0");
+	register unsigned long __r0  __asm__ ("r0");
 #define ASM_INDECL_1 ASM_INDECL_0;					\
-	unsigned long __a1; register unsigned long __r1  __asm__ ("r1")
+	unsigned long __a0;
 #define ASM_INDECL_2 ASM_INDECL_1;					\
-	unsigned long __a2; register unsigned long __r2  __asm__ ("r2")
+	unsigned long __a1; register unsigned long __r1  __asm__ ("r1")
 #define ASM_INDECL_3 ASM_INDECL_2;					\
-	unsigned long __a3; register unsigned long __r3  __asm__ ("r3")
+	unsigned long __a2; register unsigned long __r2  __asm__ ("r2")
 #define ASM_INDECL_4 ASM_INDECL_3;					\
-	unsigned long __a4; register unsigned long __r4  __asm__ ("r4")
+	unsigned long __a3; register unsigned long __r3  __asm__ ("r3")
 #define ASM_INDECL_5 ASM_INDECL_4;					\
-	unsigned long __a5; register unsigned long __r5  __asm__ ("r5")
+	unsigned long __a4; register unsigned long __r4  __asm__ ("r4")
 
-#define ASM_INPUT_0 "0" (__r0)
-#define ASM_INPUT_1 ASM_INPUT_0, "r" (__r1)
-#define ASM_INPUT_2 ASM_INPUT_1, "r" (__r2)
-#define ASM_INPUT_3 ASM_INPUT_2, "r" (__r3)
-#define ASM_INPUT_4 ASM_INPUT_3, "r" (__r4)
-#define ASM_INPUT_5 ASM_INPUT_4, "r" (__r5)
+#define ASM_INPUT_0 "r" (__r7)
+#define ASM_INPUT_1 ASM_INPUT_0, "0" (__r0)
+#define ASM_INPUT_2 ASM_INPUT_1, "r" (__r1)
+#define ASM_INPUT_3 ASM_INPUT_2, "r" (__r2)
+#define ASM_INPUT_4 ASM_INPUT_3, "r" (__r3)
+#define ASM_INPUT_5 ASM_INPUT_4, "r" (__r4)
 
 #define XENOMAI_DO_SYSCALL(nr, op, args...)				\
 	({								\
 		ASM_INDECL_##nr;					\
-		unsigned long __r7 = XENO_ARM_SYSCALL;			\
+		unsigned long __r7 = __xn_syscode(op);			\
 		LOADARGS_##nr(__xn_syscode(op), args);			\
 		__asm__ __volatile__ ("" : /* */ : /* */ :		\
 				      CLOBBER_REGS_##nr);		\
-- 
2.39.2

