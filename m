Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003685;
	b=yHsYy9coVYwuTz832MIfRc4Sc5lsaCrKTu2lB3hXhOXiut2qF6LexoYoomzCR+yUgEA/
	 WiC/yrG3AAKONjuhRXv+oqEOUSROE+piNFfzDmf4t3YQClkNRVzH0OinH7YNqInEAe8Up
	 tdmWqgDjHquqFLQSI2Z9XBnA1iIeerFsjTijjLMey96/IyLqRWe0RRrdybDMY4S1Z95GW
	 HBn4lIhIjdlm1FITyi08AlwPwyV8ltl4MbRrhBWEzPTsWwyC5KEQvsFtve0FHxkvj6WlN
	 KpwyzSgkN/6AcBsDzM0w5o9S0WXvN3j02sU56Srjt4yjw+/Jdv6gOoVOtT/T00hUZFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003685;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=bJCAEj0/qscdMnok7QouVWtUINr2f/Yl28y+7noOk8s=;
	b=to/+tzH64mTp+o7gsZ6G8mAm4OniilbuZAujkV4PgrszAvXFzRHIhMsnEXlSCQ27lscI
	 xR50WA28LNqa3j9AO0ypWNm1bDn7rmT9PuKkMV7tcIziOXTCmZbwrUG1XGJznfnIKBfrB
	 kmncGMclSaatfsfAlfKbwmG9Ea5BdeLdYRRQQclFugDn2ntLjW8CS3YTXGeYK4/tmsTmK
	 u8lU9SmGvFTAwTt3uz+SmPflo6pIG168iBv1dg4z/JWve8dxa61adG7Zdm8mglPFMpCvx
	 Gsm9ZGwGIbNv+dCNWcZiILUzLH5KFRSFIuZwvfyYKLaO3wyMxFHZevO4sCMGkR+8TXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=EU48s5KR;
	arc=none smtp.remote-ip=185.136.64.225
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6D9606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 12:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=EU48s5KR
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202611181208011a8616029c00020782
        for <xenomai@lists.linux.dev>;
        Wed, 18 Nov 2026 13:08:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bJCAEj0/qscdMnok7QouVWtUINr2f/Yl28y+7noOk8s=;
 b=EU48s5KRHtr5NdVA8klfD5B31stiVzAh5ShUB3ZBViIKMv0xSr6OI2VQOMFYe382oMcc0c
 oJRQKdpN0KrdrWr9KEXjZjPrKpOWSdBE3ySNlLoYub3UBOELOIDXqeZ8B00zxpwrCG0W3R2E
 tWJLw3nMOa8fdO1lX4bhR7ai0y8yW3NhHraXGrocPQEJq3L91DhK543jfcNJtPqLS8KAlCVf
 ktFApae5+PGaSV+KOv7XPwLJ4BQfgyQzfZKQ5Cv+sHGSXAz/+vIkHfImws5iG1mB59Zn8sq1
 8/w9ZPPrnM3PCkC7Xk4vyOEikyEHpBu9N8iaKASHzrtrEDVnTS0feCAA==;
Message-ID: <44c1d4813cc5a3da086e98037afc254007d21dde.camel@siemens.com>
Subject: Re: [PATCH 4/5] testsuite/smokey/alchemytests: Add missing includes
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 18 Nov 2026 13:08:01 +0100
In-Reply-To: <20261118114909.3030884-5-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
	 <20261118114909.3030884-5-yegorslists@googlemail.com>
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

On Wed, 2026-11-18 at 12:49 +0100, Yegor Yefremov wrote:
> With the Mercury core, the alchemy tests fail to build, as some
> declarations are only pulled in indirectly by the Cobalt headers:
>=20
>   alchemytests.c:43:17: error: implicit declaration of function 'fprintf'=
 [-Wimplicit-function-declaration]
>   alchemytests.c:43:25: error: 'stderr' undeclared (first use in this fun=
ction)
>   task-2.c:34:17: error: implicit declaration of function 'compiler_barri=
er' [-Wimplicit-function-declaration]
>=20
> Include <stdio.h> and <boilerplate/atomic.h>.
>=20
> Fixes: 61fc9ff4b721 ("alchemytests: Set cpu-affinity by env var")
> Fixes: 10d898c40e26 ("alchemytests: Fix task-2")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  testsuite/smokey/alchemytests/alchemytests.c | 1 +
>  testsuite/smokey/alchemytests/task-2.c       | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smo=
key/alchemytests/alchemytests.c
> index b596a1e17..bd01fe227 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
>  #include <smokey/smokey.h>
> diff --git a/testsuite/smokey/alchemytests/task-2.c b/testsuite/smokey/al=
chemytests/task-2.c
> index ca2225ad7..80ad90bc7 100644
> --- a/testsuite/smokey/alchemytests/task-2.c
> +++ b/testsuite/smokey/alchemytests/task-2.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <boilerplate/atomic.h>
>  #include <copperplate/traceobj.h>
>  #include <alchemy/task.h>
>  #include <alchemy/sem.h>
> --=20
> 2.34.1

That one might be still relevant. But: I'm wondering that you did not
run into another build issue:

There is a include-refactoring branch (not up to date right now, will
try to refresh it within the next days...) located at=C2=A0
=09wip/flo/refactor-includes

That branch holds the following commit
https://gitlab.com/Xenomai/xenomai3/xenomai/-/commit/454ae865105807f2fcd499=
01c618f224f3dcab34

I'm quite sure that this is also required for !cobalt.
