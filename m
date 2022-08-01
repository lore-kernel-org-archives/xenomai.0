Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA829A2
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:49:39 +0000 (UTC)
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id A2B86D2E4F
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:48 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 4A5AE240011
	for <xenomai@lists.linux.dev>; Mon,  1 Aug 2022 13:47:40 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 089867803DE
	for <xenomai@xenomai.org>; Mon,  1 Aug 2022 13:47:40 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202208011347396f90afb8b1592c978f
        for <xenomai@xenomai.org>;
        Mon, 01 Aug 2022 15:47:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+kxqL7xBfq4Hd0Ch+TeXEDk0XLwNr3CnjCm6fbcZ6Ic=;
 b=RRGmcj65J/oWTVEo7zK9Ne0XG2OrLtwQZNUUoU5bsOeo95OB0pDU0scZbGQN5+XrsP3gnz
 3wSAGm8nlCFkQMz0++pUIsysMDFLdq2Ps5sa7pAzkrp/4fPDyf1BHWYtADTVTQdr1ZxUK3GN
 jrBRa5VIzpwCyR7vB9EM4jB8nS6iA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 2/4] ci: Make alternative DNS server configuration configurable
Date: Mon,  1 Aug 2022 15:47:35 +0200
Message-Id: <6da15653b4c08e86b80e61a0b5662897cea4d5cc.1659361657.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1659361657.git.jan.kiszka@siemens.com>
References: <cover.1659361657.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool4: domain of rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) client-ip=185.136.65.225; envelope-from=fm-294854-202208011347396f90afb8b1592c978f-rrbYTP@rts-flowmailer.siemens.com; helo=mta-65-225.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm2 header.b=RRGmcj65;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-202208011347396f90afb8b1592c978f-rrbYTP@rts-flowmailer.siemens.com designates 185.136.65.225 as permitted sender) smtp.mailfrom=fm-294854-202208011347396f90afb8b1592c978f-rrbYTP@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Private deployments may not need or may not even support the hack we
carry for AWS hostings.

Reported-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 7c65ca0..83bfe0b 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2020
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -22,13 +22,16 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
   LAVA_TESTS_ENABLED: "true"
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
+  ALT_DNS_SERVER: ""
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:2.6.3
 
 .common-config:
   before_script:
-    - sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
+    - if [ -n "$ALT_DNS_SERVER" ]; then
+          sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
+      fi
     - mkdir -p -m=700 ~/.ssh
     - if [ -n "$https_proxy" ]; then
           echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config;
-- 
2.35.3

