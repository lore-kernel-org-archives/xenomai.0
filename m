Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093487;
	b=PZkt2uhpG94SXibS5/TCRvVaaB1pomPZ7oQgmYS8a/Zju7puZi+fk+1u1aF6+VbYQOjr
	 9xYpoWzVm0uDCe0ZYez9dyFrTSCtwpveVZKoDqVjD27x8+VtBPQAOCe37uTsjk0BFa/iu
	 5k6KnMdZAb67grQa1BhZ8WqhZTWNEfAlpGZaBdeSHajmLboBxJTOO/ZiWiojezGY+pP5N
	 5XrRjg48d5hO0CLpFfb9El/sQzlYac+oBX8TSKVDXf1OueAyEuTjL0AhfmeBvyyJXlclq
	 MEsrGPvaMkDmPcQ8iTXJSHEZDUGgVaLRQAgXBmlgQWf/N/uiW3q32mQvIWrjq3XbZEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093487;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 X-GND-Sasl:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=bToYbfeVDkHCI+CFF0e9U/g4MdNaB/atnwufCfOpqjg=;
	b=fUjS82x00GOINNHW36LOVPLtBpK/FdhJKMQ1lPd0Y498UW2olpvAK1PmrQ+f/25BA+wT
	 7o2CUhVCKNBJ6tWtxHFpffeWKjKmOFBfLAqn2DKlW5uogPT4KioxCrNF1TL8i7Nj1ZAlL
	 D47u6AWL2cnjmtRukH55TOjL9fo8YstDCJb1k8i1doiIB5lmzG8cVX+hs+gz7z+BCkoR5
	 o2etni3duZPEBDPNZR/VLw+6xWEZUk5tzRPe2IiDIv5xToA/8F71Ypo7XBaB/ZgtfFzux
	 W/pVel+hNezyYfbB0FD/moTQ9QdE8OHNc98zB3GctYPcN4yBI7hqbulZk8Mjpnz38dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=hxcPuWQR;
	arc=none smtp.remote-ip=217.70.183.200
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD921606A326
	for <xenomai@lists.linux.dev>; Thu, 19 Nov 2026 13:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD921606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=hxcPuWQR
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BB623ECAB;
	Thu, 19 Nov 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795093477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bToYbfeVDkHCI+CFF0e9U/g4MdNaB/atnwufCfOpqjg=;
	b=hxcPuWQRIaJgCaiHKDCBTRcxzcTYzCuyc/rFhywbTYt3bK3RLWw9s6Au2D4zJ3SvxWsNGz
	BaRr57FHhJgTAnDQmpdQRuLltxy+nk+pd+qzZUrc7SP0r76GKtNUPVxtB4zUcXkVboHC38
	1QoSE8e0Sfc+CqnmVH6I0IgXLm9s+o7V3qTQVwX2LJZDzDaRiSihD6QVifWAAAhg/U5Aga
	gfNAkCqwSidOxXXb9WvWF8WhZGNmXhhM0LSKXMZqCC7zR8P+oNsUaB+tKod1qoZvApWyCf
	uNbuyXFQGsqN9J970qEM26d29a7xxm5w0j3Ya9a1tZDfAMVg+lmRkkrO9Z9xBw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Florian Bezdeka
 <florian.bezdeka@siemens.com>
Subject: Re: [dovetail][PATCH] irq_pipeline: tick: keep IRQ_TICK set on
 shutdown
In-Reply-To: <42645f8a-126f-42dc-bae5-c23230041fe8@siemens.com> (Jan Kiszka's
	message of "Tue, 17 Nov 2026 19:32:53 +0100")
References: <42645f8a-126f-42dc-bae5-c23230041fe8@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 14:04:37 +0100
Message-ID: <87wlq9nfa2.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGhSEWPNzH4TkKRh/ufJFTd1CqHfJLN1JVBG3S0LYwo9DMWIX1r7Zhx8/onQlalGAtJ/9IWaaimguwd4YBtRjJGTFBzaVnKiEOfX1c6XA3O9zzOpOi4d0V7Y0dECIKv4wkCKum/6XQQpLd7/IP0idJvYFDFauCR18/lRgQpZ/1kP/GvSWyd6pmni/lfn0LnKoGKCPodLjspkkhMIXafUeihkL/SgvdsGrYJ78fkqycrqiBlRU2Heo9yAn7kvWRE41sZft99gS46ipgakI3RK3veMz8DLmOTIc3/ixR5wv/EOdKgCxsXPB7PuOpLhTNG5VbY07jb0jTzDUPcfTVj8yCAlHLl7BE+aFHWYV3MLSNY1bMNHl1AnQ7qLrYJeisIK5FsskbmhBQJqT99O/SKaXUEJWQ+Mh5N7gS+RWTH+BJU/7l0Wi7MovKcjT2a/y83eocX4Q8o8zu7VmRaBi3Wweps09yvq9OkjAzVxK34SM9Br9DtjCQDKPVRbHtezCh7PpnnN/2Q5Inw9pd3et8y6AnKWW7tDUsuE5Xl4/MqXU+QiD97TF2l9YXnmB41J1NsGNlnnxyQGBzxyQkvH5IIEqluEAdAdtslv1/dJy2ibt+KhTWzXIvBJqh6/Cmmlmh6G28ntDQOQAaCBFR5kL1tFlFLDSpF+zg0e0rGOOmwuN/AdQ

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> IRQ_TICK is set on the interrupt of a pipelined clock event device by
> tick_setup_device(), but cleared again by every call to
> clockevents_shutdown(). Several paths shut down a tick device and
> restart it later without going through tick_setup_device():
>
> - tick_suspend_local() / tick_resume_local(), on suspend to RAM and
>   on suspend to idle (tick_freeze/tick_unfreeze).
> - tick_broadcast_control(TICK_BROADCAST_ON) while the broadcast
>   device runs in periodic mode, undone by tick_setup_periodic() on
>   TICK_BROADCAST_OFF.
>
> In addition, per-CPU clock event devices share a single interrupt
> descriptor, so shutting down the device on one CPU clears the mark
> for all CPUs, including those still receiving ticks over it.
>
> Once the mark is lost, the pipeline entry code stops saving the
> interrupted registers for the in-band tick, which then accounts the
> CPU time and reports RCU quiescent states based on stale registers.
>
> Restoring the mark from clockevents_tick_resume() would only cover
> the suspend paths. Make it sticky instead: once an interrupt has
> driven a tick device, keep it marked. If the device stops being used
> for ticks, the mark only causes the registers of a more recent
> interrupt to be recorded, which is harmless.
>
> As irq_switch_tick(irq, false) is no longer used, rename it to
> irq_mark_tick() and clean up related bits.
>
> Assisted-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> This is now one option to address the issue brought forward in
> https://lore.kernel.org/xenomai/9b439d13-7d33-419d-9d4a-2b224bf5db7d@siemens.com/T/#u.
>
>  include/linux/irq.h       |  4 ++--
>  kernel/irq/manage.c       | 11 +++--------
>  kernel/irq/settings.h     |  5 -----
>  kernel/time/clockevents.c |  3 ---
>  kernel/time/tick-common.c |  7 ++++++-
>  5 files changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b9e4f12271ed3..0862d64b7ee4f 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -1260,7 +1260,7 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
>  
>  #ifdef CONFIG_IRQ_PIPELINE
>  int irq_switch_oob(unsigned int irq, bool on);
> -void irq_switch_tick(unsigned int irq, bool on);
> +void irq_mark_tick(unsigned int irq);
>  void irq_clear_deferral(struct irq_desc *desc);
>  void irq_clear_forward(struct irq_desc *desc);
>  #else
> @@ -1269,7 +1269,7 @@ static inline int irq_switch_oob(unsigned int irq, bool on)
>  	return 0;
>  }
>  
> -static inline void irq_switch_tick(unsigned int irq, bool on)
> +static inline void irq_mark_tick(unsigned int irq)
>  {
>  }
>  
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index bbd7c0208444f..943541b1c9fff 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -950,16 +950,11 @@ int irq_switch_oob(unsigned int irq, bool on)
>  }
>  EXPORT_SYMBOL_GPL(irq_switch_oob);
>  
> -void irq_switch_tick(unsigned int irq, bool on)
> +void irq_mark_tick(unsigned int irq)
>  {
> -	scoped_irqdesc_get_and_lock(irq, 0) {
> -		if (on)
> -			irq_settings_set_tick(scoped_irqdesc);
> -		else
> -			irq_settings_clr_tick(scoped_irqdesc);
> -	}
> +	scoped_irqdesc_get_and_lock(irq, 0)
> +		irq_settings_set_tick(scoped_irqdesc);
>  }
> -EXPORT_SYMBOL_GPL(irq_switch_tick);
>  
>  #endif /* CONFIG_IRQ_PIPELINE */
>  
> diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
> index 0a57c2080cacd..d1336b82c248f 100644
> --- a/kernel/irq/settings.h
> +++ b/kernel/irq/settings.h
> @@ -218,11 +218,6 @@ static inline bool irq_settings_is_tick(struct irq_desc *desc)
>  	return desc->status_use_accessors & _IRQ_TICK;
>  }
>  
> -static inline void irq_settings_clr_tick(struct irq_desc *desc)
> -{
> -	desc->status_use_accessors &= ~_IRQ_TICK;
> -}
> -
>  static inline void irq_settings_set_tick(struct irq_desc *desc)
>  {
>  	desc->status_use_accessors |= _IRQ_TICK;
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index 3cf30dead25d1..5138c17fd567d 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -12,7 +12,6 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/smp.h>
> -#include <linux/irq.h>
>  #include <linux/device.h>
>  
>  #include "tick-internal.h"
> @@ -178,8 +177,6 @@ void clockevents_shutdown(struct clock_event_device *dev)
>  	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
>  	dev->next_event = KTIME_MAX;
>  	dev->next_event_forced = 0;
> -	if (dev->features & CLOCK_EVT_FEAT_PIPELINE)
> -		irq_switch_tick(dev->irq, false);
>  }
>  
>  /**
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index bfb26d9d687ab..56e3ec9c754b3 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -245,8 +245,13 @@ static void tick_setup_device(struct tick_device *td,
>  	if (!cpumask_equal(newdev->cpumask, cpumask))
>  		irq_set_affinity(newdev->irq, cpumask);
>  
> +	/*
> +	 * This mark is never cleared: tick devices may be shut down and
> +	 * restarted without passing here again (suspend, periodic broadcast),
> +	 * and per-CPU devices share a single interrupt descriptor.
> +	 */
>  	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
> -		irq_switch_tick(newdev->irq, true);
> +		irq_mark_tick(newdev->irq);
>  
>  	/*
>  	 * When global broadcasting is active, check if the current

Merged, thanks.

-- 
Philippe.
