Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047963816E0
	for <xenomai@lists.linux.dev>; Wed, 14 Jan 2026 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384641; cv=none; b=QDvmuBh++UNDylZ5vphahNoQfqEx5pU2R/HcGsHe5AF8guvl1U+JTiJ/LgRZTSptOkhrjYnsnCJaF0NLNahdsUFZbUw4K+vhD7eCVzw+K4tzY+4HbZg2s3Eb1u7C+VEvHGS2cO6jkG6c+xg1bQE1/qIIvWYAZhqXIbe3I7evCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384641; c=relaxed/simple;
	bh=mFtRrytknuAPL5Nci50CsqJCYT3MawT/kkxGPtni/Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcZVSthx2Oiwofu1uCSYaiWOnWlthBrg0Us5ZeR7tvJ68M+w52l1dgl7aXb+mmQi749m736DFoDENJD7d4/2mp03Xb8WEbhz9ZYWap9hO3WIQFR7BJD2IZAlQMegJc6lEEmJWKCfkhdGxTYUaMhgaKND35k0NI+YbtGWEEF4iMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=ZWfQivHr; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="ZWfQivHr"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202601140957093da146f1a3000207c3
        for <xenomai@lists.linux.dev>;
        Wed, 14 Jan 2026 10:57:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=h2aaniQTaHJB3MOeyXgnG3YtLVH+tCFr20hv8161rDc=;
 b=ZWfQivHrdh5D55BOcBK20XLOxtT1FjlBGZvb19b9utrkuCktcVBa72RzUok9HA2y8q3kEZ
 5xT2jZiokRH7kNSRLhzDDRL+EWiiR4xzz0Xq2tQpEKkHCBaia5Gjmdo4Cu9jHJ0Swh1j1dBd
 Q0X5UTMwL8dtCe3/y7MJx2Q33IjLSjNpOZxjMs+tqWElqBkZebD9r6nxV0QQSyci/t18tMNu
 fDB1dW4WsholuZk/F5rmNHCpeHWua9mVoIzpRF/QwvHwC3Vrs1FTRbMGyMD1FzzaptktfUjp
 J7+1hYrhPb64by/xoE5tYayV7tEaWMRSBcSAMwkNPxC8SZqa5YrZAsyQ==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [xenomai-images][PATCH 1/3] README: make minor changes and fix typos
Date: Wed, 14 Jan 2026 10:56:55 +0100
Message-ID: <20260114095657.2440127-1-clara.kowalsky@siemens.com>
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
 README.md | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/README.md b/README.md
index 00c0c8b..95350cc 100644
--- a/README.md
+++ b/README.md
@@ -1,6 +1,6 @@
 # Xenomai Demonstration and Test Images
 
-This generates a number of bootable image for virtual and real targets in order
+This generates a number of bootable images for virtual and real targets in order
 to run the [Xenomai](https://www.xenomai.org) real-time system, for evaluation
 or testing purposes. The layer may also be used to build real applications on
 top.
@@ -11,18 +11,18 @@ from scratch.
 
 ## Building Target Images
 
-Install docker and make sure you have required permissions to start containers.
+Install Docker and make sure you have the required permissions to start containers.
 
-Next invoke the configuration menu to select the desired image configuration
+Next, invoke the configuration menu to select the desired image configuration
 and start the build:
 
     ./kas-container menu
 
 If you built, e.g., a QEMU AMD64 image, this can be run using
-`start-qemu.sh x86`.
+`./start-qemu.sh x86`.
 
-You can also select the desired image configuration on the command line.  To
-build the QEMU AMD64 target with debug options enabled, invoke kas-container
+You can also select the desired image configuration on the command line. To
+build the QEMU AMD64 target with debug options enabled, invoke `kas-container`
 like this:
 
     ./kas-container build kas.yaml:kas/board/qemu-amd64.yaml:kas/opt/debug.yaml
@@ -30,11 +30,11 @@ like this:
 ### Physical Targets
 
 This repository contains recipes for x86 (`kas/board/x86-64-efi.yaml`),
-armhf(`kas/board/beagle-bone-black.yaml`) and arm64(`kas/board/hikey.yaml`)
+armhf (`kas/board/beagle-bone-black.yaml`) and arm64 (`kas/board/hikey.yaml`)
 targets.
 
 Each physical target will generate ready-to-boot images under
-`build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run
+`build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run:
 
     dd if=build/tmp/deploy/images/hikey/demo-image-xenomai-demo-hikey.wic \
        of=/dev/<medium-device> bs=1M status=progress
@@ -43,16 +43,16 @@ Each physical target will generate ready-to-boot images under
 
 To generate an SDK corresponding to the selected target image, append
 `-c populate_sdk` to the build command. The SDK tarball can be found next to
-the image, e.g. as
+the image, e.g., as
 `build/tmp/deploy/images/hikey/demo-image-sdk-xenomai-demo-hikey.tar.xz`.
 Unpack it and follow its `README.sdk`.
 
 ## CI Build
 
 The CI build can be executed locally by
-[installing the gitlab-runner](https://docs.gitlab.com/runner/install/).
+[installing the GitLab Runner](https://docs.gitlab.com/runner/install/).
 
-To execute the CI build use:
+To execute the CI build, use:
 ```
 gitlab-runner exec docker --docker-privileged \
   --env "HTTP_PROXY=$HTTP_PROXY" --env "HTTPS_PROXY=$HTTPS_PROXY" \
@@ -61,15 +61,17 @@ gitlab-runner exec docker --docker-privileged \
 
 ## LAVA Lab
 
+See [tests/README.md](tests/README.md).
+
 The [Xenomai project](https://www.xenomai.org/) maintains a
 [LAVA lab](https://lava.xenomai.org) for integration testing.
 
 A LAVA lab can be created by following the
 [installation instructions](https://docs.lavasoftware.org/lava/first-installation.html)
-or use
-[lava docker](https://github.com/kernelci/lava-docker) for a faster setup.
+or by using
+[lava-docker](https://github.com/BayLibre/lava-docker) for a faster setup.
 
-It is also possible to connect a lab to lava.xenomai.org. Please get in
+It is also possible to connect a lab to [lava.xenomai.org](https://lava.xenomai.org/). Please get in
 touch with the maintainers via mailing list to join a new lab with
 lava.xenomai.org.
 
@@ -79,7 +81,7 @@ See [Xenomai project](https://www.xenomai.org/).
 
 Contributions are always welcome. They follow the same
 [process](https://gitlab.com/Xenomai/xenomai3/xenomai/blob/master/CONTRIBUTING.md)
-that Xenomai is using as well. Please tag you patches additional with
+that Xenomai is using as well. Please tag your patches additionally with
 "[xenomai-images]" to indicate which repository they are targeting.
 
 ## License
-- 
2.52.0

