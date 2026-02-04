Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB733E37B
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224182; cv=none; b=fVrVZtsVq+DB8elIFTXHnURAmGdE0bSw8NEnBJDMQ6P0K/PG+erU1da/ihZ7dNAVyQ1cZvehUQL5dpHyOf671HpMo8TVaP7RV6tTyjDWttvQBDzeebYmB3THzv2ymp4YPFUNzZ4MXdxVCWNJ0m//wFIfuQzxT9mxvGlgfBgtdDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224182; c=relaxed/simple;
	bh=ak3UQ4Zsh/gQDgRMfvh/7MFQj6LetGwZ2axIqYBEeJg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLZDQRDOXf9kxmBjFxqd+qZciBCmq1YLFtveU96ixXuwHesShczxcVqRsUifnuJg1rSPDeUhkst5VZhiy8t1dvx5PCucw4oWiHD7fgSf0cMddSKXszh5IAdBlcW3kXgSSLI8dotZEhRTyhGWhj0eDfejPSXYbBTDN7gn2fYbYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=HMP36h76; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="HMP36h76"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260204164604089e27b5680002075f
        for <xenomai@lists.linux.dev>;
        Wed, 04 Feb 2026 17:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fmQFvYM3HyzewEUquu982HHJB8v0w6tHC01wEqx+i1c=;
 b=HMP36h76ZlfT86Vf/EhwQERsMh2IKLBmRzzlqA0la+FYdLFLBvAezKg7D5bklSlrV+2kfe
 44ObHqA0f6JNIDJlrXZ9eiPw01Q9UimMoUyvKQwJ9SPj6XYXPQhvfHneqF68Vu8EbC7b5Hmk
 6W2YGL1tFp00+kcy57pavQLNnkOBo6xjz0j8g+UjZ7DNXeGuvFsOOJogSkgrMJtFlPZijfif
 TcM2ZZ+zcW2XHdSBAC74FhW68Y+1Q3oaBGYwbp863ZJReuX0Dan5HGom6Jv/Y44C/3e9wMUW
 ITptzcqVOGZG9eFFtdj1hZiomOaNQC99tLNLmfBzRdUqh7w9Uqom+uqg==;
Message-ID: <9ceacf21ff7e97ce4c706e782c00803eb25eb1fa.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Wed, 04 Feb 2026 17:46:03 +0100
In-Reply-To: <87o6m44tte.fsf@xenomai.org>
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
		<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
		<87o6m6vutd.fsf@xenomai.org>
		<513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
		<87qzr1ivxz.fsf@xenomai.org>
		<198ace7718b548735ec0cb3e29b5c4f8129fbe9d.camel@siemens.com>
		<776cf4d59124068e8d4ee1976fb3eb00f55c9b86.camel@siemens.com>
	 <87o6m44tte.fsf@xenomai.org>
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

On Wed, 2026-02-04 at 12:44 +0100, Philippe Gerum wrote:
> "Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:
>=20
> > On Tue, 2026-02-03 at 22:48 +0100, Florian Bezdeka wrote:
> > > On Tue, 2026-02-03 at 18:22 +0100, Philippe Gerum wrote:
> > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > > >=20
> > > > > On Tue, 2026-02-03 at 14:08 +0100, Philippe Gerum wrote:
> > > > > > -static inline void map_oob_ipis(int cpu)
> > > > > > +static inline void map_oob_ipis(int cpu, int offset)
> > > > > >  {
> > > > > >  	int ipi;
> > > > > > =20
> > > > > >  	for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSE=
T; ipi++)
> > > > > > -		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + ipi);
> > > > > > +		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + cpu * =
offset + ipi);
> > > > > >  }
> > > > >=20
> > > > > I'm still quite sure that the loop is wrong and should be=20
> > > > >=20
> > > > > +static inline void map_oob_ipis(int cpu, int offset)
> > > > >  {
> > > > >         int ipi;
> > > > > =20
> > > > > -       for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_O=
FFSET; ipi++)
> > > > > -               get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_ba=
se + ipi);
> > > > > +       offset =3D ipi_irq_base + (cpu * offset);
> > > > > +
> > > > > +       for (ipi =3D OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
> > > > > +               get_ipi_desc(cpu, ipi) =3D irq_to_desc(offset + i=
pi);
> > > > >  }
> > > > >=20
> > > >=20
> > > > For ipi=3DSGI-0-7, the upstream implementation of ipi_setup_lpi() d=
oes:
> > > >=20
> > > >                 irq =3D ipi_irq_base + (cpu * nr_ipi) + ipi;
> > > > 		get_ipi_desc(cpu, ipi) =3D irq_to_desc(irq);
> > > >=20
> > > > In pipelined mode, we need to do that for ipi=3DSGI0 for in-band IP=
Is,
> > > > then for ipi=3DSGI1-3 for oob ones (see below). All members of
> > > > ipi_msg_type become _logical_ IPIs multiplexed over SGI0. That is t=
he
> > > > whole point of your fix regarding CPU_BACKTRACE and KGDB_ROUNDUP.
> > > >=20
> > > >=20
> > > > > instead. (Note OOB_NR_IPI + OOB_IPI_OFFSET vs. nr_ipi)
> > > >=20
> > > > The code above would map the original IPI range from SGI0-7, which =
we
> > > > don't have to in pipelined mode, we only use SGI0-3 here.
> > > >=20
> > > > >=20
> > > > > Example:
> > > > >=20
> > > > > static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr=
)
> > > > > {
> > > > > 	unsigned int cpu;
> > > > >=20
> > > > > 	if (!percpu_ipi_descs)
> > > > > 		__ipi_send_mask(get_ipi_desc(0, nr), mask);
> > > > >=20
> > > > > How should that work for IPI_IRQ_WORK? IPI_IRQ_WORK is located be=
hind
> > > > > the IPIs used for OOB and get_ipi_desc(0, IPI_IRQ_WORK) would ret=
urn
> > > > > NULL as we skipped the mapping in map_oob_ipis().
> > > > >=20
> > > >=20
> > > > Any IPI from IPI_RESCHEDULE to IPI_IRQ_WORK are multiplexed over SG=
I0 by
> > > > smp_cross_call().=C2=A0
> > > >=20
> > >=20
> > > Here we go. I missed that smp_cross_call() calls __smp_cross_call() w=
ith
> > > ipinr set to 0, unconditionally, not forwarding ipinr. I simply
> > > overlooked that. That allows us to only map the oob IPIs as the "wron=
g"
> > > mapping in arm64_send_ipi() can not happen anymore. Sorry for the
> > > confusion.
> >=20
> > That didn't last long. Two ways to fix the problem at the end:
> >=20
> >   - Only map OOB IPIs as suggested by Philippe.
> >     Means we have to modify arm64_backtrace_ipi() and
> >     kgdb_roundup_cpus() for the dovetailing case.
> >     Calling arm64_send_ipi() with an ipi-nr !=3D 0 is not allowed in th=
e
> >     dovetailing case for inband IPIs.
> >=20
> >   - Map all IRQs as suggested by me.
> >=20
> > Hopefully correct now...
> >=20
> > Which way is the preferred one?
> >=20
> > >=20
>=20
> Excerpt from arch/arm/kernel/smp.c:
>=20
> enum ipi_msg_type {
>      ...
> 	/*
> 	 * SGI8-15 can be reserved by secure firmware, and thus may
> 	 * not be usable by the kernel. Please keep the above limited
> 	 * to at most 8 entries.
> 	 */
> 	MAX_IPI
> };

That is now taken from arch/arm instead of arch/arm64. Is that also the
case for arm64?

>=20
> This still holds true for ATF [1], so we only have 8 available SGIs
> although GICv3+ do provide 16. Since we have 8 in-band IPI message types
> defined by the arm64 port and we need 3 oob vectors more, we can't have
> a 1:1 mapping between IPIs and SGIs.
>=20
> So far we are using 4 SGIs as explained above (1 in-band + 3 oob), so we
> have 4 spares ATM. The reason for moving an in-band IPI to its own SGI
> using one of those spares would be to prioritize it over the bulk of
> in-band messages. Therefore, the question would be: do we need such
> prioritization?

I have no strong opinion on that and tried to restore what we had in the
past. Looking at 6.12 at [2] now I had to realize that this was way more
broken regarding IPI_BACKTRACE and IPI_KGDB_ROUNDUP than I had realized
up to now.

>=20
> [1] https://trustedfirmware-a.readthedocs.io/en/latest/porting-guide.html=
#function-bl31-platform-setup-mandatory

[2] https://gitlab.com/Xenomai/linux-dovetail/-/blob/v6.12.y-dovetail/arch/=
arm64/kernel/smp.c?ref_type=3Dheads#L1190

What about the following end-result:

enum ipi_msg_type {
	IPI_RESCHEDULE,			// SGI0, used for inband multiplexing
					// RESCHDULE set as reason

	IPI_CALL_FUNC,			// SGI1 reserved for OOB
					// CALL_FUNC via SGI0 with reason set

	IPI_CPU_STOP,			// SGI2 reserved for OOB
					// CPU_STOP via SGI0 with reason set

	IPI_CPU_STOP_NMI,		// SGI3 reserved for OOB
					// STOP_NMI via SGI0 with reason set


					// SGI4-7 unused

	IPI_TIMER,			// via SGI0 with reason set
	IPI_IRQ_WORK,			// via SGI0 with reason set
	NR_IPI,
	/*
	 * Any enum >=3D NR_IPI and < MAX_IPI is special and not tracable
	 * with trace_ipi_*
	 */
	IPI_CPU_BACKTRACE =3D NR_IPI,	// via SGI0 with reason set
	IPI_KGDB_ROUNDUP,		// via SGI0 with reason set
	MAX_IPI
};



Final questions:=C2=A0

Assuming SGI mode: Where are the request_percpu_irq() calls for all the
OOB SGIs? Or: How is something like irq_send_oob_ipi(2, mask) expected
to get the right IRQ descriptor in arm64_send_ipi()? Currently the
descriptor for SGI0 is returned.

Is that all just broken for a long time?

In addition I think that the trace_ipi_raise() in __smp_cross_call() is
incorrect for OOB SGIs...

Florian
