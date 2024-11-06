Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC41DED70
	for <xenomai@lists.linux.dev>; Wed,  6 Nov 2024 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893077; cv=none; b=GyNdyUFZKTuJLrNZnbWQ3uEtDwBBoet6zhc1+FTnpVH0rY9ZZoVjh9sxF4Kazj5KciAUTG14JxVWzimEJozFZ75apS0aoCDt3cT0tT3EClOQpm9ZPTsb6gxOCnnR0TGNmNwrdbl+F9Xlk2rKlvl9cVlysC2dsvCezGAVL2bT6X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893077; c=relaxed/simple;
	bh=NP0JaQepZ3OIZslHRkHCHrUppn/qwgwzw56Ui8RSjp8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF2ivg292OFIQTERaFNaamz14auvbJP3uOMEzHeKsIHKWSWHqTDOL01Is+oTAJUgM+yBsU0I1/2/LviGuKVI97311gweCg1ZsMaMtjmr7eKP9DM1HrudocJlP32+/NQwrU27sN5M63Hpr9vYGqagzBqafZFxuxDuv86zKwnd0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=fLRmxogd; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="fLRmxogd"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20241106112741788b0351c021f250e8
        for <xenomai@lists.linux.dev>;
        Wed, 06 Nov 2024 12:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kpT00mwuypiE3c/2du5UHrW8yHACUQ2OTMXKHIkEowA=;
 b=fLRmxogdpAt1U3Ne0ES1fFp9X8eRvZPe6pcmcG+U7anU10ilg5rC6JOQq2xBRrQeM9nt5/
 9tSWRrSn9hYa3VNI4l0esdsy4tMK6MAzvkluTjXynVQ+28mSlISLbDiZRf7+8KT4JZfgmu8D
 6YU+q491MC3cy+xy3Rp9LUBscVAboqhwNxdGILpu56+5lJzRzcy7arSiYwFjdBDF516+h9BA
 qtn1xnoV9Y645GUxuxRbnnwraZmXeQMwpisGQZfCQUEG9bHk+EJJ+1T8G42vstOy93kaxhrS
 Gnq4PrEt6LfMQa6DuC/9O78NtItsjnPjV0641WJRSp3b3hLYqakrv0OA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 3/3] Enable compat support for arm64
Date: Wed,  6 Nov 2024 12:27:40 +0100
Message-ID: <932c6283011567b9a7eb95af0a0166fca0a02303.1730892460.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1730892460.git.jan.kiszka@siemens.com>
References: <cover.1730892460.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Latest isar now supports this. Add a 6.6-based CI job on the RPi4 for
testing it regularly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig            |  2 +-
 ci/compat_jobs.yml | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 2336e66..26aa63e 100644
--- a/Kconfig
+++ b/Kconfig
@@ -211,7 +211,7 @@ config KAS_INCLUDE_DEBUG
 
 config COMPAT
 	bool "Build 32 bit Xenomai userspace"
-	depends on (XENOMAI_LATEST || XENOMAI_3_3) && ARCH_X86
+	depends on (XENOMAI_LATEST || XENOMAI_3_3) && (ARCH_X86 || ARCH_ARM64)
 
 config KAS_INCLUDE_COMPAT
 	string
diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
index 93cae2f..3e2d377 100644
--- a/ci/compat_jobs.yml
+++ b/ci/compat_jobs.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2024
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -25,3 +25,24 @@ lava-test-5.15-compat:x86-64-efi:
     - .compat-vars
   variables:
     KERNEL_VERSION: "5.15"
+
+build-6.6-compat:rpi4:
+  extends:
+    - .build:rpi4
+    - .compat-vars
+  rules:
+    - if: '$XENOMAI_VERSION != "3_2_x-compat"'
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
+    KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.6-compat:rpi4:
+  needs: [ "build-6.6-compat:rpi4" ]
+  extends:
+    - .lava-test:rpi4
+    - .compat-vars
+  rules:
+    - if: '$XENOMAI_VERSION != "3_2_x-compat"'
+  variables:
+    KERNEL_VERSION: "6.6"
-- 
2.43.0

