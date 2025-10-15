Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA08319619
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522993; cv=none; b=t+hTCg15+OVjsRMkR1xPkCFnubIPjLMiseNY7omEbPCa1xS7f0h1D/4RuFb/cQk3jQbCIasIrWKJ16AtQNqiBphvpuicHE/fSUrjX3orNJVzke2wUMrxhotSnS9DBeKSpee4IfhQMLop9LAkz5AopLkmKRH/7dk3/QeQQxJXPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522993; c=relaxed/simple;
	bh=+JtNszZ4fZNTYBYLuCCIG0u3BxTGM4eieSqCWOsjQJs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivqTsKItbmaUDNpK31MhxKpGkz80BTOdVa1dc7KquL/NT23tdIljrr++kAYS7eo0xTaW+lvmzgOeCZgUiIppGWh1ppaPCNxlFr73FUxoF/dZn6feAErnHeURASXAZTDE+Zu1+HE2BVvDou5Y/rg4MKTzx9B93hhwxP1kHMRjJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=del5DmXc; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="del5DmXc"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251015100943707f241f0600020773
        for <xenomai@lists.linux.dev>;
        Wed, 15 Oct 2025 12:09:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=vjxCo3tbOqlDFaui6l7zYl3PBxRF9Tap4B397LKkEr8=;
 b=del5DmXceGkuE4Ls3rdeUY0BRHA0NRiMMPfHwcsFwh6ZPh007jS81up3MKHakOoccUPTcr
 WO1PSOQs3QvEP1EkNoaVjS3hLBMHsgFnPTdOSfDdm1bYgldXgWbn7qfVBgQuPKdBbnOVUi9S
 g8/9Lzfv2gCH6wJpOD2v/6j7SMUC8C5hYPfY1J2aCt+bcpPOQwpkfj11vYYPa1FHYKf6IYDh
 nCZuv20zYkjq2Nsa/4MOftD+QJcqMJX1M6SpJPQteicm67ZCkFdeqV9QuYYVICxdDDXq2PTh
 2U365G/Bg32LKVU2ST4KVwcu9W4wh1P9kGTrVnO73SiX3isSEtmmBcIA==;
Message-ID: <a213b0651843cda2645dd472c5588459ce1a8525.camel@siemens.com>
Subject: Re: [PATCH 2/6] lib/cobalt: arm: Avoid thumb mode in
 syscall-issuing modules
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 15 Oct 2025 12:09:42 +0200
In-Reply-To: <0369aebd-5b0f-4fca-8431-0948dc4e9fc3@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
	 <b2aa6e5eb2bf3b7357239aae8d55289f0baac9a8.1760374860.git.jan.kiszka@siemens.com>
	 <77c5c99cb6dda43b48ba8bf8ef29f665ee19ea6f.camel@siemens.com>
	 <0369aebd-5b0f-4fca-8431-0948dc4e9fc3@siemens.com>
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

On Wed, 2025-10-15 at 10:03 +0200, Jan Kiszka wrote:
> On 15.10.25 09:12, Florian Bezdeka wrote:
> > On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > In 4abd59b4e3e4, we noticed the clash between r7 usage for setting up
> > > Xenomai syscalls and the compiler suddenly refusing this. What we was
> >                                                                  ^  =
=20
> > "we" seems superfluous.
> >=20
>=20
> Thanks, will fix.
>=20
> > > not clear at that point was the origin of the clash: if the compiler
> > > is configured to prefer thumb mode over regular 32-bit ARM instructio=
ns,
> > > it also starts to claim r7 as frame pointer.
> > >=20
> > > Now, the solution taken back then turned out to have a problem: It br=
oke
> > > stack unwinding. That is not only an issue when debugging, it is
> > > actually required for pthread_cancel and pthread_exit. The glibc will
> > > use unwinding to call destructors of the terminating context to call
> > > them before shutting down. This broke when we were inside a syscall
> > > because r7 was then pointing to the syscall number.
> > >=20
> > > Most glibc versions detected the broken call chain and simply skipped
> > > the destructors - which was still a problem, just unnoticed. But with
> > > recent glibc from trixie, we are now even crashing while unwinding, a=
nd
> > > that is even less acceptable.
> >=20
> > Ok, so not a trixie regression, but something that was never correct on
> > our end. Good to know as trixie will get more traction soon.
> >=20
> > >=20
> > > We could now either use the pattern of glibc to push the syscall
> > > invocation into an assembly function - or simply enforce ARM mode for
> > > libcobalt so that r7 become usable again. Take the latter approach as=
 it
> > > is leaner.
> >=20
> > As it broke again - and as already written as comment to the series -
> > we might think of reviving the syscall() series. That would allow us to
> > simply remove that code here. Seems hard to maintain and hard to
> > debug...
> >=20
>=20
> I'm not very keen on adding that overhead anymore to the low-end ARM 32
> platform. I think they should retire with the existing inline model. For
> more powerful 64-bit targets, it takes at least the benchmarks we discuss=
ed.
>=20
> But when benchmarking syscall() already, why not including prctl() as wel=
l?

We would need to refactor select() first - or in addition. prctl() is
able to handle 4 arguments - if memory is correct - select() needs one
more.

>=20
> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
