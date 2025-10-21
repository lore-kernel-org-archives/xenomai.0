Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA113635C
	for <xenomai@lists.linux.dev>; Tue, 21 Oct 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049404; cv=none; b=boGURCoDbtV7WClmDc6FPDVGnJhV1gAHdvMIcxBkjzXEBPUb8KwmiQBeTrkLuQJdIahoOK8A93BBOobBW58rB8pTjrkyD3sWa0TorTOho4q5lMgDt9j6NLhzkIEEekOUNl/Cy7Zc1kuXvR+p8UPT+BTgBPWprwrGgTdKdAO7B+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049404; c=relaxed/simple;
	bh=Yjz83AAXmiHYYaaN54/yVMfut8QfgGr2M/fJX4soM9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDJYFzcTLJ+Qk5/sNtFG2XlFeXB1rqwEfGwGO/jJlBV7bj1Ed+rIQA2MTmbduRtW/+nXtfV/YXM6KNblWUpr+4uc/+l3Ed+k4nqe4yDnsXJXPKiUSBEGAmtS9+iWF2SzMFz0sjn+nw99OxFOeGGVSplYwaHVOh0kXunTiPQdgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=IkIEHuDm; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IkIEHuDm"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251021122312088388b15500020717
        for <xenomai@lists.linux.dev>;
        Tue, 21 Oct 2025 14:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CMlXMRzMysIGRS0ZChzfdVPFdvKuEKQasvm07EYXoT4=;
 b=IkIEHuDmmpWgp4st02/3PbLJKa8AB3jLgBt//9MZFYfJFEBuRj/+9bK1G3+QWq9SyP1m/7
 FcMMeqT2FYPBOUNIYnaFDqYv/QKFdRhnuZKraldTVVluJqOYRkGVgJtE2hcgoIp6o8H5OpOz
 AFYSYr71Fw1K4gnDiCsO+7wo4Yw8RN9fhRk9HAb/4fftFJGXjiJChtaoRXrPTSc6qrM0012P
 rSlfogGzpw4usZBkUztzkXdqWnQjdI0gny67CHES/Ym9I9LlM0Fe0c4Js5IvnMWb6Wi52i6I
 k+Hsj/Tz7j/1woFyfBwy6mw/sraPlDhGBffy31izsEp2gI2BggSXwr3g==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 21 Oct 2025 14:23:11 +0200
Subject: [PATCH Dovetail 6.17 v3 1/4] clocksource/hyper-v: irq_pipeline:
 Enable pipelined clock events
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v3-1-f3b45eaed2e8@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v3-0-f3b45eaed2e8@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Make the clock event around the STIMER0 pipeline safe. The
implementation is following the same pattern that we already have in
place for the x86 LAPIC interrupt / clock event.

To get the proxy tick working we need to link the hyperv clock event
device with the STIMER0 vector. This part is also following the pattern
of the x86 lapic interrupt. Both have a fixed arch specific vector
assigned.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/clocksource/hyperv_timer.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 2edc13ca184e0..0850b0c385a8e 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -26,6 +26,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
+#include <asm/trace/irq_vectors.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
 /* Note: offset can hold negative values after hibernation. */
@@ -53,6 +54,30 @@ static int stimer0_irq = -1;
 static int stimer0_message_sint;
 static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+#define HV_STIMER_IRQ	apicm_vector_irq(HYPERV_STIMER0_VECTOR)
+
+static irqreturn_t hv_stimer_oob_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = this_cpu_ptr(hv_clock_event);
+
+	trace_local_timer_entry(HYPERV_STIMER0_VECTOR);
+	clockevents_handle_event(evt);
+	trace_local_timer_exit(HYPERV_STIMER0_VECTOR);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction hv_stimer_oob_action = {
+	.handler = hv_stimer_oob_handler,
+	.name = "Out-of-band STIMER0 timer interrupt",
+	.flags = IRQF_TIMER | IRQF_PERCPU,
+};
+#else
+#define HV_STIMER_IRQ	-1
+#endif
+
 /*
  * Common code for stimer0 interrupts coming via Direct Mode or
  * as a VMbus message.
@@ -137,8 +162,9 @@ static int hv_stimer_init(unsigned int cpu)
 
 	ce = per_cpu_ptr(hv_clock_event, cpu);
 	ce->name = "Hyper-V clockevent";
-	ce->features = CLOCK_EVT_FEAT_ONESHOT;
+	ce->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PIPELINE;
 	ce->cpumask = cpumask_of(cpu);
+	ce->irq = HV_STIMER_IRQ;
 
 	/*
 	 * Lower the rating of the Hyper-V timer in a TDX VM without paravisor,
@@ -305,6 +331,12 @@ int hv_stimer_alloc(bool have_percpu_irqs)
 		hv_remove_stimer0_irq();
 		goto free_clock_event;
 	}
+
+#ifdef CONFIG_IRQ_PIPELINE
+	ret = setup_percpu_irq(HV_STIMER_IRQ, &hv_stimer_oob_action);
+	if (ret)
+		goto free_clock_event;
+#endif
 	return ret;
 
 free_clock_event:

-- 
2.39.5

