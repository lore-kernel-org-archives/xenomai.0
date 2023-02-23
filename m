Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A931FD6
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 07:40:52 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230223074049eeee24fd49f5f1b948
        for <xenomai@lists.linux.dev>;
        Thu, 23 Feb 2023 08:40:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rqrLrnArsul+MGZvhcpc62K54IebIxgE3S1WSABjHN4=;
 b=HRneoerfda5VyclHiZVVRjeecX1g2lImo40LhTeQjsomeCJggjH98lz58+V3btkj45B51O
 U0pByNc05kVAjLVg1+1OE9s1Ibm3ap6JwXfThmpQbpXUyNQuiyeh1nmfzRD0CTg02J+7sgdV
 oH07AqVBBi9Z0gDaznT+qrw8WYs4g=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 2/2] ci: Fix some bitbake warnings triggered by opt-ci.yml
Date: Thu, 23 Feb 2023 08:40:47 +0100
Message-Id: <20230223074047.3974956-3-florian.bezdeka@siemens.com>
In-Reply-To: <20230223074047.3974956-1-florian.bezdeka@siemens.com>
References: <20230223074047.3974956-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The WARNING:
WARNING: IMAGE_INSTALL:remove += is not a recommended operator combination, please replace it.
WARNING: IMAGE_INSTALL:remove += is not a recommended operator combination, please replace it.

We can savely remove the "+".

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 opt-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/opt-ci.yml b/opt-ci.yml
index 32de022..80a3970 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -21,6 +21,6 @@ header:
 local_conf_header:
   xenomai-ci: |
     ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_sshd_key_regen"
-    IMAGE_INSTALL:remove += "sshd-regen-keys"
-    IMAGE_INSTALL:remove += "expand-on-first-boot"
+    IMAGE_INSTALL:remove = "sshd-regen-keys"
+    IMAGE_INSTALL:remove = "expand-on-first-boot"
     IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
-- 
2.39.1

