Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004172;
	b=BKGVqw0xq5z3zwbe1LfC26OhMMfcRymyo0kTLb3yEPMAKvaH+qSZo+EMKhtNggEyUNqx
	 jiJfN7KD4+0L3VBj2zwGMnUbkh3NeRXRz3UumzGWuu43eCooSfgq9GZ7UKR8q+NC2UFHA
	 KZy2ew/3M07UFFacE1+1HP2K2UN27ukT6etPoX0ZbxaR8bftjOJ9fKtc5dBf1uaf5fa/Q
	 1qoNhEjuUHYkP7MPnD4ZkClWtiot223fKzNPNyPI9jwkw1BuBK7n+kL/w/YB8JmD2Ku67
	 k2i/1iNkxbtKO+Fa4rlFJChZBmunKZGYV41KVO6wI8xvmGgXq/jwElkIdGURXzvJwVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004172;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=1oCIebrUrZC4GhpGy1AfSARNzHHJ116FukUCL63Nm1M=;
	b=2KiCwk3/Q8kUN0xYezrhaUfFSNJ5bp7ZpAihfQu8VoRX88gyuYqfB9wFEb3iQGPYtXyT
	 tyuKIm130faF+DVRCV2EPIelKl952r3oAN9W3LOFAAg5L/Rtlcaa/tfwzweBBNqxRFOPQ
	 Gqx/ZvgvRIESfzrxEFLNrOitXk56e8a5Oovi8NlLOz2bdJwpGiBXtRtQKhNMHdOLpLKR3
	 jBynXAjb3YsurfPBO4yxhxIcE3tslG9xol25ukfICQKnANI0ezeVe2+tjj1jfrM2dJiIQ
	 eezLUQiIMppMbVWxMDQEANG0xjDKCQb9UspX3H6DLnGF5FYPha60HbGKDbmLW423lmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=pAFLr8kC;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96B606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 12:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C96B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=pAFLr8kC
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202611181216080ae691e92f00020750
        for <xenomai@lists.linux.dev>;
        Wed, 18 Nov 2026 13:16:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=1oCIebrUrZC4GhpGy1AfSARNzHHJ116FukUCL63Nm1M=;
 b=pAFLr8kCHblpjkJNbiVfCj2ZoCNF4B3UrwiygRsSqCsNfmNHgnNUOZlHZwq/lDGf/+Xhl8
 hzSP1yzR4K7KB+ZK2BT50mXI0oIpDF88xC24Le8AUP6XTtXipfpTqpq1opk767Rqk8TEJrAw
 Q1XVJldzOha2kpNEahSyVhgBA8isRyqeemygDEjuFH7uDCGcWKeMDAoJYB3HA8JMgYqA54fd
 vcfIZAn7ypywEJzwgXvcJaViHUO0dgffocOvN038xwgF3NC4TmvId2/LVbNdtur/S00HS+2w
 qOKBWzVmh8zBiEAfOcTsUHzWNRDloMjnJT7LtPuFeGgxtI3Yxy5BYujw==;
Message-ID: <7d4f783056f468eda3bb1dd7796c875d674ab9d0.camel@siemens.com>
Subject: Re: [PATCH 1/5] lib: Restore includes needed by the Mercury core
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 18 Nov 2026 13:16:07 +0100
In-Reply-To: <20261118114909.3030884-2-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
	 <20261118114909.3030884-2-yegorslists@googlemail.com>
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
> Commits 41de7cc7196f ("lib/boilerplate: Cleanup includes") and
> 7b7ddf4a3658 ("lib/copperplate: Cleanup includes") dropped headers
> that are still needed. With the Cobalt core, they get pulled in
> indirectly, but building the Mercury core fails:
>=20
>   setup.c: In function '__xenomai_init':
>   setup.c:606:23: error: implicit declaration of function 'mlockall' [-Wi=
mplicit-function-declaration]
>   setup.c:606:32: error: 'MCL_CURRENT' undeclared (first use in this func=
tion)
>   setup.c:606:46: error: 'MCL_FUTURE' undeclared (first use in this funct=
ion)
>=20
>   internal.c:108:24: error: '__NR_tkill' undeclared (first use in this fu=
nction)
>=20
> Include <sys/mman.h> and <sys/syscall.h> again.
>=20
> Fixes: 41de7cc7196f ("lib/boilerplate: Cleanup includes")
> Fixes: 7b7ddf4a3658 ("lib/copperplate: Cleanup includes")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  lib/boilerplate/setup.c    | 1 +
>  lib/copperplate/internal.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
> index 7bb24f6f4..7b21c0f1a 100644
> --- a/lib/boilerplate/setup.c
> +++ b/lib/boilerplate/setup.c
> @@ -17,6 +17,7 @@
>   */
> =20
>  #include <sys/types.h>
> +#include <sys/mman.h>
>  #include <sched.h>
>  #include <getopt.h>
>  #include <string.h>
> diff --git a/lib/copperplate/internal.c b/lib/copperplate/internal.c
> index ed3f2e4fa..039767721 100644
> --- a/lib/copperplate/internal.c
> +++ b/lib/copperplate/internal.c
> @@ -18,6 +18,7 @@
> =20
>  #include <sys/types.h>
>  #include <sys/prctl.h>
> +#include <sys/syscall.h>
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <pthread.h>
> --=20
> 2.34.1

Could you please check if that mercury staff is covered by the=20
wip/flo/refactor-includes branch (which is not complete yet and will
most likely look completely different for the next revision)?

If those includes are needed for a special build configuration they
should only be included for exactly that configuration.

Specific for this patch: If those includes are only needed for a
specific build variant: Guard them with the correct #if/#ifdef as
needed.

Florian
