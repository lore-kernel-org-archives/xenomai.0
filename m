Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CA140E34
	for <xenomai@lists.linux.dev>; Sun,  6 Jul 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751834728; cv=none; b=EYY4N3Gu7zuFTZqzx/kki02ttYuj67OAOEmBOOlmgVEJfbnMg4t4k308oiZk6u5huUy0IYtpVxpptIwwH2HGevTqW+dxYfMOob6wJT1vaGig2t7R5NDO1UTKSEbdtAFr6fyK9hDE5PtrVjpjLakjSbPGRNRnSlVlXPeunW5RXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751834728; c=relaxed/simple;
	bh=XAkxcS/4a2PrSh7Brf8PByLwenZhDunVttZo8GzusFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WV9th3tDamDRyCwlrmvy5gfYRdw6M8EF2o6RjLWY5Rr3BZLvyZITwkE1lIoMLrvTi7i7vqUi4lp1G/srFBqY8KTiRZWzvdgIuhG0l80JjE297Zqq3lCKiiTQP/3gd3fjz2A7agWhjUv+jjeA+Q0+j22xmfxav3D9EfYRfxhZoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZalCDGP4; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZalCDGP4"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250706203504b262a0cd6d60297f5b
        for <xenomai@lists.linux.dev>;
        Sun, 06 Jul 2025 22:35:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UO+T/BxZl5QgP1u6gQXVSYdQra/yZb1ePSoSAy/6ahw=;
 b=ZalCDGP44oLpoVrHIY/BNYGJGDKhyWft1j2Na1RPMR7ZG7lXALzVZrifu2AJQS+cFGweBv
 KnjqUAFsGVflP6gmR8OcwFV+ToYOIlaYr7QI2jO59DeR2FsasbiS7nbM/5eEd0o6eqm+Uiui
 vMjSIxTyYWrLTVFTWr/i9fOrfd4A0e1CRFNm6TZ7/TQs+O6BaO7ZYoudelw85+mIC1O69jPc
 mbD17WhZpjMyDNfCvEPUn/GemrlpAECQHhVFyMZqhgQkYBnRKHSNPGk64My1wXVk7kM2hjsO
 fT9a5IieLVLFqWhSA5UJ36dEpy2v+5nVvylY1xXl2XiV7dSv+rGGsASg==;
Message-ID: <61d4d7521138677983a987639ebf6dad4fe3ae72.camel@siemens.com>
Subject: Re: [PATCH] boilerplate: Replace strncpy with snprintf in
 ancillaries.h
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Haiyang He <aspirestro@163.com>, jan.kiszka@siemens.com
Cc: xenomai@lists.linux.dev
Date: Sun, 06 Jul 2025 22:35:03 +0200
In-Reply-To: <20250705135610.217774-1-aspirestro@163.com>
References: <20250705135610.217774-1-aspirestro@163.com>
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

On Sat, 2025-07-05 at 21:56 +0800, Haiyang He wrote:
> When configure with --enable-registry, it fails to build regd/fs-common.c
> caused by strncpy. Using snprintf instead of strncpy ensures that
> the destination buffer is always null-terminated, preventing potential
> buffer overflow issues and compilation error.

Hm... I have --registry enabled most of the time, so I'm wondering why
I did not face the same problem yet. Some questions below:

>=20
> $ ./configure \
> --host=3Daarch64-linux-gnu \
> --build=3Daarch64-linux-gnu \

So you are building on a native aarch64 machine? That might make a
difference. Does something change if you just remove the two lines
above? The compiler should be selected / detected automatically.

> --enable-smp \
> --enable-pshared \
> --enable-registry \
> --with-core=3Dcobalt \
> CC=3Daarch64-linux-gnu-gcc \
> LD=3Daarch64-linux-gnu-ld \
> CFLAGS=3D"-march=3Darmv8-a" \
> LDFLAGS=3D"-march=3Darmv8-a"

Same problem with the 4 lines above removed?
Just wondering if we set a nasty flag somewhere that breaks the object
size detection of your compiler.

>=20
> $ cat /etc/lsb-release
> DISTRIB_ID=3DUbuntu
> DISTRIB_RELEASE=3D22.04
> DISTRIB_CODENAME=3Djammy
> DISTRIB_DESCRIPTION=3D"Ubuntu 22.04.5 LTS"
>=20
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0

I have no aarch64 machine for compile-testing at hand so I tried the
following (cross-) combinations:

x86:
- gcc 10 (from Debian 12): already fine
- gcc 12 (from Debian 12): already fine
- gcc 15 (from Fedora 42): already fine

aarch64:
- gcc 10 (cross, from Debian 12): already fine
- gcc 12 (cross, from Debian 12): already fine

Result: Unable to reproduce...

>=20
> The output of build error:
>=20
> make[3]: Entering directory '/root/xenomai-next/xenomai-next-build/lib/co=
pperplate/regd'
>   CC       regd.o
>   CC       fs-common.o
>   CC       fs-cobalt.o
> In file included from /usr/include/string.h:535,
>                  from /root/xenomai-next/xenomai-next/include/copperplate=
/heapobj.h:24,
>                  from /root/xenomai-next/xenomai-next/lib/copperplate/reg=
d/fs-common.c:27:
> In function 'strncpy',
>     inlined from 'open_heaps' at /root/xenomai-next/xenomai-next/lib/copp=
erplate/regd/fs-common.c:248:3:
> /usr/include/aarch64-linux-gnu/bits/string_fortified.h:95:10: error: '__b=
uiltin_strncpy' output may be truncated copying 31 bytes from a string of l=
ength 31 [-Werror=3Dstringop-truncation]
>    95 |   return __builtin___strncpy_chk (__dest, __src, __len,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    96 |                                   __glibc_objsize (__dest));
>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  include/boilerplate/ancillaries.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/boilerplate/ancillaries.h b/include/boilerplate/anci=
llaries.h
> index c8c209deb..8de353ce8 100644
> --- a/include/boilerplate/ancillaries.h
> +++ b/include/boilerplate/ancillaries.h
> @@ -36,8 +36,7 @@ void __namecpy_requires_character_array_as_destination(=
void);
>  	({								\
>  		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
>  			__namecpy_requires_character_array_as_destination();	\
> -		strncpy((__dst), __src, sizeof(__dst));			\
> -		__dst[sizeof(__dst) - 1] =3D '\0';			\
> +		snprintf((__dst), sizeof(__dst), "%s", (__src));	\
>  		__dst;							\
>  	 })
> =20
> --=20
> 2.34.1
