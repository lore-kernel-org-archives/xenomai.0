Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B49E313E0B
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512993; cv=none; b=GFMRHQ2+3PKcMHECoIedCyM0+x8uHMlVEU48QKeUxljDcpVC6wMATGGcAhjpsI+/onCrGoalpOm2b4Z0qkpqI6XdwTwN4CRyY+iNY3wq8s9KbWZWCmXn2ZzhgjA7ys/6osvf6v8VIlnJCdDLRQ4CLf5PVb3mZa6KNCRara+3Ozg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512993; c=relaxed/simple;
	bh=RCqF/LHdld+u/Auz/rY4Btsev9rTy/48M+0AuSAxbCo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BXtwYnZh2qepXeQwh5EfDpUdXQ8vilSP8PkeNsSafPvOvrnVs6JegY1aw2vyLtrI196nP1KKw2b35yiVvp4Ag2OY/O68N1UTSIbRBMkHd6jLx5qO5J6a2xKbm95+ZkqONkzG1zIguz3gDCrOxxhYBUFODv9HA5Qut9QMV2neCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Qc9hfkwg; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Qc9hfkwg"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251015071254f62e9f12120002077b
        for <xenomai@lists.linux.dev>;
        Wed, 15 Oct 2025 09:12:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=oTiVMftcdtFtjkwjtpOjK+gyEdr6EmIxr61B3ivM/bg=;
 b=Qc9hfkwg1WJwjzYgV5YFWeId4rqZ0knRyJNrxyJwuaBRwnr0Uuov1f+D84zP2ZQGPPpEX0
 jjycSzH3e8gzcd/mBY8GZKbq8P8MyWJxH+VAz9U2As89NaKG7mjk/b9lVzhYHTZ36VIaRtWt
 jZvI109bCL4EtyeqRU3jkwV9gzEe8cvJ6dCHPX9IWjXv6n4lJv5vFN8bLz6r6USp3mAxUFL3
 Wds56tpLNeAgJsHFdWuqI4gwVjLq2D499bqHJ9lmQhFZWb81FxSLOBdFLPppsF1m31NfOs+Y
 dLCoWBo4HJLHL1HsJ7D+QEbhugRCJ7SoNtYeO6wQeo+jJeGmhk6Qd44w==;
Message-ID: <77c5c99cb6dda43b48ba8bf8ef29f665ee19ea6f.camel@siemens.com>
Subject: Re: [PATCH 2/6] lib/cobalt: arm: Avoid thumb mode in
 syscall-issuing modules
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 15 Oct 2025 09:12:54 +0200
In-Reply-To: <b2aa6e5eb2bf3b7357239aae8d55289f0baac9a8.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
	 <b2aa6e5eb2bf3b7357239aae8d55289f0baac9a8.1760374860.git.jan.kiszka@siemens.com>
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

On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> In 4abd59b4e3e4, we noticed the clash between r7 usage for setting up
> Xenomai syscalls and the compiler suddenly refusing this. What we was
                                                                 ^  =20
"we" seems superfluous.

> not clear at that point was the origin of the clash: if the compiler
> is configured to prefer thumb mode over regular 32-bit ARM instructions,
> it also starts to claim r7 as frame pointer.
>=20
> Now, the solution taken back then turned out to have a problem: It broke
> stack unwinding. That is not only an issue when debugging, it is
> actually required for pthread_cancel and pthread_exit. The glibc will
> use unwinding to call destructors of the terminating context to call
> them before shutting down. This broke when we were inside a syscall
> because r7 was then pointing to the syscall number.
>=20
> Most glibc versions detected the broken call chain and simply skipped
> the destructors - which was still a problem, just unnoticed. But with
> recent glibc from trixie, we are now even crashing while unwinding, and
> that is even less acceptable.

Ok, so not a trixie regression, but something that was never correct on
our end. Good to know as trixie will get more traction soon.

>=20
> We could now either use the pattern of glibc to push the syscall
> invocation into an assembly function - or simply enforce ARM mode for
> libcobalt so that r7 become usable again. Take the latter approach as it
> is leaner.

As it broke again - and as already written as comment to the series -
we might think of reviving the syscall() series. That would allow us to
simply remove that code here. Seems hard to maintain and hard to
debug...

>=20
> Fixes: 4abd59b4e3e4 ("lib/cobalt: arm: Account for register allocation cl=
ash")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  configure.ac                                    |  1 +
>  .../arch/arm/include/asm/xenomai/syscall.h      | 17 +++++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index a28d80a5e0..c1214bda88 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -937,6 +937,7 @@ if test $rtcore_type =3D cobalt; then
>     XENO_COBALT_CFLAGS=3D"$XENO_USER_CFLAGS"
>     case "$build_for" in
>      i*86*-*) XENO_COBALT_CFLAGS=3D"$XENO_COBALT_CFLAGS -fno-omit-frame-p=
ointer";;
> +    arm*-*) XENO_COBALT_CFLAGS=3D"$XENO_COBALT_CFLAGS -marm";;
>      esac
> =20
>  dnl Build wrapping information. XENO_POSIX_WRAPPERS lists all wrapping
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h b/lib/coba=
lt/arch/arm/include/asm/xenomai/syscall.h
> index 105bf9faf1..1fc605b1ba 100644
> --- a/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/syscall.h
> @@ -29,6 +29,10 @@
>  #error "ARM OABI support has been removed with Xenomai 3.3.x"
>  #endif
> =20
> +#ifdef __thumb__
> +#error "Xenomai syscalls cannot be issued in Thumb mode"
> +#endif
> +
>  /*
>   * Some of the following macros have been adapted from Linux's
>   * implementation of the syscall mechanism in <asm-arm/unistd.h>:
> @@ -54,8 +58,8 @@
>  	LOADARGS_4(syscode, arg1, arg2, arg3, arg4);		\
>  	__a4 =3D (unsigned long) (arg5)
> =20
> -#define CLOBBER_REGS_0
> -#define CLOBBER_REGS_1 "r0"
> +#define CLOBBER_REGS_0 "r7"
> +#define CLOBBER_REGS_1 CLOBBER_REGS_0, "r0"
>  #define CLOBBER_REGS_2 CLOBBER_REGS_1, "r1"
>  #define CLOBBER_REGS_3 CLOBBER_REGS_2, "r2"
>  #define CLOBBER_REGS_4 CLOBBER_REGS_3, "r3"
> @@ -69,7 +73,8 @@
>  #define LOADREGS_5 LOADREGS_4; __r4 =3D __a4
> =20
>  #define ASM_INDECL_0							\
> -	register unsigned long __r0  __asm__ ("r0");
> +	register unsigned long __r0  __asm__ ("r0");			\
> +	register unsigned long __r7  __asm__ ("r7");
>  #define ASM_INDECL_1 ASM_INDECL_0;					\
>  	unsigned long __a0;
>  #define ASM_INDECL_2 ASM_INDECL_1;					\
> @@ -91,15 +96,15 @@
>  #define XENOMAI_DO_SYSCALL(nr, op, args...)				\
>  	({								\
>  		ASM_INDECL_##nr;					\
> -		unsigned long __r7 =3D __xn_syscode(op);			\
>  		LOADARGS_##nr(__xn_syscode(op), args);			\
>  		__asm__ __volatile__ ("" : /* */ : /* */ :		\
>  				      CLOBBER_REGS_##nr);		\
>  		LOADREGS_##nr;						\
> +		__r7 =3D __xn_syscode(op);				\
>  		__asm__ __volatile__ (					\
> -			"push {r7}; mov %%r7,%[__r7]; swi\t0; pop {r7}"	\
> +			"swi 0"						\
>  			: "=3Dr" (__r0)					\
> -			: ASM_INPUT_##nr, [__r7] "r" (__r7)		\
> +			: ASM_INPUT_##nr, "r" (__r7)			\
>  			: "memory");					\
>  		(int) __r0;						\
>  	})
> --=20
> 2.51.0
