Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E725BEF1
	for <xenomai@lists.linux.dev>; Mon, 22 Sep 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529662; cv=none; b=HxfCaa3C5hRlAOGBxAz5lsaCIFhQj/1qYRtClNF86GtuU2it929Me+6MNbs+ErCIQo352tDqXxP4eWgPfa/FCw7qRYIg7Q2KGK71DDTWR9zjLhycWiIc13mAQHggWRbNED0Znrc8r3PoDG5YOED3/hnDijmGviMAGY0eQ1knaUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529662; c=relaxed/simple;
	bh=ciEdYIDN+Tv1KSSXyLZEhI15wSr+VMd/tztgLiqqzsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbJULPPqBxUBoq6D34NNjnK/7wMbVpABE4IvCxFwaVE8tfp1Kg9IMa581f46UDUq51BW8Db/CyCglXKmE9Y+Zz6Itrh86WKcNIcTBExkejSATAZ5YPg47FxblfHjRrwDiAAy018VcS/MoF+FDs4nC3B+TVuoAzHX53buHra4Kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jAbJaJOf; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jAbJaJOf"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202509220827269b4cb8229d0002079b
        for <xenomai@lists.linux.dev>;
        Mon, 22 Sep 2025 10:27:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=W6JihV+gQmPkHjalhETuMRrnEEu4Jw+Z7/w8NFpeK0k=;
 b=jAbJaJOfgBtHFEcN4Xrjpc2ilcJGl16xmrBVejWpamgiQaIALguDTY6QzgqiUdSejJllNp
 u++llpTHe4kIdgM/AMPewWwXSvGL9Yn8KkcPE8Dw5xsbpma+hDI3b9nkKbJbARC8TqVXYLdS
 XdIyMRGFLUBrvLTNKB2SpU3L3YQfGxxORZwz2ytJF3jekH3MXxty+YWllgjNXjpvLhtgHFAl
 Mq11r591esCoThJ9L6Da3gy8mOnWJAhRitBU1B8VcyKGvfrtLRvEO0q9GX5Th9xFJmGYv84J
 x3fhEY422xkwcbl/Mjlp4N8mP3DsgbY2e5VnK9Lobu07CXLbgZp6DXSg==;
Message-ID: <08a144841bbb9ddfee0eb7bcad72b91258e91480.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v2 0/4] dovetail: Add support for hyper-v
 as hypervisor
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Mon, 22 Sep 2025 10:27:26 +0200
In-Reply-To: <115cc6e1-f850-451f-96a1-e711e4ecaa66@siemens.com>
References: 
	<20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
	 <f8a3f95c-f16d-4db3-8785-3acda2c738f7@siemens.com>
	 <efaeb08a17e419695579f4edba542974fda2f4d4.camel@siemens.com>
	 <115cc6e1-f850-451f-96a1-e711e4ecaa66@siemens.com>
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

On Mon, 2025-09-22 at 09:22 +0200, Jan Kiszka wrote:
> On 22.09.25 09:04, Florian Bezdeka wrote:
> > On Thu, 2025-09-18 at 18:19 +0200, Jan Kiszka wrote:
> > > On 18.09.25 15:41, Florian Bezdeka wrote:
> > > > Hi all,
> > > >=20
> > > > with this series applied dovetail is successfully booting up on a
> > > > Windows host using the Hyper-V hypervisor as virtualization platfor=
m.
> > > >=20
> > > > You won't get any RT guarantees - that's clear - but it helps to te=
st
> > > > non-RT stuff using a dovetail enabled kernel on such a platform.
> > > >=20
> > > > The following config knobs were turned on during testing:
> > > >   - CONFIG_HYPERV
> > > >   - CONFIG_HYPERV_NET
> > > >   - CONFIG_HYPERV_KEYBOARD
> > > >   - CONFIG_HYPERV_TIMER
> > > >   - CONFIG_HYPERV_UTILS
> > > >   - CONFIG_HYPERV_BALLOON
> > > >   - CONFIG_HYPERV_IOMMU
> > > >   - CONFIG_HYPERV_STORAGE
> > > >=20
> > >=20
> > > Looks good to me.
> > >=20
> > > But the only way to stress these things remains running on a real
> > > hyper-v. QEMU/KVM is not able to emulate essential PV interfaces that=
 we
> > > use here, is it?
> >=20
> > Yes and no.=C2=A0
> >=20
> > Yes, qemu is able to emulate some of those so called "enlightenments",
> > see [1].
> >=20
> > But: Linux does not run into the code paths where such features - like
> > the stimer - would be enabled.=C2=A0
> >=20
> > One of the first things the Linux guests does during hypervisor
> > detection is firing the HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS cpuid
> > call. The received hypervisor signature is "Linux KVM Hv" instead of
> > "Microsoft Hv". Linux stops the hyper-v para-virtualization
> > initialization at this point and moves on to using KVM guest para-
> > virtualization.
> >=20
> > My current interpretation is that those enlightenments are made for
> > Windows guests were the initialization code paths on guest side are
> > different.
> >=20
> > [1] https://www.qemu.org/docs/master/system/i386/hyperv.html
>=20
> If you do not use hv-passthrough but rather enable features manually,
> you will get "Microsoft Hv", see qemu/target/i386/cpu.c and
> qemu/target/i386/kvm/kvm.c.
>=20
>=20

Ha, yes, that makes a difference but shows different feature sets on
different host systems. There are a couple of host dependencies now.

For now I'm stressing
-cpu host,hv_vapic,hv_spinlocks=3D0xff,hv_vpindex,hv_time,hv_synic,hv_stime=
r,hv_ipi,
on a 6.1 host with success, even though not all features are available.

> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
