Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB52C3745
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770205460; cv=none; b=ADBoey2z86naW2XEb3MtBb23E3AFLZgMt4KSiCfALHtO0KWp6CY21VlLzDvUQ5ZIhySaUFnH+8r+h+8+YDkR5lWX3GWpZhRS5U8B83SyJOd7Jevq49gndqLfSGCIdLmS4Rc9WkGDZUx1qKjjilpzujqPOABs9lWlUzzeLiLklgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770205460; c=relaxed/simple;
	bh=MTERZMQnSfGsZ0kj8TH6kuEipGEIDW99uZ5aCzGM0Ks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFcg8Ee+InGWla4JFkk11DKt6DOkG04HmPyB9x0e0tM2sVuNBBjZRLLBWEXDIknJ5tU2xdq3OAdjvJ34ppQ0tfI+7k8zP274R4fSO5Q2tyIoekTdd1GUeT7Kzhl9ondNoBcCy+5ibr+pdKeIpFtbXTbTA6B/W0HscZTUhjKsvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=UlgAbJxW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="UlgAbJxW"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9FFC643390;
	Wed,  4 Feb 2026 11:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1770205457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIbunZSRsNRu6emjEIJkei7kWErcgTWNL35INMuTHeE=;
	b=UlgAbJxW6k/go1stcKzCQDhksjjXp+kUTOTxBny/APoNhTbA8/nrrvgpTF/4TJ12IBBlXf
	Nd7ymHMPKeGzoPFHGP/c23wJDzEvoZu1Q8zCt1EFUW9wqV5x2lh+Sws0e6CunqkFAVNssZ
	5jT0Rr2xF1J/uK189ou7vPoDtwwYBwkoFVZEkXY6jty1okUi8bGWTKaVkq/lFMI4n87LxJ
	bg9oYrXMhh95LGlDTzurQ86JYN3K9ROX/dCo02FyDQpGLk1lkiGHIGJQA+dAHn5+JcJjfW
	VHbX6wch2yWHNdcR5cgif02wmob25hPAQWYWQUswqWbGU4QyFIPoWenZ6yv9Rw==
From: Philippe Gerum <rpm@xenomai.org>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: [PATCH Dovetail 6.18 1/3] arm64: irq_pipeline: Fix mapping of
 SGI/LPI IPIs
In-Reply-To: <776cf4d59124068e8d4ee1976fb3eb00f55c9b86.camel@siemens.com>
	(Florian Bezdeka's message of "Tue, 3 Feb 2026 22:00:54 +0000")
References: <20260201-wip-flo-fixes-for-6-18-v1-0-91ea07c7eb7e@siemens.com>
	<20260201-wip-flo-fixes-for-6-18-v1-1-91ea07c7eb7e@siemens.com>
	<87o6m6vutd.fsf@xenomai.org>
	<513ae7f9858f1bc553be3c6fcbbcabf1c89d6b25.camel@siemens.com>
	<87qzr1ivxz.fsf@xenomai.org>
	<198ace7718b548735ec0cb3e29b5c4f8129fbe9d.camel@siemens.com>
	<776cf4d59124068e8d4ee1976fb3eb00f55c9b86.camel@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 04 Feb 2026 12:44:13 +0100
Message-ID: <87o6m44tte.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepteeufeejueeuffdufeeggeekgeeltefgkeeigedvjeeifeeggfelieegvdfgkeeinecuffhomhgrihhnpehrvggrughthhgvughotghsrdhiohenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpqhhiugeplefhhfevieegfeefledtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrs
 ggviiguvghkrgesshhivghmvghnshdrtghomh
X-GND-State: clean
X-GND-Score: -100

"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Tue, 2026-02-03 at 22:48 +0100, Florian Bezdeka wrote:
>> On Tue, 2026-02-03 at 18:22 +0100, Philippe Gerum wrote:
>> > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>> >=20
>> > > On Tue, 2026-02-03 at 14:08 +0100, Philippe Gerum wrote:
>> > > > -static inline void map_oob_ipis(int cpu)
>> > > > +static inline void map_oob_ipis(int cpu, int offset)
>> > > >  {
>> > > >  	int ipi;
>> > > >=20=20
>> > > >  	for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFSET; =
ipi++)
>> > > > -		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + ipi);
>> > > > +		get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base + cpu * off=
set + ipi);
>> > > >  }
>> > >=20
>> > > I'm still quite sure that the loop is wrong and should be=20
>> > >=20
>> > > +static inline void map_oob_ipis(int cpu, int offset)
>> > >  {
>> > >         int ipi;
>> > >=20=20
>> > > -       for (ipi =3D OOB_IPI_OFFSET; ipi < OOB_NR_IPI + OOB_IPI_OFFS=
ET; ipi++)
>> > > -               get_ipi_desc(cpu, ipi) =3D irq_to_desc(ipi_irq_base =
+ ipi);
>> > > +       offset =3D ipi_irq_base + (cpu * offset);
>> > > +
>> > > +       for (ipi =3D OOB_IPI_OFFSET; ipi < nr_ipi; ipi++)
>> > > +               get_ipi_desc(cpu, ipi) =3D irq_to_desc(offset + ipi);
>> > >  }
>> > >=20
>> >=20
>> > For ipi=3DSGI-0-7, the upstream implementation of ipi_setup_lpi() does:
>> >=20
>> >                 irq =3D ipi_irq_base + (cpu * nr_ipi) + ipi;
>> > 		get_ipi_desc(cpu, ipi) =3D irq_to_desc(irq);
>> >=20
>> > In pipelined mode, we need to do that for ipi=3DSGI0 for in-band IPIs,
>> > then for ipi=3DSGI1-3 for oob ones (see below). All members of
>> > ipi_msg_type become _logical_ IPIs multiplexed over SGI0. That is the
>> > whole point of your fix regarding CPU_BACKTRACE and KGDB_ROUNDUP.
>> >=20
>> >=20
>> > > instead. (Note OOB_NR_IPI + OOB_IPI_OFFSET vs. nr_ipi)
>> >=20
>> > The code above would map the original IPI range from SGI0-7, which we
>> > don't have to in pipelined mode, we only use SGI0-3 here.
>> >=20
>> > >=20
>> > > Example:
>> > >=20
>> > > static void arm64_send_ipi(const cpumask_t *mask, unsigned int nr)
>> > > {
>> > > 	unsigned int cpu;
>> > >=20
>> > > 	if (!percpu_ipi_descs)
>> > > 		__ipi_send_mask(get_ipi_desc(0, nr), mask);
>> > >=20
>> > > How should that work for IPI_IRQ_WORK? IPI_IRQ_WORK is located behind
>> > > the IPIs used for OOB and get_ipi_desc(0, IPI_IRQ_WORK) would return
>> > > NULL as we skipped the mapping in map_oob_ipis().
>> > >=20
>> >=20
>> > Any IPI from IPI_RESCHEDULE to IPI_IRQ_WORK are multiplexed over SGI0 =
by
>> > smp_cross_call().=C2=A0
>> >=20
>>=20
>> Here we go. I missed that smp_cross_call() calls __smp_cross_call() with
>> ipinr set to 0, unconditionally, not forwarding ipinr. I simply
>> overlooked that. That allows us to only map the oob IPIs as the "wrong"
>> mapping in arm64_send_ipi() can not happen anymore. Sorry for the
>> confusion.
>
> That didn't last long. Two ways to fix the problem at the end:
>
>   - Only map OOB IPIs as suggested by Philippe.
>     Means we have to modify arm64_backtrace_ipi() and
>     kgdb_roundup_cpus() for the dovetailing case.
>     Calling arm64_send_ipi() with an ipi-nr !=3D 0 is not allowed in the
>     dovetailing case for inband IPIs.
>
>   - Map all IRQs as suggested by me.
>
> Hopefully correct now...
>
> Which way is the preferred one?
>
>>

Excerpt from arch/arm/kernel/smp.c:

enum ipi_msg_type {
     ...
	/*
	 * SGI8-15 can be reserved by secure firmware, and thus may
	 * not be usable by the kernel. Please keep the above limited
	 * to at most 8 entries.
	 */
	MAX_IPI
};

This still holds true for ATF [1], so we only have 8 available SGIs
although GICv3+ do provide 16. Since we have 8 in-band IPI message types
defined by the arm64 port and we need 3 oob vectors more, we can't have
a 1:1 mapping between IPIs and SGIs.

So far we are using 4 SGIs as explained above (1 in-band + 3 oob), so we
have 4 spares ATM. The reason for moving an in-band IPI to its own SGI
using one of those spares would be to prioritize it over the bulk of
in-band messages. Therefore, the question would be: do we need such
prioritization?

[1] https://trustedfirmware-a.readthedocs.io/en/latest/porting-guide.html#f=
unction-bl31-platform-setup-mandatory

--=20
Philippe.
