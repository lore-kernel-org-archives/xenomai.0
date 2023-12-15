Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4E2E3F5
	for <xenomai@lists.linux.dev>; Fri, 15 Dec 2023 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ehTp5+LS"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2023121511445925493e8488b6cdb0ce
        for <xenomai@lists.linux.dev>;
        Fri, 15 Dec 2023 12:44:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CtKpzjO6OiPAnKWRM/kSCpqrJAbsCLseZGLEm8osfzc=;
 b=ehTp5+LSEJW6tNdQLWYA87BrOqa/c/wZAfw8SOsblxNUA/5hNjwXhdrFSWLhLKO5YO4Cqe
 oypKLDtKaoT2etjbgzUaxShpqCqwXrSPPakOmMfJq9DM19jny1Om1qPA89roUDk7QkDnJch6
 N7xJbXUYAfpEQN8wKof23Ujh+dojM=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v1 4/5] ci: Add evl test
Date: Fri, 15 Dec 2023 12:43:48 +0100
Message-Id: <20231215114349.2913803-5-clara.kowalsky@siemens.com>
In-Reply-To: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
References: <20231215114349.2913803-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Test cases are added for the linux-evl kernel v6.1 and v6.6 and for
libevl master and next branch.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .gitlab-ci.yml        | 12 ++++++++++++
 ci/evl_kernel_6_1.yml | 17 +++++++++++++++++
 ci/evl_kernel_6_6.yml | 17 +++++++++++++++++
 ci/evl_master.yml     | 22 ++++++++++++++++++++++
 ci/evl_next.yml       | 22 ++++++++++++++++++++++
 5 files changed, 90 insertions(+)
 create mode 100644 ci/evl_kernel_6_1.yml
 create mode 100644 ci/evl_kernel_6_6.yml
 create mode 100644 ci/evl_master.yml
 create mode 100644 ci/evl_next.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6e4f1df..cd0188e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -49,3 +49,15 @@ next:
   trigger:
     include:
       - local: '/ci/xenomai_next.yml'
+
+evl-master:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/evl_master.yml'
+
+evl-next:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/evl_next.yml'
diff --git a/ci/evl_kernel_6_1.yml b/ci/evl_kernel_6_1.yml
new file mode 100644
index 0000000..4c5ba73
--- /dev/null
+++ b/ci/evl_kernel_6_1.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-6.1:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linuxevl-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+    LATEST_KERNEL_VERSION: "6.1"
diff --git a/ci/evl_kernel_6_6.yml b/ci/evl_kernel_6_6.yml
new file mode 100644
index 0000000..b9335e1
--- /dev/null
+++ b/ci/evl_kernel_6_6.yml
@@ -0,0 +1,17 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-6.6:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linuxevl-latest-6.6.yml"
+    KERNEL_VERSION: "6.6"
+    LATEST_KERNEL_VERSION: "6.6"
diff --git a/ci/evl_master.yml b/ci/evl_master.yml
new file mode 100644
index 0000000..9b19d7f
--- /dev/null
+++ b/ci/evl_master.yml
@@ -0,0 +1,22 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2022
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/evl_kernel_6_1.yml'
+  - local: '/ci/evl_kernel_6_6.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-libevl-master.yml"
+  XENOMAI_VERSION: "master"
+  ISAR_IMAGE: evl-image
+  ISAR_DISTRIBUTION: evl-demo
+  BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
diff --git a/ci/evl_next.yml b/ci/evl_next.yml
new file mode 100644
index 0000000..8b007f6
--- /dev/null
+++ b/ci/evl_next.yml
@@ -0,0 +1,22 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2022
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/evl_kernel_6_1.yml'
+  - local: '/ci/evl_kernel_6_6.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-libevl-next.yml"
+  XENOMAI_VERSION: "next"
+  ISAR_IMAGE: evl-image
+  ISAR_DISTRIBUTION: evl-demo
+  BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
-- 
2.39.2

