Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323742DA23
	for <xenomai@lists.linux.dev>; Tue, 11 Aug 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786449939; cv=none; b=qRlVMrqjttDZlzTmUNuV2RzddX2fM8pgHWP35plp/igQIyMwBwfh7h5V2YSlVUNG60LtVat0oEHPZTq45HSiL4y9DiyRjpQZCXjdmm3+KtYE1hN2Fyl+KIn5l1om2RO3NvvIx1faXq/FQHSa4lZgV8sE/iwBsb6/q3jhdd4udfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786449939; c=relaxed/simple;
	bh=oKk7Lc75Wal8niYWEe4e77H4FwomFIPvNuTUPR6ZOjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmDrMgQcZbdASBap3mCD3wlOT8JpDzn3Z2Y51LRwKuHrF/g/YoH9fFA1QDrKWBtBTHq8Dzj+7xAcPBRewdHh7XS9fCiF3vb4WDXscT1aUHTS4rAa6KM6y3xvjcd3bEIU8ro3DL59ddQBmVefCsyMHurC52K1gimd4pyVotyOQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437433|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0123187-0.000376389-0.987305;FP=2074572220681161204|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.ijKuAJw_1786449925;
Received: from sinsegye..(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.ijKuAJw_1786449925 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 20:05:26 +0800
From: liuyang <liuyang@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn,
	lixiaoning@sinsegye.com.cn,
	majun@sinsegye.com.cn,
	liuyang <liuyang@sinsegye.com.cn>
Subject: [PATCH v1] x86/dovetail: pipeline the thermal APIC sysvec
Date: Tue, 11 Aug 2026 20:05:21 +0800
Message-ID: <20260811120521.1677006-1-liuyang@sinsegye.com.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysvec_thermal was a non-pipelined DEFINE_IDTENTRY_SYSVEC (with a real
__apic_eoi()). Under thermal load we still hit stalls while that
handler ran against in-band timer paths (therm_throt_process ->
add_timer_on).

Handle THERMAL_APIC_VECTOR as a pipelined sysvec and dispatch it from
do_sysvec_inband(), so thermal runs on the in-band stage like other
pipelined system vectors.

Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
---
 arch/x86/include/asm/idtentry.h | 2 +-
 arch/x86/kernel/irq.c           | 5 +++--
 arch/x86/kernel/irq_pipeline.c  | 5 +++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index bb1df662d..b8d4995f9 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -816,7 +816,7 @@ DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,		sysvec_deferred_error);
 # endif

 # ifdef CONFIG_X86_THERMAL_VECTOR
-DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,		sysvec_thermal);
+DECLARE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,		sysvec_thermal);
 # else
 # define fred_sysvec_thermal				NULL
 # endif
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index f745f1752..976828a63 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -582,12 +582,13 @@ static void smp_thermal_vector(void)
 		       smp_processor_id());
 }

-DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
+DEFINE_IDTENTRY_SYSVEC_PIPELINED(THERMAL_APIC_VECTOR,
+				sysvec_thermal)
 {
 	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
 	inc_irq_stat(irq_thermal_count);
 	smp_thermal_vector();
 	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
-	__apic_eoi();
+	apic_eoi();
 }
 #endif
diff --git a/arch/x86/kernel/irq_pipeline.c b/arch/x86/kernel/irq_pipeline.c
index 00cb779a2..cb267c2e0 100644
--- a/arch/x86/kernel/irq_pipeline.c
+++ b/arch/x86/kernel/irq_pipeline.c
@@ -176,6 +176,11 @@ static void do_sysvec_inband(struct irq_desc *desc, struct pt_regs *regs)
 	case LOCAL_TIMER_VECTOR:
 		run_sysvec_on_irqstack_cond(__sysvec_apic_timer_interrupt, regs);
 		break;
+#ifdef CONFIG_X86_THERMAL_VECTOR
+	case THERMAL_APIC_VECTOR:
+		run_sysvec_on_irqstack_cond(__sysvec_thermal, regs);
+		break;
+#endif
 	default:
 		printk_once(KERN_ERR "irq_pipeline: unexpected event"
 			" on vector #%.2x (irq=%u)", vector, irq);
--
2.34.1

