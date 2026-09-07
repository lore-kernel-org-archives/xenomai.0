Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345E395AF1
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762252; cv=none; b=KUPw8weaCYuHgOAzz0wyYgDveEvOjMHCzZZpTl+wFtNOg5lhpTPKS69tG0uhCHwjODeXsMaE6TwxPyVZf/0vnPphc5M7XntCe2N5KWW4aEr1w8iCL2DwnhA/83BTQCPKK2xVKgZKewD/kAMEoBN5v+Ul6+9VZDH+UYWzCNP6mSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762252; c=relaxed/simple;
	bh=VefnOOxAqI7fllRco7iRrKcTrBptGRsUOdoaJ3+O3HA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6m3i5E3wVu01KDT33iI6Fnln2IxPOhyFzE/ydh6SwKCdhtp7w3WRhAk0H0YfXCOefW3MUQwQkkIck3qHmT+K+UghPIO79BLbb/79knHbNQbhcUerLH3fdKHVOWAbR8bq3dkD+p9OXUfuzHDEFRoq77claJyRR/sVtmNG23nydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TufdblQ8; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TufdblQ8"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260907062353e4f3c63e900002075e
        for <xenomai@lists.linux.dev>;
        Mon, 07 Sep 2026 08:23:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VefnOOxAqI7fllRco7iRrKcTrBptGRsUOdoaJ3+O3HA=;
 b=TufdblQ85LYnQZbmfy/mOvLBJgqTsC5lUNEv6DlBOI8wATnFNsjL1ivVIzLyoLLzn+enX4
 j+F3xy8STOo7mv+dILhnCZxgbVaJJvUG2hm7JE5IF4vXu5E+JWdJuoNrawfZp6hi+5B5sJso
 Rn3tzWQKxegF71y11t4aMU/h/LZT+TdCqZmj0g2odfCN/8m8ApiQiVFenAnwd4ZgeFeDO3Fr
 FE4dcIacrRMHoz4B7+1i01hkGV2TOPYgHGYQcWZUOCLOMBIZ9RQ2OnguEMqDRAZT9+PHIXsY
 wVdcgvQWm9Nkniev85j6MmKgI9XizmWfLnjyCcPoS7/bT8I+228P/xjA==;
Message-ID: <23b48beb746e3c998d704e2e2a1b4f5a5ffea3ca.camel@siemens.com>
Subject: Re: Idle measurement problem on arm_arch_timer (ARM64)
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Gerte Hoogewerf <ghoogewerf@lmi3d.com>, xenomai@lists.linux.dev
Cc: Andrew MacPherson <andrew@elk.audio>, Philippe Gerum <rpm@xenomai.org>
Date: Mon, 07 Sep 2026 08:23:53 +0200
In-Reply-To: <CAKndYJGoGdwKkFV8Kd2O+VkAJuqeqxsmL6OLSxhyca5k5R++ZA@mail.gmail.com>
References: 
	<CAKndYJGoGdwKkFV8Kd2O+VkAJuqeqxsmL6OLSxhyca5k5R++ZA@mail.gmail.com>
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

On Mon, 2026-09-07 at 08:08 +0200, Gerte Hoogewerf wrote:
> Hi Xenomai team,
>=20
> Using "v6.18.29-dovetail3-rebase", I recently tested Zynq-7000 and
> Zynq UltraScale+, and I found an issue on the latter.
>=20
> My config on this system is as follows:
> CONFIG_IRQ_PIPELINE=3Dy
> CONFIG_ARM64=3Dy
> CONFIG_ARM_ARCH_TIMER=3Dy
> CONFIG_HZ_PERIODIC=3Dy
> CONFIG_NO_HZ_IDLE=3Dn
>=20
> Crucially, when NO_HZ_IDLE is off, the system shows 0.0% idle, even
> though the system is doing nothing. The quickest "reproducer" is
> "/bin/top", which shows 100% CPU load (usr). I can provide sample code
> if needed. Flagging the PPI as a timer IRQ resolves the issue. Four
> similar call sites in arch_timer_register() from
> drivers/clocksource/arm_arch_timer.c need to undergo the following
> edit:
>=20
> - err =3D request_percpu_irq(ppi, arch_timer_handler_virt, "arch_timer",
> arch_timer_evt);
> + err =3D __request_percpu_irq(ppi, arch_timer_handler_virt, IRQF_TIMER,
> "arch_timer", arch_timer_evt);
>=20
> I'm not sure this is the best fix, but I wanted to share this with
> you. If desired, I'm happy to test alternative approaches too.

Most likely the same issue that we discussed in [1] a couple of days
ago.=20

[1] https://lore.kernel.org/xenomai/87bjacoy6l.fsf@xenomai.org/T/
