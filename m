Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74917277C8C
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061559; cv=none; b=rP1y5k/JIRSixiLtFbKze1ldF9Hwdfb3/+NOxNbsTc7GmD4HaC7wOAQAe4ZUmdNwb+Z2JhF1zCuCh4IhOlANKNMfVYu2TbRbTasQHId4MAAg60yzSTsogKUtQ2VPFuqcUJ8eIfeJ7jUB+X2zipO0fCCjZud0nDAjQ19P+kPJXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061559; c=relaxed/simple;
	bh=jAJ8xk76kEftcYNatP3398mBU/IbUSzNbpw3mmK6xWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b5zJU/7BwfcIJgNr2B8j6/yQG/iELKwQSmVGLn6yjkGilDCa4P3R9jUyshvuqIx1Ry6ERZvpcgc+zVMbdDNGNqn/CAH1lxj7+EbAIFLdoAOGIEpOvOiOhQuulrsx6yrR3nUqHWyqNcYV+9RrwC2KPR8/4ORNaIH0Yu0NT0ogwxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=UsgYBokY; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UsgYBokY"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025090508390662629aa2980002072e
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 10:39:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RdkhbLn6BQtWERWWAGYekXcKx8xwIPepNa+JmkQYFR0=;
 b=UsgYBokYPDCcFlYgjAvG+dmSEnAKZ39OXMtXPBNddhkXPEr5uGFctSunIGXsh1//ZI0wjV
 h644eUI9itUbZoJixWXetD3blmGWbhY3R/2Y1JGpxHHLKkyCBXft5yFLlSK6T97dHwBhStKb
 zEGwAPM2rYdhOcupIgbmHkrgMY4Zmhcb8vgkO8qZC9X2p/fiLNXyqv8yjKNcWXNKvoXv02Hb
 GgyDKzQkhplzfbRdH4hvf61xX3QIoZ9R0BgHoJEo1c62oXaBeAyfYpBRuxax6i9/7YzOchSj
 K4kuAgcQUSDAYLUPxiO/og/IpQQCQRZs1zq5Pp8L1ptqlKo80/9Wc2bQ==;
Message-ID: <4fb68229ddaa695d640a5ebd03e415e0e50f2a67.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH v2] ci: Retry LAVA boot action up to
 three times
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
Date: Fri, 05 Sep 2025 10:39:05 +0200
In-Reply-To: <ecd75542-25ce-4beb-b7d5-8c58b2611cf3@siemens.com>
References: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
	 <def91a5f-1642-4374-8498-9863468f115c@siemens.com>
	 <07a52824-3514-41ef-9011-69d344ff4611@siemens.com>
	 <ecd75542-25ce-4beb-b7d5-8c58b2611cf3@siemens.com>
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

On Fri, 2025-09-05 at 10:24 +0200, Tobias Schaffner wrote:
> On 04.09.25 17:33, Jan Kiszka wrote:
> > On 04.09.25 12:16, Jan Kiszka wrote:
> > > On 04.09.25 12:03, Tobias Schaffner wrote:
> > > > Increase test robustness by retrying the LAVA boot action up to thr=
ee
> > > > times on failure. Failures are detected via server-side error messa=
ge
> > > > matching. This logic will be refined in the designated repository.
> > > >=20
> > > > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> > > > ---
> > > >   tests/jobs/xenomai-beagle-bone-black.yml | 1 +
> > > >   tests/jobs/xenomai-hikey.yml             | 1 +
> > > >   tests/jobs/xenomai-rpi4.yml              | 1 +
> > > >   tests/jobs/xenomai-x86-64-efi.yml        | 1 +
> > > >   4 files changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/=
xenomai-beagle-bone-black.yml
> > > > index 8e47dd6..b7a95bc 100644
> > > > --- a/tests/jobs/xenomai-beagle-bone-black.yml
> > > > +++ b/tests/jobs/xenomai-beagle-bone-black.yml
> > > > @@ -41,6 +41,7 @@ actions:
> > > >         compression: gz
> > > >   # BOOT_BLOCK
> > > >   - boot:
> > > > +    failure_retry: 3
> > > >       timeout:
> > > >         minutes: 5
> > > >       method: u-boot
> > > > diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hike=
y.yml
> > > > index aaf8949..27beb07 100644
> > > > --- a/tests/jobs/xenomai-hikey.yml
> > > > +++ b/tests/jobs/xenomai-hikey.yml
> > > > @@ -40,6 +40,7 @@ actions:
> > > >         compression: gz
> > > >   #  BOOT_BLOCK
> > > >   - boot:
> > > > +    failure_retry: 3
> > > >       timeout:
> > > >         minutes: 5
> > > >       method: u-boot
> > > > diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.=
yml
> > > > index 50ff9ee..4074825 100644
> > > > --- a/tests/jobs/xenomai-rpi4.yml
> > > > +++ b/tests/jobs/xenomai-rpi4.yml
> > > > @@ -40,6 +40,7 @@ actions:
> > > >         compression: gz
> > > >   #  BOOT_BLOCK
> > > >   - boot:
> > > > +    failure_retry: 3
> > > >       timeout:
> > > >         minutes: 5
> > > >       method: u-boot
> > > > diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai=
-x86-64-efi.yml
> > > > index 4f1a7d8..0014429 100644
> > > > --- a/tests/jobs/xenomai-x86-64-efi.yml
> > > > +++ b/tests/jobs/xenomai-x86-64-efi.yml
> > > > @@ -41,6 +41,7 @@ actions:
> > > >         compression: gz
> > > >   # BOOT_BLOCK
> > > >   - boot:
> > > > +    failure_retry: 3
> > > >       timeout:
> > > >         minutes: 5
> > > >       method: ipxe
> > >=20
> > > Thanks, applied.
> > >=20
> >=20
> > I think we were retrying here, but it did not help :(
> >=20
> > https://gitlab.com/Xenomai/xenomai-images/-/jobs/11248170239
>=20
> It looks like LAVA is only making two attempts.
>=20
> On the first attempt, the job runs into a timeout. This could have been=
=20
> caught earlier if the U-Boot soft reboot was detected correctly. In the=
=20
> log, it appears as "must RESET the board to recover", but our pattern is=
=20
> looking for "Must RESET board to recover" with a capital M, so it=20
> doesn=E2=80=99t match. This has to be fixed in the .jinja2 config on the =
server.

Hm. The settings is inherited from
/usr/share/lava-server/device-types/base.jinja2

a very "basic" LAVA configuration file. Which version of U-Boot is
deployed on the board? Maybe something very old and the message was
updated meanwhile?

Should be doable to overwrite / add another error message.=C2=A0

@Quirin, do you want to take over?

>=20
> I=E2=80=99ll take a closer look at why LAVA ends with
> error_msg: 2 retries out of 3 failed for uboot-action.
> It should have attempted three times.
>=20
> Ideally, we also find a way to make the boot process itself more stable,=
=20
> rather than relying only on retries.
>=20
> > Jan
> >=20
