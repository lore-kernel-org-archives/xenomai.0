Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7A55E77
	for <xenomai@lists.linux.dev>; Thu, 21 Dec 2023 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="bVH4Cr99"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231221163831f6e9db916b2c968053
        for <xenomai@lists.linux.dev>;
        Thu, 21 Dec 2023 17:38:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LSwuZWfYFIm6MOhp38co3/H+RK2oqcm8ze4LC8TsO+A=;
 b=bVH4Cr99d9wjNUKdj8rEjhQMNR3FARwCiqRH6KoyyzQZh21+pocGv/ks0tRDzZiMrMITmb
 AUPA4Vci52Mc1rTfTbR7ctKf/FoJwSdXFtSxH9TqbEXHZojrNz53WMxgDnpO7BQCxPlrrOh5
 S7D8tplai/N/+QFscawfr/+6IWmqQ=;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev,
	rpm@xenomai.org
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 6/7] ci: Add xenomai-4 test cases
Date: Thu, 21 Dec 2023 17:37:42 +0100
Message-Id: <20231221163743.2923801-7-clara.kowalsky@siemens.com>
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

Test cases are added for the linux-evl kernel v6.1 and v6.6.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/xenomai_4_kernel_6_1.yml | 17 +++++++++++++++++
 ci/xenomai_4_kernel_6_6.yml | 17 +++++++++++++++++
 ci/xenomai_4_master.yml     | 20 ++++++++++++++++++++
 ci/xenomai_4_next.yml       | 20 ++++++++++++++++++++
 ci/xenomai_4_r46.yml        | 20 ++++++++++++++++++++
 ci/xenomai_4_stable.yml     | 20 ++++++++++++++++++++
 6 files changed, 114 insertions(+)
 create mode 100644 ci/xenomai_4_kernel_6_1.yml
 create mode 100644 ci/xenomai_4_kernel_6_6.yml
 create mode 100644 ci/xenomai_4_master.yml
 create mode 100644 ci/xenomai_4_next.yml
 create mode 100644 ci/xenomai_4_r46.yml
 create mode 100644 ci/xenomai_4_stable.yml

diff --git a/ci/xenomai_4_kernel_6_1.yml b/ci/xenomai_4_kernel_6_1.yml
new file mode 100644
index 0000000..7f96611
--- /dev/null
+++ b/ci/xenomai_4_kernel_6_1.yml
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
+    LINUX_BUILD_OPTION: ":opt-xen4-linux-latest-6.1.yml"
+    KERNEL_VERSION: "6.1"
+    LATEST_KERNEL_VERSION: "6.1"
diff --git a/ci/xenomai_4_kernel_6_6.yml b/ci/xenomai_4_kernel_6_6.yml
new file mode 100644
index 0000000..b29ab71
--- /dev/null
+++ b/ci/xenomai_4_kernel_6_6.yml
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
+    LINUX_BUILD_OPTION: ":opt-xen4-linux-latest-6.6.yml"
+    KERNEL_VERSION: "6.6"
+    LATEST_KERNEL_VERSION: "6.6"
diff --git a/ci/xenomai_4_master.yml b/ci/xenomai_4_master.yml
new file mode 100644
index 0000000..9af0aa7
--- /dev/null
+++ b/ci/xenomai_4_master.yml
@@ -0,0 +1,20 @@
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
+  - local: '/ci/xenomai_4_kernel_6_1.yml'
+  - local: '/ci/xenomai_4_kernel_6_6.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-libevl-master.yml"
+  XENOMAI_VERSION: "master"
+  BUILD_IDENTIFIER: "xen4-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
new file mode 100644
index 0000000..9c6ec2e
--- /dev/null
+++ b/ci/xenomai_4_next.yml
@@ -0,0 +1,20 @@
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
+  - local: '/ci/xenomai_4_kernel_6_1.yml'
+  - local: '/ci/xenomai_4_kernel_6_6.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-libevl-next.yml"
+  XENOMAI_VERSION: "next"
+  BUILD_IDENTIFIER: "xen4-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
diff --git a/ci/xenomai_4_r46.yml b/ci/xenomai_4_r46.yml
new file mode 100644
index 0000000..c3f3469
--- /dev/null
+++ b/ci/xenomai_4_r46.yml
@@ -0,0 +1,20 @@
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
+  - local: '/ci/xenomai_4_kernel_6_1.yml'
+  - local: '/ci/xenomai_4_kernel_6_6.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-libevl-r46.yml"
+  XENOMAI_VERSION: "r46"
+  BUILD_IDENTIFIER: "xen4-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
diff --git a/ci/xenomai_4_stable.yml b/ci/xenomai_4_stable.yml
new file mode 100644
index 0000000..c6b1b07
--- /dev/null
+++ b/ci/xenomai_4_stable.yml
@@ -0,0 +1,20 @@
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
+  - local: '/ci/xenomai_4_kernel_6_1.yml'
+  - local: '/ci/xenomai_4_kernel_6_6.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-libevl-stable.yml"
+  XENOMAI_VERSION: "stable"
+  BUILD_IDENTIFIER: "xen4-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
-- 
2.39.2

