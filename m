Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854C357A5D
	for <xenomai@lists.linux.dev>; Wed, 11 Feb 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815467; cv=none; b=GaCi5Ww9moNeor/q5VFM1neGngI7mxP+YzPHiamboTZZBDxr9Vr71gJT6fgM3gf+arYnS2kcZ7lrfPgXE35sRY+J7/dYXDshWLG3RM7mdfBf3UvCEhSwY15iYqcfe4D19zMrr1vRvqAAOKWcIOgArVgmtdgpVjrzyrsTW4VRqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815467; c=relaxed/simple;
	bh=P+UdVxQqebgS5KgzrJq/tKadZi+WLjjnXMOVEDFA/Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jpe1eUpAmzn8Tn7rt1YVDTOmptu/M6J7TkFqeRe1wnvwr/KxMd7VBPUBkufC0UVxur5as+HTegRsdB1M5u72OxBfJ0ssmecwC3Tumz+N6O0Y/axtLFH6zyf1cppG2GiOCXNC0Yr5Nu3bI7HkjdAYEM383alSEtUmrcU04+HqnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=UrAEMXH3; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="UrAEMXH3"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260211131058c474f8a1b60002079c
        for <xenomai@lists.linux.dev>;
        Wed, 11 Feb 2026 14:10:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qLzKwyXAvhJgwGnAfHJ0VZv4Cw2QB5+LAIYmDk8LvLw=;
 b=UrAEMXH3u6ZHg+I6PZwrGqL167+6hUQvPCaY1pKUTamJTriDa3lKF7BieqLPm1mK96aIlf
 QeiFJdc5oy6EQaeuYPCo5kDHXN9AwiA+xxhTMnc6Xiw0B5KZI4vezXr03rvS/pN2rsrWNuIJ
 YGUhuPO+iSkaLsZyfvs3WXFwUmYd/JHtNmkvnLo1iQKZJFBqEya8FTw/Y+aJi8janm+46Ft0
 F3xugEQ+7wEfqcZHyQcbut31Eb3NErtMVhpK00GzVYDmEqNnUNcUbu3YB7YiJ+eO4O+Qrwrl
 qG6+6NVqq6FRgDv9ilfq5va/8chDk2ltiS0ZW36s20l2ly+92kZzLDXg==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH v2 3/5] ci: Add build job for pipeline triggered by libevl or linux-evl
Date: Wed, 11 Feb 2026 14:10:40 +0100
Message-ID: <20260211131043.1185863-4-clara.kowalsky@siemens.com>
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

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .gitlab-ci.yml       |  8 ++++++++
 ci/xenomai_4_evl.yml | 29 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 ci/xenomai_4_evl.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c8f649f..f810dd7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -73,6 +73,14 @@ xenomai-4/next:
     include:
       - local: '/ci/xenomai_4_next.yml'
 
+xenomai-4/evl:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_4_evl.yml'
+  rules:
+    - if: '$ONLY_RUN == $CI_JOB_NAME'
+
 lavacli-container:
   image: quay.io/buildah/stable:v1.41.4
   stage: build
diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
new file mode 100644
index 0000000..0404ca3
--- /dev/null
+++ b/ci/xenomai_4_evl.yml
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
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/6_1.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.1"'
+  - local: '/ci/lib/kernel/6_12.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "6.12"'
+  - local: '/ci/lib/kernel/head.yml'
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

