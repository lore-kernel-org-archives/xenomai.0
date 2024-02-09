Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E763B3
	for <xenomai@lists.linux.dev>; Fri,  9 Feb 2024 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520198; cv=none; b=NZtfloQ3sqKts5oF11Pe49GxGKTxOo99scnvmyAh9JCwaLgnHpa5Rg6vpx6oDgT+GqwE5Ut0Jq2ElnhI8H2sCpbtxaClGcG+LjuEfpXBxCZd+HJQQyjnYGZMLrrur8mnc0aj0+jilrF3Y9A4S1qEddpK6Pw951kc6V2ON6grGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520198; c=relaxed/simple;
	bh=058OPCrRL8s8QIX6jeLLe92AkUGhTAs+TY9ZIyJBQTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RzqQui+dCYkwwfjduO4ZBlrOiAUQl/CHdJniVYVVOQAMf6yDEPvmKZFTHrX9zZilE1bwMRGIe0MeFueXrJmWxnNi/FkaZ0KpGyE7OMXJ9ej3/4OukyYaPsz30IaOday2RAnlEdD5zlkML8hvZZSYsziOH5/ecSe0SlzUqSU81Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=iWhbKD2Y; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iWhbKD2Y"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202402092309488d2509e82cd5ea24a2
        for <xenomai@lists.linux.dev>;
        Sat, 10 Feb 2024 00:09:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=PvU4xVmjjKyhaRLjaCB0WUuf3Ssy0OtHpRAT7bkpZSA=;
 b=iWhbKD2YcV8d7GUJHL21KfBxyJO6iU84NKd5YAjhfmuYYxTX06oK3UT8XPfFspAFWWVQXM
 a9zR6CO61Y8qg8YysRKhkVZjv9YDxitF5oUMz9Hq4RNcSMv5pSXFjDzecrNa/F3oYT+c73YJ
 PHeFqJnoadXCGFJUBlVBQKywBwZwI=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Sat, 10 Feb 2024 00:09:40 +0100
Subject: [PATCH xenomai-images] compat: Fix compat builds, switch to new
 ISAR API
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-flo-fix-compat-testing-v2-v1-1-cf0d7d52f68c@siemens.com>
X-B4-Tracking: v=1; b=H4sIALOwxmUC/x2N3QqDMAxGX0VyvYAt+3OvMrxIXdRAm0rrRBDff
 WGX58D5vgMqF+EKr+aAwptUyWrgLg0MM+nEKB9j8K2/tr7tcIwZR9lxyGmhFVeuq+iEm0dHzt0
 e4d49PYH1gSpjKKTDbAv6jdHkUtjq/+EbdtacSFASTab68/wBlLaMDJAAAAA=
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Clara Kowalsky <clara.kowalsky@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The last ISAR update introduced a regression, silently switching our
-compat builds to -native ones.

Whenever opt-compat.yml was selected it basically had no effect.

Adjusting to the new API requires us to specify the prefered version of
xenomai-compat in addition to xenomai. We have compat builds enabled for
the stable 3.2 series and current next/master. The affected kas option
files have been updated.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Hi all,

it turned out that some CI jobs are not testing what the naming
suggests. Since the last ISAR update compat jobs were no compat tests 
any longer as they were silently migrated to native tasks...

Internal CI run was successful, but still: Review carefully!

Best regards,
Florian

CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 classes/print-revision.bbclass      |  4 ++--
 opt-compat.yml                      |  3 ++-
 opt-xenomai-3.2.x.yml               |  3 ++-
 opt-xenomai-next.yml                |  1 +
 recipes-core/images/demo-image.bb   | 21 +++++++++++++++------
 recipes-xenomai/xenomai/xenomai.inc |  4 +---
 6 files changed, 23 insertions(+), 13 deletions(-)

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
index fd2fbab..132a329 100644
--- a/opt-xenomai-next.yml
+++ b/opt-xenomai-next.yml
@@ -15,3 +15,4 @@ header:
 local_conf_header:
   xenomai-latest: |
     PREFERRED_VERSION_xenomai = "next"
+    PREFERRED_VERSION_xenomai-compat = "next"
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index e19a038..7bb834c 100644
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
@@ -27,9 +27,20 @@ def has_testsuite_package(d):
 
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
+    pkg_suffix = d.getVar("XENOMAI_PACKAGE_NAME_SUFFIX")
+
+    if pkg_suffix:
+        for i in range(len(pkgs)):
+            pkgs[i] = pkgs[i] + pkg_suffix
+
+    return " ".join(pkgs)
 
 # Install gdb only for older stable releases. Enables gdb tests and avoids a
 # arch missmatch for compat builds on newer releases.
@@ -41,9 +52,7 @@ IMAGE_PREINSTALL += " \
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

