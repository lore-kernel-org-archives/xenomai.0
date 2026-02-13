Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FAD257459
	for <xenomai@lists.linux.dev>; Fri, 13 Feb 2026 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975376; cv=none; b=S0+OwzZB7XKSBHBX4WtHN2quGHqFN33jIAUpqtr+LXKKr2A2mvzLfu41KHbvkK+8IsEc6s4sdmURz4s9zN+MPxWp4mHtdLO9pCw2VwWepzl9DNOC8mD0lP3hXh7Qs4J/VB9RwPOGNWhzcPdhSDCzpzg7VCr1VlIkwR/9f4MyV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975376; c=relaxed/simple;
	bh=LWGYgkIQRA642M/5p+h5V2G+xz74MiQVKXVMGQ4fuFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvlWyYL6ZPM5e0Ur8cueIPGnRrFTuw+Aa4P5B1wGjP5L/XY0tZTQe42RLdbJDQrnLnZm7xuMPWmRRs0WzeFlJjHBppErkUahlh5YebAUM0q8UgWIPiLxehi/GtlvhlpkrXw6Hf8rJ1+O+3q/28pW2cpsSjSJwmdDpF5Sz9UjlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=acPyKwxH; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="acPyKwxH"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026021309360369bbdbd5ef00020727
        for <xenomai@lists.linux.dev>;
        Fri, 13 Feb 2026 10:36:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=G60vusucgtS4W8C2e3XyO3SXoBiRbZbj/fBcREKZlkU=;
 b=acPyKwxHjcHHdaRoYE7h6h1NXXnP0yOy1tSxhUY5P+UCyao5MI0LHgES5qLp2BEaj127QX
 xYwsab8wrLP8vLdaqadwoYJzxCgrMU9tGO9fBdIXvy9cIRndyYiRIrD0OJZlHbQxXzx74kwG
 yul9UXgj2OsasAP91mwEoFBjBMXQ/JxQqGCWkBnArriLx2OkJFFWt3Ir2/gXIp3aXG0csAd5
 9cjzspna/84JQnc+LD+06r4KKpCQjt3cV5cpxJCfYRMZPdHVSPHqHPH8BXX7a/xfDemXKlZW
 3SQpmnHvApQeUQgND1WUBzVojjOv7dB/v3X6qWTLxVfjnjdI6tjN8XOw==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH] ci(libevl): Trigger more kernel combinations
Date: Fri, 13 Feb 2026 10:35:30 +0100
Message-ID: <20260213093530.2513546-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

The libevl next branch triggers a pipeline in xenomai-images in
combination with all available kernels (6.1, 6.12 and head). The
physical targets are built for all kernels, the QEMU targets just for
the head.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/trigger/libevl.yml | 2 +-
 ci/xenomai_4_evl.yml  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
index bbd4e13..f9228dd 100644
--- a/ci/trigger/libevl.yml
+++ b/ci/trigger/libevl.yml
@@ -19,8 +19,8 @@ trigger-xenomai-images:
   stage: trigger_xenomai_images
   variables:
     ONLY_RUN: xenomai-4/evl
-    KERNEL_VERSION: head
     KERNEL_VERSION_WITH_QEMU: head
+    KERNEL_ALL: "true"
   trigger:
     project: xenomai/xenomai-images
     branch: next
diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
index 0404ca3..abc1e56 100644
--- a/ci/xenomai_4_evl.yml
+++ b/ci/xenomai_4_evl.yml
@@ -13,13 +13,13 @@ include:
   - local: '/ci/lib/gitlab-ci-base.yml'
   - local: '/ci/lib/kernel/6_1.yml'
     rules:
-      - if: '$KERNEL_VERSION == "6.1"'
+      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_ALL == "true"'
   - local: '/ci/lib/kernel/6_12.yml'
     rules:
-      - if: '$KERNEL_VERSION == "6.12"'
+      - if: '$KERNEL_VERSION == "6.12" || $KERNEL_ALL == "true"'
   - local: '/ci/lib/kernel/head.yml'
     rules:
-      - if: '$KERNEL_VERSION == "head"'
+      - if: '$KERNEL_VERSION == "head" || $KERNEL_ALL == "true"'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml:kas/opt/debug.yaml"
-- 
2.52.0

