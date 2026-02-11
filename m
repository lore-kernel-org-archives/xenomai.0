Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7832D7C7
	for <xenomai@lists.linux.dev>; Wed, 11 Feb 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815460; cv=none; b=bDfp6Rf7n8ieeO6hkUo4aImLIIB8ogY41anG0ST8jTLAP4/bLUXS9l/QXTjgCFbi3Mi8wmVpocUuKTKsKTQ7W8ffOkwHgyWCluZxCXME9iEJvYo1vu618Fq1Dz0wa+k16jlWAkkRme6LH3ip/YeSY1K9Y/3iQlVaarKuIrnv/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815460; c=relaxed/simple;
	bh=Gdz5wWqXWfMLTN1kYep4FVEp8NjFZEH81eSbuJ98zws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6aSZCxcyUxUOgKSZvDdhjRNRQOtAUFvcHvmQusUndCEjrdqySP0G4vWcBA0eGlpJqmzMIphxsblO7HAegzo5jztpdydZcdADUQgO+QuYJU4bMEXejc61aMrRROthPsEZiMpgIL/1cd0n8r2m2dkGzDI2CiAvXqlLyhVW1J2gdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=D1mH4ATC; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="D1mH4ATC"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260211131056e174cf97c00002072d
        for <xenomai@lists.linux.dev>;
        Wed, 11 Feb 2026 14:10:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=C+M95QZX5j1Z2PpupUJKm+SUxPjUg+1FPiq0BVSP2As=;
 b=D1mH4ATChd6dVKjikpULoWjnPK9YzCtXHAJYmetzH5Q456ZLt1bicpfeVIjqLpaEWnaydK
 SjC89x+GOX/XMhbY/B6t6yVHMyXS4Sq1X5lj8BVxPOcRbQtjce6bTl+Jve+T8+2PhkNiTOup
 d1wcz9er5d14XZOk2x0cgqasnmLgDkJ3Gqriw5ZTLiQesFrV9RL7cL6d4AQC/qznt87nFcPk
 e6WYaG58Klk6pT7h79pouVo2Z3kJXRI5bBICD4NCtGruh3H60nGP4om9e+aW5JYBCyu7mhzW
 jU6/KjD8O1Zy9NkCWyELd3U6+0P8d/nA+dKaxalnZm1kSXrZguQoxe/w==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 2/5] ci: Move reused files into lib folder
Date: Wed, 11 Feb 2026 14:10:39 +0100
Message-ID: <20260211131043.1185863-3-clara.kowalsky@siemens.com>
In-Reply-To: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
References: <20260211131043.1185863-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

All files that are reused by other yml files are placed in the lib
folder.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .gitlab-ci.yml                                   |  2 +-
 ci/{compat_jobs.yml => lib/compat/jobs.yml}      |  0
 .../compat/xenomai_3_2_x.yml}                    |  2 +-
 .../compat/xenomai_3_3_x.yml}                    |  2 +-
 .../compat/xenomai_3_next.yml}                   |  2 +-
 .../dovetail/xenomai_3_3_x.yml}                  |  0
 .../dovetail/xenomai_3_next.yml}                 |  0
 ci/{ => lib}/gitlab-ci-base.yml                  |  0
 ci/{kernel_4_19.yml => lib/kernel/4_19.yml}      |  0
 ci/{kernel_5_10.yml => lib/kernel/5_10.yml}      |  0
 ci/{kernel_5_15.yml => lib/kernel/5_15.yml}      |  0
 ci/{kernel_6_1.yml => lib/kernel/6_1.yml}        |  0
 ci/{kernel_6_12.yml => lib/kernel/6_12.yml}      |  2 +-
 .../kernel/6_12_physical.yml}                    |  0
 ci/{kernel_head.yml => lib/kernel/head.yml}      |  0
 ci/xenomai_3_1_x.yml                             |  4 ++--
 ci/xenomai_3_2_x.yml                             | 12 ++++++------
 ci/xenomai_3_3_x.yml                             | 12 ++++++------
 ...tail_xenomai_3.yml => xenomai_3_dovetail.yml} | 16 ++++++++--------
 ci/xenomai_3_next.yml                            | 10 +++++-----
 ci/xenomai_3_next_long_term.yml                  |  4 ++--
 ci/xenomai_4_next.yml                            |  6 +++---
 22 files changed, 37 insertions(+), 37 deletions(-)
 rename ci/{compat_jobs.yml => lib/compat/jobs.yml} (100%)
 rename ci/{xenomai_3_2_x_compat.yml => lib/compat/xenomai_3_2_x.yml} (90%)
 rename ci/{xenomai_3_3_x_compat.yml => lib/compat/xenomai_3_3_x.yml} (89%)
 rename ci/{xenomai_3_next_compat.yml => lib/compat/xenomai_3_next.yml} (90%)
 rename ci/{dovetail_xenomai_3_3_x.yml => lib/dovetail/xenomai_3_3_x.yml} (100%)
 rename ci/{dovetail_xenomai_3_next.yml => lib/dovetail/xenomai_3_next.yml} (100%)
 rename ci/{ => lib}/gitlab-ci-base.yml (100%)
 rename ci/{kernel_4_19.yml => lib/kernel/4_19.yml} (100%)
 rename ci/{kernel_5_10.yml => lib/kernel/5_10.yml} (100%)
 rename ci/{kernel_5_15.yml => lib/kernel/5_15.yml} (100%)
 rename ci/{kernel_6_1.yml => lib/kernel/6_1.yml} (100%)
 rename ci/{kernel_6_12.yml => lib/kernel/6_12.yml} (96%)
 rename ci/{kernel_6_12_physical.yml => lib/kernel/6_12_physical.yml} (100%)
 rename ci/{kernel_head.yml => lib/kernel/head.yml} (100%)
 rename ci/{dovetail_xenomai_3.yml => xenomai_3_dovetail.yml} (67%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 19d7ddd..c8f649f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -63,7 +63,7 @@ xenomai-3/dovetail:
   extends: .parent
   trigger:
     include:
-      - local: '/ci/dovetail_xenomai_3.yml'
+      - local: '/ci/xenomai_3_dovetail.yml'
   rules:
     - if: '$ONLY_RUN == $CI_JOB_NAME'
 
diff --git a/ci/compat_jobs.yml b/ci/lib/compat/jobs.yml
similarity index 100%
rename from ci/compat_jobs.yml
rename to ci/lib/compat/jobs.yml
diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/lib/compat/xenomai_3_2_x.yml
similarity index 90%
rename from ci/xenomai_3_2_x_compat.yml
rename to ci/lib/compat/xenomai_3_2_x.yml
index 9465cb1..c97940b 100644
--- a/ci/xenomai_3_2_x_compat.yml
+++ b/ci/lib/compat/xenomai_3_2_x.yml
@@ -15,4 +15,4 @@
     XENOMAI_VERSION: "3_2_x-compat"
 
 include:
-  - local: '/ci/compat_jobs.yml'
+  - local: '/ci/lib/compat/jobs.yml'
diff --git a/ci/xenomai_3_3_x_compat.yml b/ci/lib/compat/xenomai_3_3_x.yml
similarity index 89%
rename from ci/xenomai_3_3_x_compat.yml
rename to ci/lib/compat/xenomai_3_3_x.yml
index 3c55681..5279be4 100644
--- a/ci/xenomai_3_3_x_compat.yml
+++ b/ci/lib/compat/xenomai_3_3_x.yml
@@ -15,4 +15,4 @@
     XENOMAI_VERSION: "3_3_x-compat"
 
 include:
-  - local: '/ci/compat_jobs.yml'
+  - local: '/ci/lib/compat/jobs.yml'
diff --git a/ci/xenomai_3_next_compat.yml b/ci/lib/compat/xenomai_3_next.yml
similarity index 90%
rename from ci/xenomai_3_next_compat.yml
rename to ci/lib/compat/xenomai_3_next.yml
index ecd888d..bb00a34 100644
--- a/ci/xenomai_3_next_compat.yml
+++ b/ci/lib/compat/xenomai_3_next.yml
@@ -15,4 +15,4 @@
     XENOMAI_VERSION: "next-compat"
 
 include:
-  - local: '/ci/compat_jobs.yml'
+  - local: '/ci/lib/compat/jobs.yml'
diff --git a/ci/dovetail_xenomai_3_3_x.yml b/ci/lib/dovetail/xenomai_3_3_x.yml
similarity index 100%
rename from ci/dovetail_xenomai_3_3_x.yml
rename to ci/lib/dovetail/xenomai_3_3_x.yml
diff --git a/ci/dovetail_xenomai_3_next.yml b/ci/lib/dovetail/xenomai_3_next.yml
similarity index 100%
rename from ci/dovetail_xenomai_3_next.yml
rename to ci/lib/dovetail/xenomai_3_next.yml
diff --git a/ci/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
similarity index 100%
rename from ci/gitlab-ci-base.yml
rename to ci/lib/gitlab-ci-base.yml
diff --git a/ci/kernel_4_19.yml b/ci/lib/kernel/4_19.yml
similarity index 100%
rename from ci/kernel_4_19.yml
rename to ci/lib/kernel/4_19.yml
diff --git a/ci/kernel_5_10.yml b/ci/lib/kernel/5_10.yml
similarity index 100%
rename from ci/kernel_5_10.yml
rename to ci/lib/kernel/5_10.yml
diff --git a/ci/kernel_5_15.yml b/ci/lib/kernel/5_15.yml
similarity index 100%
rename from ci/kernel_5_15.yml
rename to ci/lib/kernel/5_15.yml
diff --git a/ci/kernel_6_1.yml b/ci/lib/kernel/6_1.yml
similarity index 100%
rename from ci/kernel_6_1.yml
rename to ci/lib/kernel/6_1.yml
diff --git a/ci/kernel_6_12.yml b/ci/lib/kernel/6_12.yml
similarity index 96%
rename from ci/kernel_6_12.yml
rename to ci/lib/kernel/6_12.yml
index 9048461..a9bed87 100644
--- a/ci/kernel_6_12.yml
+++ b/ci/lib/kernel/6_12.yml
@@ -10,7 +10,7 @@
 #
 
 include:
-  - local: '/ci/kernel_6_12_physical.yml'
+  - local: '/ci/lib/kernel/6_12_physical.yml'
 
 build-6.12:qemu-amd64:
   extends: .build:qemu-amd64
diff --git a/ci/kernel_6_12_physical.yml b/ci/lib/kernel/6_12_physical.yml
similarity index 100%
rename from ci/kernel_6_12_physical.yml
rename to ci/lib/kernel/6_12_physical.yml
diff --git a/ci/kernel_head.yml b/ci/lib/kernel/head.yml
similarity index 100%
rename from ci/kernel_head.yml
rename to ci/lib/kernel/head.yml
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index c5b8c70..292a999 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -10,8 +10,8 @@
 #
 
 include:
-  - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_4_19.yml'
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/4_19.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.1.x-head.yaml:kas/opt/debug.yaml"
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 4e8ab0d..9eb4e12 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -10,12 +10,12 @@
 #
 
 include:
-  - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_4_19.yml'
-  - local: '/ci/kernel_5_10.yml'
-  - local: '/ci/kernel_5_15.yml'
-  - local: '/ci/kernel_6_1.yml'
-  - local: '/ci/xenomai_3_2_x_compat.yml'
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/4_19.yml'
+  - local: '/ci/lib/kernel/5_10.yml'
+  - local: '/ci/lib/kernel/5_15.yml'
+  - local: '/ci/lib/kernel/6_1.yml'
+  - local: '/ci/lib/compat/xenomai_3_2_x.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.2.x-head.yaml:kas/opt/debug.yaml"
diff --git a/ci/xenomai_3_3_x.yml b/ci/xenomai_3_3_x.yml
index 71871b9..a64ddb7 100644
--- a/ci/xenomai_3_3_x.yml
+++ b/ci/xenomai_3_3_x.yml
@@ -10,12 +10,12 @@
 #
 
 include:
-  - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_5_10.yml'
-  - local: '/ci/kernel_5_15.yml'
-  - local: '/ci/kernel_6_1.yml'
-  - local: '/ci/kernel_6_12.yml'
-  - local: '/ci/xenomai_3_3_x_compat.yml'
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/5_10.yml'
+  - local: '/ci/lib/kernel/5_15.yml'
+  - local: '/ci/lib/kernel/6_1.yml'
+  - local: '/ci/lib/kernel/6_12.yml'
+  - local: '/ci/lib/compat/xenomai_3_3_x.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml"
diff --git a/ci/dovetail_xenomai_3.yml b/ci/xenomai_3_dovetail.yml
similarity index 67%
rename from ci/dovetail_xenomai_3.yml
rename to ci/xenomai_3_dovetail.yml
index 1628af2..916d191 100644
--- a/ci/dovetail_xenomai_3.yml
+++ b/ci/xenomai_3_dovetail.yml
@@ -10,29 +10,29 @@
 #
 
 include:
-  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/lib/gitlab-ci-base.yml'
 
   # select kernel config
-  - local: '/ci/kernel_5_10.yml'
+  - local: '/ci/lib/kernel/5_10.yml'
     rules:
       - if: '$KERNEL_VERSION == "5.10"'
-  - local: '/ci/kernel_5_15.yml'
+  - local: '/ci/lib/kernel/5_15.yml'
     rules:
       - if: '$KERNEL_VERSION == "5.15"'
-  - local: '/ci/kernel_6_1.yml'
+  - local: '/ci/lib/kernel/6_1.yml'
     rules:
       - if: '$KERNEL_VERSION == "6.1"'
-  - local: '/ci/kernel_6_12.yml'
+  - local: '/ci/lib/kernel/6_12.yml'
     rules:
       - if: '$KERNEL_VERSION == "6.12"'
-  - local: '/ci/kernel_head.yml'
+  - local: '/ci/lib/kernel/head.yml'
     rules:
       - if: '$KERNEL_VERSION == "head"'
 
   # select xenomai config
-  - local: '/ci/dovetail_xenomai_3_3_x.yml'
+  - local: '/ci/lib/dovetail/xenomai_3_3_x.yml'
     rules:
       - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
-  - local: '/ci/dovetail_xenomai_3_next.yml'
+  - local: '/ci/lib/dovetail/xenomai_3_next.yml'
     rules:
       - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12" || $KERNEL_VERSION == "head"'
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index 5d8967e..b1771f6 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -10,11 +10,11 @@
 #
 
 include:
-  - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_6_1.yml'
-  - local: '/ci/kernel_6_12.yml'
-  - local: '/ci/kernel_head.yml'
-  - local: '/ci/xenomai_3_next_compat.yml'
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/6_1.yml'
+  - local: '/ci/lib/kernel/6_12.yml'
+  - local: '/ci/lib/kernel/head.yml'
+  - local: '/ci/lib/compat/xenomai_3_next.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index ea720fc..da8749e 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -10,8 +10,8 @@
 #
 
 include:
-  - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_6_12_physical.yml'
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/6_12_physical.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml"
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 03dc233..5c1c7f4 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -10,9 +10,9 @@
 #
 
 include:
-  - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_6_1.yml'
-  - local: '/ci/kernel_6_12.yml'
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/6_1.yml'
+  - local: '/ci/lib/kernel/6_12.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
-- 
2.52.0

