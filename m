Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607062;
	b=BSkIugSjdJc/pB88YqRSFfTxZF703AZccElx5ZOr3ZaSO8sVeDy7rT64FNs9JFylc3aX
	 bt1tyQ8k58PeEhRyRKSCaWHChQ44qh6tpDDgBoygGMuMIkHzsIjR8ogdEVDe9wKVdx8pa
	 bG/jGkYNG42boDU/osQOFEWyQ0OW5ml7By9nZgIwDK8WNNbU6buwtcHH9RFMN4liVkmtJ
	 gzDvCeYtF0+oxt9WxVO3Ur6h7l25IhzwWeiWZfMjUVZgOkZsWR2+193Km/lD2QvwFpD7x
	 tHW993UpRYXHFhRJnkNTz5e0HcttCpcdOJ15covV6ZXiixUoT0PpJzgY2mVlVNqvMpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607062;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=agAu2BywOFLbtMTyyy1dTLZWxp6kw5SlDoo+byMvcEg=;
	b=r17DoRL6Fgv9OLE6yHtm4lt6ljR3739tw6C1nwN1gs/XghJla/1NryLZxOAdUNP77hSc
	 1j4NSiykTF2lBDd0ke7AHaz9hvMevXd/4aPVldBO+gz4RZguQfctLXYxI2/skZJIbehXi
	 eYcBoqn2XJlR1n+jcDdwVBlaRVCsfqG5rOcgXa48QtU7Ntqk8RwTi0utIXZATHxI5Pj64
	 ZXRTO5ixocW1Ou40VrJirJ4j18X5fFErV9e/px7eK37OzaSHuqT+B0OZkgUQqg/l7YwdS
	 HkfkHEu21MTFdEJt+NVIprBhoNO097Cm8GcRwP9AnltAn3fY3wr8hcJg/G3cgtX2qbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=IgYOwI54;
	arc=none smtp.remote-ip=185.136.64.226
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1A606A321
	for <xenomai@lists.linux.dev>; Wed, 25 Nov 2026 11:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA1A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=IgYOwI54
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261125114418c2827f29eb000207b7
        for <xenomai@lists.linux.dev>;
        Wed, 25 Nov 2026 12:44:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=agAu2BywOFLbtMTyyy1dTLZWxp6kw5SlDoo+byMvcEg=;
 b=IgYOwI54Xi7n5OUEqtQjfviM0X5RpttccqqOhHz8XYwH74hrmNPRc6y/Y8+9HDT0rOXN2E
 9QE5q6jNtnW7IOSzGgPpS7bptEU7x0fHRqI4iyquW8f6DZL9629t+tbMGu7CQGzKeLwoj5xV
 1Wu/cSWtXY7WzIygloMfu8nM8tquTpTlJ2Idladf0X3XgR4jfU4b2P6bxpX5AfkYUJH+ZB+i
 2Gi0Ge/BOetscA+t78XfhowoDsHFcTsRhioM/7J0Gpqc1Q1VBELo21jLWPbaVdQlMxeANlha
 WzElIOi8z7tzSHyhPluIPcWGDgMIdd/elnIxlxctcNKVXgX0JfHE3UKw==;
Message-ID: <781b970cdfb894f40872da68e4f95dbe3dbf83c9.camel@siemens.com>
Subject: Re: [PATCH v2 2/3] lib/cobalt: Select the time64 vDSO call without
 __TIMESIZE
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 25 Nov 2026 12:44:17 +0100
In-Reply-To: <20261124145144.3411177-3-yegorslists@googlemail.com>
References: <20261124145144.3411177-1-yegorslists@googlemail.com>
	 <20261124145144.3411177-3-yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2026-11-24 at 15:51 +0100, Yegor Yefremov wrote:
> The clock_gettime() vcall is chosen by checking for __TIMESIZE =3D=3D 32,
> which only glibc defines. uClibc-ng built with time64 support
> (__UCLIBC_USE_TIME64__, as e.g. Buildroot builds it) and musl >=3D 1.2
> define __USE_TIME_BITS64 and use a 64-bit time_t on 32-bit targets, but
> have no __TIMESIZE. libcobalt then picks __vdso_clock_gettime, which
> fills in a 32-bit struct timespec: the seconds and nanoseconds both end
> up in the 64-bit tv_sec of the caller, and tv_nsec is left untouched.
>=20
> Fall back to the size of long if __TIMESIZE is not defined. Nothing
> changes for glibc, and on 64-bit targets.
>=20
> Fixes: fb112c2fdc69 ("y2038: lib/cobalt: Switch vdso to gettime64")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  lib/cobalt/arch/arm/include/asm/xenomai/time.h   | 8 +++++++-
>  lib/cobalt/arch/arm64/include/asm/xenomai/time.h | 8 +++++++-
>  lib/cobalt/arch/x86/include/asm/xenomai/time.h   | 8 +++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobalt/=
arch/arm/include/asm/xenomai/time.h
> index c260acf46..014668b6e 100644
> --- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
> @@ -12,7 +12,13 @@
> =20
>  #define COBALT_VDSO_VERSION=09"LINUX_2.6"
> =20
> -#if __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32
> +/*
> + * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. No=
t
> + * all C libraries define __TIMESIZE (e.g. uClibc-ng and musl), so fall =
back
> + * to the word size.
> + */

Grml... From a userspace perspective we could simply remove the
__TIMESIZE check. That would change the routing for systems with native
64 bit time_t, which would be ok. But: The kernel does not export the
"gettime64" variant on those systems.

Next idea: Remove COBALT_VDSO_GETTIME and do the detection based on
sizeof(time_t). Sadly arm64 has a different name of the native vdso
endpoint, so that we need some kind of arch specific "override", which
is the reason why COBALT_VDSO_GETTIME exists... Obviously not an option.

Not sure if we should really rely on __SIZEOF_LONG__ here.

Anyhow, we have more usages of __TIMESIZE in the code base. I'm sure
this patch is incomplete and further issues will come up while testing.

> +#if __USE_TIME_BITS64 &&=09=09=09=09=09=09\
> +=09(__TIMESIZE =3D=3D 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ =3D=
=3D 4))
>  #define COBALT_VDSO_GETTIME=09"__vdso_clock_gettime64"
>  #else
>  #define COBALT_VDSO_GETTIME=09"__vdso_clock_gettime"
> diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobal=
t/arch/arm64/include/asm/xenomai/time.h
> index 06992e709..d6c5880e0 100644
> --- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> +++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> @@ -12,7 +12,13 @@
> =20
>  #define COBALT_VDSO_VERSION=09"LINUX_2.6.39"
> =20
> -#if __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32
> +/*
> + * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. No=
t
> + * all C libraries define __TIMESIZE (e.g. uClibc-ng and musl), so fall =
back
> + * to the word size.
> + */
> +#if __USE_TIME_BITS64 &&=09=09=09=09=09=09\
> +=09(__TIMESIZE =3D=3D 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ =3D=
=3D 4))
>  #define COBALT_VDSO_GETTIME=09"__vdso_clock_gettime64"
>  #else
>  #define COBALT_VDSO_GETTIME=09"__kernel_clock_gettime"
> diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/time.h b/lib/cobalt/=
arch/x86/include/asm/xenomai/time.h
> index 36e027329..91993d99f 100644
> --- a/lib/cobalt/arch/x86/include/asm/xenomai/time.h
> +++ b/lib/cobalt/arch/x86/include/asm/xenomai/time.h
> @@ -12,7 +12,13 @@
> =20
>  #define COBALT_VDSO_VERSION=09"LINUX_2.6"
> =20
> -#if __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32
> +/*
> + * Use the time64 vcall whenever time_t is 64-bit on a 32-bit target. No=
t
> + * all C libraries define __TIMESIZE (e.g. uClibc-ng and musl), so fall =
back
> + * to the word size.
> + */
> +#if __USE_TIME_BITS64 &&=09=09=09=09=09=09\
> +=09(__TIMESIZE =3D=3D 32 || (!defined(__TIMESIZE) && __SIZEOF_LONG__ =3D=
=3D 4))
>  #define COBALT_VDSO_GETTIME=09"__vdso_clock_gettime64"
>  #else
>  #define COBALT_VDSO_GETTIME=09"__vdso_clock_gettime"
> --=20
> 2.34.1
