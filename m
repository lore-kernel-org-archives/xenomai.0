Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B1192593
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931623; cv=none; b=AHFCGFiEOLGEt7i4sxsOMxznZWBJ+KR6XzHPLs6WQuEIrv4nH85S2Ci7CVdTLl0ejsAxBRbDB5HHYwMPdrnWdBNMfHj/o2lUW+GCbdCdgyhUK3EaDfKHq4tsETk9zB9bZyDV9XsDf7iDXVV/Wh054p0ecP1hsFtEfMomwaXYvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931623; c=relaxed/simple;
	bh=GVBV+gDxoOlMrtP97wD629rTkJS7br7JhdIXqdr2Ecg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKWbpWfr/P7mCM9vGstKveLWuD2foVBzxlunStqEfQF5+5tf56pUPWTRB+2mEixIZjz+N9gFg5D9FMtcgS2CCZBPHTAzCfm/qtmmNY1C2VTUbfQ1tD9uFHOSJiNvhMoAxosdvlK/3i5+tZSs/PlmhYQDT9MakYVpob5gZZ5420Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BSMWKHKo; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BSMWKHKo"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 10F90100002
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 12:06:57 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 519C3740032
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 12:06:56 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024111812065505162e252aa9c930ae
        for <xenomai@xenomai.org>;
        Mon, 18 Nov 2024 13:06:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GVBV+gDxoOlMrtP97wD629rTkJS7br7JhdIXqdr2Ecg=;
 b=BSMWKHKo8WNYPyGfRXfvKlxVjWpzQRBl/8P5wMvF/aHLS16TDdhc55+bzbwVOS5FSC8XDT
 10NGYxoE6uzzx8W0Nvk627uc6k6rOoi5KIbioI5al8UKPqCZEvqiFYbII5u8OH4ZNu6IK44A
 xvvpWLtFjhRIfTX1QUQvGzTNwXLIC+86Qw42V93XlQIVQ1v+zB5pO4zEHORIEptJfh8nQwcK
 1PoQmDUn6djZ+5xxvaUmmasvBrz8dY+Qhjg7zxQp2Up0LtenG++Rr/OsGuxAzUVFGJj87DAB
 tkbU8RxjwZ46ETEVhd+Ts7MGm/ZVVrlQ0MrUSnqfrbe8g2D6Qb8LhyJg==;
Message-ID: <d06c39a750dd474769035062c2db7591cec9adb3.camel@siemens.com>
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, =?ISO-8859-1?Q?Fran=E7ois?= Legal
	 <devel@thom.fr.eu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, 
 =?UTF-8?Q?=E5=AD=99=E6=B6=9B?=
	 <suntaoworks@163.com>
Date: Mon, 18 Nov 2024 13:06:54 +0100
In-Reply-To: <87ikskkc1y.fsf@xenomai.org>
References: <1018-673b2280-29-5b0c8700@119759758>
	 <87ikskkc1y.fsf@xenomai.org>
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
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=BSMWKHKo;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-2024111812065505162e252aa9c930ae-7b81rU@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-68982-2024111812065505162e252aa9c930ae-7b81rU@rts-flowmailer.siemens.com


[ Updated CC list to merge both mail threads ]

On Mon, 2024-11-18 at 12:37 +0100, Philippe Gerum wrote:
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
>=20
> > Le Lundi, Novembre 18, 2024 11:32 CET, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit:=20
> > =C2=A0=20
> > > On Mon, 2024-11-18 at 11:21 +0100, Fran=C3=A7ois Legal wrote:
> > > > Le Lundi, Novembre 18, 2024 10:01 CET, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit:=20
> > > > =C2=A0
> > > > > On 18.11.24 09:50, Fran=C3=A7ois Legal wrote:
> > > > > > Hello,
> > > > > >=20
> > > > > > running on an Arm v7 cortex A9 platform, I'm trying to switch f=
rom xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).
> > > > > >=20
> > > > > > I can successfully boot my system with linux 5.15 + CONFIG_DOVE=
TAIL, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck at boot=
 in a do_idle loop. Did I miss anything ?
> > > > > >=20
> > > > > > Attached is my config.
> > > > >=20
> > > > > Can you factor out from it what the SoC is, if you patched the ke=
rnel
> > > > > for it (in the past and now), if you had to adopt Dovetail etc.?
> > > > >=20
> > > > > Jan
> > > >=20
> > > > The SoC is Xilinx zynq 7000. I have custom patches for custom FPGA =
peripherals (which most of them have been successfully ported to 5.15).
> > >=20
> > > We had a similar report for the zynq 7020 a couple of days ago.
> > > See [1].
> > >=20
> > > What happens if you disable CONFIG_SMP? (Not that this should be the
> > > final solution, but it might help to track the issue down...)
> > >=20
> > > Florian
> > >=20
> >=20
> > Disabling config SMP makes my system boot again.
> > How can I help working this out ?
> >=20
> > Fran=C3=A7ois
> >=20
>=20
> This looks like an issue with the proxy tick device. First thing is to
> disable CONFIG_XENOMAI, enabling CONFIG_IRQ_PIPELINE_TORTURE_TEST. If
> the kernel still hangs, we may have a hint about the reason
> why. Alternatively, you could keep CONFIG_XENOMAI in, booting the kernel
> with "xenomai.state=3Dstopped". If no hang occurs at boot anymore, there
> may be an issue with proxying the timer device on this SoC.
>=20
> [1] https://v4.xenomai.org/dovetail/porting/timer/
> [2] https://v4.xenomai.org/dovetail/porting/devnotes/#check-that-the-pipe=
line-torture-tests-pass
>=20
> --
> Philippe.

