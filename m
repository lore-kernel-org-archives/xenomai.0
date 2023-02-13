Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D71FB8
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 07:11:29 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023021307011826dcdf900d43bc7d86
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 08:01:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=d7YDAtNYriOcQdC6pJsDl+rE2/QdnSvH/WO4jWj/5VE=;
 b=A8imbQA+9ewZw8S40iZnf3Yq8QJGfGnOWxAft7o4yVwdE7oU+NUBNNGqDxHHVgIlmCKOmh
 BPzNLU7UB3OW0kItMemWUqs7I57QvYlgf1Sw8xsDXEFhtjxXRs+eFbeg4PZ85p9at1X0UNaU
 JbnjZS7osScQo4kijKlqnvkG7AIqA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 4/7] ci: Hook up kernel 6.1
Date: Mon, 13 Feb 2023 08:01:13 +0100
Message-Id: <5573a966fecb301447eb73ea3350ff5f7b986bf0.1676271676.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1676271676.git.jan.kiszka@siemens.com>
References: <cover.1676271676.git.jan.kiszka@siemens.com>
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

Add a builds and test for all targets with this new LTS kernel. We will
reduce coverage of older kernels later in order to limit CI efforts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/kernel_6_1.yml   | 82 +++++++++++++++++++++++++++++++++++++++++++++
 ci/xenomai_next.yml |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 ci/kernel_6_1.yml

diff --git a/ci/kernel_6_1.yml b/ci/kernel_6_1.yml
new file mode 100644
index 0000000..2e555af
--- /dev/null
+++ b/ci/kernel_6_1.yml
@@ -0,0 +1,82 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-6.1:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+
+lava-test-6.1:qemu-amd64:
+  needs: [ "build-6.1:qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+  variables:
+    KERNEL_VERSION: "6.1"
+
+build-6.1:qemu-armhf:
+  extends: .build:qemu-armhf
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+
+lava-test-6.1:qemu-armhf:
+  needs: [ "build-6.1:qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+  variables:
+    KERNEL_VERSION: "6.1"
+
+build-6.1:qemu-arm64:
+  extends: .build:qemu-arm64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.16"
+
+lava-test-6.1:qemu-arm64:
+  needs: [ "build-6.1:qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+  variables:
+    KERNEL_VERSION: "6.1"
+
+build-6.1:hikey:
+  extends: .build:hikey
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+
+lava-test-6.1:hikey:
+  needs: [ "build-6.1:hikey" ]
+  extends: .lava-test:hikey
+  variables:
+    KERNEL_VERSION: "6.1"
+
+build-6.1:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+
+lava-test-6.1:beagle-bone-black:
+  needs: [ "build-6.1:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    KERNEL_VERSION: "6.1"
+
+build-6.1:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+
+lava-test-6.1:x86-64-efi:
+  needs: [ "build-6.1:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "6.1"
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index b9e9a57..3e4d513 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -13,6 +13,7 @@ include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_5_10.yml'
   - local: '/ci/kernel_5_15.yml'
+  - local: '/ci/kernel_6_1.yml'
   - local: '/ci/xenomai_next_compat.yml'
 
 variables:
-- 
2.35.3

