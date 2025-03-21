Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217571F1511
	for <xenomai@lists.linux.dev>; Fri, 21 Mar 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563924; cv=none; b=b1w2Ixs/jS2zXackxjGl2JvrmaKPKs9H+tH5HaNJx8QCrVfAQRNrTnHP8HyX33Ok6V9cWYH5GTqiGzMdvEGn3OugDH9LAm2ViDxgueSywIDJFYYtmztcJFazgVAXN9No5ORIKYINE1rw3hlsweed4GMymlN5NEjjgYC9V2vLkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563924; c=relaxed/simple;
	bh=0WcdPmj0kmAnAGAERPv7Zzc4S7C687u6gTZlGdeosaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqWXcGMUjcowsvRZS+KKENVEuMsribMXNlatXD8hCPDvRRL8IZAQKKiQwUbQJJKJSasKoX44CY6vkmX3XIIXx8BXRL09LeN3J5hKqc94LixxNej4x2kIm0ifn/mbGyuw1gH4bPkDRuj/mjpykVZ3sDL1QpAJsvTuXkDg50Zxko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=bTr58ZaM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="bTr58ZaM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 260F3443F5;
	Fri, 21 Mar 2025 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742563919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDL93CcG8+0I0ka83mQszElYPLKzIohiqSMyPbl+Jos=;
	b=bTr58ZaMx1yV3jQ+3fLDfcQYnfJTm9icRFDc4o3bHOJxpvPvKi75wTEza0l1HfPnOXsebv
	HV7gdaQuGlXQWilwoDYLOLftUD2L0uk45hpiXYWNv7rCTo2pTx1nLBQ/VkpF+ARyPR1yRB
	8e6Yq1QBdHROX4q90aAFvbw+NIr9z4UYtDHyva05g7J7TneP17njSRRqGn9Nza1FQZGMkM
	NMyt9snjgNokXm8KKAe2QiArIkPgaNmtqCPDE80t/ZCl0MwWNJ6PshgXPS5ISaNKcsBc5h
	91BioweGnnvc3gz3C4nim6/La3me2ewzC4Jl1P4vDVNlwR+OT1R8RYkb5DlZHg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
In-Reply-To: <1b298aee5042ea0948591be9e5922f204fcc22b6.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 21 Mar 2025 13:51:39 +0100")
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
	<87r02qlt34.fsf@xenomai.org>
	<1b298aee5042ea0948591be9e5922f204fcc22b6.camel@siemens.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Mar 2025 14:31:58 +0100
Message-ID: <87ldsyldbl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevkeeukedvhedtieelveduleelleduhfeuvdegffeujeffheefffefhfehveelieenucffohhmrghinhepudegrdhnohifnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2025-03-21 at 08:51 +0100, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>> > From: Jan Kiszka <jan.kiszka@siemens.com>
>> > 
>> > We had unbalanced hard_cond_local_irq_disable here so far.
>> > 
>> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> > ---
>> > 
>> > Minus one hunk that is already in current 6.12.y, this needs to be 
>> > applied to older stable versions as well.
>> > 
>> >  kernel/power/hibernate.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> > 
>> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> > index 733b1a196f09e..e1c05f276a453 100644
>> > --- a/kernel/power/hibernate.c
>> > +++ b/kernel/power/hibernate.c
>> > @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>> >  	syscore_resume();
>> >  
>> >   Enable_irqs:
>> > +	hard_cond_local_irq_enable();
>> >  	system_state = SYSTEM_RUNNING;
>> >  	local_irq_enable();
>> >  
>> > @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>> >  	syscore_resume();
>> >  
>> >   Enable_irqs:
>> > +	hard_cond_local_irq_enable();
>> >  	system_state = SYSTEM_RUNNING;
>> >  	local_irq_enable();
>> >  
>> > @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>> >   Power_up:
>> >  	syscore_resume();
>> >   Enable_irqs:
>> > +	hard_cond_local_irq_enable();
>> >  	system_state = SYSTEM_RUNNING;
>> >  	local_irq_enable();
>> 
>> Merged into v6.12 and backported to v6.1.y-cip, thanks.
>
> Sorry, but I have to highlight that this patch does not help at all.
> Testing shows that we already "hang" when trying to hibernate. We never
> make it into the "wakeup" path.
>
> I think the "process" we followed here is broken. First we have to
> implement and *TEST* things in latest development branches and once we
> are sure we fully addressed the problem back porting can happen.

The point is that this has never been a new and/or untested feature, we
may be seeing a regression on all versions of a feature that did work
for ages, the story does not start with v6.14. Now, the tricky issue
with hibernation is not necessarily in the code paths above, but most
likely in one of the many suspend/resume handlers, which are per-driver
beasts. First of all, we need to define a test configuration with
suspend/resume code which is known to work.

-- 
Philippe.
