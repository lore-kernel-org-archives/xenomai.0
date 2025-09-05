Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9629B8F5
	for <xenomai@lists.linux.dev>; Fri,  5 Sep 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072587; cv=none; b=PYjw0N6jYujUWo7ydx8i+/A9Ri2o2qkt13QZ17RMP3eo8Fh7b4NpEEkmLh0jD1hCM0TaFwquta+KF8ziwe2Wtug9CmNLD6qgTCjvugesphPNmcADCow1RW+mEakltust5wtKDw8ntAeLP3PkselY/wWwrHfEIezkWTIalqlv/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072587; c=relaxed/simple;
	bh=pI8NDkADBKkw8WbJW6E5cg3AvpwjDYifa+fgUw6SaiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xhbe3OBRwvPFwU8mMOAPNYsGIulMPqqM0Frr//MqImZMDxEgEpzZZiTRCznvybS6992dVPIwuyoHCDMDJP5cSax/zUQJV0d7j8OkqKSoyFd3t1DJ3pmLyIUeuTkHlaX3S8v5Ndgb15cHzvMr9ofDqhQFa7i8749jpPkzCmfHnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Lt/GomrL; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Lt/GomrL"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202509051143007756ed41d600020753
        for <xenomai@lists.linux.dev>;
        Fri, 05 Sep 2025 13:43:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UpMrC2OlbLHCjwAUGxYbOl6hzHMs7wFEcpXZv34xQ3M=;
 b=Lt/GomrLhUocBWWGC0FX1/AXrUb2Svth33bSKH9byYbeVqJzG2ynHy8ZV1cjOkombwwi81
 eiVvsdRcCfLkh8F/8ywsg7a/wC1/T1R5AYWgEonSHk147/oJL5OZ3vt604QMFz6boaSMRuWT
 qp9shlfJAA7DaNJZ39FfBuNE5SfQFdH4buE/vrFCX7tb5//cV3Qwu8YPAUNIzYi0B1nrrY9f
 BLsZGYmjbDLM3HMSGE79RBOsoR6nJn0AV7IGA7C1sbGMKxoyHbcaFGNKPK7AZt32G2Dun2Pg
 kKozJE8nZZE532SGAb0aOpHLlkscH8LkibgLXVpkbTVeOh7BIS6ndeJQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/5] drivers/analogy/8255: Drop redundant zeroing of subdevice struct
Date: Fri,  5 Sep 2025 13:42:54 +0200
Message-ID: <6c93e3cb052709649064ecb671193b5315b77337.1757072578.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1757072578.git.jan.kiszka@siemens.com>
References: <cover.1757072578.git.jan.kiszka@siemens.com>
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

This is already done by a4l_alloc_subd, both for a4l_subdevice and the
succeeding private data. Dropping the memset here also helps resolving
CONFIG_FORTIFY_SOURCE findings as subd->priv appears as zero-length to
the compiler.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/analogy/intel/8255.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/drivers/analogy/intel/8255.c b/kernel/drivers/analogy/intel/8255.c
index 049c5d2a47..be43dbb6ab 100644
--- a/kernel/drivers/analogy/intel/8255.c
+++ b/kernel/drivers/analogy/intel/8255.c
@@ -266,9 +266,6 @@ static int dev_8255_attach(struct a4l_device *dev, a4l_lnkdesc_t *arg)
 			goto out_attach;
 		}
 
-		memset(subd, 0, sizeof(struct a4l_subdevice));
-		memset(subd->priv, 0, sizeof(subd_8255_t));
-
 		subd_8255 = (subd_8255_t *)subd->priv;
 
 		if(request_region(addrs[i], _8255_SIZE, "Analogy 8255") == 0) {
-- 
2.43.0

