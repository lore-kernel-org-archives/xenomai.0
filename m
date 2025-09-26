Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43026CE0C
	for <xenomai@lists.linux.dev>; Fri, 26 Sep 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758883047; cv=none; b=a5jcthWwOeubRaAucl8cnVhGoMk/x5v2EnixDVTScYpM7pGDeUeQV4wPwQzVmPVMmXyztDNGuTIgWh0t99C6SXaGEh4XQIYrQGGFxMNjL8TGCWzMIRQRRMgx2Y8i/UgSI1bGsajGo+a7wmXxdPDUYZt8a4cObHk0o+DRXiZMAz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758883047; c=relaxed/simple;
	bh=tUK7tmjzyUfVTRAqR+fk71BhvLZe548bvrs5pRCZWuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u9tM1yAYAKXhnMNCGEAV8xtjuqrvefOgrcnY41KiIGueYKs6ItT5CBQvs3akwI2aWjYwbGMWhcHQST8I7PORSuP+ZMRKQPfewMCnbJU7wkafMD42W8GlYXqfP/6nKlsPMYWrs9KthN6qoP8rKKpHEWMnLVbZ4VMDjZqBgy/nCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=ojhcDdTQ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="ojhcDdTQ"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5549C43187;
	Fri, 26 Sep 2025 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1758883037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C1O8vmAgV2CK11cm29eZ38GZ73tse5Z7R1o7Fijo1WI=;
	b=ojhcDdTQSsP6643y+bt2pK/o9oYxJF6zqz2MlJhRY4I10yZJfQHmlOkmfrRx/k+yTKoDJG
	E0nudd2+8IlnmbvYT1SIiL5xSwDJA7R25+8QB+r+vuHIVnEoppgVpzfZ69TKmKETN5v8yX
	RLDMQCDwzt8uPQ/lPQDV/bH+VoOVSYJ2i3KzxwW2WAAd5Au96QnEQMuoBSrma5hP2io38Q
	P058Z58kbpJf2SXF2UamOg0MKbNl0LRYpDJcP8RuCt+uIt3kLeQJ5peBa7SvZQzOrgHe3k
	Jg52bRn7y5+JEkDVT6BrsfvB284t6YPDfpc1oxEIEu2GNzNsWGEMQiHZRQfpGw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.16 1/5] kernel/entry: irq_pipeline: Do
 not leave .noinstr.text section
In-Reply-To: <0ec46f0daf973c66d194cdbec1366106f71881ba.camel@siemens.com>
	(Florian Bezdeka's message of "Fri, 26 Sep 2025 12:26:22 +0200")
References: <20250925-wip-flo-cleanups-based-on-6-16-v1-0-8c4ac7b52cd8@siemens.com>
	<20250925-wip-flo-cleanups-based-on-6-16-v1-1-8c4ac7b52cd8@siemens.com>
	<87ikh5ha31.fsf@xenomai.org>
	<0ec46f0daf973c66d194cdbec1366106f71881ba.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 26 Sep 2025 12:37:16 +0200
Message-ID: <877bxlh543.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeileduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Fri, 2025-09-26 at 10:49 +0200, Philippe Gerum wrote:
>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> 
>> > Fixing the following warning by moving the call to irqentry_syncstage()
>> > into a instrumentation_begin() section.
>> > 
>> > vmlinux.o: warning: objtool: irqentry_exit+0xab: call to synchronize_pipeline() leaves .noinstr.text section
>> > 
>> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> > ---
>> >  kernel/entry/common.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> > index 583dcef13c7c0..284d41cb1c918 100644
>> > --- a/kernel/entry/common.c
>> > +++ b/kernel/entry/common.c
>> > @@ -393,6 +393,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>> >  		return;
>> >  	}
>> >  
>> > +	instrumentation_begin();
>> >  	synchronized = irqentry_syncstage(state);
>> > 
>> 
>> This means that we won't have ftracing or anything that depends on
>> instrumentation in any inband irq handler triggered during stage sync
>> from this code path.
>
> Hm. Really? The instrumentation is now enabled before running into
> irqendtry_syncstage(). No?
>
> Seems I have some issues to fully understand that instrumentation
> thingy. Let me double check...

Nope, I got this backwards, your code is right. /me multiplexing way too
much ATM.

-- 
Philippe.
