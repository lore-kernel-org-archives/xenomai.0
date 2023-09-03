Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEED3D81
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:08 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230903150500ce98756fe9ec487253
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=INLFRBWVeL87pSO6Eb9DiNG56Qr+kwwC+LJdY1KLnOQ=;
 b=gKJ8gCVxu0gkNCTIzAAeBiYhod4Z2/1aoOhk67d66szyckzqmii6fImDtRpv7DmszgJb5+
 Vt7xkOA3voDRD3mSJj9gxFzPsfMX39G+BcQpohOESyLaMb5BjLRIVyxm3gXz4kzZiTqc2LGe
 +hNxxAdlCOHpc/d+7Kff6BE2wO61c=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 12/20] kernel/cobalt: Retire clock_freq field in cobalt_featinfo
Date: Sun,  3 Sep 2023 17:04:49 +0200
Message-Id: <36b200d807231c89f91cb391e8e92a5bbb37720b.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
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

Was always 0 since I-pipe was removed, and userspace no longer expects
it with the latest ABI revision.

Keep the field as reserved so that older userspace still finds the ABI
revision at the same offset.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/pipeline.h | 5 -----
 include/cobalt/uapi/asm-generic/features.h         | 4 ++--
 kernel/cobalt/posix/syscall.c                      | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 2ee7b32101..18a7da1913 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -92,11 +92,6 @@ static inline void pipeline_prepare_panic(void)
 	/* N/A */
 }
 
-static inline void pipeline_collect_features(struct cobalt_featinfo *f)
-{
-	f->clock_freq = 0;	/* N/A */
-}
-
 #ifndef pipeline_get_syscall_args
 static inline void pipeline_get_syscall_args(struct task_struct *task,
 					     struct pt_regs *regs,
diff --git a/include/cobalt/uapi/asm-generic/features.h b/include/cobalt/uapi/asm-generic/features.h
index 8a4927c491..4f069b1ceb 100644
--- a/include/cobalt/uapi/asm-generic/features.h
+++ b/include/cobalt/uapi/asm-generic/features.h
@@ -23,8 +23,8 @@
 #define XNFEAT_STRING_LEN 64
 
 struct cobalt_featinfo {
-	/** Real-time clock frequency */
-	__u64 clock_freq;
+	/* Used to be real-time clock frequency. */
+	__u64 __reserved1;
 	/** Offset of nkvdso in the sem heap. */
 	__u32 vdso_offset;
 	/** ABI revision level. */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 6193098bab..59c45d0499 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -331,7 +331,6 @@ static COBALT_SYSCALL(bind, lostage,
 	f->feat_abirev = XENOMAI_ABI_REV;
 	collect_arch_features(f);
 
-	pipeline_collect_features(f);
 	f->vdso_offset = cobalt_umm_offset(&cobalt_ppd_get(1)->umm, nkvdso);
 
 	if (cobalt_copy_to_user(u_breq, &breq, sizeof(breq)))
-- 
2.35.3

