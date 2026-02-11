Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB6214813
	for <xenomai@lists.linux.dev>; Wed, 11 Feb 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815466; cv=none; b=SDy5NnTmA7+tiwkW+xgTxJVGtw38oZ1PzCM+D9axCYIfkvD423PAkiZzGFvMoSeUs7wk+GoDFp6/qK2sAYmPkWAYvptUzxM0RRfWeV8/j+JkKPueRTw8Fr/yQ96XMdVYN79QQUPUx4FiTLyH6GXUxt7nUsY/pORp55QVqUXlhr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815466; c=relaxed/simple;
	bh=Qj7VqnAMWOgL4c4eC+mV7QF5m20zWCjD1Oc+CDMBfqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEqaQR42A2XpH/TSxX7D/536DJt8TySsY4r9ukPfpsjqjB0OvJd5A04mMpP+MOQDjJdun/55pTjAVglciKwlDes5MVH09oNCPBcY75iiBKc0OCpU9Sllvb1EFJF1d76JxsdPO65PB2+/QeY5119mQwfzExZ5z2Swslt3wHZkaUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=M1aAz2R0; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="M1aAz2R0"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026021113110261c7086f21000207b4
        for <xenomai@lists.linux.dev>;
        Wed, 11 Feb 2026 14:11:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SK9ewYZvHvyVL+6o1OryCBTruaA0o+z7bVldO90tsvc=;
 b=M1aAz2R0zYs1Ut8+Uy9XUUzEBzTRjJG2jEzqVTJfZ0QPMwBZG1l0vzotReMy64sFzuPlE5
 MMGAW6Z42X0Z6Oy/M0TZL8CUQTcMYbCF/GgAO3APN2nJ5lFacLJbALR0I0eSDhNy10DPZagc
 Z1XU7NOpG+jH2NtJDo5PlqDR0esB6aoh0fKJZ7EaBOtaD+NRizBqODEALtWhiy6m80TQ1VuM
 +j1eMKAC+LSxJ/91fU8ehLNzQgIy03tQw+XeZzWTC7GdWTLAa7F/cH6tAHxkEYaIgQ+Hfhc7
 3uOlGiTVzX020Om2OQZTsPZLAgxhSvJs5QV77ERruE0GHZABjMwJOemA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 5/5] ci: Add CI for linux-evl
Date: Wed, 11 Feb 2026 14:10:42 +0100
Message-ID: <20260211131043.1185863-6-clara.kowalsky@siemens.com>
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

The linux-evl repo uses this CI/CD configuration file, as configured in
its settings. If new commits are pushed to a supported linux-evl branch
(that would be kernel version 6.1, 6.12 and head at the moment), a CI
job is started that triggers the xenomai-images CI in combination with
the libevl next branch. Build jobs on the physical targets as well as in
QEMU are run.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 README.md          | 10 ++++++++
 ci/trigger/evl.yml | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 ci/trigger/evl.yml

diff --git a/README.md b/README.md
index e6535be..7e6ebeb 100644
--- a/README.md
+++ b/README.md
@@ -81,6 +81,16 @@ on the `next` branch trigger a pipeline in this repository. The GitLab CI/CD
 configuration file for libevl is located in this repository under [ci/trigger/libevl.yml](ci/trigger/libevl.yml),
 as specified in the libevl settings via `ci/trigger/libevl.yml@Xenomai/xenomai-images:next`.
 
+#### Linux-evl
+
+For the [linux-evl](https://gitlab.com/Xenomai/xenomai4/linux-evl) repository,
+pushes to branches that have a corresponding kernel file in [`ci`](ci) trigger
+a pipeline in this repository. The GitLab CI configuration for linux-evl is
+located in this repository under [ci/trigger/evl.yml](ci/trigger/evl.yml), as specified
+in the libevl settings via
+`ci/trigger/evl.yml@Xenomai/xenomai-images:next`. In the triggered pipeline,
+images for the corresponding linux-evl branch are built and tested.
+
 ### Local CI Execution
 
 The CI build can be executed locally by
diff --git a/ci/trigger/evl.yml b/ci/trigger/evl.yml
new file mode 100644
index 0000000..fdbd15d
--- /dev/null
+++ b/ci/trigger/evl.yml
@@ -0,0 +1,63 @@
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
+# This is the CI/CD configuration file of the linux-evl repository,
+# as configured in its CI/CD settings
+#
+
+workflow:
+  rules:
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-evl-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-evl-rebase$/'
+
+stages:
+  - set_vars
+  - trigger_xenomai_images
+
+set-vars:
+  stage: set_vars
+  tags:
+   - small
+  image: debian:trixie-slim
+  script:
+    - |
+      apt update -y && apt install git -y
+
+      KERNEL_VERSION=""
+      if [[ "$CI_COMMIT_BRANCH" =~ ^v(6\.(1|12))(\.y)?(-cip)?-evl-rebase$ ]]; then
+          KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?(-cip)?-evl-rebase$/\1/p')
+      elif [ "$CI_COMMIT_BRANCH" = \
+        "$(git ls-remote --tags --head --refs https://gitlab.com/Xenomai/xenomai4/linux-evl.git | \
+        sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | \
+        grep "v6\.[0-9].*-evl-rebase" | \
+        sort -r -n -k 1.4 | head -1)" ]; then
+          KERNEL_VERSION="head"
+      fi
+      echo "KERNEL_VERSION: $KERNEL_VERSION"
+      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
+  artifacts:
+    reports:
+      dotenv: vars.env
+
+trigger-xenomai-images:
+  stage: trigger_xenomai_images
+  needs:
+    - set-vars
+  trigger:
+    project: xenomai/xenomai-images
+    branch: next
+    forward:
+      pipeline_variables: true
+  variables:
+    KERNEL_VERSION: $KERNEL_VERSION
+    KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
+    ONLY_RUN: xenomai-4/evl
+  rules:
+    - if: '$KERNEL_VERSION != ""'
-- 
2.52.0

