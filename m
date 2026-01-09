Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572B328B47
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968422; cv=none; b=giDDU0SREJ2S1DBk2pVWaRofAHPq9FRk8iRiJgoP7u7yOcUZYhQ12eQmCBOCGlo+n5jACJpBok9oHUXRl4t9PKnH7C0nJmh5zNewEJ6mpivx2aCeoBDGWkEwNAs0CGnBk3ybubzg7u4O3LU0m80mO9OB3idOmJw9QdlQDnxbiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968422; c=relaxed/simple;
	bh=AOUmZqYLjl9fGYe4Xfv8Rjna5uky9BdljYprRszH1Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtvxU/pW3wwRwr2Nk5I/uyXAjawMNVy6Cc5dBSRgYtlBTNlMZ6C+ARMGhaZz8R81Vz17+bnLKcBo4CcrvmYEeoSy83PHlTVieDLfezheCGCYg9/7HMh2pn9YRvg+csQ5fScs6/1Sq68YbYHn7nhsyTZ3mndkZ/RVU/Z3ituw8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=WO9ryMoh; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="WO9ryMoh"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260109142015940b13ff50000207fb
        for <xenomai@lists.linux.dev>;
        Fri, 09 Jan 2026 15:20:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=VX0YrkrXTv0LjKirBP0DAGb2OFDKj1n7B2PyvTmiqBU=;
 b=WO9ryMohDVYYTp+z55aTBc9Q3nfpg7SBh/U5GAQhofsfScFgHoWEcqe/Rb+iwnMoKkXPUs
 1sYioZTSeRJOvbMnztIgqM7C6ajdFwBZuyTRrCNd3piNkp2uUsHznvqVSwPK4CBqCFWCF1+K
 nwglUe+0PSpqEo5L1eCaPMO1unHpSiLHpUPXeSzaFJyQYtdVld9f8S/Nj3BGUJ+gcxrPf1y6
 gf+FWINjlD6ucK9ts6TLdgrbnFHn8waso3Z4G93gbyta71vD7VmoFYS/lWabzVLGmRqXuSzl
 ixHcZv46MTFxN9bTQUR35XSIXjRh/8DNAvfjYZOGRMY/fFbZEb199O7Q==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 1/2] ci: Add build job for pipeline triggered by linux-dovetail
Date: Fri,  9 Jan 2026 15:20:00 +0100
Message-ID: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
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
 .gitlab-ci.yml            |  8 ++++++
 ci/xenomai_3_dovetail.yml | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 ci/xenomai_3_dovetail.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2f03fdd..c8f649f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -59,6 +59,14 @@ xenomai-3/next-long-term:
   rules:
     - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
 
+xenomai-3/dovetail:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_dovetail.yml'
+  rules:
+    - if: '$ONLY_RUN == $CI_JOB_NAME'
+
 xenomai-4/next:
   extends: .parent
   trigger:
diff --git a/ci/xenomai_3_dovetail.yml b/ci/xenomai_3_dovetail.yml
new file mode 100644
index 0000000..e54cafd
--- /dev/null
+++ b/ci/xenomai_3_dovetail.yml
@@ -0,0 +1,51 @@
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
+  - local: '/ci/kernel_6_1.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.1"'
+  - local: '/ci/kernel_6_12.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.12"'
+  - local: '/ci/kernel_5_10.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "5.10"'
+  - local: '/ci/kernel_5_15.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "5.15"'
+  - local: '/ci/kernel_4_19.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "4.19"'
+
+.xenomai-3-next:
+  variables:
+    XENOMAI_VERSION: "3-next"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml:kas/opt/debug.yaml"
+    LATEST_KERNEL_VERSION: "6.12"
+  rules:
+    - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12"'
+
+.xenomai-3-3:
+  variables:
+    XENOMAI_VERSION: "3.3.x"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.3.x-head.yaml:kas/opt/debug.yaml"
+    LATEST_KERNEL_VERSION: "6.12"
+  rules:
+    - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
+
+.xenomai-3-2:
+  variables:
+    XENOMAI_VERSION: "3.2.x"
+    XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-3.2.x-head.yaml:kas/opt/debug.yaml"
+  rules:
+    - '$KERNEL_VERSION == "4.19"'
-- 
2.52.0

