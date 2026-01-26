Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC082F5461
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444113; cv=none; b=F/v1fZvtJGCLY6bYaJ7bnOWxWBQHHyW+Q1t+jMXoc72UuLjbym/zPENkv7w8f2C8BawrBwq39mXiH9/zunUFmaRtTHujD1Bvb5VCfjRGA98OWDyxxD7sfLk5SdSqFOkwp5cv3so+GMByvDl+myS759WcU7fbvQC0OfmEkiDNQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444113; c=relaxed/simple;
	bh=tT+mtZY4EoeKEnePSgT/sA7N54Qhl2ULooKuVL8D0Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwijQuXSR6tdDPlJJYhB8tZeuzsm2jKvZjMSO5zu4mpbXuNEz8EvPYwHwkjfdKXCDVpWYgvGBVRtVUenGyfQaLMuF21Vdzh7pQr+4c9j2/mKwE9zRgGmpgu01EhQX+29V5NNRx+usXKzixgZnlFfKXf1WSzcbK5z4ezqxJQE/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=FWMV9EGN; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="FWMV9EGN"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260126161502bf8a3583750002079d
        for <xenomai@lists.linux.dev>;
        Mon, 26 Jan 2026 17:15:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eKmqpWzRdrmZsZ2zGPZ/O9Pw5f2j/4KkKS4igqz/ayc=;
 b=FWMV9EGNOqwoiEzYqcfs5iIDNN0a+i6ZR5FW+tkREyC565QGmZoC8UfqrtJyntx5l2YN6k
 gZPYM7kMF4wHH6II0jSamVZyoENfIpeLXrtL/RSmja9c1N5RGbmCuTiJiDItHHJooZEuSDbF
 SdINvVNThOe2RBvIeIyk0jMxEuWPSQX8m2y84KG7JOIDK585QRQiQRZPTtLccXp7td4I+ph3
 zx9sDaOSIei/82TSzO4c7Wvaslp5p6R1e+5InNsbn42e4f48lQbXtH9VQOCy0aETEzvTlCRM
 gT01bhWfuF+BoH9aSuFv60XNn91jNECYWn0rbL+VKcc5BdlsGnavzl9g==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 3/3] ci(dovetail): Trigger xenomai-images CI for dovetail head
Date: Mon, 26 Jan 2026 17:14:45 +0100
Message-ID: <20260126161445.349483-4-clara.kowalsky@siemens.com>
In-Reply-To: <20260126161445.349483-1-clara.kowalsky@siemens.com>
References: <20260126161445.349483-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

For checking which of the v6.*.y(-cip)-dovetail-rebase branches is the
current head, the same procedure is used as in
recipes-kernel/linux/linux-xenomai-3_latest.bb.
Only if the job set-vars sets the KERNEL_VERSION, the job
trigger-xenomai-images is executed and the corresponding pipeline in
xenomai-images is started.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/ci-dovetail.yml | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
index 77fa02b..b3a95ff 100644
--- a/ci/ci-dovetail.yml
+++ b/ci/ci-dovetail.yml
@@ -15,6 +15,7 @@
 workflow:
   rules:
     - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$/'
+    - if: '$CI_COMMIT_BRANCH =~ /^v6\.[0-9]+\.y(-cip)?-dovetail-rebase$/'
 
 stages:
   - set_vars
@@ -27,7 +28,18 @@ set-vars:
   image: debian:trixie-slim
   script:
     - |
-      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?(-cip)?-dovetail-rebase$/\1/p' || echo "unknown")
+      apt update -y && apt install git -y
+
+      KERNEL_VERSION=""
+      if [[ "$CI_COMMIT_BRANCH" =~ ^v(5\.(10|15)|6\.(1|12))(\.y)?(-cip)?-dovetail-rebase$ ]]; then
+          KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?(-cip)?-dovetail-rebase$/\1/p')
+      elif [ "$CI_COMMIT_BRANCH" = \
+        "$(git ls-remote --tags --head --refs https://gitlab.com/xenomai/linux-dovetail.git | \
+        sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | \
+        grep -E "^v6\.[0-9]+\.y(-cip)?-dovetail-rebase$" | \
+        sort -r -V | head -1)" ]; then
+          KERNEL_VERSION="head"
+      fi
       echo "KERNEL_VERSION: $KERNEL_VERSION"
       { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
   artifacts:
@@ -47,3 +59,5 @@ trigger-xenomai-images:
     KERNEL_VERSION: $KERNEL_VERSION
     KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-3/dovetail
+  rules:
+    - if: '$KERNEL_VERSION != ""'
-- 
2.52.0

