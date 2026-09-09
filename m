Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0A3B995E
	for <xenomai@lists.linux.dev>; Wed,  9 Sep 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942104; cv=none; b=Nk+ssRsuSvI+Uj5lrMhQbmpGvTxygo6MppaupI2BeMztQt/B8fObPysuDqanHzuka2tn8+9WvHekxTj6qM4cO0BKOWNPPgylTdx7tuj+bdEml2EVDJK0CoBdgT2tBxR5u2BreIdzqBHmeqZfeSagn34eogcMu+cZHZo+9PeufhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942104; c=relaxed/simple;
	bh=NDnkFbZjcwL+wkZdprnZYr2Oz9N9EYhS5H9d/Cd4wpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Am50RK1kZ4InPfWeJlrP7SRW2Ex4Rd7MH5T/y/tfhgQdOhM9JWya5N+k+eDGcx6qlJovmIruItQZOiCzeU6BhdvVGppBktoBBZv5f+M2tcgUiaCW3ZETl/HCiLlNAQ2mWjcmNP4gRhXfrSB6mjIQ5XxUchgKijMssmBUsTizCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=o6/R/Jt8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="o6/R/Jt8"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB4763EB91;
	Wed,  9 Sep 2026 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1788942094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXQLfBt5akQmOJtZpsxlvD715Uu19OnHGJyx7iXzQLE=;
	b=o6/R/Jt82qNzE55IJnXRGiDE7PpZLUdVh3CDO37lUiZSZ+4jCeFIqDstkYuVw4FX86dyG9
	iQyiUHfFqewMsIKKNyF9p/UKFxtTqPaOHre+9KxCEhWI9KBUXGXyL0hDuNAKEMrTlqgpxm
	9zsnXweoaUXkhTMnJCzsmTkgjaZMbFHqL38DPJS75JWj2J4Cyhnt/cB/wM+52KANDAypZI
	rinLybRcrf8//2XMoTtwgVks7UT4kD+nkOg9scjeof9P1MOGpojUDnUFDYyAhi6rOW9H5Q
	do3aWbOpogtLu2c5hRWvFN2oAzxVnn3OTdHbVdkvjiEO9CxGuQMm9XNodeFAqg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Andrew MacPherson <andrew@elk.audio>,  xenomai@lists.linux.dev,  Gerte
 Hoogewerf <ghoogewerf@lmi3d.com>
Subject: Re: perf getting all-zeroes IP on STM32MP1
In-Reply-To: <f78cec8dff20c4c799ede0e8e749e97ccf96ac27.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 08 Sep 2026 10:46:52 +0200")
References: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
	<9e0b7d3e72a19bd900a14faa6c459f5a2e093982.camel@siemens.com>
	<CACiVkwkc6nzD1qv7yzUR=a3GMPO+b9kp53sBVVKQpiW0NJX65w@mail.gmail.com>
	<dc1c6765187854e0758378af34098a64a8f7bf3b.camel@siemens.com>
	<87cxupgrnp.fsf@xenomai.org>
	<a14e0d0f9ec97f6064a1b2fb221f3ee5015e2241.camel@siemens.com>
	<877bkxgl7k.fsf@xenomai.org>
	<396c6e2bee432007d4878f092ed353f3034a2287.camel@siemens.com>
	<87pkyoduoj.fsf@xenomai.org>
	<f78cec8dff20c4c799ede0e8e749e97ccf96ac27.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 09 Sep 2026 10:21:32 +0200
Message-ID: <87mrtq25tf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTElwWfUI/YpQ59nC9Ahm5jIOFc1Mis7JQyZCuS+RNNDbgiwGe805HcDI/AaMci07ssdrFm4xaa0pZrvXDwB/CWc6+VsdVmRYyfx9JKgHXGv8hPVIxnRtZthNEYgzLbsfuxZZTOUuiLbkI6JTCNZWhFILcQiVL64mA0hQxzLT7Vu0o/TqXT0q6qYSf/ULccsD7mbrilQW1biyTpBght2luMaZ24czBocJ2UrjRLdq3mYYcvktcgvRePjCMT7oErxch2iug2QUzVdOMQfP++EknXCncQhFNPLn2sEbKWbBLOIxACvP2hqllxD/7UUabl/VQ2R3qhJ/+HsZ3CZf0TLt5ZYGNkJxZVP0sFmwScTEF+TK6trhfKVyKsOxK5AKieUSGJIc+abO59h8scEHwUSZljiZwivyx3UwNHk61oKPdzr6/AFqHTAxPey+Zd8MkdYjXbclfiJtDyE6Pzr5YA0gMHFNnYi62WZmLAaEW1vFIeqYs13HMrFbX7APxP4ZQHklK07vKx/k/gVmclmyhn58Fvn3juC1OiVNX/0ZUTJpB7BKNcM4A1uG+R9MhHCOl7qv+d++xwmzTsnlG0N4O2Rv26vlYXpCjSvqN+Iomv2mkYvQja7q99rRHjL8+SeEMmhVVjZeS5IhidusO/ZgYK3nELd94z6u1uz98h6NgIh62aCBA

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-09-08 at 10:16 +0200, Philippe Gerum wrote:
>> 
>> > 
>> > We could ask the clock_event_device (real device) for it's IRQ and mark
>> > it  as __IRQF_TIMER during proxy registration.
>> > 
>> > The following seems to work, but might need some more work.
>> > 
>> > The on_each_cpu() part is likely a overkill due to percpu IRQs, but the
>> > real_dev part of mark_timer_tick_irq() is local CPU specific as well.
>> > 
>> > diff --git a/kernel/time/tick-proxy.c b/kernel/time/tick-proxy.c
>> > index 6ef04fcf5dacd..55526cd99e849 100644
>> > --- a/kernel/time/tick-proxy.c
>> > +++ b/kernel/time/tick-proxy.c
>> > @@ -296,6 +296,22 @@ static int enable_oob_timer(void *arg) /* hard_irqs_disabled() */
>> >  	return 0;
>> >  }
>> >  
>> > +static void mark_timer_tick_irq(void *arg)
>> > +{
>> > +	struct clock_event_device *real_dev;
>> > +	struct irq_desc *desc;
>> > +	int irq;
>> > +
>> > +	real_dev = raw_cpu_ptr(&tick_cpu_device)->evtdev;
>> > +	irq = real_dev->irq;
>> > +	desc = irq_to_desc(irq);
>> > +
>> > +	if (!desc || !desc->action)
>> > +		return;
>> > +
>> > +	desc->action->flags |= __IRQF_TIMER;
>> > +}
>> > +
>> >  struct proxy_install_arg {
>> >  	void (*setup_proxy)(struct clock_proxy_device *dev);
>> >  	int result;
>> > @@ -400,6 +416,8 @@ int tick_install_proxy(void (*setup_proxy)(struct clock_proxy_device *dev),
>> >  		return arg.result;
>> >  	}
>> >  
>> > +	on_each_cpu(mark_timer_tick_irq, NULL, true);
>> > +
>> >  	/*
>> >  	 * Start ticking from the out-of-band interrupt stage upon
>> >  	 * receipt of out-of-band timer events.
>> 
>> Almost there, but we still need to provide the registers used in
>> profiling when no proxy is registered, in which case we cannot depend on
>> proxy registration for this, but on clock event device registration
>> instead.
>
> diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
> index 85ec0cbf5fb1e..c4eda1243b915 100644
> --- a/kernel/irq/pipeline.c
> +++ b/kernel/irq/pipeline.c
> @@ -1064,7 +1064,7 @@ void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
>  {
>  	struct irq_pipeline_data *p;
>  
> -	if (desc->action == NULL || !(desc->action->flags & __IRQF_TIMER))
> +	if (desc->action == NULL || !(desc->action->flags & IRQF_DEFERRED_TIMER))
>  		return;
>  	/*
>  	 * Given our deferred dispatching model for regular IRQs, we
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 90fae659e4ea6..9296164c1d198 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -326,6 +326,16 @@ bool tick_check_replacement(struct clock_event_device *curdev,
>  	return tick_check_preferred(curdev, newdev);
>  }
>  
> +static void tick_mark_deferred_timer_irq(struct clock_event_device *dev)
> +{
> +	struct irq_desc *desc = irq_to_desc(dev->irq);
> +
> +	if (!desc || !desc->action)
> +		return;
> +
> +	desc->action->flags |= IRQF_DEFERRED_TIMER;
> +}
> +
>  /*
>   * Check, if the new registered device should be used. Called with
>   * clockevents_lock held and interrupts disabled.
> @@ -367,6 +377,8 @@ void tick_check_new_device(struct clock_event_device *newdev)
>  	tick_setup_device(td, newdev, cpu, cpumask_of(cpu));
>  	if (newdev->features & CLOCK_EVT_FEAT_ONESHOT)
>  		tick_oneshot_notify();
> +	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
> +		tick_mark_deferred_timer_irq(newdev);
>  	return;
>  
>  out_bc:

I would attach this flag to the interrupt descriptor instead because
this is actually a property of the interrupt line, not of its
handler(s). Also, we need to consider device shutdown: as the current
tick source may be replaced dynamically, turning off this bit for proper
accounting when a clock device goes down would be safer.

e.g.:

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b13e4e90ab18f..5f7a2c78b3ca7 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -81,6 +81,7 @@ enum irqchip_irq_state;
  *                                when pipelining is enabled (CONFIG_IRQ_PIPELINE),
  *                                regardless of the (virtualized) interrupt state
  *                                maintained by local_irq_save/disable().
+ * IRQ_TICK                     - Interrupt is a timer tick source.
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -109,14 +110,15 @@ enum {
 	IRQ_HIDDEN		= (1 << 20),
 	IRQ_NO_DEBUG		= (1 << 21),
 	IRQ_OOB			= (1 << 22),
-	IRQ_RESERVED		= (1 << 23),
+	IRQ_TICK		= (1 << 23),
+	IRQ_RESERVED		= (1 << 24),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB | IRQ_TICK)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
@@ -1258,6 +1260,7 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
 
 #ifdef CONFIG_IRQ_PIPELINE
 int irq_switch_oob(unsigned int irq, bool on);
+void irq_switch_tick(unsigned int irq, bool on);
 void irq_clear_deferral(struct irq_desc *desc);
 void irq_clear_forward(struct irq_desc *desc);
 #else
@@ -1266,6 +1269,10 @@ static inline int irq_switch_oob(unsigned int irq, bool on)
 	return 0;
 }
 
+static inline void irq_switch_tick(unsigned int irq, bool on)
+{
+}
+
 static inline void irq_clear_deferral(struct irq_desc *desc) { }
 static inline void irq_clear_forward(struct irq_desc *desc) { }
 #endif	/* !CONFIG_IRQ_PIPELINE */
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 260ffd288bd81..c4e2d6a5d20d5 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -274,6 +274,11 @@ static inline int irq_is_oob(unsigned int irq)
 	return irq_check_status_bit(irq, IRQ_OOB);
 }
 
+static inline int irq_is_tick(unsigned int irq)
+{
+	return irq_check_status_bit(irq, IRQ_TICK);
+}
+
 void __irq_set_lockdep_class(unsigned int irq, struct lock_class_key *lock_class,
 			     struct lock_class_key *request_class);
 static inline void
diff --git a/kernel/irq/debug.h b/kernel/irq/debug.h
index 4eafd04a62962..9813c8ec66a44 100644
--- a/kernel/irq/debug.h
+++ b/kernel/irq/debug.h
@@ -34,6 +34,7 @@ static inline void print_irq_desc(unsigned int irq, struct irq_desc *desc)
 	___P(IRQ_NOTHREAD);
 	___P(IRQ_NOAUTOEN);
 	___P(IRQ_OOB);
+	___P(IRQ_TICK);
 
 	___PS(IRQS_AUTODETECT);
 	___PS(IRQS_REPLAY);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1c1920f5fbc08..a10d1081bea8c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -949,6 +949,17 @@ int irq_switch_oob(unsigned int irq, bool on)
 }
 EXPORT_SYMBOL_GPL(irq_switch_oob);
 
+void irq_switch_tick(unsigned int irq, bool on)
+{
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		if (on)
+			irq_settings_set_tick(scoped_irqdesc);
+		else
+			irq_settings_clr_tick(scoped_irqdesc);
+	}
+}
+EXPORT_SYMBOL_GPL(irq_switch_tick);
+
 #endif /* CONFIG_IRQ_PIPELINE */
 
 /*
diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
index 85ec0cbf5fb1e..ce4404b7b2c4d 100644
--- a/kernel/irq/pipeline.c
+++ b/kernel/irq/pipeline.c
@@ -1062,10 +1062,6 @@ bool handle_oob_irq(struct irq_desc *desc)
 static inline
 void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
 {
-	struct irq_pipeline_data *p;
-
-	if (desc->action == NULL || !(desc->action->flags & __IRQF_TIMER))
-		return;
 	/*
 	 * Given our deferred dispatching model for regular IRQs, we
 	 * record the preempted context registers only for the latest
@@ -1073,8 +1069,10 @@ void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
 	 * CPU times properly. It is assumed that no other interrupt
 	 * handler cares for such information.
 	 */
-	p = raw_cpu_ptr(&irq_pipeline);
-	arch_save_timer_regs(&p->tick_regs, regs);
+	if (irq_settings_is_tick(desc)) {
+		struct irq_pipeline_data *p = raw_cpu_ptr(&irq_pipeline);
+		arch_save_timer_regs(&p->tick_regs, regs);
+	}
 }
 
 static __always_inline
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 27a37d992f237..c4b48d22d271a 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -19,6 +19,7 @@ enum {
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
 	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
 	_IRQ_OOB		= IRQ_OOB,
+	_IRQ_TICK		= IRQ_TICK,
 	_IRQ_PROC_VALID		= IRQ_RESERVED,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
@@ -37,6 +38,7 @@ enum {
 #define IRQ_HIDDEN		GOT_YOU_MORON
 #define IRQ_NO_DEBUG		GOT_YOU_MORON
 #define IRQ_OOB			GOT_YOU_MORON
+#define IRQ_TICK		GOT_YOU_MORON
 #define IRQ_RESERVED		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
@@ -210,3 +212,18 @@ static inline void irq_settings_set_oob(struct irq_desc *desc)
 {
 	desc->status_use_accessors |= _IRQ_OOB;
 }
+
+static inline bool irq_settings_is_tick(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_TICK;
+}
+
+static inline void irq_settings_clr_tick(struct irq_desc *desc)
+{
+	desc->status_use_accessors &= ~_IRQ_TICK;
+}
+
+static inline void irq_settings_set_tick(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_TICK;
+}
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 0ed4122d40986..d8d2dd43baaa0 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp.h>
+#include <linux/irq.h>
 #include <linux/device.h>
 
 #include "tick-internal.h"
@@ -177,6 +178,8 @@ void clockevents_shutdown(struct clock_event_device *dev)
 	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 	dev->next_event = KTIME_MAX;
 	dev->next_event_forced = 0;
+	if (dev->features & CLOCK_EVT_FEAT_PIPELINE)
+		irq_switch_tick(dev->irq, false);
 }
 
 /**
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 90fae659e4ea6..d15bd478cef89 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -13,6 +13,7 @@
 #include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/nmi.h>
+#include <linux/irq.h>
 #include <linux/percpu.h>
 #include <linux/profile.h>
 #include <linux/sched.h>
@@ -244,6 +245,9 @@ static void tick_setup_device(struct tick_device *td,
 	if (!cpumask_equal(newdev->cpumask, cpumask))
 		irq_set_affinity(newdev->irq, cpumask);
 
+	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
+		irq_switch_tick(newdev->irq, true);
+
 	/*
 	 * When global broadcasting is active, check if the current
 	 * device is registered as a placeholder for broadcast mode.

-- 
Philippe.
