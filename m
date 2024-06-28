Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9F146A85
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577295; cv=none; b=nTCEtqVNgq30lZfVe38kZLn9YllEnhTAACdnQUvBdYflqMvul0VmX3Qzi3oW3HzGwutnImC9tpnV0UQ2hxx2+1tE0yaaJ1JG8/WP7k4/MHsriAPDU9kurcMH+hnZJBo8SIhGi7byW9VqFd4KMnBkS+TOka6wa+oLBYZ9CrT/SEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577295; c=relaxed/simple;
	bh=dyhYngvFYYpfDJ9/Xq6P03bdODiK+w/etKCg5CEtRu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfUW0lkRlXmGajR6kPioDHN4wZcPRe7PSXE36XCrDFPdp89rANgiq8NESWDNGVBMJqhtYLfqL4gK1RtITjwx70BU3/ff2HYpleR3D7VJuNrz7pHBrLtHcNOzeaoaf3/F4eTCFllke6E1OynBWPblZPQC77tJlnlIZ2mQgJ783h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=NZwSAq6F; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="NZwSAq6F"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202406281221236313a1f6867932ae02
        for <xenomai@lists.linux.dev>;
        Fri, 28 Jun 2024 14:21:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/EoTkG+qW4Ai8gf1+mAd7iEPqXGrHBQqfBhLItDZpLs=;
 b=NZwSAq6Fwnb+KiXoB/nvaSKQqhnwipDAgX9yqFtFaK/6SAM2YplKFfmrVjFpjgNvYW6ICa
 loltUDtGdw4EhP6t8kqGMzDaPz6GP3kCW6t1YN4HC90HpMIKp8wNikT1T0t4A/aVbyy2gYy+
 DyEZzIQHauty9gekUZkwkpqUjv3YQ=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH 4/4] ci: add test job configurations for rpi4
Date: Fri, 28 Jun 2024 14:21:17 +0200
Message-Id: <20240628122117.19059-5-yi.jiang@siemens.com>
In-Reply-To: <20240628122117.19059-1-yi.jiang@siemens.com>
References: <20240628122117.19059-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
---
 tests/jobs/xenomai-rpi4.yml | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 tests/jobs/xenomai-rpi4.yml

diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
new file mode 100644
index 0000000..4416a64
--- /dev/null
+++ b/tests/jobs/xenomai-rpi4.yml
@@ -0,0 +1,72 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Yi Jiang <yi.jiang@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+job_name: xenomai-test-suite
+device_type: bcm2711-rpi-4-b
+
+timeouts:
+  job:
+    minutes: 90
+  action:
+    minutes: 65
+  connection:
+    minutes: 5
+priority: medium
+visibility: public
+
+metadata:
+  docs-source: xenomai-rpi4b
+  docs-filename: pipeline-xenomai-rpi4b
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 30
+    to: tftp
+    kernel:
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
+      type: image
+    dtb:
+      url: ${DEPLOY_URL}/bcm2711-rpi-4-b.dtb
+    nfsrootfs:
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
+      compression: gz
+#  BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 5
+    method: u-boot
+    commands: nfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    timeout:
+      minutes: 30
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
-- 
2.39.2

