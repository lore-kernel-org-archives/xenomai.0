Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF391DA43
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="JWkNEVq1"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231221163830740b7e4530bb39278f
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Mjx2CZy4hZZcxRssnmzd+tBTrs3Egw/4816IhEEhEqI=;
 b=JWkNEVq13/nvqk437W2M0p4T+ax5cvZ1FnJjHcUaOGe2U/MJ+UuTyX8aaNoqopcmbdYrKg
 YbLVB+4EGYQTYakX2OfyPJn6IXCEybjEAZAvD3DyoscRfBkzxsCOaM4vcBs+Mm/kzDEl3d8z
 Np9WfG8BpCMZWHUzVyyWgoh9sPTIU=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 5/7] ci: Rename xenomai 3 files
Date: Thu, 21 Dec 2023 17:37:41 +0100
Message-Id: <20231221163743.2923801-6-clara.kowalsky@siemens.com>
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

The files for xenomai 3 obtain a corresponding name change.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .gitlab-ci.yml                                     | 14 +++++++++++++-
 ci/xenomai_3_1_x.yml                               |  2 +-
 ci/xenomai_3_2_x.yml                               |  8 ++++----
 ci/{kernel_4_19.yml => xenomai_3_kernel_4_19.yml}  |  0
 ci/{kernel_5_10.yml => xenomai_3_kernel_5_10.yml}  |  0
 ci/{kernel_5_15.yml => xenomai_3_kernel_5_15.yml}  |  0
 ci/{kernel_5_4.yml => xenomai_3_kernel_5_4.yml}    |  0
 ci/{kernel_6_1.yml => xenomai_3_kernel_6_1.yml}    |  0
 ci/{xenomai_next.yml => xenomai_3_next.yml}        |  8 ++++----
 ...i_next_compat.yml => xenomai_3_next_compat.yml} |  0
 10 files changed, 22 insertions(+), 10 deletions(-)
 rename ci/{kernel_4_19.yml => xenomai_3_kernel_4_19.yml} (100%)
 rename ci/{kernel_5_10.yml => xenomai_3_kernel_5_10.yml} (100%)
 rename ci/{kernel_5_15.yml => xenomai_3_kernel_5_15.yml} (100%)
 rename ci/{kernel_5_4.yml => xenomai_3_kernel_5_4.yml} (100%)
 rename ci/{kernel_6_1.yml => xenomai_3_kernel_6_1.yml} (100%)
 rename ci/{xenomai_next.yml => xenomai_3_next.yml} (66%)
 rename ci/{xenomai_next_compat.yml => xenomai_3_next_compat.yml} (100%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6e4f1df..1120f20 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -48,4 +48,16 @@ next:
   extends: .parent
   trigger:
     include:
-      - local: '/ci/xenomai_next.yml'
+      - local: '/ci/xenomai_3_next.yml'
+
+xen4-master:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_4_master.yml'
+
+xen4-next:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_4_next.yml'
diff --git a/ci/xenomai_3_1_x.yml b/ci/xenomai_3_1_x.yml
index b6f0010..07735d2 100644
--- a/ci/xenomai_3_1_x.yml
+++ b/ci/xenomai_3_1_x.yml
@@ -11,7 +11,7 @@
 
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_4_19.yml'
+  - local: '/ci/xenomai_3_kernel_4_19.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-3.1.x.yml"
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 781eec8..bb2ebe7 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -11,10 +11,10 @@
 
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_4_19.yml'
-  - local: '/ci/kernel_5_4.yml'
-  - local: '/ci/kernel_5_10.yml'
-  - local: '/ci/kernel_5_15.yml'
+  - local: '/ci/xenomai_3_kernel_4_19.yml'
+  - local: '/ci/xenomai_3_kernel_5_4.yml'
+  - local: '/ci/xenomai_3_kernel_5_10.yml'
+  - local: '/ci/xenomai_3_kernel_5_15.yml'
   - local: '/ci/xenomai_3_2_x_compat.yml'
 
 variables:
diff --git a/ci/kernel_4_19.yml b/ci/xenomai_3_kernel_4_19.yml
similarity index 100%
rename from ci/kernel_4_19.yml
rename to ci/xenomai_3_kernel_4_19.yml
diff --git a/ci/kernel_5_10.yml b/ci/xenomai_3_kernel_5_10.yml
similarity index 100%
rename from ci/kernel_5_10.yml
rename to ci/xenomai_3_kernel_5_10.yml
diff --git a/ci/kernel_5_15.yml b/ci/xenomai_3_kernel_5_15.yml
similarity index 100%
rename from ci/kernel_5_15.yml
rename to ci/xenomai_3_kernel_5_15.yml
diff --git a/ci/kernel_5_4.yml b/ci/xenomai_3_kernel_5_4.yml
similarity index 100%
rename from ci/kernel_5_4.yml
rename to ci/xenomai_3_kernel_5_4.yml
diff --git a/ci/kernel_6_1.yml b/ci/xenomai_3_kernel_6_1.yml
similarity index 100%
rename from ci/kernel_6_1.yml
rename to ci/xenomai_3_kernel_6_1.yml
diff --git a/ci/xenomai_next.yml b/ci/xenomai_3_next.yml
similarity index 66%
rename from ci/xenomai_next.yml
rename to ci/xenomai_3_next.yml
index b611e60..0ee3767 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -11,10 +11,10 @@
 
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_5_10.yml'
-  - local: '/ci/kernel_5_15.yml'
-  - local: '/ci/kernel_6_1.yml'
-  - local: '/ci/xenomai_next_compat.yml'
+  - local: '/ci/xenomai_3_kernel_5_10.yml'
+  - local: '/ci/xenomai_3_kernel_5_15.yml'
+  - local: '/ci/xenomai_3_kernel_6_1.yml'
+  - local: '/ci/xenomai_3_next_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_3_next_compat.yml
similarity index 100%
rename from ci/xenomai_next_compat.yml
rename to ci/xenomai_3_next_compat.yml
-- 
2.39.2

