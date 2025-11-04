Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0F30AAB8
	for <xenomai@lists.linux.dev>; Tue,  4 Nov 2025 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242823; cv=none; b=fpx3hzErXNVIZL2JRQQqAQaOql5sFYZVJEl1vp2QHEz7Y4z5zGEuwtDsbR+L1D6Jf7rrWYHbo9Yt4AfUH2KdFvj/K5kpeZ53ZdYrmHRyk/LMxsr3OOJZWHfCpuixFZpvOHf3YoQSbyEhQzms2QrGVbzRopy76JuWh7OhEwGUtyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242823; c=relaxed/simple;
	bh=6Mzgy5aDjQBqykbLcSJ3a3sixKIXmq1QB7Un+o/s5io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euFkuQNEQFo8BReFH5FchBQGDNdeMe1Il+6JjHGkmAWqd63LLkROwru5bXmb5jhTVPGMbylcKNoivQSFf7QEUg3YDRdgKN2njOH1jKmtRKBJKJL8VxvcdWb3Ao24WqqA83aqbYREYzF0arO1Wc59CR9GlT8vJerxQVbkXLG6fu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=UMoWd0ou; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="UMoWd0ou"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2F3D108D02;
	Tue,  4 Nov 2025 08:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1762242812;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jweSj5czry2AuxzblM4G/p0/TGfpEODQ71wh2f5EC78=;
	b=UMoWd0ouBGaVJNbiy/rMUUa5yPxyS70h7QpAAXvj4VcYxa55y6rxFprm1n8UYaLsIgWIwV
	R4LpPd9y3fBDLpyzifETIgxh3hCd0ncpDMubNKp0sznMRH1aWNaTAPTU/1Cq0wlGT6v0kh
	Zz0cxJafaw4CbVNMZnojL9iB3MGFFVOQ7Yv+HmeDVUpdR5zy/MugKtpp5BN9AbFGnLLNOu
	PqPPx5/GEF2MIuobyccUcnKL8bRv8UWOuzXMEIfFVZ4GTvftYkBBw6B7ZkBl8oh1ACjawr
	gPeJR5gRWr2kQMr7gIbyG1JYc32xBapqys+0Lf3Uzh5hPhMmr9e7U0iiJdJG2w==
Date: Tue, 4 Nov 2025 08:53:29 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Unexpected switches to in-band
Message-ID: <20251104085329.3bfa97f9@wsk>
In-Reply-To: <87cy5znrc1.fsf@xenomai.org>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
	<20251009151737.0d03b211@wsk>
	<20676160-4572-d92d-4b33-ff4255946345@bela.io>
	<87qzv9sa9c.fsf@xenomai.org>
	<87ikgls9kh.fsf@xenomai.org>
	<f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io>
	<20251020094705.2ac256f2@wsk>
	<9d2bacac-8d70-f083-e926-21beee2207c2@bela.io>
	<87o6q1ad07.fsf@xenomai.org>
	<20251023155439.0170f987@wsk>
	<87a51djuor.fsf@xenomai.org>
	<20251027120535.7933c720@wsk>
	<20251027172505.29eecfb2@wsk>
	<875xbyawx7.fsf@xenomai.org>
	<20251029145125.71debaab@wsk>
	<20251030132602.2d1ccfcc@wsk>
	<87qzukuzy5.fsf@xenomai.org>
	<20251031165615.2c9f72f5@wsk>
	<87bjlnc9u5.fsf@xenomai.org>
	<20251101165957.12432bf4@wsk>
	<58fcd922-3a50-74c5-bfee-01cbcb7e1e6d@bela.io>
	<87cy5znrc1.fsf@xenomai.org>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Philippe,

> Giulio Moro <giulio@bela.io> writes:
> 
> > Hi everyone,
> >  
> >> CONFIG_COMPACTION=n - it also automatically set CONFIG_MIGRATION=n
> >>  From the Kconfig dependencies CONFIG_MIGRATION=n -> !PREEMPT_RT
> >> [=n]
> >> (i.e. it can be only enabled when PREEMPT_RT is NOT)
> >> I've just set CONFIG_COMPACTION=n (which also disabled the
> >> CONFIG_MIGRATION) and now I cannot reproduce the issue on my setup
> >> (i.e. v6.6.) anymore.
> >> It looks like those (enabled by default) config options have
> >> slipped in
> >> silently and introduced the issue...
> >>   
> >
> > I can confirm disabling CONFIG_COMPACTION and CONFIG_MIGRATION
> > fixed the issue for me as well. Fun fact is that I started looking
> > over these options when I first raised the issue, but then realised
> > that evl check did not flag them as problematic, giving me a false
> > sense of security ... Without knowing much about the internals, in
> > hindsight it makes perfect sense that the process was more likely
> > to fail early on in the lifteime of the process and/or of the
> > kernel than after it had been running for a long time: once the
> > memory layout has settled, it's unlikely it will get moved again.
> >
> > By the way, I was thinking that replacing an in-menuconfig warning
> > (a la Xenomai-3) would be nice to have, instead of having to
> > manually run evl check on the config file.  
> 
> Actually, we want both. Some automated configuration process may not
> give us any hint loud enough, a runtime check is always welcome,
> especially when providing support.
> 

IMHO, it would be enough if we would have:

1. evl check complaining loudly about CONFIG_COMPACTION=y and
CONFIG_MIGRATION=y

2. Just adjust Kconfig to have:
CONFIG_MIGRATION if !DOVETAIL



-- 
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
