Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D547484
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="lmlZigIJ"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2024011004460475a69d3c54aa26cc4d
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 05:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=EA5nZhgMQJNkHkokwvmd2FYOaLESRNCd3VTOZVWhxSI=;
 b=lmlZigIJayC5FfBXoP/E2JhmtHzbuhc4bWdFvPWwRx0Pepqbd9Hp6+F4SSm5i4luK/ULC+
 imYpDXCA52FBnmij96gFb5nCKGJnR6GshHm4fv1MtYv1dGrqUs4Ol26p5Q/2ZtqV6p63CKSC
 ohTdpOpiZFtzLYck1UivkEvdpp9ic=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH v3 10/10] ci: Prepare for xenomai-4 test cases
Date: Wed, 10 Jan 2024 05:46:02 +0100
Message-Id: <fb47426561014256662091891eeded9722f21350.1704861962.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Clara Kowalsky <clara.kowalsky@siemens.com>

Test cases are prepared for the linux-evl kernel v6.1 and v6.6. We don't
add them yet as there is no equivalent to xeno-test in libevl.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
[Jan: drop unused ci files, enable qemu targets, do not hook-up yet]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/xenomai_4_next.yml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 ci/xenomai_4_next.yml

diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
new file mode 100644
index 0000000..226c72f
--- /dev/null
+++ b/ci/xenomai_4_next.yml
@@ -0,0 +1,21 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2023-2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_6_1.yml'
+  - local: '/ci/kernel_6_6.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-libevl-next.yml"
+  XENOMAI_VERSION: "next"
+  LATEST_KERNEL_VERSION: "6.6"
+  BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
-- 
2.35.3

