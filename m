Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562445;
	b=SsIXiXUVBHR5oEXW8fjoT6Z7TdamH5IG28cHfofTqndGeEoO+liwkefmN0if59BmoGyO
	 CZkNXShvzYxoWA8tMl39HBemA88Zn+y8Dq5Dc/Vt4+dZ1+YvtFy5GhsL9YicV0wtsOSyZ
	 7HUZbWurcPBdok04xvLwKHojozWFv4X6i/2WrHfn/A+j3Eyz119Lns2S6v5OHfnU6+7X0
	 NP3ecfknHP6mtbELJKu9XnppSg7nk9jKfwEWzYkupP99zmNWFpkJPzWKdRgyAKuANkx5O
	 6xQmgOIarqG3/aeYkZY9t6aE9lxprRGARb7fyRPyB3vz9cH6i3o9/t658ovUugD0tJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562445;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 From:Subject:To:References:Content-Language:In-Reply-To:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=tObzfEyVGVDzx4fvUVpOyYbbb6+k3PgCqP8qD9SLkTs=;
	b=R2dWyYyfddQwib+oV0xIc2Ur+a/iUmyr5X8bpoX8PldPoPzayVYSMYm41U2YBLVaCDX6
	 xMkEcRRZqSbHMQkS6MwSf6fBL4F1StqUR+mJFH/MuwUlrOjyH7iGir5enOa66AgUwMvTM
	 Z66kfkBVRK0Abj7cJ6juxYij8NMgFLw05AOf36n+xmN5Z6Ev5xjgae0OcaH/wy4cq7Iid
	 CQYJPuAv//cG7UkObUU8mExX7Tl929R3amqTWFNjavD3yiYaIxlA356B37EY7UlqcXRVh
	 8B+CdNHrqWThr/V5ekNLg9Rfq50HlOKm+enMFf5fbmsRAZFe14E6flxTdqbU9zejxYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=jan.kiszka@web.de header.a=rsa-sha256 header.s=s29768273 header.b=BOZC8aYY;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4328606A32A
	for <xenomai@lists.linux.dev>; Fri, 13 Nov 2026 09:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4328606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.a=rsa-sha256 header.s=s29768273 header.b=BOZC8aYY
DKIM2-Signature:  i=1; m=1; t=1794562437;
 mf=PGphbi5raXN6a2FAd2ViLmRlPg==;
 rt=PHhlbm9tYWlAbGlzdHMubGludXguZGV2Pg==;
 d=web.de;
 s=s29768273:rsa-sha256:wehkEd2CwOKorkmW2SDdo3TpXGaK
   tx2hcQSPYpqm3Ug4SsHlO1oIFr9KcHCQ2utlzKSFoFbUmLnnJ+AIleL5ejqNQq2rcDCw0OPvQDh
   siKISaR16Uk7DEDOFfSk6Kmc96/TLZvQ3v7I8EJQdIoY8/ztPfOuiEaElR+hQGB5ADiZB2a66KW
   btBi8VIdqUh77UGLXfNeE7KUiRnw5cmcR2/SERwzkFMpekIaK3VkSVIR64CAU2Enghx/qOuNf3t
   3gwNGJwJ6a+yIwl52HxuvMmhNw9oIUUBQ6wsE4xO2nZCSIrMwx6GR5rEpO9MHykKIQyKyaSPP/q
   j/h2fa2lFc6Njw==;
Message-Instance:  m=1;
 h=sha256:
   uosmSGm8rz411zfptQrzWobm4cafEEfzgNruJN6o4aI=:
   uPtXupjMyyBjnnME1LdPg89G9r8CnJsBMeXRR6DbWKk=,
  sha512:
   z+qA5Np31Yas0EggphFVe/8+q+8ir38GE+hcKiIlAO/sClY1bjwQYq7hZMjOvEZSRjGNZzkTvjDLH1Ta4lsg9w==:
   1gtTpPX4hi+v8o2YwU32Tm7jhdlkSa+83m8uCQpXjmSbwkK3Sfvmp6GvW9BjSiRL3bysqo7gbo9aj5BybXhpWQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794562437; x=1795167237; i=jan.kiszka@web.de;
	bh=tObzfEyVGVDzx4fvUVpOyYbbb6+k3PgCqP8qD9SLkTs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BOZC8aYYL8RcxFY6b2EdU+zlpcASoEdZ32b0dFuX2w5f/4gWVNVAVSZaKPH+vqIl
	 nRt0Sm2zlqWrOZFX3oFeuF9LNJ6LjWn+v+7QOMzpFeJl1vsJeGGdvK/lJfPrYCFoT
	 BwukT46eNqibz2mlhWf+InC9aMMPPNWWSyIBFVbkWrVDsyBZ/Dp0ON/hMnkbGXMrx
	 npADtEPJIkj46Sgqr+v2RP+buO40+wcpekyISiAyY63/p2X/isqe2hcHDjUYTx3n5
	 FPFTYvOVHnOWElcPGO1t5Vz83bdeD/Mwho7XkbkTBPjGL7kgk7AVZTRI7cpO7JKcw
	 hndlbnkM0mF2elkAGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1McZnj-1wtnNo2jWf-00n0nz; Fri, 13
 Nov 2026 08:35:57 +0100
Message-ID: <b2cf84dd-aaae-4eb5-8fb4-2d5f00594478@web.de>
Date: Fri, 13 Nov 2026 08:35:57 +0100
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH] Fixes broken mmap patching on 32bits archs
To: xenomai@lists.linux.dev, =?UTF-8?Q?Fran=C3=A7ois_LEGAL?=
 <devel@thom.fr.eu.org>
References: <115efd-6af60100-33-36f80d40@101055323>
Content-Language: en-US
In-Reply-To: <115efd-6af60100-33-36f80d40@101055323>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aDccEiKGi926v6CXr6Mw8xcK0XEn+Wy0uTa9DfPLEHlgrm9885g
 qLXO07G15Oei4vmVxK03FTw9Enoq40we3h20dcxTDLyuMRdU/UTvvjgoQc3kca7L+N+FLzR
 oBWAoyujA7ZB3efjsmbG6QWIFNlCg8qvIgln4T66Vv18Z/c00hemqFxj+c0bP7mENz76f2Q
 sjCrudLF6hYGjrtR8qkIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cz2xlel21D8=;X5MUx7QwAW5CjGPcUwPYS12fbuy
 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
 uqgsg24AopGzL

On 12.11.26 19:11, Fran=C3=83=C2=A7ois Legal wrote:
> mmap is broken on 32 bits arch when __USE_TIME_BITS64 and __USE_FILE_OFF=
SET64 are set
> in that case, libc translate calls of mmap to mmap64 because file offset=
 argument is a 64 bit value.
> We fail to catch that with the decoration logic (__STD/__RT) and plain l=
ibc mmap is called.
>=20
> Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
> --
> diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
> index e291f50ef..b6d650876 100644
> --- a/include/cobalt/sys/mman.h
> +++ b/include/cobalt/sys/mman.h
> @@ -28,16 +28,10 @@
>  extern "C" {
>  #endif
> =20
> -COBALT_DECL(void *, mmap,
> +COBALT_DECL_OFF64(void *, mmap, mmap64,
>  	    (void *addr, size_t length, int prot, int flags, int fd,
>  	     off_t offset));
> =20
> -#if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
> -COBALT_DECL(void *, mmap64,
> -	    (void *addr, size_t length, int prot, int flags, int fd,
> -	     off64_t offset));
> -#endif
> -
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
> index a5645a1d4..82c9aaa69 100644
> --- a/include/cobalt/wrappers.h
> +++ b/include/cobalt/wrappers.h
> @@ -46,6 +46,23 @@
>  #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
>  #endif
> =20
> +#if __USE_FILE_OFFSET64 && __WORDSIZE =3D=3D 32
> +/*
> + * Make __RT() and __STD() usable in combination with time64_t related =
services.
> + */
> +#define COBALT_IMPL_OFF64(T, FN, FN_64, I)                             =
       \
> +	__typeof__(T) __wrap_##FN_64 I                                        =
 \
> +		__attribute__((alias("__cobalt_" __stringify(FN)), weak));     \
> +	COBALT_IMPL(T, FN, I)
> +#define COBALT_DECL_OFF64(T, FN, A, I)                                 =
       \
> +	__typeof__(T) __STD(A) I;                                             =
 \
> +	extern T __REDIRECT_NTH(__STD(FN), I, __real_##A);                    =
 \
> +	COBALT_DECL(T, FN, I)
> +#else
> +#define COBALT_IMPL_OFF64(T, FN, FN_64, I) COBALT_IMPL(T, FN, I)
> +#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
> +#endif
> +
>  /*
>   *=20
>   * Each "foo" Cobalt routine shadowing a POSIX service may be
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 00c1aaf4b..11a6e86e6 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -542,7 +542,7 @@ COBALT_IMPL(int, shutdown, (int fd, int how))
>  	return __STD(shutdown(fd, how));
>  }
> =20
> -COBALT_IMPL(void *, mmap64, (void *addr, size_t length, int prot, int f=
lags,
> +COBALT_IMPL_OFF64(void *, mmap, mmap64, (void *addr, size_t length, int=
 prot, int flags,
>  			     int fd, off64_t offset))
>  {
>  	struct _rtdm_mmap_request rma;
> @@ -574,8 +574,3 @@ regular:
>  #endif
>  }
> =20
> -COBALT_IMPL(void *, mmap, (void *addr, size_t length, int prot, int fla=
gs,
> -			   int fd, off_t offset))
> -{
> -	return __COBALT(mmap64(addr, length, prot, flags, fd, offset));
> -}
>=20

The LLM is not convinced: On 32-bit arm with time64 libs, this version=20
will map __RT(mmap()) to a variant that expects 64-bit off_t, while a=20
caller which uses 32-bit off_t would rightfully expect mmap to be 32-bit=
=20
then.

Its counter-proposal:

diff --git a/include/cobalt/sys/mman.h b/include/cobalt/sys/mman.h
index e291f50ef..54c028ad9 100644
=2D-- a/include/cobalt/sys/mman.h
+++ b/include/cobalt/sys/mman.h
@@ -28,9 +28,9 @@
 extern "C" {
 #endif
=20
-COBALT_DECL(void *, mmap,
-	    (void *addr, size_t length, int prot, int flags, int fd,
-	     off_t offset));
+COBALT_DECL_OFF64(void *, mmap, mmap64,
+		  (void *addr, size_t length, int prot, int flags, int fd,
+		   off_t offset));
  #if defined(_LARGEFILE64_SOURCE) || defined(_GNU_SOURCE)
 COBALT_DECL(void *, mmap64,
diff --git a/include/cobalt/wrappers.h b/include/cobalt/wrappers.h
index 6d826eedf..9dd022a75 100644
=2D-- a/include/cobalt/wrappers.h
+++ b/include/cobalt/wrappers.h
@@ -45,6 +45,21 @@
 #define COBALT_DECL_TIME64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
 #endif
=20
+#if defined(__USE_FILE_OFFSET64) && !defined(__COBALT_NO_OFF64_REDIRECT__=
)
+/*
+ * Make __RT() and __STD() usable in combination with off_t related
+ * services: the libc redirects them to their 64-bit variants in this
+ * case, follow suit. Code implementing the native variants opts out,
+ * as some libcs enforce 64-bit file offsets (e.g. uClibc-ng).
+ */
+#define COBALT_DECL_OFF64(T, FN, FN_64, I)                               =
      \
+	extern T __REDIRECT_NTH(__STD(FN), I, __real_##FN_64);                 \
+	extern T __REDIRECT_NTH(__RT(FN), I, __cobalt_##FN_64);                \
+	extern T __REDIRECT_NTH(__WRAP(FN), I, __wrap_##FN_64)
+#else
+#define COBALT_DECL_OFF64(T, FN, FN_64, I) COBALT_DECL(T, FN, I)
+#endif
+
 /*
  *   * Each "foo" Cobalt routine shadowing a POSIX service may be
diff --git a/lib/cobalt/mmap.c b/lib/cobalt/mmap.c
index d30b1722d..bf8772f6a 100644
=2D-- a/lib/cobalt/mmap.c
+++ b/lib/cobalt/mmap.c
@@ -18,6 +18,12 @@
   USA.
  */
=20
+/*
+ * We implement mmap() for the native off_t next to mmap64(): keep their
+ * names apart, even if the libc enforces 64-bit file offsets.
+ */
+#define __COBALT_NO_OFF64_REDIRECT__
+
 #include <sys/mman.h>
 #include <rtdm/rtdm.h>
 #include <cobalt/uapi/syscall.h>


I challenged it why we need that __COBALT_NO_OFF64_REDIRECT__:

"Why the time64 pattern doesn't carry over

- __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32 works without a marker because
   the native-time_t implementations are compiled with -U_TIME_BITS, so
   the condition is false in exactly those files.
- With glibc, the same works for mmap.c, which is built with
  -U_FILE_OFFSET_BITS. The counterpart of __TIMESIZE =3D=3D 32 is
  !defined(__OFF_T_MATCHES_OFF64_T), which glibc and uClibc-ng define
  when off_t is 64-bit anyway.
- uClibc-ng 1.0.58 and later always define __USE_FILE_OFFSET64, so
  -U_FILE_OFFSET_BITS has no effect. On 32-bit targets
  __OFF_T_MATCHES_OFF64_T isn't defined, so the property test is true
  inside mmap.c as well. That brings back "__wrap_mmap aliased to
  undefined symbol __cobalt_mmap". Only an explicit opt-out by the file
  that implements both variants avoids it."

Jan
