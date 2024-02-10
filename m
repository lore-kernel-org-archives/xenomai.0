Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315495FEE5
	for <xenomai@lists.linux.dev>; Sat, 10 Feb 2024 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602286; cv=none; b=dAyHvgUoLkqDr9b1GxpBpqdB79hu306FjszrxkWojNuXZjc+myUZqQbbNu/XT7xZiBQBp2o+9kO6fb/tYqZ/KtnmPPI54m4Ube8UpCiGCyk6lKTEZMWaacrHTMWHqPmy5gheI10Wo7EIaerfpUoG+4m49TLXg/mUcCQmO/jepbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602286; c=relaxed/simple;
	bh=xFn3ol335F35m6JUo1umgnff4nPjcEdkGfttVjxd6Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HGv0cA1fodYGO6kQI0rtJD2F/LdLyJ09SqJKnPNrUcHYFUzVE4doL+tYycRIixti1e1B6epbAxpzpNfhLe/gWjhbrjBa6Mda1sKuNTBNDS0f/URFiswDCSkZAa1Nr3Kr+AYg5sREWBrzEDhksm5GSevN+0ghgQzuwvP3espoM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ldGx72oL; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ldGx72oL"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240210215751fd13e695e8bf84cfe7
        for <xenomai@lists.linux.dev>;
        Sat, 10 Feb 2024 22:57:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=K960FUkHqFKFiveH16YYIxNXwrofZiDHfirocyfVGls=;
 b=ldGx72oLlyvK9+Tbir6PupQduoN1rxm1zSPF5BUm5YDhCU9SBFImDRcgDg3zfy0ZM3I702
 v/Nt6sex+2pCmUPKhCPHlEZkXDEDtJWrUzG1A2P55HLfwG03bNqeMsZKYoNpa1BuNKAiCiyz
 Rt8+wXsh/n9Hz+s1F967IfMIbfqtA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 10 Feb 2024 22:57:50 +0100
Subject: [PATCH xenomai-images v3] compat: Fix compat builds, switch to new
 ISAR compat API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-flo-fix-compat-testing-v2-v3-1-72e81671f1ec@siemens.com>
X-B4-Tracking: v=1; b=H4sIAF3xx2UC/42PvQ7CMAyEXwVlxihJKX8T74EY3NRpLbUJSkoEq
 vruWN3YOp599509q0yJKavbblaJCmeOQUS13ynXY+gIuBWtrLZHbfUV/BDB8wdcHF84wUR54tB
 BsWDQmPrcnK4Xi0ryDWaCJmFwvRDCexhk+Eok6bXwoT4U4ogMPGIno6fse85TTN/1nmJW14bqY
 sCA87o9t7X1p4u7Z6aRQj6Id+UWu5kln4A23tWNr7Cq/D9rWZYfGukh3jUBAAA=
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The last ISAR update introduced a regression, silently switching our
-compat builds to -native ones.

Whenever opt-compat.yml was selected it basically had no effect.

Adjusting to the new API requires us to specify the preferred version of
xenomai-compat in addition to xenomai. We have compat builds enabled for
the stable 3.2 series and current next/master.

To be consistent all kas option files that set a preferred version for
the xenomai package have been updated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Hi all,

it turned out that some CI jobs are not testing what the naming
suggests. Since the last ISAR update compat jobs were no compat tests 
any longer as they were silently migrated to native tasks...

Internal CI run was successful, but still: Review carefully!

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Clara Kowalsky <clara.kowalsky@siemens.com>
---
Changes in v3:
- Set PREFERRED_VERSION_xenomai-compat in distro config as well
- Link to v2: https://lore.kernel.org/r/20240209-flo-fix-compat-testing-v2-v2-1-01fc5bf3a33f@siemens.com

Changes in v2:
- Simplify get_package_names(), address review comments from Jan 
- Set PREFERRED_VERSION_xenomai-compat in all remaining option files as
  well
- Link to v1: https://lore.kernel.org/r/20240209-flo-fix-compat-testing-v2-v1-1-cf0d7d52f68c@siemens.com
---
 classes/print-revision.bbclass      |  4 ++--
 conf/distro/xenomai-demo.conf       |  3 ++-
 opt-compat.yml                      |  3 ++-
 opt-xenomai-3.0.x.yml               |  3 ++-
 opt-xenomai-3.1.x.yml               |  3 ++-
 opt-xenomai-3.2.x.yml               |  3 ++-
 opt-xenomai-next.yml                |  3 ++-
 recipes-core/images/demo-image.bb   | 17 +++++++++++------
 recipes-xenomai/xenomai/xenomai.inc |  4 +---
 9 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/classes/print-revision.bbclass b/classes/print-revision.bbclass
index ca4aa7b..7674129 100644
--- a/classes/print-revision.bbclass
+++ b/classes/print-revision.bbclass
@@ -18,6 +18,6 @@ def get_commit(d):
 COMMIT="${@get_commit(d)}"
 
 dpkg_runbuild:prepend() {
-    bbplain $(printf "%s-%s: Building revision %.20s\n" \
-                     ${PN} ${PV} ${COMMIT})
+    bbplain $(printf "%s-%s: Building revision %.20s for %s\n" \
+                     ${PN} ${PV} ${COMMIT} ${PACKAGE_ARCH})
 }
diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 2915dbf..9e8c346 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2023
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -16,6 +16,7 @@ XENOMAI_MAJOR_VERSION ?= "3"
 OVERRIDES .= ":xenomai${XENOMAI_MAJOR_VERSION}"
 
 PREFERRED_VERSION_xenomai ?= "3.2%"
+PREFERRED_VERSION_xenomai-compat ?= "3.2%"
 include conf/distro/include/xenomai-version.inc
 
 PREFERRED_VERSION_libevl ?= "4%"
diff --git a/opt-compat.yml b/opt-compat.yml
index 734066a..df01da8 100644
--- a/opt-compat.yml
+++ b/opt-compat.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2024
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   compat: |
     ISAR_ENABLE_COMPAT_ARCH = "1"
+    XENOMAI_PACKAGE_NAME_SUFFIX = "-compat"
diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
index 0962373..b078e6c 100644
--- a/opt-xenomai-3.0.x.yml
+++ b/opt-xenomai-3.0.x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   xenomai-3-0-x: |
     PREFERRED_VERSION_xenomai = "stable-3.0.x"
+    PREFERRED_VERSION_xenomai-compat = "stable-3.0.x"
diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
index 937b5f9..91c097f 100644
--- a/opt-xenomai-3.1.x.yml
+++ b/opt-xenomai-3.1.x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   xenomai-3-1-x: |
     PREFERRED_VERSION_xenomai = "stable-3.1.x"
+    PREFERRED_VERSION_xenomai-compat = "stable-3.1.x"
diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
index 401efa2..117161e 100644
--- a/opt-xenomai-3.2.x.yml
+++ b/opt-xenomai-3.2.x.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   xenomai-3-2-x: |
     PREFERRED_VERSION_xenomai = "stable-3.2.x"
+    PREFERRED_VERSION_xenomai-compat = "stable-3.2.x"
diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
index fd2fbab..1d8885a 100644
--- a/opt-xenomai-next.yml
+++ b/opt-xenomai-next.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   xenomai-latest: |
     PREFERRED_VERSION_xenomai = "next"
+    PREFERRED_VERSION_xenomai-compat = "next"
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index e19a038..69067ed 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -27,9 +27,16 @@ def has_testsuite_package(d):
 
 def get_testsuite_package_names(d):
     if not has_testsuite_package(d):
-        return ""
+        return []
 
-    return "xenomai-testsuite xenomai-testsuite-dbgsym"
+    return ["xenomai-testsuite", "xenomai-testsuite-dbgsym"]
+
+def get_package_names(d):
+    pkgs = ["xenomai-runtime", "xenomai-runtime-dbgsym", "libxenomai1-dbgsym"]
+    pkgs = pkgs + get_testsuite_package_names(d)
+    pkg_suffix = d.getVar("XENOMAI_PACKAGE_NAME_SUFFIX") or ""
+
+    return " ".join([p + pkg_suffix for p in pkgs])
 
 # Install gdb only for older stable releases. Enables gdb tests and avoids a
 # arch missmatch for compat builds on newer releases.
@@ -41,9 +48,7 @@ IMAGE_PREINSTALL += " \
     iw wireless-tools wpasupplicant dbus \
     lsb-release"
 
-IMAGE_INSTALL:append:xenomai3 = " xenomai-runtime xenomai-runtime-dbgsym"
-IMAGE_INSTALL:append:xenomai3 = " ${@get_testsuite_package_names(d)}"
-IMAGE_INSTALL:append:xenomai3 = " libxenomai1-dbgsym"
+IMAGE_INSTALL:append:xenomai3 = " ${@get_package_names(d)}"
 IMAGE_INSTALL:append:xenomai4 = " libevl"
 
 IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 95b2875..efb92ad 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2023
+# Copyright (c) Siemens AG, 2018-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -21,8 +21,6 @@ PROVIDES += "libxenomai1"
 PROVIDES += "libxenomai-dev"
 PROVIDES += "libxenomai1-dbgsym"
 
-PACKAGE_ARCH:compat-arch = "${COMPAT_DISTRO_ARCH}"
-
 do_prepare_build() {
     # Xenomai currently does not maintain its changelog, plus we want the
     # actual package version in there.

---
base-commit: 9c7bfa8f1af0faa68d19778d0e0a559f407e27df
change-id: 20240209-flo-fix-compat-testing-v2-1a1157b6982a

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

