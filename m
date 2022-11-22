Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B554E17CA5
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:37 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 38A401BF204
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:30 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4A027D80D0C
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20221122222628ecce460ede39505049
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=jTONenTyp4vEJMG8N/hdU/o7kCjsn4ubNqktRnONgg4=;
 b=IaTFRHsj6qQO6uITHbK1Qep5tbwbXHCXbF9/62f6QUrN3S3z7AftrpK5QJxszGUrhQCwOz
 meUigMm9V9E/islTJ5ZSCagWJ7SzUo5l1VCZCcviSVpfP2Jo1N9FHk8aDpSHBwPlUuCRBOe+
 Q8/O8ZgLIwNzoFziHTBi54X68w0kw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 5/8] ci: Update latest kernels to v6.x
Date: Tue, 22 Nov 2022 23:26:23 +0100
Message-Id: <fbc0f62ba82da790df0fbcb58211ce90db18d52f.1669155986.git.jan.kiszka@siemens.com>
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
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) client-ip=185.136.64.225; envelope-from=fm-294854-20221122222628ecce460ede39505049-YOBBAj@rts-flowmailer.siemens.com; helo=mta-64-225.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=IaTFRHsj;
	dmarc=pass (policy=none) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20221122222628ecce460ede39505049-YOBBAj@rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) smtp.mailfrom=fm-294854-20221122222628ecce460ede39505049-YOBBAj@rts-flowmailer.siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

This also gives a chance to prepare the sorting rule for the transition
v6.9 -> v6.10. It was likely not even correct when it was once
introduced for ipipe rules.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 03d3382117..19775fb7c4 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -37,7 +37,7 @@ variables:
     - apt update
     - ARCH_PACKAGES="PACKAGES_${ARCH}"
     - apt install -y ${PACKAGES} ${!ARCH_PACKAGES}
-    - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
+    - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -k 1.4 | head -1)
     - test -n "${REV}" || REV="${PIPELINE_REV}"
     - test -n "${PIPELINE_KERNEL}" && echo "Checking out ${REV}..." && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
     - case "${ARCH}" in
@@ -179,11 +179,11 @@ variables:
     paths:
       - .ccache
 
-arm-5.xx-latest:
+arm-6.xx-latest:
   extends: .build
   variables:
     ARCH: arm
-    PIPELINE_REV: "v5\\.[0-9][0-9].*-dovetail-rebase"
+    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
@@ -203,11 +203,11 @@ arm-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
-arm64-5.xx-latest:
+arm64-6.xx-latest:
   extends: .build
   variables:
     ARCH: arm64
-    PIPELINE_REV: "v5\\.[0-9][0-9].*-dovetail-rebase"
+    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
@@ -227,11 +227,11 @@ arm64-5.10-head:
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: defconfig
 
-x86-5.xx-latest:
+x86-6.xx-latest:
   extends: .build
   variables:
     ARCH: x86
-    PIPELINE_REV: "v5\\.[0-9][0-9].*-dovetail-rebase"
+    PIPELINE_REV: "v6\\.[0-9].*-dovetail-rebase"
     PIPELINE_KERNEL: ${DOVETAIL_URL}
     KERNEL_DEFCONFIG: x86_64_defconfig
 
-- 
2.35.3

