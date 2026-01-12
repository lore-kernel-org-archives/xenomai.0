Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B925A334
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219760; cv=none; b=FhsRKwnMBFba1BAvTg24uj0NABF2EnJ1bKm5B/PmUQ76S6VuN1WY7nFc2wxwN/HU6NMwjQhLBEEE92jbuGMNJhzXHzi3MtmYmaecAvRBgT5oxgM3vOEuMhtEiHmV8dfKImSFKb2oHWgFvyUxF+X96jGVLgyq172AxXAbHlXAS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219760; c=relaxed/simple;
	bh=U+g/1HAZeHk/cREFyWsU6vW9AI6ckmxd9THtmoZCrjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbr5wH1GBhAKBiGvfG4XSMPpveMgSQRuMp0Du9T+KHfNk3LB0aNSMnh0T9Kr8S66Rn2usn+x2BorhmJ7t1EKcOmF9137faxkauAp2ZHBRPd7Oy2EJMuh4IAp7JgwPomtIrUhxDz32n8DerS59qGPvyjIRUyZOl4zS+l7+C7vfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=Vlq0Jr8N; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="Vlq0Jr8N"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026011212091199a5047e0b000207b1
        for <xenomai@lists.linux.dev>;
        Mon, 12 Jan 2026 13:09:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GySxMPgntBTjTQS/W49/83mHqY1zq9c4+QxGM4UfSMM=;
 b=Vlq0Jr8NC/WU8ZDmzBzaaUyeO+O+fghVAxyNMw1vNF1AKeLNhb1dpW4kA7092nJhEqX6BS
 Z0r4voZZHKZbcKDBfm29IWjuxeMN04D4jTV/tK9naneEgsyq+lgDyHGuXc4i4AZD07AMngnE
 NfahOeOzMxrMvgIxqleW4lkNMxW9QSu1Y0eEd6IsFxpksAE0ZPcy/CMnRXbQo1NhAl6+Pfbt
 TkdWBEiGFl4OVOvRXm9bU3Jp5ViP3Z2EnsGFYIMwUIf/tYxqbIAOA7tCEKdRlbZU0cheYcnX
 tnBP8S33yB4MTu5d102i0nV+6HYY/f6Ozp1bpdNmC6K8fPTKQ7+V2E8g==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 3/3] ci: Add CI for linux-dovetail
Date: Mon, 12 Jan 2026 13:08:56 +0100
Message-ID: <20260112120856.3912990-4-clara.kowalsky@siemens.com>
In-Reply-To: <20260112120856.3912990-1-clara.kowalsky@siemens.com>
References: <20260112120856.3912990-1-clara.kowalsky@siemens.com>
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
 ci/ci-dovetail.yml | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 ci/ci-dovetail.yml

diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
new file mode 100644
index 0000000..460fd19
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
+    project: xenomai-testing/xenomai-images
+    branch: ck/ci-dovetail
+    forward:
+      pipeline_variables: true
+  variables:
+    KERNEL_VERSION: $KERNEL_VERSION
+    KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
+    ONLY_RUN: xenomai-3/dovetail
-- 
2.52.0

