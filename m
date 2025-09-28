Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2854918
	for <xenomai@lists.linux.dev>; Sun, 28 Sep 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044279; cv=none; b=K0MNLDxRveJKQKncOwjv2cpAIxHZ5ceXhoM8xrqDB4+mFVX4Du4rZ/RcONpumgB5nX2GNQjypGSw2Jiru34aMhzlgCNFRQXrEtt37KjooWQQ4lSXVEYM9Y5AZ8dH6TDGbS3Yq6AAcMhb+46jeH3cNMSUmI11SPV4BfCDqfedzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044279; c=relaxed/simple;
	bh=DchC8Lon3/Ka4v7NDqID4vfD1Qtwz9bZOhKeHfn+tog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AqIwuIR1qWCW9BfD094TZakdQKtLamgnzAAcw1X7hSbseIcEyxc15YIAQI09gZOPkQLMQl2anE1euILLBiNRt79fueQ9Doq8togp+hFDs1cr6oE1o5wmU34SDIz7yePgOgFh7qUxmsz1stSG1Hu+WEzMnBSfmqVbnREZMyriv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=PYQNO5Md; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="PYQNO5Md"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4CA64336D;
	Sun, 28 Sep 2025 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1759044268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWd+in6q6Ovpc4PzMkzq8q+1l0EbZRfrOkQoIlc5f74=;
	b=PYQNO5MdqgdD+lEyTy6bM+XEb9yueBgJlV6L+ISSJJEqJUZacdGXdjTjHzJPBGh87EroQy
	fOo5DIaAQy3xj9yOepoh+x48ByYoREzJGnyJo+7oXTduCNLgZRXe7r0g3TogHhJF6PCWfn
	MOFO8T3a+Bedw4nuFi5q5BUmxrO0iL5KaJEtoFpnCt43zE7nVoWIENC+QdsioGWe6U39WH
	V9A9XzOPSFHpMSTuI02Wt08LvFyTGMWHXThVuu/2ARqY4hkarqIsdFvyxrXhyALn/pramh
	dBpFinE3qvUGrK1eq2iRNtWJT2qCGwtqmeSvQJlQyBwyRrChrgepay8LMDGP1g==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 1/4] clocksource/hyper-v: irq_pipeline: Enable pipelined
 clock events
In-Reply-To: <11dda4abd1986a4abcb0dca5af57f3fe8bb40bbe.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 24 Sep 2025 09:51:58 +0200")
References: <20250602-flo-add-hyperv-support-for-6-15-v1-0-449e6c20debd@siemens.com>
	<20250602-flo-add-hyperv-support-for-6-15-v1-1-449e6c20debd@siemens.com>
	<87h5wtm2ot.fsf@xenomai.org>
	<11dda4abd1986a4abcb0dca5af57f3fe8bb40bbe.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sun, 28 Sep 2025 09:24:24 +0200
Message-ID: <87jz1jrqdz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejgeehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2025-09-23 at 20:41 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Fixes a boot failure on hyper-v.
>> > 
>> 
>> A bit of context would help here. Failure doing what, enabling the proxy
>> tick on STIMER0?
>
> ACK. That goes back to the early phase of enabling hyper-v where I
> simply did not care about story telling yet.
>
> Proposal:
>
> Make the clock event around the STIMER0 pipeline safe. The
> implementation is following the same pattern that we already have in
> place for the x86 LAPIC interrupt / clock event.
>
> To get the proxy tick working we need to link the hyperv clock event
> device with the STIMER0 vector. This part is also following the pattern
> of the x86 lapic interrupt. Both have a fixed arch specific vector
> assigned.
>

LGTM.

>> 
>> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > ---
>> >  drivers/clocksource/hyperv_timer.c | 34 +++++++++++++++++++++++++++++++++-
>> >  1 file changed, 33 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
>> > index 2edc13ca184e0..0850b0c385a8e 100644
>> > --- a/drivers/clocksource/hyperv_timer.c
>> > +++ b/drivers/clocksource/hyperv_timer.c
>> > @@ -26,6 +26,7 @@
>> >  #include <clocksource/hyperv_timer.h>
>> >  #include <hyperv/hvhdk.h>
>> >  #include <asm/mshyperv.h>
>> > +#include <asm/trace/irq_vectors.h>
>> >  
>> >  static struct clock_event_device __percpu *hv_clock_event;
>> >  /* Note: offset can hold negative values after hibernation. */
>> > @@ -53,6 +54,30 @@ static int stimer0_irq = -1;
>> >  static int stimer0_message_sint;
>> >  static __maybe_unused DEFINE_PER_CPU(long, stimer0_evt);
>> >  
>> > +#ifdef CONFIG_IRQ_PIPELINE
>> > +
>> > +#define HV_STIMER_IRQ	apicm_vector_irq(HYPERV_STIMER0_VECTOR)
>> > +
>> 
>> Does this mean that we won't support Hyper-V on architectures with
>> per-CPU irqs (according to the comment heading hv_setup_stimer0_irq()),
>> or is this ok to always bypass the ACPI in order to get the STIMER0
>> interrupt in the pipeline case?
>
> I came along the same question during implementation. The most
> confusing part is, that this per-cpu IRQ implementation has no in-tree
> user - or I could not find it.
>
> It all starts in hv_stimer_setup_percpu_clockev() (x86 specific) where
> we have the only user of hv_stimer_alloc() with have_percpu_irqs set to
> false.
>
> With that I decided to follow the same pattern as we have in place for
> the APIC timer IRQ on x86.
>

Makes sense to me too.

>> 
>> > +static irqreturn_t hv_stimer_oob_handler(int irq, void *dev_id)
>> > +{
>> > +	struct clock_event_device *evt = this_cpu_ptr(hv_clock_event);
>> > +
>> > +	trace_local_timer_entry(HYPERV_STIMER0_VECTOR);
>> > +	clockevents_handle_event(evt);
>> > +	trace_local_timer_exit(HYPERV_STIMER0_VECTOR);
>> > +
>> > +	return IRQ_HANDLED;
>> > +}
>> > +
>> 
>> Could not we have hv_stimer0_isr() call clockevents_handle_event()
>> instead, so that hv_setup_stimer0_irq() -> hv_stimer0_percpu_isr() could
>> be reused, only fixed up for picking the IRQ number from the apic
>> mapping if interrupts are pipelined?
>
> I definitely tried updating hv_stimer0_isr() to call
> clockevents_handle_event(). It has been a while so I'm not sure if
> memories are still correct: It might happen that the STIMER0 IRQ fires
> before the proxy tick infrastructure is in place, so it ended up in
> "ignoring a timer tick".
>
> In any case there was/is a reason why the LAPIC is using
> local_apic_timer_interrupt() for a short period in time and later moves
> on to the oob action. The same reason applied to STIMER0.
>

Ok. Another way would be to make the handler bullet-proof to the
inband->oob transition of the clock device if this is indeed the issue
at stake, following the same pattern than armv7 is implementing, i.e.:

static irqreturn_t twd_handler(int irq, void *dev_id)
{
	struct clock_event_device *evt = dev_id;

	if ((running_inband() && clockevent_is_oob(evt)) || twd_timer_ack()) {
		clockevents_handle_event(evt);
		return IRQ_HANDLED;
	}

	return IRQ_NONE;
}

This said, Hyper-v is hardly going to be a hot spot for pipeline-related
changes, so I'm ok with the fully decoupled approach you suggested.

-- 
Philippe.
