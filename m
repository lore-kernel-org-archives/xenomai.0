Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA637BE7F
	for <xenomai@lists.linux.dev>; Mon,  9 Feb 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648239; cv=none; b=laRCWrzHJ5fYKDbJxdm9FrukD3uz3OQxEvZEcx1WTxgJyTTS7pQNA6Z0HjCauPtpnmlAWmTP/Bh/fLYYZs19nVSROjgTx9oTry/d8Z4P/E3CB1j5JXYZeR72Zv85icFbxPHKFlwzmTv7nfSjZWEvz81JrjZ8UpPmGb+/d6nxgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648239; c=relaxed/simple;
	bh=rUdZhuhi6WeFFu1gUEWjRASDxi+jKkAmXUhO3n00zZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKB9YfFp8aJCkyDS9LuG+AVQccOdjIm8pOzsJeUpGtGrZT4jss2/UmjRRbIL5K5n6rMUd82ORSrUu1jTXLTCIPossUYHQteoKpYmdDPvDkiUCQ1oHHzgQw0HFgBUr07u/RXBRDPZblMaaSG3RCgw0zDA6dl26yCkZQ4Rtp5cIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=IgBR0rj6; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="IgBR0rj6"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260209144358e16c5c9c2d00020736
        for <xenomai@lists.linux.dev>;
        Mon, 09 Feb 2026 15:43:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fajnJh9aBCuWqFfFTda6KkfHQKjc0zrBMtrws2B/KzM=;
 b=IgBR0rj6dINAaw9r4L66t+sJtXToI8hf1yALe5TKU7dl6XNguuDMNvBDPSA6fJ5FmbwpDo
 dwI8VA/UXu7aoNL/cCFOm+bKJS72gTUOq//jv+zwfAfp+SBPa1FyaWc8Ky+sZpa+O9PXTRKE
 emV9fr4Cxz7ViIQ2BGjMbUXdtv1l0Kr36M0uehGH5vaGpIkQnIiaA4iMAIkEzjaAMrM8ZPZI
 UEctqq8d6adyvCchQHd3DfR2ZQhRwC2SzUXR3VHlkIAbiUeYwq7b5fdDFkXlFQQOltx3lfJe
 4fODVvUev0a5sn+plQgL86XR+jWh0MkMMzLhTdeQXxaszX6muXDYH+Ag==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [[xenomai-images]PATCH 3/4] ci: Add CI for linux-evl
Date: Mon,  9 Feb 2026 15:43:45 +0100
Message-ID: <20260209144346.487179-4-clara.kowalsky@siemens.com>
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

The linux-evl repo uses this CI/CD configuration file, as configured in
its settings. If new commits are pushed to a supported linux-evl branch
(that would be kernel version 6.1, 6.12 and head at the moment), a CI
job is started that triggers the xenomai-images CI in combination with
the libevl next branch. Build jobs on the physical targets as well as in
QEMU are run.
Since we have branches in linux-evl that meet the rule
$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-evl-rebase$/
but are not head (e.g., v6.6.y-evl-rebase), and GitLab rules are only
evaluated once at job creation, a dummy job is triggered in that case,
instead of the xenomai-images CI. This makes sure that the CI does not
fail with the error "The resulting pipeline would have been empty".

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/ci-child.yml | 27 ++++++++++++++++++
 ci/ci-evl.yml   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 ci/ci-child.yml
 create mode 100644 ci/ci-evl.yml

diff --git a/ci/ci-child.yml b/ci/ci-child.yml
new file mode 100644
index 0000000..6871b5d
--- /dev/null
+++ b/ci/ci-child.yml
@@ -0,0 +1,27 @@
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
+# This is used by the CI of linux-evl
+#
+
+stages:
+  - trigger_xenomai_images
+
+trigger-xenomai-images:
+  stage: trigger_xenomai_images
+  trigger:
+    project: xenomai/xenomai-images
+    branch: next
+    forward:
+      pipeline_variables: true
+  variables:
+    KERNEL_VERSION: $KERNEL_VERSION
+    KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
+    ONLY_RUN: $ONLY_RUN
diff --git a/ci/ci-evl.yml b/ci/ci-evl.yml
new file mode 100644
index 0000000..f436d0b
--- /dev/null
+++ b/ci/ci-evl.yml
@@ -0,0 +1,74 @@
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
+# This is the CI/CD configuration file of linux-evl, as configured in
+# its CI/CD settings
+#
+
+workflow:
+  rules:
+    - if: '$CI_COMMIT_BRANCH =~ /^v(6\.(1|12))(\.y)?(-cip)?-evl-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-evl-rebase$/'
+
+stages:
+  - set_vars
+  - trigger_child
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
+      if [ "$KERNEL_VERSION" != "" ]; then
+          git clone --depth 1 --branch next https://gitlab.com/Xenomai/xenomai-images.git /tmp/xenomai-images
+          cp /tmp/xenomai-images/ci/ci-child.yml .
+      else
+          cat <<EOF > ci-child.yml
+          stages:
+            - dummy_stage
+          dummy_job:
+            stage: dummy_stage
+            script:
+              - echo "This is a dummy job."
+      EOF
+      fi
+  artifacts:
+    paths:
+      - vars.env
+      - ci-child.yml
+    reports:
+      dotenv: vars.env
+
+trigger-child-pipeline:
+  stage: trigger_child
+  trigger:
+    include:
+      - artifact: ci-child.yml
+        job: set-vars
+    strategy: depend
+  variables:
+    KERNEL_VERSION: $KERNEL_VERSION
+    ONLY_RUN: xenomai-4/evl
-- 
2.52.0

