Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F145301708
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239543; cv=none; b=ucNt/UxQJ4rf9yxJBKPrlisbSLU9xyBnneqR3l5nJksjkYhzB8sYMIDY1vFj3us2cvhC4PT6Nn0uKEA9bpyw+MD5Z0I4I4GpY46triLMK3ZQk/nV8lPKc/X+i8N3aSmV4XwWHcMhCyAHiFVbuq4FwVWS2Ito0f3le8X2z4cIE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239543; c=relaxed/simple;
	bh=gpDa/jRw3zy75ND1Mf4hOt2N/wk/bHTevnbnctScnfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRx5x4Fv/tbL2p/YKP5Nr8kyRL0lAXTOTA4Bh7MpWt5MoqFIoEHzRgooEX+52529qZd56tVdTHkbjaRx4bu8Vw0eMfctpBWqgZc+P3WgNte0odj3piaMtca7kDA1U+Gf2zYhgsA/RIZ5IFSCgN48pkyDwzOipzGvpEy0pda81XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Zz95AAqI; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Zz95AAqI"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260216105856c5772dc81a000207f5
        for <xenomai@lists.linux.dev>;
        Mon, 16 Feb 2026 11:58:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z0aohrr3op3RCuQ4lhBepRfXdmZuNvJvORUjnoz6NZs=;
 b=Zz95AAqIno1z+x1Uv1EnPXis2kCnSYyYtayLramGulEnWQO6yitN+TF7SLRonKIC/6X8ra
 Nku4q30QtW/I/IVj5Vb+eNCc6ml+PY761izWuv7jJdgcky9I2GuIiSDsIzI77D64vpI+xtHQ
 dGqR6tFtQHCd/IrncwcywffM4HL6TZl0R/VGa8lq7LgRck7DSRe2vtGwpxsex/fGBfDAApdw
 1osTnTIBSn3XNwPOdnn1HYniOzo5ZtxR1nw1O1EE4Yeb7On5+TLmlxdkEl4BgtJ+a2kEE6iF
 ZSlJ66hWlNFy6QQjRW5DEHMUf2eGXpFqtPGrfIfUumTtUQFXoYcPmYbA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 16 Feb 2026 11:58:51 +0100
Subject: [PATCH 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-wip-flo-prepare-for-6-19-v1-1-f7362cdd2532@siemens.com>
References: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
In-Reply-To: <20260216-wip-flo-prepare-for-6-19-v1-0-f7362cdd2532@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Since 6.19 the signature of __request_percpu_irq() got one additional
affinity parameter.

A new Linux version specific wrapper cobalt_request_percpu_irq() is
introduced to hide the signature change between different Linux
versions.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/irq.h      | 20 ++++++++++++++++++++
 include/cobalt/kernel/dovetail/pipeline/pipeline.h | 10 +++++-----
 include/cobalt/kernel/dovetail/pipeline/sirq.h     |  8 +++-----
 kernel/cobalt/dovetail/tick.c                      |  8 ++++----
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..ac780a4bb3223889ccf827b5b8cb279035a5dd7b 100644
--- a/include/cobalt/kernel/dovetail/pipeline/irq.h
+++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
@@ -5,6 +5,26 @@
 #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
 #define _COBALT_KERNEL_DOVETAIL_IRQ_H
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
+static inline int cobalt_request_percpu_irq(unsigned int irq,
+					    irq_handler_t handler,
+					    unsigned long flags,
+					    const char *devname,
+					    void __percpu *dev_id)
+{
+	return __request_percpu_irq(irq, handler, flags, devname, dev_id);
+}
+#else
+static inline int cobalt_request_percpu_irq(unsigned int irq,
+					    irq_handler_t handler,
+					    unsigned long flags,
+					    const char *devname,
+					    void __percpu *dev_id)
+{
+	return __request_percpu_irq(irq, handler, flags, devname, NULL, dev_id);
+}
+#endif
+
 static inline void xnintr_init_proc(void)
 {
 	/* N/A */
diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 2e6e66a2d6d4dbf407d4ce42fff8b84acc2931d0..898f249f3316c6543cdce0b2c2f6e0b72a0a7809 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -11,6 +11,7 @@
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/syscall.h>
+#include <pipeline/irq.h>
 #include <pipeline/machine.h>
 
 typedef unsigned long spl_t;
@@ -42,11 +43,10 @@ static inline int pipeline_request_resched_ipi(void)
 		return 0;
 
 	/* Trap the out-of-band rescheduling interrupt. */
-	return __request_percpu_irq(RESCHEDULE_OOB_IPI,
-			pipeline_reschedule_ipi_handler,
-			IRQF_OOB,
-			"Xenomai reschedule",
-			&cobalt_machine_cpudata);
+	return cobalt_request_percpu_irq(RESCHEDULE_OOB_IPI,
+					 pipeline_reschedule_ipi_handler,
+					 IRQF_OOB, "Xenomai reschedule",
+					 &cobalt_machine_cpudata);
 }
 
 static inline void pipeline_free_resched_ipi(void)
diff --git a/include/cobalt/kernel/dovetail/pipeline/sirq.h b/include/cobalt/kernel/dovetail/pipeline/sirq.h
index 1da9d13b217081ba52ef0444b60d236ddb9c8a9e..784d4213cff4f28b29c76293e61d9a48e74b3bc7 100644
--- a/include/cobalt/kernel/dovetail/pipeline/sirq.h
+++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
@@ -9,6 +9,7 @@
 
 #include <linux/irq_pipeline.h>
 #include <cobalt/kernel/assert.h>
+#include <pipeline/irq.h>
 
 /*
  * Wrappers to create "synthetic IRQs" the Dovetail way. Those
@@ -29,11 +30,8 @@ int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
 	if (sirq == 0)
 		return -EAGAIN;
 
-	ret = __request_percpu_irq(sirq,
-			handler,
-			IRQF_NO_THREAD,
-			"Inband sirq",
-			&cobalt_machine_cpudata);
+	ret = cobalt_request_percpu_irq(sirq, handler, IRQF_NO_THREAD,
+					"Inband sirq", &cobalt_machine_cpudata);
 
 	if (ret) {
 		irq_dispose_mapping(sirq);
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 873b62471eac758fba5b86fa36b8265b6284dc87..dd8849ff053bc1629a20f543e38c7cf115a68458 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -8,6 +8,7 @@
 #include <linux/tick.h>
 #include <linux/clockchips.h>
 #include <cobalt/kernel/intr.h>
+#include <pipeline/irq.h>
 #include <pipeline/tick.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/timer.h>
@@ -153,10 +154,9 @@ int pipeline_install_tick_proxy(void)
 	 * CPUs.
 	 */
 	if (num_possible_cpus() > 1) {
-		ret = __request_percpu_irq(TIMER_OOB_IPI,
-					tick_ipi_handler,
-					IRQF_OOB, "Xenomai timer IPI",
-					&cobalt_machine_cpudata);
+		ret = cobalt_request_percpu_irq(TIMER_OOB_IPI, tick_ipi_handler,
+						IRQF_OOB, "Xenomai timer IPI",
+						&cobalt_machine_cpudata);
 		if (ret)
 			return ret;
 	}

-- 
2.53.0

