Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D558368E90
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="qWvwtuqB"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20231205152204e9637093ef91713e45
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 16:22:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gGYkWXHPYeQud5NXIyOSQYWA89EaHiMDMUo1NDucUHk=;
 b=qWvwtuqBggE0F9p8cGeujGz1xhw8LdxOFO4pb8LETs3mKb7xNXBBm0XmUGxNvhtqKtFEC/
 KdGKY0B/bVJhFfyAiPLrCt0/NvfkulrHasoHc75t4tureborgiJNqRuLZXvN0KzOEy3KdPKx
 EREpYTxGAJDuZcofRvTO69sjAz9Zk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH] tests/jobs: Fix warning about an invalid value for kernel type
Date: Tue,  5 Dec 2023 16:22:02 +0100
Message-Id: <20231205152202.924589-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The following warning could be seen in the LAVA web gui for all x86 test
jobs. An example available at [1]:

    Invalid job definition:
    not a valid value @ data['actions[0]']['deploy']['tftp']['kernel']['type']

According to the docs [2] the supported values are:
    image, uimage and zimage

As kernel type for x86 bootloaders is never used we can remove the type
property completely.

[1] https://lava.xenomai.org/scheduler/job/11720
[2] https://docs.lavasoftware.org/lava/actions-deploy.html#type

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 tests/jobs/xenomai-x86-64-efi.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index ec28291..d71b5ae 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -33,7 +33,6 @@ actions:
     to: tftp
     kernel:
       url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
-      type: bzimage
     ramdisk:
       url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       compression: gz
-- 
2.39.2

