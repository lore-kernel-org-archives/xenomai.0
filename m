Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4A3D3D1D
	for <xenomai@lists.linux.dev>; Thu, 26 Feb 2026 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116648; cv=none; b=Bd9+NMOmVMa7Ce3dB6ibo5T63SgSAoGICG4OoqCjMF0BT96J6GTCjMaYmAAa/tHqkCoN85zlki27Km6PBPHaY9yUvQJc/iKKAugmU98heo7qdX14NlRN4r1jvwC4kMIztFb1k5DiXFwqB+8b+KW9aKyk2kW92mSu3wd7IOCj4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116648; c=relaxed/simple;
	bh=DDz7eLPO4krsgqYk19Iv6TUzP2rKdb/vHWdIxfw/16E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hbsk3EV2gaxwWDmrIrX6assz8PCNJ5OYQT9GxQoPq2pw1AwqU7Vi0Gsir2BygwJTB/NDmMjMy+bB7+F8KFwnbuYysoU6IZE7/jPWV/wPNm8yC/9c6YH861yvL3wH8Hh0FkyBfyp6lRHf9sZrO7ycjVdgI+qBTYpUg12T7n/6jvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=c6MM6j2+; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="c6MM6j2+"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202602261437142166e0598c000207be
        for <xenomai@lists.linux.dev>;
        Thu, 26 Feb 2026 15:37:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9XDXFYRnMktLookUZoyV/cEvskJ0rXQyXc8ws2GkcJw=;
 b=c6MM6j2+9Som/8vDuot1cKG/XSpaz5onQIfhEpzywViSCwAtZcio3LCPQhIMSEAFAuc50q
 lVrihKYRZsh5R+vWcdmrAqQgPU9gWqHCcf9tO/mxoBZPHVwwJcvSRcTN+gJYsVOgg0fT0t6A
 VOgFmmaevT0JvUa4DU28JVYSVTsJWCvZIqulx7sseZj2CqB3TeJ0Wh8dd+hX6TyZ678hzHGF
 yIZWdSPZY7UhnRcf7+AagBMqfhhAJD/M0MkDm7Bh77faLhvsWu0ct2csyi5GOj9ldFTLaEGz
 3jK10HDB5ePNKYgc/2Zj+JOjkoIc4xqCndf7PYjtOATXHChd22V2ULXg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 26 Feb 2026 15:37:16 +0100
Subject: [PATCH v3 5/5] testsuite/switchtest: Add support for Dovetail >=
 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-wip-flo-prepare-for-6-19-v3-5-e730e85eda81@siemens.com>
References: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
In-Reply-To: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
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

preempt_disable() has no impact on OOB tasks, so when an OOB task
is scheduled out the fpsimd code tries to save the FPU regs to NULL,
which (obviously) triggered a fault.

To be able to provide a struct user_fpsimd_state located on the
stack  the signature of fp_linux_begin() on all architectures has
been updated.

There is a new arch dependent struct now: cobalt_arch_fp_state.
Arm64 will wrap the FPU state (struct user_fpsimd_state) there,
all remaining archs will implement an empty (and unused) type.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h   |  6 ++++--
 kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h | 16 +++++++++++-----
 kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h   |  9 ++++++---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h  |  7 +++++++
 kernel/drivers/testing/switchtest.c                   | 18 +++++++++++++-----
 5 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
index fc177fcb53bd259011a4a65f889c236f7c8e115e..3b80fa8461d44e3cf224dcba3d0bd7255d302732 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
@@ -30,12 +30,14 @@
 
 #include <asm/xenomai/uapi/fptest.h>
 
-static inline int fp_linux_begin(void)
+struct cobalt_arch_fp_state {};
+
+static inline int fp_linux_begin(struct cobalt_arch_fp_state *state)
 {
 	return -ENOSYS;
 }
 
-static inline void fp_linux_end(void)
+static inline void fp_linux_end(struct cobalt_arch_fp_state *state)
 {
 }
 
diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
index 520cd38519db66ad25baecedd183d56f92895539..e1ff046e1c9a99990cc93bcb7f3aa600186bfb36 100644
--- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
@@ -7,22 +7,28 @@
 #ifndef _COBALT_ARM64_FPTEST_H
 #define _COBALT_ARM64_FPTEST_H
 
-#include <asm/xenomai/uapi/fptest.h>
 #include <asm/hwcap.h>
 #include <asm/neon.h>
 
+#include <asm/xenomai/uapi/fptest.h>
+#include <asm-generic/xenomai/wrappers.h>
+
 #define have_fp (ELF_HWCAP & HWCAP_FP)
 
-static inline int fp_linux_begin(void)
+struct cobalt_arch_fp_state {
+	struct user_fpsimd_state state;
+};
+
+static inline int fp_linux_begin(struct cobalt_arch_fp_state *state)
 {
-	kernel_neon_begin();
+	kernel_neon_begin(&state->state);
 
 	return 0;
 }
 
-static inline void fp_linux_end(void)
+static inline void fp_linux_end(struct cobalt_arch_fp_state *state)
 {
-	kernel_neon_end();
+	kernel_neon_end(&state->state);
 }
 
 static inline int fp_detect(void)
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
index 55818f853c2407eef40f3d1d9a1336bfa7605512..de6a931077fc7ff6aca6f8a27423e31d64bace0d 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
@@ -19,12 +19,15 @@
 #ifndef _COBALT_X86_ASM_FPTEST_H
 #define _COBALT_X86_ASM_FPTEST_H
 
-#include <linux/errno.h>
+#include <asm/fpu/api.h>
+
 #include <asm/processor.h>
 #include <asm/xenomai/wrappers.h>
 #include <asm/xenomai/uapi/fptest.h>
 
-static inline int fp_linux_begin(void)
+struct cobalt_arch_fp_state {};
+
+static inline int fp_linux_begin(struct cobalt_arch_fp_state *state)
 {
 	kernel_fpu_begin();
 	/*
@@ -38,7 +41,7 @@ static inline int fp_linux_begin(void)
 	return true;
 }
 
-static inline void fp_linux_end(void)
+static inline void fp_linux_end(struct cobalt_arch_fp_state *state)
 {
 	kernel_fpu_end();
 }
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index baf54dcfe7bb5071a1abea48bd87f471eb938297..27e641fa7f9178229e0616e4de64b0e267910915 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -84,4 +84,11 @@
 	})
 #endif
 
+#ifdef CONFIG_ARM64
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
+#define kernel_neon_begin(fpu_preempt_buffer)	kernel_neon_begin()
+#define kernel_neon_end(fpu_preempt_buffer)	kernel_neon_end()
+#endif
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index f8f6c892076bba729d5d4b536288574df431e344..bb9c3dcae36f412562b78713bb10260d764dfd40 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -15,16 +15,23 @@
  * along with Xenomai; if not, write to the Free Software Foundation,
  * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
+
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/semaphore.h>
+
+/*
+ * Needs to be the first non-Linux include, wrappers.h for older kernels
+ * involved on arm64 and further Linux headers included at the top of fptest.h
+ */
+#include <asm/xenomai/fptest.h>
+
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/synch.h>
 #include <cobalt/kernel/thread.h>
 #include <cobalt/kernel/trace.h>
 #include <rtdm/testing.h>
 #include <rtdm/driver.h>
-#include <asm/xenomai/fptest.h>
 
 MODULE_DESCRIPTION("Cobalt context switch test helper");
 MODULE_AUTHOR("Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>");
@@ -236,6 +243,7 @@ static int rtswitch_to_nrt(struct rtswitch_context *ctx,
 			   unsigned int from_idx,
 			   unsigned int to_idx)
 {
+	struct cobalt_arch_fp_state state;
 	struct rtswitch_task *from, *to;
 	unsigned int expected, fp_val;
 	int fp_check;
@@ -276,7 +284,7 @@ static int rtswitch_to_nrt(struct rtswitch_context *ctx,
 
 		case RTSWITCH_RT:
 
-			if (!fp_check || fp_linux_begin() < 0) {
+			if (!fp_check || fp_linux_begin(&state) < 0) {
 				fp_check = 0;
 				goto signal_nofp;
 			}
@@ -287,7 +295,7 @@ static int rtswitch_to_nrt(struct rtswitch_context *ctx,
 			fp_regs_set(fp_features, expected);
 			rtdm_event_signal(&to->rt_synch);
 			fp_val = fp_regs_check(fp_features, expected, report);
-			fp_linux_end();
+			fp_linux_end(&state);
 
 			if(down_interruptible(&from->nrt_synch))
 				return -EINTR;
@@ -308,11 +316,11 @@ static int rtswitch_to_nrt(struct rtswitch_context *ctx,
 				(ctx->switches_count % 4000000) * 1000;
 			barrier();
 
-			fp_linux_begin();
+			fp_linux_begin(&state);
 			fp_regs_set(fp_features, expected);
 			rtdm_event_signal(&to->rt_synch);
 			fp_val = fp_regs_check(fp_features, expected, report);
-			fp_linux_end();
+			fp_linux_end(&state);
 
 			if (down_interruptible(&from->nrt_synch))
 				return -EINTR;

-- 
2.53.0

