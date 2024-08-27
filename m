Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6F19D06D
	for <xenomai@lists.linux.dev>; Tue, 27 Aug 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750139; cv=none; b=Hd57A6ZuVlBr37KtuTCIeeyJmGY5cHJrNvtputeVZZy2Sjc9yAQ0xY6SiwsDiK61a+G5d1keG1aFVYc463s+9EmWZN25AGrCFWHmCkpUF2wEenm+QQbcQhCDKS0UIbKrQClmtQMWQrr3TlbdTzGGuG1SKTRMA4VWl2WhSTMY2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750139; c=relaxed/simple;
	bh=gQsimr+PAnsEiUPzhpJ3dak77uhB1JW7cLc+o+sQnIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CsgYbhYIwGL6irrR8l0zkq63tUihPdyqd8cCefX08lRoN2JTN6Z/GcsocqaKRPxEaFF+kioSBF0OiuAr3HCRvdRhrlAObv5ChChMfIpZOPP7aaezxjWAcqGsZyC+JEflR8bPKpHuXIiiOyzjEeRHzCImNPCmnsXQaimCI1nRgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=YLVP9+DB; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="YLVP9+DB"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202408270915308755bffe079cda1901
        for <xenomai@lists.linux.dev>;
        Tue, 27 Aug 2024 11:15:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mCdaLYuB3PyeZ1rR1VEz71MmlIO/JtBVfzQSgq+N0L0=;
 b=YLVP9+DBdQGVmf7ut8IiArGG6Hm+bQsfWcttlekvJ5vQSUR6UuowBpVpkC1xqht9OJh5GX
 wFirCe0w5oUEHKf9OuDItrCUVxR+2Y2r2Kkp7kEcfoGEoQpkEQpeYDsGBQQ0uF/XwkV9eWHQ
 LHvW0o72AEIIJLOWwYX2KPcpcUk85xuL8oYsxKle5VQr22SqLyDfdbKsYOjjGwGKUPrpK3da
 4QFKd+lE2Y37M4e/gS63U4zO11W4RdrJJx0pDP9cm36jyL+DRsJcbCESkax3TFOt1e5/f9T8
 K0KaAv0apjksyw0kFkmxjzyB4L9GIM1CgTO+Pgc+/SaEMImDOeaTydSQ==;
Message-ID: <616b40879c0563a56bc8119efd8b10f66562f0bd.camel@siemens.com>
Subject: Re: [PATCH v2 3/4] alchemytests: Set cpu-affinity by env var
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
Date: Tue, 27 Aug 2024 11:15:29 +0200
In-Reply-To: <20240827084521.13547-4-simon.graber@sigma-star.at>
References: <20240827084521.13547-1-simon.graber@sigma-star.at>
	 <20240827084521.13547-4-simon.graber@sigma-star.at>
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

On Tue, 2024-08-27 at 10:45 +0200, Simon Graber wrote:
> The alchemy test runner can now make use of
> the XENO_CPU_AFFINITY environment variable by setting it before
> dispatching to the inidvidual test programs.
>=20
> Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
> ---
>  testsuite/smokey/alchemytests/alchemytests.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smo=
key/alchemytests/alchemytests.c
> index cf9f970f1..edbafe6e7 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <string.h>
> +#include <stdlib.h>
>  #include <smokey/smokey.h>
> =20
>  static const char * const tests[] =3D {
> @@ -31,12 +32,19 @@ static const char * const tests[] =3D {
> =20
>  static int run_alchemytests(struct smokey_test *t, int argc, char *const=
 argv[])
>  {
> -	const char *args =3D "--vm --cpu-affinity=3D0";
>  	const char *const mod =3D "xeno_rtipc";
> +	const char *args =3D "--vm";
>  	int test_ret =3D 0;
>  	int ret =3D 0;
>  	int tmp;
> =20
> +	ret =3D setenv("XENO_CPU_AFFINITY", "0", 0);
> +	if (ret !=3D 0) {
> +		fprintf(stderr, "%s failed to set XENO_CPU_AFFINITY: %m\n",
> +			__func__);
> +		return ret;
> +	}
> +

Is there any side-effect that I don't see here? The result seems the
same... My question is: Can't we drop this patch?

Btw: If we set something, we normally have to clean it up / unset it
again. Can we safely skip unsetenv() here?

>  	/* Try loading the xeno_rtipc module as the pipe test depends on it */
>  	tmp =3D smokey_modprobe(mod, true);
>  	if (tmp)
> --=20
> 2.46.0
>=20

