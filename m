Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491354;
	b=TiyYgJrQWeSW/X5Ulwapr0L/9SOhVwMxBIed0BpPvnLoqsCn63wBeOgZ/p2m6fDqeBHG
	 oUe3a7DJyqDJcEs/D1KZ07B8seRzmXGZPBRu+am9dHnxvDtsfDVKfsvVEzrsooDWY3zf6
	 GHOX8CxjnWjZzyg3UIzOsLpau3Y7eBVbPW3luLeBSyrM9b2nMq0yaplE6uNkTMGdHzLXP
	 iLMwX/5rK/lAzZlTKsRLuZhwUEgnpE6BzxxW59gpumnylcl8aWGEG6Lxwtm/U8nUQDjN0
	 xXTuQCp1t/5EMSEF0qpObcwSjillVZSPK5EF9Zzf0W2uhQOw27m/9IzOhN7ZIfrp6Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491354;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=WLaJ/TsO3H8QzLPOhcYx8OvNK3n1vZKb5lnwjRds/8U=;
	b=nAnYz4prEMqXxSAFCTj/ls6RqYs7UqeO8046piAj8wMweCYAUJmO0NobX/mzNHig5Sje
	 cVEc599gYxsxw9oKxOZRzJX1biWh62xl/MvH18cDUWwf2W3PjoPL6xKVY/88SdFFBXNVR
	 8VIKCn6Dr60cC+2sNPy9o1zKmwDB3nYawrOxQ9bQUwDxia18S2W509gk26pyWx6AQMgCX
	 k53T6S1qNXJuqQqe76zJNFmqE3IvgHmg9SQhDq4bm3XLJmKjotuEKeMmg+V9IN8ZN6uUJ
	 vpUC6CW9/i+NBgOXHf6Bqp2998Z+Gb67mXjTbBmNnw6vuPl1TCtJoiJl4NZAiZTSEAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=hT74K1Y0;
	arc=none smtp.remote-ip=217.70.178.233
Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD35606A327
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 13:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD35606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=hT74K1Y0
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id AB4E73EB4C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 13:49:11 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6B12B27E031D
	for <xenomai@xenomai.org>; Thu, 12 Nov 2026 13:49:11 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=hT74K1Y0;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 2001:4b98:dc4:8::223 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=none
Received: by mail.gandi.net (Postfix) with ESMTPSA id A02561F654;
	Thu, 12 Nov 2026 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794491351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WLaJ/TsO3H8QzLPOhcYx8OvNK3n1vZKb5lnwjRds/8U=;
	b=hT74K1Y0ryaUr5Oi2Za1AwqhpA9IDGXw577DWOFMjDmEbr5MklctxwB0zlNVHCdeUPN456
	DxkLosU6WQWL96sYyLUkkiwGzaLbN2XvrTziUyyF9WhnFYBjxoEjTLQFF7e2dCg3YvgqbR
	N4qZ1L3SB+cT3uLdoUorNmui1NBy01Wy78pWstOXdhMTq1z48qfmzMan+hW2MsTEMVXcyy
	rtLU5wI4s1AaflbVw7DRvh/jRLR6Ws0btnFGFFe02WqFbYyrzCNXPDohzP3R14uHtaMgVF
	ZEiU50tR+lSUXj6omZ4wHh8uEZ7KFf1PUEzoclV5rK7/WVH+b16svRV9ecoBfg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
In-Reply-To: <c3b7ca5c-cc7f-442c-be5d-9b9e80b0f94e@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 14:29:01 +0100")
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	<87cxsa2vej.fsf@xenomai.org>
	<f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
	<383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
	<339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
	<6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
	<b4f20066cfe191c9aa22e4da524d56838da5df3c.camel@siemens.com>
	<ab4bf2bd-f38c-451b-9b76-d4ed3bbbf535@siemens.com>
	<874idm2okc.fsf@xenomai.org>
	<c3b7ca5c-cc7f-442c-be5d-9b9e80b0f94e@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 14:49:10 +0100
Message-ID: <87h5hm17op.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Cause: dmFkZTGDDJbm18ENekeTSkHeyTMepOlixKxhm1ILRIthIim4B/yiIO3uB7ClAvS8JFvRjKSf/vfxkRhBJPvGJIhZpcRDS65TNcu60GOoooRvzBp+QKw2gzlJ2lSAyft+W6yyomYCKdtx+tmPV8lgoDvn3TN/in4Ty6uBcRq1SUm555fVqncdg67DioHND2bocl432MnxPn6mGSn8XNUvYhVHCbyRxDaqchuUQOecdDrlOBdKxX/3vI6AgFhg9HMJ4oL5f60JLB3NCOPk4aEvXtp9mss9qY4J8sEoQHJMZpBYvVdZFvc8bz8t1FG+X90FhKxJkoMhSK/gkRZCqPEMQGda750MqlENQ+yPgs8zMLyAB4nPquTPJKRdT8QBZCmsnScUTP71x4sOZOirfrvPdjyVmq7rBHJ5HNDCIAc5N0A+0SnUDUbVz++JhoUuWhheyA5gU6hyeNTTiYjg9PSZOmQO5AL1pLAdjs8x7N/jirc6R8urFvGXuCY00vBBhuKkouRj54DHu0m/8RdsGCK6AQGchjcEy9Ho5JVIpO6YgvrSnGXIcQtewpcfAZYqRJ5vZutP3MXtZOm/pgcDCFJRztPYHXVqpwNme082PgRjVCqXjF9PI5ilsk1GjAEqMpw9ZGDGM/4fceQedUjIjo25D+AqP46ZK8t3zIfPurmm8BfKzN8EuQ
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.11.26 13:59, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 12.11.26 12:39, Florian Bezdeka wrote:
>>>> On Thu, 2026-11-12 at 12:30 +0100, Jan Kiszka wrote:
>>>>> On 12.11.26 12:25, Florian Bezdeka wrote:
>>>>>> On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
>>>>>>> On 12.11.26 12:05, Florian Bezdeka wrote:
>>>>>>>> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I will share the lengthy test case as well once I'm done with stripping
>>>>>>>>>> it down further (if possible). What the tests already demonstrated is
>>>>>>>>>> that unpatched kernels crash.
>>>>>>>>>>
>>>>>>>>>> These patches here are almost completely generated. One of my few
>>>>>>>>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>>>>>>>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>>>>>>>>
>>>>>>>>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>>>>>>>>> of them I already shortened, but most is still left. We can cut down
>>>>>>>>>> further, but I would first of all like to have another review round.
>>>>>>>>>>
>>>>>>>>>> While doing that, keep in mind that AI tends to ignore issues left and
>>>>>>>>>> right when being told to do a specific task. It may have simply missed
>>>>>>>>>> further preexisting issues or even created new ones now. Watch out!
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>>>>>>>>> that you are confident with those changes eventually.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Those patches should not go anywhere until they reached the latest
>>>>>>>> development branch. The common "upstream first" rule.
>>>>>>>>
>>>>>>>> Everything else will add a lot of confusion.
>>>>>>>
>>>>>>> The v6.18 application was experimental, to validate that the test suite
>>>>>>> passes on real hardware when all issues are addressed. Nothing is
>>>>>>> official in rebase branches until it is tagged, including those patches.
>>>>>>>
>>>>>>> Jan
>>>>>>>
>>>>>>
>>>>>> Why not just push out a wip/ prefixed branch? That does not require to
>>>>>> temporary update branches looked at by different / more people.
>>>>>
>>>>> CI is not picking up such branches.
>>>>>
>>>>
>>>> Which is OK. Those branches should be tested only when requested
>>>> manually. The "internal" infrastructure has such a feature, while the
>>>> public one is missing that.
>>>>
>>>> Upstreaming was not considered yet as it highly reworked the xenomai-
>>>> images project. But maybe it's of interest now.
>>>>
>>>
>>> I'm not using anything internal. If you have a patch for the official
>>> one, please submit.
>>>
>>> But pushing to -rebase is also not a big deal because it is, well,
>>> rebasing, not stable.
>>>
>> 
>> The dovetail rebase branches feed the evl trees though, which follow a
>> rebasing model for a reason. Although I'm not concerned by the specific
>> patches I mentioned earlier which look sane so far (review is still
>> ongoing), let's keep in mind that dovetail rebase branches are not the
>> right place for unstable work. As Florian pointed out, wip/ should
>> preferred for this.
>
> Rebase branches were and are not stable until they are tested. This is
> what they exist for.

No, they don't. Rebase branches are only a workflow for evl which do not
assume that code might be unstable in there, only accepting that bugs do
exist.

> Once testing passed, we tag. This is also how I run
> all the stable versions I maintain. In most cased, the tagging goes
> straight on top, but I already had to fix up untagged branches in the
> past. Or rebase them once more because of further upstream releases.
>
> Now, if you ever tagged evl branches earlier than dovetail branches,
> that should be avoided in the future.

I'm unsure why the tagging issue is brought up, this is not the point
which is being discussed. The point is to refrain from changing the
semantics underlying the rebase branch arbitrarily, only to find out
that this may break the evl development that sparked the dovetail
development in the first place, nearly ten years ago.

I'm generally ok for improving the process, like getting help from an
LLM for the mechanical part of the maintenance, but let's do this with
every stakeholder on board, participating to the decision.

-- 
Philippe.
