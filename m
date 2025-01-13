Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF26922A4E9
	for <xenomai@lists.linux.dev>; Mon, 13 Jan 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772564; cv=none; b=NCNmk+/fPw1qaedDNABgXxvGK3TDoURV+80kSuYv3GZJrS/N48V49A20BwAyz1Hw0br/RpMAtSx7nhVwhspRqQ/eK5Zq32exOgEU2jy4NefmE6x2zKq8wZ+u9ulZ2Y4zKBFstGJGkcg5Z5q/0AEHjVTay1biAAFiGYrVyW4zs6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772564; c=relaxed/simple;
	bh=sCGVYVXYI+d1Ks68Fk53DCg4k8YUavXWSdwjz3UDFCY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONW9Hmxd1FHdu19jRdCAxU2vu/WNu+A34deg+lqYRJhKUzMiI/UYKXS6FZG8ebCoEp9/EzfEEFoROlxL/206Xp0F3IFvQaaN26yDDScEpKJIe/gJeR2ATR6lpKfhx5I3lZOKvAk7nIzRPOHv8XizZ1TZodSauxybIAevMCUEMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Os72fBDH; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Os72fBDH"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025011312491308fd07dcd6b8c188ae
        for <xenomai@lists.linux.dev>;
        Mon, 13 Jan 2025 13:49:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wIRQoDSLIqAKTKRpHQGtryQ+p+OLDzm6XqI3IZZZydc=;
 b=Os72fBDH6RITTXOG7eHOIk1IxxJCVx0gxKyobnTWH4PzzkGTbRXcsCaQdNAYpuid27LvUJ
 I9Suj/yeZ1sBIVc+9+5R7qNqNh5+ii2wVr7Z+k5UGlJQX29spOKEEoFel1BPNgZBHJRPYhJD
 hD9tDJa8WNbwr25qRLdx29jkptWRe0SkHKX3Gy7XyuziptxiPanaggasd21t/uH92uRGesU1
 bkybxcFooRp9wHnDrjXaa5LTmkf05BNL3nl6gTMeGAtabb+jsG9+yhXLSwTPEWlricBXY9tS
 1S5975HwoimFZ7zOREKAuE6q6dFBs3cgK/pHG7xNmqFORalENITdtCow==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 6/6] ci: Replace kernel 6.6 with 6.12
Date: Mon, 13 Jan 2025 13:49:08 +0100
Message-ID: <39a822c1a315a3fe58743029a719dfafd4dde835.1736772548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1736772548.git.jan.kiszka@siemens.com>
References: <cover.1736772548.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Moving forward to the latest LTS while dropping the previous latest one
helps keeping the test matrix size under control. In addition, 6.6 is
likely discontinued on Xenomai 3 and 4 side soon.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/compat_jobs.yml              | 14 ++++-----
 ci/kernel_6_12.yml              | 52 +++++++++++++++++++++++++++++++++
 ci/kernel_6_12_physical.yml     | 52 +++++++++++++++++++++++++++++++++
 ci/kernel_6_6.yml               | 52 ---------------------------------
 ci/kernel_6_6_physical.yml      | 52 ---------------------------------
 ci/xenomai_3_next.yml           |  6 ++--
 ci/xenomai_3_next_long_term.yml |  4 +--
 ci/xenomai_4_next.yml           |  6 ++--
 8 files changed, 119 insertions(+), 119 deletions(-)
 create mode 100644 ci/kernel_6_12.yml
 create mode 100644 ci/kernel_6_12_physical.yml
 delete mode 100644 ci/kernel_6_6.yml
 delete mode 100644 ci/kernel_6_6_physical.yml

diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
index 3e2d377..b5ad60a 100644
--- a/ci/compat_jobs.yml
+++ b/ci/compat_jobs.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -26,23 +26,23 @@ lava-test-5.15-compat:x86-64-efi:
   variables:
     KERNEL_VERSION: "5.15"
 
-build-6.6-compat:rpi4:
+build-6.12-compat:rpi4:
   extends:
     - .build:rpi4
     - .compat-vars
   rules:
     - if: '$XENOMAI_VERSION != "3_2_x-compat"'
   variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    KERNEL_VERSION: "6.12"
     CACHE_KERNEL: dovetail
 
-lava-test-6.6-compat:rpi4:
-  needs: [ "build-6.6-compat:rpi4" ]
+lava-test-6.12-compat:rpi4:
+  needs: [ "build-6.12-compat:rpi4" ]
   extends:
     - .lava-test:rpi4
     - .compat-vars
   rules:
     - if: '$XENOMAI_VERSION != "3_2_x-compat"'
   variables:
-    KERNEL_VERSION: "6.6"
+    KERNEL_VERSION: "6.12"
diff --git a/ci/kernel_6_12.yml b/ci/kernel_6_12.yml
new file mode 100644
index 0000000..ebf1da0
--- /dev/null
+++ b/ci/kernel_6_12.yml
@@ -0,0 +1,52 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024-2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/kernel_6_12_physical.yml'
+
+build-6.12:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:qemu-amd64:
+  needs: [ "build-6.12:qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    KERNEL_VERSION: "6.12"
+
+build-6.12:qemu-armhf:
+  extends: .build:qemu-armhf
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:qemu-armhf:
+  needs: [ "build-6.12:qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    KERNEL_VERSION: "6.12"
+
+build-6.12:qemu-arm64:
+  extends: .build:qemu-arm64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:qemu-arm64:
+  needs: [ "build-6.12:qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    KERNEL_VERSION: "6.12"
diff --git a/ci/kernel_6_12_physical.yml b/ci/kernel_6_12_physical.yml
new file mode 100644
index 0000000..17e42ad
--- /dev/null
+++ b/ci/kernel_6_12_physical.yml
@@ -0,0 +1,52 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024-2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-6.12:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:rpi4:
+  needs: [ "build-6.12:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "6.12"
+    TEST_MAXIMUM_LATENCY: 150
+
+build-6.12:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:beagle-bone-black:
+  needs: [ "build-6.12:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    KERNEL_VERSION: "6.12"
+    TEST_MAXIMUM_LATENCY: 150
+
+build-6.12:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.12.yml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:x86-64-efi:
+  needs: [ "build-6.12:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "6.12"
+    TEST_MAXIMUM_LATENCY: 100
diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
deleted file mode 100644
index 59e9704..0000000
--- a/ci/kernel_6_6.yml
+++ /dev/null
@@ -1,52 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-include:
-  - local: '/ci/kernel_6_6_physical.yml'
-
-build-6.6:qemu-amd64:
-  extends: .build:qemu-amd64
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:qemu-amd64:
-  needs: [ "build-6.6:qemu-amd64" ]
-  extends: .lava-test:qemu-amd64
-  variables:
-    KERNEL_VERSION: "6.6"
-
-build-6.6:qemu-armhf:
-  extends: .build:qemu-armhf
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:qemu-armhf:
-  needs: [ "build-6.6:qemu-armhf" ]
-  extends: .lava-test:qemu-armhf
-  variables:
-    KERNEL_VERSION: "6.6"
-
-build-6.6:qemu-arm64:
-  extends: .build:qemu-arm64
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:qemu-arm64:
-  needs: [ "build-6.6:qemu-arm64" ]
-  extends: .lava-test:qemu-arm64
-  variables:
-    KERNEL_VERSION: "6.6"
diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
deleted file mode 100644
index 2693907..0000000
--- a/ci/kernel_6_6_physical.yml
+++ /dev/null
@@ -1,52 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2024
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-build-6.6:rpi4:
-  extends: .build:rpi4
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:rpi4:
-  needs: [ "build-6.6:rpi4" ]
-  extends: .lava-test:rpi4
-  variables:
-    KERNEL_VERSION: "6.6"
-    TEST_MAXIMUM_LATENCY: 150
-
-build-6.6:beagle-bone-black:
-  extends: .build:beagle-bone-black
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:beagle-bone-black:
-  needs: [ "build-6.6:beagle-bone-black" ]
-  extends: .lava-test:beagle-bone-black
-  variables:
-    KERNEL_VERSION: "6.6"
-    TEST_MAXIMUM_LATENCY: 150
-
-build-6.6:x86-64-efi:
-  extends: .build:x86-64-efi
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:x86-64-efi:
-  needs: [ "build-6.6:x86-64-efi" ]
-  extends: .lava-test:x86-64-efi
-  variables:
-    KERNEL_VERSION: "6.6"
-    TEST_MAXIMUM_LATENCY: 100
diff --git a/ci/xenomai_3_next.yml b/ci/xenomai_3_next.yml
index 1a49f6e..d05596f 100644
--- a/ci/xenomai_3_next.yml
+++ b/ci/xenomai_3_next.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2024
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,10 +14,10 @@ include:
   - local: '/ci/kernel_5_10.yml'
   - local: '/ci/kernel_5_15.yml'
   - local: '/ci/kernel_6_1.yml'
-  - local: '/ci/kernel_6_6.yml'
+  - local: '/ci/kernel_6_12.yml'
   - local: '/ci/xenomai_3_next_compat.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-debug.yml"
   XENOMAI_VERSION: "next"
-  LATEST_KERNEL_VERSION: "6.6"
+  LATEST_KERNEL_VERSION: "6.12"
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index e3740f5..93c0e2f 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -11,11 +11,11 @@
 
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_6_6_physical.yml'
+  - local: '/ci/kernel_6_12_physical.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
   XENOMAI_VERSION: "next"
-  LATEST_KERNEL_VERSION: "6.6"
+  LATEST_KERNEL_VERSION: "6.12"
   TEST_RUNTIME_SECONDS: 3600
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 64657ff..36ea986 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2024
+# Copyright (c) Siemens AG, 2023-2025
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -12,11 +12,11 @@
 include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_6_1.yml'
-  - local: '/ci/kernel_6_6.yml'
+  - local: '/ci/kernel_6_12.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":opt-libevl-next.yml:opt-debug.yml"
   XENOMAI_VERSION: "next"
-  LATEST_KERNEL_VERSION: "6.6"
+  LATEST_KERNEL_VERSION: "6.12"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
-- 
2.43.0

