Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B067221554
	for <xenomai@lists.linux.dev>; Sun,  1 Feb 2026 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769980315; cv=none; b=eJHpZO+qt9BR+VfV73C83EcgC7ckzOCOhh2u/m8vN7gS3OaEvZZ3b+pedlestm7Njd/goMb8PzR841I7zT1VDVXh/IBWec0Jf8rOZUC4C7QA4OIEaDxj/LX5isTZbnsXpWdIPwg2k7qzxxSW3FLDunyFFBjNWjk81ZpnzSdUY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769980315; c=relaxed/simple;
	bh=C5F8IuKIgp0mKszTd2FDJa+B2KAW3GNExZfZFWX5zN0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qc5L//p+pfILK6b8SKfMAdC5m9sOYT9rRkflKHiwvMMeDlb+QbQLooC+a2JgD0dJTJJr815CoP+exwetTG3yoSk+3BS3xKP+JuREnz7zjao0TWnYQEkhavb22KtUU2eVSsB4/IoOi+PfdNhpgFn3RWidcbLBsP77Rbb0hrm6qug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YQOJWGo7; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YQOJWGo7"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260201211141f49b5fcc5c000207bf
        for <xenomai@lists.linux.dev>;
        Sun, 01 Feb 2026 22:11:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7uE3+NPtwtmDM5+qdL/udrEsB0aa92UCc8rZAEReqqs=;
 b=YQOJWGo7CsKIx19aBgxQ714zC2FZijT40y9IV8+/q5WfAYsFATqA5D1h2sRXz3W4nwLoBh
 Mn/UlXeSi1LM8+0hbKvUnH84ZNk9TDWxXD+iWNF2gnco2D3tlu804WIrznPforA1ZseoXdbh
 kU/iSwwcHHqazSLPXgGAHkqCX2TP6q/Kj2abQdE4bmJxNWO4txibOx10I0cV8MSwLj12A2Pd
 LQcikVK0EiD0b3jcjKDt2YsIupIeLT/PpVWjSpo0sn3mRvYa7mm4ff21yYD1XXvKi3N259ko
 yQ9Np2TMGQUvZxE9sD9uS0vTPD+IyUTrFxRI17JfciKXGX3rTCzu3QpQ==;
Message-ID: <51f29e5883cf0adf7e671a9c6eba0668eddadc17.camel@siemens.com>
Subject: Re: [PATCH v2] lib/cobalt: Avoid making mmap offset argument
 unconditionally 64-bit
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Sun, 01 Feb 2026 22:11:40 +0100
In-Reply-To: <0b60192d-053e-4ba4-96bc-2d60b5a8e464@siemens.com>
References: <0b60192d-053e-4ba4-96bc-2d60b5a8e464@siemens.com>
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

On Sun, 2026-02-01 at 10:36 +0100, Jan Kiszka wrote:
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
       ^^^
way?

>=20
> To avoid running into conflicts between enabling and disabling
> _TIME_BITS=3D64 and, thus, also _FILE_OFFSET_BITS=3D64, factor out the
> affected mmap wrappers as well as their __real stubs into a separate
> code module.

Is mmap() the only wrapper that we implement that is affected by this?

>=20
> Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disab=
le-y2038")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Changes in v2:
>  - factor out 32-bit off_t code into separate module
>  - add missing libcobaltext_la_LDFLAGS
>  - and v1 was completely broken...
>=20
>  lib/cobalt/Makefile.am | 15 ++++++++
>  lib/cobalt/mmap.c      | 79 ++++++++++++++++++++++++++++++++++++++++++
>  lib/cobalt/rtdm.c      | 38 --------------------
>  lib/cobalt/wrappers.c  | 17 ---------
>  4 files changed, 94 insertions(+), 55 deletions(-)
>  create mode 100644 lib/cobalt/mmap.c
>=20
> diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
> index 4318adf185..ed7e503899 100644
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
> +	libcobaltext.la				\
>  	arch/@XENO_TARGET_ARCH@/libarch.la	\
>  	../boilerplate/libboilerplate.la
> =20
> @@ -43,6 +46,18 @@ libcobalt_la_CPPFLAGS =3D			\
>  	-I$(top_srcdir)/include/cobalt	\
>  	-I$(top_srcdir)/include
> =20
> +# source files that require native off_t size
> +libcobaltext_la_SOURCES =3D	\
> +	mmap.c
> +
> +libcobaltext_la_LDFLAGS =3D @XENO_LIB_LDFLAGS@
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
> diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
> new file mode 100644
> index 0000000000..069163a855
> --- /dev/null
> +++ b/lib/cobalt/mmap.c
> @@ -0,0 +1,79 @@
> +/*
> + * Copyright (C) 2005 Jan Kiszka <jan.kiszka@web.de>.
> + * Copyright (C) 2005 Heikki Lindholm <holindho@cs.helsinki.fi>.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> +
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> +  USA.
> + */

Should we switch to SPDX for new files?

> +
> +#include <sys/mman.h>
> +#include <rtdm/rtdm.h>
> +#include <cobalt/uapi/syscall.h>
> +#include <asm/xenomai/syscall.h>
> +
> +COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int fl=
ags,
> +			     int fd, off64_t offset))
> +{
> +	struct _rtdm_mmap_request rma;
> +	int ret;
> +
> +	if (fd < 0) /* We don't do anonymous mappings. */
> +		goto regular;
> +
> +	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
> +	rma.length =3D length;
> +	rma.offset =3D offset;
> +	rma.prot =3D prot;
> +	rma.flags =3D flags;
> +
> +	ret =3D XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
> +	if (ret !=3D -EADV && ret !=3D -ENOSYS) {
> +		if (ret) {
> +			errno =3D -ret;
> +			return MAP_FAILED;
> +		}
> +
> +		return addr;
> +	}
> +
> +regular:
> +#if mmap64 =3D=3D mmap
> +	return __STD(mmap(addr, length, prot, flags, fd, offset));
> +#else
> +	return __STD(mmap64(addr, length, prot, flags, fd, offset));
> +#endif
> +}
> +
> +COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flag=
s,
> +			   int fd, off_t offset))
> +{
> +	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
> +}
> +
> +__weak
> +void *__real_mmap(void *addr, size_t length, int prot, int flags,
> +		  int fd, off_t offset)
> +{
> +	return mmap(addr, length, prot, flags, fd, offset);
> +}
> +
> +#if mmap64 !=3D mmap
> +__weak
> +void *__real_mmap64(void *addr, size_t length, int prot, int flags,
> +		  int fd, off64_t offset)
> +{
> +	return mmap64(addr, length, prot, flags, fd, offset);
> +}
> +#endif

I assume there is a reason, but I don't have it at hand right now... Why
do we actually implement the __real_ stuff again? That should be auto-
generated by the linker.

Maybe to catch "misconfigured" applications? If compiled without the
wrapper configuration the build might fail. Just a guess... Might happen
if users bypass xeno-config.

> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 00c1aaf4b2..119ba3f83d 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -541,41 +541,3 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
> =20
>  	return __STD(shutdown(fd, how));
>  }
> -
> -COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int fl=
ags,
> -			     int fd, off64_t offset))
> -{
> -	struct _rtdm_mmap_request rma;
> -	int ret;
> -
> -	if (fd < 0) /* We don't do anonymous mappings. */
> -		goto regular;
> -
> -	/* RTDM ignores the address hint, and rejects MAP_FIXED. */
> -	rma.length =3D length;
> -	rma.offset =3D offset;
> -	rma.prot =3D prot;
> -	rma.flags =3D flags;
> -
> -	ret =3D XENOMAI_SYSCALL3(sc_cobalt_mmap, fd, &rma, &addr);
> -	if (ret !=3D -EADV && ret !=3D -ENOSYS) {
> -		ret =3D set_errno(ret);
> -		if (ret)
> -			return MAP_FAILED;
> -
> -		return addr;
> -	}
> -
> -regular:
> -#if mmap64 =3D=3D mmap
> -	return __STD(mmap(addr, length, prot, flags, fd, offset));
> -#else
> -	return __STD(mmap64(addr, length, prot, flags, fd, offset));
> -#endif
> -}
> -
> -COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int flag=
s,
> -			   int fd, off_t offset))
> -{
> -	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
> -}
> diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
> index 18c237734f..3a0063f051 100644
> --- a/lib/cobalt/wrappers.c
> +++ b/lib/cobalt/wrappers.c
> @@ -28,7 +28,6 @@
>  #include <sys/select.h>
>  #include <sys/socket.h>
>  #include <sys/time.h>
> -#include <sys/mman.h>
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <stdlib.h>
> @@ -384,22 +383,6 @@ int __real_select (int __nfds, fd_set *__restrict __=
readfds,
>  	return select(__nfds, __readfds, __writefds, __exceptfds, __timeout);
>  }
> =20
> -__weak
> -void *__real_mmap(void *addr, size_t length, int prot, int flags,
> -		  int fd, off_t offset)
> -{
> -	return mmap(addr, length, prot, flags, fd, offset);
> -}
> -
> -#if mmap64 !=3D mmap
> -__weak
> -void *__real_mmap64(void *addr, size_t length, int prot, int flags,
> -		  int fd, off64_t offset)
> -{
> -	return mmap64(addr, length, prot, flags, fd, offset);
> -}
> -#endif
> -
>  __weak
>  int __real_vfprintf(FILE *stream, const char *fmt, va_list args)
>  {
> --=20
> 2.51.0
