Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA9111E
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 13:42:24 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 140B31BF204;
	Tue,  1 Aug 2023 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1690897337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eh7zz1uXifmPKNBVCKMssy0ub0MVkzOyFOAJcXxlrrI=;
	b=hLjkfORLKt4S7Oa0rRAH77vkHspPnuDgl/5rr30h0aw/A5clZE3beIrSCrSl+FhRxLCl2M
	MMM8WxIw38SkLBZVmymeV3YBLdhxAPuKeS4OcwRQI+U1Iz+NeAVcR8hbsZ/PKVQq2juvWg
	82m6cGkZB4Xgj8szsF024FlCQ6cC1U+KmOApK6vBfSPQkNg/YjSM9glthvs38XkNwhydxF
	Ft8kraLvSy5h43Q5961YIttHQ33LMpAtlt6AeZq3NWQ8E7QmTgRaB8k/JRMF5RqJOfxJeL
	4IdarmNwGUTo0NLPh3IUzEjDQQsHFZZ7YnwgSO2ePi3XgqTtDmCxZDmGvCDppQ==
References: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
 <87edlkeu1b.fsf@xenomai.org>
 <a35a96771c0f059370357b9a37c9ab1871e621b0.camel@siemens.com>
 <beff2aa61a6b00af08baa7374feff1a0ddf6dd93.camel@siemens.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: v6.1.y-dovetail-rebase
Date: Tue, 01 Aug 2023 15:26:44 +0200
In-reply-to: <beff2aa61a6b00af08baa7374feff1a0ddf6dd93.camel@siemens.com>
Message-ID: <87tttiswuf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>> > Hi,
>> > 
>> > Jan Kiszka <jan.kiszka@siemens.com> writes:
>> > 
>> > > Hi Philippe,
>> > > 
>> > > quick feedback on latest rebasing:
>> > > 
>> > > https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>> > > 
>> > > This was likely accidentally folded, right?
>> > > 
>> > 
>> > It looks so. This conditional statement appeared upstream during the
>> > v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>> > patch for this entire series.
>> > 
>> > > Furthermore, I will factor this change out into a separate commit in 
>> > > merging v6.1.y-dovetail, for better traceability:
>> > > 
>> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> > > index ce8bdd804bc7..c843bf352999 100644
>> > > --- a/arch/x86/mm/fault.c
>> > > +++ b/arch/x86/mm/fault.c
>> > > @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>> > >  
>> > >  	/* The fault is fully completed (including releasing mmap lock) */
>> > >  	if (fault & VM_FAULT_COMPLETED)
>> > > -		return;
>> > > +		goto out;
>> > >  
>> > >  	/*
>> > >  	 * If we need to retry the mmap_lock has already been released,
>> > > 
>> > > To my understanding, this was a dovetail fix that applied to previous 
>> > > versions as well.
>> > 
>> > Only to v6.0, however this series is not maintained dovetail-wise
>> > anymore, so this stayed under the radar.
>> 
>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>> through a 24h stress test while the "merge" branch failed. Happily
>> waiting for the next release...
>
> Do we have a idea / plan when the next 6.1 dovetail release will
> happen? My internal customer is waiting for that and I want to avoid
> backporting to 6.1.34.
>

There is a brewing rebase to v6.1.42 pending tests here, no challenging
source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
if you want to give it a try before Jan updates the stable branch.

> @Philippe, any news regarding the IRQ issue? Did the VM image help to
> reproduce the issue?
>

I did not have a chance to look at this yet although I intend to, no
spare cycles ATM. I'll follow up when I have news. Since it takes ~18h
on average to observe the issue on your end, I would not expect a quick
resolution though.

-- 
Philippe.
