Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334025A2D1
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102199; cv=none; b=C6CDTNOTlgt+FUu6aXLXu+/BXql1issR8tpDeh8+aXTcPhdZORF43ItKSwl1LfJ7z99KSA6bCS1/0A+pUQSB2AdFYvD8vwXIJKyaYmZ/0+SHGdCVDpq67pkHgAIqWNG64lg0BKx66yv52qazIF9/vU1wg9KUo8KtS8DgF1uqcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102199; c=relaxed/simple;
	bh=LM8sGwxi+EQOCloMYbEFLvKvK2wGWvJmOtCJp1tUctU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aB+xa5ryA1LU3VOyRyYXjtmFPRkmK+IFSkq0Vn6nODVnP8qcw162zLDb0vXOZtF41KPpFasLjjnuOv4PAekTzHDtr+NZ4xmcwFCHo7S4H6RxxSJMR8qDmCyKtMQFvuEnOeD8klFGd+HeWahRqYYyS54pIrJGIi4dGgjsPNHA5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=N9uw9XpP; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="N9uw9XpP"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025101013162401f9177f1e0002074b
        for <xenomai@lists.linux.dev>;
        Fri, 10 Oct 2025 15:16:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=n4J3XucUq/VC4GWbQ1kEdhjvJn/ag3LgNarqPQ7T+1A=;
 b=N9uw9XpPe4W9VdOCfQs/KzrUoOm2f/Ql30ZmXjCL5u4S4X+eKU1pI0A48kVg9S86aAamJM
 8FQNFAlYIRkkRdhSYQc8iU+8oEIqkNUvEiWKqv+HmH4wPZLprSH13pzbYrvxy0hfMaeye98o
 Y+M+j3j8C5Kg0AZsWwPuv/EJ5O3W7Hp6DDDpaM3p9yjK0E4YfHadUBchu9vlJsJetegYjj7y
 g17e5XGJOhhhWnGfJXa4Ephvvvf1geTE4On2WOqkovhxSxllppLqzJzk9JkV6LyvbGbFkmdR
 jnweMFinKYq01ECHKCJwjDYWfU2U37sXeSChZx/9XAgWP9eUwkusYOIQ==;
Message-ID: <0e60ea350929090e70354a5ff705348f441ea15a.camel@siemens.com>
Subject: Re: [PATCH 1/2] linux-xenomai: Add arch specific debug kernel
 configuration snippets
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 10 Oct 2025 15:16:24 +0200
In-Reply-To: <20251009111228.3504354-2-tobias.schaffner@siemens.com>
References: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
	 <20251009111228.3504354-2-tobias.schaffner@siemens.com>
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

On Thu, 2025-10-09 at 13:12 +0200, Tobias Schaffner wrote:
> [snip]

> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linu=
x/linux-xenomai.inc
> index 8c7df40..501c212 100644
> --- a/recipes-kernel/linux/linux-xenomai.inc
> +++ b/recipes-kernel/linux/linux-xenomai.inc
> @@ -16,9 +16,10 @@ FILESPATH =3D. "${LAYERDIR_xenomai}/recipes-kernel/lin=
ux/files:"
> =20
>  XENOMAI_DEFCONFIG =3D "${DISTRO_ARCH}_defconfig"
>  KERNEL_DEFCONFIG ?=3D "${XENOMAI_DEFCONFIG}"
> +KERNEL_DEBUGCONFIG =3D "${DISTRO_ARCH}_debugconfig"
>  XENOMAI_DEBUG ?=3D "0"
> =20
>  SRC_URI +=3D "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCON=
FIG') =3D=3D d.getVar('XENOMAI_DEFCONFIG') else ''}"
> -SRC_URI +=3D "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') =
=3D=3D '0' else ''}"
> +SRC_URI +=3D "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI_DEB=
UG') =3D=3D '1' else ''}"

NACK. This switches all the CI builds to no-debug.

We need all the debug flags enabled for CI builds.
Otherwise, we risk to loose really important debug information.

no-debug builds, for example for performance measurement purposes need
to disable the debug settings, not the other way around.

> =20
>  S =3D "${WORKDIR}/git"
> --=20
> 2.43.0
