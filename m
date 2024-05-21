Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B594F74402
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299336; cv=none; b=N13+Vj9o/nwyHjsQu6mgFVVH5PjWPtb2KrVM6bIgoH4knKmPtRqbs1sAzMlnTHbTxGMhJctsUGK9WUUQnvpBuIdyrmqoWBgZKx3rtdaI5ZQZB1g7SvdxsHJI/3IcqNZqnffvT7at03OQocD6LQHnds3Fihv39muOsXNoIFc7t2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299336; c=relaxed/simple;
	bh=X49rExHe2ClyuR/YLmr8aLQ7II3gMxn0UqU0+ljUlyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OC4Wp7MZTkurtseTna5YLav2NEbCQuCGB6CfQiqxfle6K55MT1bktBHlagDdvAnj+rrw8+tQSMiggSPdY+jqyBlRo9p1YO37sc8Ss4dzvsbD01ctMBX1iyjHc/F7uIIj5JhhWCg0k26ioR3YrvBB04SomnNWL4hDwyArxx0CDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=VdoE7Uc1; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="VdoE7Uc1"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024052113484410eb6cc032360f790f
        for <xenomai@lists.linux.dev>;
        Tue, 21 May 2024 15:48:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LGlhqsAOS8yL5hSbHwugq4QAxN4CiMBFIPW6K05Ag3w=;
 b=VdoE7Uc128pt0kvvdP0ArjctnxiqWE5Y3ie8wyexnyH1Y+scQ7fpEFWfgQuW+q0Wka+00U
 I3/1m61QJ5gpXJknAR0c2lUTDPzmgW1UD5eFDr7p9/pGwxTO1qZPGCnghIQDaqVoZbX8O5ar
 Ly27a+TxEoZwQSOjmlSUgbqgWWgzc=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/3] rpi-firmware: Add recipe for building version 20230405
Date: Tue, 21 May 2024 15:48:39 +0200
Message-Id: <20240521134841.21749-1-yi.jiang@siemens.com>
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

Preparation for supporting the Raspberry Pi 4 as target platform.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../rpi-firmware/files/debian/aliases.dts     | 18 +++++++++++
 .../rpi-firmware/files/debian/cmdline.txt     |  1 +
 .../rpi-firmware/files/debian/config.txt      | 12 ++++++++
 .../files/debian/rpi-firmware.install         |  9 ++++++
 recipes-bsp/rpi-firmware/files/rules          |  7 +++++
 .../rpi-firmware/rpi-firmware_1.20230405.bb   | 30 +++++++++++++++++++
 6 files changed, 77 insertions(+)
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/aliases.dts
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/cmdline.txt
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/config.txt
 create mode 100644 recipes-bsp/rpi-firmware/files/debian/rpi-firmware.install
 create mode 100644 recipes-bsp/rpi-firmware/files/rules
 create mode 100644 recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb

diff --git a/recipes-bsp/rpi-firmware/files/debian/aliases.dts b/recipes-bsp/rpi-firmware/files/debian/aliases.dts
new file mode 100644
index 0000000..15020d9
--- /dev/null
+++ b/recipes-bsp/rpi-firmware/files/debian/aliases.dts
@@ -0,0 +1,18 @@
+/*
+ * Xenomai Real-Time System
+ *
+ * Copyright (c) Siemens AG, 2024
+ *
+ * Authors:
+ *  Florian Bezdeka <florian.bezdeka@siemens.com>
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+/dts-v1/;
+/plugin/;
+&{/aliases} {
+	/* Ensure stable /dev/mmcblk0 assignment */
+	mmc0 = "/emmc2bus/mmc@7e340000";
+	mmc1 = "/soc/mmc@7e300000";
+};
diff --git a/recipes-bsp/rpi-firmware/files/debian/cmdline.txt b/recipes-bsp/rpi-firmware/files/debian/cmdline.txt
new file mode 100644
index 0000000..58971c5
--- /dev/null
+++ b/recipes-bsp/rpi-firmware/files/debian/cmdline.txt
@@ -0,0 +1 @@
+module_blacklist=vc4 console=ttyS1,115200 root=/dev/mmcblk0p2 rootwait
diff --git a/recipes-bsp/rpi-firmware/files/debian/config.txt b/recipes-bsp/rpi-firmware/files/debian/config.txt
new file mode 100644
index 0000000..61eee20
--- /dev/null
+++ b/recipes-bsp/rpi-firmware/files/debian/config.txt
@@ -0,0 +1,12 @@
+dtparam=audio=on
+
+[pi4]
+dtoverlay=vc4-fkms-v3d
+max_framebuffers=2
+
+[all]
+enable_uart=1
+arm_64bit=1
+dtoverlay=aliases
+dtoverlay=dwc2
+initramfs initrd.img followkernel
diff --git a/recipes-bsp/rpi-firmware/files/debian/rpi-firmware.install b/recipes-bsp/rpi-firmware/files/debian/rpi-firmware.install
new file mode 100644
index 0000000..28d6cc3
--- /dev/null
+++ b/recipes-bsp/rpi-firmware/files/debian/rpi-firmware.install
@@ -0,0 +1,9 @@
+boot/bootcode.bin		usr/lib/rpi-firmware/
+boot/LICENCE.broadcom		usr/lib/rpi-firmware/
+boot/*.dat			usr/lib/rpi-firmware/
+boot/*.dtb			usr/lib/rpi-firmware/
+boot/*.elf			usr/lib/rpi-firmware/
+boot/overlays/README		usr/lib/rpi-firmware/overlays/
+boot/overlays/aliases.dtbo	usr/lib/rpi-firmware/overlays/
+debian/cmdline.txt		usr/lib/rpi-firmware/
+debian/config.txt		usr/lib/rpi-firmware/
diff --git a/recipes-bsp/rpi-firmware/files/rules b/recipes-bsp/rpi-firmware/files/rules
new file mode 100644
index 0000000..df0582c
--- /dev/null
+++ b/recipes-bsp/rpi-firmware/files/rules
@@ -0,0 +1,7 @@
+#!/usr/bin/make -f
+
+override_dh_auto_build:
+	dtc -O dtb -b 0 -@ debian/aliases.dts -o boot/overlays/aliases.dtbo
+
+%:
+	dh $@
diff --git a/recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb b/recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb
new file mode 100644
index 0000000..1cfb103
--- /dev/null
+++ b/recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb
@@ -0,0 +1,30 @@
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
+inherit dpkg
+
+SRC_URI = " \
+    https://github.com/raspberrypi/firmware/archive/${PV}.tar.gz;downloadfilename=${PN}-${PV}.tar.gz \
+    file://debian \
+    file://rules"
+
+SRC_URI[sha256sum] = "08b208bf715d0379a93d38f20aed409cbe2e12c1dc27e3a3794416faefde1aa9"
+
+S = "${WORKDIR}/firmware-${PV}"
+
+DEBIAN_BUILD_DEPENDS = "device-tree-compiler"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    cp -r ${WORKDIR}/debian ${S}
+
+    deb_debianize
+}
-- 
2.39.2

