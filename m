Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137120F991
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857938; cv=none; b=jpOiK++otzPzFx0QiUYSv5DWXFRpI+LjTr200Wk+6g/YqQlPp3Z8f8gWLyyYOtr80pOQ78rNTU3oEw9yT5335/7VxjdCWFSqHY1ueqUwy5FJY1t/yBrApdXAIbmxNEwKUow3UYx5J/mKrDH5BAyHuEiipHlERuJJLKhY0NhgXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857938; c=relaxed/simple;
	bh=cGETXJdlzzjjwQljszSOhUa2brYGDzRNKFQmjv5GujM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6DOEUZHIrCO+VJq51J9EgUfkpqH8BuldbYiTP3zpuI8J7ldeBFisjlDhyEg0dfa8ZJ72qSXTUr2bb7PhMxosVhIJpVSVVWFqfhZd8Ld9cXDm6tJuivSbyzqKpia4UoE2ozsTnnuyu1Un7rjjp2CkHSLGhD3tgqX7RQEXWvVYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=tN4NtHR+; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="tN4NtHR+"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250114123210698d128df87ba3436b
        for <xenomai@lists.linux.dev>;
        Tue, 14 Jan 2025 13:32:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fZLUe/QRD0QWENLUPuH7ZEHWlbJfmSh1F7/1n+mFEJ4=;
 b=tN4NtHR+58ZQJSlHbuJaXklK5WAbJctCc+u19TXlNRTHbaFVyW5r5eiwvUGA5Lo1JYfRLI
 SM57ZUaYelPlFz0JDEm7P8LHyCmv2D5Yq3QTbkU53nmrvAQX3CKQpTdp/lBeaFJbVP2JrwWZ
 H6E1ERPmJF/jEiiIR0NCYqPFU00alCwNzebG1bLGqvqzshy1YoHGcpFmuKAFjJ66947kH/Gl
 shWXS5F3/SfgQlVJLQKoQyrticj6j52n3i6Ob1xn11rsRMJO0efmq6H/SrNXluiGJmb+3XqT
 Yx+NbD0DZmYTdA78sqFooJCicJFrDOp74YayZCjYIjvTCxcPfqCeIIVw==;
Message-ID: <525144fb4682062710c34cae20a8bbc39e31db8c.camel@siemens.com>
Subject: Re: [PATCH] y2038: lib/cobalt: vdso: Fix runtime error detected on
 arm/arm64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, =?ISO-8859-1?Q?L=E9o?= BRIAND
	 <leo.briand@smile.fr>, xenomai@lists.linux.dev
Date: Tue, 14 Jan 2025 13:32:09 +0100
In-Reply-To: <f9635d3a-6831-436e-bc01-b5d033318b04@siemens.com>
References: <20250113141003.3146947-1-leo.briand@smile.fr>
	 <f9635d3a-6831-436e-bc01-b5d033318b04@siemens.com>
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

On Tue, 2025-01-14 at 13:22 +0100, Jan Kiszka wrote:
> On 13.01.25 15:10, L=C3=A9o BRIAND wrote:
> > Issue:  Runtime error on arm64 application:
> >=20
> >         root@ls1046ardb:~# latency
> >         latency: __vdso_clock_gettime64 not found in vDSO: No such file=
 or directory
> >=20
> > Reason: Due to changed __USE_TIME_BITS64 behavior the vDSO init fails.
> >=20
> > Fix: Adjust the vDSO configuration to correctly handle the selection of
> > `__vdso_clock_gettime64` or `__kernel_clock_gettime` depending on the e=
nvironment.
> >=20
> > Impact: Resolves runtime errors on ARM64 platforms caused by incorrect =
vDSO function
> > selection, ensuring compatibility with 64-bit and compatibility tasks.
> >=20
>=20
> Thanks for the fix.
>=20
> Under which higher-level conditions is this biting us? Does it need
> specific defaults of the toolchain, certain versions of certain libcs?
> Do we need to expand our test matrix?

See
https://source.denx.de/Xenomai/xenomai/-/commit/db203dc68964235b1c6b549bfaa=
2c3b88f736814

I looked at the testing part when doing some "forward tests". The
result was that it's not that easy to add a single test job build
against a different Debian version (trixie) which ships a glibc >=3D
2.40.

But it's doable if we want to test against the upcoming Debian release
as well.

Florian


>=20
> Jan
>=20
> > Signed-off-by: L=C3=A9o BRIAND <leo.briand@smile.fr>
> >=20
> > diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobal=
t/arch/arm/include/asm/xenomai/time.h
> > index 1b4947b2d..c260acf46 100644
> > --- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
> > +++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
> > @@ -12,7 +12,7 @@
> > =20
> >  #define COBALT_VDSO_VERSION	"LINUX_2.6"
> > =20
> > -#ifdef __USE_TIME_BITS64
> > +#if __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32
> >  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
> >  #else
> >  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
> > diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cob=
alt/arch/arm64/include/asm/xenomai/time.h
> > index 9577aa773..06992e709 100644
> > --- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> > +++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> > @@ -12,7 +12,7 @@
> > =20
> >  #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
> > =20
> > -#ifdef __USE_TIME_BITS64
> > +#if __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32
> >  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
> >  #else
> >  #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center

