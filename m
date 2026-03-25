Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7E3E6DE4
	for <xenomai@lists.linux.dev>; Wed, 25 Mar 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451529; cv=none; b=WsiYM/RMhbDya2cLe5OeRvTE6kKsgmtYD/p6229KfioG8RVYyH/+NH+5h6jSj4nFvByFdSKI51LkkykACMpQmK7ilwfxws+KvLAMja8QqiAm2OdR86VTT5vbElMIcnf9OJoJf7ALAKZX3HWwl48Ol0gmueW8Pc4hQv1NTRyvx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451529; c=relaxed/simple;
	bh=xH6O3+C80tP53ke0CYMG1fFCukyLSJ/HM2g2qnJLJII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e3ZCLLeM5ukwmdnAl/sgS7/PdmTiISQcwlM7dihCfwFIOsnj57jYs/2nufTKY717LlKH9ekxA9EHh29RZbv6f8yVWzR+MafFsmXfooHDZH1XCbBaafsFEplLQht+7mjpBJb7Bv7qen7e9drPWEmZLxhKkz7NFVPHpMLQkhfsECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=FutRfOGn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="FutRfOGn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1DF83ED11;
	Wed, 25 Mar 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1774451526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5R9Si1z/M74ZAAb+2NoJop1tZcgPKfDZ6n3QXf23SLw=;
	b=FutRfOGn1lWUPIz5//XpcRvnriYUTI892CLdFO6s4Hu9EbhcAA7XO3XVHxvSTKfMsM9equ
	zDv6O7D0WF//bo+W7yXotBFZ3pgy7etsspo0LnSaxu7hVe/+N2ZexKLdLNtIXKPd80WMBY
	0TCrF0ZzUkT8UHM0BmBVbfeC3aBzbvOeH3Hc4svKQMrLifW0wFiWeNEy/od0mWVOoR6aL9
	KnETTxcK7Ba1b5UgGRKGxgFl232h/ZOZ88kdtB8q0RHuWx0whsXnK5F5CNi0cheZXx2hFQ
	jksaZwp27vFhq3XZqUdM2/waWKAMju9aYdkXqeh20BGIm6PLrB3XiybLdIHthw==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH linux-evl] evl/latmus: handle ERESTARTSYS from
 evl_wait_flag()
In-Reply-To: <20260320211822.2151049-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Fri, 20 Mar 2026 22:18:22 +0100")
References: <20260320211822.2151049-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 25 Mar 2026 16:12:05 +0100
Message-ID: <87v7ekhrju.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepgfdufffhkeefgfffuddupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepthhosghirghsrdhstghhrghffhhnvghrsehsihgvmhgvnhhsrdgtohhm

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> evl_sleep_schedule() returns -ERESTARTSYS when an EVL thread is kicked
> due to a pending Linux signal (e.g. SIGALRM from the -T timeout).
> run_measurement() only checked for -EINTR, causing the histogram data
> to be discarded instead of copied to userspace on timed runs.
>
> Fixes: 6f1edfe3b73e ("evl/syscall: fix restartable syscall handling")
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  drivers/evl/latmus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/evl/latmus.c b/drivers/evl/latmus.c
> index 0303e21d066b..9a0295044443 100644
> --- a/drivers/evl/latmus.c
> +++ b/drivers/evl/latmus.c
> @@ -970,7 +970,7 @@ static int run_measurement(struct latmus_runner *runner,
>  		return -EFAULT;
>  
>  	ret = measure_continously(runner);
> -	if (ret != -EINTR)
> +	if (ret != -EINTR && ret != -ERESTARTSYS)
>  		return ret;
>  
>  	/*

Merged, thanks.

-- 
Philippe.
