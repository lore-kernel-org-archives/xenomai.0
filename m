Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570F5CD0F
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DHFSvi4B"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20231205132115b9b05802d106801d3e
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 14:21:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gABhT054OjaoDrsGFQo8sT0WjKMcyHL3wdph+RmNdFA=;
 b=DHFSvi4BzPW+nPzHAbY84HWXfsoWprKZndefEk5IEHgRZoVTnizIRkGJQiaNEIEtuabOYG
 04tHNH56NZqWKBgFD0vzke3rfCvWmFRQw0hofeQA+cpJ9vC+qV7VPa/vk5JOdooeT+zo3Fxh
 k6gdTZqQn325JUUrX+fCijCwezVv4=;
Message-ID: <cd40b0a44612f1f233aba3b3e8fe3748833771c9.camel@siemens.com>
Subject: Re: Can xenomai-kernel boot on the second-generation hyper-v ?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "mars_liu2023@163.com"
	 <mars_liu2023@163.com>, xenomai <xenomai@lists.linux.dev>, rpm@xenomai.org
Date: Tue, 05 Dec 2023 14:21:14 +0100
In-Reply-To: <3718a82d-7421-49b0-8a4d-21b8886d2e8a@siemens.com>
References: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
	 <3718a82d-7421-49b0-8a4d-21b8886d2e8a@siemens.com>
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

On Tue, 2023-12-05 at 15:40 +0900, Jan Kiszka wrote:
> On 03.12.23 15:13, mars_liu2023@163.com wrote:
> > Hi xenomai,
> >=20
> > I tried to learn the Xenomai kernel on =C2=A0Hyper-V=EF=BC=8Cand appear=
 some problems.
> > xeno-kernel can't boot on the hyper-v ,so i did the following .
> > I saw such a message in other mails in the community that "prevent CONF=
IG_HYPER from being built if interrupt pipeline is enabled",so i disabled C=
ONFIG_HYPER for =C2=A0boot xeno_kernel(version :5.10.180-xenomai.3.2.2)=C2=
=A0 on hyper-v .
> > it can work well on the fist-generation hyper-v,but it's boot failed on=
 the second-generation hyper-v.
> > This is also the=C2=A0 case when disabled CONFIG_HYPER on normal linux =
kernel.
> > Did i do something wrong ? it seems linux (vesrion 5.10.180) disabled C=
ONFIG_HYPER can't work on the second-generation hyper-v.
> > Is xeno-kernel(dovetail) not allowed to work on the second-generation h=
yper-v? if not ,how do i do it ?
> > thanks for any reply.
>=20
> I vaguely recall some very unfortunate internal dependencies of Hyper-V
> device drivers support on CPU paravirt features, at least Kconfig-wise,
> but I don't recall all details. Florian, do you?

No. The situation is a bit strange here. Adding Philippe, we might have
a typo in drivers/hv/Kconfi:

Taken from drivers/hv/Kconfig:

config HYPERV
	tristate "Microsoft Hyper-V client drivers"
	depends on ACPI && !IRQ_PIPIPELINE && \
		((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
		|| (ARM64 && !CPU_BIG_ENDIAN))

!IRQ_PIPIPELINE will always be true (due to the typo).

That explains why one of my kernel configurations with
	CONFIG_IRQ_PIPELINE=3Dy
	CONFIG_HYPERV=3Dm
builds, but I have never tried to boot it up on any hyper-v enabled
machine so far.

Question to Philippe: Why did you try to disable the HYPERV bits? Due
to the lack of testing or is there more behind it? Building works, so
it must have been something hat happens during runtime...

Best regards,
Florian

>=20
> Jan
>=20

