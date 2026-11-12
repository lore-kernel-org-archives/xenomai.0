Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488365;
	b=r9MWc3ezAe02qxz4oWXJHaGcdpuxtj5atuDzc5xa5B8CPRzUwSjWkXLKnlAnF62FCSJk
	 ez3ykfG0JLqk/0RP4dZzGcNnhQ11ZMgdjwTVvbsnXaUTSqu56cwzck5psxgSqhCqfXnCr
	 XKT+pWWvRBn5TjULROzhyvK91P8UF93i8WaSWstekMCERXOVHd8fOYfy17IB8htv8vZ/E
	 ZbQL/pahDDaJuNzyrXTsPmeNyqdnWIEx1KZF5XvPdUVj3cOR+RV8Ipcc28OE2+0p7cAl5
	 39UNE25jb75LGAdOgyvEmSrOX7hBvwYAJOo5/sL9BQ3YZHnVYKUS2MuuhnBBa14NX4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488365;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=W2emVDwGviLS7v+Cj808AlXBiQJHmYctQgQqMoH5FAY=;
	b=Zs6cNCqVkgRMYTwQ7eqxg0Vneg6//UWGAfiDvA977bVkzMpDRibDZOx+pHa4HLjGws+a
	 BNPTj+FrgmW/ii7vSDLgsJI6EIN9ttl7jim0UK4vFZpS6+SLuPxn7dBLInTsFzZxBVZyv
	 3LtXEPgiX3IWpiupHO8JXZMgmMot4fAUEyPmkkQEY1AD4juXNWdBApVbNgvwzO0HY6RG3
	 pFqF/JlSvKQJfJhC8EelEVNmYSwxu+Vf6Azn5okvdZkYpZ8PRR9FrgpoOAZXlaFm++0sL
	 4w2aXGMWASM+m+f5Phx6P0EnLeY1zedPMNo6NNAMpYa3b6BFe/1F4YiQZuqEzWzixOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=bgh8Fhet;
	arc=none smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FD5606A881
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 12:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FD5606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=bgh8Fhet
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id B82ED43045
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 12:59:16 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7C7FBC004E2
	for <xenomai@xenomai.org>; Thu, 12 Nov 2026 12:59:16 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=bgh8Fhet;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.198 as permitted sender) smtp.mailfrom=rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D6FC3ED38;
	Thu, 12 Nov 2026 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794488356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W2emVDwGviLS7v+Cj808AlXBiQJHmYctQgQqMoH5FAY=;
	b=bgh8Fhetuo/kmFqycxnle8bLV0cLQBRZlT3Wfvlh61tohQMjby94NwOvnPmPMxYWh/l8Tr
	EVuV0YYiUmZndJcmu8VwXbnm7F0rVa9MxuHi4hm0DxQzTXFhflW4w/swTa04jmEwxyrQFb
	8UuD0imih90bIDqzA+CragPW83fUVULub1c/kYNH3lG//7nHqV39IsODJYJ9OezPM3VphV
	laOOJeID66eXzamnM2vIp7gTkRFNJWpxfHD9yFZi2kf/+RDvhXW9AYMbl20GEOfbpkRsn5
	UUFd36Hew7N7ZEzuZfAD8/uVhWaDmn/+v0ouNwIFOjGvkXqlkWtBYbkp3Lw0WQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
In-Reply-To: <ab4bf2bd-f38c-451b-9b76-d4ed3bbbf535@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 13:04:53 +0100")
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	<87cxsa2vej.fsf@xenomai.org>
	<f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
	<383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
	<339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
	<6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
	<b4f20066cfe191c9aa22e4da524d56838da5df3c.camel@siemens.com>
	<ab4bf2bd-f38c-451b-9b76-d4ed3bbbf535@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 13:59:15 +0100
Message-ID: <874idm2okc.fsf@xenomai.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTF+yNvoNcXLytYVp0+OOytSCBQloXajBxP5FA87Cu9zamAktl6gJGCVmCfu8jrrNydOFlhB1feoy7ejpHRp1F+EjH7aYGzF39o6MQUCQ7C3kE6DGnD7o5cLZTRP/Zph6N87EwwPZIhFszn5J5WeVecHA0ieZdHF+OJaXbIRwP5oyiC+tIXfSlB9q6QL1nLIfNUMxx0QIZ4kCXWqjLiVzwvNteDkkLMa9aGTwdS7quxyQpLHwRuddHgUe3VziqloqHrGkYMJizzJZC+XOgDscTIsPix0b3ppHI/JVu8N6PfYNMOXI7AOGLXMSeTT3D/85JE2EzUMZmGl9eVUCNR9YW5JJowNHxvORJQLJ5M18eJezi/ySwvC8EhVgqq0Uj+gpE1lBkxNd+wFwclVCPHb4GUT8XdCUlf6TEsRzv7Ts/WL7vgSlxoMfwDEWgJDJKFZ2t2fnTJyQ0W/rHaS4X9DjpK9hYYwTuND7/cVM77e9zqKR6D9PuQPeRf8qH1oAmrdxZsLCiNYsE2gb897x+hJEeOqdi4iuk8vQj2oi5iAoa/I1CvPpV5AyCLjb+zTIdEKAC1whs0N+3PCTH+T/CerigwNEcRuF9Q79cT37uJtRQ7/i/y+QMlA1caeZte2b+Hr+Y9Ad8GS5vBkLlyJVDlu1VQKiocmqMWaLaSVgNADxnqI2A

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.11.26 12:39, Florian Bezdeka wrote:
>> On Thu, 2026-11-12 at 12:30 +0100, Jan Kiszka wrote:
>>> On 12.11.26 12:25, Florian Bezdeka wrote:
>>>> On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
>>>>> On 12.11.26 12:05, Florian Bezdeka wrote:
>>>>>> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>
>>>>>>>>
>>>>>>>> I will share the lengthy test case as well once I'm done with stripping
>>>>>>>> it down further (if possible). What the tests already demonstrated is
>>>>>>>> that unpatched kernels crash.
>>>>>>>>
>>>>>>>> These patches here are almost completely generated. One of my few
>>>>>>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>>>>>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>>>>>>
>>>>>>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>>>>>>> of them I already shortened, but most is still left. We can cut down
>>>>>>>> further, but I would first of all like to have another review round.
>>>>>>>>
>>>>>>>> While doing that, keep in mind that AI tends to ignore issues left and
>>>>>>>> right when being told to do a specific task. It may have simply missed
>>>>>>>> further preexisting issues or even created new ones now. Watch out!
>>>>>>>>
>>>>>>>
>>>>>>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>>>>>>> that you are confident with those changes eventually.
>>>>>>>
>>>>>>
>>>>>> Those patches should not go anywhere until they reached the latest
>>>>>> development branch. The common "upstream first" rule.
>>>>>>
>>>>>> Everything else will add a lot of confusion.
>>>>>
>>>>> The v6.18 application was experimental, to validate that the test suite
>>>>> passes on real hardware when all issues are addressed. Nothing is
>>>>> official in rebase branches until it is tagged, including those patches.
>>>>>
>>>>> Jan
>>>>>
>>>>
>>>> Why not just push out a wip/ prefixed branch? That does not require to
>>>> temporary update branches looked at by different / more people.
>>>
>>> CI is not picking up such branches.
>>>
>> 
>> Which is OK. Those branches should be tested only when requested
>> manually. The "internal" infrastructure has such a feature, while the
>> public one is missing that.
>> 
>> Upstreaming was not considered yet as it highly reworked the xenomai-
>> images project. But maybe it's of interest now.
>> 
>
> I'm not using anything internal. If you have a patch for the official
> one, please submit.
>
> But pushing to -rebase is also not a big deal because it is, well,
> rebasing, not stable.
>

The dovetail rebase branches feed the evl trees though, which follow a
rebasing model for a reason. Although I'm not concerned by the specific
patches I mentioned earlier which look sane so far (review is still
ongoing), let's keep in mind that dovetail rebase branches are not the
right place for unstable work. As Florian pointed out, wip/ should
preferred for this.

-- 
Philippe.
