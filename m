Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88D324B3A
	for <xenomai@lists.linux.dev>; Tue, 23 Sep 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633017; cv=none; b=IIEm2mLlcL/FQm90g4YroTXceukzcK2qGrARwJdAcslxhlTVZhuT9t4JBAdK0K1Tr7YdcTKeYDs01wvvaOeTrf7zvGoejub9GY+n286NCYUvKSAmOVUCQlKER3qix3aHS9+EN7/zdzm5/ftMge0w96LBFlQr/1QOIIwF9vo0Jcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633017; c=relaxed/simple;
	bh=McHl6hKGZl+wAP7hL0bRxdsJoqaK6FIEcDJ/QW+FuZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVRDnOM/OB4HRb3zY26GiF0Ptoa8rQM9HgSYP2O4oBUnqW/ShRAOGVi5dwMlLitRHDj/ZKUkiKQmH/6O9xHc/bpUuv/J7cVrlRZ9olThomEWN8GfCEJTThJAx/ocx0DjSmVVcDbdg5wqa19cvYrdvBSyeGsKWPJfxoEXgo8q3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=a+tI4uDF; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="a+tI4uDF"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025092313100359a5705018000207e3
        for <xenomai@lists.linux.dev>;
        Tue, 23 Sep 2025 15:10:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LRE9aVoEkxqxwLv6NRWCI05UB7fFDDjg4LkECcqMntU=;
 b=a+tI4uDFMOM5vwRciyUfCYjz4HwmtmYhjzOPeCUXIEwUJraWnaWTmSHYQXvDBUXmI6al1g
 rHlaEYFXZavhfrpfId+4pmBLQpuMI1XWR4/+1L8t8mqXSIUtpGcNpjkZ+AljSK3C/BT3N/6v
 02h/srG1A2NalXU/A0tkRuL1gaCYqM8OgK899jwzJpPVgdcLX99QRL07kHaTgCFs4XLC3Cn0
 ow1WKcvDvS/fcpUCQZzVMxRoqCjnKcMYbfgJDOj1QAe+2mmzWObDdZ9oTTkBh324NeO3PN3I
 n8WUOZp4ecfBCuydjLBdMFBEqEafhI9vcDrWklwNiQ54fSUPZvYUWp3w==;
Message-ID: <0d5fbc3c6b70b4f5e5f485606311754b35d63dba.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v2 0/4] dovetail: Add support for hyper-v
 as hypervisor
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 23 Sep 2025 15:10:01 +0200
In-Reply-To: <08a144841bbb9ddfee0eb7bcad72b91258e91480.camel@siemens.com>
References: 
	<20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
		 <f8a3f95c-f16d-4db3-8785-3acda2c738f7@siemens.com>
		 <efaeb08a17e419695579f4edba542974fda2f4d4.camel@siemens.com>
		 <115cc6e1-f850-451f-96a1-e711e4ecaa66@siemens.com>
	 <08a144841bbb9ddfee0eb7bcad72b91258e91480.camel@siemens.com>
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

On Mon, 2025-09-22 at 10:27 +0200, Florian Bezdeka wrote:
> On Mon, 2025-09-22 at 09:22 +0200, Jan Kiszka wrote:
> > On 22.09.25 09:04, Florian Bezdeka wrote:
> > > On Thu, 2025-09-18 at 18:19 +0200, Jan Kiszka wrote:
> > > > On 18.09.25 15:41, Florian Bezdeka wrote:
> > > > > Hi all,
> > > > >=20
> > > > > with this series applied dovetail is successfully booting up on a
> > > > > Windows host using the Hyper-V hypervisor as virtualization platf=
orm.
> > > > >=20
> > > > > You won't get any RT guarantees - that's clear - but it helps to =
test
> > > > > non-RT stuff using a dovetail enabled kernel on such a platform.
> > > > >=20
> > > > > The following config knobs were turned on during testing:
> > > > >   - CONFIG_HYPERV
> > > > >   - CONFIG_HYPERV_NET
> > > > >   - CONFIG_HYPERV_KEYBOARD
> > > > >   - CONFIG_HYPERV_TIMER
> > > > >   - CONFIG_HYPERV_UTILS
> > > > >   - CONFIG_HYPERV_BALLOON
> > > > >   - CONFIG_HYPERV_IOMMU
> > > > >   - CONFIG_HYPERV_STORAGE
> > > > >=20
> > > >=20
> > > > Looks good to me.
> > > >=20
> > > > But the only way to stress these things remains running on a real
> > > > hyper-v. QEMU/KVM is not able to emulate essential PV interfaces th=
at we
> > > > use here, is it?
> > >=20
> > > Yes and no.=C2=A0
> > >=20
> > > Yes, qemu is able to emulate some of those so called "enlightenments"=
,
> > > see [1].
> > >=20
> > > But: Linux does not run into the code paths where such features - lik=
e
> > > the stimer - would be enabled.=C2=A0
> > >=20
> > > One of the first things the Linux guests does during hypervisor
> > > detection is firing the HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS cpuid
> > > call. The received hypervisor signature is "Linux KVM Hv" instead of
> > > "Microsoft Hv". Linux stops the hyper-v para-virtualization
> > > initialization at this point and moves on to using KVM guest para-
> > > virtualization.
> > >=20
> > > My current interpretation is that those enlightenments are made for
> > > Windows guests were the initialization code paths on guest side are
> > > different.
> > >=20
> > > [1] https://www.qemu.org/docs/master/system/i386/hyperv.html
> >=20
> > If you do not use hv-passthrough but rather enable features manually,
> > you will get "Microsoft Hv", see qemu/target/i386/cpu.c and
> > qemu/target/i386/kvm/kvm.c.
> >=20
> >=20
>=20
> Ha, yes, that makes a difference but shows different feature sets on
> different host systems. There are a couple of host dependencies now.
>=20
> For now I'm stressing
> -cpu host,hv_vapic,hv_spinlocks=3D0xff,hv_vpindex,hv_time,hv_synic,hv_sti=
mer,hv_ipi,
> on a 6.1 host with success, even though not all features are available.
       ^^^^
       typo: It was a 6.16 host.

I played around with some CI enablement today but failed. All hosts
driving the CI qemu instances are based on 6.1, which is too old. (No
CONFIG_KVM_HYPERV, available since 6.8)

I can revisit that topic once the systems have been updated. I'm
expecting this to happen within the next months anyway.
