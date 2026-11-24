Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532733;
	b=Ggg9tw7RjLNcp9zD3hGl9+qZ8FF/7oB9+cV1HokeY3mUQ1dIQaup/dA6nAE9q7nCmZRV
	 wJ+jI0N2z2pAczC7i7adZn2XoqGD8c9QFwVdI/z0nlB8lhWb+5YLwR8TWWYguuQigbtQt
	 hnMEEtz4YdQKtwFmcX5/DpF8rgzgRjWyE/6DAneKwE+adR4voeg3OrpNQVQNgWErEusT5
	 9BmfF3v740UmEBSqbQGwvTTFsAfs9Ps9W4PtEeaV4QWZZ+hMrjDWBn14YgmJK/drWOqOX
	 PSSJGLxi0FQwnPtKNPLb+xXgF7K5Qzm1dw2b7tX06JHueYXXxuwRIJuBq+KmKCdIaHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532733;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=JkmEyPUtD/Ru1HkFDWMH/jUS8pP5wxbnASFOuwBgT/c=;
	b=pwNKEpTg7kFbORXJxzKcGy5Q2Al5W2xI5SWEj+6TMNH0MFjMTtJg7sIbAJr2Qlni/H/i
	 3A7WoVycqrL3iWTMpKpSheDV5hqWL3xZCaSkMEmhnsgYRb2qnQxDEMIQ5bqkfEMiCaoBG
	 UNhkMqnQS3NHYZXG/667HpKa6sRxko8gsY8giPHMwxZcvItkQAv1sHmtD5+MxMGZWrDGH
	 /R01Rvjd1Skq/jt/Zv9EwPdzw1xvuiB7qAqTlx9bfqStx5AZ4Wr7oBGjRK7vM+VlsruLk
	 OEB4vfS5GuK1FN5vOkQILubFruhR1NhRp8TKHqywE0pgSWj8+X6j+PFNv/0K6ImTP/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b="XVlTwj9/";
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12682606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 15:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12682606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=XVlTwj9/
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 2376778035E;
	Tue, 24 Nov 2026 16:05:20 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=XVlTwj9/;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6AOF5JFa3460276;
	Tue, 24 Nov 2026 16:05:19 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1795532720;
	bh=pf4dq7fNRPvB6pmztczg3HgyGodkKfUmJd2iTOvdCWM=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=XVlTwj9/s+mwsI0rNZiul3wT67OXndaSm5lBaMOgP/hNAaBGTiXKPQuxP9VU+OZ43
	 iVjc7E8gTf4+fO0gfAMAIFIcljw4e95JlFwp9RSjpN9k3zJ5TUw+i6F5cAc0Z6jq+u
	 qj/Kz7PNE2jj6HDJq5e4EyaEjYnUfHoXXQCOuDxyOQlu9uCrnzMvajv4CfGQB3BIqJ
	 lP2GJtldxlxWULlDpi4JhmOOuDm2ogoTL4hzSum0ve9k++fyxKQYGUkJM3LJ3WOWF1
	 9EUpioU68KhNXy3OgrK9y2+5FxKZVkFwNpazLh8LQCb6L1p1L1QQqAK6fzQkt0+S6z
	 C2EQdJs2yLWew==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <d0919a84-e71f-4e08-86e3-8900b30f9e5f@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Tue, 24 Nov 2026 16:05:19 +0100
Cc: "Xenomai" <xenomai@lists.linux.dev>,
        "Florian Bezdeka" <florian.bezdeka@siemens.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <1207-6b05a780-75-3e404bc0@80415301>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?lib/cobalt=3A?= Let 
 =?utf-8?q?=5F=5FSTD()?= and =?utf-8?q?=5F=5FRT()?= of mmap follow the 
 =?utf-8?q?off=5Ft?= redirection
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Mardi, Novembre 24, 2026 13:59 CET, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> With =5FFILE=5FOFFSET=5FBITS=3D64, glibc redirects mmap() to mmap64()=
 on 32-bit
> archs. Applications get this setting by default since y2038 support w=
as
> added, as xeno-config passes it along with =5FTIME=5FBITS=3D64, and s=
ome
> toolchains even predefine both (e.g. Debian armhf). uClibc-ng enforce=
s
> 64-bit file offsets unconditionally since release 1.0.58.
> 
> =5F=5FSTD(mmap()) and =5F=5FRT(mmap()) do not follow this redirection=
: they
> expand to =5F=5Freal=5Fmmap() and =5F=5Fcobalt=5Fmmap(), declared wit=
h the 64-bit
> off=5Ft of the caller. But with the Cobalt wrappers, =5F=5Freal=5Fmma=
p() binds
> to the libc's mmap(), and =5F=5Fcobalt=5Fmmap() is built with native =
off=5Ft,
> so both take a 32-bit offset. They read it from the padding word in
> front of the 64-bit argument and fail with EINVAL or map the wrong
> page.
> 
> Internal users built with 64-bit off=5Ft are affected as well:
> cobalt=5Funmap=5Fumm(), the pshared heap of copperplate and the TLSF =
pool
> of boilerplate all bind to the native-off=5Ft =5F=5Freal=5Fmmap() of =
libcobalt.
> 
> Add COBALT=5FDECL=5FOFF64(), which redirects the =5F=5FSTD(), =5F=5FR=
T() and
> =5F=5FWRAP() symbols of a service to its 64-bit variant whenever the =
libc
> does so, and use it for mmap(). This relies on libcobalt providing
> =5F=5Freal=5Fmmap64(). lib/cobalt/mmap.c implements both variants and=
 opts
> out via =5F=5FCOBALT=5FNO=5FOFF64=5FREDIRECT=5F=5F: building it with =
native off=5Ft is
> not sufficient if the libc enforces 64-bit file offsets.
> 
> Reported-by: Fran=C3=A7ois Legal <francois.legal@eventlab.fr>
> Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --d=
isable-y2038")
> Assisted-by: opencode:Opus-5.5
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/cobalt/sys/mman.h |  6 +++---
>  include/cobalt/wrappers.h | 15 +++++++++++++++
>  lib/cobalt/mmap.c         |  6 ++++++
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
> index e291f50ef..54c028ad9 100644
> --- a/include/cobalt/sys/mman.h
> +++ b/include/cobalt/sys/mman.h
> @@ -28,9 +28,9 @@
>  extern "C" {
>  #endif
>  
> -COBALT=5FDECL(void *, mmap,
> -	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> -	     off=5Ft offset));
> +COBALT=5FDECL=5FOFF64(void *, mmap, mmap64,
> +		  (void *addr, size=5Ft length, int prot, int flags, int fd,
> +		   off=5Ft offset));
>  
>  #if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
>  COBALT=5FDECL(void *, mmap64,
> diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
> index 6d826eedf..9dd022a75 100644
> --- a/include/cobalt/wrappers.h
> +++ b/include/cobalt/wrappers.h
> @@ -45,6 +45,21 @@
>  #define COBALT=5FDECL=5FTIME64(T, FN, FN=5F64, I) COBALT=5FDECL(T, F=
N, I)
>  #endif
>  
> +#if defined(=5F=5FUSE=5FFILE=5FOFFSET64) && !defined(=5F=5FCOBALT=5F=
NO=5FOFF64=5FREDIRECT=5F=5F)
> +/*
> + * Make =5F=5FRT() and =5F=5FSTD() usable in combination with off=5F=
t related
> + * services: the libc redirects them to their 64-bit variants in thi=
s
> + * case, follow suit. Code implementing the native variants opts out=
,
> + * as some libcs enforce 64-bit file offsets (e.g. uClibc-ng).
> + */
> +#define COBALT=5FDECL=5FOFF64(T, FN, FN=5F64, I)                    =
                 \
> +	extern T =5F=5FREDIRECT=5FNTH(=5F=5FSTD(FN), I, =5F=5Freal=5F##FN=5F=
64);                 \
> +	extern T =5F=5FREDIRECT=5FNTH(=5F=5FRT(FN), I, =5F=5Fcobalt=5F##FN=5F=
64);                \
> +	extern T =5F=5FREDIRECT=5FNTH(=5F=5FWRAP(FN), I, =5F=5Fwrap=5F##FN=5F=
64)
> +#else
> +#define COBALT=5FDECL=5FOFF64(T, FN, FN=5F64, I) COBALT=5FDECL(T, FN=
, I)
> +#endif
> +
>  /*
>   * 
>   * Each "foo" Cobalt routine shadowing a POSIX service may be
> diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
> index d30b1722d..bf8772f6a 100644
> --- a/lib/cobalt/mmap.c
> +++ b/lib/cobalt/mmap.c
> @@ -18,6 +18,12 @@
>    USA.
>   */
>  
> +/*
> + * We implement mmap() for the native off=5Ft next to mmap64(): keep=
 their
> + * names apart, even if the libc enforces 64-bit file offsets.
> + */
> +#define =5F=5FCOBALT=5FNO=5FOFF64=5FREDIRECT=5F=5F
> +
>  #include <sys/mman.h>
>  #include <rtdm/rtdm.h>
>  #include <cobalt/uapi/syscall.h>
> -- 
> 2.47.3
 
Hi Jan,

I think this patch needs to fix [1], as it is not linking correctly (at=
 least here for my arm target), because at some point, =5F=5Freal=5Fmma=
p64 goes missing while it should not, because of the #if mmap64 !=3D mm=
ap :

#if mmap64 !=3D mmap
=5F=5Fweak
void *=5F=5Freal=5Fmmap64(void *addr, size=5Ft length, int prot, int fl=
ags,
		  int fd, off64=5Ft offset)
{
	return mmap64(addr, length, prot, flags, fd, offset);
}
#endif

Fran=C3=A7ois

[1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608b6fa712

