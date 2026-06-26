Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D553F58EB
	for <xenomai@lists.linux.dev>; Fri, 26 Jun 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481062; cv=none; b=NrsXd0fnbsDBO/NaWlOwIdLzfsUdL3gDiYz8f1e7Vz5OaUVKQYnpTZYSU6K3D4AtFWjGvspxw47nUqp/Sdz4JrQazcCNYtXvLTLBLezvSQu6KHGcHBtgxqny5j4oJN4oo3wUZD1UjkR4gENvTqr4QsG2EoClqz5vxG+QpkIkELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481062; c=relaxed/simple;
	bh=725jYcr0Rde0ro+FXK8MNQgdgaFgZicWoksgqXRyRZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YytULsBRylPKSKBvjfxHtgm0TblZ3GKU6bsFXfjFpJJdJqHUaA29tidh7yw74SZatkn+l3JrdfjhYFmx/Vthg5co8ntbHKX54UtdLg+6zq7O7r98uZoBbPXu45BHsce2CQe7t3R2mgEql3zJk/zojQpHSAqTX3r6M9VGzp1Ku6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VcWRgj61; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VcWRgj61"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260626133726af56505906000207ef
        for <xenomai@lists.linux.dev>;
        Fri, 26 Jun 2026 15:37:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ICEx5MZNq2oBQrMQ6nSZVHzz34Eo1d8C9hcNt87POns=;
 b=VcWRgj61P9VzmjNDnVIw6X9LmVG/k69ojtAyjqfOUm3C1TFr6d3+KVouTzOYsxlHyLq8mn
 /NKMuTxmg3uNfE44jRPjFA3XNM81DhBWmQZVz+KO4iOj3QyBrcIAxsjNvR7S8M5umYSVoQCK
 p85/DR9od0vJK5Wsk4R8D9WErKs8SQUyZbcv3ClSKcO8gK7HnsBICtW7Mp37KymFGeh6ix4j
 4zTG+/TJ2PNh1j+wGHMfTCH4mUHjCwrMk7/gCitVZXBKrovpeSwvjw+luOnYOMaBueGi60ow
 pts74DhRwC/GqvM8RbFv05UZBD1zprcRtNcR9zGEkWQ2SnEEfNnBKutw==;
Message-ID: <6f4294c546488db17178cd7baedc37ef96db52fe.camel@siemens.com>
Subject: Re: [PATCH Dovetail v3 3/6] arm: irq_pipeline: Fix
 dovetail_fault_{entry,exit} bypass in hw_breakpoint_pending
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>, Tobias
 Schaffner <tobias.schaffner@siemens.com>
Date: Fri, 26 Jun 2026 15:37:25 +0200
In-Reply-To: <87cxxdrgs0.fsf@xenomai.org>
References: 
	<20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-0-230f03227abb@siemens.com>
		<20260622-wip-flo-v7-1-arm-pipelining-fixes-v3-3-230f03227abb@siemens.com>
	 <87cxxdrgs0.fsf@xenomai.org>
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

On Fri, 2026-06-26 at 07:51 +0200, Philippe Gerum wrote:
> Hi Florian,
>=20
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > HW breakpoint / watchpoint handling was bypassing the
> > dovetail_fault_{entry,exit} machinery. As a result it could happen that
> > the inband IRQ mask was touched from the OOB stage.
> >=20
> > There is one more problem in the HW bp/wp handling related to
> > interrupts_enabled(). This one will be fixed in a separate patch.
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> >  arch/arm/include/asm/dovetail.h         | 1 +
> >  arch/arm/include/asm/trace/exceptions.h | 3 ++-
> >  arch/arm/kernel/hw_breakpoint.c         | 6 ++++++
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/include/asm/dovetail.h b/arch/arm/include/asm/dov=
etail.h
> > index 795a1fb903ec29f4c2fb7b25e70980796804acc0..eeb5d16ad032044a2587822=
f6b35074d664a9bbc 100644
> > --- a/arch/arm/include/asm/dovetail.h
> > +++ b/arch/arm/include/asm/dovetail.h
> > @@ -16,6 +16,7 @@
> >  #define ARM_TRAP_VFP		6	/* VFP floating point exception */
> >  #define ARM_TRAP_UNDEFINSTR	7	/* Undefined instruction */
> >  #define ARM_TRAP_ALIGNMENT	8	/* Unaligned access exception */
> > +#define ARM_TRAP_HW_BREAK	9	/* HW break or watchpoint exception */
> >=20
>=20
> ARM_TRAP_HW_BREAK would not be caught by xnarch_fault_bp_p() and friends
> without fixing them up. What is the expected upside of differentiating
> ARM_TRAP_BREAK from ARM_TRAP_HW_BREAK?
>=20
>=20

When starting to implement test that I thought it would be nice to
separate them. That changed a bit meanwhile. More testing within the
last week showed that we should be able to harmonize that / use
ARM_TRAP_BREAK for both cases.

Noted for v4. Will take some time, now timeslot available ATM.
