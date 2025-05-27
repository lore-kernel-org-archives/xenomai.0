Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCD770E2
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351907; cv=none; b=Esnm52FCBsItYO/LxnebCrqKSrbINmtKeaOzln507LwsGBU1nvsOt63dE+WlilfI39354Khw6U7NOFK0fVV5nKgF+NYspcXM6AvMQUxtgUlvDE1ej1nAkMaxEvsWUZZEjh9XLVRYvEEm3tbxI3SEawWgHzLi6cPydnTd4VhnbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351907; c=relaxed/simple;
	bh=SmwRmsRaOksTNUoT0SS/iRNpWK6B/zln6XixA4I9vII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRXEh7SAEfVslN0tmizo0CzhOEwTybPJEzFwsU1WoLXthofoYojK1NVjsdg7FepVnmPx2OGJCTk7a0R2S9gzI2yd4FY9oaKSbGPDEH1nJWgiQz/ZjDoRH2vabpIjgbr8Bz/usm8wixSB/wMVOaLaT3OMw4s+p2OfpIBvIbmv15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=khtMEFYx; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="khtMEFYx"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250527131811f004b8687c9d60a0d3
        for <xenomai@lists.linux.dev>;
        Tue, 27 May 2025 15:18:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=T0YhCBZIwCIVVAoGqDxVns501aKzKiuGCKzoOynFqus=;
 b=khtMEFYxGEnQ6PTxnERtwUrLHniW0KZw7EvqEms/QpTnhAGBpUiN7ozc1Y07ShH+6/tRqo
 9MfKOPxeqidm7QRLnRKPBYEsXMnY5//pu0eFteFdrlS8i3OFXi8P/RA0SolJlojd43BrGUBE
 jlVFG4ekuum0dabs57NYOAWNRb25rszKtmDT0LWU4OAnIaNuwWtJ/9JkfKBW074DUdyrWLc4
 W+zm99x8Zz6rdty52kcI6E88sWF1JmiGq2JgV8NtSyySXO3yQje44KVwnBTm1P3Wo6nu4ebP
 SZRXfprFCuuF6BA+fL1tUPsnqoTXJOc//GodCKe083ubo7aCE6YHEaKw==;
Message-ID: <569ce07695ba9d09a81ae8b521e1a072fc5283ea.camel@siemens.com>
Subject: Re: [PATCH v2] cobalt/posix/clock: Allow NULL resolution on
 clock_getres64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: chensong <chensong@tj.kylinos.cn>
Date: Tue, 27 May 2025 15:18:11 +0200
In-Reply-To: <00e27ff6-15e8-4b24-9c2b-181755ec2cba@siemens.com>
References: <00e27ff6-15e8-4b24-9c2b-181755ec2cba@siemens.com>
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

On Tue, 2025-05-27 at 14:59 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Permitted according to POSIX spec. Adjust the testsuite accordingly.
>=20
> Fixes: 633022801750 ("y2038: cobalt/posix/clock: Adding clock_getres64")

Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Changes in v2:
>  - also adjust the test case
>=20
>  kernel/cobalt/posix/clock.c            | 2 +-
>  testsuite/smokey/y2038/syscall-tests.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
> index 845918a4a1..e6c187ca40 100644
> --- a/kernel/cobalt/posix/clock.c
> +++ b/kernel/cobalt/posix/clock.c
> @@ -103,7 +103,7 @@ COBALT_SYSCALL(clock_getres64, current,
>  	if (ret)
>  		return ret;
> =20
> -	if (cobalt_put_timespec64(&ts, u_ts))
> +	if (u_ts && cobalt_put_timespec64(&ts, u_ts))
>  		return -EFAULT;
> =20
>  	trace_cobalt_clock_getres(clock_id, &ts);
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2=
038/syscall-tests.c
> index 7b56d281a6..4318712cc4 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -363,13 +363,13 @@ static int test_sc_cobalt_clock_getres64(void)
>  	struct xn_timespec64 ts64;
>  	int ret;
> =20
> -	/* Make sure we don't crash because of NULL pointers */
> -	ret =3D XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
> +	/* Make sure we accept a NULL pointer */
> +	ret =3D XENOMAI_SYSCALL2(sc_nr, CLOCK_MONOTONIC, NULL);
>  	if (ret =3D=3D -ENOSYS) {
>  		smokey_note("clock_getres64: skipped. (no kernel support)");
>  		return 0; // Not implemented, nothing to test, success
>  	}
> -	if (!smokey_assert(ret =3D=3D -EFAULT))
> +	if (!smokey_assert(ret =3D=3D 0))
>  		return ret ? ret : -EINVAL;

Seems a pipeline run revealed the missing test adjustments ;-)


>  	/* Providing an invalid address has to deliver EFAULT */
> --=20
> 2.43.0

