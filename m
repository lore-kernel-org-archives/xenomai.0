Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85379370592
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082397; cv=none; b=pEKbmT9TTS7DtGSuuTF5kF0NDot1Uew/pBFQqZZgAQORmDTBtTTv64CboVrxRj3oPHNUqM4SAouWJosv5nRWBZ6FUE/F28T/5Xb8O/EvkNkCBSxCuvbT1p/bncnTl+aX+I6+YDZzHYh+tPLMDvUWou6LWc70L0QAwJsjSPjf81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082397; c=relaxed/simple;
	bh=o6eOZbCaecJAiDCdPw3laRvMmCfN0KepEIZs9ziZZTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brgBi7EhPytNnFQPWgsqrq0oi41t5zJtEbWWYQA0KR9twkQmZeUYllsteS1yQhMfSQKJBDYkeZqhQvDqZC8WatBVQwjWPi9MeC+esRsSrO85CE8MPaNeKkhli4vuXX+Mt9rkgFKTNNXGjegPKDRjILbHeUIg4YQJYnpmolQCoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Vqur7YcU; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Vqur7YcU"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250905142630ab5a21c6900002074b
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 16:26:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=q2Taw3MAQimlp2+RnN5XIYCgOeIF52hA8G8bLjzavc0=;
 b=Vqur7YcUCD+CsbYdYvsFV1Us7fP3uQc6W6+6i2F94kZ6xTMInXToMOY0ZmkPm2q3XGtas0
 1S3Wzvw84c1x4mU6ekn4tFho8EyPjfro9inwS5MVY8pk+I4YBu+lOBXAnIN8T3GIYZ67arB+
 a3TcP7+B4OgHqx3Xq5VWt5ubzz7csC9v3lTJ/SrdXjdS6iE9GlVMqe+bS3RJ7s+Zc0VlYeF0
 5T7H5SWU5jZI69DuDG6gxOaFIthtB17rUJNSj5SyHICULj2CGDnaHM3rNqNoAWA7eW5F7XhL
 rngHzGpmCHjZ9vndl4rSZAVok3BX8KZ60HTX1XHYL3W0ughUkMXcsPpA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 Sep 2025 16:26:26 +0200
Subject: [PATCH Dovetail 6.16 v3 2/3] arm64: fpsimd: dovetail: Align with
 x86 implementation
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-2-ae4a674d8e10@siemens.com>
References: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
In-Reply-To: <20250820-wip-flo-fixes-for-dovetail-6-15-v3-0-ae4a674d8e10@siemens.com>
To: xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The FPU preemption marker is only accessed from the current task, so
we can avoid atomic operations. Moving the marker from the low level
flags to the local (synchronous) flags to make that clear.

Gives us some performance and aligns the arm64 implementation with x86.
---
 arch/arm64/include/asm/thread_info.h | 10 +++++-----
 arch/arm64/kernel/fpsimd.c           |  7 +++++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 3fb3725fb004..a4405b11189b 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -75,7 +75,6 @@ void arch_setup_new_exec(void);
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
 #define TIF_SECCOMP		11	/* syscall secure computing */
 #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
-#define TIF_KERNEL_FP_PREEMPTED	15	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
 #define TIF_MAYDAY		16	/* Emergency trap pending */
 #define TIF_RETUSER		17	/* INBAND_TASK_RETUSER is pending */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -141,9 +140,10 @@ void arch_setup_new_exec(void);
 /*
  * Local (synchronous) thread flags.
  */
-#define _TLF_OOB		0x0001
-#define _TLF_DOVETAIL		0x0002
-#define _TLF_OFFSTAGE		0x0004
-#define _TLF_OOBTRAP		0x0008
+#define _TLF_OOB			0x0001
+#define _TLF_DOVETAIL			0x0002
+#define _TLF_OFFSTAGE			0x0004
+#define _TLF_OOBTRAP			0x0008
+#define _TLF_KERNEL_FPU_PREEMPTED	0x0010	/* Dovetail: kernel mode FPSIMD section preempted by OOB */
 
 #endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index aac0dbf6d84e..1f5fcac32b2d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -2183,7 +2183,7 @@ void fpsimd_suspend_inband(void)
 	 */
 	if (test_thread_flag(TIF_KERNEL_FPSTATE)) {
 		fpsimd_save_state(kfpu);
-		set_thread_flag(TIF_KERNEL_FP_PREEMPTED);
+		set_thread_local_flags(_TLF_KERNEL_FPU_PREEMPTED);
 	}
 }
 
@@ -2191,8 +2191,11 @@ void fpsimd_resume_inband(void)
 {
 	struct user_fpsimd_state *kfpu = this_cpu_ptr(&in_kernel_fpstate);
 
-	if (test_and_clear_thread_flag(TIF_KERNEL_FP_PREEMPTED))
+	if (test_thread_local_flags(_TLF_KERNEL_FPU_PREEMPTED)) {
 		fpsimd_load_state(kfpu);
+		clear_thread_local_flags(_TLF_KERNEL_FPU_PREEMPTED);
+	}
+
 }
 
 #endif

-- 
2.39.5

