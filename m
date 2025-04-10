Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D420E334
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278321; cv=none; b=YV46eo9or1qw4JIO9KMe9KHzU33azVJX7S1tNQhYHWFLxDKtEGd2OEeNQm0gv0LQQHLi+aUqe9yGNeKZfOSYp0Ahhz+dRiDK0+YsMjGqBq1tXuE6vL6DR2thEP25wl8ymVUzqaQb5XxYZsUo/WjFXRrfmdWnrebhMoA7K2apqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278321; c=relaxed/simple;
	bh=Ne0sifKwT34TWzMnZnYkV0Luai6ycEpYD8WlolCCbxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ue1tBEaITdc6lzthfYY2tI04sd6JmIvsEtMJBTu36qZUMP3HFJKSWxqoYGY6fEE5LECNBnxjnLhF88gACAYFHY3Q5gxKSY/ukkYUz7WLGIGTqNdi8TBgQnyq97AasCbxOaRbEJyvWyTe0uxn4EL0WOHkwBfdoNH8GuG01kvY5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JXzaSB/P; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JXzaSB/P"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D660A43E60;
	Thu, 10 Apr 2025 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1744278311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9QPDeBmldrlxeF53hVXAHkj0uETCYiRiXT5qEdKvUss=;
	b=JXzaSB/PUszAFZtof9SNhS5VdfHtENPLMKrFkvGQqpkUmKspAFkJAWXRt/bowGuK5ltuoQ
	K+w8XiGJqZuJel93bBuyyliDoPI1NeEoqWL6WuiqI9+h1/hl/9+C2cv176EMGbkurB6yuJ
	yzlt3CLGGwwGZsDmzC99s3ScWUzjAIIMFRLxRlp8NAq3gjZL+iLMw1LtUSonCBpGEIemT7
	D5CO8BuuXnH6J2fMtQB7YPx5b+ZLUcKqEojOUbZkznY+5bS829jw+oBNZv+zIieRJm/rCX
	0KgYteRLaXEzBChL7twgO42gbPfQmDaiV+sgSdpO3dmNU1Lz0QaU8OBEXLqo/Q==
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Nikolaus Funk <nikolaus.funk@sigmatek.at>,  xenomai@lists.linux.dev,
  Jan Kiszka <jan.kiszka@siemens.com>,  Richard Weinberger <richard@nod.at>
Subject: Re: [RFC PATCH 0/6] Xenomai: Real-time Exception Handling
In-Reply-To: <6934535.sGJI6kyIVQ@anvil> (Richard Weinberger's message of "Tue,
	08 Apr 2025 20:39:57 +0200")
References: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
	<879ad6e6-3f38-4f22-aa74-fa3862d85cb5@siemens.com>
	<6934535.sGJI6kyIVQ@anvil>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 10 Apr 2025 11:45:10 +0200
Message-ID: <87h62wmjtl.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohephedprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepnhhikhholhgruhhsrdhfuhhnkhesshhighhmrghtvghkrdgrthdprhgtphhtthhopehrihgthhgrr
 hgusehsihhgmhgrqdhsthgrrhdrrght
X-GND-Sasl: rpm@xenomai.org


Hi Richard,

Richard Weinberger <richard@sigma-star.at> writes:

> On Dienstag, 8. April 2025 19:32 Jan Kiszka wrote:
>> > real-time.  A notable example is a page fault, determining whether
>> > SIGSEGV is appropriate requires deep traversal into the memory
>> > management code.
>> 
>> ...on arm and arm64. It worked fairly well for x86. This is indeed a
>> very prominent exception that people may expect behind this feature. And
>> it is also a use case we have with our (x86-only) deployment.
>
> True that.
> I think the set of supported exceptions should be architecture specific
> anyways. And we need to state that it is best effort.
>
>> 
>> > 
>> > Patches 1, 2, 3, and 4 implement the Xenomai-side changes for this
>> > feature.  Dovetail will receive a separate patch set. Patches 5 and 6
>> > introduce tests.
>> > 
>> > It is important to note that this is not a fully-fledged signal
>> > implementation.  The only supported use case is delivering exceptions
>> > as signals to the affected thread.
>> > There is no support for sending signals or handling block/ignore masks.
>> > The only user visible API so far is cobalt_rt_signal().
>> > It takes a signal number (SIGILL or SIGFPE so far) and a handler
>> > function with the signature fn(int, siginfo_t *, void *).
>> 
>> Did you intentionally left out the oldact parameter of sigaction?
>
> Not really. Adding this should be trivial.
> Maybe my subconsciousness tried to make it less look like POSIX
> real time signals. ;-)
>
>> 
>> > 
>> > TODO:
>> > - Better naming, IMHO "signal" is the wrong term and will confuse users.
>> >   Especially since POSIX real-time signals are something different.
>> >   Maybe "umex" for "user mode exception handling"?
>> 
>> Just "exception" might be enough and clearer. OTOH, we are reusing a lot
>> of sigaction and siginfo...
>
> That's the problem. It kinda looks like signals but isn't.
>

Indeed. This rather looks like the handling side of the full exception
offloading path to me. That was the point of introducing the
mark_cond_trap_{entry, exit}() helpers. As you already know, when
notified of a trap, the companion core may decide _not_ to downgrade the
caller in-band, causing the regular low-level exception handlers to
assume that no more fix up is required.

>> 
>> > - Document new APIs
>> > - Improve tests
>> > - Carefully select more exceptions
>> 
>> Yeah, that is the challenge.
>> 
>> And:
>> 
>>  - align with EVL / Xenomai 4 to ensure compatible features
>
> Agreed.
> The dovetail side is rather small. We could also integrate the signal frame
> helper functions into Xenomai.
>

I may be stating the obvious, but with hindsight, there is a basic
trade-off we have to do for fully offloading the exception handling over
the oob stage, based on the past experience with dealing with the
arch-specific code in Xenomai 3 + I-pipe:

- the more we ask the companion core (i.e. cobalt / evl) to implement
  processor and/or standard abi-specific bits, the more we risk nasty
  bugs over time. Typically, maintaining a duplicate fpu and context
  switching code into the cobalt core during the I-pipe years has been
  an excruciating nightmare, compared to the current state with Dovetail
  which oob-enables the upstream code instead, presenting a complete
  task switching service to the core. This can be extended to
  implementing any duplicate/simplified version of an upstream routine
  on the regular kernel side for oob-specific use (for that reason, I'm
  not fond of the idea of copy&pasting in part the sigframe setup
  code). IOW, a plain and obvious conflict with some upstream change in
  a well-thought section of code shared between in-band and oob contexts
  is usually way safer than an oob-specific code mimicking (portions of)
  the in-band implementation living in parallel, since critical changes
  in the latter might go unnoticed.

- but, introducing oob-awareness in some in-band code is obviously more
  prone to merge conflicts, which might be another form of nightmare
  when the latter is a moving target on the upstream side, when it comes
  to tracking the kernel development tip.

To best decide, I agree with Jan that first and foremost, we need to
agree on an explicit feature set regarding exception offload to the
companion core including arch-specific issues/restrictions if any, so
that we may evolve the Dovetail implementation in the right direction in
this area. IIRC, we started a discussion on this list a couple of years
ago about this, for x86 at least.

-- 
Philippe.
