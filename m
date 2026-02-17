Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4E2D59FA
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315651; cv=none; b=Nd17vQFP6IkUPVry5F2PzQ7Ox9SCUzNcP5mbGoa0618he021/5WJZxAK4DlOsaJFy2h/izX1x4BqSPNTuQ9wCaSQlLqfcZGan7nJsDS2ECIbr7Fr48+MDxhFSkQFSAk7Ht3mVdUYJj70DRFm82H9HRdfnrcPjXu+YBlIemoV+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315651; c=relaxed/simple;
	bh=lgzape97VBTSH8g4Sn4ffM5oBqcg2AeUOu2+qSZoYfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lsflFpyy1+T8qM7o6/DEVdkX4X+BpBpyyawYYp+05ydfzeZdAa7KF3d/uSh446INDdiXpkPAlgh/3SimW55Gc9NvTyM2YI+vmGaI2sOCZ1zl3l6bHWuUfCgq9lYeFFkDr+IPSxZwH9v8UNCLiYzGUYNCTskweEJEWa3AvSn7p44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fDID5y3T; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fDID5y3T"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 1ECD65813BA
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 08:00:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9A474326D;
	Tue, 17 Feb 2026 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771315225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PW/Y8yXp1o00s+IcJf8yi0FZtw2FljC7Pv+blsrlbt4=;
	b=fDID5y3T5U1jHcGXA4z64sYAuk4JIzec+u1Wrbw0W675RTxkeJBGEoX9TEFXdml3pZHEzY
	ipxDcwztjFctsvIVkCX8q4nhxXQ83Cb84eSa6NW3AQRfhWvZ5l4tBFPqwa8vKFY8vcG0Hk
	NgpUv9r4+aTFQTVf9ADV/uq7bEs1kft9I+3HuBNdSVf0fHKnu8Sze7CdeWomZsOrGHq5qi
	HSvdR+nhZognxIhpC6y4YzLWC6m2Qz7ElEUMikAzwDei8tDmdsXtT+Yla9Y+NH2U469Yi9
	CTveHWqFs2GU7Xnr4fOvFUfpAAYf7Fo9nxc6Isv7w8DTja1ispX9g1x634q/YA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
In-Reply-To: <20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
	(Florian Bezdeka's message of "Mon, 16 Feb 2026 20:05:26 +0100")
References: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Feb 2026 09:00:17 +0100
Message-ID: <87jywbajfy.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfelteegjeegfedvieffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> While reviewing some of the low level pipeline code I realized that
> the checks for task demotion are wrong on arm64.
>
> el0: The demotion check was missing in the oob case. We have to check
>      for running_inband() only as user_mode(regs) will always be true.
>      We are serving an IRQ over el0, so application / user mode.
>
> el1: The demotion check was unnecessary and "inactive" as
>      user_mode(regs) is never true on el1, we are serving an IRQ over
>      kernel mode.
>

If the demotion happens from el1, you still want to check for a
rescheduling opportunity (i.e. kernel preemption case).

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/arm64/kernel/entry-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 07fa70713ce04eaf3df9223354babcecde923280..9c99eb3d18c459a90e1f7ce4e4c307e235e457a2 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -73,6 +73,10 @@ static noinstr void arm64_pipeline_el0_irq(struct pt_regs *regs,
>  	do_interrupt_handler(regs, handler);
>  	/* Done, unwind now. */
>  	handle_irq_pipelined_finish(prevd, regs);
> +	if (running_inband()) {
> +		stall_inband_nocheck();
> +		irqentry_exit_to_user_mode(regs);
> +	}
>  	instrumentation_end();
>  	arm64_exit_to_user_mode(regs);
>  }
> @@ -90,10 +94,6 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
>  		prevd = handle_irq_pipelined_prepare(regs);
>  		do_interrupt_handler(regs, handler);
>  		handle_irq_pipelined_finish(prevd, regs);
> -		if (running_inband() && user_mode(regs)) {
> -			stall_inband_nocheck();
> -			irqentry_exit_to_user_mode(regs);
> -		}
>  		instrumentation_end();
>  		mte_check_tfsr_exit();
>  		return;

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index e0227d467cef4..770fc4059e083 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -90,10 +90,8 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
 		prevd = handle_irq_pipelined_prepare(regs);
 		do_interrupt_handler(regs, handler);
 		handle_irq_pipelined_finish(prevd, regs);
-		if (running_inband() && user_mode(regs)) {
-			stall_inband_nocheck();
-			irqentry_exit_to_user_mode(regs);
-		}
+		if (running_inband())
+			goto out_irqentry;
 		instrumentation_end();
 		mte_check_tfsr_exit();
 		return;
@@ -109,6 +107,7 @@ static noinstr void arm64_pipeline_el1_irq(struct pt_regs *regs,
 	trace_hardirqs_on();
 	unstall_inband_nocheck();
 	handle_irq_pipelined_finish(prevd, regs);
+out_irqentry:
 	stall_inband_nocheck();
 	trace_hardirqs_off();
 	instrumentation_end();

-- 
Philippe.
