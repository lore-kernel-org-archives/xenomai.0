Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1246FD7
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="cFypmN/F"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240110044603162ab4e6220b8882b2
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Czpx5jKpqfzpG7ZEKZbYub4sLvlOUNxOELAivnwgR4w=;
 b=cFypmN/F6EdIn695N/5Ltb9qpZGr1veXpPj1f7FZktdHDgYOVHpPxjcjkjq/7SaC9OVz+W
 5e260Eped8p/7PMEUl96Neiqh7BfCMkEBAPt6QKq/FtjpVUGWEweCOzuqbE6rWsZl0K9yiSS
 mFo7t2fkBwtarX4+tUvw9Nl6+LSVc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 05/10] xenomai-3: Mark xenomai 3 specific configs
Date: Wed, 10 Jan 2024 05:45:57 +0100
Message-Id: <f8381901b3aa09328fc7b9e289ec3c7dc91780c5.1704861962.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Clara Kowalsky <clara.kowalsky@siemens.com>

In preparation for the integration of EVL, a xenomai-3 override is
added.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
[Jan: set xenomai3 by default, drop unneeded override in linux-xenomai-3_latest]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/xenomai-demo.conf     | 2 ++
 recipes-core/images/demo-image.bb | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/conf/distro/xenomai-demo.conf b/conf/distro/xenomai-demo.conf
index 7b2b0a4..e6d690e 100644
--- a/conf/distro/xenomai-demo.conf
+++ b/conf/distro/xenomai-demo.conf
@@ -13,6 +13,8 @@ require conf/distro/debian-bookworm.conf
 
 XENOMAI_MAJOR_VERSION ?= "3"
 
+OVERRIDES .= ":xenomai${XENOMAI_MAJOR_VERSION}"
+
 PREFERRED_VERSION_xenomai ?= "3.2%"
 include conf/distro/include/xenomai-version.inc
 
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
-- 
2.35.3

