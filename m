Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DF34A783
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450131; cv=none; b=Eu6EHktBF9hCLpH5u4vIWqhcNvK9GTzA40Owdq+XoL6YxidpATiNAiaL5O/b8ixBWI+kEavdQj6uP9dwO3pUa+quC6MCGyXTPBoNjnk3nsRtjMsHgbyIBeGSKIK9wOas6RwAH7dT9EWR1bfEgxcy8I6/2j92GLzUcw6lWI0/zkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450131; c=relaxed/simple;
	bh=ybqe8its2+Kw3bTTUZgxImc9FmLXHX/kzqvmhZd8ykQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn0c3flWIfTcVLevl0Ntlu0TUcrs+gaatVTSToTX9GPagAkf+l4nsY2/gXvABU/Jvi2AGFUAMvtk6bfd5Mc1QEGx9hHE/vrbAozslZqpzyPh9jl6gowBoqrAA0nYtlHIOmTj7VpQ1253VOGbBlkqPnrZpp6jqD3h08HgDe8dGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=TtofsJ6P; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="TtofsJ6P"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026012616145955f8475daa00020739
        for <xenomai@lists.linux.dev>;
        Mon, 26 Jan 2026 17:14:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yMYBGnXw14OjDRTjC174huguf9V4xlnnku7Qa68zJDA=;
 b=TtofsJ6PmKaA08SID4poHgOtQRl8spZm7HvgBaS4RHjRQqMKV9X7fSrJfXFuq2ftuMvwQX
 QM2YRhfOkv3wDELYT7m/OqD0bZXJlax++mrEq07fkYT7bN954gq4vBUYQ91Nqygm71thNwWR
 f/MPp9zXPfOHDEU7aV2cVS0X3rmtrJnhYqxZ/UsupBI1DFt8e55EBOqzynmX/6RIpGrNnSL5
 5rGpB7jcvEMk9CpF77Ls8AuD1jPJymoj0+CKYZcYcI6pPhUuhEYEvyc06DiaJCcLVavw8P+1
 nJeRI9qikn/VFxjfNg1Y1kT22I93smec3pNtUvCewftZ6lIwZh1Lknew==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 2/3] ci(xenomai-images): Add build job for dovetail head
Date: Mon, 26 Jan 2026 17:14:44 +0100
Message-ID: <20260126161445.349483-3-clara.kowalsky@siemens.com>
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

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 ci/dovetail_xenomai_3.yml |  5 ++-
 ci/kernel_head.yml        | 70 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 ci/kernel_head.yml

diff --git a/ci/dovetail_xenomai_3.yml b/ci/dovetail_xenomai_3.yml
index 3ba027f..1628af2 100644
--- a/ci/dovetail_xenomai_3.yml
+++ b/ci/dovetail_xenomai_3.yml
@@ -25,6 +25,9 @@ include:
   - local: '/ci/kernel_6_12.yml'
     rules:
       - if: '$KERNEL_VERSION == "6.12"'
+  - local: '/ci/kernel_head.yml'
+    rules:
+      - if: '$KERNEL_VERSION == "head"'
 
   # select xenomai config
   - local: '/ci/dovetail_xenomai_3_3_x.yml'
@@ -32,4 +35,4 @@ include:
       - if: '$KERNEL_VERSION == "5.10" || $KERNEL_VERSION == "5.15"'
   - local: '/ci/dovetail_xenomai_3_next.yml'
     rules:
-      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12"'
+      - if: '$KERNEL_VERSION == "6.1" || $KERNEL_VERSION == "6.12" || $KERNEL_VERSION == "head"'
diff --git a/ci/kernel_head.yml b/ci/kernel_head.yml
new file mode 100644
index 0000000..fa109a5
--- /dev/null
+++ b/ci/kernel_head.yml
@@ -0,0 +1,70 @@
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
+build-head:qemu-amd64:
+  extends: .build:qemu-amd64
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    CACHE_KERNEL: dovetail
+
+lava-test-head:qemu-amd64:
+  needs: [ "build-head:qemu-amd64" ]
+  extends: .lava-test:qemu-amd64
+
+build-head:qemu-armhf:
+  extends: .build:qemu-armhf
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    CACHE_KERNEL: dovetail
+
+lava-test-head:qemu-armhf:
+  needs: [ "build-head:qemu-armhf" ]
+  extends: .lava-test:qemu-armhf
+
+build-head:qemu-arm64:
+  extends: .build:qemu-arm64
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    CACHE_KERNEL: dovetail
+
+lava-test-head:qemu-arm64:
+  needs: [ "build-head:qemu-arm64" ]
+  extends: .lava-test:qemu-arm64
+
+build-head:hikey:
+  extends: .build:hikey
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    CACHE_KERNEL: dovetail
+
+lava-test-head:hikey:
+  needs: [ "build-head:hikey" ]
+  extends: .lava-test:hikey
+
+build-head:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    CACHE_KERNEL: dovetail
+
+lava-test-head:beagle-bone-black:
+  needs: [ "build-head:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+
+build-head:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    CACHE_KERNEL: dovetail
+
+lava-test-head:x86-64-efi:
+  needs: [ "build-head:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
-- 
2.52.0

