Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AC36165C
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335077; cv=none; b=N0KblfHPy2+fP8SziEkk4XYg9DiYlYCE62MfeK7jQGZ9mHO+PSqfqv7owhDBqFIYbSQeAB4ZEcdlULvCY+F6YXp/67Nc+fpZlwk5hkarqvgdTDt+QWoRG+AYL1xiOZ5tC2hA9psq5xBgZnIIdI3WVzRN/5g03ZusRAkcQk9GJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335077; c=relaxed/simple;
	bh=YT9ffT4TnC24BJtjAJTFLK5Cu2KK3pZDc0JXIkU/4s0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fE/5TniTXM6Qz4cZmX5uQ6M3Y2vQIXz0+dWAiypuIAyzwjczwNnyV/6FklC2nZYOJErAdVwp+UfaLcqjzly+uF0PDnjfB6RflFtntlDq73+lwCLjSpHFcqvCabMK30dCkAuzk6znxdqE+z6snvdGahIhIIUr/tqYFVJN6ikiKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=KZNhmhqh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="KZNhmhqh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE5F33E9F0;
	Tue, 17 Feb 2026 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771335073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7wdl0DT0Fu9AprySqsSWIhMXIzaifF4ffVsdpKBcAI=;
	b=KZNhmhqhZo6JkOzm5P4NXarEDu/k/PtYDjL9+ahaqWQ73IrnJszJm90sEJsJUU/Aj5pdX4
	+ucPdJocCeqWeysJzCv8ncoPyjtoQNWPVDb2VIPkWv05SQ5lnzOTMZWv7RMJcKzzrjWEW8
	gMkXNuzRPS2kZxe/h3CbbYnpL43kUgk+dKfXKQpH+x6z2ndZuZzeMKjscudkXfO9suoKOi
	NIoy615nY89O7yKB9NscwwRpvJ93jz92cQCiWAfpC3+0ihL9/NQ622YHhFn9QHQWxjYgE4
	dpcuKhhCg85Amq3xu97KeZ9xcOlUoalchrBdaUn3/s679I8TqQOWLgjOVjOP3w==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
In-Reply-To: <36ce9316dacdc92bfc02ea2888e05d424bf5c9b7.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 17 Feb 2026 12:23:42 +0100")
References: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
	<87jywbajfy.fsf@xenomai.org>
	<505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
	<9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
	<87ecmjahk3.fsf@xenomai.org>
	<430245ce2bc8da023235e9cf1312f729d7c57494.camel@siemens.com>
	<87tsvf9081.fsf@xenomai.org> <87o6ln8yt1.fsf@xenomai.org>
	<36ce9316dacdc92bfc02ea2888e05d424bf5c9b7.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Feb 2026 14:31:12 +0100
Message-ID: <87ikbv8pjz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvefghefhfeefgfelhfdtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-02-17 at 11:11 +0100, Philippe Gerum wrote:
>> Philippe Gerum <rpm@xenomai.org> writes:
>> 
>> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > 
>> > > On Tue, 2026-02-17 at 09:41 +0100, Philippe Gerum wrote:
>> > > > > Comparing with x86 again, I think that my proposal is "correct" in terms
>> > > > > of identical to what x86 does. Do all architectures have a gap here?
>> > > > 
>> > > > x86 has a single implementation for both user and kernel preemption
>> > > > paths, arm64 has two since the privilege level is explicitly stated by
>> > > > the irq handler being called, but this still must translate identically
>> > > > logically speaking. Your implementation is missing the kernel preemption
>> > > > path after demotion.
>> > > > 
>> > > > i.e. when checking for running_oob() || irqs_disabled(), the cases
>> > > > covered are:
>> > > > 
>> > > > (1) in-band user path on entry (implies !irqs_disabled())
>> > > > (2) oob user path on entry (might be demoted)
>> > > > (3) (virtually) stalled in-band kernel path on entry (implies no reschedule,
>> > > >   filtered out by irqentry_exit())
>> > > > (4) oob kernel path on entry (might be demoted)
>> > > > 
>> > > > Therefore, with your patch in, el1 is now missing (4).
>> > > 
>> > > Right, but I'm wondering if x86 ignores this case as well.
>> > > 
>> > > After demotion of a oob kernel path entry, user_mode() should still be
>> > > false - bypassing the call to irqentry_exit_to_user_mode() - No?
>> > 
>> > Yes, x86 assumes that a kernel path demoted to in-band is going to cross
>> > an IRQ synchronization point shortly after on return to the preempted
>> > context. Now, with hindsight, the question is: are we 100% certain of
>> > that? Any real (hw) IRQ over the in-band stage would trigger the
>> > synchronization as expected, but a synthetic one posted from the oob
>> > stage might linger if this assumption ends up being wrong. I need to
>> > have a second look at this code.
>> 
>> Which means that your latest patch series is ok and complete. The change
>> if any would most likely happen in the generic pipeline bits.
>
> I think (2) is still wrong on arm64 now, so:
>
> @@ -65,15 +65,17 @@ static noinstr void arm64_pipeline_el0_irq(struct
> pt_regs *regs,
>                                 void (*handler)(struct pt_regs *))
>  {
>         struct irq_stage_data *prevd;
> +       bool oob_on_enter;
>  
>         arm64_enter_from_user_mode(regs);
>         instrumentation_begin();
>         /* Prep for handling, switching oob if needed. */
> +       oob_on_enter = running_oob();
>         prevd = handle_irq_pipelined_prepare(regs);
>         do_interrupt_handler(regs, handler);
>         /* Done, unwind now. */
>         handle_irq_pipelined_finish(prevd, regs);
> -       if (running_inband()) {
> +       if (oob_on_enter && running_inband()) {
>                 stall_inband_nocheck();
>                 irqentry_exit_to_user_mode(regs);
>         }
>
> Do you agree?
>

On a second look, _el0 needs no particular handling of the demotion
case, because arm64_exit_to_user_mode() already does what is required.

-- 
Philippe.
