Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE021FB5
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:48:45 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202302230748433a961e80afa7bf8b4e
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:48:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=1zY8qXk/jkxDGroN9fbotK89vrufTRt9M8ORrTiGzl0=;
 b=dwy3J2CbzPD2dJg2Mlq0pQVnA/e5k2YCaEe/8Bmr2JDRe9PUUHtb7zBZz0KORRx4OKcyI2
 dxLPjyGHkmIiHfLIEzIq6jhmQPQLJQUaszl7PFqTxV+ANBcNJ4B32zVlxgNdJbrEXCnayvG3
 2EfQcYQzaqZs/MMx/rAiMStpHdS7M=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [RFC PATCH] ci: Enable compat testing for the Xenomai stable/v3.2.x branch
Date: Thu, 23 Feb 2023 08:48:41 +0100
Message-Id: <20230223074841.3977544-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Add compat build and test jobs for the stable/v3.2.x branch.

The compat build and test jobs have been moved to compat_jobs.yml which
is now included by xenomai_next_compat.yml and xenomai_3_2_x.yml.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/compat_jobs.yml          | 43 +++++++++++++++++++++++++++++++++++++
 ci/xenomai_3_2_x.yml        |  1 +
 ci/xenomai_3_2_x_compat.yml | 19 ++++++++++++++++
 ci/xenomai_next_compat.yml  | 34 +++--------------------------
 4 files changed, 66 insertions(+), 31 deletions(-)
 create mode 100644 ci/compat_jobs.yml
 create mode 100644 ci/xenomai_3_2_x_compat.yml

diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
new file mode 100644
index 0000000..aaf582a
--- /dev/null
+++ b/ci/compat_jobs.yml
@@ -0,0 +1,43 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-5.15-compat:qemu-amd64:
+  extends:
+    - .build:qemu-amd64
+    - .compat-vars
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15-compat:qemu-amd64:
+  needs: [ "build-5.15-compat:qemu-amd64" ]
+  extends:
+    - .lava-test:qemu-amd64
+    - .compat-vars
+  variables:
+    KERNEL_VERSION: "5.15"
+
+build-5.15-compat:x86-64-efi:
+  extends:
+    - .build:x86-64-efi
+    - .compat-vars
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
+    KERNEL_VERSION: "5.15"
+
+lava-test-5.15-compat:x86-64-efi:
+  needs: [ "build-5.15-compat:x86-64-efi" ]
+  extends:
+    - .lava-test:x86-64-efi
+    - .compat-vars
+  variables:
+    KERNEL_VERSION: "5.15"
+
diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
index 3a1d5e3..3ee0b7d 100644
--- a/ci/xenomai_3_2_x.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -15,6 +15,7 @@ include:
   - local: '/ci/kernel_5_4.yml'
   - local: '/ci/kernel_5_10.yml'
   - local: '/ci/kernel_5_15.yml'
+  - local: '/ci/xenomai_3_2_x_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
new file mode 100644
index 0000000..a212859
--- /dev/null
+++ b/ci/xenomai_3_2_x_compat.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+.compat-vars:
+  variables:
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-compat.yml"
+    XENOMAI_VERSION: "3_2_x-compat"
+
+include:
+  - local: '/ci/compat_jobs.yml'
+
diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_next_compat.yml
index 92571ef..f7e3146 100644
--- a/ci/xenomai_next_compat.yml
+++ b/ci/xenomai_next_compat.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2023
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -14,34 +14,6 @@
     XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
     XENOMAI_VERSION: "next-compat"
 
-build-5.15-compat:qemu-amd64:
-  extends:
-    - .build:qemu-amd64
-    - .compat-vars
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
-    KERNEL_VERSION: "5.15"
-
-lava-test-5.15-compat:qemu-amd64:
-  needs: [ "build-5.15-compat:qemu-amd64" ]
-  extends:
-    - .lava-test:qemu-amd64
-    - .compat-vars
-  variables:
-    KERNEL_VERSION: "5.15"
+include:
+  - local: '/ci/compat_jobs.yml'
 
-build-5.15-compat:x86-64-efi:
-  extends:
-    - .build:x86-64-efi
-    - .compat-vars
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
-    KERNEL_VERSION: "5.15"
-
-lava-test-5.15-compat:x86-64-efi:
-  needs: [ "build-5.15-compat:x86-64-efi" ]
-  extends:
-    - .lava-test:x86-64-efi
-    - .compat-vars
-  variables:
-    KERNEL_VERSION: "5.15"
-- 
2.39.1

