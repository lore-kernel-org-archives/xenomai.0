Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678836B066
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304411; cv=none; b=DEab3SR8F0inti9jZ+37Fa2THYCZ5ZhLFMAy9PjhTUFpu1n+kXsm/yhOCqDo9fJwctdD6IdOp0Ba/fPZMjudtDjY5tnpDL6beq7bx8U+8Umy5QeKoDJwA4hEu4nw50YH4bCjOdzut3j6zE5d1w8bbiT67lv7jL2v1u3rMqY7w9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304411; c=relaxed/simple;
	bh=KyIcvmSeuv+G9D46k/UIF2r0wpiqP0a6Dh/2ds/9Xe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtkfjQJAaft00LCBPE/rAxKwcdEeYYGknP9idQLOfX/Mc4AJOJlbfdaFY88VSL9eh4SegrarAXavcsDOFQlC+pSXIxLvnhe7/j6DfrIfS35PVR3M1FZhraTfItEH7hD8KcNW7soUulQLezU6nSU+NzYkBNH2wFebYXPxh7Ntz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=F4AlUhM9; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="F4AlUhM9"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260113114000b5899d7db800020730
        for <xenomai@lists.linux.dev>;
        Tue, 13 Jan 2026 12:40:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YrmBX8w/h4+xvcNjS69EBtUSQD0KtZkYg5E+6XYCaqs=;
 b=F4AlUhM9bkF4WwyJ+8PxkDjLDynSmhnfUSmBSN0K+SxYUj4+3NME3i/ilaLqhWxLCnbRXV
 op9rg2V7QTO1fIw0vg2fyd3dhdNOwkTLWZdT76oXz7DEwTTJYXZIxK1tkhE2laSMpcqB3zMM
 d5hNHVlI7bVgAj9FrlVf/vWRCQaZGl/VpzugocU5byPPTuzs8RxjCGmNkuTAEP4ChzdTbzMt
 XNShjBRdp8MzxbKqpdV1BqPq16Vp4n/B/NA1vKlgalDk8Th5h3Z7bCJ7thfiX6YDsY9emFKI
 6PhfUtmf8yfSaoiPJCovV+2ilJGUp3HgfXfjucmcfpbeMx+AcZKAYthg==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v4 3/3] ci: Add CI for linux-dovetail
Date: Tue, 13 Jan 2026 12:39:44 +0100
Message-ID: <20260113113945.1038227-4-clara.kowalsky@siemens.com>
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

The linux-dovetail repo is configured in the CI/CD settings to use as
configuration file this file in xenomai-images.
This adds a CI job for triggering the xenomai-images CI if new commits
are pushed to a supported dovetail branch. This starts by default the
build jobs on the physical targets for the corresponding dovetail
version.
By setting KERNEL_VERSION_WITH_QEMU to the dovetail version that
triggered the CI, the QEMU build jobs are also always run.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/ci-dovetail.yml | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 ci/ci-dovetail.yml

diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
new file mode 100644
index 0000000..0792898
--- /dev/null
+++ b/ci/ci-dovetail.yml
@@ -0,0 +1,49 @@
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
+set-vars:
+  stage: set_vars
+  tags:
+   - lava
+  image: debian:trixie-slim
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
+  rules:
+    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$/'
-- 
2.52.0

