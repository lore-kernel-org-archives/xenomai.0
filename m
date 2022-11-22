Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3117CA1
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:36 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 6EFE6240006
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 46E217803DB
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20221122222628bb3a22589a62128ba9
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=88Ef8SnRprZeZ4hr3LvLM6kKDgiSx2FMJ4ePTrVRsyM=;
 b=G+WPLS580CZ5JV6TESL5ZWCDbXnnhT/Puqkxm7iAiW3ccv1SGYlzMRWzqDtBzFXeb5MGHo
 q6qygHBto0Ays5e+gMDTt/ymC9FYsmJWNOxj7wB9g8GYnuYmYIeU7uO4b/OdCY2bVHuEH2jR
 0vf3zvvB4C/Tb1KfStfBwjLPBOwDY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 6/8] ci: Fold DOVETAIL_URL into PIPELINE_KERNEL
Date: Tue, 22 Nov 2022 23:26:24 +0100
Message-Id: <2e92c3ae2e22c481af4880ab3f7781836063cd37.1669155986.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1669155986.git.jan.kiszka@siemens.com>
References: <cover.1669155986.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool4: domain of rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) client-ip=185.136.65.226; envelope-from=fm-294854-20221122222628bb3a22589a62128ba9-IGoTK0@rts-flowmailer.siemens.com; helo=mta-65-226.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=G+WPLS58;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20221122222628bb3a22589a62128ba9-IGoTK0@rts-flowmailer.siemens.com designates 185.136.65.226 as permitted sender) smtp.mailfrom=fm-294854-20221122222628bb3a22589a62128ba9-IGoTK0@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoids having to set PIPELINE_KERNEL for every job while it is the same
for them all by now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 19775fb7c4..0dd68d7571 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,7 +20,7 @@ variables:
   KDIR: "/tmp/kernel"
   USE_CCACHE: "1"
   CCACHE_MAXSIZE: "1G"
-  DOVETAIL_URL: "https://source.denx.de/Xenomai/linux-dovetail.git"
+  PIPELINE_KERNEL: "https://source.denx.de/Xenomai/linux-dovetail.git"
   GCC_VERSION: "10"
   PACKAGES: "u-boot-tools git make bc bison libelf-dev autotools-dev \
              autoconf autogen libtool pkg-config ccache flex libssl-dev \
@@ -184,7 +184,6 @@ arm-6.xx-latest:
   variables:
     ARCH: arm
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-5.15-head:
@@ -192,7 +191,6 @@ arm-5.15-head:
   variables:
     ARCH: arm
     PIPELINE_REV: v5.15.y-dovetail-rebase
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm-5.10-head:
@@ -200,7 +198,6 @@ arm-5.10-head:
   variables:
     ARCH: arm
     PIPELINE_REV: v5.10.y-dovetail-rebase
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
 arm64-6.xx-latest:
@@ -208,7 +205,6 @@ arm64-6.xx-latest:
   variables:
     ARCH: arm64
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
 arm64-5.15-head:
@@ -216,7 +212,6 @@ arm64-5.15-head:
   variables:
     ARCH: arm64
     PIPELINE_REV: v5.15.y-dovetail-rebase
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
 arm64-5.10-head:
@@ -224,7 +219,6 @@ arm64-5.10-head:
   variables:
     ARCH: arm64
     PIPELINE_REV: v5.10.y-dovetail-rebase
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
 x86-6.xx-latest:
@@ -232,7 +226,6 @@ x86-6.xx-latest:
   variables:
     ARCH: x86
     PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-5.15-head:
@@ -240,7 +233,6 @@ x86-5.15-head:
   variables:
     ARCH: x86
     PIPELINE_REV: v5.15.y-dovetail-rebase
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 x86-5.10-head:
@@ -248,7 +240,6 @@ x86-5.10-head:
   variables:
     ARCH: x86
     PIPELINE_REV: v5.10.y-dovetail-rebase
-    PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: x86_64_defconfig
 
 i386-userland:
-- 
2.35.3

