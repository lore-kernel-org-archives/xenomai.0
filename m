Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5922CF3F
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776084; cv=none; b=YqiR7b8hAiBJY1RtqDxiumozRQyXB/U187kt7ytGLtFPEMWtthFShrVp+2ysN8xPs98bllg5zfTKH8Y/Ft0Dm6zTBbVOCRnCTaNz7l8aBEwQ03xccsFT1yI8sL0nj3kn+kETofiqH1qZcdPq9m+oqxOdWA9bisEi1CBesYL7dHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776084; c=relaxed/simple;
	bh=Jd7XIwte1SWQiBXueHAmQtVOaWElqd6Vdz+CsCMQrjw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oX7oxDipiZzFyZV7DMvImDm0BCnVZ6D4wycdUq3HbIdUcKBCbRXfLLlffzHUxKj09xi/Omq4f1KMzcEiYIA0f53rZCLhHT6xY4xGIJofGdtejy0nxDJsMNyvxx/fPjI0OwHqqbARBjMPpoJbLyQ91AIqAnjOOcxJU2OqwiE70R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jpGZEWHT; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jpGZEWHT"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250113134755c021303c9abd8a0bd0
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 14:47:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xRqbgCHEz9gg87SYxHiafIasWG1kAPJ6l0Ie4tArirc=;
 b=jpGZEWHTR+XwAdCbxGlCfRJrI2YHVM5vvuC3BhOf/MGQ9eSy2AXPmjti1MhFO3Qh00UjD+
 RPpuJI65GyMcsyKS+2XodJJNQO5IMmiFraqIlD+KE+ldtvOYWtRmiPS1HenReYo6iRrqu0f8
 g+F35u388K7f11DaK8X055vkU/FmQlLgKNNMMzll9y42WJpDSZs+s1fT7raJHNWF4G+Wr7Hu
 y9NQCPHejC9byP0JZzuQmvecvPiehQxFlKJ4uEHM5zYwwYJA3l8Rje39Eqa12QCJIT7Bd+Ny
 fZZELEAPdO/kEOEkqBKijTUfHSt6uafHg2HkJ4w2l/3V4Cg6H49r7Eww==;
Message-ID: <d27a41676b58227da5adceeaa04ca81bf0ee578b.camel@siemens.com>
Subject: Re: [PATCH] y2038: lib/cobalt: vdso: Fix runtime error detected on
 arm64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?ISO-8859-1?Q?L=E9o?= BRIAND <leo.briand@smile.fr>, 
	xenomai@lists.linux.dev
Date: Mon, 13 Jan 2025 14:47:53 +0100
In-Reply-To: <20250113134128.3132911-1-leo.briand@smile.fr>
References: <20250113134128.3132911-1-leo.briand@smile.fr>
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

On Mon, 2025-01-13 at 14:41 +0100, L=C3=A9o BRIAND wrote:
> Issue:  Runtime error on arm64 application:
>=20
>         root@ls1046ardb:~# latency
>         latency: __vdso_clock_gettime64 not found in vDSO: No such file o=
r directory
>=20
> Reason: Due to changed __USE_TIME_BITS64 behavior the vDSO init fails.
>=20
> Fix: Adjust the vDSO configuration to correctly handle the selection of
> `__vdso_clock_gettime64` or `__kernel_clock_gettime` depending on the env=
ironment.
>=20
> Impact: Resolves runtime errors on ARM64 platforms caused by incorrect vD=
SO function
> selection, ensuring compatibility with 64-bit and compatibility tasks.
>=20
> Signed-off-by: L=C3=A9o BRIAND <leo.briand@smile.fr>
> ---
>  lib/cobalt/arch/arm64/include/asm/xenomai/time.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobal=
t/arch/arm64/include/asm/xenomai/time.h
> index 9577aa773..06992e709 100644
> --- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
> +++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h

ARM has a similar left over.

Seems I missed that during the last checks against recent libc
versions.

> @@ -12,7 +12,7 @@
> =20
>  #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
> =20
> -#ifdef __USE_TIME_BITS64
> +#if __USE_TIME_BITS64 && __TIMESIZE =3D=3D 32
>  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
>  #else
>  #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
> --=20
> 2.34.1
>=20

