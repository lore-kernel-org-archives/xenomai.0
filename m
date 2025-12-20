Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5229A1
	for <xenomai@lists.linux.dev>; Sat, 20 Dec 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766189039; cv=none; b=MhPgbEwuuVwGIyf0ah5mfzcN56gEDW7mJJDoyBewMYDRYHzoTMx4q+/J65VQpJO6y7yMwIreG82RJLnruAoOqUJBJ0dHXvNzAGlCrF+yg0gzVFRQ1fddnM21Gc5QK3BZeT0P0KEtjRBUXAbRLXPIMxf5N8qo63pvXFQE+PosXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766189039; c=relaxed/simple;
	bh=FOIEsVOFMndfPiDgm5uCi1VF95kHz0USqp9oPCzxbkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tne/Fr8DHQ+vgAvD6lb1DPNc2+8an5Pq1KUyQc1Gx1LuRtc1QsRSvfk7AJno4b4MnHq1WTmfnh+jfFzjwYGjfubu2klZcX+j70jIyZK6hQqjNn4WSRWkxUR5TdoFTb/jRWdE94bO9iiIuHh9Z6tB1d7r5K8TLfU0iGnujEzk7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=o59RZGPC; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="o59RZGPC"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251220000345684da3e6e20002079b
        for <xenomai@lists.linux.dev>;
        Sat, 20 Dec 2025 01:03:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=27Ie6HdX9N5jT8VcxjsBKIVoJFbjZH4VLnpsmqgaXVY=;
 b=o59RZGPCISgpHy79sODmprk9IqqUgdKc4X4towm73qGJilnQrNoexNfg+SCtH/I6hdKw82
 mPA7DcZPJEr0cv4szt8z9Ffe6aCReibjsKtc5vJh0Um0Je7QfcP2w4yGSUTV84iX4EDbqXsk
 ws81vl/OmDjBV+F5JM+V8hEaA6gS2ylfX6yux6gZv8eieEZdoA10wZCEu8soMhi/lLscnwoR
 vwkacA0T3pbfq2/AEy7TLj+FX4sHkFKZtRCgt3xzDEQWKKyNiVQmmbzQFMlIbB/JRg8uiRdO
 sTAOmCEMj/AMZaM3EPZ2zCiN91pxEznyw2zyQA98uPKXetjJWoHPceyA==;
Message-ID: <e99baed49536a1a461ba56c87d043a6299778639.camel@siemens.com>
Subject: Re: [PATCH RFC Dovetail 6.1 0/3] arm64: Enable in-kernel FPU /
 FPSIMD usage
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
Date: Sat, 20 Dec 2025 01:03:44 +0100
In-Reply-To: <181afe87-4b2d-45e7-8ede-eed5e95e04a3@siemens.com>
References: 
	<20251119-flo-6-1-arm64-fpsimd-test-enablement-v1-0-8653c0b573fd@siemens.com>
	 <181afe87-4b2d-45e7-8ede-eed5e95e04a3@siemens.com>
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

On Wed, 2025-12-17 at 17:51 +0100, Jan Kiszka wrote:
> On 19.11.25 15:25, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > these are the necessary backports for dovetail 6.1 that would allow us =
to
> > enable the in-kernel FPU usage of switchtest. This is currently not
> > possible as dovetail < 6.12 does not allow / implement the necessary fp=
simd
> > context switching.
> >=20
> > I have backported the necessary patches down to 5.10. That would allow
> > us to unconditionally enable the tests for the xenomai3-next branch. I
> > will send out the 5.15 and 5.10 series once we agreed that this version
> > (targeting 6.1) is correct.
> >=20
> > Please note that there is a small problem with this series. Patch 1
> > removes the check/flag that was used by the dovetail enablement code to
> > detect in-band FPU usage. The new flag is implemented differently in
> > patch 2. Patch 2 also fixes the usage of that flag. I had no better
> > idea. Otherwise I would have to delete? the in-kernel fpu preemption
> > code (temporary).
> >=20
> > Previous discussion can be found here:
> > https://lore.kernel.org/xenomai/cover.1758264904.git.jan.kiszka@siemens=
.com/T/#t
> >=20
> > Best regards,
> > Florian
> >=20
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > Cc: Philippe Gerum <rpm@xenomai.org>
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > Florian Bezdeka (3):
> >       arm64: fpsimd: Drop unneeded 'busy' flag
> >       arm64: fpsimd: Preserve/restore kernel mode NEON at context switc=
h
> >       arm64/fpsimd: Avoid erroneous elide of user state reload
> >=20
> >  arch/arm64/include/asm/processor.h   |   2 +
> >  arch/arm64/include/asm/simd.h        |  11 +-
> >  arch/arm64/include/asm/thread_info.h |   3 +-
> >  arch/arm64/kernel/fpsimd.c           | 193 ++++++++++++++++++++-------=
--------
> >  4 files changed, 114 insertions(+), 95 deletions(-)
> > ---
> > base-commit: 501e3ddd3ff59f522d9c7a1f2ee993620d5389f9
> > change-id: 20251119-flo-6-1-arm64-fpsimd-test-enablement-67294b3d8f0c
> >=20
> > Best regards,
>=20
> Ok, I've started to integrate those bits over a refresher 6.1 kernel.
> Please see v6.1.y-cip-dovetail-rebase, I had to resolve some conflicts
> again.
>=20
> But as we discussed and as Philippe also pointed out, we need some
> solution for the softirq oob preemption as well, not only in 6.1.
>=20

I revisited this problem today. Seems that we have the same problem in
all Dovetail versions and on all architectures. At least I could not
find something that would prevent the same happening on x86.

Did I miss something?

Florian
