Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC10763F1
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307058; cv=none; b=knxSE1CVbvEhSykD6pvUaiCd2CU8Y/m89Ikc1VQOqgz6ty6BkxCSo9OaH4O2nrH5aPqcuj3hT4ZMVYMQVYLAimNiukopbOjO3jTmF8CNrVVI+mURLU2RuQUlZbODOx15PF57enV+4tTjayZgXC7jGSP5sdNCo4goJszORLOHLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307058; c=relaxed/simple;
	bh=JH6jcK5uGg9i9mS1DuFPErD8Qw7X+ixpGQzZq13ZBLA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZM8AEXCMaR73IgbJ0kphBSKUDqq/cQU+0NhDE4PTYXKaqYWzYH005grnwrWnnzUH4Q/gxIgnHB9SA88fzuZCq6gdTQ3n/MBsP6J1B14LOXUERgGO0EvtaWgw+PBXvEnqirIr5hyb8tKkK09B87gEjos64CPVLbPSxyPPvRkaF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fmRl94Du; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fmRl94Du"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240521155722bc209cc3664116be0a
        for <xenomai@lists.linux.dev>;
        Tue, 21 May 2024 17:57:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=2fM9nhhcn9NYd/ZVTvErLrAETr9oAz++YOwBb2l4BRM=;
 b=fmRl94DuPNfL2ffSSQsSCku0FDJrQeoV6T4DUu1ymF14QSMsPmAjUirLpzE/lmkCHTlLnv
 Y6UXAc0ZTO8DmihiEIFLc/Qwdomxd1fIntgmfOMLslnVOZcGNj8lj5ukMs1aGvZL0W9KRUEN
 Ho14sVBYT9R3OMmSnJgWZmg4ccnpM=;
Message-ID: <dafbc406f9f93c4a77d3e95fcd5f5d8fa2f792c5.camel@siemens.com>
Subject: Re: [PATCH 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Yi Jiang <yi.jiang@siemens.com>, 
	xenomai@lists.linux.dev
Date: Tue, 21 May 2024 17:57:21 +0200
In-Reply-To: <81ab4ff0-6eff-4944-83fe-336c965b9ed3@siemens.com>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
	 <20240521134841.21749-2-yi.jiang@siemens.com>
	 <81ab4ff0-6eff-4944-83fe-336c965b9ed3@siemens.com>
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

On Tue, 2024-05-21 at 16:52 +0200, Jan Kiszka wrote:
> On 21.05.24 15:48, Yi Jiang wrote:
> > From: Florian Bezdeka <florian.bezdeka@siemens.com>
> >=20
> > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
> > ---
> >  board-rpi4.yml                                | 15 +++++++++
> >  conf/machine/rpi4.conf                        | 32 +++++++++++++++++++
> >  .../customizations/files/primary.network      |  2 +-
> >  recipes-kernel/linux/files/arm64_defconfig    | 10 ++++--
> >  recipes-kernel/linux/files/rpi4.cfg           | 20 ++++++++++++
> >  .../linux/linux-xenomai-3-dovetail.inc        |  1 +
> >  .../linux/linux-xenomai-3_latest.bb           |  1 +
> >  wic/rpi4.wks                                  | 17 ++++++++++
> >  8 files changed, 94 insertions(+), 4 deletions(-)
> >  create mode 100644 board-rpi4.yml
> >  create mode 100644 conf/machine/rpi4.conf
> >  create mode 100644 recipes-kernel/linux/files/rpi4.cfg
> >  create mode 100644 wic/rpi4.wks
> >=20
> > diff --git a/board-rpi4.yml b/board-rpi4.yml
> > new file mode 100644
> > index 0000000..debff7a
> > --- /dev/null
> > +++ b/board-rpi4.yml
> > @@ -0,0 +1,15 @@
> > +#
> > +# Xenomai Real-Time System
> > +#
> > +# Copyright (c) Siemens AG, 2024
> > +#
> > +# Authors:
> > +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +header:
> > +  version: 14
> > +
> > +machine: rpi4
> > diff --git a/conf/machine/rpi4.conf b/conf/machine/rpi4.conf
> > new file mode 100644
> > index 0000000..3c0607e
> > --- /dev/null
> > +++ b/conf/machine/rpi4.conf
> > @@ -0,0 +1,32 @@
> > +#
> > +# Xenomai Real-Time System
> > +#
> > +# Copyright (c) Siemens AG, 2024
> > +#
> > +# Authors:
> > +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +DISTRO_ARCH =3D "arm64"
> > +
> > +IMAGE_FSTYPES ?=3D "wic"
> > +IMAGER_BUILD_DEPS =3D "rpi-firmware linux-image-${KERNEL_NAME}"
> > +IMAGER_INSTALL +=3D "${IMAGER_BUILD_DEPS}"
> > +
> > +IMAGE_BOOT_FILES =3D " \
> > +    /usr/lib/rpi-firmware/bootcode.bin;bootcode.bin \
> > +    /usr/lib/rpi-firmware/cmdline.txt;cmdline.txt \
> > +    /usr/lib/rpi-firmware/config.txt;config.txt \
> > +    /usr/lib/rpi-firmware/fixup4.dat;fixup4.dat \
> > +    /usr/lib/rpi-firmware/fixup4x.dat;fixup4x.dat \
> > +    /usr/lib/rpi-firmware/start4.elf;start4.elf \
> > +    /usr/lib/rpi-firmware/start4x.elf;start4x.elf \
> > +    /usr/lib/rpi-firmware/overlays/*;overlays/ \
> > +    /usr/lib/linux-image-*/broadcom/bcm2711-rpi-4-b.dtb \
> > +    /usr/lib/linux-image-*/overlays/*;overlays/ \
> > +    ${IMAGE_ROOTFS}/vmlinuz;kernel8.img \
> > +    "
> > +
> > +IMAGE_PREINSTALL:append =3D " firmware-brcm80211"
> > diff --git a/recipes-core/customizations/files/primary.network b/recipe=
s-core/customizations/files/primary.network
> > index c517d10..2343386 100644
> > --- a/recipes-core/customizations/files/primary.network
> > +++ b/recipes-core/customizations/files/primary.network
> > @@ -1,5 +1,5 @@
> >  [Match]
> > -Name=3Deth0 enp2s0 enp3s0
> > +Name=3Deth0 enp2s0 enp3s0 end0
> > =20
> >  [Network]
> >  DHCP=3Dyes
> > diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kerne=
l/linux/files/arm64_defconfig
> > index 9bacb82..94f7b5b 100644
> > --- a/recipes-kernel/linux/files/arm64_defconfig
> > +++ b/recipes-kernel/linux/files/arm64_defconfig
> > @@ -603,6 +603,7 @@ CONFIG_FREEZER=3Dy
> >  # CONFIG_ARCH_ACTIONS is not set
> >  CONFIG_ARCH_SUNXI=3Dy
> >  CONFIG_ARCH_ALPINE=3Dy
> > +CONFIG_ARCH_BCM=3Dy
> >  CONFIG_ARCH_BCM2835=3Dy
> >  CONFIG_ARCH_BCM_IPROC=3Dy
> >  CONFIG_ARCH_BERLIN=3Dy
> > @@ -704,6 +705,7 @@ CONFIG_PCIE_IPROC_MSI=3Dy
> >  # CONFIG_PCI_HOST_THUNDER_ECAM is not set
> >  CONFIG_PCIE_ROCKCHIP=3Dm
> >  # CONFIG_PCIE_MEDIATEK is not set
> > +CONFIG_PCIE_BRCMSTB=3Dy
> > =20
> >  #
> >  # PCI Endpoint
> > @@ -1552,7 +1554,7 @@ CONFIG_OF_MDIO=3Dy
> >  CONFIG_OF_PCI=3Dy
> >  CONFIG_OF_PCI_IRQ=3Dy
> >  CONFIG_OF_RESERVED_MEM=3Dy
> > -# CONFIG_OF_OVERLAY is not set
> > +CONFIG_OF_OVERLAY=3Dy
> >  CONFIG_OF_NUMA=3Dy
> >  # CONFIG_PARPORT is not set
> >  CONFIG_PNP=3Dy
> > @@ -1949,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=3Dy
> >  # CONFIG_MACB_PCI is not set
> >  CONFIG_NET_VENDOR_BROADCOM=3Dy
> >  # CONFIG_B44 is not set
> > -# CONFIG_BCMGENET is not set
> > + CONFIG_BCMGENET=3Dy
> >  # CONFIG_BNX2 is not set
> >  # CONFIG_CNIC is not set
> >  # CONFIG_TIGON3 is not set
> > @@ -2640,7 +2642,7 @@ CONFIG_I2C_ALGOBIT=3Dy
> >  #
> >  # I2C system bus drivers (mostly embedded / system-on-chip)
> >  #
> > -CONFIG_I2C_BCM2835=3Dm
> > +CONFIG_I2C_BCM2835=3Dy
> >  CONFIG_I2C_BCM_IPROC=3Dy
> >  CONFIG_I2C_BRCMSTB=3Dy
> >  # CONFIG_I2C_CADENCE is not set
> > @@ -2880,6 +2882,7 @@ CONFIG_GPIO_GENERIC=3Dy
> >  # CONFIG_GPIO_ALTERA is not set
> >  # CONFIG_GPIO_AMDPT is not set
> >  # CONFIG_GPIO_AXP209 is not set
> > +CONFIG_GPIO_BCM_XGS_IPROC=3Dy
> >  CONFIG_GPIO_BRCMSTB=3Dy
> >  CONFIG_GPIO_DWAPB=3Dy
> >  # CONFIG_GPIO_EXAR is not set
> > @@ -5473,6 +5476,7 @@ CONFIG_PHY_MESON_GXL_USB2=3Dy
> >  # CONFIG_BCM_KONA_USB2_PHY is not set
> >  # CONFIG_PHY_BCM_NS_USB2 is not set
> >  # CONFIG_PHY_BCM_NS_USB3 is not set
> > +CONFIG_PHY_BCM_SR_USB=3Dy
> >  CONFIG_PHY_NS2_PCIE=3Dy
> >  CONFIG_PHY_NS2_USB_DRD=3Dy
> >  CONFIG_PHY_BRCM_SATA=3Dy
>=20
> With all those changes to our shared arm64 defconfig, why do we still
> need the rpi4.cfg below?

Confused.

- My original patch did not touch the arm64 defconfig.
  So I'm still listed as author ("From:" inside the body) but the patch
  content is different.

- The subject says 2/3. Where is 3/3?


>=20
> > diff --git a/recipes-kernel/linux/files/rpi4.cfg b/recipes-kernel/linux=
/files/rpi4.cfg
> > new file mode 100644
> > index 0000000..9d77279
> > --- /dev/null
> > +++ b/recipes-kernel/linux/files/rpi4.cfg
> > @@ -0,0 +1,20 @@
> > +#CONFIG_ARCH_BCM=3Dy
> > +#CONFIG_ARCH_BCM2835=3Dy
> > +#CONFIG_BCM2835_MBOX=3Dy
> > +#CONFIG_RASPBERRYPI_FIRMWARE=3Dy
> > +#CONFIG_OF_OVERLAY=3Dy
> > +#CONFIG_SERIAL_8250_BCM2835AUX=3Dy
> > +#CONFIG_MMC_BCM2835=3Dy
> > +#CONFIG_MMC_SDHCI_IPROC=3Dy
> > +#CONFIG_MMC_SDHCI_BRCMSTB=3Dy
> > +#CONFIG_I2C_BCM2835=3Dy
> > +#CONFIG_PHY_BCM_SR_USB=3Dy
> > +#CONFIG_PWM_BCM_IPROC=3Dy
> > +#CONFIG_PWM_BCM2835=3Dm
> > +#CONFIG_DMA_BCM2835=3Dm
> > +#CONFIG_SPI_BCM2835=3Dm
> > +#CONFIG_GPIO_BRCMSTB=3Dy
> > +#CONFIG_GPIO_BCM_XGS_IPROC=3Dy
> > +#CONFIG_BCM2835_WDT=3Dy
> > +#CONFIG_PCIE_BRCMSTB=3Dy
> > +#CONFIG_BCMGENET=3Dy
> > diff --git a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc b/recipe=
s-kernel/linux/linux-xenomai-3-dovetail.inc
> > index a8612ba..36000dd 100644
> > --- a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
> > +++ b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
> > @@ -12,5 +12,6 @@
> >  require recipes-kernel/linux/linux-xenomai-3.inc
> > =20
> >  SRC_URI +=3D "git://source.denx.de/xenomai/linux-dovetail.git;protocol=
=3Dhttps;nobranch=3D1"
> > +SRC_URI:append:rpi4 =3D " file://rpi4.cfg"
> > =20
> >  PV ?=3D "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
> > diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-k=
ernel/linux/linux-xenomai-3_latest.bb
> > index c65c28d..5908c59 100644
> > --- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
> > +++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
> > @@ -80,3 +80,4 @@ SRC_URI +=3D "${GIT_REPO};protocol=3Dhttps;branch=3D$=
{GIT_BRANCH}"
> >  SRCREV =3D "${AUTOREV}"
> > =20
> >  SRC_URI:append:beagle-bone-black =3D " ${@ 'file://bbb_4.4.cfg' if is_=
xeno_3_0(d) else '' }"
> > +SRC_URI:append:rpi4 =3D " file://rpi4.cfg"
> > diff --git a/wic/rpi4.wks b/wic/rpi4.wks
> > new file mode 100644
> > index 0000000..22eeb87
> > --- /dev/null
> > +++ b/wic/rpi4.wks
> > @@ -0,0 +1,17 @@
> > +#
> > +# Xenomai Real-Time System
> > +#
> > +# Copyright (c) Siemens AG, 2024
> > +#
> > +# Authors:
> > +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +part --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label=
 boot --align 1 --size 128 --overhead-factor 1 --extra-space 0
> > +
> > +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts=
 "-T default" --label platform --align 1024 --active
> > +
> > +# silence wic
> > +bootloader
>=20
> Rest of this looks good.
>=20
> Thanks,
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

