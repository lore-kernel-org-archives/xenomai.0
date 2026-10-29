Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288190;
	b=ARcDPEUj92UfckCGKwyrxa/CiNyhcFBY/M0FxKBGvpjHu2xhoKrBjlTVRczJ+0MNuEKd
	 RrDCtvdP0JGu8t+X+9hrZeXb4csI14/Nc9MsYL2Ytr2RU/6WmcgYPtpe5ydYikoN18qjm
	 D4iOWJioqhVoCGMmgRXgXTNBy0m4eoiTwrhUVNbLniYP0jKqVOA0MbvQbPaQeON916zXE
	 NG+Z8uqE19cHo6b0YiqhFxsPyybZQbl/Bu66hQKqKCRa+5XP3NcnLRmSFaG1DQG9fKG0k
	 ZFzL+vNggEjp7c6BNM6vB7HsMMNBVd4GpkV5dB5bQnH/WB/PQueqwG6dbGNdGi2RD3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288190;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=jibePMSTmqi5vI/H3prlfzEUapRnRaT68NBTT9D6Meg=;
	b=irt+sMpcoRsvIhEwQr4uj5WSLkqNyhzGmnXxwJFZenDypeRWT0A7z3R0xA1VVX7jyBgF
	 4nuRR1cyQh5D4iLCRgwgbeYagajjV4VlMlM8WIVOG72X0dAEpWyu0apu5e9Ko2jBc+QXL
	 JpqLsiQ9+QCKByIMd+/C3Hywd/7emiZ7t0P3DDvVPBAWJQEDTCDnqsZZGaDijXwxD0/3Z
	 P0vYQKnI/icACN60qbnYD+N4xcc1Hxw+l5cUstbDb2Pxi73FAjFPQBsjo/3n7uyPoRyYl
	 WqrBX+AiNr1dIHtNMW4Sa85jRRtpXmp3KVaWuKvxammwTNEJ91/bC3YiZ57aNA/koeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=CG0iwX5i;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A0606A31A
	for <xenomai@lists.linux.dev>; Thu, 29 Oct 2026 15:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 133A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=CG0iwX5i
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202610291536188d98d3c9c7000207f6
        for <xenomai@lists.linux.dev>;
        Thu, 29 Oct 2026 16:36:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jibePMSTmqi5vI/H3prlfzEUapRnRaT68NBTT9D6Meg=;
 b=CG0iwX5iXFAhXBQnLZErV/V5B2gmjnVzCHUjQOyu09BeeDsaBdJAJgeojroA+zAFsn802e
 Y9M8qAMkV6/GQHx0bNle+ySCY/NCl5iekMgnf+Yh2cP2nvPkXutRixljtXPmMTS/+IxIlbUl
 FEBA4ujjjkzhn/yFKRQJMvH7OoVJ9d0p0xQIDF3l+p7ODaxQ1PgXJURUti89GxxSOvyE7JeJ
 WLXF52zDp4ZzHjHs5wvN9BEXq3vaMV4Agncmttor8Wu/E+1vgVN2mlpQ2glSyOdfXVt3T6Ow
 gQxxfXAqtwiXSzCnMFBcipVcSqTQUJpdaMRvoYws/1Ce+lRwijCnKkYw==;
Message-ID: <1cc707116938f50d38ded0e91aa8bb845dd53607.camel@siemens.com>
Subject: Re: Dovetail 7.3 release candidate available
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Jan Kiszka
	 <jan.kiszka@siemens.com>
Date: Thu, 29 Oct 2026 16:36:18 +0100
In-Reply-To: <87y0bgmtba.fsf@xenomai.org>
References: <eec03efd38a42874e7ff4c7fca7246208e49ef03.camel@siemens.com>
		<1e1270ef6b7a899fa095765a68461f2baf8c927e.camel@siemens.com>
	 <87y0bgmtba.fsf@xenomai.org>
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

On Thu, 2026-10-29 at 16:15 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Mon, 2026-10-26 at 15:35 +0100, Florian Bezdeka wrote:
> > >=20
> > >=20
> > > Missing / next steps:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 - Expect a final history (git commit) cleanup
> > > =C2=A0=C2=A0=C2=A0 - Move to final branch (most likely v7.3.y-dovetai=
l-rebase)
> > > =C2=A0=C2=A0=C2=A0 - Rebase evl
> > > =C2=A0=C2=A0=C2=A0 - riscv: Run the Xenomai 4 testsuite (once evl has=
 been rebased)
> > >=20
> >=20
> > Update:
> >=20
> >     - EVL rebase is waiting in the=C2=A0next/v7.3-evl-rebase-flo=C2=A0b=
ranch
> >=20
> >     - The Xenomai 4 CI pipeline is green. All architectures passed
> >       the test run - riscv included.
> >=20
> > @Philippe: How do we proceed. Do you want to take over for the final
> > history cleanup / branch "renamings" and tag assignments?
> >=20
>=20
> Ok, I'll handle this. I have a few patches on the evl side which
> complete the kernel support for the POSIX interface in libevl, I'll
> merge them in the same move.

Nice. Thanks!
