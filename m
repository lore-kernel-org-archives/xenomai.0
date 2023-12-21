Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EA55E79
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="gGYbKk+i"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231221163825576f558ba10606738a
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/8zhkbi/VRFonxk+JJ55yTL+Naa8Hg1nTi5G0pkpY7A=;
 b=gGYbKk+iusCEQMOcTIbRh3D7CemPOXts4OrWLp+/8Agj5R1zd4jHSP6ty3uV/Jar4Y2coe
 U1Jt+3+lgfLLb6YPKmeldzzDi6+KSR8msVFTMY+HR7NXlvwWF6+RgA6GH2sCc9BHZIPDGiut
 2G0o8+l3tnC82+4Gg1jZ7A7CUaPN4=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 2/7] xenomai-3: Mark xenomai 3 specific configs
Date: Thu, 21 Dec 2023 17:37:38 +0100
Message-Id: <20231221163743.2923801-3-clara.kowalsky@siemens.com>
In-Reply-To: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
References: <20231221163743.2923801-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

In preparation for the integration of EVL, a xenomai-3 override is
added.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 conf/distro/xenomai-demo.conf                  | 2 +-
 opt-xenomai-3.0.x.yml                          | 2 ++
 opt-xenomai-3.1.x.yml                          | 2 ++
 opt-xenomai-3.2.x.yml                          | 2 ++
 opt-xenomai-next.yml                           | 2 ++
 recipes-core/images/demo-image.bb              | 8 ++++----
 recipes-kernel/linux/linux-xenomai-3_latest.bb | 2 +-
 7 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index c99669d..d96cdaf 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -16,7 +16,7 @@ include conf/distro/include/xenomai-version.inc
 
 HOST_DISTRO ?= "debian-bookworm"
 
-KERNEL_NAME = "xenomai"
+KERNEL_NAME:xenomai3 = "xenomai-3"
 
 WKS_FILE = "${MACHINE}.wks"
 
diff --git a/opt-xenomai-3.0.x.yml b/opt-xenomai-3.0.x.yml
index 4559de8..35714b1 100644
--- a/opt-xenomai-3.0.x.yml
+++ b/opt-xenomai-3.0.x.yml
@@ -15,3 +15,5 @@ header:
 local_conf_header:
   xenomai-3-0-x: |
     PREFERRED_VERSION_xenomai = "stable-3.0.x"
+  xenomai-3_override: |
+    OVERRIDES .= ":xenomai3"
diff --git a/opt-xenomai-3.1.x.yml b/opt-xenomai-3.1.x.yml
index 2479e96..c5417d7 100644
--- a/opt-xenomai-3.1.x.yml
+++ b/opt-xenomai-3.1.x.yml
@@ -15,3 +15,5 @@ header:
 local_conf_header:
   xenomai-3-1-x: |
     PREFERRED_VERSION_xenomai = "stable-3.1.x"
+  xenomai-3_override: |
+    OVERRIDES .= ":xenomai3"
diff --git a/opt-xenomai-3.2.x.yml b/opt-xenomai-3.2.x.yml
index 1abcef9..54d0e9a 100644
--- a/opt-xenomai-3.2.x.yml
+++ b/opt-xenomai-3.2.x.yml
@@ -15,3 +15,5 @@ header:
 local_conf_header:
   xenomai-3-2-x: |
     PREFERRED_VERSION_xenomai = "stable-3.2.x"
+  xenomai-3_override: |
+    OVERRIDES .= ":xenomai3"
diff --git a/opt-xenomai-next.yml b/opt-xenomai-next.yml
index ba0b2da..9d74ed0 100644
--- a/opt-xenomai-next.yml
+++ b/opt-xenomai-next.yml
@@ -15,3 +15,5 @@ header:
 local_conf_header:
   xenomai-latest: |
     PREFERRED_VERSION_xenomai = "next"
+  xenomai-3_override: |
+    OVERRIDES .= ":xenomai3"
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 540583b..db7e2c7 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -33,7 +33,7 @@ def get_testsuite_package_names(d):
 
 # Install gdb only for older stable releases. Enables gdb tests and avoids a
 # arch missmatch for compat builds on newer releases.
-IMAGE_PREINSTALL += "${@ 'gdb' if not has_testsuite_package(d) else '' }"
+IMAGE_PREINSTALL:append:xenomai3 = " ${@ 'gdb' if not has_testsuite_package(d) else '' }"
 
 IMAGE_PREINSTALL += " \
     bash-completion less vim nano man \
@@ -41,7 +41,7 @@ IMAGE_PREINSTALL += " \
     iw wireless-tools wpasupplicant dbus \
     lsb-release"
 
-IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym"
-IMAGE_INSTALL += "${@get_testsuite_package_names(d)}"
-IMAGE_INSTALL += "libxenomai1-dbgsym"
+IMAGE_INSTALL:append:xenomai3 = " xenomai-runtime xenomai-runtime-dbgsym"
+IMAGE_INSTALL:append:xenomai3 = " ${@get_testsuite_package_names(d)}"
+IMAGE_INSTALL:append:xenomai3 = " libxenomai1-dbgsym"
 IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index adda9b5..a9c223a 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -72,6 +72,6 @@ GIT_BRANCH:arm64 = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
-SRCREV = "${AUTOREV}"
+SRCREV:xenomai3 = "${AUTOREV}"
 
 SRC_URI:append:beagle-bone-black = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) else '' }"
-- 
2.39.2

