Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE10EA6
	for <xenomai@lists.linux.dev>; Thu,  4 May 2023 08:08:55 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202305040758458b1b96d493e519337f
        for <xenomai@lists.linux.dev>;
        Thu, 04 May 2023 09:58:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a4oZyJQTjpzAokn6njU+v40ItziV3GTs9GTZ+3NfFzY=;
 b=nsOGx0zsz11WuHuAY3X325lQQE105ep3DmcS39mo0X9MyMQYEVUSZ3U5fNbnMKIFwZiLMO
 kYAnw4pE1nlZj/VvjyyoUiRBM2US9wcAyDfatwwpRujbRIo6K2Kz66ol11l+E1l0L+/q2rdx
 FUzTvZG/HXSkP+X+WP8MBJ8JfPciw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 04 May 2023 09:58:40 +0200
Subject: [PATCH xenomai-images v2 2/4] customizations: Mask
 systemd-network-generator service
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-flo-debian-bookworm-update-v2-2-f859df1417e6@siemens.com>
References: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
In-Reply-To: <20230503-flo-debian-bookworm-update-v2-0-f859df1417e6@siemens.com>
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

