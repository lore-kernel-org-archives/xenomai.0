Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340F17B42A
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013153; cv=none; b=hKkF7HyAvIDtwk3oLbFgu6hbIi8AKrJKP9m1QKrxMLr+nORO8h85hgP6VXZoFkykJaUM363vsFoY9Gh7FAnSg7c3tGWj5bICmqQL+2uI54pLBuau3k+RxSnWw7p2lyXXL/78qEWmExmLwPVhpzm3rcTkq/mDQxmXh4GK/20J2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013153; c=relaxed/simple;
	bh=ZPuH+l2UI/d8VB1DDXtzkD2oHcxgOZX7srBbrMxROPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAI6NETVZOZU5xCDFNgdaWLlG8L4d8/Abf2baGcrIrCAfwhPpNd5+BPZQ729IPVX3iV3SwUBlsPTApTY3RnTCqJbxtwVjMGN+94TEcIDR+IPvrv//lcQ5BNhU7yYkNNXvvOxorXGo5t3MhMB+91rJW5t2ng8R57ynbi9cmAcfgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=rjrhl3pv; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="rjrhl3pv"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240703132550602e22165afbee8625
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kNAbca03lskEAzPszOYWIOXxU5n2Q62tJAjhMmtwezc=;
 b=rjrhl3pvo/X3i0KZOhKUckRW+ntmcYQ1SO+NvYPPtKuEzAEvaIfITGsI7QOoCrhu0T28ZS
 IS4Zt64eKGJSS+6YFvrlvD+chIls+jB3U6Vk8kLNl7y9BCX3zqgbKoHVyFtEthLEf6D2RYRG
 zzZYvGnY6GkRktRsKVbVrOdqmoKXY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:55 +0200
Subject: [PATCH 32/33] drivers/spi: Migrate from printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-32-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The log level was present in this case, migrating anyway to keep in
sync with all the other drivers.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/spi/spi-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index b3ffb64b1..f58fc900a 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -379,7 +379,7 @@ int __rtdm_spi_setup_driver(struct rtdm_spi_master *master)
 #endif
 	if (IS_ERR(master->devclass)) {
 		kfree(master->classname);
-		printk(XENO_ERR "cannot create sysfs class\n");
+		pr_err("cannot create sysfs class\n");
 		return PTR_ERR(master->devclass);
 	}
 

-- 
2.39.2

