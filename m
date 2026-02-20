Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27133031F
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586873; cv=none; b=aXtUtXIo9vspUmqxTF0H2RseCmL07fk5jUedxmUUW+LoCuWkBQBrGjkYdVIS+l5he2HCWxnQHOgXrXDxtUnaoZ9Jx+TKnGRs6T05QnUuKVSawwvpkFUvwsrpkMBK9+DqojbCS2gFupy3FWZMEV2JEHjQmtZs9kfbcOdIi24QUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586873; c=relaxed/simple;
	bh=ZdUTi/BZnUIK3+XUumXid1Vcdkp4klz8VEtMSYx3tZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=or3mH3i03uUjYV5ClLHoRhInpGgvAeA2jAXJXJU0S502sPAfNGaoca2SdsB6w/ZjkU1Ci7Y5gl+h5MOPwfUuD1QuReNbh6p0Z5CJ0i7QLTUTMAuwX0i7BZ8hhn9u/5W8sNJ1kX+yHnS81JJgblsIyzmbLRe7FdX2a9RH7Le3z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=RB3DZEgS; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="RB3DZEgS"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260220112748d60df03cce000207d0
        for <xenomai@lists.linux.dev>;
        Fri, 20 Feb 2026 12:27:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RpHqvkO+Epp/xwKKUWnJspJ6AG7AtTA59GTuYgcSkcM=;
 b=RB3DZEgSKEWI0sAd7pJSdF5u2PC+vKYg98ls6Xl6MUYvbrMYVN9f7z9ENVFjyMZzaEDBoo
 rVIvr2nA3VgMbmxuedRG83fFGW1vN4ZwN61lbz1qdSfZHo5NfjXaDoKtMuz+OpO9depw0D5G
 RKwJtrihK04SySbUqlYieHH/Dl4+/Te2XNsmC4w1ZZI8mvjgj9a+VCJ+kYMI/ChcPUoK0dMT
 s5TYJ0TLYRjLJOb7JFn7BlDDfvJ0p8atbI9OUZOghGV5+7L8ChzbS0tVeDvQ4OWLjLvueAhF
 Zst+xkLrkCG170fYbjK4qL1Ws0jcYcK7vhlK21UXg6WN5/xesLjDWuwQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 20 Feb 2026 12:27:48 +0100
Subject: [PATCH v2 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
In-Reply-To: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The signature of __request_percpu_irq() got one additional affinity
parameter in 6.19 and 7.0 will remove the function entirely.

Dovetail 6.19 will introduce a new dovetail specific service called
request_percpu_irq_affinity_flags() that allows us to set flags and
affinity at the same time.

It might happen that older Dovetail versions get the new API via
backports, so the re-#definement for older kernels might get
obsolete earlier than dropping support for Dovetail < 6.19.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/irq.h      | 6 ++++++
 include/cobalt/kernel/dovetail/pipeline/pipeline.h | 9 ++++-----
 include/cobalt/kernel/dovetail/pipeline/sirq.h     | 9 ++++-----
 kernel/cobalt/dovetail/tick.c                      | 8 ++++----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..df0b8ceb05c25d655a331d238e7ef8ac8a6afeea 100644
--- a/include/cobalt/kernel/dovetail/pipeline/irq.h
+++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
@@ -5,6 +5,12 @@
 #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
 #define _COBALT_KERNEL_DOVETAIL_IRQ_H
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
+#define request_percpu_irq_affinity_flags(irq, handler, flags, devname,        \
+					  affinity, dev_id)                    \
+	__request_percpu_irq(irq, handler, flags, devname, dev_id)
+#endif
+
 static inline void xnintr_init_proc(void)
 {
 	/* N/A */
diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 2e6e66a2d6d4dbf407d4ce42fff8b84acc2931d0..f5ee443ada3788b8b0261f77ae7da5d5f69ef9f2 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -11,6 +11,7 @@
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
 #include <asm/syscall.h>
+#include <pipeline/irq.h>
 #include <pipeline/machine.h>
 
 typedef unsigned long spl_t;
@@ -42,11 +43,9 @@ static inline int pipeline_request_resched_ipi(void)
 		return 0;
 
 	/* Trap the out-of-band rescheduling interrupt. */
-	return __request_percpu_irq(RESCHEDULE_OOB_IPI,
-			pipeline_reschedule_ipi_handler,
-			IRQF_OOB,
-			"Xenomai reschedule",
-			&cobalt_machine_cpudata);
+	return request_percpu_irq_affinity_flags(
+		RESCHEDULE_OOB_IPI, pipeline_reschedule_ipi_handler, IRQF_OOB,
+		"Xenomai reschedule", NULL, &cobalt_machine_cpudata);
 }
 
 static inline void pipeline_free_resched_ipi(void)
diff --git a/include/cobalt/kernel/dovetail/pipeline/sirq.h b/include/cobalt/kernel/dovetail/pipeline/sirq.h
index 1da9d13b217081ba52ef0444b60d236ddb9c8a9e..00c08af784588d5239cf399d69800c914221b210 100644
--- a/include/cobalt/kernel/dovetail/pipeline/sirq.h
+++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
@@ -9,6 +9,7 @@
 
 #include <linux/irq_pipeline.h>
 #include <cobalt/kernel/assert.h>
+#include <pipeline/irq.h>
 
 /*
  * Wrappers to create "synthetic IRQs" the Dovetail way. Those
@@ -29,11 +30,9 @@ int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
 	if (sirq == 0)
 		return -EAGAIN;
 
-	ret = __request_percpu_irq(sirq,
-			handler,
-			IRQF_NO_THREAD,
-			"Inband sirq",
-			&cobalt_machine_cpudata);
+	ret = request_percpu_irq_affinity_flags(sirq, handler, IRQF_NO_THREAD,
+						"Inband sirq", NULL,
+						&cobalt_machine_cpudata);
 
 	if (ret) {
 		irq_dispose_mapping(sirq);
diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
index 873b62471eac758fba5b86fa36b8265b6284dc87..fa7ef09eaf39cdc1fca5c68f22f57da0c1320789 100644
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
+		ret = request_percpu_irq_affinity_flags(
+			TIMER_OOB_IPI, tick_ipi_handler, IRQF_OOB,
+			"Xenomai timer IPI", NULL, &cobalt_machine_cpudata);
 		if (ret)
 			return ret;
 	}

-- 
2.53.0

