Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B315DBC1
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062666; cv=none; b=hAZxeM7jNKA4L7JNy4LmJ7xzdeGDJDOU9leNIA94u5Deel9kkTGstTL0rjHlX54eRE9SEi7inJEgAfEFuY4KQ9xXiSIQvR4G77ZjbCQZHOF6bpXXoCclX7HGtMUabZS0GurCoNnRW9VCGKimOfS4W9TvRCYg0mNUoWKwMbPgpqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062666; c=relaxed/simple;
	bh=DNWPLhPthzWqtzDEkCgr5n+wDK9CtL5lO7Tq/OZy0IU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHC1cP+ICo8JITD4S1/t20q3VL2nPHiNtxEZCUOjjM73i0ZW+EO2mYL4ok0ed8fTkYJQxiaHx5MrYzZOq3j2c9eVcQilh54Zb0N6tqa13pR0BYwGQWINrGdqfPzcyPR+dvvn2Fe1z/W/Kd8J5ey0il/u07rXjLn8euvoh1ctRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=C2l0Jm1H; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="C2l0Jm1H"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250905085740e9be74ec4f0002074e
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 10:57:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sEO+kfPBv9cdcG3Q5MXg+l920Uo2HYbZBcdNe9v/XfI=;
 b=C2l0Jm1H/FTP8veICeyZwobLeXrsfhz2SvWIMJPFk9X8zhr191jMIsnCghDw1WQ/LTyFTX
 1sdftq1Ks10TOJWo2Lt7fYKQ6IglLXQLOaBw3Y4qGqn4Ur7EXsuaKkgdQ5wVga/codEaCPbA
 +cytWkXEKLKHqFpZ6UBGVkk19mZJ4DPxDQM9aIaLXSMR4SCuo1nfYb0MaO7Ow0AXmjPsc6eJ
 C4UTc3Xcc/tdKSdgLSVpfjhWCMl0s7YAKrWD4rFHSyZLpN7ygaN1g08JUM2gJin15ombJjKB
 uZaY3tCQuzxzna4rtGt4Q5goyIpTR3mmFTifDjsqCeh2A6hcKxYqweiA==;
Message-ID: <859bc0fc07c6972d566f6e658f81c2711194978a.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH v2] ci: Retry LAVA boot action up to
 three times
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Jan Kiszka
	 <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
Date: Fri, 05 Sep 2025 10:57:39 +0200
In-Reply-To: <4fb68229ddaa695d640a5ebd03e415e0e50f2a67.camel@siemens.com>
References: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
		 <def91a5f-1642-4374-8498-9863468f115c@siemens.com>
		 <07a52824-3514-41ef-9011-69d344ff4611@siemens.com>
		 <ecd75542-25ce-4beb-b7d5-8c58b2611cf3@siemens.com>
	 <4fb68229ddaa695d640a5ebd03e415e0e50f2a67.camel@siemens.com>
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

On Fri, 2025-09-05 at 10:39 +0200, Florian Bezdeka wrote:
> On Fri, 2025-09-05 at 10:24 +0200, Tobias Schaffner wrote:
> > On 04.09.25 17:33, Jan Kiszka wrote:
> > > On 04.09.25 12:16, Jan Kiszka wrote:
> > > > On 04.09.25 12:03, Tobias Schaffner wrote:
> > > > > Increase test robustness by retrying the LAVA boot action up to t=
hree
> > > > > times on failure. Failures are detected via server-side error mes=
sage
> > > > > matching. This logic will be refined in the designated repository=
.
> > > > >=20
> > > > > Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> > > > > ---
> > > > >   tests/jobs/xenomai-beagle-bone-black.yml | 1 +
> > > > >   tests/jobs/xenomai-hikey.yml             | 1 +
> > > > >   tests/jobs/xenomai-rpi4.yml              | 1 +
> > > > >   tests/jobs/xenomai-x86-64-efi.yml        | 1 +
> > > > >   4 files changed, 4 insertions(+)
> > > > >=20
> > > > > diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/job=
s/xenomai-beagle-bone-black.yml
> > > > > index 8e47dd6..b7a95bc 100644
> > > > > --- a/tests/jobs/xenomai-beagle-bone-black.yml
> > > > > +++ b/tests/jobs/xenomai-beagle-bone-black.yml
> > > > > @@ -41,6 +41,7 @@ actions:
> > > > >         compression: gz
> > > > >   # BOOT_BLOCK
> > > > >   - boot:
> > > > > +    failure_retry: 3
> > > > >       timeout:
> > > > >         minutes: 5
> > > > >       method: u-boot
> > > > > diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hi=
key.yml
> > > > > index aaf8949..27beb07 100644
> > > > > --- a/tests/jobs/xenomai-hikey.yml
> > > > > +++ b/tests/jobs/xenomai-hikey.yml
> > > > > @@ -40,6 +40,7 @@ actions:
> > > > >         compression: gz
> > > > >   #  BOOT_BLOCK
> > > > >   - boot:
> > > > > +    failure_retry: 3
> > > > >       timeout:
> > > > >         minutes: 5
> > > > >       method: u-boot
> > > > > diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi=
4.yml
> > > > > index 50ff9ee..4074825 100644
> > > > > --- a/tests/jobs/xenomai-rpi4.yml
> > > > > +++ b/tests/jobs/xenomai-rpi4.yml
> > > > > @@ -40,6 +40,7 @@ actions:
> > > > >         compression: gz
> > > > >   #  BOOT_BLOCK
> > > > >   - boot:
> > > > > +    failure_retry: 3
> > > > >       timeout:
> > > > >         minutes: 5
> > > > >       method: u-boot
> > > > > diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenom=
ai-x86-64-efi.yml
> > > > > index 4f1a7d8..0014429 100644
> > > > > --- a/tests/jobs/xenomai-x86-64-efi.yml
> > > > > +++ b/tests/jobs/xenomai-x86-64-efi.yml
> > > > > @@ -41,6 +41,7 @@ actions:
> > > > >         compression: gz
> > > > >   # BOOT_BLOCK
> > > > >   - boot:
> > > > > +    failure_retry: 3
> > > > >       timeout:
> > > > >         minutes: 5
> > > > >       method: ipxe
> > > >=20
> > > > Thanks, applied.
> > > >=20
> > >=20
> > > I think we were retrying here, but it did not help :(
> > >=20
> > > https://gitlab.com/Xenomai/xenomai-images/-/jobs/11248170239
> >=20
> > It looks like LAVA is only making two attempts.
> >=20
> > On the first attempt, the job runs into a timeout. This could have been=
=20
> > caught earlier if the U-Boot soft reboot was detected correctly. In the=
=20
> > log, it appears as "must RESET the board to recover", but our pattern i=
s=20
> > looking for "Must RESET board to recover" with a capital M, so it=20
> > doesn=E2=80=99t match. This has to be fixed in the .jinja2 config on th=
e server.
>=20
> Hm. The settings is inherited from
> /usr/share/lava-server/device-types/base.jinja2
>=20
> a very "basic" LAVA configuration file. Which version of U-Boot is
> deployed on the board? Maybe something very old and the message was
> updated meanwhile?
>=20
> Should be doable to overwrite / add another error message.=C2=A0
>=20
> @Quirin, do you want to take over?

Just realized that there is a device reset ongoing, triggered by u-boot
because the device tree could not be loaded.

2025-09-04T15:24:53 ERROR: root node setup failed
2025-09-04T15:24:53  - must RESET the board to recover.
2025-09-04T15:24:53=20
2025-09-04T15:24:53 FDT creation failed!
2025-09-04T15:24:53 resetting ...

The problem is, that the board is now booting into whatever is deployed
to the EEMC:

2025-09-04T15:24:53 U-Boot SPL 2022.04-ge0d31da5 (Aug 04 2023 - 18:48:26 +0=
000)
2025-09-04T15:24:53 Trying to boot from MMC1
...
2025-09-04T15:24:54 Reset Source: Global warm SW reset has occurred.

Which is not what we expect.

The problem starts with:
2025-09-04T15:24:50 ERROR: reserving fdt memory region failed (addr=3D10000=
0000 size=3D30000000d flags=3D0)

The job is successful after a retry? If so, is the memory of this board
really ok? No overlap between kernel/initrd/device tree?

>=20
> >=20
> > I=E2=80=99ll take a closer look at why LAVA ends with
> > error_msg: 2 retries out of 3 failed for uboot-action.
> > It should have attempted three times.
> >=20
> > Ideally, we also find a way to make the boot process itself more stable=
,=20
> > rather than relying only on retries.
> >=20
> > > Jan
> > >=20
