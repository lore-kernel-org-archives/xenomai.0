Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105AD58ABC
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817704; cv=none; b=RgS9co9SI43vwrqRq8nJb46Pu1CVjlSmbyDkd0bnj3ux+kWZ24Ukp67N6y9sgexg9Ww+b4auizBMB4QDBUkj04+3OpDLczLva8JEPM0ZTCB0M/vSlWqyDQmsZo4tAx4XBBJWobGXyushoDQ/zjWTOE87oydPB6AQ6+yTpyHQu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817704; c=relaxed/simple;
	bh=Hrb+C4z6JmogF/MWh3HBzvycJKpFQIH6/TxSHPH/YJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YB4nSLissrTBIrvpxIXqGViy7/EuUgz1WaaQbSxnxM5adufs4jOYR/fc23d6GUkFXLPGeYrPR68zyn+dxC2vRqd9p9qTSbwDPm9RjSl2SP+iXvzRPmnS2o/5RsBZfYojeI5zAHfORMqHlm2qfF4FZgrR2wvA81ry7HcoJ8GvsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=HA5Tu1nj; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="HA5Tu1nj"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024070107081048d1614dc3e8477320
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jul 2024 09:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4jPSZshXJjMCzlBR6D9zOP/0fqoECPBPgrIsNmhiIio=;
 b=HA5Tu1nj3vi8i0xkwVW3WoxYycEK0waK90CCNpjTVVBWsc2l0DyhqUY3bJX4e1JNEzTUFN
 CfkVf6Hws8Cw1V1cuB8VFdWrlMFTqb08ChFwyz7ZHdtCVeUwXOfOpxcRXyZBXRy/fh0CI17m
 /uAu4gTvTWY72sPGnaNonUZ2BSMAY=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH v2 1/4] ci: specify the dtb file for rpi4 in machine conf
Date: Mon,  1 Jul 2024 09:08:04 +0200
Message-Id: <20240701070807.14465-2-yi.jiang@siemens.com>
In-Reply-To: <20240701070807.14465-1-yi.jiang@siemens.com>
References: <20240701070807.14465-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

This patch is necessary because U-boot cannot take use of the local DTB file on the board, therefore we must provide the DTB for LAVA.

Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
---
 conf/machine/rpi4.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/machine/rpi4.conf b/conf/machine/rpi4.conf
index 3c0607e..c24bc4c 100644
--- a/conf/machine/rpi4.conf
+++ b/conf/machine/rpi4.conf
@@ -30,3 +30,5 @@ IMAGE_BOOT_FILES = " \
     "
 
 IMAGE_PREINSTALL:append = " firmware-brcm80211"
+
+DTB_FILES = "bcm2711-rpi-4-b.dtb"
-- 
2.39.2

