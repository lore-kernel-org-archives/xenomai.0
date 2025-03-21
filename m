Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9442A94
	for <xenomai@lists.linux.dev>; Fri, 21 Mar 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565099; cv=none; b=ZpByUThaazEwj2OazRNdYMNgCULoIfcb/IUcBfWeL3vAZQ/TDGNZfSJd92hQw6YWTJ20g7O1GQeQl/0iBehZN3hnaiBaXvjgXyKSsApPHmNyaj6yn7CLngGgnDKUMLPcqogadb/Ga2HxCuS4zEK2EJDbpRe5I9xK2Seq5Pu7HvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565099; c=relaxed/simple;
	bh=7DSwQ6VUdri3LYhPCIZbv2Wip6bFq8i/pPH+CTYpn8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRpTm7EfWDrX57JRV9NAAIdN3Ssvrnm9XRNtfkaFkZHcurz38AF2lBlho0e18zLJQtMKA+v6mz1NVIETtsaitAd8w+GmIgwDxtAcHPbgm/5eNPNLtAX0N6BtNXyfqzklR1rjnof7c9oyYhIXLmO+54re8SarW/3EQn04PQMGKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=D6l1UqFE; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="D6l1UqFE"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E181443F5;
	Fri, 21 Mar 2025 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742565095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k1m2RKa1jQRfCBUyBAtEmME2yIaNSnk0JZUuM1XWXm0=;
	b=D6l1UqFEnQcucCX2aaKoXzMgrRDoQdXPKAzTX8QY0v2f8CrTuzrnh37vpvIjEzk3DXOi4S
	MGQ0C3lsq7+4tnqIGjv61yd3G4MoEFHRtoXWBHHIgH1/C/VFcw0B+YJSBqORRQKrnyM/YN
	3OHSXsijfCoLAwUPLZ9bDBrAYmgeUs7i1kaaFjMyN190acnToGqh2GCKT0UZ/TX5HL0tse
	fJp5tSPqAk2UdOeBTb7mu68n886mnzdjeMMqgOjMhvslarnY7gHdETb75C4hksVurK2wcX
	PDrJAY63fFHEZa3xyo85N/UsazGzUW0NqSkQ+IV/otB3CsZSP794+NZ45JGL5A==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
In-Reply-To: <87frj6ld53.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	21 Mar 2025 14:35:52 +0100")
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
	<87r02qlt34.fsf@xenomai.org>
	<1b298aee5042ea0948591be9e5922f204fcc22b6.camel@siemens.com>
	<87ldsyldbl.fsf@xenomai.org> <87frj6ld53.fsf@xenomai.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Mar 2025 14:51:34 +0100
Message-ID: <87a59elcex.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevkeeukedvhedtieelveduleelleduhfeuvdegffeujeffheefffefhfehveelieenucffohhmrghinhepudegrdhnohifnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>
>>> On Fri, 2025-03-21 at 08:51 +0100, Philippe Gerum wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>> 
>>>> > From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> > 
>>>> > We had unbalanced hard_cond_local_irq_disable here so far.
>>>> > 
>>>> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> > ---
>>>> > 
>>>> > Minus one hunk that is already in current 6.12.y, this needs to be 
>>>> > applied to older stable versions as well.
>>>> > 
>>>> >  kernel/power/hibernate.c | 3 +++
>>>> >  1 file changed, 3 insertions(+)
>>>> > 
>>>> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>>>> > index 733b1a196f09e..e1c05f276a453 100644
>>>> > --- a/kernel/power/hibernate.c
>>>> > +++ b/kernel/power/hibernate.c
>>>> > @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>>>> >  	syscore_resume();
>>>> >  
>>>> >   Enable_irqs:
>>>> > +	hard_cond_local_irq_enable();
>>>> >  	system_state = SYSTEM_RUNNING;
>>>> >  	local_irq_enable();
>>>> >  
>>>> > @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>>>> >  	syscore_resume();
>>>> >  
>>>> >   Enable_irqs:
>>>> > +	hard_cond_local_irq_enable();
>>>> >  	system_state = SYSTEM_RUNNING;
>>>> >  	local_irq_enable();
>>>> >  
>>>> > @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>>>> >   Power_up:
>>>> >  	syscore_resume();
>>>> >   Enable_irqs:
>>>> > +	hard_cond_local_irq_enable();
>>>> >  	system_state = SYSTEM_RUNNING;
>>>> >  	local_irq_enable();
>>>> 
>>>> Merged into v6.12 and backported to v6.1.y-cip, thanks.
>>>
>>> Sorry, but I have to highlight that this patch does not help at all.
>>> Testing shows that we already "hang" when trying to hibernate. We never
>>> make it into the "wakeup" path.
>>>
>>> I think the "process" we followed here is broken. First we have to
>>> implement and *TEST* things in latest development branches and once we
>>> are sure we fully addressed the problem back porting can happen.
>>
>> The point is that this has never been a new and/or untested feature, we
>> may be seeing a regression on all versions of a feature that did work
>> for ages, the story does not start with v6.14. Now, the tricky issue
>> with hibernation is not necessarily in the code paths above, but most
>> likely in one of the many suspend/resume handlers, which are per-driver
>> beasts. First of all, we need to define a test configuration with
>> suspend/resume code which is known to work.
>
> Known to work when irq pipelining is enabled, I mean.

Food for thought: since the weak point of hibernation is definitely in
those suspend/resume handlers, a way to make any suspend-to-* sequence
stable without incurring a truckload of changes sprinkled all over the
map in those handlers, would be to temporarily switch the implementation
of the inband stall/unstall helpers to hard irq disabling/enabling
_while_ a suspend/resume sequence is ongoing. A bit like Dovetail's
so-called 'hybrid' spinlocks (hybrid_spinlock_t) are working for
irq_desc->lock.

i.e. use static branching in __inband_irq_enable(), inband_irq_save()
and alike in order to pair virtual masking using the stall bit with
hardware-level masking in the CPU.

With that scheme in place, interrupt bit virtualization would be
actually disabled while traversing the sensitive paths during
suspend/resume.

-- 
Philippe.
