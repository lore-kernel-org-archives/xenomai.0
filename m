Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A0321426
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323086; cv=none; b=g341BRwR6XmIwex541L8G3dw1c/a2o1jFlAS5HWAB6M34OOxIzQzTJF900Tg4eKmmvkkRQEiyM+0I2xjPQfJtlB0zzLEW3Ul9OKWxqrstBpJF8PjC27gmPHqiaZeOmmopVMJEr4nbYTO3dQZK1pPUevZlmBMlPmPgrQ5p/rLXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323086; c=relaxed/simple;
	bh=dp1Wj5lfu4LTdl6g3HIbuqvCJbls45rXaCaV1z/DTFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HsG8zszlmZadwXlY/ja1BRNXvVEO41WQgdJYGQ7qUNdU5XHqIDxMjjs+Bvaocag9Sw7zq3/2MsfGujpCSSJhl+xofbKEC9YSgQgnZktGOYL8jiO4Xgv0Y+Vn4Zx32JNDOvlfloqu+o7gNpKOBlR2F9xx+15a6ZnSJVRuewGeWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=lIdwQUeg; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="lIdwQUeg"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4ACE41D50;
	Tue, 17 Feb 2026 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1771323083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzWlLwd2bZAEX9IykMUlfgEeFqVrN7P4Ixn7LjYC5xo=;
	b=lIdwQUegCyRi+md5CsQ+aZOCGanonhcpBmMuXtWwiXZepNjTkik+FzEidOzSnwyOVwZPTQ
	hlv5RK63K7nPbfIOsXX23I9oefN4yjYFVyQY7qCaG88VKTsrHoBVSMVIM3pwVU+bCuXOAg
	Rl5RlrB7VjezykB13dINu799rXwA/FCs+LjbDTTf/pUhUfYwX2XuknHTXZyOmwzPF3kLcy
	JInPCLHlkXYf5Rwzc0Ss5y58N8bYLgo6H5kt9Vm1OTC340B+auZV+m2LLMB1ic/APSJV6T
	uIoIBgS3vKK37x4s+bIQwhHLiWEtjgoEi1oj3w4B5QDbQn3g8RDrYqjAmLT6Bw==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH Dovetail 2/2] arm64: irq_pipeline: Fix the demotion
 checks for el0 and el1 IRQs
In-Reply-To: <87tsvf9081.fsf@xenomai.org> (Philippe Gerum's message of "Tue,
	17 Feb 2026 10:40:46 +0100")
References: <20260216-wip-flo-v6-19-dovetail-rebase-v1-0-5c36863cba17@siemens.com>
	<20260216-wip-flo-v6-19-dovetail-rebase-v1-2-5c36863cba17@siemens.com>
	<87jywbajfy.fsf@xenomai.org>
	<505e35212b6655e0cb65e9fbc418c1171a9c916e.camel@siemens.com>
	<9e12c4a73df2d24dd1b39ab196b0112cb4e7e6ef.camel@siemens.com>
	<87ecmjahk3.fsf@xenomai.org>
	<430245ce2bc8da023235e9cf1312f729d7c57494.camel@siemens.com>
	<87tsvf9081.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 17 Feb 2026 11:11:22 +0100
Message-ID: <87o6ln8yt1.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepteegteevgfegudffhedtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

Philippe Gerum <rpm@xenomai.org> writes:

> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>
>> On Tue, 2026-02-17 at 09:41 +0100, Philippe Gerum wrote:
>>> > Comparing with x86 again, I think that my proposal is "correct" in terms
>>> > of identical to what x86 does. Do all architectures have a gap here?
>>> 
>>> x86 has a single implementation for both user and kernel preemption
>>> paths, arm64 has two since the privilege level is explicitly stated by
>>> the irq handler being called, but this still must translate identically
>>> logically speaking. Your implementation is missing the kernel preemption
>>> path after demotion.
>>> 
>>> i.e. when checking for running_oob() || irqs_disabled(), the cases
>>> covered are:
>>> 
>>> (1) in-band user path on entry (implies !irqs_disabled())
>>> (2) oob user path on entry (might be demoted)
>>> (3) (virtually) stalled in-band kernel path on entry (implies no reschedule,
>>>   filtered out by irqentry_exit())
>>> (4) oob kernel path on entry (might be demoted)
>>> 
>>> Therefore, with your patch in, el1 is now missing (4).
>>
>> Right, but I'm wondering if x86 ignores this case as well.
>>
>> After demotion of a oob kernel path entry, user_mode() should still be
>> false - bypassing the call to irqentry_exit_to_user_mode() - No?
>
> Yes, x86 assumes that a kernel path demoted to in-band is going to cross
> an IRQ synchronization point shortly after on return to the preempted
> context. Now, with hindsight, the question is: are we 100% certain of
> that? Any real (hw) IRQ over the in-band stage would trigger the
> synchronization as expected, but a synthetic one posted from the oob
> stage might linger if this assumption ends up being wrong. I need to
> have a second look at this code.

Which means that your latest patch series is ok and complete. The change
if any would most likely happen in the generic pipeline bits.

-- 
Philippe.
