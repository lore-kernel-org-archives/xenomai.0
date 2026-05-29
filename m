Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039FD15746F
	for <xenomai@lists.linux.dev>; Fri, 29 May 2026 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051803; cv=none; b=ialyksoJmJDZrTpqvx3Bel/apJXzVYuPwmnGDE+akOWeX6iDZvLbXfDSCXN4ImxnBQdef6JKpv6MjGgHHdb3nLcZ47/L7f+uWB5lF1HJcpnhdMSGxprBTdUEspxQMbrctvxJl2dd6SSfdkZeEAAX2XEYeNP7otmfIFu7Jt8+mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051803; c=relaxed/simple;
	bh=Zk2e1INXMu49pYm6pc0zOAQ1c5q18NWcz8n3rWF1Xk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FB17BfkuwgSSgKM0nTpB8P3YEAnNoNaU29SrX4+XT/0XLJcPZ2FQZwuF+69K8l5RPJS2XkcLHV//hMlhmQuQ4oQjU118gtj1dZgmtEhAlA0mYPAe/6TOAmnb76vduy7BfEABpoRwYFYnCyY2m1FsZOdyDy6/MGKQvdsiTpb7pIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZxOs96za; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZxOs96za"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260529104956499da0a8750002073f
        for <xenomai@lists.linux.dev>;
        Fri, 29 May 2026 12:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B95N33V6RWETZqDqZK0qwJRMtxXGccsrqXH6hkk0G6w=;
 b=ZxOs96zaehqka98b6DUaJH+qFK0YqC37kt1Fb74X/QxeOhPHJqrdSJkqM8Zc25iHsAIDH5
 zAm3wQkLAb94d3LYH0FhFXU3iCzYS92gIhd0hASYotihlCZFiGcno8icbHW+y8a0dHUSBfPi
 0Kiz3J8PvHan1r6yK2XSs3Tgh/6tyYgvuJqf+uSrXfD0e5u2rDZCDjkyToNh0UDul4eYbIg3
 xIkDfwYalcsFel5QSokRCesfn7znAP1m1zxlET36UlAb/nZMuFswHoyWt39LmD1cCiGGw0HC
 RntOzl1NolpFuz5lJSxMXKt879eZxxDdSllJYpDUjDfvftsBma2N0vrw==;
Message-ID: <b63745f3f56d5494ae60f0248e4f2ea440448bc6.camel@siemens.com>
Subject: Re: Dovetail on risc-v: Testing strategy, managing efforts for
 forward porting
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 29 May 2026 12:49:55 +0200
In-Reply-To: <87wlwmh4x4.fsf@xenomai.org>
References: <77ac2e8147a0ecd8f9618e3a9492ec87bdf9dd98.camel@siemens.com>
		<87bjdyil4u.fsf@xenomai.org>
		<030f8cd8-a587-496a-ab3d-11e67568a732@siemens.com>
	 <87wlwmh4x4.fsf@xenomai.org>
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

On Fri, 2026-05-29 at 12:43 +0200, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
> > On 29.05.26 12:08, Philippe Gerum wrote:
> > >=20
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > Hi Philippe,
> > > >=20
> > > > I'm currently waiting for a v8 of Tobias' risc-v implementation. A
> > > > couple of minor things still need fixing, but overall I would say t=
hat
> > > > we are looking good - ready for merging - assuming that currently
> > > > running tests are successful.
> > > >=20
> > >=20
> > > Really nice stuff, thanks to anyone involved.
> > >=20
> > > > From my point of view there is one issue left, that needs a discuss=
ion:
> > > > Testing and forward porting in the future.
> > > >=20
> > > > Up to now I was able to test all architectures using cobalt / x3. T=
hat
> > > > will change now, as we don't have risc-v support in x3.
> > > >=20
> > > > I see the following options:
> > > >=20
> > > > 1: Additionally forward port linux-evl in the future, so that we ca=
n run
> > > > tests against risc-v using x4. Additional effort for me, especially
> > > > because we don't have an in-house user for that. Can you estimate h=
ow
> > > > much time it takes you to forward port linux-evl in comparison to l=
inux-
> > > > dovetail?
> > > >=20
> > >=20
> > > Porting evl to a new arch kernel-wise is fundamentally trivial, the r=
eal
> > > work is done by Dovetail. For every currently supported arch, the amo=
unt
> > > of arch-specific evl code is 60 lines of C, merely wrappers in header=
s
> > > (arch/*/include/asm/evl/*.h). Tobias already contributed the few bits
> > > libevl needs to support risc-v.
> > >=20
> > > > 2: Add risc-v support to x3 as well. To my understanding there were=
 no
> > > > plans yet, but it might be worth it to limit forward porting effort=
s. I
> > > > could focus on x3 for testing. This might also help to compare risc=
-v
> > > > against the other architectures.
> > > >=20
> > >=20
> > > Although this may require a little more effort compared to x4, such p=
ort
> > > would still be tractable since Dovetail does most of the work here as
> > > well. Adding risc-v support to x3 is Jan's call.
> > >=20
> > > > 3: Ignore risc-v during forward porting. Yes, this option exists, b=
ut I
> > > > don't consider it as a real / valid option.
> > > >=20
> > >=20
> > > Neither do I. Merged implies maintained.
> > >=20
> > > > 4: Merge the risc-v support into linux-evl. That would make risc-v
> > > > support exclusive to evl, where we could already test it. Would tha=
t be
> > > > an valid option for the evl side?
> > > >=20
> > >=20
> > > No, I believe that we can deal with one arch more such as risc-v in t=
he
> > > Dovetail maintenance process. Besides, we really want the generic
> > > Dovetail code to be shared by all architectures, otherwise this would
> > > become a maintenance nightmare for the risc-v port.
> > >=20
> > > > Any additional option available, that I missed?
> > > >=20
> > >=20
> > > I'd say, the simpler the better. Today, enabling risc-v for x4 would =
be
> > > straightforward while keeping the current maintenance model for Dovet=
ail
> > > mostly unaffected.  Granted, forward porting to the latest kernel
> > > release may require a bit more work in order to maintain the risc-v p=
art
> > > too, but my understanding is that Tobias is willing to help with this=
 in
> > > the long term. AFAICS, the arch-specific part in risc-v for Dovetail =
is
> > > fairly reasonable in size as well.
> > >=20
> > > So, first step would be to merge the Dovetail risc-v support into
> > > linux-dovetail like other supported archs, enabling it for x4/evl in =
the
> > > same move. It could be enabled for x3 next, when time allows on your =
end
> > > if desired.
> > >=20
> >=20
> > To my understanding, Florian's concerns are not about the first-time
> > enabling or risc-v but its future testing when going to a new kernel
> > version. While arch-wise, most work is done in dovetail, testing would
> > only be possible once linux-evl is ported to a new kernel as well. And
> > that porting is widely arch-agnostic but for other reasons (drivers
> > e.g.) quite some generic effort.
>=20
> This proved to be a limited effort over time. Porting issues in generic
> driver code for linux-evl can only affect the GPIO core, all the rest is
> on the Dovetail side (NIC drivers, SPI and DMA cores), so already ported
> actually.
>=20
> Those issues did happen but rarely, and the complexity to address them
> always were an order of magnitude smaller than it has been for Dovetail
> over time. Most importantly, those merge conflicts were all due to
> changes in symbol names and routines moving around due to upstream
> refactoring/cleaning up the code, still keeping the original logic
> untouched though. I'd say such porting work still qualifies as simple.

With that: Let me try it. Which branch should be the "source" for v7.1-
evl-rebase? next/v7.0-evl-rebase or v7.0-evl-rebase? (with or without
next/)

I would do it the same way as for Dovetail: I would push to something
like wip/<release>-rebase and ask you to take over / release. Right?

Florian

