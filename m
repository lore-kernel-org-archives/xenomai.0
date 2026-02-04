Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA12D978A
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228299; cv=none; b=shaFAurSGozhZUYeirswTUxq8QZSoYiCP4IyHEE8aKgkzI6393UnpZHyOVmrMeEhUtkB7QBn5fCbuel5VHHGpzpXsy8W+Zt+IVFGLAB/4MQU3PrNObfsXtyIylpzhJxkdFhM3a1wsqqMlEoGk3jp3zWVI1k4BS3F/F99qMyGZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228299; c=relaxed/simple;
	bh=5KTu3y70U0h8ASZvSEMYp5iJ6uKfjDdRU6oZ9i0o6oc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HXitJTd20zBvkfJ0gihGjA8vw8Lv9JU+VUEp4nZ0yNu/q3ciboYZWrsdyky9/Okcrjq4iLpQlWsggJKl6gf6jUXzN+0DQfD9oXpLtMcpA0SDJAObIIVwDu8eZW4uAUFKmInLHSS5nqMXLb6BXncnXSJpiGKhJKAUZZs2CRfhFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YJ85oJUR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YJ85oJUR"
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDDE64436B;
	Wed,  4 Feb 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770228291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpwr5MUdsEcCskDSi/1gRzqNsheeMD0TTMaDFoIZCPA=;
	b=YJ85oJURgxyUu4JO+hpFhdj4PcDhdWjN9bayMMuEfEdzOokcctrTVAtjmtpkoPLb4FY0Vg
	i94P4J3MK5FH4Mr1QB4C+MXWU+zLfWlwmq8nKEKsKP3AINOhD+VK1EX6JSwiVztrEJLIRv
	R2x3U0jptPt6cOk9Pb2sEPjF7BsLHU43ZW9aR3EphIakict42JaAlU0ojEoRLYNAmQ7YWE
	uIUtUDv5Q2w44xSjw5dRiw+jWI/pl5O0A0p2zcnG42x9UbWD0JvN4RWdobf6Y6lKsfeUgV
	9ip3qt9MGryhaQAo3WFADh+GKEVhoMcFnPk0S67GAKv7y1FaBt2CO2KtD7fyNA==
From: Philippe Gerum <rpm@xenomai.org>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
In-Reply-To: <9ceacf21ff7e97ce4c706e782c00803eb25eb1fa.camel@siemens.com>
	(Florian Bezdeka's message of "Wed, 04 Feb 2026 17:46:03 +0100")
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
	<87o6m6vutd.fsf@xenomai.org>
	<513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
	<87qzr1ivxz.fsf@xenomai.org>
	<198ace7718b548735ec0cb3e29b5c4f8129fbe9d.camel@siemens.com>
	<776cf4d59124068e8d4ee1976fb3eb00f55c9b86.camel@siemens.com>
	<87o6m44tte.fsf@xenomai.org>
	<9ceacf21ff7e97ce4c706e782c00803eb25eb1fa.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 04 Feb 2026 19:04:50 +0100
Message-ID: <87ikcc4c71.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepgedttefgtdefheefjedtvedvtefggfefvddvgedvtdefveetueegueduleetueffnecuffhomhgrihhnpehrvggrughthhgvughotghsrdhiohdpghhithhlrggsrdgtohhmnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeevffffgfeigeegfeeiuedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtt
 hhopehflhhorhhirghnrdgsvgiiuggvkhgrsehsihgvmhgvnhhsrdgtohhm
X-GND-State: clean
X-GND-Score: -100

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On Wed, 2026-02-04 at 12:44 +0100, Philippe Gerum wrote:
>> "Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:
>>=20
>> > On Tue, 2026-02-03 at 22:48 +0100, Florian Bezdeka wrote:
>> > > On Tue, 2026-02-03 at 18:22 +0100, Philippe Gerum wrote:
>> > > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> > > >=20
>> > > > > On Tue, 2026-02-03 at 14:08 +0100, Philippe Gerum wrote:
>> > > > > > -static inline void map_oob_ipis(int cpu)
>> > > > > > +static inline void map_oob_ipis(int cpu, int offset)
>> > > > > >  {
>> > > > > >  	int ipi;
>> > > > > >=20=20
>> > > > > >  	for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFS=
ET; ipi++)
>> > > > > > -		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + ipi);
>> > > > > > +		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + cpu *=
 offset + ipi);
>> > > > > >  }
>> > > > >=20
>> > > > > I'm still quite sure that the loop is wrong and should be=20
>> > > > >=20
>> > > > > +static inline void map_oob_ipis(int cpu, int offset)
>> > > > >  {
>> > > > >         int ipi;
>> > > > >=20=20
>> > > > > -       for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_=
OFFSET; ipi++)
>> > > > > -               get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_b=
ase + ipi);
>> > > > > +       offset =3D ipi_irq_base + (cpu * offset);
>> > > > > +
>> > > > > +       for (ipi =3D OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
>> > > > > +               get_ipi_desc(cpu, ipi) =3D irq_to_desc(offset + =
ipi);
>> > > > >  }
>> > > > >=20
>> > > >=20
>> > > > For ipi=3DSGI-0-7, the upstream implementation of ipi_setup_lpi() =
does:
>> > > >=20
>> > > >                 irq =3D ipi_irq_base + (cpu * nr_ipi) + ipi;
>> > > > 		get_ipi_desc(cpu, ipi) =3D irq_to_desc(irq);
>> > > >=20
>> > > > In pipelined mode, we need to do that for ipi=3DSGI0 for in-band I=
PIs,
>> > > > then for ipi=3DSGI1-3 for oob ones (see below). All members of
>> > > > ipi_msg_type become _logical_ IPIs multiplexed over SGI0. That is =
the
>> > > > whole point of your fix regarding CPU_BACKTRACE and KGDB_ROUNDUP.
>> > > >=20
>> > > >=20
>> > > > > instead. (Note OOB_NR_IPI + OOB_IPI_OFFSET vs. nr_ipi)
>> > > >=20
>> > > > The code above would map the original IPI range from SGI0-7, which=
 we
>> > > > don't have to in pipelined mode, we only use SGI0-3 here.
>> > > >=20
>> > > > >=20
>> > > > > Example:
>> > > > >=20
>> > > > > static void arm64_send_ipi(const cpumask_t *mask, unsigned int n=
r)
>> > > > > {
>> > > > > 	unsigned int cpu;
>> > > > >=20
>> > > > > 	if (!percpu_ipi_descs)
>> > > > > 		__ipi_send_mask(get_ipi_desc(0, nr), mask);
>> > > > >=20
>> > > > > How should that work for IPI_IRQ_WORK? IPI_IRQ_WORK is located b=
ehind
>> > > > > the IPIs used for OOB and get_ipi_desc(0, IPI_IRQ_WORK) would re=
turn
>> > > > > NULL as we skipped the mapping in map_oob_ipis().
>> > > > >=20
>> > > >=20
>> > > > Any IPI from IPI_RESCHEDULE to IPI_IRQ_WORK are multiplexed over S=
GI0 by
>> > > > smp_cross_call().=C2=A0
>> > > >=20
>> > >=20
>> > > Here we go. I missed that smp_cross_call() calls __smp_cross_call() =
with
>> > > ipinr set to 0, unconditionally, not forwarding ipinr. I simply
>> > > overlooked that. That allows us to only map the oob IPIs as the "wro=
ng"
>> > > mapping in arm64_send_ipi() can not happen anymore. Sorry for the
>> > > confusion.
>> >=20
>> > That didn't last long. Two ways to fix the problem at the end:
>> >=20
>> >   - Only map OOB IPIs as suggested by Philippe.
>> >     Means we have to modify arm64_backtrace_ipi() and
>> >     kgdb_roundup_cpus() for the dovetailing case.
>> >     Calling arm64_send_ipi() with an ipi-nr !=3D 0 is not allowed in t=
he
>> >     dovetailing case for inband IPIs.
>> >=20
>> >   - Map all IRQs as suggested by me.
>> >=20
>> > Hopefully correct now...
>> >=20
>> > Which way is the preferred one?
>> >=20
>> > >=20
>>=20
>> Excerpt from arch/arm/kernel/smp.c:
>>=20
>> enum ipi_msg_type {
>>      ...
>> 	/*
>> 	 * SGI8-15 can be reserved by secure firmware, and thus may
>> 	 * not be usable by the kernel. Please keep the above limited
>> 	 * to at most 8 entries.
>> 	 */
>> 	MAX_IPI
>> };
>
> That is now taken from arch/arm instead of arch/arm64. Is that also the
> case for arm64?
>


Yes, the issue is with the trusted firmware, which is the reference
implementation for armv7-A and armv8-A.

>>=20
>> This still holds true for ATF [1], so we only have 8 available SGIs
>> although GICv3+ do provide 16. Since we have 8 in-band IPI message types
>> defined by the arm64 port and we need 3 oob vectors more, we can't have
>> a 1:1 mapping between IPIs and SGIs.
>>=20
>> So far we are using 4 SGIs as explained above (1 in-band + 3 oob), so we
>> have 4 spares ATM. The reason for moving an in-band IPI to its own SGI
>> using one of those spares would be to prioritize it over the bulk of
>> in-band messages. Therefore, the question would be: do we need such
>> prioritization?
>
> I have no strong opinion on that and tried to restore what we had in the
> past. Looking at 6.12 at [2] now I had to realize that this was way more
> broken regarding IPI_BACKTRACE and IPI_KGDB_ROUNDUP than I had realized
> up to now.
>

I depends on what you mean by "more broken", triggering a CPU backtrace
does not crash the kernel on 6.12 (unlike 6.18) because we have at least
valid ipi_desc[] on the whole IPI range although no backtrace ever shows
up. :)

>>=20
>> [1] https://trustedfirmware-a.readthedocs.io/en/latest/porting-guide.htm=
l#function-bl31-platform-setup-mandatory
>
> [2] https://gitlab.com/Xenomai/linux-dovetail/-/blob/v6.12.y-dovetail/arc=
h/arm64/kernel/smp.c?ref_type=3Dheads#L1190
>
> What about the following end-result:
>
> enum ipi_msg_type {
> 	IPI_RESCHEDULE,			// SGI0, used for inband multiplexing
> 					// RESCHDULE set as reason
>
> 	IPI_CALL_FUNC,			// SGI1 reserved for OOB
> 					// CALL_FUNC via SGI0 with reason set
>
> 	IPI_CPU_STOP,			// SGI2 reserved for OOB
> 					// CPU_STOP via SGI0 with reason set
>
> 	IPI_CPU_STOP_NMI,		// SGI3 reserved for OOB
> 					// STOP_NMI via SGI0 with reason set
>
>
> 					// SGI4-7 unused
>
> 	IPI_TIMER,			// via SGI0 with reason set
> 	IPI_IRQ_WORK,			// via SGI0 with reason set
> 	NR_IPI,
> 	/*
> 	 * Any enum >=3D NR_IPI and < MAX_IPI is special and not tracable
> 	 * with trace_ipi_*
> 	 */
> 	IPI_CPU_BACKTRACE =3D NR_IPI,	// via SGI0 with reason set
> 	IPI_KGDB_ROUNDUP,		// via SGI0 with reason set

Yep, this is what we should have if the current scheme is kept.

> 	MAX_IPI
> };
>
>
>
> Final questions:=C2=A0
>
> Assuming SGI mode: Where are the request_percpu_irq() calls for all the
> OOB SGIs?

The real-time core takes care of this (e.g. v3 does this in
pipeline_request_resched_ipi(), pipeline_install_tick_proxy()).

> Or: How is something like irq_send_oob_ipi(2, mask) expected
> to get the right IRQ descriptor in arm64_send_ipi()? Currently the
> descriptor for SGI0 is returned.
>

No, SGI1-3 may be returned, never SGI0.

arch/arm64/include/asm/irq_pipeline.h:
#define OOB_IPI_OFFSET		1 /* SGI1 */
#define TIMER_OOB_IPI		(ipi_irq_base + OOB_IPI_OFFSET)
#define RESCHEDULE_OOB_IPI	(TIMER_OOB_IPI + 1)
#define CALL_FUNCTION_OOB_IPI	(RESCHEDULE_OOB_IPI + 1)

and:

unsigned int sgi =3D irq - ipi_irq_base;

The irq numbers passed to irq_send_oob_ipi() must be one of these IPI
values otherwise the debug assertion on entry would fail, so the mapping
is correct.

> Is that all just broken for a long time?

No, that part is ok. Only CPU backtracing and KGDB were broken due to
bypassing the mapping to SGI0, due to a merge fallout after upstream
reorganized their own mapping code. Otherwise no tick, no rescheduling
would have been received ever by Xenomai. You would have noticed :)

>
> In addition I think that the trace_ipi_raise() in __smp_cross_call() is
> incorrect for OOB SGIs...
>

Yes, would not break anything, but wrong IPI label in the traces for sure.

--=20
Philippe.
