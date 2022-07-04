Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B646AA
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:09:09 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 8587AC9F3E
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 1FFB64001D
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:38 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E7440D8106A
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2022070413083762d6cdd90b713e6c72
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zOMkeg4KAbgXC4MhXq+tMxsS77O6QaEBf7He8JXUo7w=;
 b=UKLZVas/tI+KaWasUniPVZ982Eq4VK8SGvd+tKPuDYwP5L9OxPLLhcjHrDfCXlNtHlp5MX
 snrzAsSeD/Ue6G0Ty3vIyq7qxbXYwu/QDqBowoWAjgUqx3nechEudFPavfhmfbg2nAAMOVzC
 n2kyIs5bRI4sRiO1Qb86avoXvYXzc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 15/15] ci: Add targets for latest dovetail queue
Date: Mon,  4 Jul 2022 15:08:35 +0200
Message-Id: <c66601680f06e6235966b704764c77be22d8c1c2.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) client-ip=185.136.64.228; envelope-from=fm-294854-2022070413083762d6cdd90b713e6c72-8j0Yti@rts-flowmailer.siemens.com; helo=mta-64-228.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b="UKLZVas/";
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-2022070413083762d6cdd90b713e6c72-8j0Yti@rts-flowmailer.siemens.com designates 185.136.64.228 as permitted sender) smtp.mailfrom=fm-294854-2022070413083762d6cdd90b713e6c72-8j0Yti@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

This tests the latest v5.xx[.y]-dovetail-rebase queue in addition to the
5.10 and 5.19 variants. Should help to find build compatibility issues
earlier.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 224e2ef619..2d4c7635cb 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -39,7 +39,7 @@ variables:
     - apt install -y ${PACKAGES} ${!ARCH_PACKAGES}
     - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
     - test -n "${REV}" || REV="${PIPELINE_REV}"
-    - test -n "${PIPELINE_KERNEL}" && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
+    - test -n "${PIPELINE_KERNEL}" && echo "Checking out ${REV}..." && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
     - case "${ARCH}" in
       "arm64")
       export CROSS_COMPILE=aarch64-linux-gnu-;
@@ -178,6 +178,14 @@ variables:
     paths:
       - .ccache
 
+arm-5.xx-latest:
+  extends: .build
+  variables:
+    ARCH: arm
+    PIPELINE_REV: "v5\\.[0-9][0-9].*-dovetail-rebase"
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: multi_v7_defconfig
+
 arm-5.15-head:
   extends: .build
   variables:
@@ -194,6 +202,14 @@ arm-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
+arm64-5.xx-latest:
+  extends: .build
+  variables:
+    ARCH: arm64
+    PIPELINE_REV: "v5\\.[0-9][0-9].*-dovetail-rebase"
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: defconfig
+
 arm64-5.15-head:
   extends: .build
   variables:
@@ -210,6 +226,14 @@ arm64-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
+x86-5.xx-latest:
+  extends: .build
+  variables:
+    ARCH: x86
+    PIPELINE_REV: "v5\\.[0-9][0-9].*-dovetail-rebase"
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: x86_64_defconfig
+
 x86-5.15-head:
   extends: .build
   variables:
-- 
2.35.3

