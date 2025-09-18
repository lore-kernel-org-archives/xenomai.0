Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F5307493
	for <xenomai@lists.linux.dev>; Thu, 18 Sep 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210976; cv=none; b=agSD8uwT5d9NDyoHN6T0M16VVInPMQDjFIzZNazORs06OGabd2BjU4AZrQsHAH41eAxJBCcMkbDeJzD/1NpTyVe70jNVGQlwJt8BF0f/y/QcbTBJTNkagmbbd3Myr3EpFunqOjY9yooxdAw50gHjNJTieEOgWDQAM5SZiM49DCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210976; c=relaxed/simple;
	bh=LWFFaMIiZj2WwP6/kmHFrao1cMtx7XZrhdYSReSuqrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJgReQEJPL0+s0tkikhmi5dba3q075LUoFK2KPQpMYcOA95iRV1IZgBWQCAJ/SBdVfuAwTqQiYKZfzmN7JCijpGVbpuaYNGXpYDI/JpsUiL+P5vR9vCzQSFdZH0tW+YP+DQXmhTCcu0LR8KO3GQB2hM4hTi76JRIjgxViLHj4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=OlRmokHi; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="OlRmokHi"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250918155610a4469400cb000207ae
        for <xenomai@lists.linux.dev>;
        Thu, 18 Sep 2025 17:56:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nYWK8sSowsemW/W57Fxpc0w5+M0O4xLjO4PfAPuTdzk=;
 b=OlRmokHicbRvWnNX+7kacujKMK90fOFfn3OpA5pT5Unq2Ijsl5lW526zgAEGPrwiolZDfk
 nR6dAE9daM4m4mpTAH2YDrQf80mVpzQ4sHttdwgOtxPnZZS80bs+k5MK2X4/x9N86oysqLRm
 gP+MLjb9s8BbDe58eZXvbqmVbws/8zHGeXErLiqoM+XVYUOGEtV44J5T+jdcOFN/c3KGY+RD
 MXmKmQ9zTO28zZflpuS+bXo3pZSwtU4zqvrOdmqerCGtHALzR8jBKjIvzQkLmyxQ5dvdaNlf
 7gtoOQ2wuE7EikuEZjcmC5r8qSvgrvQhe0XWLwJFvR97LDPBUgO3fTBw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 04/13] libevl: Unbreak build of r51..r55
Date: Thu, 18 Sep 2025 17:55:46 +0200
Message-ID: <45ee3b4aed024b1fc66864a77e09ddb49346e1a1.1758210955.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1758210955.git.jan.kiszka@siemens.com>
References: <cover.1758210955.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

One patch is needed since r53 up to and including the r55 release. An
additional build dependency is required since r51.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...missing-initialization-of-query_type.patch | 41 +++++++++++++++++++
 recipes-xenomai/libevl/libevl.inc             |  4 +-
 recipes-xenomai/libevl/libevl_55.bb           |  2 +
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch

diff --git a/recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch b/recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch
new file mode 100644
index 0000000..95993ea
--- /dev/null
+++ b/recipes-xenomai/libevl/files/0001-utils-net-Add-missing-initialization-of-query_type.patch
@@ -0,0 +1,41 @@
+From 11e695ec96fb07b4a6659f7527350e570c523b3c Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Wed, 10 Sep 2025 14:23:42 +0200
+Subject: [PATCH] utils: net: Add missing initialization of query_type
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+Fixes
+
+In function ‘query_oob_port’,
+    inlined from ‘main’ at ../utils/evl-net.c:483:3:
+../utils/evl-net.c:157:24: error: ‘query_type’ may be used uninitialized [-Werror=maybe-uninitialized]
+  157 |         if (!which || !*which) {
+      |                        ^~~~~~
+../utils/evl-net.c: In function ‘main’:
+../utils/evl-net.c:371:18: note: ‘query_type’ was declared here
+  371 |                 *query_type, *vlan_list = NULL;
+      |                  ^~~~~~~~~~
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ utils/evl-net.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/utils/evl-net.c b/utils/evl-net.c
+index b45fa60..b1d06a1 100644
+--- a/utils/evl-net.c
++++ b/utils/evl-net.c
+@@ -368,7 +368,7 @@ static void bad_usage(const char *arg0)
+ int main(int argc, char *argv[])
+ {
+ 	const char *netif = NULL, *modpath = NULL, *ipaddr = NULL,
+-		*query_type, *vlan_list = NULL;
++		*query_type = NULL, *vlan_list = NULL;
+ 	bool set_filter = false, solicit = false, permanent = false,
+ 		enable = false, disable = false, query = false,
+ 		allow_routing = false, set_vlans = false,
+-- 
+2.51.0
+
diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
index fb82d09..1783042 100644
--- a/recipes-xenomai/libevl/libevl.inc
+++ b/recipes-xenomai/libevl/libevl.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -17,7 +17,7 @@ DESCRIPTION ?= "libevl libraries and tools"
 SRC_URI += "file://debian"
 
 DEPENDS = "linux-xenomai-4"
-DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, pkg-config, libbpf-dev"
+DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, pkg-config, libbpf-dev, cpio"
 
 TEMPLATE_FILES = "debian/control.tmpl"
 TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
diff --git a/recipes-xenomai/libevl/libevl_55.bb b/recipes-xenomai/libevl/libevl_55.bb
index 36c05b4..1863210 100644
--- a/recipes-xenomai/libevl/libevl_55.bb
+++ b/recipes-xenomai/libevl/libevl_55.bb
@@ -12,3 +12,5 @@
 require libevl.inc
 
 SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=master;tag=r${PV}"
+
+SRC_URI += "file://0001-utils-net-Add-missing-initialization-of-query_type.patch"
-- 
2.51.0

