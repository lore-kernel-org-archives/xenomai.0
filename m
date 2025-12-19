Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB179218ACC
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766163123; cv=none; b=jXOhK8mbziWY/HPxgZ7tpkuobDZbySBIOSlLA+/X+DSBY4ESV64BPwz+GuMqz1gXxdWNVy19V41qLlju+4zGc3Uak640WOLl8Ywrw0NiCmOazvIoBRJ+l5RmucJMUH/hVPai7lUPteqlrRMUw1EDBX2NDweIZzdZxDMu8cUXAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766163123; c=relaxed/simple;
	bh=5Cn90f+nFiB5lmahDuQrUMyfVoA3c5B4UyPBhX6AbpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBPN2mNyGHIchGjuqml0w9b9W00vLXWDpruaW9+g5HBJgLildhJ9U1UJrrlS64jsFIjXx9lHwnFof5xGkGZGtBPQE/zjXN6nQhTD3ujmefMKEUO/bjLL03ZePDIbqxBWeuhQvSqrEoj0jZXFHUnCJQf6SYZa2SCmkVWkex/jKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=VpQE1Caz; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="VpQE1Caz"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202512191651557a83ae38eb00020734
        for <xenomai@lists.linux.dev>;
        Fri, 19 Dec 2025 17:51:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=xRXA379iRq4Vzqvqi28opa0abIpNiMM6IqTfZxg0+bQ=;
 b=VpQE1CazDfSO8IBT4W2sWui6ElnVEEHsnw4yR3Q/Jyu5MIk5GaC1ZmDVV4BZwTzifk/8Nr
 xGYcUdyedE+Kw2qyrWHhhcXo7cNgL0oRgUekzoaEEOV7caIZ3kQ5NV3jEFBkgPmCLpP8ClYE
 b47dJnHe+qQkEmHAtrh5etECx3a/ZWPcnRIBfjL5AWNdXcMHzzqTnkMdaEG+gLKxJM44dOPX
 DjqK7KU76AXfBIqB+D+O4Wi0LSAH754TrXvDMb/fv0Xi7RcM46mv35AAZ0l1xwo4XI2V19Ng
 zNA0oL/jbZh2rlgCrg4EAL41jVe/9yn4PqmWtzk91hx1zqw69pyJWo2A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 2/5] ci: Lift x86 compat tests to 6.1 kernel
Date: Fri, 19 Dec 2025 17:51:51 +0100
Message-ID: <4730a9b747ae02fbf5d7920ee63f99f31cd92c7d.1766163114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1766163114.git.jan.kiszka@siemens.com>
References: <cover.1766163114.git.jan.kiszka@siemens.com>
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

Kernel 5.15 moves out of scope for Xenomai 3 head, so we need to move
forward to the overlap between stable/3.2.x and head.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/compat_jobs.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
index ccbb15b..1fad3b3 100644
--- a/ci/compat_jobs.yml
+++ b/ci/compat_jobs.yml
@@ -9,22 +9,22 @@
 # SPDX-License-Identifier: MIT
 #
 
-build-5.15-compat:x86-64-efi:
+build-6.1-compat:x86-64-efi:
   extends:
     - .build:x86-64-efi
     - .compat-vars
   variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-5.15-head.yaml"
-    KERNEL_VERSION: "5.15"
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.1-head.yaml"
+    KERNEL_VERSION: "6.1"
     CACHE_KERNEL: dovetail
 
-lava-test-5.15-compat:x86-64-efi:
-  needs: [ "build-5.15-compat:x86-64-efi" ]
+lava-test-6.1-compat:x86-64-efi:
+  needs: [ "build-6.1-compat:x86-64-efi" ]
   extends:
     - .lava-test:x86-64-efi
     - .compat-vars
   variables:
-    KERNEL_VERSION: "5.15"
+    KERNEL_VERSION: "6.1"
 
 build-6.12-compat:rpi4:
   extends:
-- 
2.51.0

