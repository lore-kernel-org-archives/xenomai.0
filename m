Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9C38F25F
	for <xenomai@lists.linux.dev>; Thu, 11 Jun 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168029; cv=none; b=OATjN5Hu3TV6DgNJ7Z+p+pRiK1g1StmTgu6EO/oVux6y++y/x9f7/JuNsvo1y7P8EkyG6o4mkKN1zzZsgdKHQnGaZxs0fGbl24Zfpc9zCdBdExLVsJVBWT/eyn2spn29PCgpRQ5rf72yauAH9kfzHihAZcqSWcX2J6jE4GHK/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168029; c=relaxed/simple;
	bh=AwvGWPFW2JxNYTl553aLUoWh6fMQkLQ75WCaL0ePB30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvsFKGHvmFJbY3WiueggX3HH6odJhqDiTYei0oQQq8x5E3IPPjy8J0keqgskzkSKhg0zaJk4473AkJZ0QZ+jJz/lUmQQBvPDzJ6t1Q058BgkRVlZgbJupWXYvkKlAugk3LlEGmNCnz6OaTOqj8RBw/abXiBBj1oxI572taYiogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=CywJN9Ur; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="CywJN9Ur"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 801843EBCA;
	Thu, 11 Jun 2026 08:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1781168019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFyo/2AWEVpEjytqRnfoQfzfDwAw6HS9r9TaSOJBKHc=;
	b=CywJN9UrUiyy+l8k/jhgFrSnf6EuFG6xzE+TQwdCoySgz0wi5T+/XsNGTF3pTlQyrJ/6Ov
	kOJklbF8DcJgdYJ/SEbwkENuf792ahRVUPeZoSH3hsf1IjhYd7YPAOmYwjoCNMZQfuEJ6k
	vAsl4SsfjsxQynnRwCU1DiGvsGm/iB/uIfqiD5LaWRlYq0D+OWpa2viaMQWS41JgT8vmMu
	NGndI2HWpGAKVJRIYtvjoLfrh6A8oiUdRS/mRWWlHavPZ58i9wWUM+nt1+1Lwm8gdZszOM
	uNOcK+CfP11R1onsvq7O9hcGb7AvpVTPT2Ij3KP47ku51KD2ZqNe6Zna4ly8rA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: SCHED_SPORADIC in Xenomai 3
In-Reply-To: <2becb808-b1ef-4d3e-b1e7-121697cef154@siemens.com> (Jan Kiszka's
	message of "Thu, 11 Jun 2026 09:56:02 +0200")
References: <19c8bc29-9eb5-4265-931a-1cc5c34ba1ac@siemens.com>
	<5bb1aace-8083-400b-9e74-5a047873a1ed@siemens.com>
	<c5761187-9689-45b1-9527-89cc8a5b2763@siemens.com>
	<2227cdf6-d2cc-4f5a-87ab-d09861d4ce26@siemens.com>
	<30be9f34-4fd0-47fc-932f-70970217acb0@siemens.com>
	<87y0glbjp6.fsf@xenomai.org>
	<2becb808-b1ef-4d3e-b1e7-121697cef154@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 11 Jun 2026 10:53:36 +0200
Message-ID: <87mrx1bgq7.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGM7vYQ3eGXKDRbIytoX5iZwBnYT9+alb9iJmTLSW8C6nXfUL58nZ68GZEZ3A393j8HjXEH8a1SbYKaIm2rrUpEhDDdHLmUsn7BGl+jcXRF1/v1GR+02yStBVs6QRZEcDSqfDSYNuX4D2f2XSMbYATA8kChYyZPz5DpDOiqz3X49pfGzepKkjHgjdmkaXH4bRBS/UkT28Edr+ZWG9Y10w5vuOwus4AYOvnTS+WlBkXptA8Wguow/iw6UWv2WwY8nmioKFwBDvqA/se/yUqi/CfTDBGHxZU3j8gNcuFbQ6ylKFWi3/Lw/XYp5Wdblk028X13VUVqDeUtmy7q5alMdFRKsUtEvWSCWOAspD4KtvMC7SeFE3L8vAkKjqO7IITFEshZ5lgN7jMMCKzrU6rd86XgzUkF1GVjMVfTDiuBWzt0ciG5woNV02uwZNggM51e9FXcwMeaUXU+0ecmhLZniWMLPXB+GBoc9v5DZdXDSXTpsFX/2K/R35pIo4BvhovLzXQqGEyQWq3uH+rupbaMG9U2KC3M7kkyH5runj/SwwRhihiFSLiiS9KUE7N9vi1JsYjPO4cL+T7nnadGayK173Fae0wgKeSp+d6UT/Vv+7ek96fywlvfQohz0yL/x7PGmAKRYis5BgD0eq8FuK7JzUC6KqgdSqSfylWJY6KMwZtrww

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 11.06.26 09:49, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> diff --git a/kernel/cobalt/sched.c b/kernel/cobalt/sched.c
>>> index d527b6be2c..6dfbf83220 100644
>>> --- a/kernel/cobalt/sched.c
>>> +++ b/kernel/cobalt/sched.c
>>> @@ -895,6 +895,7 @@ static inline void do_lazy_user_work(struct xnthread *curr)
>>>  
>>>  int ___xnsched_run(struct xnsched *sched)
>>>  {
>>> +	struct xnsched_class *prev_schedclass __maybe_unused;
>>>  	bool switched = false, leaving_inband;
>>>  	struct xnthread *prev, *next, *curr;
>>>  	spl_t s;
>>> @@ -933,6 +934,13 @@ int ___xnsched_run(struct xnsched *sched)
>>>  
>>>  	prev = curr;
>>>  
>>> +#ifdef CONFIG_XENO_OPT_SCHED_CLASSES
>>> +	prev_schedclass = prev->sched_class;
>>> +	if (prev_schedclass->weight < next->sched_class->weight &&
>>> +	    prev_schedclass->sched_out)
>>> +		prev_schedclass->sched_out(prev);
>>> +#endif
>> 
>> I would call the scheduling out hook unconditionally, the sched class
>> has all the information required to sort this out, do the right thing,
>> which the generic scheduler does not.
>
> That would mean moving the accounting out of the pick callback
> unconditionally as well - leaving some smaller synergies on the road.

This hook would have to be called when the current thread blocks, which
should not be filtered out by the class weight check. Moreover, if next
!= curr, we know for sure that curr is either blocked, yields on a
round-robin tick or gets preempted on priority basis. In the latter
case, the sched class weight is accounted for when picking next. If
current is still runnable, prev_schedclass->weight has to be lower than
next->sched_class->weight for preemption to take place anyway.

IOW, the following change would be appropriate:

>>> +	    if (prev_schedclass->sched_out)
>>> +		prev_schedclass->sched_out(prev);

-- 
Philippe.
