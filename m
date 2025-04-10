Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C405204697
	for <xenomai@lists.linux.dev>; Thu, 10 Apr 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295207; cv=none; b=ddpfPOk7K+yv1QobiGcuJAxNz3tc6HtHFtE84SlCRYAoWFFvULCb5g1VpoSX6Oi/oAVPeZvIuutqsj7nkRXt8o8l/GvLBk36CZ+hqtciJI81Tkcf+65USJW23IuIOs68ABjeERBhBYJ5EnL+ZBePjh3Fezu9ODCUiE8e8hu/kMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295207; c=relaxed/simple;
	bh=FAeb2qonlZ1qVpEkio8LSce1SKnzqGI7Id3HPt5x3FE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhcmIdcaRoiqjgQg5TBcfRfkgvMmj2PKhrSraA09hPPxn2oKHwKCQGcZdp8YMCL/HSs+FuvoPal1sUXYMUW4C0ofjYDChOh2kRk1Bnc9iQQxU6fx1Rt3X57pih93sZbW5+ZZWOOJ+P5QenKId8B05OCHyIbK6g+KnMDit8I/9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=UyWFdY26; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="UyWFdY26"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250410141631a0cf65a8e5e49dcd5f
        for <xenomai@lists.linux.dev>;
        Thu, 10 Apr 2025 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ICtiKBPJC5ychek3EmXC2pMZgbs9KSOUFMu5K22/Lew=;
 b=UyWFdY26ZBqCfEYmrf9dw+2Mg+7TVUkeSA2Msd4I3jxnWEtcVJv5r4LGZon9nGTLD0ubdK
 8WL/Lj63JIO8mZP/UutS82nvrovXDfmGg+P2nH0iMi8WiSJfserd8mte7h4HiKrSXRhMO7iV
 ZczKVsNWMYz8a7D2MBd6EDkQDAETyEcLIoEvdPgjQnC/dFnKrwGY6wjrlEFZnmV2KAzOCE4w
 US0H6ww8V9SqSxLq+TvQj1fI0X5M8Myc6zdq4v2VaZMCrJuLm/IpQwKgBk3mPA4wZLjUeXNU
 uGi2u3nG+m/pQSh9kZ3Hg/6we8OQzfBmv4BCX927S4ARLcLFWmAHlh6w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/7] ci: Add coverage for stable/v3.3.x branch
Date: Thu, 10 Apr 2025 16:16:25 +0200
Message-ID: <a9baee76f5c9280b6a97b40b08e86c4e0bcfdcd4.1744294590.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1744294590.git.jan.kiszka@siemens.com>
References: <cover.1744294590.git.jan.kiszka@siemens.com>
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

At this stage, we just copy the targets from next. They will likely be
reduced over the time.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml              |  8 +++++++-
 ci/xenomai_3_3_x.yml        | 23 +++++++++++++++++++++++
 ci/xenomai_3_3_x_compat.yml | 18 ++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 ci/xenomai_3_3_x.yml
 create mode 100644 ci/xenomai_3_3_x_compat.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6f9bcd6..7a6c6a9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2024
+# Copyright (c) Siemens AG, 2019 - 2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -46,6 +46,12 @@ stable/v3.2.x:
     include:
       - local: '/ci/xenomai_3_2_x.yml'
 
+stable/v3.3.x:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_3_x.yml'
+
 xenomai-3/next:
   extends: .parent
   trigger:
diff --git a/ci/xenomai_3_3_x.yml b/ci/xenomai_3_3_x.yml
new file mode 100644
index 0000000..a8dfa29
--- /dev/null
+++ b/ci/xenomai_3_3_x.yml
@@ -0,0 +1,23 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019-2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_5_10.yml'
+  - local: '/ci/kernel_5_15.yml'
+  - local: '/ci/kernel_6_1.yml'
+  - local: '/ci/kernel_6_12.yml'
+  - local: '/ci/xenomai_3_next_compat.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x.yml:opt-debug.yml"
+  XENOMAI_VERSION: "3.3.x"
+  LATEST_KERNEL_VERSION: "6.12"
diff --git a/ci/xenomai_3_3_x_compat.yml b/ci/xenomai_3_3_x_compat.yml
new file mode 100644
index 0000000..5f64fed
--- /dev/null
+++ b/ci/xenomai_3_3_x_compat.yml
@@ -0,0 +1,18 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+.compat-vars:
+  variables:
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.3.x.yml:opt-debug.yml:opt-compat.yml"
+    XENOMAI_VERSION: "3_3_x-compat"
+
+include:
+  - local: '/ci/compat_jobs.yml'
-- 
2.43.0

