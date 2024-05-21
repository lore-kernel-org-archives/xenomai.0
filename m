Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22947F466
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299941; cv=none; b=QtdPIowe5mTN5esSMHdBnBpOYucBE5eoYxsw9ZSREmqVEzrDoH99vYfbmNzxX8hFk1vHKie63sIX1gitqRNoDlsg3UwO51OrRZJWTsQBJ8mn6PofFuOsEvphuJVpWbDc1xh1UTtkrscNSYX3ZHcTXslqCcKdBoOuAG7NFh3aff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299941; c=relaxed/simple;
	bh=70BI8bKQ60liiUaJnw9gF3MenG4cXDjwhKW7QcYB2wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0xx1f408BwFCLPp9cy8Y4rtB+jRLwQOggiTok5o1PVAbZY3xywAmngArJloXf92IP2IeHlOyS9QLNYOorAouKPiPPO8zga8Ipb+kfvFtSLKUTOj+KdlSaFBSM32phKaGeI8vgkf+FZWQf0HDlM8xSx9MqrSIAuLrHzoSH3n5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=Ntv5aJvB; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="Ntv5aJvB"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240521134844397b865f5418a780f6
        for <xenomai@lists.linux.dev>;
        Tue, 21 May 2024 15:48:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XZUKqa6hMT8annJZ2Z4hNl1le3gZ0JeEgPdPADpckkY=;
 b=Ntv5aJvB+m+t70smJbcDdpS4yvwVUYujDshctfi1RCRuT+cTRmC+DbTx5qXBJu1KT33RJK
 WIPXNro4qIgjym1rHuOAKlncYdsuW2opSQOk6OOedP4cRUONbfQQOuUMbW8WQwlHMbJBl05w
 CEmf73dKqzeRmOq7ok052oXI9fM3M=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
Date: Tue, 21 May 2024 15:48:40 +0200
Message-Id: <20240521134841.21749-2-yi.jiang@siemens.com>
In-Reply-To: <20240521134841.21749-1-yi.jiang@siemens.com>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
---
 board-rpi4.yml                                | 15 +++++++++
 conf/machine/rpi4.conf                        | 32 +++++++++++++++++++
 .../customizations/files/primary.network      |  2 +-
 recipes-kernel/linux/files/arm64_defconfig    | 10 ++++--
 recipes-kernel/linux/files/rpi4.cfg           | 20 ++++++++++++
 .../linux/linux-xenomai-3-dovetail.inc        |  1 +
 .../linux/linux-xenomai-3_latest.bb           |  1 +
 wic/rpi4.wks                                  | 17 ++++++++++
 8 files changed, 94 insertions(+), 4 deletions(-)
 create mode 100644 board-rpi4.yml
 create mode 100644 conf/machine/rpi4.conf
 create mode 100644 recipes-kernel/linux/files/rpi4.cfg
 create mode 100644 wic/rpi4.wks

diff --git a/board-rpi4.yml b/board-rpi4.yml
new file mode 100644
index 0000000..debff7a
--- /dev/null
+++ b/board-rpi4.yml
@@ -0,0 +1,15 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: rpi4
diff --git a/conf/machine/rpi4.conf b/conf/machine/rpi4.conf
new file mode 100644
index 0000000..3c0607e
--- /dev/null
+++ b/conf/machine/rpi4.conf
@@ -0,0 +1,32 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "arm64"
+
+IMAGE_FSTYPES ?= "wic"
+IMAGER_BUILD_DEPS = "rpi-firmware linux-image-${KERNEL_NAME}"
+IMAGER_INSTALL += "${IMAGER_BUILD_DEPS}"
+
+IMAGE_BOOT_FILES = " \
+    /usr/lib/rpi-firmware/bootcode.bin;bootcode.bin \
+    /usr/lib/rpi-firmware/cmdline.txt;cmdline.txt \
+    /usr/lib/rpi-firmware/config.txt;config.txt \
+    /usr/lib/rpi-firmware/fixup4.dat;fixup4.dat \
+    /usr/lib/rpi-firmware/fixup4x.dat;fixup4x.dat \
+    /usr/lib/rpi-firmware/start4.elf;start4.elf \
+    /usr/lib/rpi-firmware/start4x.elf;start4x.elf \
+    /usr/lib/rpi-firmware/overlays/*;overlays/ \
+    /usr/lib/linux-image-*/broadcom/bcm2711-rpi-4-b.dtb \
+    /usr/lib/linux-image-*/overlays/*;overlays/ \
+    ${IMAGE_ROOTFS}/vmlinuz;kernel8.img \
+    "
+
+IMAGE_PREINSTALL:append = " firmware-brcm80211"
diff --git a/recipes-core/customizations/files/primary.network b/recipes-core/customizations/files/primary.network
index c517d10..2343386 100644
--- a/recipes-core/customizations/files/primary.network
+++ b/recipes-core/customizations/files/primary.network
@@ -1,5 +1,5 @@
 [Match]
-Name=eth0 enp2s0 enp3s0
+Name=eth0 enp2s0 enp3s0 end0
 
 [Network]
 DHCP=yes
diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
index 9bacb82..94f7b5b 100644
--- a/recipes-kernel/linux/files/arm64_defconfig
+++ b/recipes-kernel/linux/files/arm64_defconfig
@@ -603,6 +603,7 @@ CONFIG_FREEZER=y
 # CONFIG_ARCH_ACTIONS is not set
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
+CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
@@ -704,6 +705,7 @@ CONFIG_PCIE_IPROC_MSI=y
 # CONFIG_PCI_HOST_THUNDER_ECAM is not set
 CONFIG_PCIE_ROCKCHIP=m
 # CONFIG_PCIE_MEDIATEK is not set
+CONFIG_PCIE_BRCMSTB=y
 
 #
 # PCI Endpoint
@@ -1552,7 +1554,7 @@ CONFIG_OF_MDIO=y
 CONFIG_OF_PCI=y
 CONFIG_OF_PCI_IRQ=y
 CONFIG_OF_RESERVED_MEM=y
-# CONFIG_OF_OVERLAY is not set
+CONFIG_OF_OVERLAY=y
 CONFIG_OF_NUMA=y
 # CONFIG_PARPORT is not set
 CONFIG_PNP=y
@@ -1949,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=y
 # CONFIG_MACB_PCI is not set
 CONFIG_NET_VENDOR_BROADCOM=y
 # CONFIG_B44 is not set
-# CONFIG_BCMGENET is not set
+ CONFIG_BCMGENET=y
 # CONFIG_BNX2 is not set
 # CONFIG_CNIC is not set
 # CONFIG_TIGON3 is not set
@@ -2640,7 +2642,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # I2C system bus drivers (mostly embedded / system-on-chip)
 #
-CONFIG_I2C_BCM2835=m
+CONFIG_I2C_BCM2835=y
 CONFIG_I2C_BCM_IPROC=y
 CONFIG_I2C_BRCMSTB=y
 # CONFIG_I2C_CADENCE is not set
@@ -2880,6 +2882,7 @@ CONFIG_GPIO_GENERIC=y
 # CONFIG_GPIO_ALTERA is not set
 # CONFIG_GPIO_AMDPT is not set
 # CONFIG_GPIO_AXP209 is not set
+CONFIG_GPIO_BCM_XGS_IPROC=y
 CONFIG_GPIO_BRCMSTB=y
 CONFIG_GPIO_DWAPB=y
 # CONFIG_GPIO_EXAR is not set
@@ -5473,6 +5476,7 @@ CONFIG_PHY_MESON_GXL_USB2=y
 # CONFIG_BCM_KONA_USB2_PHY is not set
 # CONFIG_PHY_BCM_NS_USB2 is not set
 # CONFIG_PHY_BCM_NS_USB3 is not set
+CONFIG_PHY_BCM_SR_USB=y
 CONFIG_PHY_NS2_PCIE=y
 CONFIG_PHY_NS2_USB_DRD=y
 CONFIG_PHY_BRCM_SATA=y
diff --git a/recipes-kernel/linux/files/rpi4.cfg b/recipes-kernel/linux/files/rpi4.cfg
new file mode 100644
index 0000000..9d77279
--- /dev/null
+++ b/recipes-kernel/linux/files/rpi4.cfg
@@ -0,0 +1,20 @@
+#CONFIG_ARCH_BCM=y
+#CONFIG_ARCH_BCM2835=y
+#CONFIG_BCM2835_MBOX=y
+#CONFIG_RASPBERRYPI_FIRMWARE=y
+#CONFIG_OF_OVERLAY=y
+#CONFIG_SERIAL_8250_BCM2835AUX=y
+#CONFIG_MMC_BCM2835=y
+#CONFIG_MMC_SDHCI_IPROC=y
+#CONFIG_MMC_SDHCI_BRCMSTB=y
+#CONFIG_I2C_BCM2835=y
+#CONFIG_PHY_BCM_SR_USB=y
+#CONFIG_PWM_BCM_IPROC=y
+#CONFIG_PWM_BCM2835=m
+#CONFIG_DMA_BCM2835=m
+#CONFIG_SPI_BCM2835=m
+#CONFIG_GPIO_BRCMSTB=y
+#CONFIG_GPIO_BCM_XGS_IPROC=y
+#CONFIG_BCM2835_WDT=y
+#CONFIG_PCIE_BRCMSTB=y
+#CONFIG_BCMGENET=y
diff --git a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
index a8612ba..36000dd 100644
--- a/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
+++ b/recipes-kernel/linux/linux-xenomai-3-dovetail.inc
@@ -12,5 +12,6 @@
 require recipes-kernel/linux/linux-xenomai-3.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
+SRC_URI:append:rpi4 = " file://rpi4.cfg"
 
 PV ?= "${@d.getVar('SRCREV').strip('-')[0].lstrip('v')}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index c65c28d..5908c59 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -80,3 +80,4 @@ SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
 
 SRC_URI:append:beagle-bone-black = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) else '' }"
+SRC_URI:append:rpi4 = " file://rpi4.cfg"
diff --git a/wic/rpi4.wks b/wic/rpi4.wks
new file mode 100644
index 0000000..22eeb87
--- /dev/null
+++ b/wic/rpi4.wks
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+part --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 128 --overhead-factor 1 --extra-space 0
+
+part / --source rootfs --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active
+
+# silence wic
+bootloader
-- 
2.39.2

