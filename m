Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C903382C9
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304406; cv=none; b=r/5XpPeKhMHx18i+p5yDSIbeMXGAZ+/yziz8u3xtw6x9UHBpngfGtFpNB1suP3cSWCST31PPiGlloKVdHVLPC7Fsvs099BPmzQeHPQTe+M37b9XK1eaVx5ssBRNU0TX/gxPdl1HowVHUUk8K8gse7tS4Zt3bR4wPXmZX1cVqAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304406; c=relaxed/simple;
	bh=BkZpAUnwpYn106gtk5CAeuR4trE9ZiWyL2uwfSr81xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgPSY/81HgY5JeTuEIbyGSn3JeecfIIlE9h+5O5ogARbtnHxR2jHAp+pQSdQnVE+ggLFFNHkbYzlfj7PrQMJeGuIVhCT2eelk0KiIY1XqIA8RdBbePSfY5m2psaUCOn5lTWrBVbCJJpDZXpavWlAdSuNCHWsVzLNxiXgMSMluks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=RN/DZzyV; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="RN/DZzyV"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026011311395814669cd005000207d9
        for <xenomai@lists.linux.dev>;
        Tue, 13 Jan 2026 12:39:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7LOjMuZAe2JohEXNcI06yUTELFap7kfW0lUB5vKySnQ=;
 b=RN/DZzyVFLOPEGbr23GepFsF/6hyaeE6zsNucFYMDBLf2scCPF0GfkLkgbMiTRP9MgwKmx
 Yh98jpf6jtCnK34pXuehgpXGN4m8sk4jQ3RCXX08nMamU1Y0MvjQAwcL7vZxSAEMUg1lsGOh
 RkOJbrMDZm6ejY5zOPCfDIvktWMMWsOiM+oFLUWncYoLYC6KErPSuCACDAtOz10nqI1fZUFw
 4l0M5toqVkbS/4dE3sO95gZVaoegiicUnZTfjjgC/HLkHv+mMxjt/RkIBVGs9nDK69TF1XGJ
 MsDiUC1nJR/YkWrfjC+to03rh8cgmKcnemCi8OitNPXfGlF64sP5rBuQ==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v4 2/3] ci: Add build job for pipeline triggered by linux-dovetail
Date: Tue, 13 Jan 2026 12:39:43 +0100
Message-ID: <20260113113945.1038227-3-clara.kowalsky@siemens.com>
In-Reply-To: <20260113113945.1038227-1-clara.kowalsky@siemens.com>
References: <20260113113945.1038227-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .gitlab-ci.yml                 |  8 ++++++++
 ci/dovetail_xenomai_3.yml      | 35 ++++++++++++++++++++++++++++++++++
 ci/dovetail_xenomai_3_3_x.yml  | 14 ++++++++++++++
 ci/dovetail_xenomai_3_next.yml | 14 ++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 ci/dovetail_xenomai_3.yml
 create mode 100644 ci/dovetail_xenomai_3_3_x.yml
 create mode 100644 ci/dovetail_xenomai_3_next.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2f03fdd..19d7ddd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -59,6 +59,14 @@ xenomai-3/next-long-term:
   rules:
     - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
 
+xenomai-3/dovetail:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/dovetail_xenomai_3.yml'
+  rules:
+    - if: '$ONLY_RUN == $CI_JOB_NAME'
+
 xenomai-4/next:
   extends: .parent
   trigger:
diff --git a/ci/dovetail_xenomai_3.yml b/ci/dovetail_xenomai_3.yml
new file mode 100644
index 0000000..3ba027f
--- /dev/null
+++ b/ci/dovetail_xenomai_3.yml
@@ -0,0 +1,35 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+
+  # select kernel config
+  - local: '/ci/kernel_5_10.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "5.10"'
+  - local: '/ci/kernel_5_15.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "5.15"'
+  - local: '/ci/kernel_6_1.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.1"'
+  - local: '/ci/kernel_6_12.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.12"'
+
+  # select xenomai config
+  - local: '/ci/dovetail_xenomai_3_3_x.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
+  - local: '/ci/dovetail_xenomai_3_next.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12"'
diff --git a/ci/dovetail_xenomai_3_3_x.yml b/ci/dovetail_xenomai_3_3_x.yml
new file mode 100644
index 0000000..84bebd4
--- /dev/null
+++ b/ci/dovetail_xenomai_3_3_x.yml
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+variables:
+  XENOMAI_VERSION: "3.3.x"
+  XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml"
diff --git a/ci/dovetail_xenomai_3_next.yml b/ci/dovetail_xenomai_3_next.yml
new file mode 100644
index 0000000..6c1602a
--- /dev/null
+++ b/ci/dovetail_xenomai_3_next.yml
@@ -0,0 +1,14 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+variables:
+  XENOMAI_VERSION: "3-next"
+  XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
-- 
2.52.0

