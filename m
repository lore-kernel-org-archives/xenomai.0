Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A354A02
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113681; cv=none; b=uPHUV85DVnRWmoMHOis4A7UfOngBHsg66Lb9zNfdKNhTuR5SP1Frcx+q49a4d5gO1tlmAxf8pA2vD9WeYY13vS9oGM3VY30Q6ndCr9ur6QKwgx6e17oRakTM28StFzqKfkGp7H6nlilUWuinC0Rt9NOqku9drsJNxFUARb3jZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113681; c=relaxed/simple;
	bh=8i8Sdf5SzfS9B6zqLZNmcXWnOcEy/JN8wn/g11oQmTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TJSURPBD4roB/1RLRfhVOFrTKDb+ZSodeyacj1DmJbf/HwP8gfIqEk0d4Hc6R0N0pu7EZaqRxT+yM+Cugr+Q92GcIHBishDllXoVpp1wao9U2c53ioD79ARqwGpkDKARm2foIVjmJcxxSkQeHALxfbOXL08Nbz7GeGcI3GzTSxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=utUM//L4; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="utUM//L4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760113670; x=1760718470; i=jan.kiszka@web.de;
	bh=8i8Sdf5SzfS9B6zqLZNmcXWnOcEy/JN8wn/g11oQmTg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=utUM//L46yt2lGKcqs3zd5NBfQg9jQN4NzUF4/TLVx5jN+eVGnFnwU/WDv4bWv76
	 nOSNDor3OxT25yzBrNlHWt/8Yrn/RgklE9DyPTEzt1yCc/gOkRgWybloztW2Jj3Of
	 HZ/hWEy2wo874pg7bPyQh7OMlap6fY0YkPAWzJHRJpziDtwbbKGdpJuruRQsLUIrV
	 Utqk3Dto+vPvB65tbiWX3oxs7LY50B9UabLvGE+4wRKiJRmfPbAea3Pc0cgRw2P8H
	 9pfJ0tgha3slqMPw4yKo6LdhDvDNIi5H7e7F7Zd1/SSPpfW9yTqVmY9gBiMjg6G0s
	 xta0nVMEB0d2OY2XMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.31] ([188.108.202.214]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1uZ1DH2vJN-00lmjN; Fri, 10
 Oct 2025 18:27:50 +0200
Message-ID: <962e5de9-5659-4a3e-bbf3-d408a14e21f1@web.de>
Date: Fri, 10 Oct 2025 18:27:50 +0200
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
 <2225a246-5cc5-45aa-a5cd-8434065ff69a@web.de>
 <1c53c64e-c23b-4978-b595-ef150e7eb7ef@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@web.de; keydata=
 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
In-Reply-To: <1c53c64e-c23b-4978-b595-ef150e7eb7ef@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yXIQxnotCy39jKh3CJScLyZT9I5Na5iCcqbaMAaon4zaDXhmrMR
 r5dewuPcsLUA1BgXn7eEtznJKgYP91yFyh3jr1MShijxdTMzrRjBQsJYqRR7azhlgT0uvYQ
 Hb9DiZXsG0dMZKdMieIwmhtCgfqBYSxVJocRBTHYRzQYuBa6H1o/iG+XwrTgWKtHNzpQUY0
 tQD0xJwrZlMAlmRziah4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xBK3f0vZ35Q=;2kvnt4aKFseREA8FdyI898GXYIY
 +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
 fPANw==

On 10.10.25 16:48, Tobias Schaffner wrote:
>=20
>=20
> On 10.10.25 15:55, Jan Kiszka wrote:
>> On 10.10.25 12:17, Tobias Schaffner wrote:
>>> Introduce support for building EVL for the RISC-V QEMU target.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 12 +
>>> =C2=A0 conf/machine/qemu-riscv64.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 14 +
>>> =C2=A0 kas/board/qemu-riscv64.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 15 +
>>> =C2=A0 recipes-kernel/linux/files/riscv64_defconfig | 7378 +++++++++++=
+++++++
>>> =C2=A0 4 files changed, 7419 insertions(+)
>>> =C2=A0 create mode 100644 conf/machine/qemu-riscv64.conf
>>> =C2=A0 create mode 100644 kas/board/qemu-riscv64.yaml
>>> =C2=A0 create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index a3e3885..23d5f4a 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -17,6 +17,9 @@ config ARCH_ARM
>>> =C2=A0 config ARCH_ARM64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>>> =C2=A0 +config ARCH_RISCV64
>>> +=C2=A0=C2=A0=C2=A0 bool
>>> +
>>> =C2=A0 choice
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prompt "Target board"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default TARGET_QEMU_AMD64
>>> @@ -41,6 +44,10 @@ config TARGET_QEMU_ARM64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "QEMU ARM64 virtual target"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_ARM64
>>> =C2=A0 +config TARGET_QEMU_RISCV64
>>> +=C2=A0=C2=A0=C2=A0 bool "QEMU RISCV64 virtual target"
>>> +=C2=A0=C2=A0=C2=A0 select ARCH_RISCV64
>>> +
>>> =C2=A0 config TARGET_HIKEY
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "LeMaker HiKey"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_ARM64
>>> @@ -58,6 +65,7 @@ config KAS_INCLUDE_TARGET
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/qemu-armhf.yaml" if =
TARGET_QEMU_ARM
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/beagle-bone-black.ya=
ml" if TARGET_BBB
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/qemu-arm64.yaml" if =
TARGET_QEMU_ARM64
>>> +=C2=A0=C2=A0=C2=A0 default "kas/board/qemu-riscv64.yaml" if TARGET_QE=
MU_RISCV64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/hikey.yaml" if TARGE=
T_HIKEY
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/rpi4.yaml" if TARGET=
_RPI4
>>> =C2=A0 @@ -65,9 +73,13 @@ choice
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prompt "Xenomai version"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default XENOMAI3
>>> =C2=A0 +if !TARGET_QEMU_RISCV64
>>
>> no, rather...
>>
>>> +
>>> =C2=A0 config XENOMAI3
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Xenomai 3"
>>
>> depends on !ARCH_RISCV64
>>
>> BTW, we will likely have some kernel version deps as well, won't we?
>=20
> Most likely. :) Noted: will set this as soon as we have something
> integrated upstream.
>=20
>>> =C2=A0 +endif
>>> +
>>> =C2=A0 config XENOMAI4
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Xenomai 4 / EVL"
>>> =C2=A0 diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu=
-
>>> riscv64.conf
>>> new file mode 100644
>>> index 0000000..65c1a53
>>> --- /dev/null
>>> +++ b/conf/machine/qemu-riscv64.conf
>>> @@ -0,0 +1,14 @@
>>> +#
>>> +# Xenomai Real-Time System
>>> +#
>>> +# Copyright (c) Siemens AG, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Tobias Schaffner <tobias.schaffner@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require qemu-machine.inc
>>> +
>>> +DISTRO_ARCH =3D "riscv64"
>>> diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
>>> new file mode 100644
>>> index 0000000..a659c2b
>>> --- /dev/null
>>> +++ b/kas/board/qemu-riscv64.yaml
>>> @@ -0,0 +1,15 @@
>>> +#
>>> +# Xenomai Real-Time System
>>> +#
>>> +# Copyright (c) Siemens AG, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Tobias Schaffner <tobias.schaffner@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +header:
>>> +=C2=A0 version: 14
>>> +
>>> +machine: qemu-riscv64
>>> diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-
>>> kernel/linux/files/riscv64_defconfig
>>> new file mode 100644
>>> index 0000000..c57065e
>>> --- /dev/null
>>> +++ b/recipes-kernel/linux/files/riscv64_defconfig
>>
>> Is this a real config, not a defconfig, right? Is that needed?
>=20
> It's a defconfig with some debug switches (some of them EVL=E2=80=91spec=
ific)
> applied.
>=20

I was just looking at the riscv defconfig in the kernel, and that is
about 300 lines.

Jan

> I think I could unset=E2=80=AFKERNEL_DEFCONFIG and add only a=E2=80=AFde=
bug_config
> snippet. The ISAR custom kernel recipe generates the defconfig in this
> case.
>=20
> Do completely generated defconfigs introduce more changes across kernel
> versions than using an old config and relying on the defaults for newly
> introduced switches? If the defaults of existing switches rarely change
> over time, this may be a good idea.
>=20
>> Jan
>>
>=20

