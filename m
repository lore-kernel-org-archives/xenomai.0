Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482760;
	b=PN9lCtOZbyH0RsjiR6o0U0LTcFO5TrwvowtQxIl5aUbP8VIzLVHBOW8JhTLYfJfdpGBv
	 b6S+svXNemqCPb9YxJY0I7MFOCWhjp5o3RNhd3kc0p/JZwRjf/LTTMNucJyWEtySL9gGL
	 AVnOtjlvywjeejquucsVC8M4mI8I/1NZRaUWsTL8i+xm/s5TXpl1Vjb+eCK/FaadLGdr5
	 tiUYZmCE2JGMIHUa5ObysY/7RLA1b76Wd9n3s77BWwboBlEOdwxL3zjl6EbLB4P5SI9dD
	 MH3gnDMb6Ne7THln2obB+5icnMR4/M1cRMY+e8mhJwKxZNb/pv+GtvXJWIjxra8eNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482760;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Flowmailer-Platform:
	 Feedback-ID:X-GND-Cause:X-GND-State:X-GND-Score;
	bh=AAV0qO+mnLQtUq+TP5aLEBgmSGuU9vFw8ppbV8YRLo4=;
	b=wPC7T5b1xriwcoshA7mciq6F+d7Vsps9lpjGgJEweRTf/prbSkL8YbUNPE0LAvNBGK4B
	 WcgFBYO+Hf3IMUTa+AK1utvLoPdlT32L5k/g0G0BwVXRJ9Ywn5AdmhhrWrZyvsZ5kqb5P
	 c/BB4NwvpJKfVpNwQy6GtlEvewm6DvLugjadONkFEW2XvvjTVsfRVFiRVP9U/eC1lzsZv
	 NO6itDqCPpvW8+ZAsHLIbNLbJqS+MJeqzYs9jgaIthM1Yfm2Lb3XC0gxKsmkDbuCIYasS
	 fmLlvq8CFYTDRIKvx393f/Mf1ytwntkzo+vqPzuEF+83ycu1wY50JUOqEgTkXvvrFqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=fje7S6p6;
	arc=none smtp.remote-ip=217.70.178.233
Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA62606A8A5
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA62606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=fje7S6p6
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 75A953EAB8
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:25:56 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 1F0A927E011E
	for <xenomai@xenomai.org>; Thu, 12 Nov 2026 11:25:55 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=fje7S6p6;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20261112112555d768481446000207d5-JiRFVZ@rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) smtp.mailfrom=fm-68982-20261112112555d768481446000207d5-JiRFVZ@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261112112555d768481446000207d5
        for <xenomai@xenomai.org>;
        Thu, 12 Nov 2026 12:25:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AAV0qO+mnLQtUq+TP5aLEBgmSGuU9vFw8ppbV8YRLo4=;
 b=fje7S6p6DKQskCBRA+4H62wIIcKhUvQhAKoWGr2FFa19NE89QZ+wuoM7z/HxBYD05YEPq6
 9WvzLSXEJCETiUVYt2PQBng5vUxlMRuqRJl4KyONBBjoHlhftKugljsyR4hZVI35mguhFE70
 YMdUA2gfOUMRkyMEotcKdyZg5LvcWlYnE2bsLSaUKATjcPIV5C12uRzxzKD1SiRq/XnS63Et
 KIIW2APARoH19bCqIe+iuSu+YSbBpV5DASeMwlZifdw6Ne3k2FdmSCwoA5tUOvKI0VlOr87g
 nIcjBc2lk+pxYqwOs/vaPfAVMa0UBiS3UcQBdTGMUNQ7iMrltD2MPXYA==;
Message-ID: <339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
Date: Thu, 12 Nov 2026 12:25:54 +0100
In-Reply-To: <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	 <87cxsa2vej.fsf@xenomai.org>
	 <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
	 <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
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
X-GND-Cause: dmFkZTFt9IyL+Z00wT3ADS6b0OzF1VsYeGwoBkVGYJD251jZrLinYb9tqIX8n6cgx0DZhdVUxIxGq+So+3oZSQpBRdtCRP7rteOVFzybVU0oZU9NPi5bHzq1XIFgZ0Po2Wt8+qIjZp3ljjHWiuvIv8vmc0lt5os7hmrs3GksRwq/nil0ZRM7x/QWgYgJiZV+1VeZZckbhvgEZ8R1PBv6cBABy2DOwOTUKdvIXMI1fdn/nanCPF6gf+g5ih9VQMO1ghqo9jpbPVLSWttDW//DEw0YWn45hmkxRvuTpvcQkmooenwR6+aDc6W4iqr5c+U9txeFk1xpXmh46C8vmwUpCpcUT0iLN1MKVc3GrM5TI7BgCBs7ME6eLjPtJQImNk/eCOnoo42qAAu81nc5dOAWz95QuG89MCAoPBxMxvvUcCKh2IpcfV7lW3F5mEw43nopUEaLPWur2dGuL7XzrUIzT9z7klQI8u2tn+je2S+wdYhb8wYc00i9zjgCfEYMSqfgD/8+SKEntwcvwpJyg5qLMoZ3UR4KXkCP/n0/x7GzqocqpFxjq3qqMIVtuDzkJ2xVWqlfz+LLeOR2m1K9Nkh3Z3ETsEek9bp8wDYJ+YXOb0UubIL+lRxEEU3EuvHtG2FOWJ4Qt1E02ciZlm78NwGYU/98ccedwN1lJ6wNlilva8piT2ANIA
X-GND-State: clean
X-GND-Score: -100

On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
> On 12.11.26 12:05, Florian Bezdeka wrote:
> > On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
> > > Jan Kiszka <jan.kiszka@siemens.com> writes:
> > >=20
> > > >=20
> > > > I will share the lengthy test case as well once I'm done with strip=
ping
> > > > it down further (if possible). What the tests already demonstrated =
is
> > > > that unpatched kernels crash.
> > > >=20
> > > > These patches here are almost completely generated. One of my few
> > > > contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The id=
ea
> > > > of having oob_trap_regs as a nesting detector came from the AI, tho=
ugh.
> > > >=20
> > > > As usual, AI is still rather verbose in descriptions and comments. =
Some
> > > > of them I already shortened, but most is still left. We can cut dow=
n
> > > > further, but I would first of all like to have another review round=
.
> > > >=20
> > > > While doing that, keep in mind that AI tends to ignore issues left =
and
> > > > right when being told to do a specific task. It may have simply mis=
sed
> > > > further preexisting issues or even created new ones now. Watch out!
> > > >=20
> > >=20
> > > It looks like patches 1-3 have landed into v6.18.Y already, which mea=
ns
> > > that you are confident with those changes eventually.
> > >=20
> >=20
> > Those patches should not go anywhere until they reached the latest
> > development branch. The common "upstream first" rule.
> >=20
> > Everything else will add a lot of confusion.
>=20
> The v6.18 application was experimental, to validate that the test suite
> passes on real hardware when all issues are addressed. Nothing is
> official in rebase branches until it is tagged, including those patches.
>=20
> Jan
>=20

Why not just push out a wip/ prefixed branch? That does not require to
temporary update branches looked at by different / more people.
