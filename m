Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48761F9F70
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203525; cv=none; b=DCG8U0zQqSafRFzA9syj1wsock+GYYWeRz1oUqLtKMM9QohRaxEcUchRyGxYOJF1raosT5PtkDrEt0zdg/vbeneAQ6/zgFjMcOOx9OHHNXoAIr/PRp34XZa/q0jirpvPxthUTj336t6boSAb4A9/WMYYkLmKkqaBPhfTDtLR8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203525; c=relaxed/simple;
	bh=RejzeVT9WhlCbQ0mr/85MMN+asc2NhHmHp8CZuflh9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IK2AmPRPD3TiCm015wTjPkRBpVLIKFp5+Y1bmKIVQi1NuYWiKpvbqeSbQaVkKskMgk+Uc+TPjbNV802MfLJAkHeU3GfjwxR/HlOb6TAvWNpVgCzEsk9mMvIcLdBaWyoTtOJJnJj50Vhim7M+QGirHCJJHng4K1JkMK8fE8688sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=i6oxYLtm; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="i6oxYLtm"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250918134153b83b1b001c00020785
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 15:41:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aNmjoRx+M40ZEykzP0OuZQub9Z6p59CUTVuTYgvveGA=;
 b=i6oxYLtmBqNrZQa564AzdSeZ/+nz90jFK1vAVCzcuX7i9Fb4uJtz0w2etLaBpjoHU8V3uy
 U4azwsnULTzeJUMccEXZEUFuLuqxj7wEt0tE7mQMiKDE4c1J17O671usMmNrGxczpYiebedG
 FLsrEMV7uCqHbvDjMH5MJKmR/LJgRXjhk8HP8F2A1urP+WQCwpQG8UnOY3ATd3VqVsPnCIOg
 nGYDjCCMa/MtUOTMKpK5njPyAIcgZdRlp68/JaxVTMuyHOvza0rapqw58sy4qVmQ4dRgUwuu
 NpSx74dVURMBLiZeRd+95BYoz9xaIm+l3HQHobEmnJaHQ6Y8DodPuzHA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 18 Sep 2025 15:41:51 +0200
Subject: [PATCH Dovetail 6.16 v2 1/4] clocksource/hyper-v: irq_pipeline:
 Enable pipelined clock events
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-flo-add-hyperv-support-for-6-15-v2-1-f1c802b1aba3@siemens.com>
References: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
In-Reply-To: <20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixes a boot failure on hyper-v.

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

