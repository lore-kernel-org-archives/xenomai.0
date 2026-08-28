Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA3364059
	for <xenomai@lists.linux.dev>; Fri, 28 Aug 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931309; cv=none; b=pXwHbnvkcncEIB83yrQ4+feM2WIpLCvOLlTKqydUGnYBLe7fJasIKI4ozjy95ByYQ4OmBsBjSz3fZGMY2/r3hARReipGxxzrbfKW5bC5a25Eejq7cl147e6/ginLQUBvJr85+LK7oIw/qCymSIBeY1aEP47Nv4S88eWg0XIiHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931309; c=relaxed/simple;
	bh=e/Z0D9dEDg4w8wAf0XlklM2edf2QmkP5s5Zpnk1jQ7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEDGXijdBo+E18DEXfRs5lDPEL5ACv7j2lWPJ69qmurvPdSgwf6Vb5t97htCNEYGZQm2ADDsAMd2aMktlFefD1zF9ojSXaKR62GioxnnR0jjmxG3Z0q04F1aqgvDRWH7ORXry9kfzAVJDXXCBP72AO3lMtcZF/3ZFwF3cUyaZuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=KM612seM; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="KM612seM"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026082815345702c76da7690002077d
        for <xenomai@lists.linux.dev>;
        Fri, 28 Aug 2026 17:34:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=wh38Gz1CzgsOJ5cabFDLzLhk4LbOfR79/8R0fpjD1SE=;
 b=KM612seMAatMdCiIUcod/Yg704cu3XBKc8VkWhKG2U0RhrskBj9dvytjNT2YfdztK3ILrd
 vJdRmhmIikzEL1wAmruA7b6+RxnoKNLGCML5A4EJSLZIpYhqPCmxYJhUMsGT0QcHaGS38hvh
 v8+RjHblasiVBpqhprbRAPJPCNGW0XAjf7HjpGne9enlLF8oql0ACH885TyHL146Imv9XDTy
 QTi7PwEmXnTQWQRFQx2GG2quplvVqlhw5OpMba7oKeEna7Fw1xRxO9GZWl+e+yQj8CbPnD0Z
 lN1Y6ohqtS3IQh58LebaltODS456kkb9T6WHRokHXrP6juNaHuUE0Zcg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [xenomai-images][PATCH 5/5] Switch to rootless builds
Date: Fri, 28 Aug 2026 17:34:56 +0200
Message-ID: <eb82698af1ef62819a085c92941857a592f40d7c.1787931296.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787931296.git.jan.kiszka@siemens.com>
References: <cover.1787931296.git.jan.kiszka@siemens.com>
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

This removes the need to add a user to the docker group if podman is
used.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig   | 10 +++++++++-
 README.md |  4 +++-
 kas.yaml  |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Kconfig b/Kconfig
index 5337d37..b574c8c 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,3 +1,11 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2021-2026
+#
+# SPDX-License-Identifier: MIT
+#
+
 mainmenu "Xenomai Reference Images"
 
 config KAS_INCLUDE_MAIN
@@ -6,7 +14,7 @@ config KAS_INCLUDE_MAIN
 
 config KAS_BUILD_SYSTEM
 	string
-	default "isar-privileged"
+	default "isar-rootless"
 
 config ARCH_X86
 	bool
diff --git a/README.md b/README.md
index 7e6ebeb..cfa7906 100644
--- a/README.md
+++ b/README.md
@@ -11,7 +11,9 @@ from scratch.
 
 ## Building Target Images
 
-Install Docker and make sure you have the required permissions to start containers.
+Install Podman (recommended) or Docker. If using Docker, see
+[kas documentation](https://kas.readthedocs.io/en/latest/userguide/kas-container.html)
+for more details.
 
 Next, invoke the configuration menu to select the desired image configuration
 and start the build:
diff --git a/kas.yaml b/kas.yaml
index cc5202a..bd4ecc2 100644
--- a/kas.yaml
+++ b/kas.yaml
@@ -12,7 +12,7 @@
 header:
   version: 14
 
-build_system: isar-privileged
+build_system: isar-rootless
 
 distro: xenomai-demo
 target: demo-image
-- 
2.47.3

