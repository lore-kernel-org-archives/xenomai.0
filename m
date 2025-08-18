Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAD261B8C
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520016; cv=none; b=rHZtPl6tz5kOhcnzg3JNiIFgyWpxHpoTV00LRhyOKP77pqibWtdrSGA/aKQOZ5OVE7r89G3Gs6yDMMdBsFats1CB3RxoW6HBnciPXf1tDdp8xHQIf3SvBe/Y2F9EMMKYgi6hJIgK8T+lFry85W+k+F9EYOTso9up98iewxrIRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520016; c=relaxed/simple;
	bh=4pcjIxl1KOGNAFQmACJMSNTX0wamc3z9qP8QzH1x3LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVxHTnm6Y4ejF1WitxSw2pOTKGrXdJjAKnmQgHK49Q4E8G92m8Y/1MYoKw6IslrZgLCPy/ow88GoBCu7u9wTF629pbGs37Hof7bFp2PBEzFg8Th1PjDhsZA2c3vMFTrYZCMhJ62Ja744zqzXNVI33ktRS3+T+iLqzpPS+XDpzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TBOAqVFw; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TBOAqVFw"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025081812264602d1e8364f18aa58a2
        for <xenomai@lists.linux.dev>;
        Mon, 18 Aug 2025 14:26:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=qzcT7mwlWXg7V3XSHZ0tQId/7qzr3cvZTQcHIO+huJo=;
 b=TBOAqVFwzrKcYgXkhTjWmvMwCNc0s4KmbHnUq+ktqLAky+vKtY955mTIBvQq1rtlg5wyUj
 1FDhUNTuYdvu6hgUM/cg4EE8jZAaR7aTWfTcq9Q0oNC5VOTDFOvpNeX2uzZZt0Y+31NXFH34
 qKgNGUy8qh8XN83inzykIwvo/izaKv0bdJ6S44k6nuLG7ARDShr12qnDV4YuPQ4hjoKKw/K1
 7jlrU7bzHMR0zuPB5oYJvvY6JtF6xntFfacoPxFmPHJcv/h1NrtYDXxC7o7//J2sBKXMpcEj
 9y8AsyvOts8d70smPeWoxtITzsAidglZxQ2R9gTUB+rwz6yzmmyEo+3A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 Aug 2025 14:26:47 +0200
Subject: [PATCH 05/13] drivers/eth1394: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-wip-flo-add-missing-module-descriptions-v1-5-c57f195e3f93@siemens.com>
References: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
In-Reply-To: <20250812-wip-flo-add-missing-module-descriptions-v1-0-c57f195e3f93@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There is a build warning triggered when MODULE_DESCRIPTION() is
missing. Seen on builds with Dovetail 6.16, but likely older versions
are also already triggering the warning.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/drivers/eth1394.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/drivers/eth1394.c b/kernel/drivers/net/drivers/eth1394.c
index 689648313..a7bfd54ee 100644
--- a/kernel/drivers/net/drivers/eth1394.c
+++ b/kernel/drivers/net/drivers/eth1394.c
@@ -1517,3 +1517,4 @@ module_init(eth1394_init);
 module_exit(eth1394_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM driver for Ethernet emulation over FireWire");

-- 
2.39.5

