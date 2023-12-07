Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFD34183
	for <xenomai@lists.linux.dev>; Thu,  7 Dec 2023 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="UB5qCOVp"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20231207132143bb6788b0ca28e83b4e
        for <xenomai@lists.linux.dev>;
        Thu, 07 Dec 2023 14:21:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=f+If9vOiKFSYs5tKWhNUu8lFdavdxCyotlYBYnuQci8=;
 b=UB5qCOVpMljD7YeBZpMJixNRMVM4cPTH1e7HnXM0RuUAJEHgnIT+uhTI4lvH3lMMcT2uDN
 U5Jd52ItbD2xX0AhiKyj9ltTlud65f2gWgOQ6QuTaP7FT5uYU650qvoCM4RBEYB1OC9/Tti8
 Q55kw4qkAVeysQ6SH6cb7Fj4xw4LA=;
Message-ID: <a7756962bd637d2738611761c600bf81d367aab9.camel@siemens.com>
Subject: Re: Can xenomai-kernel boot on the second-generation hyper-v ?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>, "mars_liu2023@163.com"
	 <mars_liu2023@163.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@lists.linux.dev>
Date: Thu, 07 Dec 2023 14:21:42 +0100
In-Reply-To: <87il5al8zb.fsf@xenomai.org>
References: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
	 <3718a82d-7421-49b0-8a4d-21b8886d2e8a@siemens.com>
	 <cd40b0a44612f1f233aba3b3e8fe3748833771c9.camel@siemens.com>
	 <87il5al8zb.fsf@xenomai.org>
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

On Thu, 2023-12-07 at 08:52 +0100, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>=20
> > On Tue, 2023-12-05 at 15:40 +0900, Jan Kiszka wrote:
> > > On 03.12.23 15:13, mars_liu2023@163.com wrote:
> > > > Hi xenomai,
> > > >=20
> > > > I tried to learn the Xenomai kernel on =C2=A0Hyper-V=EF=BC=8Cand ap=
pear some problems.
> > > > xeno-kernel can't boot on the hyper-v ,so i did the following .
> > > > I saw such a message in other mails in the community that "prevent =
CONFIG_HYPER from being built if interrupt pipeline is enabled",so i disabl=
ed CONFIG_HYPER for =C2=A0boot xeno_kernel(version :5.10.180-xenomai.3.2.2)=
=C2=A0 on hyper-v .
> > > > it can work well on the fist-generation hyper-v,but it's boot faile=
d on the second-generation hyper-v.
> > > > This is also the=C2=A0 case when disabled CONFIG_HYPER on normal li=
nux kernel.
> > > > Did i do something wrong ? it seems linux (vesrion 5.10.180) disabl=
ed CONFIG_HYPER can't work on the second-generation hyper-v.
> > > > Is xeno-kernel(dovetail) not allowed to work on the second-generati=
on hyper-v? if not ,how do i do it ?
> > > > thanks for any reply.
> > >=20
> > > I vaguely recall some very unfortunate internal dependencies of Hyper=
-V
> > > device drivers support on CPU paravirt features, at least Kconfig-wis=
e,
> > > but I don't recall all details. Florian, do you?
> >=20
> > No. The situation is a bit strange here. Adding Philippe, we might have
> > a typo in drivers/hv/Kconfi:
> >=20
> > Taken from drivers/hv/Kconfig:
> >=20
> > config HYPERV
> > 	tristate "Microsoft Hyper-V client drivers"
> > 	depends on ACPI && !IRQ_PIPIPELINE && \
> > 		((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > 		|| (ARM64 && !CPU_BIG_ENDIAN))
> >=20
> > !IRQ_PIPIPELINE will always be true (due to the typo).
> >=20
>=20
> Yep, was fixed in 6.4 and above.
>=20
> > That explains why one of my kernel configurations with
> > 	CONFIG_IRQ_PIPELINE=3Dy
> > 	CONFIG_HYPERV=3Dm
> > builds, but I have never tried to boot it up on any hyper-v enabled
> > machine so far.
> >=20
> > Question to Philippe: Why did you try to disable the HYPERV bits? Due
> > to the lack of testing or is there more behind it? Building works, so
> > it must have been something hat happens during runtime...
> >=20
>=20
> I did not care about HYPERV, that's pretty much the reason. Which means
> no use case, therefore no specific work on enabling/testing interrupt
> pipelining for this beast, so I forced it off. Only PARAVIRT_XXL is
> officially a no-go for Dovetail ATM, because the current irqflags
> implementation for x86 prevents it.
>=20

Philippe, thanks for the clarification. I might have to revisit this
topic in the future as some colleagues had some thoughts about using
hyper-v during development. If we would report back that it works
(maybe with some necessary fixes) you would consider removing the
restriction?

To the original thread creator: It's quite clear that you face boot
problems over hyper-v without hyper-v guest support in the kernel
(=3Ddisabled CONFIG_HYPERV). I can't say something about the different
versions of hyper-v regarding dovetail/xenomai yet. I have never tried
it. Can you follow the boot process by some kind of virtual serial
console? Any relevant output?

Best regards,
Florian

