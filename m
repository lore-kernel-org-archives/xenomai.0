Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D6E39E6D9
	for <xenomai@lists.linux.dev>; Thu, 26 Feb 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117248; cv=none; b=rErVGwBWytsqHRoGKVoHsZI9L7SP2gs8mh7fyC1q3g1DpJqa+xKBxqL4/97eXvCKJepfu5zrNGXY3lRyykto8dGatnT++s2Q3w826j7aR9UgGURaeflEzsviG0cnAr2oLsZy2j1+E4GINxvyQF+IydHKWPppm9wN3M7rVabfPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117248; c=relaxed/simple;
	bh=CoY4OheUEOmcwzzhMXYRIcJl82PnnKE2wgN5CWMFVeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Byw5IDA0pzmLqvaBqLqL49aYOPJ25XtAcSDsElKt1m+W9cQvB9sj1qRp0ZoMJFRp4d0xM96t/27g6BZtYLukD5Lgep/uAgpQPkn4tAYOUtU6gIx9ngHyCUfCenfBOdxFTm3Aq74ngPLWH6WETsDqpcXt38gA8blr1amIWEKHP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=LytcUf00; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="LytcUf00"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202602261437142960a03a890002070c
        for <xenomai@lists.linux.dev>;
        Thu, 26 Feb 2026 15:37:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gVfpJmbo5phNVAho9qmuQr8nXL+lrnL9+cB64G2vmrY=;
 b=LytcUf00ZKcz3DqSjM88CiOlcLBIN/zNcM7CGjkQbY+BcuITj4UBnmMhcSkuDVMIKwr9B/
 dYKjtpHJqqjMTvWxmh9R5vIEEMRbdGlEFpGic4bzBYs4znghtj3kThZEfMNIIEHZ6awPVNvc
 t91jkwhPqZbSdPfOPejrwkNTQWCyil6YNMOWjrrWFiB2L2p78h5AvmI4TuHd3JJ49u4s8/5z
 CQT5WCQVyPQ35KNO9IvvOAfj2FW8lR214qBkOg6YiMlEUSlPpkN+cEr0Z8v+OLt/SHZZONnl
 VYXFbtPFGioG17mz9uLCnzTK8gyMoYdw3UyXwD/I9UcTW2VxN+n221aA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 26 Feb 2026 15:37:12 +0100
Subject: [PATCH v3 1/5] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-wip-flo-prepare-for-6-19-v3-1-e730e85eda81@siemens.com>
References: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
In-Reply-To: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
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
 include/cobalt/kernel/dovetail/pipeline/pipeline.h   | 8 +++-----
 include/cobalt/kernel/dovetail/pipeline/sirq.h       | 8 +++-----
 kernel/cobalt/dovetail/tick.c                        | 7 +++----
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 9 +++++++++
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 2e6e66a2d6d4dbf407d4ce42fff8b84acc2931d0..19d616a421d2ebc83d21d816bf00eead298b8def 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -42,11 +42,9 @@ static inline int pipeline_request_resched_ipi(void)
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
index 1da9d13b217081ba52ef0444b60d236ddb9c8a9e..13eb020ac7c17ec06c52b43406cc68aa7f3e52a1 100644
--- a/include/cobalt/kernel/dovetail/pipeline/sirq.h
+++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
@@ -29,11 +29,9 @@ int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
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
index 873b62471eac758fba5b86fa36b8265b6284dc87..7ebce1991fd35d9e0cb45e05c55f3b8e5ef6baf2 100644
--- a/kernel/cobalt/dovetail/tick.c
+++ b/kernel/cobalt/dovetail/tick.c
@@ -153,10 +153,9 @@ int pipeline_install_tick_proxy(void)
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
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index a68c3b1951d1a4a90c032a9a132c920b841cda49..838085d338b51a4fdd89218aa512de8d60a853a0 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -71,4 +71,13 @@
 #define timer_container_of	from_timer
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
+#define request_percpu_irq_affinity_flags(irq, handler, flags, devname,        \
+					  affinity, dev_id)                    \
+	({                                                                     \
+		WARN_ON_ONCE(affinity);                                        \
+		__request_percpu_irq(irq, handler, flags, devname, dev_id);    \
+	})
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */

-- 
2.53.0

