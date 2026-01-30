Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837C2BDC0A
	for <xenomai@lists.linux.dev>; Fri, 30 Jan 2026 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769758968; cv=none; b=L7KHoCsv8MO0NS7WBAR4PMrLIC2ZLzos5MsmpQMJNL98gdcPFPpskUf5E/iMvK7AjWH2GOj0ghpb6M0+0NiANI1Bm4WvuTT3IqrSGjG5fI+0f6tL/Lo2Sy1tuwb4ljXhleP31Y2kg5np8PAE9mAnqGsN+gTFByt9ABG7YQr9Uuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769758968; c=relaxed/simple;
	bh=KYbAiOyKVDw3lLpJzew/jsBuJgcYJyiCarLgHaFJcPs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPuR/KYMA8IbDzF/y2/wwNGqWiaF8D9kEFDa9d4evRz1L8BOD9rNjBoIQ3D3hbDw9eEoQ+f2YRq0XUnW13YvtD4RASAJ9lrJ8C3BGJHcbEKNBluXnrsqB+M8vFUb09dtJLT8EX78kxS5Pgq8o+EHHvWvMA9gdp2yCpaEWm6eDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=BqgLeoLW; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="BqgLeoLW"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202601300742346183bbc121000207ed
        for <xenomai@lists.linux.dev>;
        Fri, 30 Jan 2026 08:42:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aVdoe4aWQtQ/ypiL+VnMCoSgzNB05vpYjFQlxJCA1S4=;
 b=BqgLeoLWQ/vlsEo8T+y4G+C2MGhTNU/iIRzcmmBnoGlJnicJ5UoEhYDRGWXsGgZUoDW1RV
 dqlf9WGBsqCGQzJknPj2dDoNZFePPpQTbxCeO0/rdg307N7RdPdYEdcBgwT9ue0M6llMJPqI
 q1oirkG9NE7heXryaE6kHTpX8lgUr6wOT5wnivzN9eNd+opRDColRFHBudzNb5pQVihkJs5A
 L+58OhTOMdlReFZnUyuN7q30O+/J/SijbtlUrgpqeFrt+HcnuN35axov/McftgdrbxmCFWpX
 LJRsa6EwBKpbr2SWNudJxtPbubcyj+aSQ2cv21q7heP25+s3s0J2jQ3g==;
Message-ID: <fba6f379235e6cd97e1a2fd3ec366da852da4ea1.camel@siemens.com>
Subject: Re: [PATCH] lib/cobalt: Avoid making mmap offset argument
 unconditionally 64-bit
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Fri, 30 Jan 2026 08:42:34 +0100
In-Reply-To: <7303ef50-ae85-4fe2-99bf-cdac90a10c63@siemens.com>
References: <7303ef50-ae85-4fe2-99bf-cdac90a10c63@siemens.com>
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

On Fri, 2026-01-30 at 08:18 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> When _FILE_OFFSET_BITS is 64, mmap is handled by the mmap64 symbol of
> glibc. The original mmap continues to expect native off_t size, i.e.
> 32 bits on 32-bit archs.
>=20
> While we require applications to be rebuilt with the same settings
> Xenomai was built with as well (either both _TIME_BITS and
> _FILE_OFFSET_BITS set to 64 or both left unset) which practically
> shadows this issue, it remains wrong to change the wrapped mmap function
> in a was that is incompatible with glibc.

The main point here is that we want to serve both (__USE_FILE_OFFSET64
=3D=3D 64 and __USE_FILE_OFFSET64 =3D=3D 32) worlds within one libcobalt bu=
ild.

That was indeed silently changed by the commit below as building with
_FILE_OFFSET_BITS =3D 64 left no 32 bit variant alive.

>=20
> Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disab=
le-y2038")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  lib/cobalt/Makefile.am | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
> index 4318adf185..fef2ec9b69 100644
> --- a/lib/cobalt/Makefile.am
> +++ b/lib/cobalt/Makefile.am
> @@ -7,9 +7,12 @@ noinst_HEADERS =3D	\
> =20
>  lib_LTLIBRARIES =3D libcobalt.la libmodechk.la
> =20
> +noinst_LTLIBRARIES =3D libcobaltext.la
> +
>  libcobalt_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@ -version-info 2:0:0 -lpthrea=
d -lrt
> =20
>  libcobalt_la_LIBADD =3D \
> +	libcobaltext.la
>  	arch/@XENO_TARGET_ARCH@/libarch.la	\
>  	../boilerplate/libboilerplate.la
> =20
> @@ -24,7 +27,6 @@ libcobalt_la_SOURCES =3D		\
>  	mutex.c			\
>  	parse_vdso.c		\
>  	printf.c		\
> -	rtdm.c			\
>  	sched.c			\
>  	select.c		\
>  	semaphore.c		\
> @@ -35,14 +37,24 @@ libcobalt_la_SOURCES =3D		\
>  	timer.c			\
>  	timerfd.c		\
>  	trace.c			\
> -	umm.c			\
> -	wrappers.c
> +	umm.c
> =20
>  libcobalt_la_CPPFLAGS =3D			\
>  	@XENO_COBALT_CFLAGS@		\
>  	-I$(top_srcdir)/include/cobalt	\
>  	-I$(top_srcdir)/include
> =20
> +# source files that require native off_t size
> +libcobaltext_la_SOURCES =3D	\
> +	rtdm.c			\
> +	wrappers.c

At least rtdm.c hosts some COBALT_IMPL_TIME64() wrappers. Needs double
checking that we do not disable the time64 bit support for them while
trying to fix behavior around __USE_FILE_OFFSET64.

> +
> +libcobaltext_la_CPPFLAGS =3D		\
> +	@XENO_COBALT_CFLAGS@		\
> +	-I$(top_srcdir)/include/cobalt	\
> +	-I$(top_srcdir)/include		\
> +	-U_TIME_BITS -U_FILE_OFFSET_BITS
> +
>  libmodechk_la_LIBADD =3D libcobalt.la
> =20
>  libmodechk_la_SOURCES =3D	\
> --=20
> 2.51.0
