Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575622;
	b=S/EjEARnfHf4ouO+zwHb4JkJZqXOebxeCXcxsZxFGs7nyCwLxt5qwVXbeaKv1RTdbnNC
	 2nDhQ8W1FBWmhkOAlrt9VOT/tcATHjN4kIhWVMwK4RK7u7Fdg0wVQgSPSQfAksTnpWUDG
	 6GEbNRCZ1MAecaQQ4DFf5tMqQMYPRdgW8QUe+clc8P2NM8+QgzYffxS+7le4IAF9/vqnX
	 194GznkJ/6nmK+2JmQxKoCNfCpJ32bZ4OSC2esimpTdoU+7vSPgoP2L195NAx1unWZCrq
	 ub+/f2btI98DVrvVMn3xedxLu8SV23Tjq2bO2F7YLwZTP72UFa2iFTYoqjYBbQfOAcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575622;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=7yzWsk4+jvivQ2aEvZWe5LwAKuI2/XjgRdbpFmyHquU=;
	b=lUNndSGQzsrD4kaUv6Q3/fbW0R7PKE7pWoPUKK2pkdgL+O26HEvt9fYBH354gnuvdnBu
	 ysEhW4gx3+1Y/XzgINE28H2sEmDaZvrGD4IQZtXkLIHDMYi5Emk7Nemd0fql40U5bP5jj
	 A1YsUSCKc/jJuH187dwz6xo9ZeTXj/g61ObvPPP+yakHcDFmRu/OG77YhcnHwApy2sk2l
	 pNpJ7LRI8s3Q4e981kpcYsZxP1SW7dqJ4DkEi83OjtERdL2dzryIhE4YBJ3AVulENxTL5
	 gYKuGPA+ObknhHoIoNdjTsJvSaU5xZJF5sc7dtd6O/9ah3wUSCDs5LXSe2neDcafmrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=PN+h1sOJ;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70856606A32D
	for <xenomai@lists.linux.dev>; Fri, 13 Nov 2026 13:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70856606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=PN+h1sOJ
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 11577780383;
	Fri, 13 Nov 2026 14:13:37 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=PN+h1sOJ;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6ADDDad92958644;
	Fri, 13 Nov 2026 14:13:37 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1794575617;
	bh=bU3V5Iw3ZglfirVW5D422k7N537Ax3ADphN6w+zg+cc=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=PN+h1sOJVdFqgFeh0Aq31jLxuaOTIUUhjUHLgtcRn3Wwiyfm6ZixQj+cyBVZJx0UJ
	 OXN7gwioy8igy8BI3J51LagNgeWIS8+JfkKc9GOCGc8wE5IjwoA9ja/K+I7jjcLbpW
	 zN+WYB9p+jacjbqRqzxUGd7W+07+QypzQ0FrCziGs5q2cWGce6UB8QmRhoQf/JsXxY
	 v0j4+ad3XONvdyyvEj3rJqM5ulyU6x27EgJ4dhNUYzqN50nJXwHqsAySWoPcBdTdDE
	 nTnUVKQJ3DLOseLlvniigyTuCfDbrFjBTMWPW+ROAEsRupQBFJ9GMPakmclYEKUS2n
	 GO/518mucWELA==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <b2cf84dd-aaae-4eb5-8fb4-2d5f00594478@web.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 82.64.149.25, 194.9.103.31
Date: Fri, 13 Nov 2026 14:13:36 +0100
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@web.de>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <115efd-6af70d00-3b-36f80d40@101056742>
Subject: =?utf-8?q?Re=3A?= [PATCH] Fixes broken mmap patching on 32bits archs
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Vendredi, Novembre 13, 2026 08:35 CET, Jan Kiszka <jan.kiszka@web.de=
> a =C3=A9crit: 
 
> On 12.11.26 19:11, Fran=C3=83=C2=A7ois Legal wrote:
> > mmap is broken on 32 bits arch when =5F=5FUSE=5FTIME=5FBITS64 and =5F=
=5FUSE=5FFILE=5FOFFSET64 are set
> > in that case, libc translate calls of mmap to mmap64 because file o=
ffset argument is a 64 bit value.
> > We fail to catch that with the decoration logic (=5F=5FSTD/=5F=5FRT=
) and plain libc mmap is called.
> > 
> > Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> > --
> > diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
> > index e291f50ef..b6d650876 100644
> > --- a/include/cobalt/sys/mman.h
> > +++ b/include/cobalt/sys/mman.h
> > @@ -28,16 +28,10 @@
> >  extern "C" {
> >  #endif
> >  
> > -COBALT=5FDECL(void *, mmap,
> > +COBALT=5FDECL=5FOFF64(void *, mmap, mmap64,
> >  	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> >  	     off=5Ft offset));
> >  
> > -#if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
> > -COBALT=5FDECL(void *, mmap64,
> > -	    (void *addr, size=5Ft length, int prot, int flags, int fd,
> > -	     off64=5Ft offset));
> > -#endif
> > -
> >  #ifdef =5F=5Fcplusplus
> >  }
> >  #endif
> > diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
> > index a5645a1d4..82c9aaa69 100644
> > --- a/include/cobalt/wrappers.h
> > +++ b/include/cobalt/wrappers.h
> > @@ -46,6 +46,23 @@
> >  #define COBALT=5FDECL=5FTIME64(T, FN, FN=5F64, I) COBALT=5FDECL(T,=
 FN, I)
> >  #endif
> >  
> > +#if =5F=5FUSE=5FFILE=5FOFFSET64 && =5F=5FWORDSIZE =3D=3D 32
> > +/*
> > + * Make =5F=5FRT() and =5F=5FSTD() usable in combination with time=
64=5Ft related services.
> > + */
> > +#define COBALT=5FIMPL=5FOFF64(T, FN, FN=5F64, I)                  =
                  \
> > +	=5F=5Ftypeof=5F=5F(T) =5F=5Fwrap=5F##FN=5F64 I                   =
                      \
> > +		=5F=5Fattribute=5F=5F((alias("=5F=5Fcobalt=5F" =5F=5Fstringify(F=
N)), weak));     \
> > +	COBALT=5FIMPL(T, FN, I)
> > +#define COBALT=5FDECL=5FOFF64(T, FN, A, I)                        =
                \
> > +	=5F=5Ftypeof=5F=5F(T) =5F=5FSTD(A) I;                            =
                  \
> > +	extern T =5F=5FREDIRECT=5FNTH(=5F=5FSTD(FN), I, =5F=5Freal=5F##A)=
;                     \
> > +	COBALT=5FDECL(T, FN, I)
> > +#else
> > +#define COBALT=5FIMPL=5FOFF64(T, FN, FN=5F64, I) COBALT=5FIMPL(T, =
FN, I)
> > +#define COBALT=5FDECL=5FOFF64(T, FN, FN=5F64, I) COBALT=5FDECL(T, =
FN, I)
> > +#endif
> > +
> >  /*
> >   * 
> >   * Each "foo" Cobalt routine shadowing a POSIX service may be
> > diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> > index 00c1aaf4b..11a6e86e6 100644
> > --- a/lib/cobalt/rtdm.c
> > +++ b/lib/cobalt/rtdm.c
> > @@ -542,7 +542,7 @@ COBALT=5FIMPL(int, shutdown, (int fd, int how))=

> >  	return =5F=5FSTD(shutdown(fd, how));
> >  }
> >  
> > -COBALT=5FIMPL(void *, mmap64, (void *addr, size=5Ft length, int pr=
ot, int flags,
> > +COBALT=5FIMPL=5FOFF64(void *, mmap, mmap64, (void *addr, size=5Ft =
length, int prot, int flags,
> >  			     int fd, off64=5Ft offset))
> >  {
> >  	struct =5Frtdm=5Fmmap=5Frequest rma;
> > @@ -574,8 +574,3 @@ regular:
> >  #endif
> >  }
> >  
> > -COBALT=5FIMPL(void *, mmap, (void *addr, size=5Ft length, int prot=
, int flags,
> > -			   int fd, off=5Ft offset))
> > -{
> > -	return =5F=5FCOBALT(mmap64(addr, length, prot, flags, fd, offset)=
);
> > -}
> > 
> 
> The LLM is not convinced: On 32-bit arm with time64 libs, this versio=
n 
> will map =5F=5FRT(mmap()) to a variant that expects 64-bit off=5Ft, w=
hile a 
> caller which uses 32-bit off=5Ft would rightfully expect mmap to be 3=
2-bit 
> then.

I'm not sure about that. At least with glibc, if we want time64, we nee=
d offset64 too. So under those circumstances off=5Ft is always 64bits l=
ong and glibc forces translation of calls to mmap to calls to mmap64 (u=
sing the =5F=5FREDIRECT=5FNTH macros).

I'll give a try to this proposal anyway, but I have to admit that stick=
ing to what Florian did for the time64 counterpart seemed a better appr=
oach than mixing glibc mangling like this.

Fran=C3=A7ois

> 
> Its counter-proposal:
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
>   #if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
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
>   *   * Each "foo" Cobalt routine shadowing a POSIX service may be
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
> 
> 
> I challenged it why we need that =5F=5FCOBALT=5FNO=5FOFF64=5FREDIRECT=
=5F=5F:
> 
> "Why the time64 pattern doesn't carry over
> 
> - =5F=5FUSE=5FTIME=5FBITS64 && =5F=5FTIMESIZE =3D=3D 32 works without=
 a marker because
>    the native-time=5Ft implementations are compiled with -U=5FTIME=5F=
BITS, so
>    the condition is false in exactly those files.
> - With glibc, the same works for mmap.c, which is built with
>   -U=5FFILE=5FOFFSET=5FBITS. The counterpart of =5F=5FTIMESIZE =3D=3D=
 32 is
>   !defined(=5F=5FOFF=5FT=5FMATCHES=5FOFF64=5FT), which glibc and uCli=
bc-ng define
>   when off=5Ft is 64-bit anyway.
> - uClibc-ng 1.0.58 and later always define =5F=5FUSE=5FFILE=5FOFFSET6=
4, so
>   -U=5FFILE=5FOFFSET=5FBITS has no effect. On 32-bit targets
>   =5F=5FOFF=5FT=5FMATCHES=5FOFF64=5FT isn't defined, so the property =
test is true
>   inside mmap.c as well. That brings back "=5F=5Fwrap=5Fmmap aliased =
to
>   undefined symbol =5F=5Fcobalt=5Fmmap". Only an explicit opt-out by =
the file
>   that implements both variants avoids it."
> 
> Jan
>

