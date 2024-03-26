Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426C54BFF
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435283; cv=none; b=ZTwAHpKPizj8+jsn0rha4zUp9sgkF1zPB3wCvNMmB4i2ZZWXr9Y9Q/W22BLw0dSiUtkev8XSPMCv9TTtqPP2ZsSotFgtCNXF03+gwjckQ1Zy58GPWWMuFM2IZ0d6Op7sh5oP2FcyDibJCn14CNqD9IZZrS/XUjO1Po8VDkpNbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435283; c=relaxed/simple;
	bh=a9qF4pxRIxn0ldWVqMvgWn+gd0sFNreOZB7P0+bHc7k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jRPRBmSzC9VJcNMKP//h7KNbjlnNFX7Bw7tT5knoBtXD6dTQZXhXrc1WobUxYeYxpT8pTw9Tm41XF74okeU1X1vfKy12p2nvcJWwLKdak5GexWpXH0YXz7V6iv/cM12BHWjXU8096/e76FiFJVXNFxQSFVgXAdvzEwTMsk7VOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=I0z7/CK+; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="I0z7/CK+"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024032606310877d6d32b191a3299a0
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=muOMOlx2QLqlCLZV/y52M+URteARhbr9bA79ppvarBM=;
 b=I0z7/CK+hDRW+eZ3pWKCHvbPWd77t4vDy8NJ4rwYACQ25ixM9AYozbaeoAwF4EKk5DZTNs
 e5bH1DwUHgWwWoe0jgXjUEQQfu1dXNRmvsJyk8yrJyIZ3XecytTJJjyrWnapUbfvBQO0uCKc
 TIO6B2kbruT5qSQC2EMY4r3ltve+M=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 12/25] drivers/can/c_can: Replace deprecated strlcpy with strscpy
Date: Tue, 26 Mar 2024 07:30:51 +0100
Message-Id: <836e6eb3aaa64abb2d72e3ac27082fcca68c62f5.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

strlcpy was dropped from kernel 6.8, and strscpy is around since 4.3.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/c_can/rtcan_c_can_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/can/c_can/rtcan_c_can_ethtool.c b/kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
index 7945ce4d8b..8e672a9f36 100644
--- a/kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
+++ b/kernel/drivers/can/c_can/rtcan_c_can_ethtool.c
@@ -20,9 +20,9 @@ static void rtcan_c_can_get_drvinfo(struct rtcan_device *dev,
 	struct c_can_priv *priv = rtcan_priv(dev);
 	struct platform_device *pdev = to_platform_device(priv->device);
 
-	strlcpy(info->driver, "c_can", sizeof(info->driver));
-	strlcpy(info->version, "1.0", sizeof(info->version));
-	strlcpy(info->bus_info, pdev->name, sizeof(info->bus_info));
+	strscpy(info->driver, "c_can", sizeof(info->driver));
+	strscpy(info->version, "1.0", sizeof(info->version));
+	strscpy(info->bus_info, pdev->name, sizeof(info->bus_info));
 }
 
 static void rtcan_c_can_get_ringparam(struct rtcan_device *dev,
-- 
2.35.3

