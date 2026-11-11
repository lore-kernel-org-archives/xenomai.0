Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433839;
	b=Br+jtncOoPIB+pcWLoCQ0qy59hy5dgZVZoIhBFJnGj2IysRdwoHQAAnRWj9lendED1Wl
	 TFLFVxsIiKLGg9gQBwjF+whL+kWYmmw4EytwQciU3ubfBkFQiIkfPLYHk65BrFR7LZpNh
	 WnVYrf2iNCU00w9mV76qADY0NlAY6m5oHqyKIMY54mjyk4YSRZIKWJcDxYH60nkB16wpP
	 hKzgU1gDE7N+XFNuTxVEdghkL0yGqc5qB3e+6258+2z4nOItt7PAObAizThY9gPGRHPyn
	 27ygs/10KD+8ex8GSYuespH6FiSiexSdTjPoUkpOyWl5ecArHgsw3h2YVTuHcfivLzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433839;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Flowmailer-Platform:
	 Feedback-ID:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=tq/ccIKL/LwGA4CGwYC/Aru8f+FlCHjHLh3h+KvbGIU=;
	b=PcnVZuEbxvlWYt821/ODH+Pqeuz1NcsifV2qgxtE6TUD9IWVfD2t6IPzcwyThmiQHvAn
	 KewO+NuNtot1/6EQW54RstqctQkHBN2WTn/HZNOQlpQBm2eSv2K2Tyk49pGYG3tM8bTMI
	 nFu3tn2uhAe9Y/noKJ4UKjcFXnQ7gvb03h23kcqIwZYGYYjSpchzkm2UbHtn6iYhXKDZm
	 Lnf0bSXI0x/xWDU8buLVc1gRDzQ20DWMXCYcFjHMr+lUcTdPZi1131XuptoK4R+kw1KWc
	 G+aWK9lWYM63HtcsX2j3VEwTrAjpb4WLU9R9T+tTzw+JhA+/iLttS1oBAEjnyZWfd4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=oU4qk9lX;
	arc=none smtp.remote-ip=217.70.178.230
Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B43606A321
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 21:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B43606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=oU4qk9lX
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 2CB4C428DD
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 21:50:31 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id D8FADC0000E
	for <xenomai@xenomai.org>; Wed, 11 Nov 2026 21:50:30 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=oU4qk9lX;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20261111215030983099bcf60002073d-Xqd7OK@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-68982-20261111215030983099bcf60002073d-Xqd7OK@rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261111215030983099bcf60002073d
        for <xenomai@xenomai.org>;
        Wed, 11 Nov 2026 22:50:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tq/ccIKL/LwGA4CGwYC/Aru8f+FlCHjHLh3h+KvbGIU=;
 b=oU4qk9lXtcWiMYllAiM09rPJJrozACC2DUTbpD1YfG3Zs14eRKjHMxymlUky9nWBlYrUcR
 G6AHlnmktzrnzrtX+KM8+VDHTucCfgWRsVFSHFKg+ujYcUe9v3AieNYF+2waVchLdloKQFe7
 by5fjlhxGpJa1nJknpDM7FbYVG603AA9YQV+ml/RoV6y3EoM5t1LXev/U+xcz9ty6vIL22yx
 GHr0i31NJmOa3AXeQNqGiXQ7sZkPpUTixxt2EkFxjmAnpotExzIY6SQ9mU0bt8CfSNdw7mSf
 qkMlrO33Ui9WAS2uLnk54xbqsoWt6gCfUzMAZE5dzGdfKEH3P2y7Aozg==;
Message-ID: <91f0ffe92381f03a73177803317d5839af22ba5d.camel@siemens.com>
Subject: Re: [dovetail][PATCH 0/4] ARM trap fixes and generic handling of
 trap nesting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Date: Wed, 11 Nov 2026 22:50:29 +0100
In-Reply-To: <d39d9dd1-9757-453a-b33d-2951c7b6ae65@siemens.com>
References: <ed4a5ca3-009b-431c-b014-02046df3c04d@siemens.com>
	 <87ld6z6a7e.fsf@xenomai.org>
	 <d39d9dd1-9757-453a-b33d-2951c7b6ae65@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-GND-Score: -100
X-GND-Cause: dmFkZTEn/ny5v/zFMgMYyYNz9cWj7I/rglgyMZos850c3jYuga9N4ZmOuABtkIwxtdCTX56DbtVNeqF+Xdgna1/6K5dFpDG1n++PzDZXgFH+FAIsxUveO/tQ7wFpT5W+5SoMFz/QoGRg3fueJsT8i/WHfg1ooT4EgDobpfBDwN8i72Kd3zVnFAsKnRuWYu9mF2aJQ7SMeZcuUwmZ57LjBHr2HHwBb9CzUIC0O4YINpBQYSu6VkyO6chlnwgkFzFkf+pgIwI+5pRsS5N27u4MJNLfR9ZB3RC2Cb/Ady5E025uJUQZX+saHAF7bo3vMAgyE5xT9paF2Q9QKsKsYAj2Aq90EBdAeY7HqbGzoEGeUKK9WbppSn1lATMS+KCRR9Ghwwhq+HXlbDL+kMLZkJ4hryAUgl3JQqwlR8o2F9Wdxjc6hyX+LjcHcvPccu9cIfWkEXU2VCTZUMi5d5pKGgoTlJbv86yxO1uQngxcBdr1Zz04TeE4WRZV4YY3Feyu87urJPeuyqUSXB5OKmAL7zxVqSyP4RFJY4hNmdXbX2t+C0ykqv5hKf6ElK+IQVD86Vozh90DhqY/Y9oc+YclrQkOBCdzQSlFopM/cNQpSA4/14pyWttAdrMjDD8wK5ySQ8QQMYa9vywbhjy12OcDqbA8EB7H/Ww5zh23HIPJ4sDFpJ/DYbYORw
X-GND-State: clean

On Wed, 2026-11-11 at 13:15 +0100, Jan Kiszka wrote:
> On 11.11.26 09:31, Philippe Gerum wrote:
> > Jan Kiszka <jan.kiszka@siemens.com> writes:
> >=20
> > > Jan Kiszka (4):
> > >   dovetail: Track the owner of a trap notification by exception frame
> > >   ARM: dovetail: Fix trap unwind condition in __und_svc
> > >   ARM: dovetail: Notify the core about undefined instruction traps fr=
om
> > >     user mode
> > >   ARM: dovetail: Fix VFP exception trap notification
> > >=20
> > >  arch/arm/include/asm/thread_info.h   |  1 -
> > >  arch/arm/include/asm/traps.h         |  2 ++
> > >  arch/arm/kernel/asm-offsets.c        |  2 --
> > >  arch/arm/kernel/entry-armv.S         | 20 ++++----------------
> > >  arch/arm/kernel/swp_emulate.c        | 22 ++++++++++++++++++----
> > >  arch/arm/kernel/traps.c              | 27 ++++++++++++++++++++++++++=
+
> > >  arch/arm/probes/uprobes/core.c       | 10 ++++++++++
> > >  arch/arm/vfp/vfpmodule.c             | 27 +++++++++++++++++++-------=
-
> > >  arch/arm64/include/asm/thread_info.h |  1 -
> > >  arch/riscv/include/asm/thread_info.h |  1 -
> > >  arch/x86/include/asm/thread_info.h   |  2 --
> > >  include/linux/dovetail.h             | 12 ++++++++++--
> > >  include/linux/sched.h                |  5 +++++
> > >  kernel/dovetail.c                    | 10 ++++++++--
> > >  14 files changed, 103 insertions(+), 39 deletions(-)
> >=20
> > Please resend the whole series, some patches arrived garbled.
> >=20
>=20
> Done, hope this one was better.
>=20

Thanks. I have the same problem here. Only half of the patches made it
to my inbox. Most likely one of the internal infrastructure problems
that we face from time to time.

Florian
