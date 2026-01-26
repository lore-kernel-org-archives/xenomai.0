Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719623A58F
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445094; cv=none; b=SazPdh/0Piu0sQLbOP/NET2rB/AN8zOciJDo/9gD5NuYn0lYVQ+OWsXXGOeIU13cEdgTR0kmkPoUzBgxqMy/yr5JNdeQrtloTDtCfp34GRnpio9FVvdx2G8px5FzvacZlbovJdZJBCmmKowNk1khtQGiqsrqNwygaJwYvmtnpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445094; c=relaxed/simple;
	bh=o+pNjJHuePgo29F9vV7bsbetQqnAaFNXl3GgP/ZYZ7Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOGhOmyUJ0r3H+0nyAgNF2r+AUGaFe2NUXlTget/ubpfZ52w3bQr1PyL3YKwD32trxQ2EX9bs/OFeR+uxKgCx8zpQdsXdHvXNWl5fS/Apfyr9gUncPd3IF92q1Yx5/fxc3adgOPzbtLitNYeYB/PiQt/1OCPCzUO1uEqqi18Kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Fz50tkWK; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Fz50tkWK"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260126155111535265f0a0000207aa
        for <xenomai@lists.linux.dev>;
        Mon, 26 Jan 2026 16:51:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=F749bKB2i3RsOxibbww/h/S88/9q2iDFV8TA2GU2cNw=;
 b=Fz50tkWKehG3y+Ye1UMJ3pnrAtzggyYd8A6Z0+EvD7QLpWdCsI4kQHBCKgcTPBM8F2Tr5B
 ULGZACcLq+A0/z5z0tTIkbby1Mkpx4vDHmd3e7w0QgvQksZ1jCYa1k8JtS2lBukF+hj/Y8zM
 fxMJtO4gajYZV177XjYFWbfnmwTZNAH+cyWahwyn985eF02TV48RTnRrJrSCZDlrhrSpp00f
 qf8ARQTTHCMPQgECqL2UfyqeiF7QOr2+jNGOaxbzqrZMHDI3ziTX9Qr54Ee3lWt7cZWqerI2
 M1oWqfw857bQXahaUAbmmzJ2LBIAAgY4c397svXSONvHY8ZqvWHqK7nQ==;
Message-ID: <8a26646d6b3592c7d0ab476d4d2819c3ca7d225e.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH] linux-xenomai: Fix armhf defconfig for
 BeagleBone Black
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Mon, 26 Jan 2026 16:51:11 +0100
In-Reply-To: <c2020c95-48c9-4dbc-b0bd-fa2371c0f916@siemens.com>
References: <c2020c95-48c9-4dbc-b0bd-fa2371c0f916@siemens.com>
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

On Mon, 2026-01-26 at 16:01 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> In 6.18, the kernel's dtb for the BBB drop "ti,omap3-uart" from its uart
> compatibles. This now directs serial support the 8250_omap, rather than t=
he
> already enabled omap-serial driver.
>=20
> Furthermore, we need to build-in the MMC driver since trixie because the
> default initramfs will no longer include that driver as module.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Florian, maybe this also resolves your BBB issues with 6.18-dovetail.

Yes. CONFIG_SERIAL_8250_OMAP is the important one in my case.
Thanks!

>=20
>  recipes-kernel/linux/files/armhf_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/=
linux/files/armhf_defconfig
> index 7f370b9..ff8908d 100644
> --- a/recipes-kernel/linux/files/armhf_defconfig
> +++ b/recipes-kernel/linux/files/armhf_defconfig
> @@ -2748,7 +2748,7 @@ CONFIG_SERIAL_8250_FSL=3Dy
>  CONFIG_SERIAL_8250_DW=3Dy
>  CONFIG_SERIAL_8250_EM=3Dy
>  # CONFIG_SERIAL_8250_RT288X is not set
> -# CONFIG_SERIAL_8250_OMAP is not set
> +CONFIG_SERIAL_8250_OMAP=3Dy
>  CONFIG_SERIAL_8250_MT6577=3Dy
>  CONFIG_SERIAL_8250_UNIPHIER=3Dy
>  # CONFIG_SERIAL_8250_MOXA is not set
> @@ -5209,7 +5209,7 @@ CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
>  CONFIG_MMC_SDHCI_PCI=3Dy
>  CONFIG_MMC_SDHCI_PLTFM=3Dy
> -CONFIG_MMC_SDHCI_OMAP=3Dm
> +CONFIG_MMC_SDHCI_OMAP=3Dy
>  CONFIG_MMC_SDHCI_OF_ARASAN=3Dy
>  CONFIG_MMC_SDHCI_OF_AT91=3Dy
>  CONFIG_MMC_SDHCI_OF_ESDHC=3Dy
> --=20
> 2.51.0
