Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBFE30F552
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252222; cv=none; b=mPeve2oSZqAzhDhojGco9DfXgY7BD1zQKw4Mz/6W0M90IAJbzMo0Mbao5uK/iCrvJH+nay0JQzub5cBWjrXotF7gng4oQjsMRDphyfx57vV+/p0K9LLJww0eO/Wl/kzCVG5cM2qwLsT5gjwAKBIas0gKCOSbKrTnxCzDkbSpxkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252222; c=relaxed/simple;
	bh=ShcKerxWYTPnSU1ksRu0NuK6kIMnBV3zLPTcbWGOnPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptbtHhQR4DHrrIqGBHp08SOsl3sGiPytBaZFuW95BoeJ3vdyN7lxl5U3V9xWVnDXqcaQ7j55nNZyH2h4UJqrB/Ae5SXzVQ+MjLOw3OVmbTzGlhsl3VRT+GhtU4HKJZtvLv8gVMZoHMfSzgaI8DVC+iCnG/f1pkW4y7JBC108qRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=n4a8UjYN; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="n4a8UjYN"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8CDA3EAF4;
	Mon, 16 Feb 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771252213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+N1aKpzNwb9WzWrwWIIJpXNM3wpd89wK9UwcXGal4yI=;
	b=n4a8UjYNnFcoN1Ej3FMJJlcxjweYsf17pzVAy+8uR1WfBWgpcaE1O7/38maxBdR8Zy4F36
	qv8/3LI6h2j/wiNujNkSs7ahrtk1pJe4jSElOWjHcRfO8mm2K1/rFwg7h7p26lZ7kZMCu6
	4DOluvmDsA0tUnEL+9UvSMISz5tOwsyHommXwyn9+msQ9zELI2AYZndm6NN0RsP1BP0vIy
	60V6OPzQhmlqPoY4G2QPZj0SkUotX8LAyX5aRSv/f8wb3l8ziNNdeBGHekv+2eqZkAGvBR
	9hLL37Pa5OVg7MgWtERmMJSjUA1MZawFwxvXk6zguDM6begjozUfAcUDZQ2JtQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH dovetail] irq_pipeline: synchronize inband IRQ log in
 exit_to_user_mode_prepare()
In-Reply-To: <5b5db336-84f6-4add-a485-6414f7a2f190@siemens.com> (Florian
	Bezdeka's message of "Sun, 15 Feb 2026 00:25:07 +0100")
References: <20260214113941.91453-1-tobias.schaffner@siemens.com>
	<5b5db336-84f6-4add-a485-6414f7a2f190@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 16 Feb 2026 15:30:03 +0100
Message-ID: <87jywc4v84.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepteekveffteefgfethfegpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghom
 h
X-GND-State: clean

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On 2/14/26 12:39, Tobias Schaffner wrote:
>> Architectures using the generic handle_irq_pipelined() path do not
>
> arm64 and x86 are not using that, so the only arch left is arm.
> See below...
>
>> synchronize the inband IRQ log in handle_irq_pipelined_finish()
>> because inband is still stalled from irqentry_enter() when it gets
>> called.
>
> I think the real issue / correct wording is:
>
> _TIF_WORK is left pending on IRQ exit.
>

More precisely, some IRQs might be logged for the in-band stage (taken
during stage demotion but virtually masked, as your pointed out), and we
must play them before returning to userland.

[snip]

> Taken from arm64/x86:
> if (unlikely(running_oob() || irqs_disabled())) {
> 	...
> 	handle_irq_pipelined_finish(prevd, regs);
> 	if (running_inband() && user_mode(regs)) {
> 		stall_inband_nocheck();
> 		irqentry_exit_to_user_mode(regs);
> 	}
> 	...
> }
>
>>  again:
>>  	ti_work = read_thread_flags();
>>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))

Incidentally, I just noticed that arm64 looks wrong
here. arm64_pipeline_el0_irq() lacks the demotion check in the
running_oob() case, and arm64_pipeline_el1_irq() unfortunately checks
for user_mode(regs) in arm64_pipeline_el1_irq(). I'll leave the
conclusion to the careful reader.

>
> That said, we should double check that this corner case is handled right
> on arm. If arm suffers from the same problem, this corner case is
> missing in handle_irq_pipelined().
>
> I hope all of this makes sense at the end. It's late...
>
> Best regards,
> Florian
>
> [2. text/vcard; florian_bezdeka.vcf]...

-- 
Philippe.
