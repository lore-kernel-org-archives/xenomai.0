Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15A32D7F0
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981315; cv=none; b=qLH6Vxz7UOm+B66lH86G4ldhiOfrtScCsonG/KJMP259ilLBZ7bJOXDFIb1BaZjHi7basCJ3iJwbrTHSLZcJxJsH/KhV4wZlZ+ZOXr5E9MAQpwD+n/tG6ldLpC6BlDA/iIXdhieXrVUSWG+vxU6O3wWXm02UGb/L/cdfl/n8Tqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981315; c=relaxed/simple;
	bh=iL1MWYxWeBrBNEUb98kU9cxFu6B2GwRY+Jgi6gDKsm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jrU1NRG4RQ6vjWBW7UQra1hwGo7GPneOSL1O7J56wOJD871BoMN6JNIuYUh6R/7Du2J10VFtooscONTYVoe4DCiZpVGnvTIDfuBHMgga9CQO6D0zbIfRUCjg6o3fdw73X5VuVrvD6xEjMo3/ijH2TFl6Y4rODaja1ui8c3u6LHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=TTFR8lcG; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="TTFR8lcG"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 79AEA580EF7
	for <xenomai@lists.linux.dev>; Wed, 17 Dec 2025 14:21:49 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83166430BB;
	Wed, 17 Dec 2025 14:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1765981301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LWwvxZ7xsRL8X4O3qKuotroyjdvtgF7R8J94qlxIhrQ=;
	b=TTFR8lcGCHnsVbKQfDiTI6gOLaf5etk7wSLA24bDIRd/4nrkhL+9twwp5KL4nX93vdu+xo
	GIxC11gO/v/L9m/ud5oG7FrC5hQuFbrLkCg+sr/HNGwLq4WgX8EmEhyEP416ZbyYS7WQYj
	p5E71H6ObG4BBbQPLjwy+ZDaLEhv/75z+ioFWkN0OVm4EXpoTXN9XIShS+uiDuLCehnsCm
	FSgPWd9DhHwocV+kuVRWXkbTJjxTggwAYR/TAYZILOW4Nb2uUso0h5Kn3mjX+En+lM2/AB
	6Z+ua2o/dI6m7Z+vVkkitQtsGavyTuX7t3QTvKgXH6HPqUiGPtwqpCv5aXWblA==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Philippe Gerum
 <philippe.gerum@gmail.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU /
 FPSIMD usage
In-Reply-To: <f20f223d-dd45-4821-9534-b54ebf1c92db@siemens.com> (Jan Kiszka's
	message of "Wed, 17 Dec 2025 13:46:38 +0100")
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
	<875xaq88tf.fsf@xenomai.org>
	<0b02043cfe5b2032611180d514dcb2eff690d844.camel@siemens.com>
	<87h5txuqhp.fsf@xenomai.org>
	<a1849bb77a5e82a5eaea88d0498dc42ff6d88c1f.camel@siemens.com>
	<f20f223d-dd45-4821-9534-b54ebf1c92db@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 17 Dec 2025 15:21:36 +0100
Message-ID: <87sed9p4sv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepvdelhfdvheekudehveelgeeitdeujefgkefhieejfedvieejkeegiefgjefhkeegnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeekfeduieeigeeftdeuuedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehphhhilhhiphhpvghgvghruhhmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomhdprhgtphhtt
 hhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.12.25 12:19, Florian Bezdeka wrote:
>> On Thu, 2025-12-11 at 13:56 +0100, Philippe Gerum wrote:
>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>
>>>> On Mon, 2025-12-01 at 17:29 +0100, Philippe Gerum wrote:
>>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> these are the necessary backports for dovetail 6.1 that would allow us to
>>>>>> enable the in-kernel FPU usage of switchtest. This is currently not
>>>>>> possible as dovetail < 6.12 does not allow / implement the necessary fpsimd
>>>>>> context switching.
>>>>>>
>>>>>> I have backported the necessary patches down to 5.10. That would allow
>>>>>> us to unconditionally enable the tests for the xenomai3-next branch. I
>>>>>> will send out the 5.15 and 5.10 series once we agreed that this version
>>>>>> (targeting 6.1) is correct.
>>>>>>
>>>>>> Please note that there is a small problem with this series. Patch 1
>>>>>> removes the check/flag that was used by the dovetail enablement code to
>>>>>> detect in-band FPU usage. The new flag is implemented differently in
>>>>>> patch 2. Patch 2 also fixes the usage of that flag. I had no better
>>>>>> idea. Otherwise I would have to delete? the in-kernel fpu preemption
>>>>>> code (temporary).
>>>>>
>>>>> TIF_KERNEL_FPSTATE is not covering a preemption of a softirq handler
>>>>> using the NEON unit by an oob thread when PREEMPT_RT is disabled, kernel
>>>>> or user for that matter. i.e. It looks like this aspect was overlooked
>>>>> during the busy -> TIF_KERNEL_FPSTATE transition for Dovetail, so a
>>>>> broader fix may be required. We may have to use a marker which covers
>>>>> any type of preempted context.
>>>>>
>>>>
>>>> I agree, but this is something that we should address in addition / on
>>>> top, no?
>>>>
>>>
>>> Yep, would make backporting easier.
>>>
>>>> This issue seems to affect all versions of dovetail. If we do the
>>>> backports first we can address the issue on the same feature set. That
>>>> should simplify the back-porting again. Did I miss something?
>>>>
>>>
>>> Agreed.
>> 
>> How do we proceed now? Once applied to 6.1 I can send out the versions
>> for 5.15 and 5.10 so Jan can apply them as well.
>> 
>
> Philippe, do you plan to update 6.1 soon? Or should I already take over
> 6.1, given that 6.18 is on the horizon and you would likely stop 6.1 for
> evl and dovetail soon?
>

Please take over.

-- 
Philippe.
