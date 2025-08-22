Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732DF2E4241
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848172; cv=none; b=FT3bJYnJQQ+nlsJ0NFean2bJAFsIRUn2ynmrZ9QzqiriFhdhL4H/3/UGD+TLfbZOKSwbP3O7x7RvW909OpuUC5s567a/JKG9MpAwSaycfyS//ecB3NQHDhfMYsmEIuyy842v2tCSiPZEFIQWTGhUvXT4mof9Sm+aHJKq0XcFFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848172; c=relaxed/simple;
	bh=hQ/wwIvO/tvGpwmgx7SJyEHd+gD06RjdT8wlhz64eQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQrFnAfKiKw7/lhxLBxrui+9UoN3ljqsXOlBRTVwgHc9bIEUhLRoCD3rHOSzyJJHO1JWVmC3ikOShYDWoqMGOvInguVAKBGaM0BLQmJWdrJ4525m8ORdUQC6TkYOTFYATgn4frZfBodM4EI8cr7X0SZlbJ4dz7XLh3eRTi3cNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=VtBq15qM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="VtBq15qM"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B411341C06;
	Fri, 22 Aug 2025 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1755848168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2rrsHsIvyRSYa2U5LHaDSf2d6DFzRvzvG3oJlz3EoU=;
	b=VtBq15qMZccy4KtjRwEcr17/zIsYB+reiPWuItIPkp+4f/rmNuzG4CtVd57h5S1s9wSyiP
	emZAy7DcYZWLqYcwtWjNW3t05et5cyVlQICNwtmlMlcsp8jA9TuTg7VyhchjCupY9l8K1s
	aLo9Zv2fl6/AXwVDv0Pr5BPtaDnl8dmMRM9Jyy2PCr/A5KBty+r/VeEBRo0DsEX6Qo/YjK
	LS35mR9aaIYbdPGKWfJSb7rNRve78EBBeAzaAdBXlyti/rRdLfjloYaxvA2JJYOfqw4aNx
	xZd5MHj/wD6b1XAsZXJE48HbW0DO5oC8981iC9nDzSl/RIB5QYyZ49BbB9Axog==
From: Philippe Gerum <rpm@xenomai.org>
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
Cc: xenomai <xenomai@lists.linux.dev>
Subject: Re: Simple Xenomai 4 API use examples and a question
In-Reply-To: <87ect3hkqy.fsf@xenomai.org> (Philippe Gerum's message of "Fri,
	22 Aug 2025 09:35:17 +0200")
References: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
	<87jz2vhksw.fsf@xenomai.org> <87ect3hkqy.fsf@xenomai.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 22 Aug 2025 09:36:08 +0200
Message-ID: <878qjbhkpj.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevuddtteekjeelgeejieeikeegteelteegvedvhfeuvdektdehhedtuedvhfegheenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghmmhgrnhhuvghlrdhprggtrghuugeslhgrphhprdhinhdvphefrdhfrh
X-GND-Sasl: rpm@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> Philippe Gerum <rpm@xenomai.org> writes:
>
>> Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr> writes:
>>
>>> [1. text/markdown]
>>> Hi,
>>>
>>> I have started to work on a repository which is intended as a
>>> collection of very simple (dumb) examples of Xenomai 4 API use. Each
>>> example is an application, sometimes coupled with a kernel module,
>>> with the strict minimum around the actual API use. Applications and
>>> kernel modules are built using meson. The meson files are also kept
>>> the their simplest form. That was easy for the application building,
>>> not so for the kernel modules.
>>>
>>> The repository is here: <https://gitlab.com/emmanuelpacaud/xenomai-c-examples>
>>>
>>> It is similar to what I did for my own project: <https://github.com/AravisProject/aravis-c-examples>. I do think this sort a simple example collection are useful to understand how to use an API.
>>>
>>> It is a work on progress, the code should be more commented.
>>>
>>> But to be useful, all the examples should work, and I'm blocking on the oob_ioctl example :(
>>>
>>> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/oob-ioctl.c>
>>> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/modules/oob-ioctl.c>
>>> * <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325b57565edcd691021255adc486b90/modules/oob-ioctl.h>
>>>
>>> The ioctl call fails with a `Bad file descriptor` error. What I'm doing wrong ?
>>>
>>
>> Looks like a typo in the public path to the thread:
>>
>> - fd = open ("/dev/oob_ioctl", O_RDWR);
>> + fd = open ("/dev/evl/thread/oob_ioctl", O_RDWR);
>
> Sorry, stike that. I missed the point. You want to open the driver,
> not

strike that, too. Coffee underflow.

-- 
Philippe.
