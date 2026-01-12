Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5EC2D94A2
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221258; cv=none; b=mHAHfzuekTZdgx53sgCO3LKTcT9wRH1cZSttLE4VnVKIK9NjLYbB/blpFdY/bzBlcIebwUI5Hjroo+/SqRb+ofbN4qJJEWWEoK7pII6rWEkhUw8jMAjdCU3s7O04oWrpcbyTo9wgELkty5+gRD/K/09bKVRCx0vDYgHldrDss7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221258; c=relaxed/simple;
	bh=FRVvUpAnHd+q/BRckYg6P66P+nCO9dXbrX09RCj47hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiK75IvH3LvUWUB5Rxq8bSjyzrzl9n2Ou2RYovTAUw9TSiul13emfp2zCMwFQNW9yI5GgpRT3oqL++UFWF35LE2/0ZGNnAvjVnhJLcIlLAdgPq5JyyzOUi0QggyGVa/ECNfpIXlQaijBLv/4bZB6AhpkSVyl3YoaKL5SJEQOxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=diIkUdAN; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="diIkUdAN"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026011212341388efdbdb4c00020731
        for <xenomai@lists.linux.dev>;
        Mon, 12 Jan 2026 13:34:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fvuVbSsoHTHmR+jMEGR3jQn/46Qi7qXy1U56WZYJyfs=;
 b=diIkUdANEaQlxkeeX2C/DLK1yHCrb34OifG2AIAh4SJ+nnp6PLoEYEjr5Lc7fORURgGNjS
 0dE9odgGhGU3l03qxnJcuxUdPHtkXbp8qnyTDjX6TP5lSp63Yw/x38gI9to3Ar/BkyPuhr1N
 b+l3fnQhu40jcAiC4z99AyC55OTeMwvaYo2JKuYv1ugb4zhFR1w7zeItm2Y/SgsHKtfIx4/o
 fpgJ0LZvxKC+zaEK4ub/8W0Lcm2XfoDq1gpCoa5UkLTjqATTQKTnTzyh5LBmdoV/SaXqLS9D
 u038FQAeS2IwNFWxJOMRIvzgc6yf0K7c8yjs+ELACfDB35BIBuYuKjbA==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v3 3/3] ci: Add CI for linux-dovetail
Date: Mon, 12 Jan 2026 13:33:49 +0100
Message-ID: <20260112123349.3945734-4-clara.kowalsky@siemens.com>
In-Reply-To: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The linux-dovetail repo is configured in the CI/CD settings to use as
configuration file this file in xenomai-images.
This adds a CI job for triggering the xenomai-images CI if new commits
are pushed to a supported dovetail branch. By default the
build jobs on the physical targets are started for the corresponding dovetail
version.
By setting KERNEL_VERSION_WITH_QEMU to the dovetail version that
triggered the CI, the QEMU build jobs are also always run.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/ci-dovetail.yml | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 ci/ci-dovetail.yml

diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
new file mode 100644
index 0000000..c326c97
--- /dev/null
+++ b/ci/ci-dovetail.yml
@@ -0,0 +1,47 @@
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
+# This is the CI/CD configuration file of the linux-dovetail repository,
+# as configured in its CI/CD settings
+#
+
+stages:
+  - set_vars
+  - trigger_xenomai_images
+
+default:
+  image: debian:trixie-slim
+
+set-vars:
+  stage: set_vars
+  script:
+    - |
+      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
+      echo "KERNEL_VERSION: $KERNEL_VERSION"
+      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
+  artifacts:
+    reports:
+      dotenv: vars.env
+  rules:
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$/'
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
+    ONLY_RUN: xenomai-3/dovetail
-- 
2.52.0

