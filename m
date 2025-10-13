Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C92BE7B5
	for <xenomai@lists.linux.dev>; Mon, 13 Oct 2025 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374875; cv=none; b=nSm6hqCkFDFxFKCtsOfmchBjr6RU5TVOwbOwXo7jTC+cEplGCjgCgrp1wbH2Kz9shEWkvVJNWH+XF2m7Wf53bTAjVZU6ZI5pvR7HMCErk5feza9lmTXYU2CVLSIYxaQrBkAoWKNQT9CgGBjNiReu4sh8TjPIK7a0k9jE41OLVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374875; c=relaxed/simple;
	bh=m1NMRNqihVKbruLdc/8b4+arizqHeC/CoKtgCCQDKQM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugKifk3TqrQx4pUx9NwXuksn/TUxZs5SdXOqZ+PfJDPswijaHMrOScSUAjFOYW5qjkiVuZ/U4yphXms+mrZIWP5XccW5phwUx+tOwSY4YL6EfClgqW7qY4rpwLMVLRvtuTTatHhUtqPh8stJV5Z5R36awS06frve0ZCn+czeFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ACayGQhW; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ACayGQhW"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025101317010028110254c800020778
        for <xenomai@lists.linux.dev>;
        Mon, 13 Oct 2025 19:01:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/Klp/RxQE/AdApolJMufV97oaehqQuZpQK+LPi6pjV4=;
 b=ACayGQhWe00ARtkyZW955b26cxizy4aRT4g/bn8Y6NaHFrvdn6VQtUSmXlJtlHnJjOkOxY
 XpUB6Yva+j55LjCxYWrutLpzq4v8B5p1kJGRKiXm4FpdzC/1VGlwx3RBzvCQJjh8NNd9KUpC
 q1sZdxCfS0YgeRYiR+fVlddxow2duMiUpmOJjlY5wjQwXHspIqpsqwr3h9TyNDbN717pJUKB
 /W/PGTOKZ80alZg+XO8ymnSpGmB4e5QTQSrKmX8incAnAd17s+ymxbIr8i3HOafNhuLmK902
 SOG8A2IKumVd2qmTBwyq63AtCO/7kg7YKVDdCF4cLMB5g7NFZcK8X1sg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 2/6] lib/cobalt: arm: Avoid thumb mode in syscall-issuing modules
Date: Mon, 13 Oct 2025 19:00:56 +0200
Message-ID: <b2aa6e5eb2bf3b7357239aae8d55289f0baac9a8.1760374860.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
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

In 4abd59b4e3e4, we noticed the clash between r7 usage for setting up
Xenomai syscalls and the compiler suddenly refusing this. What we was
not clear at that point was the origin of the clash: if the compiler
is configured to prefer thumb mode over regular 32-bit ARM instructions,
it also starts to claim r7 as frame pointer.

Now, the solution taken back then turned out to have a problem: It broke
stack unwinding. That is not only an issue when debugging, it is
actually required for pthread_cancel and pthread_exit. The glibc will
use unwinding to call destructors of the terminating context to call
them before shutting down. This broke when we were inside a syscall
because r7 was then pointing to the syscall number.

Most glibc versions detected the broken call chain and simply skipped
the destructors - which was still a problem, just unnoticed. But with
recent glibc from trixie, we are now even crashing while unwinding, and
that is even less acceptable.

We could now either use the pattern of glibc to push the syscall
invocation into an assembly function - or simply enforce ARM mode for
libcobalt so that r7 become usable again. Take the latter approach as it
is leaner.

Fixes: 4abd59b4e3e4 ("lib/cobalt: arm: Account for register allocation clash")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configure.ac                                    |  1 +
 .../arch/arm/include/asm/xenomai/syscall.h      | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index a28d80a5e0..c1214bda88 100644
--- a/configure.ac
+++ b/configure.ac
@@ -937,6 +937,7 @@ if test $rtcore_type = cobalt; then
    XENO_COBALT_CFLAGS="$XENO_USER_CFLAGS"
    case "$build_for" in
     i*86*-*) XENO_COBALT_CFLAGS="$XENO_COBALT_CFLAGS -fno-omit-frame-pointer";;
+    arm*-*) XENO_COBALT_CFLAGS="$XENO_COBALT_CFLAGS -marm";;
     esac
 
 dnl Build wrapping information. XENO_POSIX_WRAPPERS lists all wrapping
diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 105bf9faf1..1fc605b1ba 100644
--- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -29,6 +29,10 @@
 #error "ARM OABI support has been removed with Xenomai 3.3.x"
 #endif
 
+#ifdef __thumb__
+#error "Xenomai syscalls cannot be issued in Thumb mode"
+#endif
+
 /*
  * Some of the following macros have been adapted from Linux's
  * implementation of the syscall mechanism in <asm-arm/unistd.h>:
@@ -54,8 +58,8 @@
 	LOADARGS_4(syscode, arg1, arg2, arg3, arg4);		\
 	__a4 = (unsigned long) (arg5)
 
-#define CLOBBER_REGS_0
-#define CLOBBER_REGS_1 "r0"
+#define CLOBBER_REGS_0 "r7"
+#define CLOBBER_REGS_1 CLOBBER_REGS_0, "r0"
 #define CLOBBER_REGS_2 CLOBBER_REGS_1, "r1"
 #define CLOBBER_REGS_3 CLOBBER_REGS_2, "r2"
 #define CLOBBER_REGS_4 CLOBBER_REGS_3, "r3"
@@ -69,7 +73,8 @@
 #define LOADREGS_5 LOADREGS_4; __r4 = __a4
 
 #define ASM_INDECL_0							\
-	register unsigned long __r0  __asm__ ("r0");
+	register unsigned long __r0  __asm__ ("r0");			\
+	register unsigned long __r7  __asm__ ("r7");
 #define ASM_INDECL_1 ASM_INDECL_0;					\
 	unsigned long __a0;
 #define ASM_INDECL_2 ASM_INDECL_1;					\
@@ -91,15 +96,15 @@
 #define XENOMAI_DO_SYSCALL(nr, op, args...)				\
 	({								\
 		ASM_INDECL_##nr;					\
-		unsigned long __r7 = __xn_syscode(op);			\
 		LOADARGS_##nr(__xn_syscode(op), args);			\
 		__asm__ __volatile__ ("" : /* */ : /* */ :		\
 				      CLOBBER_REGS_##nr);		\
 		LOADREGS_##nr;						\
+		__r7 = __xn_syscode(op);				\
 		__asm__ __volatile__ (					\
-			"push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"	\
+			"swi 0"						\
 			: "=r" (__r0)					\
-			: ASM_INPUT_##nr, [__r7] "r" (__r7)		\
+			: ASM_INPUT_##nr, "r" (__r7)			\
 			: "memory");					\
 		(int) __r0;						\
 	})
-- 
2.51.0

