Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EF2F0694
	for <xenomai@lists.linux.dev>; Mon, 22 Sep 2025 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524688; cv=none; b=ssqS4c6XBg4vW2Da6NEZUtSuQ9OrlRFMPBVvCx0FMGogNL/LIaEfg7e+cjrx4sJbWmtG7iT9Y53YDBPxki8iO3kQdwpnJ3OTOvNo9gpymZwpJ3hL3nMzSz8ECsEDKsdBs7sKDL+kw0LZ3w/001OTU53qe2y2l4HreDwACDHLLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524688; c=relaxed/simple;
	bh=8+G0U33gMGNoL7IoH+eQraxmdCvTquo9JCDmYO8hbHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4p/4r/BEHC3RRXXmkJjzeNft6HSeTcZJUeUySgXzMueyntc36AKgIZ8pt0SwlxDKNaZVoD445AAAQOkZqb0iMJD6vyoYqY1AGGMtdVVUtxI3J9jwXhC7+RMw4uTadl2NG0w4atQbsVc4PjZPXQXpvv9SdVCpiBAMmHWSrMGk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=MPMAufSn; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="MPMAufSn"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250922070432635118f979000207b4
        for <xenomai@lists.linux.dev>;
        Mon, 22 Sep 2025 09:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=9nUJyEmKxyVscEDI9od/mmY34cd6Me2UynKPFlGJKKc=;
 b=MPMAufSn80M2C8Y4e7pNbmxyTZNe+r8Z6nDsnMz2kq1KF4c7HkNwnmLOn0uh2d1v6QkuvE
 PPsMh0zMiQ79Ha7Ed4gdAGXxoyBiil9DooXuZdoBmD0xx1dCZQLPZXqCYLJa6PtaD1e9O26w
 OOnxEsxz2EjiBE5fNny/c//OHBKk8aDDOm9z6aZXVoV6GbCwVtDWi0+jy+zuJ5oKEF/pGoL5
 0ZjgSmy85YEbUUKpfWMi+ww5AMhuw2A/86u3uyR0k51jvJx8Kkc7T6USUItaD14DLAcH+8FO
 30hCnwpq1i2k4zVwxK7Lqj4Q4LK/BVwsdip3B43KEKgZJ+RaTZacRg6w==;
Message-ID: <efaeb08a17e419695579f4edba542974fda2f4d4.camel@siemens.com>
Subject: Re: [PATCH Dovetail 6.16 v2 0/4] dovetail: Add support for hyper-v
 as hypervisor
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Mon, 22 Sep 2025 09:04:32 +0200
In-Reply-To: <f8a3f95c-f16d-4db3-8785-3acda2c738f7@siemens.com>
References: 
	<20250602-flo-add-hyperv-support-for-6-15-v2-0-f1c802b1aba3@siemens.com>
	 <f8a3f95c-f16d-4db3-8785-3acda2c738f7@siemens.com>
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

On Thu, 2025-09-18 at 18:19 +0200, Jan Kiszka wrote:
> On 18.09.25 15:41, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > with this series applied dovetail is successfully booting up on a
> > Windows host using the Hyper-V hypervisor as virtualization platform.
> >=20
> > You won't get any RT guarantees - that's clear - but it helps to test
> > non-RT stuff using a dovetail enabled kernel on such a platform.
> >=20
> > The following config knobs were turned on during testing:
> >   - CONFIG_HYPERV
> >   - CONFIG_HYPERV_NET
> >   - CONFIG_HYPERV_KEYBOARD
> >   - CONFIG_HYPERV_TIMER
> >   - CONFIG_HYPERV_UTILS
> >   - CONFIG_HYPERV_BALLOON
> >   - CONFIG_HYPERV_IOMMU
> >   - CONFIG_HYPERV_STORAGE
> >=20
>=20
> Looks good to me.
>=20
> But the only way to stress these things remains running on a real
> hyper-v. QEMU/KVM is not able to emulate essential PV interfaces that we
> use here, is it?

Yes and no.=C2=A0

Yes, qemu is able to emulate some of those so called "enlightenments",
see [1].

But: Linux does not run into the code paths where such features - like
the stimer - would be enabled.=C2=A0

One of the first things the Linux guests does during hypervisor
detection is firing the HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS cpuid
call. The received hypervisor signature is "Linux KVM Hv" instead of
"Microsoft Hv". Linux stops the hyper-v para-virtualization
initialization at this point and moves on to using KVM guest para-
virtualization.

My current interpretation is that those enlightenments are made for
Windows guests were the initialization code paths on guest side are
different.

[1] https://www.qemu.org/docs/master/system/i386/hyperv.html
