Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF0353EC2
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606922; cv=none; b=tmjPHfY3TeuA3l9AWx7/7U89dYup6nl/Wm52Z2k7Po/V5o/Oisp3GuyEP/jS1P4NHmLqAXP+ZQgTmEdhP087Fb35ZS2o48fOS4+pQpulAZ6JOMXSqIMqN82+zr+93F+MhjEJfrmhl/xSRRW6ewkGk+Yojby3RL1bvHp/rScw/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606922; c=relaxed/simple;
	bh=/KcdOeoqoTnBSbKgBMl1mcjXeV1Pv1cBQBUsJiqBTEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TT5pCc0NkFz1TF0tW0Uwp43vpwuBxz3KoSQtvXesiaBeIyAAE7mCmsBED1KUVaZ9Bv6du3AojVDU9ZQk0ZP+C6cWv6GA8Rm4e2Qm49LsDMCi/jnu2pQHkwXu6MML3JuLpBDb962cAzXHZB8nJUdZSnnlqnD66bjC6rZgkCGLN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=oxGMxPJY; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="oxGMxPJY"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 91F855806A5
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 13:23:30 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3456844288;
	Wed, 28 Jan 2026 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769606603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RptRgywKGWsFzZnBaDAno4iMyzd+spSjl4EELERnTZU=;
	b=oxGMxPJYFpSlfyVKF0Ab7Pfdq7Tmd680CKHeT3IC1LJbPsgo5TZztHNNRxHL4Uw/MIqIDH
	NOHBMm8DH76Rk+DXKO0Ens37u/gKCwN/CTT93F2sv/FVQyCdvpMj68t1ESCwOwf2XDOPUi
	wqvp5deAt6g+hVMIGFOcV0rz5zZi2aUo2x1ZZUwjai/xAh64mIRAaoHwQl1MmZZDT3F7dI
	bw0sPVwaWYZl7TrO9yUPFwPdeITfebIEQYE39LwWwaRWrcBapHg9Zmb6ozQ+TogimtiANF
	+U5nJRLz2WapaKKiyfqAmr5fUmxZhzkVVcTiQcb+CFhjeNHjp9le4A596eGltw==
From: Philippe Gerum <rpm@xenomai.org>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai@lists.linux.dev,  upstream+xenomai@sigma-star.at
Subject: Re: [PATCH 2/5] Make RTDM tasks behave, part I
In-Reply-To: <20260128112821.1232-2-richard@nod.at> (Richard Weinberger's
	message of "Wed, 28 Jan 2026 12:28:18 +0100")
References: <20260128112821.1232-1-richard@nod.at>
	<20260128112821.1232-2-richard@nod.at>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 28 Jan 2026 14:23:22 +0100
Message-ID: <874io5vpkl.fsf@xenomai.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugepfeegheeikeeggedvkeekpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehuphhsthhrvggrmhesshhighhmrgdqshhtrghrrdgrthdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrght

Richard Weinberger <richard@nod.at> writes:

> RTDM tasks must now utilize rtdm_task_should_stop() to ensure proper
> cleanup and SIGSHADOW detection.
> Also, handle -EINTR gracefully, rather than exiting immediately on
> interruption, the task should loop and re-check rtdm_task_should_stop()
> to decide if termination is actually required.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/drivers/autotune/autotune.c              | 17 ++++++++++-------
>  kernel/drivers/net/addons/proxy.c               |  6 +++++-
>  kernel/drivers/net/stack/ipv4/tcp/timerwheel.c  |  6 ++++--
>  kernel/drivers/net/stack/rtcfg/rtcfg_frame.c    |  6 +++++-
>  .../drivers/net/stack/rtmac/nomac/nomac_proto.c |  6 +++++-
>  .../drivers/net/stack/rtmac/tdma/tdma_worker.c  |  4 +++-
>  kernel/drivers/net/stack/rtnet_rtpc.c           |  5 ++++-
>  kernel/drivers/net/stack/stack_mgr.c            |  6 +++++-
>  kernel/drivers/testing/rtdmtest.c               |  9 ++++-----
>  kernel/drivers/testing/timerbench.c             |  2 +-
>  10 files changed, 46 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune/autotune.c
> index 03fd688de..c11d18057 100644
> --- a/kernel/drivers/autotune/autotune.c
> +++ b/kernel/drivers/autotune/autotune.c
> @@ -248,22 +248,25 @@ static void task_handler(void *arg)
>  	xnticks_t now;
>  	int ret = 0;
>  
> -	for (;;) {
> -		if (rtdm_task_should_stop())
> -			break;
> -
> +	while (!rtdm_task_should_stop()) {
>  		ret = rtdm_event_wait(&k_tuner->barrier);
> -		if (ret)
> +		if (ret == -EINTR)
> +			continue;

Using -EINTR is going to be a problem if xnthread_unblock() is called to
forcibly wake up a kernel task from a sleep. In this case, you would not
be able to distinguish a signal receipt from a forcible
unblock. -ERESTARTSYS may be better for that specific purpose in the
RTDM API.

-- 
Philippe.
