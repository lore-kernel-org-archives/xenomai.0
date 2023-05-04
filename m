Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359294A31
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 08:08:57 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023050407584698372eeb21647cdbd7
        for <xenomai@lists.linux.dev>;
        Thu, 04 May 2023 09:58:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yU7KY/9VXhG6ma7S/os93MPNBO9daakroLdD8Z2/8Z8=;
 b=g1yZfjAB1Ap2yxiEKqpYRGS6qTIlvoTQIDvhsaMGFeZcMnw2fCHJRu7zrfKWwZccONG0RI
 FYzECzr91ggz3NmoxqFuKHBrvvWzhhKnPi0GVg6pMWYNGVknHXToBT3aTVpHsDEucYFnsjoO
 3c4bSUIDcuuNLlI4fsnL4MDQLPncs=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 04 May 2023 09:58:42 +0200
Subject: [PATCH xenomai-images v2 4/4] customizations: Migrate from ifup to
 systemd-networkd
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-flo-debian-bookworm-update-v2-4-f859df1417e6@siemens.com>
References: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a boot-time optimization for some boards. As we are using
ip=dhcp for most CI targets the kernel already pre-configures one
network device using DHCP.

When using the traditional interface configuration in
/etc/network/interfaces.d the following warning - and a boot hang for
up to 90 sec - could be observed:

[ TIME ] Timed out waiting for device s/subsystem/net/devices/eth0.
[DEPEND] Dependency failed for ifup for eth0.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-core/customizations/customizations.bb     |  8 ++++----
 recipes-core/customizations/files/ethernet        | 19 -------------------
 recipes-core/customizations/files/primary.network |  5 +++++
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 0faaff8..f86bf68 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2021
+# Copyright (c) Siemens AG, 2018-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,14 +15,14 @@ DESCRIPTION = "demo image customizations"
 
 SRC_URI = " \
     file://postinst \
-    file://ethernet \
+    file://primary.network \
     file://99-silent-printk.conf"
 
 DEBIAN_DEPENDS = "openssh-server"
 
 do_install() {
-	install -v -d ${D}/etc/network/interfaces.d
-	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
+	install -d ${D}/etc/systemd/network
+	install -m 640 ${WORKDIR}/*.network ${D}/etc/systemd/network/
 
 	install -v -d ${D}/etc/sysctl.d
 	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
diff --git a/recipes-core/customizations/files/ethernet b/recipes-core/customizations/files/ethernet
deleted file mode 100644
index d282ce1..0000000
--- a/recipes-core/customizations/files/ethernet
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2018
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-allow-hotplug eth0
-allow-hotplug enp0s2
-
-# used on qemu-arm and qemu-arm64
-iface eth0 inet dhcp
-
-# used on qemu-amd64
-iface enp0s2 inet dhcp
diff --git a/recipes-core/customizations/files/primary.network b/recipes-core/customizations/files/primary.network
new file mode 100644
index 0000000..c517d10
--- /dev/null
+++ b/recipes-core/customizations/files/primary.network
@@ -0,0 +1,5 @@
+[Match]
+Name=eth0 enp2s0 enp3s0
+
+[Network]
+DHCP=yes

-- 
2.39.2

