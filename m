Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F511C5D44
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104529; cv=none; b=JI+9wbrNL31aIuKSDJO29BIcbDYE1ClOa+f/egNagT3lA7AjTtTtMEtpOs2L2AyOfeJC7TV2SjGGy1efCBlMwfEshPY1pdRCAye4/o/58G2fJPGfapD9mMmewcjnDS4tiB3gDVSHkIleevJeMhxzCUNX65yrNas2PiQhPOm+2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104529; c=relaxed/simple;
	bh=q7TNv0Og7roZyjxtzowtCMvOMYtdua4jSo6nCFZhGWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RZzwY1NigAMUXr57eNTjxPNC3NxpSGg0xlRC+NaGpvfpxHob0br16WlhiFgOL2GxlnOXqJC/R3kDUkudLxhnVN4Mf+1EBBAHmvM0f6RhW7SnnMLRzaB5LcO5ZIqXvXKcG3qG3wskuhgMkpAbflRMgJSQ4GRsEM72Hiq5nYOC8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=lELvqyfA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="lELvqyfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760104525; x=1760709325; i=jan.kiszka@web.de;
	bh=HrSMSWX15dqDCVUh4p4Asd7Y4o4YHE7xw6qM4onlTCk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lELvqyfAPMFk3R78rS0MNxRlwsnunovpcWDKe9okRC9U2OB8lOHWtNRm4GP8ur+n
	 9KTuOTzdGOTzLEDJLTkuwj0udSTMSICJS7QoWHlBbsBknlBHSypp60vCvJD+ZxZAI
	 jAqGpawCNvf8P+yGLNxfF1dXW2RZSLeyhip12LrPNhKrbSk1vbjrs3F/tQ6pU+D9r
	 pqU8Y/mc4VAqE+axhRKxRcEhXV2Cz5ZJnpPrKkaB51Glovv2V/EnytiNOgJWzYWIf
	 WtrKv6A6UpnkWOridfQYuB9yHI9emX8peBytsm6jBwDbBfShyHF5aw00DYui4Xrle
	 KuvYkGy0BAvVTU3ytA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([188.108.202.214]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRYd-1upxxH3lq7-00IAcr; Fri, 10
 Oct 2025 15:55:24 +0200
Message-ID: <2225a246-5cc5-45aa-a5cd-8434065ff69a@web.de>
Date: Fri, 10 Oct 2025 15:55:24 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv64: Add support for RISC-V architecture
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20251010101717.3759565-1-tobias.schaffner@siemens.com>
 <20251010101717.3759565-2-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <20251010101717.3759565-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EUi4hVNQcmkyJORDLDTTl3mfWqrn7RYi/hbmETfWYn0ri1s32nz
 gOZ9V6HrXekQkIIEsBmZGyAS7OlDUJs7aYQxTm14cWvwS08lyo2ttiaaP8YntQWI0FWihWB
 i39UxbMzzaL7ZlvaF/P2lSC/3Ifh2S1+0V8WY4VAZ2zTC4F8lEhpF6aG5/p6kU3yZKNrQNS
 wIx4hqMDZJJPrzu7Kiumw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EPUZOXUcAXU=;m1fcMyvFkc+TlQ2wI/rScNGeXtt
 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
 dsiAQ==

On 10.10.25 12:17, Tobias Schaffner wrote:
> Introduce support for building EVL for the RISC-V QEMU target.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  Kconfig                                      |   12 +
>  conf/machine/qemu-riscv64.conf               |   14 +
>  kas/board/qemu-riscv64.yaml                  |   15 +
>  recipes-kernel/linux/files/riscv64_defconfig | 7378 ++++++++++++++++++
>  4 files changed, 7419 insertions(+)
>  create mode 100644 conf/machine/qemu-riscv64.conf
>  create mode 100644 kas/board/qemu-riscv64.yaml
>  create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
>=20
> diff --git a/Kconfig b/Kconfig
> index a3e3885..23d5f4a 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -17,6 +17,9 @@ config ARCH_ARM
>  config ARCH_ARM64
>  	bool
> =20
> +config ARCH_RISCV64
> +	bool
> +
>  choice
>  	prompt "Target board"
>  	default TARGET_QEMU_AMD64
> @@ -41,6 +44,10 @@ config TARGET_QEMU_ARM64
>  	bool "QEMU ARM64 virtual target"
>  	select ARCH_ARM64
> =20
> +config TARGET_QEMU_RISCV64
> +	bool "QEMU RISCV64 virtual target"
> +	select ARCH_RISCV64
> +
>  config TARGET_HIKEY
>  	bool "LeMaker HiKey"
>  	select ARCH_ARM64
> @@ -58,6 +65,7 @@ config KAS_INCLUDE_TARGET
>  	default "kas/board/qemu-armhf.yaml" if TARGET_QEMU_ARM
>  	default "kas/board/beagle-bone-black.yaml" if TARGET_BBB
>  	default "kas/board/qemu-arm64.yaml" if TARGET_QEMU_ARM64
> +	default "kas/board/qemu-riscv64.yaml" if TARGET_QEMU_RISCV64
>  	default "kas/board/hikey.yaml" if TARGET_HIKEY
>  	default "kas/board/rpi4.yaml" if TARGET_RPI4
> =20
> @@ -65,9 +73,13 @@ choice
>  	prompt "Xenomai version"
>  	default XENOMAI3
> =20
> +if !TARGET_QEMU_RISCV64

no, rather...

> +
>  config XENOMAI3
>  	bool "Xenomai 3"

depends on !ARCH_RISCV64

BTW, we will likely have some kernel version deps as well, won't we?

> =20
> +endif
> +
>  config XENOMAI4
>  	bool "Xenomai 4 / EVL"
> =20
> diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.=
conf
> new file mode 100644
> index 0000000..65c1a53
> --- /dev/null
> +++ b/conf/machine/qemu-riscv64.conf
> @@ -0,0 +1,14 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require qemu-machine.inc
> +
> +DISTRO_ARCH =3D "riscv64"
> diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
> new file mode 100644
> index 0000000..a659c2b
> --- /dev/null
> +++ b/kas/board/qemu-riscv64.yaml
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: qemu-riscv64
> diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kern=
el/linux/files/riscv64_defconfig
> new file mode 100644
> index 0000000..c57065e
> --- /dev/null
> +++ b/recipes-kernel/linux/files/riscv64_defconfig

Is this a real config, not a defconfig, right? Is that needed?

Jan
