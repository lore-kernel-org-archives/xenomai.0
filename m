Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C515DBC6
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781343; cv=none; b=kxoNd+tTxgmVSoyhwfZCjDNsykKS8I6lXSRDSgzt1xfqqdaBp/sThzL4hDooznTUUwD0CRFm3eYXriQF3uwuA7+suprQWNvMhWI4gYVBJcJrJg/RcoPOnZs1OVzID+aki25u5KlZjdc4xI7apop447O6SmI77uLkmnqcUZc5eFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781343; c=relaxed/simple;
	bh=ZPuH+l2UI/d8VB1DDXtzkD2oHcxgOZX7srBbrMxROPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/JAZzX/OWXzuhYc0mc3ETgcBTZSdifbxdLe2tzZhcQtKxUd0x90JuRZBBPO6mJhv6npI1IihXsWc19OfbKlYHIpSyo14sp5bCEcpmjO0KoPJud5/O1gkrIQyZjUzNDH2U3NprEpZ+pWDY/FtQao/q6Um67AV29Bb94gSsUDhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=eSCIrt/t; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="eSCIrt/t"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240712104901be6bc58e0b75718143
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kNAbca03lskEAzPszOYWIOXxU5n2Q62tJAjhMmtwezc=;
 b=eSCIrt/tzF0aQlznKkj3GvVE8TquTZk+1xPPeFUOfJIvG1mrcF/AAvFlUTu4xeskL4WNKE
 eMZaGppRVbv+CRIKeIAQN8zCOaLG/qvEuUbYdMkxwr62qydviVGAZ7fdgRNa0SoB6c1ZbH6v
 zJxT8Zd9jum8d9cfap1Y015aVEA4c=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:18 +0200
Subject: [PATCH v2 32/33] drivers/spi: Migrate from printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-32-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
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

