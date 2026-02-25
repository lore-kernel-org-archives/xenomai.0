Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466771C5D44
	for <xenomai@lists.linux.dev>; Wed, 25 Feb 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037827; cv=none; b=b04MchX3f9LZL/Y4hPMwohcAO9it/8dkHzY4h/fHGDgzMTSZBXpF4GIpgNNIn1ITsz6bxUJjTAIyDGYjxqW0Xpzbb6owe0EeEIE0uK/levtecgub+W4ejc0aZlLviOPZpPjc5m/BqszGw6Z+aSzWGdmdT0mzLym0R3HMCJWaXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037827; c=relaxed/simple;
	bh=r4TTLFKbvrodIaRQTa0ht502cGC2jU2jjGTCIPdnZtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mybWPHys5t9peWrESVEyvg+CvHnaui2O5RSWn0lQ1mhjalWtb78CgqqVU2LN9za0eFWYRwNDPcIBU+m5Ql3k7mldiM+ees3/dIEuDbVQdkJMyZIswTFWwrJtXYcPAFDXdnhYWPV2Gci8lsMOeZ/EJRUGtN6yEpNckzktON1g9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=lHMVdXb2; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="lHMVdXb2"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29A8743971;
	Wed, 25 Feb 2026 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1772037818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b397kcDkE951NYkAcVrXMDdkhDmoumZub3jJkb8sfRo=;
	b=lHMVdXb2sDI2Xu05aelCW5yw0J7Xz8tvQB+sGFZK0iEUFYKMmwqCyRzPr3IKANrcbeNupH
	llCuq6H+W4bPrh8I4nRdprJ3DteMC1rex1r7u612izKTMDWH1uMuU+wwInd8YjErTDIv3E
	ccQYb2AA4MTKF+8DaBwuSbOj9AxmA976nwz6R/DhJUKfb2lZY7leYW+LWd7nXbeHrJ1lDp
	7H2S++/cFPdTTNTq09/Py07HjiLiqwe5gQyIPOvlBWizZDjZrRPJrNHBal45kxuIyMXxGX
	V1ieUkxPFBh5OpYFGsdC4JK77X9d5bMD7WFOdN78N09p04vGVJJs3fjXnxbj1g==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Xenomai
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH v2 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
In-Reply-To: <c2a6c8bf-0bb9-470c-81f1-bd3dd60c5f3f@siemens.com> (Jan Kiszka's
	message of "Wed, 25 Feb 2026 15:36:16 +0100")
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
	<20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
	<cbadbf4e-0d05-476e-8d18-49436fe52868@siemens.com>
	<c2a6c8bf-0bb9-470c-81f1-bd3dd60c5f3f@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Feb 2026 17:43:33 +0100
Message-ID: <871pi8ydsa.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepvdelteekjeegfeeljedupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 24.02.26 22:11, Jan Kiszka wrote:
>> On 20.02.26 12:27, Florian Bezdeka wrote:
>>> The signature of __request_percpu_irq() got one additional affinity
>>> parameter in 6.19 and 7.0 will remove the function entirely.
>>>
>>> Dovetail 6.19 will introduce a new dovetail specific service called
>>> request_percpu_irq_affinity_flags() that allows us to set flags and
>>> affinity at the same time.
>>>
>>> It might happen that older Dovetail versions get the new API via
>>> backports, so the re-#definement for older kernels might get
>>> obsolete earlier than dropping support for Dovetail < 6.19.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 6 ++++++
>>>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 9 ++++-----
>>>  include/cobalt/kernel/dovetail/pipeline/sirq.h     | 9 ++++-----
>>>  kernel/cobalt/dovetail/tick.c                      | 8 ++++----
>>>  4 files changed, 18 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..df0b8ceb05c25d655a331d238e7ef8ac8a6afeea 100644
>>> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
>>> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
>>> @@ -5,6 +5,12 @@
>>>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>>>  
>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
>>> +#define request_percpu_irq_affinity_flags(irq, handler, flags, devname,        \
>>> +					  affinity, dev_id)                    \
>>> +	__request_percpu_irq(irq, handler, flags, devname, dev_id)
>> 
>> BTW, this effectively invalidates the affinity parameter. Before we
>> could make use of it, we would have to backport the dovetail function to
>> older kernels as well (6.1 right now).
>> 
>
> For the time being, I would like to have a WARN_ON_ONCE(affinity !=
> NULL) in the wrapper so that we have a chance to detect future overuse
> of the new API.
>
>> At the same time, we seem to be forced to create all the OOB interrupts
>> on all the cores anyway, even when supported_cpus is set to a smaller
>> set. I do not recall why that is the case, I just vaguely remember
>> having asked this before. And as long as it is required, the new
>> affinity parameter will remain NULL.
>
> Would still be interesting to recap this aspect, both for classic cobalt
> (supported_cpus) but also the evl core (oobcpus). Even if the lock
> contention in the absence of a global nklock is not there anymore, I
> guess there would be value in not having to proxy the timer on cores
> that do not host RT workload. But evl is currently requesting the proxy
> for all cpus as well, isn't it?

Only on the evl_oob_cpus set (tick_install_proxy()).

-- 
Philippe.
