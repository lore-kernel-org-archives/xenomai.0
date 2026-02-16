Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D1301704
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239543; cv=none; b=EE0GB0lFAxz88TvLjuVjWzC+mMsICk0K6TrgBZZDgWC84wCV39qA4Id7I+/flvjC9WwrpGCIHdeEmZfIetIuq31iFtPx1gscG2t8vFJhiCfI4Xdtuv5aWEN8M8M1MANNPO3d0id8elWzCRG5R/WX4lkTz2VT6w2Xpo4r0ZzFNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239543; c=relaxed/simple;
	bh=MW3Y/WtfB/p95cGESjpt5lkE4j1y72PciyLZXm7AUeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiF0jEqSUY+agP5sVlAU+h+kXbPa8XmSTHdeS7cm/PzFkD1WN8qPnqaZ/M5W8mFu9BKeMUXUxwg/DdJE0u0rbQ54NB4kyDSI/JeLkuELeRexH4Oes9i+YRhQRiW53MJ/ete53d+DYbZE27oZ3B9oZKSLmK2IEwmFJw0I877Edug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=EdTxZhCb; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="EdTxZhCb"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260216105857e403d11f0c0002070e
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 11:58:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3RFDc5OQILV3witAQ7WT/zvPQEyT+T2XEvyBvhgjJVM=;
 b=EdTxZhCbjV6R+N3MaPtWw5ZTWshlq3Pilos66AgIM2AxToWz8uEtYHcJEr5u2vGHanwEik
 da4puPbNe/bJRWqYLY1IPfr/pD+V4ZrSWBljC1zPgdHHfmnYn0jVtdvG0+8Cd1BS1t1eHkMQ
 RPqCc/tvKBXhg7/IjVT6wQoC7TBiAqB4vspJgPkdPnMH6RjfwDbDXffabKkolhVKMIc03at+
 HYSrovHhUZju0KN1o7t+PlfeVpiMF54xB/3t96iVvczKYaR9uGis/8FXfibmbLW08yf99I9/
 gMCx0X2v0ZTdTIT+r/niHwbzL/LuBhVffBw+4k/As416GpeasEzFnoeg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 16 Feb 2026 11:58:53 +0100
Subject: [PATCH 3/3] testsuite/switchtest: Add support for Dovetail >= 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-wip-flo-prepare-for-6-19-v1-3-f7362cdd2532@siemens.com>
References: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
In-Reply-To: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The background for this reworking is a recent change to Linux in 6.19:

commit 4fa617cc6851 ("arm64/fpsimd: Allocate kernel mode FP/SIMD
		     buffers on the stack")

expects all (non-preemtable) users to provide a buffer that is used
in case the calling task is scheduled out. NULL is only allowed when
preemption is disabled.

preempt_disable() has no impact on OOB tasks, so when an OOB task is
scheduled out the fpsimd code tries to save the FPU regs to NULL, which
(obviously) triggered a fault.

To be able to provide a struct user_fpsimd_state located on the stack
the complete FPU usage has to move into one function, now called
arch_cobalt_in_kernel_fpu_usage() and implemented by all architectures.
arm64 needs two implementations to stay compatible with older kernels.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../cobalt/arch/arm/include/asm/xenomai/fptest.h   | 26 ++++---------
 .../cobalt/arch/arm64/include/asm/xenomai/fptest.h | 43 ++++++++++++++++++----
 .../cobalt/arch/x86/include/asm/xenomai/fptest.h   | 41 ++++++++++++---------
 kernel/drivers/testing/switchtest.c                | 19 +++-------
 4 files changed, 70 insertions(+), 59 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
index fc177fcb53bd259011a4a65f889c236f7c8e115e..f9f61109db07351283612f6e3a69a179c0a51e34 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
@@ -19,29 +19,17 @@
 #ifndef _COBALT_ARM_FPTEST_H
 #define _COBALT_ARM_FPTEST_H
 
-#include <linux/errno.h>
-#include <asm/hwcap.h>
-
-#ifdef CONFIG_VFP
-#define have_vfp (elf_hwcap & HWCAP_VFP)
-#else /* !CONFIG_VFP */
-#define have_vfp 0
-#endif /* !CONFIG_VFP */
-
-#include <asm/xenomai/uapi/fptest.h>
-
-static inline int fp_linux_begin(void)
-{
-	return -ENOSYS;
-}
-
-static inline void fp_linux_end(void)
+static inline int cobalt_arch_fp_detect(void)
 {
+	/* armhf: in-kernel-fpu-usage does not support preemption */
+	return 0;
 }
 
-static inline int fp_detect(void)
+static inline unsigned int
+cobalt_arch_in_kernel_fpu_usage(unsigned int expected, rtdm_event_t *rt_synch,
+				int (*report)(const char *fmt, ...))
 {
-	return have_vfp ? __COBALT_HAVE_VFP : 0;
+	return 0;
 }
 
 #endif /* _COBALT_ARM_FPTEST_H */
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
index 520cd38519db66ad25baecedd183d56f92895539..e7f12a9c065a8d239488d90937dac4739c17bdeb 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
@@ -13,21 +13,48 @@
 
 #define have_fp (ELF_HWCAP & HWCAP_FP)
 
-static inline int fp_linux_begin(void)
+static inline int cobalt_arch_fp_detect(void)
 {
-	kernel_neon_begin();
-
-	return 0;
+	return have_fp ? __COBALT_HAVE_FPU : 0;
 }
 
-static inline void fp_linux_end(void)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
+static inline unsigned int
+cobalt_arch_in_kernel_fpu_usage(unsigned int expected, rtdm_event_t *rt_synch,
+				int (*report)(const char *fmt, ...))
 {
+	int features = cobalt_arch_fp_detect();
+	unsigned int fp_val;
+
+	kernel_neon_begin();
+
+	fp_regs_set(features, expected);
+	rtdm_event_signal(rt_synch);
+	fp_val = fp_regs_check(features, expected, report);
+
 	kernel_neon_end();
-}
 
-static inline int fp_detect(void)
+	return fp_val;
+}
+# else
+static inline unsigned int
+cobalt_arch_in_kernel_fpu_usage(unsigned int expected, rtdm_event_t *rt_synch,
+				int (*report)(const char *fmt, ...))
 {
-	return have_fp ? __COBALT_HAVE_FPU : 0;
+	int features = cobalt_arch_fp_detect();
+	struct user_fpsimd_state fpu_state;
+	unsigned int fp_val;
+
+	kernel_neon_begin(&fpu_state);
+
+	fp_regs_set(features, expected);
+	rtdm_event_signal(rt_synch);
+	fp_val = fp_regs_check(features, expected, report);
+
+	kernel_neon_end(&fpu_state);
+
+	return fp_val;
 }
+#endif
 
 #endif /* !_COBALT_ARM64_FPTEST_H */
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
index 55818f853c2407eef40f3d1d9a1336bfa7605512..bbb7f3e5f3f9d09ebaf78499a07cc4e48c6dea0f 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
@@ -19,13 +19,30 @@
 #ifndef _COBALT_X86_ASM_FPTEST_H
 #define _COBALT_X86_ASM_FPTEST_H
 
-#include <linux/errno.h>
 #include <asm/processor.h>
 #include <asm/xenomai/wrappers.h>
 #include <asm/xenomai/uapi/fptest.h>
 
-static inline int fp_linux_begin(void)
+static inline int cobalt_arch_fp_detect(void)
 {
+	int features = 0;
+
+	if (boot_cpu_has(X86_FEATURE_XMM2))
+		features |= __COBALT_HAVE_SSE2;
+
+	if (boot_cpu_has(X86_FEATURE_AVX))
+		features |= __COBALT_HAVE_AVX;
+
+	return features;
+}
+
+static inline unsigned int
+cobalt_arch_in_kernel_fpu_usage(unsigned int expected, rtdm_event_t *rt_synch,
+				int (*report)(const char *fmt, ...))
+{
+	int features = cobalt_arch_fp_detect();
+	unsigned int fp_val;
+
 	kernel_fpu_begin();
 	/*
 	 * We need a clean context for testing the sanity of the FPU
@@ -35,25 +52,13 @@ static inline int fp_linux_begin(void)
 	 */
 	asm volatile("fninit");
 
-	return true;
-}
+	fp_regs_set(features, expected);
+	rtdm_event_signal(rt_synch);
+	fp_val = fp_regs_check(features, expected, report);
 
-static inline void fp_linux_end(void)
-{
 	kernel_fpu_end();
-}
 
-static inline int fp_detect(void)
-{
-	int features = 0;
-
-	if (boot_cpu_has(X86_FEATURE_XMM2))
-		features |= __COBALT_HAVE_SSE2;
-
-	if (boot_cpu_has(X86_FEATURE_AVX))
-		features |= __COBALT_HAVE_AVX;
-
-	return features;
+	return fp_val;
 }
 
 #endif /* _COBALT_X86_ASM_FPTEST_H */
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index f8f6c892076bba729d5d4b536288574df431e344..4a5d2bee7fe4f7ef265e2932e202ef4d8949496a 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -62,8 +62,6 @@ struct rtswitch_context {
 	rtdm_nrtsig_t wake_utask;
 };
 
-static int fp_features;
-
 static int report(const char *fmt, ...)
 {
 	va_list ap;
@@ -276,7 +274,7 @@ static int rtswitch_to_nrt(struct rtswitch_context *ctx,
 
 		case RTSWITCH_RT:
 
-			if (!fp_check || fp_linux_begin() < 0) {
+			if (!fp_check || !cobalt_arch_fp_detect()) {
 				fp_check = 0;
 				goto signal_nofp;
 			}
@@ -284,10 +282,8 @@ static int rtswitch_to_nrt(struct rtswitch_context *ctx,
 			expected = from_idx + 500 +
 				(ctx->switches_count % 4000000) * 1000;
 
-			fp_regs_set(fp_features, expected);
-			rtdm_event_signal(&to->rt_synch);
-			fp_val = fp_regs_check(fp_features, expected, report);
-			fp_linux_end();
+			fp_val = cobalt_arch_in_kernel_fpu_usage(
+				expected, &to->rt_synch, report);
 
 			if(down_interruptible(&from->nrt_synch))
 				return -EINTR;
@@ -308,11 +304,8 @@ static int rtswitch_to_nrt(struct rtswitch_context *ctx,
 				(ctx->switches_count % 4000000) * 1000;
 			barrier();
 
-			fp_linux_begin();
-			fp_regs_set(fp_features, expected);
-			rtdm_event_signal(&to->rt_synch);
-			fp_val = fp_regs_check(fp_features, expected, report);
-			fp_linux_end();
+			fp_val = cobalt_arch_in_kernel_fpu_usage(
+				expected, &to->rt_synch, report);
 
 			if (down_interruptible(&from->nrt_synch))
 				return -EINTR;
@@ -725,8 +718,6 @@ static struct rtdm_device device = {
 
 static int __init __switchtest_init(void)
 {
-	fp_features = fp_detect();
-
 	return rtdm_dev_register(&device);
 }
 

-- 
2.53.0

