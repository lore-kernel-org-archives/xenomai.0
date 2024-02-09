Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367493172D
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479476; cv=none; b=coEw41rLb/n7wVAZYryQJ5M3EJfXjIKoXsZ9Q5APZowji/afmeiS3+n0hXZIBnu9M337JgjVeNpV7P8JmjKNYkBF/A+AFMt8fg4cNr97Pv+DUqZ8QF3Uycga9CowUBTubz1vz9S7dGjDJ6F3AMtxltVqQiloFl6d+3FJtj0cs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479476; c=relaxed/simple;
	bh=oGi64BmjvAdE0DOGjMeiQ1aMX2d3kE1TR5Vc9V1kysg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sb+w5R6nBFU0qLThkW06n7Bw3nv3+oPZ42lQ8g+/8tYd6UQBBxLZgoDWTqG/XDSDSpA9lTG6TQLLxj3q4nzxlR9ZfOkQ0V6gBYzMy6KbXqi1BtMzQI6bXRB/PqGVw8trVNO6J3zSPi9s3R3lKFAdApcFdVrwoKMvz0yNznA3698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=Dh+F5G4/; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="Dh+F5G4/"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024020911511060ce91b5c11e1f0008
        for <xenomai@lists.linux.dev>;
        Fri, 09 Feb 2024 12:51:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pHysrua/GrthnMnr7ysaRkFBBjKFKTYxIFAT1dhet+U=;
 b=Dh+F5G4/0uXtwZUrXfObjkzslbJ5/0JTwLtgqNr81wM6dCDXNEL3qjQqj2tFwAladS2KgB
 JCt/TbIw2uIwcbwUYTUgFVrASA4ejoVvbRwptGxP+r2qaPGI8psGMiIh97VhowgsVDFVPdMS
 KLoGU8d4mYZ4IiGUUtMnQlQ8RNNhk=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 2/7] compat support: cobalt/arm: Refactor registers for arm alignment
Date: Fri,  9 Feb 2024 12:50:20 +0100
Message-Id: <20240209115025.1884451-3-clara.kowalsky@siemens.com>
In-Reply-To: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
References: <20240209115025.1884451-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

So far, the syscall number for arm is loaded in ARM_ORIG_r0 and ARM_r7
contains the syscall marker XENO_ARM_SYSCALL.
An alignment change is now made with respect to the arm EABI convention
such that ARM_r7 holds the syscall number and therefore r0 to r6 can be
used normally as arguments.
The now unused XENO_ARM_SYSCALL is removed.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../arch/arm/include/asm/xenomai/syscall.h    | 14 ++--
 .../arm/include/asm/xenomai/uapi/syscall.h    |  2 -
 .../arch/arm/include/asm/xenomai/syscall.h    | 65 +++++++++----------
 3 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 172197725..0ecf56ce3 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -29,13 +29,11 @@
 #include <asm-generic/xenomai/syscall.h>
 
 /*
- * Cobalt syscall numbers can be fetched from ARM_ORIG_r0 with ARM_r7
- * containing the Xenomai syscall marker, Linux syscalls directly from
+ * Cobalt syscall and Linux syscall numbers can be fetched directly from
  * ARM_r7. Since we have to work with Dovetail whilst remaining binary
- * compatible with applications built for the I-pipe, we retain the
- * old syscall signature based on receiving XENO_ARM_SYSCALL in
- * ARM_r7, possibly ORed with __COBALT_SYSCALL_BIT by Dovetail
- * (IPIPE_COMPAT mode).
+ * compatible with applications built for the I-pipe, the syscall signature
+ * is possibly ORed with __COBALT_SYSCALL_BIT by Dovetail (IPIPE_COMPAT
+ * mode).
  *
  * FIXME: We also have __COBALT_SYSCALL_BIT (equal to
  * __OOB_SYSCALL_BIT) present in the actual syscall number in r0,
@@ -44,8 +42,8 @@
  * Dovetail abides by, with the actual syscall number into r7 ORed
  * with __OOB_SYSCALL_BIT, freeing r0 for passing a call argument.
  */
-#define __xn_reg_sys(__regs)	((__regs)->ARM_ORIG_r0)
-#define __xn_syscall_p(__regs)	(((__regs)->ARM_r7 & ~__COBALT_SYSCALL_BIT) == XENO_ARM_SYSCALL)
+#define __xn_reg_sys(__regs)	((__regs)->ARM_r7)
+#define __xn_syscall_p(__regs)	((__regs)->ARM_r7 & __COBALT_SYSCALL_BIT)
 #define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
 
 /*
diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
index c079a358c..c9561e030 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/syscall.h
@@ -23,8 +23,6 @@
 
 #define __xn_syscode(__nr)	(__COBALT_SYSCALL_BIT | (__nr))
 
-#define XENO_ARM_SYSCALL        0x000F0042	/* carefully chosen... */
-
 #define XENOMAI_SYSARCH_TSCINFO      4
 
 #endif /* !_COBALT_ARM_ASM_UAPI_SYSCALL_H */
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

