Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC82119
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266088; cv=none; b=JQquaXSFIo/F8y1iaGwh2eUtorbFbkDmKY7npD/CyG819FfilMLWK4nGyNwW/JmfeZMrSPtrEOGgNGK3OwY7GGLA0moe8nIlRawZhubD4rJn88rEOR2EpkMEq5ics1DXjvsnJxyYMPhpciED5DXovBE/TaArk7dCkKeyANCV2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266088; c=relaxed/simple;
	bh=xULPOVOS+p0fXRLH9CQBcU/qQE8jngWrBY7ctoNEpWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFQUtGArkc5OHBeE4uJtqU5KoW7aFKyF7zgGUV5sxrvLa66xLtGrVAlXb+IW2YvujqhsbuH3Yg1LoY2a3A8d0LHF4oc/GoshhZQGqqmq+ZNXq6/irOazpryjtMybmThah9ypXUH61ehVUhatsuZ5Q+cQTbgrVivUsB5e9ygsXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=E/EvyTns; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="E/EvyTns"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024061308075501c4e33b2466ed413b
        for <xenomai@lists.linux.dev>;
        Thu, 13 Jun 2024 10:07:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/jGkpIYcqRFauXWVh9euo0D88uUBD7bYGVuSI+rBWWo=;
 b=E/EvyTns4JccfF9waSYVvsbV17RaGeuYVABxT4SzSoOXyglMdG/q8nCDCn4nodEMUA0kbA
 OjCacSgjIR9o2BBX6ju0ZtGeMLQF2cnv0Jnui64wzmVZST3mO6jsPksebIRvPLinecJ7iibQ
 I+sDmAd1oNIF20x0LEf1yvSop/eiY=;
Message-ID: <e8572de411ac7bc002cd08c276bc967aaf9c5ab3.camel@siemens.com>
Subject: Re: [PATCH v2 1/4] xnthread_set_periodic: Improve period adjusting
 support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>, 
	xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 13 Jun 2024 10:07:52 +0200
In-Reply-To: <20240608195337.11137-2-david.oberhollenzer@sigma-star.at>
References: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
	 <20240608195337.11137-2-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Sat, 2024-06-08 at 21:52 +0200, David Oberhollenzer wrote:
>  	xntimer_set_affinity(&thread->ptimer, thread->sched);
> =20
> -	if (idate =3D=3D XN_INFINITE)
> -		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
> -	else {
> +	if (idate =3D=3D XN_INFINITE) {
> +		idate =3D period;
> +
> +		if (xntimer_running_p(&thread->ptimer))
> +			idate =3D __xntimer_get_timeout(&thread->ptimer);
> +
> +		xntimer_start(&thread->ptimer, idate, period, XN_RELATIVE);
> +	} else {
>  		if (timeout_mode =3D=3D XN_REALTIME)
>  			idate -=3D xnclock_get_offset(xntimer_clock(&thread->ptimer));
>  		else if (timeout_mode !=3D XN_ABSOLUTE) {

This changes the behavior of rtdm_task_wait_period() when called again
while the timer is already running. This documentation is updated (note
the comment from Jan) but what about backward compatibility?

I think we are allowed to change that in the upcoming 3.3 release, but
should we add an additional note about that change somewhere?
