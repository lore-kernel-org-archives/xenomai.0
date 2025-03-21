Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59A216E01
	for <xenomai@lists.linux.dev>; Fri, 21 Mar 2025 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564157; cv=none; b=aqlPlkpUpc2WigV52ojpWhClKaqag6glbBe3LdSKB++wMivGmJkjQRUo8K6Z97NkOiLOWP6gAXj+PCgmJ2U0m8zlyOC2SL36neLOmyCaAhH0+BrWNYBsGWS3/MaI/gsKFOjd+iCMa+W4enR7QMhWYypskehKVoupNiIO1pxRemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564157; c=relaxed/simple;
	bh=CoZ20CvXbyk5Wazp2GoqnhYgIFeWtN4n4oxeYvoVHNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hSrD4CCmwDdNrUpeRToxU6IZcD+mylSskxS/vGYPSofbWPC1Xgbswhb/676imy8s3EUATlj2Jzlx/4TgqAcsVDAVNPYFvRBuaZKOLPmPAmcVXoKIswUemS4JHkDrx57ZrJQdRCgtRZUNwui4VWmbLvFStsa0nAOH+hh6NMWQxTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=MRIcySfQ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="MRIcySfQ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C5D2443B1;
	Fri, 21 Mar 2025 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1742564153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3Gf2kv54gHfT5GKpedA6e5TysydteHhozgzbJsmstg=;
	b=MRIcySfQiWA/JaPyxUwUjAEP0M3VvyFeSaYz7QDjHRVt1jCaaorrvZvT8xdYsSYoqCEgiJ
	AjeyboFeYgkncVHXQ4KPaPe0sV9PRX6gG7zwHP7oFONY0ZPlTaKWwjovJ2a55+w+rTEF6J
	OJqVkByxQsAnQsQonnmlVWBF5aMz0zw7X6HDiFpg2ZRzQnCj5Yud7GvE1vuvRhxDDRzrfT
	t6oCNccEUfyk+B8VLsNaIyimwI3xNLtL1AOPwrMGXNfrtEKPYVyZsfDZLoSq5RZabF4FUw
	N/xTSGstKjwjNi/xn4pDMRFWiDjO67rQE9Fx2I3BIdQcZwWCVWqR6LVe7g9wQg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,  Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
In-Reply-To: <87ldsyldbl.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	21 Mar 2025 14:31:58 +0100")
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
	<87r02qlt34.fsf@xenomai.org>
	<1b298aee5042ea0948591be9e5922f204fcc22b6.camel@siemens.com>
	<87ldsyldbl.fsf@xenomai.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 21 Mar 2025 14:35:52 +0100
Message-ID: <87frj6ld53.fsf@xenomai.org>
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

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> On Fri, 2025-03-21 at 08:51 +0100, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>> 
>>> > From: Jan Kiszka <jan.kiszka@siemens.com>
>>> > 
>>> > We had unbalanced hard_cond_local_irq_disable here so far.
>>> > 
>>> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> > ---
>>> > 
>>> > Minus one hunk that is already in current 6.12.y, this needs to be 
>>> > applied to older stable versions as well.
>>> > 
>>> >  kernel/power/hibernate.c | 3 +++
>>> >  1 file changed, 3 insertions(+)
>>> > 
>>> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>>> > index 733b1a196f09e..e1c05f276a453 100644
>>> > --- a/kernel/power/hibernate.c
>>> > +++ b/kernel/power/hibernate.c
>>> > @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>>> >  	syscore_resume();
>>> >  
>>> >   Enable_irqs:
>>> > +	hard_cond_local_irq_enable();
>>> >  	system_state = SYSTEM_RUNNING;
>>> >  	local_irq_enable();
>>> >  
>>> > @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>>> >  	syscore_resume();
>>> >  
>>> >   Enable_irqs:
>>> > +	hard_cond_local_irq_enable();
>>> >  	system_state = SYSTEM_RUNNING;
>>> >  	local_irq_enable();
>>> >  
>>> > @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>>> >   Power_up:
>>> >  	syscore_resume();
>>> >   Enable_irqs:
>>> > +	hard_cond_local_irq_enable();
>>> >  	system_state = SYSTEM_RUNNING;
>>> >  	local_irq_enable();
>>> 
>>> Merged into v6.12 and backported to v6.1.y-cip, thanks.
>>
>> Sorry, but I have to highlight that this patch does not help at all.
>> Testing shows that we already "hang" when trying to hibernate. We never
>> make it into the "wakeup" path.
>>
>> I think the "process" we followed here is broken. First we have to
>> implement and *TEST* things in latest development branches and once we
>> are sure we fully addressed the problem back porting can happen.
>
> The point is that this has never been a new and/or untested feature, we
> may be seeing a regression on all versions of a feature that did work
> for ages, the story does not start with v6.14. Now, the tricky issue
> with hibernation is not necessarily in the code paths above, but most
> likely in one of the many suspend/resume handlers, which are per-driver
> beasts. First of all, we need to define a test configuration with
> suspend/resume code which is known to work.

Known to work when irq pipelining is enabled, I mean.

-- 
Philippe.
