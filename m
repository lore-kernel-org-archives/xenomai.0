Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B518E30
	for <xenomai@lists.linux.dev>; Wed, 18 Oct 2023 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="KiQMHLG3"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202310181048595ab298398cb62a65fc
        for <xenomai@lists.linux.dev>;
        Wed, 18 Oct 2023 12:48:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7ytZR+9L/O16wPaIcc6RaWu5pArcrfNpedt8p+Cn/JI=;
 b=KiQMHLG3uwBFKdFRUi1g72q5LdiXY/MziCZra1NhOXD1/MWA+rWSOeTNJYSNwZf6nVP7zP
 bRCr1lxvCboq4uoOI0+9d/OmUAxSi8B+4cVCC56lXWnn9GWfMtV+UAOt2O+OV5wuf8BL5wdH
 WzwJvvVkpZweE1PWGzU7WhSHFeYqo=;
Message-ID: <221340fee33336dd554ce147943c2575f7658393.camel@siemens.com>
Subject: Re: initramfs can't find root filesystem device
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Baeten, M.J.J. (Max)" <max.baeten@tno.nl>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Wed, 18 Oct 2023 12:48:57 +0200
In-Reply-To: <40202c26ad1440aaad6cca4463af0e29@tno.nl>
References: <40202c26ad1440aaad6cca4463af0e29@tno.nl>
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

On Wed, 2023-10-18 at 09:32 +0000, Baeten, M.J.J. (Max) wrote:
>=20
>=20
>=20
> Hello!
> =C2=A0
> After compiling a xenomai 3.2.1 patched kernel the initramfs can=E2=80=99=
t boot this kernel because it can=E2=80=99t find the root filesystem device=
.
> =C2=A0
> Error:
> Gave up waiting for root file system device. Common problems:
> - Boot args (cat /proc/cmdline)
> =C2=A0=C2=A0 - Check rootdelay=3D (did the system wait long enough?)
> - Missing modules (cat /proc/modules; ls /dev)
> ALERT! /dev/mapper/ubuntu-vg-ubuntu=E2=80=94lv does not exist.
> =C2=A0
> When I compile the same kernel sources without xenomai patch it works.
> =C2=A0
> My .config is included and a screenshot of the error as well.
> Cat /proc/modules =3D empty=20
> Cat /proc/cmdline =3D BOOT_IMAGE=3D/vmlinuz-5.4.253-xeno-3.2.1 root=3D/de=
v/mapper/ubuntu--vg
> =C2=A0
> I have tried on two systems with different ubuntu versions, kernels and x=
enomai patches.
> Ubuntu is installed with LVM but I tried as well without LVM. (Similar er=
ror: UUID does not exist)
> =C2=A0
> # Config FOR UBUNTU 18.04
> KERNEL_VERSION=3D"4.19.66"
> XENO_VERSION=3D"3.2.1"
> XENO_PATCH=3D"ipipe-core-4.19.66-x86-6.patch"
> =C2=A0
> # UBUNTU SRV 20.04
> KERNEL_VERSION=3D"5.4.253"
> XENO_VERSION=3D"3.2.1"
> XENO_PATCH=3D"ipipe-core-5.4.253-x86-14.patch"
> =C2=A0
> Any ideas on what I am doing wrong or how I can debug this problem?

Where does your rootfs reside? Some external device like USB? Are you
sure that the kernel configuration you are using is the same (content
wise) for both setups?

Seems your missing a driver / subsystem enablement.

It might have happened that you deactivated some required configuration
options while migrating the configuration from 4.19 to 5.4.

Best regards,
Florian
> =C2=A0
> Kind regards,
> Max Baeten
> =C2=A0
> =C2=A0
> =C2=A0
>=20
> This message may contain information that is not intended for you. If you=
 are not the addressee or if this message was sent to you by mistake, you a=
re requested to inform the sender and delete the message. TNO accepts no li=
ability for the content of this e-mail, for the manner in which you use it =
and for damage of any kind resulting from the risks inherent to the electro=
nic transmission of messages.
>=20

