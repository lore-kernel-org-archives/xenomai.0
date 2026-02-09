Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3544378D84
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648237; cv=none; b=C5/DAym4iPL3TqvWv224qpQzaQDagh9XmEBdD+DDEycJAs4An330r9PMSzLIJMphRuAUMtdP5uSBQz/XwymARoG8guByim7G5lqKElKUDBeeMCEFBhd7mCgjv8HbCiUsGzZGT8z1JZBiz0q1hLgNtcrqhR85iGZY2mSMvlvPxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648237; c=relaxed/simple;
	bh=dZOVhkyaQD9hL7yrMSqnXzxvdDbvBMqTM/4TxOwzeHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myQ/5QmXEcY2VT7peX/bXqwmd0oiUZnNFLnHz3ORaDCYpoi2X0Ki5WfE5pnt4392p5gFZwc2XBPhn6M+QHS3ncY694+5C3L1VjC96DCdSyXbcjKx91n5+zTx6GTwymZjy5aPHhvppeJoVLQiG82dAoDVdGUyzkuHBLczzwxNvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=JzOHtPfn; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="JzOHtPfn"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202602091443547b4e46cd670002079f
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 15:43:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vzHx4NuZndYgbscCMgLOOW4bA9pUXQTrnrjNktHK1Lg=;
 b=JzOHtPfnqL2F6gZFBUb6NYY5t3qAIuppQchQtXkQgc7b4GfClAah1kaVQ76d73JCP5PgJy
 /07yZ/50YqjBycrdvvyUThnQYaQSY2GfCw7bv5POhNPcFV3n63UrNcdPZ+xPJriBxRcTxM91
 bZqWMCAtWIK2BabQDCxYVdZ5dYUshujq1MUcrVvV1ozUT+BUCVN2cI/TQ+DVA2s7lYTf5CzR
 3ybLk6cuS9c+REdcYmM02tUaf5GzFF41sxWYpKUMvq0il//1CBladRq/z7oi4MyVL1dz53Lx
 aNgHYvLGaj85t7rXAnSqqrSxCS7uAjG7PzeMdZBeaCH/V2YHIpO/BSNQ==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 1/4] ci(xenomai-images): Add build job for pipeline triggered by libevl or linux-evl
Date: Mon,  9 Feb 2026 15:43:43 +0100
Message-ID: <20260209144346.487179-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260209144346.487179-1-clara.kowalsky@siemens.com>
References: <20260209144346.487179-1-clara.kowalsky@siemens.com>
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
 .gitlab-ci.yml       |  8 ++++++++
 ci/evl_xenomai_4.yml | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 ci/evl_xenomai_4.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 19d7ddd..955e6a6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -73,6 +73,14 @@ xenomai-4/next:
     include:
       - local: '/ci/xenomai_4_next.yml'
 
+xenomai-4/evl:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/evl_xenomai_4.yml'
+  rules:
+    - if: '$ONLY_RUN == $CI_JOB_NAME'
+
 lavacli-container:
   image: quay.io/buildah/stable:v1.41.4
   stage: build
diff --git a/ci/evl_xenomai_4.yml b/ci/evl_xenomai_4.yml
new file mode 100644
index 0000000..ea58f0d
--- /dev/null
+++ b/ci/evl_xenomai_4.yml
@@ -0,0 +1,29 @@
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
+  - local: '/ci/kernel_head.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "head"'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
+  XENOMAI_VERSION: "4-next"
+  BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
+  CACHE_KERNEL: evl
+  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
-- 
2.52.0

