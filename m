Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDB31BC82
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523185; cv=none; b=RhT+Oe27RQVdufQzpj7ukUqz1OpY66PXVaiDnnOpb+TV7Ig8dzT3OfOVFHCO7oumMELhk9vWEekz2Sw9P+AesAjj8OnhFi0MQPz2X3mH0YOIUAFOg7ZjmeeQd/dqpz+npnHiOWn8/tHGbAtn4CHLThG8Op5xjbiEhSVIoYo6VcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523185; c=relaxed/simple;
	bh=+vW1iTOOFj7Nf7awDp/FCtf2TvXXlA/NxPW/qjgGhZw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOy1QU8jxPPV5hKVnVweNIW+biKfroMa7NhV5vXNato5QYBIoTlvlk6ke6I6jaRMCPxZu74IoZkYrlJBx1/HAeM0zL2KLiy6WaEJn8eJBYGJh29sZfKaoSQy6mL0Odz5G2jDfLoTXasNuKY8ZGRpONbFWvz8rraFsBmyFSIJL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SsVu4i4K; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SsVu4i4K"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251015101253775d8c6f4100020701
        for <xenomai@lists.linux.dev>;
        Wed, 15 Oct 2025 12:12:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nVr8cNrtCSwvnbgKhhZRwmjqsQwKL5hRxglkCFgwbt8=;
 b=SsVu4i4KCFEkWMjAnFsnV7JGilL3k87yexw0pc6fxSTEmU8T0nmdcvMcA7ddhmtw0X63nR
 3aMyz+87b+aX8feYNPzhRHtfuluQs829so+2VlcNcvVKXVtryQFwTllCgfPeULwA5CyLeazX
 BkRDfKHGryGX5mnrMiGQCGUFru4ZtYt4GOA2NgU7i2JGzcnZiUrVtBXVMcZnouwn43dsRur1
 9Kde3Hiz0+VYCb6klSu7ilZWF50nVeoIakrZO76d2+gMua9x3SbvVFfRPsJhIDaOhlaRD1UG
 0P3njv4wWVU7pqrGaFWnihQCUWxGzfO/7VQE1KIGETss7HIDdBCGls/Q==;
Message-ID: <5bc23c9a22cc9ede19d993d0cd63991acfc8aa0e.camel@siemens.com>
Subject: Re: [PATCH 3/6] arm: fptest: Ensure that fp_regs_set/check
 functions are truly inline
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 15 Oct 2025 12:12:53 +0200
In-Reply-To: <8a6c0009-d926-4da2-90e8-cf644579ff5e@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
	 <f601ea1438f94ac28c28d6eaca0eab2eac0de096.1760374860.git.jan.kiszka@siemens.com>
	 <ab02742a9249b19717a91c33572bad16efed73a2.camel@siemens.com>
	 <8a6c0009-d926-4da2-90e8-cf644579ff5e@siemens.com>
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

On Wed, 2025-10-15 at 10:04 +0200, Jan Kiszka wrote:
> On 15.10.25 09:00, Florian Bezdeka wrote:
> > On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > If they aren't, d8-d15 will be saved/restored, and that is ruining ou=
r
> > > tests.
> > >=20
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 8 +++++--=
-
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h=
 b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
> > > index d5c2c7515b..2b21bc5f55 100644
> > > --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
> > > +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
> > > @@ -20,7 +20,8 @@
> > > =20
> > >  #define __COBALT_HAVE_VFP  0x1
> > > =20
> > > -static inline void fp_regs_set(int features, unsigned int val)
> > > +static inline void __attribute__ ((always_inline))
> > > +fp_regs_set(int features, unsigned int val)
> > >  {
> > >  	unsigned long long e[16];
> > >  	unsigned int i;
> > > @@ -41,8 +42,9 @@ static inline void fp_regs_set(int features, unsign=
ed int val)
> > >  	}
> > >  }
> >=20
> > Could we use the __always_inline macro from Linux here?
> >=20
>=20
> This is (also) userland code (uapi...).

That's clear. I thought __always_inline is available for both worlds,
but that might not be the case for all kernel versions we have here.

Btw: Which path (user or kernel) was the problem? Both or just one of
them?


>=20
> Jan
>=20
> > > =20
> > > -static inline unsigned int fp_regs_check(int features, unsigned int =
val,
> > > -					 int (*report)(const char *fmt, ...))
> > > +static inline unsigned int __attribute__ ((always_inline))
> > > +fp_regs_check(int features, unsigned int val,
> > > +	      int (*report)(const char *fmt, ...))
> > >  {
> > >  	unsigned int result =3D val, i;
> > >  	unsigned long long e[16];
> > > --=20
> > > 2.51.0
>=20
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
