Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72417CA3
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:37 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id A8C5E1C0008
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8492B941E83
	for <xenomai@xenomai.org>; Tue, 22 Nov 2022 22:26:29 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20221122222628156750b6a08cec7ad3
        for <xenomai@xenomai.org>;
        Tue, 22 Nov 2022 23:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Oxz2oce2ECrXJ4vYuyGSbOU37LQCLyqlBt5qPnVAy90=;
 b=NN5BmZuozzgkjR+FkTZcXY7EruQcobH7/NP5MkyKSbSHV9++ZgqlDJEjgx7J1B/ncIEKvJ
 J2Z47j2tpghepVcoSOwjPcG+dXZNeDqzAF5g5oKxw+eOkARjO3B4QOCCntBnQSr6qa3xzu0M
 FfLeu5YyelWQkfs/vENkLXfn1SICw=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 7/8] ci: Exclude master branch from builds
Date: Tue, 22 Nov 2022 23:26:25 +0100
Message-Id: <45861a0475bf7ecf6709ae8313009e71f3451d49.1669155986.git.jan.kiszka@siemens.com>
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
Received-SPF: pass (spool1: domain of rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) client-ip=185.136.64.225; envelope-from=fm-294854-20221122222628156750b6a08cec7ad3-TP2vro@rts-flowmailer.siemens.com; helo=mta-64-225.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=NN5BmZuo;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20221122222628156750b6a08cec7ad3-TP2vro@rts-flowmailer.siemens.com designates 185.136.64.225 as permitted sender) smtp.mailfrom=fm-294854-20221122222628156750b6a08cec7ad3-TP2vro@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

According to our workflow, it was always already tested via 'next'.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0dd68d7571..2b62f1a736 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -33,6 +33,8 @@ variables:
 
 .build:
   stage: build
+  rules:
+    - if: $CI_COMMIT_BRANCH != "master"
   before_script:
     - apt update
     - ARCH_PACKAGES="PACKAGES_${ARCH}"
@@ -65,7 +67,6 @@ variables:
     - ln -s /usr/lib/ccache/${CROSS_COMPILE}gcc-${GCC_VERSION} /usr/lib/ccache/${CROSS_COMPILE}gcc
     - export PATH=/usr/lib/ccache:$PATH
     - ${CROSS_COMPILE}gcc --version
-
   script:
     - export CCACHE_DIR=$(pwd)/.ccache
     - pushd ${KDIR}
-- 
2.35.3

