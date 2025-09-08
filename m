Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133B2EBDF4
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339575; cv=none; b=dxFZ3tlbu3mjVWygn4nIX7iOSO2st6d4lHe51tVEBlOWpSLamPZ5Nk1z3PCF/83JtgAqoAicqyTxeCdliZFEOdGKIXw3BSjY8qaL3nwCzTXJjEEdoKGFQLI3YXRheBv4ahujJGSHJGuhu2uTKwKmAlRpv5sZoYamBYJ306BSLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339575; c=relaxed/simple;
	bh=GVqeOKmiSNZDM/AQKa/ulx08pt0EF5JpF4eKy9v5SQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j+8W65YjhB2iyfIaxomvz+qypOGsRGkYuGOjjfEIwC73H5qwNlGqXXRhSlXjdIjh/CL+k8UHpKbZ9rPsSHwXotNLfEomef9x6PvvV6LpqW7pi5ND7/GO6ywi9C6EzRZBS4XAziVaB/lOrw7cfO4aA8LTywbJDL3OisNNN/mmr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DE3F42FD8;
	Mon,  8 Sep 2025 13:52:46 +0000 (UTC)
From: Philippe Gerum <philippe.gerum@gmail.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Philippe Gerum <philippe.gerum@gmail.com>,  xenomai@lists.linux.dev,
  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail v2] irq_pipeline: Fix system freeze triggered
 by periodic edge type IRQs
In-Reply-To: <312c039a18f033ee21137ec9af77b7d5a07ddf6a.camel@siemens.com>
	(Florian Bezdeka's message of "Mon, 08 Sep 2025 11:23:56 +0200")
References: <20250820-wip-flo-fix-edge-irq-handling-v2-1-1a958d17eace@siemens.com>
	<87ikhwk7y8.fsf@xenomai.org>
	<18e3f6b4f6f10574fafa5530be7bbeb1347fcfa1.camel@siemens.com>
	<312c039a18f033ee21137ec9af77b7d5a07ddf6a.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 08 Sep 2025 15:52:45 +0200
Message-ID: <87frcx830y.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceophhhihhlihhpphgvrdhgvghruhhmsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhkefgtdehueffhefgvedtveetfedvtdeukedvfeffvdejkedugffhteehveelleenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomhepphhhihhlihhpphgvrdhgvghruhhmsehgmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehphhhilhhiphhpvgdrghgvrhhumhesghhmrghilhdrtghomhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiu
 ggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

>
> I'm currently testing the following, which is heavily enspired by the
> upstream Fix for the IRQ migration issue:
>
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 45d0ab985068..acb6a580cc7f 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -638,6 +638,27 @@ static inline bool should_feed_pipeline(struct irq_desc *desc,
>         }
>  }
>  
> +static bool irq_active_on_this_cpu(struct irq_desc *desc)
> +{
> +       struct irq_data *data = &desc->irq_data;
> +       const struct cpumask *aff;
> +
> +       /* Check if active on any CPU */
> +       if (!irqd_irq_inprogress(data))
> +               return false;
> +
> +       /* The below works only for single target interrupts */
> +       if (!IS_ENABLED(CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK) ||

CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK is turned off in uniprocessor
builds which are still available with v6.16, in this case we can and
want to rely on the pipeline for serializing the IRQs,
i.e. irq_active_on_this_cpu() should yield true.

> +           !irqd_is_single_target(data) || desc->handle_irq != handle_edge_irq)
> +               return false;
> +
> +       aff = irq_data_get_effective_affinity_mask(data);
> +       if (cpumask_first(aff) != smp_processor_id())
> +               return false;
> +
> +       return true;
> +}
> +
>  static bool irq_can_handle_pm(struct irq_desc *desc)
>  {
>         unsigned int mask = IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
> @@ -668,6 +689,8 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
>                 WARN_ON_ONCE(irq_pipeline_debug() && !in_pipeline());
>                 if (irqd_is_wakeup_armed(&desc->irq_data))
>                         return true;
> +               if (irq_active_on_this_cpu(desc))
> +                       return true;

-- 
Philippe.
