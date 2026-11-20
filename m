Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163529;
	b=f196X9Ms39NkyRq6nyn9EsFF8ZoylQxc1V7+gEERa1s5jsZ1HgU4H4mmoDqOkAH7xp0C
	 wOzDXQwsaTny67TKOtElrEcAyzP9kjsABftUCVWSvwyuEpIrqaXoJ6IczHYsb7lK6Yl6J
	 0Dz0nb6UhDc/x/ejIBUoIjD/GZ+8ypYam/SituYwwyNQi6wNM1NtbCMmP7gwMSJ/1aniu
	 8rVJ84KtK+BGdEwUgi+gKacKgmtXDJH2hrknGw7q8DYG/Y9Z6hAq2YfKgu6uPD1cF7459
	 ZbsI6Ff95YrT90D4H67EwaZDCleaxjtpaO5zi9RcIDmmuSmiivTQnz8E3ns1EGuhQiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163529;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:In-Reply-To:
	 Content-Type:X-Forward:Date:Cc:To:MIME-Version:Message-ID:Subject:
	 User-Agent:Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
	bh=5uGZr/OSxQDKH3Ti9A5TjVWx7tK4Ods5pFQTdLl9E0w=;
	b=kglQrTz6D2MzQ41ss1hi+TY6/J9eZO0h/DN9g5dRVTk/k80FP2+5ba13gxVQ0wRNLx/x
	 w0mXSQ/SyCrhotSN2KUrxiuYIUp7u74u5ZyCftl7jNCXpLDSutt8/fC6eKV2tbuYIAIpi
	 ePGJZQ+OZiGxpx6jMNozalMxcYvnqNHCAmIgsMBaQozlBnUq/MFxacloapk85rNAlcvrg
	 JYUHX/09UKe/NwdxYMFY4HffmdZRqnbF6s0vK9K/QnWxENf0N6pYx95l51T4lfQ+72ruG
	 i+8OnHFKBDiAW5hUAiov6wWnwLgrS01+6gbA2pcplD/5f3Kx63fp6FQulWQKU6Yo9kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eventlab.fr;
	spf=pass smtp.mailfrom=eventlab.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=vIgmr3WY;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57367606A320
	for <xenomai@lists.linux.dev>; Fri, 20 Nov 2026 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57367606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=vIgmr3WY
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id 66116780371;
	Fri, 20 Nov 2026 09:32:03 +0100 (CET)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=vIgmr3WY;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6AK8W0W03267503;
	Fri, 20 Nov 2026 09:32:01 +0100
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1795163521;
	bh=AmXabNAGwOBY3b6ic2itmDoAka1FT8sCpOg8uKvKWzo=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=vIgmr3WYPm8A1E+PCPCNFQD92zOjRSPrSMTDtNHggGJDlXKitqrO/cC7KZo+/oMpZ
	 eE9qA+1wJ9uo9WahelmxpGjRtKP8Ne3wehi8K0+aDNgHyPBydO6okl0IBB7Vgr65Ju
	 7ib+/e0++134nxFPibDrf9lMrjFEaPx7ZeBdpfVOk91r3ndgdzIr5xfrHKatJMeR6G
	 02CWUNtNVTIhJBszdSjax2+LYhbHrOLUHFOB1ZTPMmDANTfs8/BBm+W9Fll1Q4ZzVP
	 bjB1x9REV7EblFbdfiSqqeFIieDrgrUK/etpmsluakSBhJAhEsN0/O6mdQIqOM3n58
	 /YWH2AEi421aA==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <f0f8dc2a-bf6a-4a48-9ed3-4b3bc45b995d@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Fri, 20 Nov 2026 09:32:00 +0100
Cc: xenomai@lists.linux.dev
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
Message-ID: <115efd-6b000580-3f-36f80d40@101056808>
Subject: =?utf-8?q?Re=3A?= [PATCH] Fixes broken mmap patching on 32bits archs
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Vendredi, Novembre 13, 2026 13:20 CET, Jan Kiszka <jan.kiszka@siemen=
s.com> a =C3=A9crit: 
 
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
>   the native-time=5Ft implementations are compiled with -U=5FTIME=5FB=
ITS, so
>   the condition is false in exactly those files.
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
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
 
Hi Jan,

I had a hard time making your patch apply to my tree and build (it came=
 a little bit garbled in the message).
Anyway, I ended up succeeding. It works. However, to make it build corr=
ectly, I slight modification is required in [1].
So for the records, I paste below the mix of both patches, the one that=
 actually build and work.

Fran=C3=A7ois

[1] https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/0bb6608b6fa712=


From d7905501b97604e252550030698cf6b2fdc43dc5 Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 30 Jan 2026 07:46:12 +0100
Subject: [PATCH] lib/cobalt: Avoid making mmap offset argument uncondit=
ionally

 64-bit

When =5FFILE=5FOFFSET=5FBITS is 64, mmap is handled by the mmap64 symbo=
l of
glibc. The original mmap continues to expect native off=5Ft size, i.e.
32 bits on 32-bit archs.

While we require applications to be rebuilt with the same settings
Xenomai was built with as well (either both =5FTIME=5FBITS and
=5FFILE=5FOFFSET=5FBITS set to 64 or both left unset) which practically=

shadows this issue, it remains wrong to change the wrapped mmap functio=
n
in a way that is incompatible with glibc.

To avoid running into conflicts between enabling and disabling
=5FTIME=5FBITS=3D64 and, thus, also =5FFILE=5FOFFSET=5FBITS=3D64, facto=
r out the
affected mmap wrappers as well as their =5F=5Freal stubs into a separat=
e
code module.

There is one catch: The cobalt-call to mmap in umm.c needs to be forced=

to mmap64 to become agnostic to =5FFILE=5FOFFSET=5FBITS used by the cob=
alt
core internally.

Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --dis=
able-y2038")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/sys/mman.h |  6 +--
 include/cobalt/wrappers.h | 15 +++++++
 lib/cobalt/Makefile.am    | 15 +++++++
 lib/cobalt/mmap.c         | 83 +++++++++++++++++++++++++++++++++++++++=

 lib/cobalt/rtdm.c         | 38 ------------------
 lib/cobalt/umm.c          |  4 +-
 lib/cobalt/wrappers.c     | 17 --------
 7 files changed, 118 insertions(+), 60 deletions(-)
 create mode 100644 lib/cobalt/mmap.c

diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
index e291f50ef..54c028ad9 100644
--- a/include/cobalt/sys/mman.h
+++ b/include/cobalt/sys/mman.h
@@ -28,9 +28,9 @@
 extern "C" {
 #endif
 
-COBALT=5FDECL(void *, mmap,
-	    (void *addr, size=5Ft length, int prot, int flags, int fd,
-	     off=5Ft offset));
+COBALT=5FDECL=5FOFF64(void *, mmap, mmap64,
+		  (void *addr, size=5Ft length, int prot, int flags, int fd,
+		   off=5Ft offset));
 
 #if defined(=5FLARGEFILE64=5FSOURCE) || defined(=5FGNU=5FSOURCE)
 COBALT=5FDECL(void *, mmap64,
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index a5645a1d4..3d9ec7dda 100644
--- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -46,6 +46,21 @@
 #define COBALT=5FDECL=5FTIME64(T, FN, FN=5F64, I) COBALT=5FDECL(T, FN,=
 I)
 #endif
 
+#if defined(=5F=5FUSE=5FFILE=5FOFFSET64) && !defined(=5F=5FCOBALT=5FNO=
=5FOFF64=5FREDIRECT=5F=5F)
+/*
+ * Make =5F=5FRT() and =5F=5FSTD() usable in combination with off=5Ft =
related
+ * services: the libc redirects them to their 64-bit variants in this
+ * case, follow suit. Code implementing the native variants opts out,
+ * as some libcs enforce 64-bit file offsets (e.g. uClibc-ng).
+ */
+#define COBALT=5FDECL=5FOFF64(T, FN, FN=5F64, I)                      =
               \
+	extern T =5F=5FREDIRECT=5FNTH(=5F=5FSTD(FN), I, =5F=5Freal=5F##FN=5F6=
4);                 \
+	extern T =5F=5FREDIRECT=5FNTH(=5F=5FRT(FN), I, =5F=5Fcobalt=5F##FN=5F=
64);                \
+	extern T =5F=5FREDIRECT=5FNTH(=5F=5FWRAP(FN), I, =5F=5Fwrap=5F##FN=5F=
64)
+#else
+#define COBALT=5FDECL=5FOFF64(T, FN, FN=5F64, I) COBALT=5FDECL(T, FN, =
I)
+#endif
+
 /*
  * 
  * Each "foo" Cobalt routine shadowing a POSIX service may be
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 4318adf18..b5b184b55 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -7,9 +7,12 @@ noinst=5FHEADERS =3D	\
 
 lib=5FLTLIBRARIES =3D libcobalt.la libmodechk.la
 
+noinst=5FLTLIBRARIES =3D libcobaltnativeoff.la
+
 libcobalt=5Fla=5FLDFLAGS =3D @XENO=5FLIB=5FLDFLAGS@ -version-info 2:0:=
0 -lpthread -lrt
 
 libcobalt=5Fla=5FLIBADD =3D \
+	libcobaltnativeoff.la			\
 	arch/@XENO=5FTARGET=5FARCH@/libarch.la	\
 	../boilerplate/libboilerplate.la
 
@@ -43,6 +46,18 @@ libcobalt=5Fla=5FCPPFLAGS =3D			\
 	-I$(top=5Fsrcdir)/include/cobalt	\
 	-I$(top=5Fsrcdir)/include
 
+# source files that require native off=5Ft size
+libcobaltnativeoff=5Fla=5FSOURCES =3D	\
+	mmap.c
+
+libcobaltnativeoff=5Fla=5FLDFLAGS =3D @XENO=5FLIB=5FLDFLAGS@
+
+libcobaltnativeoff=5Fla=5FCPPFLAGS =3D	\
+	@XENO=5FCOBALT=5FCFLAGS@		\
+	-I$(top=5Fsrcdir)/include/cobalt	\
+	-I$(top=5Fsrcdir)/include		\
+	-U=5FTIME=5FBITS -U=5FFILE=5FOFFSET=5FBITS
+
 libmodechk=5Fla=5FLIBADD =3D libcobalt.la
 
 libmodechk=5Fla=5FSOURCES =3D	\
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
new file mode 100644
index 000000000..cc304bf80
--- /dev/null
+++ b/lib/cobalt/mmap.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2005 Jan Kiszka <jan.kiszka@web.de>.
+ * Copyright (C) 2005 Heikki Lindholm <holindho@cs.helsinki.fi>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software=

+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-130=
7
+  USA.
+ */
+
+/*
+ * We implement mmap() for the native off=5Ft next to mmap64(): keep t=
heir
+ * names apart, even if the libc enforces 64-bit file offsets.
+ */
+#define =5F=5FCOBALT=5FNO=5FOFF64=5FREDIRECT=5F=5F
+
+#include <sys/mman.h>
+#include <rtdm/rtdm.h>
+#include <cobalt/uapi/syscall.h>
+#include <asm/xenomai/syscall.h>
+
+COBALT=5FIMPL(void *, mmap64, (void *addr, size=5Ft length, int prot, =
int flags,
+			     int fd, off64=5Ft offset))
+{
+	struct =5Frtdm=5Fmmap=5Frequest rma;
+	int ret;
+
+	if (fd < 0) /* We don't do anonymous mappings. */
+		goto regular;
+
+	/* RTDM ignores the address hint, and rejects MAP=5FFIXED. */
+	rma.length =3D length;
+	rma.offset =3D offset;
+	rma.prot =3D prot;
+	rma.flags =3D flags;
+
+	ret =3D XENOMAI=5FSYSCALL3(sc=5Fcobalt=5Fmmap, fd, &rma, &addr);
+	if (ret !=3D -EADV && ret !=3D -ENOSYS) {
+		if (ret) {
+			errno =3D -ret;
+			return MAP=5FFAILED;
+		}
+
+		return addr;
+	}
+
+regular:
+#if mmap64 =3D=3D mmap
+	return =5F=5FSTD(mmap(addr, length, prot, flags, fd, offset));
+#else
+	return =5F=5FSTD(mmap64(addr, length, prot, flags, fd, offset));
+#endif
+}
+
+COBALT=5FIMPL(void *, mmap, (void *addr, size=5Ft length, int prot, in=
t flags,
+			   int fd, off=5Ft offset))
+{
+	return =5F=5FCOBALT(mmap64(addr, length, prot, flags, fd, offset));
+}
+
+=5F=5Fweak
+void *=5F=5Freal=5Fmmap(void *addr, size=5Ft length, int prot, int fla=
gs,
+		  int fd, off=5Ft offset)
+{
+	return mmap(addr, length, prot, flags, fd, offset);
+}
+
+=5F=5Fweak
+void *=5F=5Freal=5Fmmap64(void *addr, size=5Ft length, int prot, int f=
lags,
+		  int fd, off64=5Ft offset)
+{
+	return mmap64(addr, length, prot, flags, fd, offset);
+}
diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
index 264de8ace..98513925a 100644
--- a/lib/cobalt/rtdm.c
+++ b/lib/cobalt/rtdm.c
@@ -541,41 +541,3 @@ COBALT=5FIMPL(int, shutdown, (int fd, int how))
 
 	return =5F=5FSTD(shutdown(fd, how));
 }
-
-COBALT=5FIMPL(void *, mmap64, (void *addr, size=5Ft length, int prot, =
int flags,
-			     int fd, off64=5Ft offset))
-{
-	struct =5Frtdm=5Fmmap=5Frequest rma;
-	int ret;
-
-	if (fd < 0) /* We don't do anonymous mappings. */
-		goto regular;
-
-	/* RTDM ignores the address hint, and rejects MAP=5FFIXED. */
-	rma.length =3D length;
-	rma.offset =3D offset;
-	rma.prot =3D prot;
-	rma.flags =3D flags;
-
-	ret =3D XENOMAI=5FSYSCALL3(sc=5Fcobalt=5Fmmap, fd, &rma, &addr);
-	if (ret !=3D -EADV && ret !=3D -ENOSYS) {
-		ret =3D set=5Ferrno(ret);
-		if (ret)
-			return MAP=5FFAILED;
-
-		return addr;
-	}
-
-regular:
-#if mmap64 =3D=3D mmap
-	return =5F=5FSTD(mmap(addr, length, prot, flags, fd, offset));
-#else
-	return =5F=5FSTD(mmap64(addr, length, prot, flags, fd, offset));
-#endif
-}
-
-COBALT=5FIMPL(void *, mmap, (void *addr, size=5Ft length, int prot, in=
t flags,
-			   int fd, off=5Ft offset))
-{
-	return =5F=5FCOBALT(mmap64(addr, length, prot, flags, fd, offset));
-}
diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index c0d4489d3..6b4303b72 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -58,8 +58,8 @@ static void *=5F=5Fmap=5Fumm(const char *name, uint32=
=5Ft *size=5Fr)
 		return MAP=5FFAILED;
 	}
 
-	addr =3D =5F=5FRT(mmap(NULL, statbuf.size, PROT=5FREAD|PROT=5FWRITE,
-			 MAP=5FSHARED, fd, 0));
+	addr =3D =5F=5FRT(mmap64(NULL, statbuf.size, PROT=5FREAD|PROT=5FWRITE=
,
+			   MAP=5FSHARED, fd, 0));
 	=5F=5FRT(close(fd));
 
 	*size=5Fr =3D statbuf.size;
diff --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c
index 18c237734..3a0063f05 100644
--- a/lib/cobalt/wrappers.c
+++ b/lib/cobalt/wrappers.c
@@ -28,7 +28,6 @@
 #include <sys/select.h>
 #include <sys/socket.h>
 #include <sys/time.h>
-#include <sys/mman.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -384,22 +383,6 @@ int =5F=5Freal=5Fselect (int =5F=5Fnfds, fd=5Fset =
*=5F=5Frestrict =5F=5Freadfds,
 	return select(=5F=5Fnfds, =5F=5Freadfds, =5F=5Fwritefds, =5F=5Fexcept=
fds, =5F=5Ftimeout);
 }
 
-=5F=5Fweak
-void *=5F=5Freal=5Fmmap(void *addr, size=5Ft length, int prot, int fla=
gs,
-		  int fd, off=5Ft offset)
-{
-	return mmap(addr, length, prot, flags, fd, offset);
-}
-
-#if mmap64 !=3D mmap
-=5F=5Fweak
-void *=5F=5Freal=5Fmmap64(void *addr, size=5Ft length, int prot, int f=
lags,
-		  int fd, off64=5Ft offset)
-{
-	return mmap64(addr, length, prot, flags, fd, offset);
-}
-#endif
-
 =5F=5Fweak
 int =5F=5Freal=5Fvfprintf(FILE *stream, const char *fmt, va=5Flist arg=
s)
 {

