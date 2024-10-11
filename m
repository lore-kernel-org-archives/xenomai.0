Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDFE1F471F
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728628705; cv=none; b=V2jo5/x/PvEXOw/ayFZVAgZ4ZbbuzULQTzlY0ABwHIG2FGO/dZyFVeAqhqiwjRQSvzfUzOm7J6iDuJ9PeLLOi1PlmFezoHVN+eAm+T2FhSwKJmefVp3AGH983XReHjd+Z70TOYC+q/tPCwNXqztK84IHUqs23zmQgZo+K31V3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728628705; c=relaxed/simple;
	bh=iAnpM1VYBlnK9Q219Lje0E0bhpu+CmKvrpwh4opz5po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtVWzTTI2adeAACPQOVFrhyco/GfZ0UPKAbD0G8l+5RBDQANpWMe4r/M/RQz0oUDIxOdE4VpvZIVRHtgbWGcEDQhhT4ZkhdxruaFNlcboRgJ1exNm4CJCUMGcPTDQIs3Cb8Yuqe66aPjlWrgkLJjGvDh08pBIv5UU5+dvRPcJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgJGqzvO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgJGqzvO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c8b557f91so10902855ad.2
        for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728628701; x=1729233501; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyZnrXXHDg/jPzH0KE3RglRWeBRtQQbO6+qN1SMXoMc=;
        b=KgJGqzvO4Ah7A3RR721o26Akc9hvJNLkAflMLcZEUAmh2GDnOz91nbQL2dbMLGSzkR
         vHT9RpgXjnlBd74a27quWaTo1FRNKdvQKNYCZ+bYFAVIGhwDu0Q2gkiY81EYLQq6Xhms
         kRA7AAgXyUIH1ejYMRIwF2x/Ka8yRZr7wzlsIXxo/IP1vUxr2PzoJHkVSCNqQ6WUZbM9
         326Zfsfm6yMCLQ9tSfuLibaatg2TCC3DAExnumCXIXmkuSzVpbImE9fcne7JKOpP77EO
         tfocC5S5UslIgz0tnNLBpvWSsfzTtfDE8s2jIPuxIi0QB8B4EAHSi2I1ezoBtIQ9+GdO
         b7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728628701; x=1729233501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyZnrXXHDg/jPzH0KE3RglRWeBRtQQbO6+qN1SMXoMc=;
        b=KX2iSXjs152912glmlGYCqoPs9gnu68mcHQr0N/GR1/up6M/BIdO1I3NsWM7KUxzhW
         Z33xoamE2b2VoVBFdP27aUDiW/V5/eATTXu5P0zaaGMtbrNgbNOjnX6Lyui6Pl1AYy6O
         TKHD7c7Hmp8MEmERszsV4K1fEdiU/FNQOo0ydUgYGAKd6c4EMUqasx6azbKJK9SU67XE
         NwIh+v/KhhMZVDBtBKbwUeUwHEzdEACKm6qv9mXP01EZh0aoVNFwnONd+qGH9iIcmKOH
         LsomH/PZ3HXubRCIl7tUjZOt1emHh8jX+EoOJc+Sdc7sXamSWNme2IfIia+qeM7FlGqM
         JMGA==
X-Gm-Message-State: AOJu0YyKCReWiU1ZjeZTKjslzsXbvVeqsrDtYF3r8oxj3M7mnN7wLO4/
	VzDKps4UVR7QgpcKdbxrKOnJL1JIovffhWh3OIo0oqeEGomi3XNCrDZAqnwPgpw=
X-Google-Smtp-Source: AGHT+IHz5NGpdqSMWjvWJZ/ri9RZe6S3gDxXom1R5pXeMxai7YdMedEWLZQfKjmb6dcOK6Gb0WcB0w==
X-Received: by 2002:a17:902:d491:b0:20c:60a0:78cb with SMTP id d9443c01a7336-20ca16c8bfdmr26402685ad.38.1728628700720;
        Thu, 10 Oct 2024 23:38:20 -0700 (PDT)
Received: from 43c7c7756ed8.. ([117.129.58.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1b9f3sm18241865ad.76.2024.10.10.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:38:20 -0700 (PDT)
From: shannmu <shanmu1901@gmail.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	shannmu <shanmu1901@gmail.com>
Subject: [PATCH 2/3] clocksource: Add irq pipelined clock events
Date: Fri, 11 Oct 2024 06:37:29 +0000
Message-Id: <20241011063730.310568-3-shanmu1901@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011063730.310568-1-shanmu1901@gmail.com>
References: <20241011063730.310568-1-shanmu1901@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds pipelined clock events for irqchip.

Signed-off-by: shannmu <shanmu1901@gmail.com>
---
 drivers/clocksource/timer-clint.c |  9 +++---
 drivers/clocksource/timer-riscv.c | 46 ++++++++++++++++---------------
 drivers/irqchip/irq-riscv-intc.c  |  1 +
 drivers/irqchip/irq-sifive-plic.c |  7 +++--
 4 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 9a55e733ae99..de3eb6937d6e 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -111,17 +111,16 @@ static struct clocksource clint_clocksource = {
 static int clint_clock_next_event(unsigned long delta,
 				   struct clock_event_device *ce)
 {
-	void __iomem *r = clint_timer_cmp +
-			  cpuid_to_hartid_map(smp_processor_id());
+	void __iomem *r = clint_timer_cmp + cpuid_to_hartid_map(smp_processor_id());
 
-	csr_set(CSR_IE, IE_TIE);
 	writeq_relaxed(clint_get_cycles64() + delta, r);
+	csr_set(CSR_IE, IE_TIE);
 	return 0;
 }
 
 static DEFINE_PER_CPU(struct clock_event_device, clint_clock_event) = {
 	.name		= "clint_clockevent",
-	.features	= CLOCK_EVT_FEAT_ONESHOT,
+	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE,
 	.rating		= 100,
 	.set_next_event	= clint_clock_next_event,
 };
@@ -156,7 +155,7 @@ static irqreturn_t clint_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evdev = this_cpu_ptr(&clint_clock_event);
 
 	csr_clear(CSR_IE, IE_TIE);
-	evdev->event_handler(evdev);
+	clockevents_handle_event(evdev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..bb0615937679 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -32,11 +32,10 @@ static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
 static bool riscv_timer_cannot_wake_cpu;
 
 static int riscv_clock_next_event(unsigned long delta,
-		struct clock_event_device *ce)
+				  struct clock_event_device *ce)
 {
 	u64 next_tval = get_cycles64() + delta;
 
-	csr_set(CSR_IE, IE_TIE);
 	if (static_branch_likely(&riscv_sstc_available)) {
 #if defined(CONFIG_32BIT)
 		csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
@@ -47,15 +46,17 @@ static int riscv_clock_next_event(unsigned long delta,
 	} else
 		sbi_set_timer(next_tval);
 
+	csr_set(CSR_IE, IE_TIE);
+
 	return 0;
 }
 
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
-	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
-	.rating			= 100,
-	.set_next_event		= riscv_clock_next_event,
+	.name = "riscv_timer_clockevent",
+	.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE,
+	.rating = 100,
+	.set_next_event = riscv_clock_next_event,
 };
 
 /*
@@ -74,11 +75,11 @@ static u64 notrace riscv_sched_clock(void)
 }
 
 static struct clocksource riscv_clocksource = {
-	.name		= "riscv_clocksource",
-	.rating		= 400,
-	.mask		= CLOCKSOURCE_MASK(64),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	.read		= riscv_clocksource_rdtime,
+	.name = "riscv_clocksource",
+	.rating = 400,
+	.mask = CLOCKSOURCE_MASK(64),
+	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
+	.read = riscv_clocksource_rdtime,
 #if IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY)
 	.vdso_clock_mode = VDSO_CLOCKMODE_ARCHTIMER,
 #else
@@ -120,7 +121,7 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
 	csr_clear(CSR_IE, IE_TIE);
-	evdev->event_handler(evdev);
+	clockevents_handle_event(evdev);
 
 	return IRQ_HANDLED;
 }
@@ -140,7 +141,8 @@ static int __init riscv_timer_init_common(void)
 
 	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
 	if (!riscv_clock_event_irq) {
-		pr_err("Failed to map timer interrupt for node [%pfwP]\n", intc_fwnode);
+		pr_err("Failed to map timer interrupt for node [%pfwP]\n",
+		       intc_fwnode);
 		return -ENODEV;
 	}
 
@@ -152,9 +154,8 @@ static int __init riscv_timer_init_common(void)
 
 	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
-	error = request_percpu_irq(riscv_clock_event_irq,
-				    riscv_timer_interrupt,
-				    "riscv-timer", &riscv_clock_event);
+	error = request_percpu_irq(riscv_clock_event_irq, riscv_timer_interrupt,
+				   "riscv-timer", &riscv_clock_event);
 	if (error) {
 		pr_err("registering percpu irq failed [%d]\n", error);
 		return error;
@@ -166,8 +167,9 @@ static int __init riscv_timer_init_common(void)
 	}
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
-			 "clockevents/riscv/timer:starting",
-			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
+				  "clockevents/riscv/timer:starting",
+				  riscv_timer_starting_cpu,
+				  riscv_timer_dying_cpu);
 	if (error)
 		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
 		       error);
@@ -183,8 +185,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
 	error = riscv_of_processor_hartid(n, &hartid);
 	if (error < 0) {
-		pr_warn("Invalid hartid for node [%pOF] error = [%lu]\n",
-			n, hartid);
+		pr_warn("Invalid hartid for node [%pOF] error = [%lu]\n", n,
+			hartid);
 		return error;
 	}
 
@@ -199,8 +201,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
 	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
 	if (child) {
-		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
-					"riscv,timer-cannot-wake-cpu");
+		riscv_timer_cannot_wake_cpu = of_property_read_bool(
+			child, "riscv,timer-cannot-wake-cpu");
 		of_node_put(child);
 	}
 
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index e8d01b14ccdd..fa3a7b153e08 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -68,6 +68,7 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+	.flags = IRQCHIP_PIPELINE_SAFE
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf0b40b0fad4..9c03993ddbba 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -197,8 +197,8 @@ static struct irq_chip plic_edge_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
-	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_AFFINITY_PRE_STARTUP |
+		IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip plic_chip = {
@@ -213,7 +213,8 @@ static struct irq_chip plic_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
-- 
2.34.1

