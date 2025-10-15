Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F031A065
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512875; cv=none; b=pBWty1fqG2SMXz35Zb0MulYUIF3a2kRTt7YtCT6f8/eFEg0vE0eykN1hj7iK+NKTMFoOZu/Ful4f/9owPWGl4FU3eZ58QOp2fKR0pAQcHteALEBeGOLARk0xzsx76Ek4j0QWj3on2ZbHbUCw8fZXCPL1Hc7fuRcPlxi6LM8ohmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512875; c=relaxed/simple;
	bh=eSlgzppsnlnER1KT/0+Ha8W+aKfS0TlCtu/+Ogosm08=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JG+nN05LnTOFy6soI1EJObDtJoTte6AZ56Y5PxyJ+eRy07thsAAlyZ3p9kVN+LgwAfQsG6YmQjg1xJ6VaRbrdIa7Rhr8m5qpkgzmJGZbcaWXew/fOSrwA/U6oqWSfjRqp2Y3oIgkreMntk3l8gYNPpqSapier8c6xEpYL01Meao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=VV1hLLWl; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="VV1hLLWl"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025101507210011b81276df0002075f
        for <xenomai@lists.linux.dev>;
        Wed, 15 Oct 2025 09:21:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ibt0LGOm+mhDRgfCucDn8CoO3KTwUdRsDn8bv1zzW2o=;
 b=VV1hLLWlq2SCmXNRPPsGiKs8idN5bCGJbbUhjtGhLsK9tKfUBUnWklqt8OgdcPAI9rjpm4
 wGPLqFZQZ66JzCDt0GiJfpAYXgCLrvi1/VabE0G7agSlmB0zsxEn4k0dxP8JugyMe//Z87GW
 Oj2lM5CI02qnxh33mQfcJkrE07IaDDXqIPId1rbE6ZWrXpVxoySegiLrStq5dhoiI65w15hA
 nVtNaosDqlvjev1ikeVHJyihwZBCaBu2ef/r6ZCi2/qscS7VA0bJjtgGNREtIqpZE827aECU
 +9XyrWIWOuOvlv+1PnGBoyIelORtKj3S5tQsIW7HTTk/7QAWkUYxCBTQ==;
Message-ID: <041484c388d623bbfb4832b55858083feb856ec1.camel@siemens.com>
Subject: Re: [PATCH 5/6] lib/cobalt: arm: Skip SIGSHADOW_ACTION_BACKTRACE
 over asynchronous signals
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 15 Oct 2025 09:21:00 +0200
In-Reply-To: <111db6f38a33a6d7e8a2a0b983dc244049a37d44.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
	 <111db6f38a33a6d7e8a2a0b983dc244049a37d44.1760374860.git.jan.kiszka@siemens.com>
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
> The unwinders of libgcc and libunwind prefer the ARM exception handling
> table over debug information. Unwinding this way is not designed to
> handle asynchronous signals, causing wrong backtraces in the best case
> but also too often even crashes.

Has that changed with trixie or why did this problem not manifest
earlier?

>=20
> Avoid running into that trap by skipping the request to create a
> backtrace via SIGSHADOW on ARM in case either the migration reason was a
> signal, or PTHREAD_WARNSW is enabled for the current thread. In both
> cases, the SIGSHADOW could be raised over the first instruction of
> another signal handler, causing the unwinder to fail.

Hm. Adding more arch specific code... Not nice, but well...

Does that have any effect on how debugging works or feels on arm now?
Especially any difference to arm64? I'm concerned about gdb showing
different information for the same issue. (In terms of different
instruction shown as root cause of a migration, or things alike)

>=20
> Improving the unwinding libraries themselves is likely no longer with
                                                                  ^^^^
Typo with -> worth?

> the effort for this phase-out architecture.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../arch/arm/include/asm/xenomai/Makefile.am  |  1 +
>  .../arch/arm/include/asm/xenomai/debug.h      | 27 +++++++++++++++++++
>  .../arm64/include/asm/xenomai/Makefile.am     |  1 +
>  .../arch/arm64/include/asm/xenomai/debug.h    | 18 +++++++++++++
>  .../arch/x86/include/asm/xenomai/Makefile.am  |  1 +
>  .../arch/x86/include/asm/xenomai/debug.h      | 18 +++++++++++++
>  lib/cobalt/sigshadow.c                        | 12 ++++++---
>  7 files changed, 74 insertions(+), 4 deletions(-)
>  create mode 100644 lib/cobalt/arch/arm/include/asm/xenomai/debug.h
>  create mode 100644 lib/cobalt/arch/arm64/include/asm/xenomai/debug.h
>  create mode 100644 lib/cobalt/arch/x86/include/asm/xenomai/debug.h
>=20
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am b/lib/co=
balt/arch/arm/include/asm/xenomai/Makefile.am
> index a7dd090432..8cc767030f 100644
> --- a/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/Makefile.am
> @@ -1,4 +1,5 @@
> =20
>  noinst_HEADERS =3D	\
> +	debug.h		\
>  	features.h	\
>  	syscall.h
> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/debug.h b/lib/cobalt=
/arch/arm/include/asm/xenomai/debug.h
> new file mode 100644
> index 0000000000..e49b928516
> --- /dev/null
> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/debug.h
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (c) Siemens, 2025
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _LIB_COBALT_ARM_DEBUG_H
> +#define _LIB_COBALT_ARM_DEBUG_H
> +
> +#include <signal.h>
> +#include "current.h"
> +
> +static inline int cobalt_avoid_backtrace(int reason)
> +{
> +	if (reason =3D=3D SIGDEBUG_MIGRATE_SIGNAL)
> +		return 1;
> +
> +	if (cobalt_get_current_mode() & PTHREAD_WARNSW)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +#endif /* !_LIB_COBALT_ARM_DEBUG_H */
> diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am b/lib/=
cobalt/arch/arm64/include/asm/xenomai/Makefile.am
> index a7dd090432..8cc767030f 100644
> --- a/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
> +++ b/lib/cobalt/arch/arm64/include/asm/xenomai/Makefile.am
> @@ -1,4 +1,5 @@
> =20
>  noinst_HEADERS =3D	\
> +	debug.h		\
>  	features.h	\
>  	syscall.h
> diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/debug.h b/lib/coba=
lt/arch/arm64/include/asm/xenomai/debug.h
> new file mode 100644
> index 0000000000..6ca1d42a34
> --- /dev/null
> +++ b/lib/cobalt/arch/arm64/include/asm/xenomai/debug.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (c) Siemens, 2025
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _LIB_COBALT_ARM64_DEBUG_H
> +#define _LIB_COBALT_ARM64_DEBUG_H
> +
> +static inline int cobalt_avoid_backtrace(int reason)
> +{
> +	return 0;
> +}
> +
> +#endif /* !_LIB_COBALT_ARM64_DEBUG_H */
> diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am b/lib/co=
balt/arch/x86/include/asm/xenomai/Makefile.am
> index a7dd090432..8cc767030f 100644
> --- a/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
> +++ b/lib/cobalt/arch/x86/include/asm/xenomai/Makefile.am
> @@ -1,4 +1,5 @@
> =20
>  noinst_HEADERS =3D	\
> +	debug.h		\
>  	features.h	\
>  	syscall.h
> diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/debug.h b/lib/cobalt=
/arch/x86/include/asm/xenomai/debug.h
> new file mode 100644
> index 0000000000..9d39233d12
> --- /dev/null
> +++ b/lib/cobalt/arch/x86/include/asm/xenomai/debug.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (c) Siemens, 2025
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _LIB_COBALT_X86_DEBUG_H
> +#define _LIB_COBALT_X86_DEBUG_H
> +
> +static inline int cobalt_avoid_backtrace(int reason)
> +{
> +	return 0;
> +}
> +
> +#endif /* !_LIB_COBALT_X86_DEBUG_H */
> diff --git a/lib/cobalt/sigshadow.c b/lib/cobalt/sigshadow.c
> index 10736b113f..b98e4a1d55 100644
> --- a/lib/cobalt/sigshadow.c
> +++ b/lib/cobalt/sigshadow.c
> @@ -18,6 +18,7 @@
> =20
>  #include <pthread.h>
>  #include <signal.h>
> +#include <asm/xenomai/debug.h>
>  #include <asm/xenomai/syscall.h>
>  #include "internal.h"
> =20
> @@ -43,7 +44,7 @@ static bool past_constructors;
>  int cobalt_sigshadow_handler(int sig, siginfo_t *si, void *ctxt)
>  {
>  	void *frames[SIGSHADOW_BACKTRACE_DEPTH];
> -	int action, arg, nr, skip;
> +	int action, reason, nr, skip;
> =20
>  	if (si->si_code !=3D SI_QUEUE)
>  		return 0;
> @@ -55,11 +56,14 @@ int cobalt_sigshadow_handler(int sig, siginfo_t *si, =
void *ctxt)
>  		XENOMAI_SYSCALL1(sc_cobalt_migrate, COBALT_PRIMARY);
>  		break;
>  	case SIGSHADOW_ACTION_BACKTRACE:
> -		arg =3D sigshadow_arg(si->si_int);
> -		nr =3D backtrace(frames, ARRAY_SIZE(frames));
> +		reason =3D sigshadow_arg(si->si_int);
> +		nr =3D 0;
> +		if (!cobalt_avoid_backtrace(reason))
> +			nr =3D backtrace(frames, ARRAY_SIZE(frames));
>  		/* Skip the sighandler context. */
>  		skip =3D nr > 3 ? 3 : 0;
> -		XENOMAI_SYSCALL3(sc_cobalt_backtrace, nr - skip, frames + skip, arg);
> +		XENOMAI_SYSCALL3(sc_cobalt_backtrace, nr - skip, frames + skip,
> +				 reason);
>  		break;
>  	case SIGSHADOW_ACTION_HOME:
>  		/*
> --=20
> 2.51.0
