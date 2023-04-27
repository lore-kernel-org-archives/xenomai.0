Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283F2594
	for <xenomai@lists.linux.dev>; Thu, 27 Apr 2023 12:36:44 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202304271156253669625f35a187bcf2
        for <xenomai@lists.linux.dev>;
        Thu, 27 Apr 2023 13:56:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zTJ3lad5hlg9iam2T1uglsItPa2abqfbGzVLv+qWL+Q=;
 b=AIhuaDoEOfWtkJZDsy/Sn/HjQt/j9tWLcuAF6IMLKlEkCfgFQrA3+03d/Lp3uRLkNol/N+
 yCxNOh9JHEsKEhoaIrx50igzBceeFOLyOrceq+jGkgF7w51+HtaAMH+mwEQ5YYnzBzwJU6uL
 367+9rJgoPIwIJAjkvq1YX75bUcY4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 27 Apr 2023 13:56:19 +0200
Subject: [PATCH xenomai-images 2/2] xenomai: Install xenomai-testsuite in
 addition to xenomai-runtime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-flo-testsuite-extraction-v1-2-6f026bba9c39@siemens.com>
References: <20230426-flo-testsuite-extraction-v1-0-6f026bba9c39@siemens.com>
In-Reply-To: <20230426-flo-testsuite-extraction-v1-0-6f026bba9c39@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The xenomai testsuite has been moved into a separate package
(xenomai-testsuite) during 3.3.x development but will stay inside the
xenomai-runtime package for older stable releases.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-core/images/demo-image.bb   | 27 +++++++++++++++++++++++++--
 recipes-xenomai/xenomai/xenomai.inc |  2 ++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index df849f2..540583b 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -14,11 +14,34 @@ inherit image
 ISAR_RELEASE_CMD = "git -C ${LAYERDIR_xenomai} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"
 DESCRIPTION = "Xenomai demo and test image"
 
+# The Xenomai testsuite was part of the xenomai-runtime package until 3.2.x.
+# Since 3.3.x a new package (xenomai-testsuite) is providing the testsuite.
+def has_testsuite_package(d):
+    xeno_ver = "PREFERRED_VERSION_xenomai"
+    v3_0 = d.getVar("XENOMAI_3_0_VERSION_LIST")
+    v3_1 = d.getVar("XENOMAI_3_1_VERSION_LIST")
+    v3_2 = d.getVar("XENOMAI_3_2_VERSION_LIST")
+    all = v3_0 + " " + v3_1 + " " + v3_2
+
+    return bb.utils.contains_any(xeno_ver, all, False, True, d)
+
+def get_testsuite_package_names(d):
+    if not has_testsuite_package(d):
+        return ""
+
+    return "xenomai-testsuite xenomai-testsuite-dbgsym"
+
+# Install gdb only for older stable releases. Enables gdb tests and avoids a
+# arch missmatch for compat builds on newer releases.
+IMAGE_PREINSTALL += "${@ 'gdb' if not has_testsuite_package(d) else '' }"
+
 IMAGE_PREINSTALL += " \
     bash-completion less vim nano man \
     ifupdown isc-dhcp-client net-tools iputils-ping ssh \
     iw wireless-tools wpasupplicant dbus \
-    gdb lsb-release"
+    lsb-release"
 
-IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym libxenomai1-dbgsym"
+IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym"
+IMAGE_INSTALL += "${@get_testsuite_package_names(d)}"
+IMAGE_INSTALL += "libxenomai1-dbgsym"
 IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index ca71d8c..0a32981 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -14,6 +14,8 @@ inherit dpkg
 PROVIDES += "xenomai-kernel-source"
 PROVIDES += "xenomai-runtime"
 PROVIDES += "xenomai-runtime-dbgsym"
+PROVIDES += "xenomai-testsuite"
+PROVIDES += "xenomai-testsuite-dbgsym"
 PROVIDES += "libxenomai1"
 PROVIDES += "libxenomai-dev"
 PROVIDES += "libxenomai1-dbgsym"

-- 
2.39.2

