Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD715172DB
	for <xenomai@lists.linux.dev>; Thu, 15 Oct 2026 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060329; cv=none; b=EKPXkPL9hyrqjQdHIrFwb/c8cnXtibINNrr9L6aJgxuxXhNQvPb1L7THtFBNYU4/CEjbDKsaAYxaQfGq1/SRp9NoFf5uWfLDST4V37SQHROUWR/MOo/Y/z0nVuk1Isk73ACXd1v72M6K/X5Cxe7bt2W6M8OPgM2ZBDPfBO7frzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060329; c=relaxed/simple;
	bh=8IZCaV6EIc2M7XknCNS//oQGQRii10SPZGC8j+xb6kw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUOvWcaz6nMnzQdAOv1pTJMp7HYLYAhYkg+Hl7uC0tsiEe9WmzU568Eumak0pv4WUP3AWgzfMjSe5QMh5zC3Enfa+MdP5yOzsC61nLwT0XP0HNKu4k0ll91Y0+PVavGfVmulEgIhmbdeVtFYq1j2k0smP5VceSG7TWWjYbuyZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=kT2hSHMm; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="kT2hSHMm"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261015103155e8b794167800020702
        for <xenomai@lists.linux.dev>;
        Thu, 15 Oct 2026 12:31:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lWXegwgLpLp84Rk+aQYdKXv63dsQXsjaZw7dLDxw7Js=;
 b=kT2hSHMmaqqMa0HqYPzZAihjCl7cMOQp7rn243mma6Gq90/rlYZatnEBueVOI2Kkn1nbUz
 Phx1kF9aAVi9oecqjGdhnjLHzdYADEVXVgC3KH7oHBah9oHJ9M0DFQNhnEi13XfBH7elpBUb
 +wz575sgmanfvG55udNQZF0M5QU/BIyKkwcGwpEttWsu6MhB6XnU+qikL+mHyMs2SX5RblKA
 sm5Fa4/3ZxIExUavyxzo0UNSeRA3lVevaj2eB2WZVNE4E6bfFlJJ5BuHgyE6T/GqmmxtxxXn
 bkcjb+kXRv76Cm+8xcCCVWS2sBOvz7SgL5U0/rPgddRHPZywEqKVoHXQ==;
Message-ID: <697ef196b2868a3d1ea292b1a5c9064bef7d4e64.camel@siemens.com>
Subject: Re: [PATCH Dovetail] arm: irq_pipeline: Fix IRQ state checking in
 do_page_fault()
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 15 Oct 2026 12:31:54 +0200
In-Reply-To: <87tsmnl0zh.fsf@xenomai.org>
References: 
	<20260929-wip-flo-7-2-arm-pipeline-fix-v1-1-300c70cfae7f@siemens.com>
	 <87tsmnl0zh.fsf@xenomai.org>
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

On Thu, 2026-10-15 at 12:19 +0200, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > When correcting some fault handlers in the patch series referenced belo=
w
> > one call site was missed. That is corrected now.
> >=20
> > do_page_fault() migrates to the inband stage and enabled the inband IRQ=
s
> > depending on the hardware state. Instead, we have to check if the inban=
d
> > stage was stalled on kernel entry.
> >=20
> > Link: https://lore.kernel.org/xenomai/20260610-wip-flo-v7-1-arm-pipelin=
ing-fixes-v2-6-62c9c477f8f2@siemens.com/
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > Found while scanning the code for necessary 7.3-rc adjustments.
> >=20
> > To: xenomai@lists.linux.dev
> > Cc: Philippe Gerum <rpm@xenomai.org>
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  arch/arm/mm/fault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index 8f7feb1a228fc12c2d14389f865b13e23d11460d..91d0afe7985d55b424009cc=
29d8f3343cfca90fd 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -376,7 +376,7 @@ do_page_fault(unsigned long addr, unsigned int fsr,=
 struct pt_regs *regs)
> >  	irqflags =3D dovetail_fault_entry(ARM_TRAP_ACCESS, regs);
> > =20
> >  	/* Enable interrupts if they were enabled in the parent context. */
> > -	if (interrupts_enabled(regs))
> > +	if (!arch_kentry_test_stalled(regs))
> >  		local_irq_enable();
> > =20
> >  	/*
> >=20
> > ---
> > base-commit: 58e8e0f74c2b20f6228b7d327ec2e955ffd5b491
> > change-id: 20260929-wip-flo-7-2-arm-pipeline-fix-939fc6370fb2
> >=20
> > Best regards,
>=20
> This patch [1] uncovered an issue with the series introducing
> dovetail_fault_entry() and friends. Fixed by that patch [2] living in
> next/evl-6.12.y-cip-evl for now, on top of a backport of the series
> mentioned above. Tests look ok so far, I'll update all the affected
> branches next.
>=20
> [1] https://lore.kernel.org/xenomai/20260929-wip-flo-7-2-arm-pipeline-fix=
-v1-1-300c70cfae7f@siemens.com/T/#u
> [2] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/020af735209333=
b180993f03534baf078fcddfb9

Thanks for debugging this!

I have to go an check why my testing did not reveal that.

I will combine [1], this patch and [2] in a new version of the patch
series. I will publish that once I applied it on top of 7.3 - as soon as
I have 7.3 available...

PS: I'm currently rebasing against latest 7.2 stable releases. Having
fun with arm64 right now...

Best regards,
Florian
