Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522812CDB1
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563031; cv=none; b=EiB0i7e8u1rK/PQNNFZGOCd0PhWthgVXNq65Pczt9pPpKAsudMUtNqTvjczSULvsr+3LoRI1/J4u35LsTuhI5DlP9v5EkOHZ61dlAO3uKqCSH/2kqGMTDcJD+gPk5YR/ZuLqOC6A4V0dmuWjv8uPyh4xy1hrSo/hpsTtUPrXSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563031; c=relaxed/simple;
	bh=XhdDFAn4WuzkJ+nR9+pE6TOzsHQVJd8lEz8GnpF6dp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7JNLxtvtZFtjU7s94ETlhrL6rLQx0U7PCiYDG9tdXk+UtIWfnLCAy0TIClFhpkQWkqBlCJeMg5FuhCmcZ9pBl5oPPY9vUk+2xi2fQFdd3/HotKNq4UESSebV6+Qtw77w1/t98ju7o6uXKzssqFhgxiLqXWm9PTHrkETLdlBKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=SxMSWj89; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="SxMSWj89"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240524150339d03c50f016afc249b3
        for <xenomai@lists.linux.dev>;
        Fri, 24 May 2024 17:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KMG4x9+BF1CvhYSwL8uGPC41xftInozPgMGrj/zcnxI=;
 b=SxMSWj89tUp44kyXAiXA65KxHoFlowpg/iAIHCHTi/RAjb/KPJgSLIldFnQWDZ6I+p5liu
 kJdZU7tQ57/HiMK7cyCX+rWxPQoGV6fbPdAwXFZM7V4b3UanwOuwmkFJblKJA/1PRoeGJwSI
 h1dY8CJ8L/KzAZgU+UuS4LQVFVUHY=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v3 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
Date: Fri, 24 May 2024 17:03:34 +0200
Message-Id: <20240524150335.23090-3-yi.jiang@siemens.com>
In-Reply-To: <20240524150335.23090-1-yi.jiang@siemens.com>
References: <20240524150335.23090-1-yi.jiang@siemens.com>
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
 wic/rpi4.wks                                  | 17 ++++++++++
 5 files changed, 72 insertions(+), 4 deletions(-)
 create mode 100644 board-rpi4.yml
 create mode 100644 conf/machine/rpi4.conf
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

