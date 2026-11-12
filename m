Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.178.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481555;
	b=Fsem1dGJWfnz791PQR32boVANRC3c4iA0l2g6lvJjKylG1I5MM1/GlwFZOGh5TTA9Fz/
	 dUFuVjQWhKkviDf5723+d4qSy/hJ00IEnEeo3IFFtkBYXJdvmZB5s9XVwci0pVg9E/Bxv
	 hkJcs8XNn9wMCejd+53yLgi9peZYxpAK7/Fk9OjZyXPnLM5e03VUUx2+NJfdCEzAqbbqw
	 1Cci3qd5qkjFQWMVBVqXvmgask11hhQzrUqldDjw+hGzk8ju3Gs4CtJaBYx5M34YiSysL
	 9ft0qITtM95KyRU9zt2O0fT5UEtopE80pDdKiYKFhi5pQQPXVKmJpVqmKjxiZgtVDcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481555;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Flowmailer-Platform:
	 Feedback-ID:X-GND-State:X-GND-Score:X-GND-Cause;
	bh=oeaOkLLpb+QvqQ1GTHWxz1X47H3o3iY1I30bZb9ghA8=;
	b=Zt9VtJCkWjCviwA8y933Y8+4G6h9m9pfQEqubIPN2JzdXUTXUs4PhQmA5KmnLBERpgkx
	 ehsnhiUhdaQovyVruUIb8HY6WvUuy7D6B+mpx8QuMRuEFnPBQYQVCQSL81n+a717jwTQC
	 zNuIipxcZZyZG+GG9sX96VxTlQck/PppAMjtxRpefMpGddjtSc66Q99VfLyav3qrnbTin
	 INA01xkczok3XS9Vibb2pf2511S0L/XXivvsF/ajU4UD7dlp3xr/Je0X3STsbXqbtDKib
	 16p/PwGL7HgaEcBKlRxGXNZQCMsHsGI8/ImhV+EY5lt+UVF0241+Ps4epNoRCcIbD7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b="Nl3Ydy/d";
	arc=none smtp.remote-ip=217.70.178.232
Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D78606A323
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D78606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Nl3Ydy/d
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 1DD493EA3A
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:05:51 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9F74AC006E2
	for <xenomai@xenomai.org>; Thu, 12 Nov 2026 11:05:50 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b="Nl3Ydy/d";
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-202611121105490ba83aa4390002072d-7NDFFi@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-68982-202611121105490ba83aa4390002072d-7NDFFi@rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202611121105490ba83aa4390002072d
        for <xenomai@xenomai.org>;
        Thu, 12 Nov 2026 12:05:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oeaOkLLpb+QvqQ1GTHWxz1X47H3o3iY1I30bZb9ghA8=;
 b=Nl3Ydy/dyOcnFeyvypJfu6SAQbjDYwrinBUWAqNAx+/ygcv79zs0F2A292ackb2VlWli4A
 vIEZFH2tHojrIomGWLVY/33zvB0g6LUntLgIpDltTrOBafTGZtkdC768GfDc0oDtdPFUFKqe
 nT+Gn35xnhhmgCp2yIcqTzWs03y8PrjKRkF+KY1XacGGz06Rs6MTKtaukRl6qeTgp1tJetss
 y01uhoHJw1EfAjOhyoI+/Nxlu64JPyNLkS1OrxS1jbokpIbZYn9hvykw0pG1rxlNaBz+3llB
 CW+aMTzmXBGsAzJ9gBxDgWCtXxGmH8LZtc8siy/n3Q8yC1ghkK6kzhKg==;
Message-ID: <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org
Date: Thu, 12 Nov 2026 12:05:49 +0100
In-Reply-To: <87cxsa2vej.fsf@xenomai.org>
References: <cover.1794399047.git.jan.kiszka@siemens.com>
	 <87cxsa2vej.fsf@xenomai.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFIrBll36v0pA4KvH+I7cwYMc+oEdIHiotLUyctQfG53g8y+xzqW1CAQSr/F+xqb2INAYpKSwWoBGud0LnjT8XBxQFYCtNvv+K/OGgUmrkLsdJQRbGlpit4fIa99TheLnWLSPf8Za20HRS2HV1PmZcLHKJaWzzw9jgJ0GardbnOUgSxKYkyWL8ELsFNSw6FPZKCMt5aJiEUotW4SdsJAOyH9HRYxWv9IgJl5oC16E8OqOqBvW0YDvv1g3a5NmMr+E9SKMMD/jjdPjaI8uQJBkAnGjRp5W6A24Yf+x8w8VlwB46kb1Ufda7cAzpOlj9OWlNdj3sw1HWF3lPAp/jWvlwJh5Te+d0E88qmAT2BNhN+jfQtZ04KUWcb26Z8MIl869Aax2aswC8tv+213fcwOqeklussFrlMIuSCC1nHsZkoPuQ+hgP8oD/GBu3StoNdLsYfTjo/+94hJAUyLGoYIQHCZXZVDEDrxiiisksEAkMfa++4DmuDP6Gv5OoBc63QCJamRThqeZVl9Cu2Ab/oR9sUeTKLMD7agymcWl5kGFPue1Bp73F/IICZI8/rTqw9U3D8qKzYupEMCUxHEhzcoDMghn98lQjWgdLkTQpKsu1ykWqbBCTl1L04j1+uONGS5y18CDD6voEutl+uLLjF1g4nfBjWCTdcU5n9nS6lt1/0sQ

On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> >=20
> > I will share the lengthy test case as well once I'm done with stripping
> > it down further (if possible). What the tests already demonstrated is
> > that unpatched kernels crash.
> >=20
> > These patches here are almost completely generated. One of my few
> > contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
> > of having oob_trap_regs as a nesting detector came from the AI, though.
> >=20
> > As usual, AI is still rather verbose in descriptions and comments. Some
> > of them I already shortened, but most is still left. We can cut down
> > further, but I would first of all like to have another review round.
> >=20
> > While doing that, keep in mind that AI tends to ignore issues left and
> > right when being told to do a specific task. It may have simply missed
> > further preexisting issues or even created new ones now. Watch out!
> >=20
>=20
> It looks like patches 1-3 have landed into v6.18.Y already, which means
> that you are confident with those changes eventually.
>=20

Those patches should not go anywhere until they reached the latest
development branch. The common "upstream first" rule.

Everything else will add a lot of confusion.
