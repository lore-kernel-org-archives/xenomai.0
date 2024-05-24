Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F086246
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716551002; cv=none; b=mlCbfnEm136T3Mhw6ZGlNn/dfx+EWtYaHn2+qmx7LQhv+1Br8J+nTNln1hxa4mepgQkuqRcCzT98YoswHgt1VaxV7k2/Mk/AVnA67WHhAwlFpfs6kwdfjl4udc5kq0NerVBfcWitF27/aedtnTvG8HjheCOMfy0bXqpWQcBU2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716551002; c=relaxed/simple;
	bh=X49rExHe2ClyuR/YLmr8aLQ7II3gMxn0UqU0+ljUlyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Arv51ZbXJXvnaSX/p66ku5Iy3jaaSowrASyJqTdkO3P0PHMrUCegulpYQY3bgBQn/CePkHgqTUDIyeKOCzFNGECPDvUbp0xNwvCzMgzjLIhTA0/O/DCFkue+4ghupSJnsvRV+qQ50esg5gOhzTk1Zw7bE6bDVlzx99CLVMZGjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=gqKX0Vup; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="gqKX0Vup"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240524110258a21c5ef3749b95d4ef
        for <xenomai@lists.linux.dev>;
        Fri, 24 May 2024 13:02:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LGlhqsAOS8yL5hSbHwugq4QAxN4CiMBFIPW6K05Ag3w=;
 b=gqKX0VupKVUQKTL9UfLVXx30ZV+jM5ytSz4IsLQefJ3bDbhEzt8yhzXJ57U+QaKeaGIO04
 ZNtcXEAnu1E+N7Y8q5/kDtIS3fFuTZwchDJ7I2p+l6wdR6MQ7XIQ+JGU+U4fs32j0CYqEiOQ
 BlANLuY8yHygsVXbHNllgV9cP0gF0=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com
Subject: [PATCH v2 1/3] rpi-firmware: Add recipe for building version 20230405
Date: Fri, 24 May 2024 13:02:52 +0200
Message-Id: <20240524110254.37483-2-yi.jiang@siemens.com>
In-Reply-To: <20240524110254.37483-1-yi.jiang@siemens.com>
References: <20240524110254.37483-1-yi.jiang@siemens.com>
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

