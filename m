Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AE328B47
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968431; cv=none; b=soYELadbLpZ414DovksK5rPhWpKy/cJbrarbMWUQl+WiP2uCiqyZ4DPDPRs3Hd3Ut2IF+KUiVYwZS+f6xcSfO1HwxqwaTIVuDzxmUjHqdXi2fJ39jy+UOKdimrafXNAPj7KmC6ZZAf17xfjBzc/bEGPhqOTyiGWZLGfgdOZLOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968431; c=relaxed/simple;
	bh=hT7RvtWda+E6dciv/13q/2hA+UT87sqv5R0LWhwuTF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHBindmXq9kfDxuW4E4tX8LGUnBOCB7WvdWx03PFYLFMLuS2cYZ0kJidwKfFx4x9RrgCRQaVG5Bdg5XC1NbMhDWK/AKmuZYjhalHORubNrSCbV/xAwW83BUfY/xgDy52pS8LcGLACLkC0HIEm26l1/a0lgUhAq9PAQ/nEVycAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=GKyWBrcQ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="GKyWBrcQ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202601091420208ac41e5fbc00020706
        for <xenomai@lists.linux.dev>;
        Fri, 09 Jan 2026 15:20:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5vQyb2Uq7jY9x9J9y50A72CjD1AizJzyKwawFug5420=;
 b=GKyWBrcQjn1yp4nPXi5y3iAR9QW1WxdPVcMiYRZg5QqUBWsYI0V38W4m35RXOdgkmbH+Cf
 n8unPRTX2Xl3Q+tJpKv0XhZ7DmK9/NssmIBenZUIFbitMkedgKhyzzA/QTVm9G7aFG6+ol6P
 tji4/xT616KL+JlEOtFnti3A9Ab27XRO3MCKVnqlEDRbnZ7koRrnsaejmgBxpZXEvp64uO45
 MkIqqm8lCFACrFr715SJKOTI7BILjdDQvT29j0xfei1GHWBGGeuQQwH5lREoYWdGrAPu3xkr
 G3bg8cZFcualqAZpWqwPOCAoKwDnsnMmkNrHDZogNsqTx2a6KD9I5T/Q==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
Date: Fri,  9 Jan 2026 15:20:01 +0100
Message-ID: <20260109142001.2548128-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
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
are pushed to a supported dovetail branch.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/ci-dovetail.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 ci/ci-dovetail.yml

diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
new file mode 100644
index 0000000..52685e6
--- /dev/null
+++ b/ci/ci-dovetail.yml
@@ -0,0 +1,43 @@
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
+stages:
+  - set_vars
+  - trigger_xenomai_images
+
+default:
+  image: debian:bookworm
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
+    - if: '$CI_COMMIT_BRANCH =~ /^v(6\.(1|12)|5\.(10|15)|4\.19)(\.y)?-dovetail-rebase$/'
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
+    ONLY_RUN: xenomai-3/dovetail
-- 
2.52.0

