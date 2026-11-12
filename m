Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494588;
	b=INVgP9RNCCAxC8uMsVROXy/6OKThm+FP9c00BfMrVcyuVGXbBjqkUqNtrD0YyVvkcOKc
	 BtfxsFg26KvNjM8AAygQ7HtyHG5KSiOme6S26ZqzfyifyuZJKu5EO8X5y62HoCGzHbf1b
	 8TkdU/e48OlsyaaBotP7FBWilyQrtG09W90M0L05DmIibSRIHjwMz266j1U+eBs2YBXbV
	 mU48IMDIbMWzAAXBKClphjNCuEubQqiKTaQX/mF5Fi9SmVmUMjB3rSqA4SL4C8NMnlK+2
	 yrbz8SqdmdanTicw6HUPWQONNCy1j4zwKIVETxKzDHWZq4iE2st7Tc9S6pqDOSljmaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494588;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=gDQiKu/UA2WDGPkZNJlDReFoKzxgxgo+j6idiXrbJ64=;
	b=ZGEbYs70Eko14/y9Lv3FA4JyVM6go7DnfpTrOfxQPbAVr+BHNBGw+vicg7zmBz/HhJHQ
	 HO4Mhyr0pCjMHKfJ3pdK50A8jHAQ6u4ob69ZKetYCO3eqP/wOp31X0QrmNG3h4Rl9fYmI
	 ku5X3XlRXkgdSbcjYIpq/rowMriC7OEUBHlPQH0mUbdFmdVt4sBpS5seDB1FencP9OTpY
	 Ceco4QEI3CWvr9qdg2HGdPnznQpLXvfJjs/YjBcUyd1rGBcFwDHpSAxPyU86+Jn7r1rYR
	 5Po8cubWOaFFcfM89Vh4XvUCpvBu/ZSyu4xoEnNXLlQnT7yviDBOIahs7VdKhx/t0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=AFsMeTx+;
	arc=none smtp.remote-ip=217.70.178.231
Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20C606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F20C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=AFsMeTx+
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id B53103F44D
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:43:05 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7936456008C
	for <xenomai@xenomai.org>; Thu, 12 Nov 2026 14:43:05 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=xenomai.org header.s=gm1 header.b=AFsMeTx+;
	spf=pass (spool.mail.gandi.net: domain of rpm@xenomai.org designates 217.70.183.201 as permitted sender) smtp.mailfrom=rpm@xenomai.org;
	dmarc=none
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D5A43ECDB;
	Thu, 12 Nov 2026 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794494585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDQiKu/UA2WDGPkZNJlDReFoKzxgxgo+j6idiXrbJ64=;
	b=AFsMeTx+8dSnTubGdeo1gEwx1EAOZLTGwIRJ/wWM+l6SfoSJeeqjVe0qAZFouhphPIziG4
	efHa26hqv/UQFS1y3zhucfdK1DGkO5hGOwbTD/iJpwNBgMxq9Vv9qQF3+Hwp8Pf4HvkDI5
	taAuboxvX+4zxnZSZNQV7eNTWQRJZ5rVK07JgpUA4Hiz0VLk1aS6tBdE8jcpp4tTHjF70U
	maCcQm/P9Auv1W0JMQiosvWxVEN4wj+G3mXVb+z2GQTme8vlKveE8DRZ3QlQlsGw6B73ak
	t5fO8S9UfZF0XCR+pry286DGkfXD2u+9LYZXfTiYqJeJDa9JnlIE5sL5P85oWQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
In-Reply-To: <08720c97-6405-43ed-8096-7126cc9db235@siemens.com> (Jan Kiszka's
	message of "Thu, 12 Nov 2026 15:03:07 +0100")
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
	<87h5hm17op.fsf@xenomai.org>
	<08720c97-6405-43ed-8096-7126cc9db235@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 15:43:04 +0100
Message-ID: <87o6buyutj.fsf@xenomai.org>
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
X-GND-Cause: dmFkZTE88JKgkBoygRx+aC8WxYooFbHHlM8Mcrv0RMZQ63fzwq8MdLxo8xy64SfJXzbTcKUmTeaZT96Pdtrqbbi0VsRU4CmzzEi0XmVXxoCqmi+LnYhDL+N11L3TmplBgAa8BWfWytp2RufDAcBbfcsfd0baanTQ7cEtkrQv0cN0WEPyLoFOyeBTLnY3NrkgrfDC81yoLMEsNXiVY1idsrzlWI+Gx+tST2Y6fDOmeiAMSVb9tNyaLs1I3Ud0HzAQkDMf9yFmYFnR7mfd4lubTnNcbk+nqZ2OBri6WTcjIgPIGbuBpjeiJDQzHpcqGe/Byb3qR7QqY9EIGCFQLvHXfJVMZ8swUzouIHBbdzSDsEdi27bAVSh4qiSXcXp3S/fKHhEQJMuxc8AYnd186aW7pWphrxLc8V85c/1SZ0nvUJEJ1CroSKfIeipEE1p40EqJ4ubP6154GZs6GqnTHugozb5QJX5BhGPuSLptrTDE88t/3Ucy53lDtUb/mjtyojfrdzPT+YF42wgoAoX4zBLr5uks3NqxQ3foM1hrHMlCeM0adkxzw7D5bJLBTIxctdjzIhm4UGva8T5i8qcCtV7OiTudi5zWhI6lMvJ8q5i2J6Kolgxq+KQ42Omc0X0UgGakNBT/LD7mssRN1ZkdIqUn2SP514OXi5Dq8Fvib7yg4NauiqthMQ
X-GND-State: clean
X-GND-Score: -100

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.11.26 14:49, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 12.11.26 13:59, Philippe Gerum wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> On 12.11.26 12:39, Florian Bezdeka wrote:
>>>>>> On Thu, 2026-11-12 at 12:30 +0100, Jan Kiszka wrote:
>>>>>>> On 12.11.26 12:25, Florian Bezdeka wrote:
>>>>>>>> On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
>>>>>>>>> On 12.11.26 12:05, Florian Bezdeka wrote:
>>>>>>>>>> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I will share the lengthy test case as well once I'm done with stripping
>>>>>>>>>>>> it down further (if possible). What the tests already demonstrated is
>>>>>>>>>>>> that unpatched kernels crash.
>>>>>>>>>>>>
>>>>>>>>>>>> These patches here are almost completely generated. One of my few
>>>>>>>>>>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>>>>>>>>>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>>>>>>>>>>
>>>>>>>>>>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>>>>>>>>>>> of them I already shortened, but most is still left. We can cut down
>>>>>>>>>>>> further, but I would first of all like to have another review round.
>>>>>>>>>>>>
>>>>>>>>>>>> While doing that, keep in mind that AI tends to ignore issues left and
>>>>>>>>>>>> right when being told to do a specific task. It may have simply missed
>>>>>>>>>>>> further preexisting issues or even created new ones now. Watch out!
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>>>>>>>>>>> that you are confident with those changes eventually.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Those patches should not go anywhere until they reached the latest
>>>>>>>>>> development branch. The common "upstream first" rule.
>>>>>>>>>>
>>>>>>>>>> Everything else will add a lot of confusion.
>>>>>>>>>
>>>>>>>>> The v6.18 application was experimental, to validate that the test suite
>>>>>>>>> passes on real hardware when all issues are addressed. Nothing is
>>>>>>>>> official in rebase branches until it is tagged, including those patches.
>>>>>>>>>
>>>>>>>>> Jan
>>>>>>>>>
>>>>>>>>
>>>>>>>> Why not just push out a wip/ prefixed branch? That does not require to
>>>>>>>> temporary update branches looked at by different / more people.
>>>>>>>
>>>>>>> CI is not picking up such branches.
>>>>>>>
>>>>>>
>>>>>> Which is OK. Those branches should be tested only when requested
>>>>>> manually. The "internal" infrastructure has such a feature, while the
>>>>>> public one is missing that.
>>>>>>
>>>>>> Upstreaming was not considered yet as it highly reworked the xenomai-
>>>>>> images project. But maybe it's of interest now.
>>>>>>
>>>>>
>>>>> I'm not using anything internal. If you have a patch for the official
>>>>> one, please submit.
>>>>>
>>>>> But pushing to -rebase is also not a big deal because it is, well,
>>>>> rebasing, not stable.
>>>>>
>>>>
>>>> The dovetail rebase branches feed the evl trees though, which follow a
>>>> rebasing model for a reason. Although I'm not concerned by the specific
>>>> patches I mentioned earlier which look sane so far (review is still
>>>> ongoing), let's keep in mind that dovetail rebase branches are not the
>>>> right place for unstable work. As Florian pointed out, wip/ should
>>>> preferred for this.
>>>
>>> Rebase branches were and are not stable until they are tested. This is
>>> what they exist for.
>> 
>> No, they don't. Rebase branches are only a workflow for evl which do not
>> assume that code might be unstable in there, only accepting that bugs do
>> exist.
>> 
>>> Once testing passed, we tag. This is also how I run
>>> all the stable versions I maintain. In most cased, the tagging goes
>>> straight on top, but I already had to fix up untagged branches in the
>>> past. Or rebase them once more because of further upstream releases.
>>>
>>> Now, if you ever tagged evl branches earlier than dovetail branches,
>>> that should be avoided in the future.
>> 
>> I'm unsure why the tagging issue is brought up, this is not the point
>> which is being discussed. The point is to refrain from changing the
>> semantics underlying the rebase branch arbitrarily, only to find out
>> that this may break the evl development that sparked the dovetail
>> development in the first place, nearly ten years ago.
>> 
>> I'm generally ok for improving the process, like getting help from an
>> LLM for the mechanical part of the maintenance, but let's do this with
>> every stakeholder on board, participating to the decision.
>> 
>
> Yes, we need to align on this. Do you have your workflow documented
> anywhere?

Terser on the kernel side compared to libevl unfortunately, written
years ago but the basics did not change.

https://v4.xenomai.org/devprocess/index.html

> Then blame it on me that I didn't read that. I only followed
> intuitively reasonable patterns for many years now to ensure that
> dovetail is broadly tested and based on recent stable versions before it
> is released.
>

I do acknowledge this as a valuable effort, of course. We just need to
keep flexibility at the other end of the line as well, because as you
already know, we have to deal with out-of-tree issues vs upstream code
churn, an integration effort ongoing on the evl side in order to align
as intimately as possible with upstream by reusing its infrastructure,
and only few resources to do all of that.

So let's have an open conversation with anyone interested in
participating to it, about what can be improved in the existing process
- which was laid out in the early stages of the evl development when the
only dovetail user was evl. What made it flexible once may have become a
liability in some aspects, we can and should address these issues.

-- 
Philippe.
