Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3855288D2
	for <xenomai@lists.linux.dev>; Mon,  1 Dec 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606571; cv=none; b=TpsUt4eIj0EgRNgCODd514Wnc4jqRluRKpulr2NKxN8H3L24XszKeR/BD6bovFj33hX+x3kTWxNYU6tc+VQsH5Xi/7NN3+hCV0ABGMUBmLapibtmxIbg2Seab8BhRHWS3AeLzRorSyGuM/806PLrXCjjeH0sd/R8SG0SjT1HCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606571; c=relaxed/simple;
	bh=VMR3Tzs1Ty0WYAztjk0Rt0NwJ4j6UqG1tsxHAxKQQ58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jag5cH2ZLjFiKGrNPz4Ve7oDKYQCxFVgLmLKTcZC1TzLCld6/DGu6ZPfC9LEQFRaIn/tJKm+QsdwxHf+c4/v9TTupkYe7tzSz0mYd0EKNFH3Te082zuMsShMKMlPuEniQeVc+mz5/WWFNU2NAD5irAQwIg95kYDEsyJ7+WywQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=T+Wtm/Yq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="T+Wtm/Yq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F54543EE7;
	Mon,  1 Dec 2025 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1764606561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=el0GMOoqfGECUSo03V4BXP77MkqUpbOZ95zu2pCHaKM=;
	b=T+Wtm/Yq7M3c26sEMgJFC6SU7XrSRFFktVU3LDkUXM/VNHHISWgZeAaj9udQFJnL7UabiS
	I1foKQED9pQsut1s4w+WczgwGvXp3FNL4+VcFsL6P/fWqDDo7JhJWd7AUfJDCHMrrAuVeL
	YX+necx49l/2pEoy/fI/4YlukgiUOH0el3G/ihgORgUhJFMNtm6cPJ2ETGuB2DGKRldOYg
	1I9x1hZ7eTECPnEhO3KZHfD7cB4smq8Mts1MdlFBNTwRXtgIqu4J5CNJgye3Qj76VEKqYJ
	BrCgHEtN1dk0fT7HSSv2veb/J897YXmCa2cK8vYqpQ07JgVL5DnIKiLoSQxRYg==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev,  Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU /
 FPSIMD usage
In-Reply-To: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
	(Florian Bezdeka's message of "Wed, 19 Nov 2025 15:25:18 +0100")
References: <20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 01 Dec 2025 17:29:16 +0100
Message-ID: <875xaq88tf.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheekudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepfedprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfhhlohhrihgrnhdrsggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-Sasl: rpm@xenomai.org

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all,
>
> these are the necessary backports for dovetail 6.1 that would allow us to
> enable the in-kernel FPU usage of switchtest. This is currently not
> possible as dovetail < 6.12 does not allow / implement the necessary fpsimd
> context switching.
>
> I have backported the necessary patches down to 5.10. That would allow
> us to unconditionally enable the tests for the xenomai3-next branch. I
> will send out the 5.15 and 5.10 series once we agreed that this version
> (targeting 6.1) is correct.
>
> Please note that there is a small problem with this series. Patch 1
> removes the check/flag that was used by the dovetail enablement code to
> detect in-band FPU usage. The new flag is implemented differently in
> patch 2. Patch 2 also fixes the usage of that flag. I had no better
> idea. Otherwise I would have to delete? the in-kernel fpu preemption
> code (temporary).

TIF_KERNEL_FPSTATE is not covering a preemption of a softirq handler
using the NEON unit by an oob thread when PREEMPT_RT is disabled, kernel
or user for that matter. i.e. It looks like this aspect was overlooked
during the busy -> TIF_KERNEL_FPSTATE transition for Dovetail, so a
broader fix may be required. We may have to use a marker which covers
any type of preempted context.

-- 
Philippe.
