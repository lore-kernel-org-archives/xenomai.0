Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4ED517
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 12:10:17 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230503121009193353e742ef19b957
        for <xenomai@lists.linux.dev>;
        Wed, 03 May 2023 14:10:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a4oZyJQTjpzAokn6njU+v40ItziV3GTs9GTZ+3NfFzY=;
 b=lU9g2qICAjmj2o/SPYycQNKUoUqvKtWgcPrUTquhqrd713GSIc4Y/wsCDfSQyrG5oYkUmS
 6KjTh2Ge6jQ8jLchB1hnsRmrE4UH/bcYlLjW0TC7OxnsVLz/6A0evZ7u1nBc+WV24iNXz5bF
 EccUSEpLCp+amTLWXDfgAlP4JjaqM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 May 2023 14:10:04 +0200
Subject: [PATCH xenomai-images 3/4] customizations: Mask
 systemd-network-generator service
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-flo-debian-bookworm-update-v1-3-6a4aa9e4d95f@siemens.com>
References: <20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v1-0-6a4aa9e4d95f@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

We use ip=dhcp as kernel cmdline option for most of our CI targets.
This cmdline option is now taken into account by newer systemd versions
and a network configuration generation in userspace is triggered.

WLAN interfaces are part of the generated network configuration and
might trigger a complete system hang. Especially the HiKey board in
combination with 4.19 (ipipe) is affected.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-core/customizations/files/postinst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
index 691988f..d8d141c 100644
--- a/recipes-core/customizations/files/postinst
+++ b/recipes-core/customizations/files/postinst
@@ -15,3 +15,5 @@ echo "Xenomai Demo Image (login: root/root)" > /etc/issue
 echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
 
 echo "demo" > /etc/hostname
+
+/usr/bin/systemctl mask systemd-network-generator

-- 
2.39.2

