Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186041F956
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577294; cv=none; b=CPA6/gNwPKmzp+FgGF4K7y8Ue32yDZsAtVvfSVZzzv4pWA87WIW5XIZMzpGI+Q2GEIg2BwCdBiXlOyyDcv6svj8fajYwSS7EEmpwFLf8zLP3FwYd3CKruOer94RY53HdZDEC3Ao8FfILv4jwkZ0Es1kw6PgZXskS92hllhZSriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577294; c=relaxed/simple;
	bh=uo1pDQaQEs7r+vLtS3C75u9UWsq+DLBzwP+2uwmbTJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvHC6Rw+UgEhxz2j4wtRWUS6MpGpJMkfk91UNBOc0kjFLMSJDvpV7zwwAZmrHvaUrMYy7crCE0QAPin95z+g9EyPFqWepBlyg2n3jD1gKq1kx6yUlGGEhyGDymol2maTOH8X4noDq6jr85zvwVQE+bEI8M0x7X5pklyS7+kyGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b=h7D8pr3W; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=yi.jiang@siemens.com header.b="h7D8pr3W"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240628122121b866ac0f005b14bde9
        for <xenomai@lists.linux.dev>;
        Fri, 28 Jun 2024 14:21:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=yi.jiang@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+8pyyrimA/GL4LoHtTskPau5xifNxkB+M8xNYIDiz0o=;
 b=h7D8pr3WDnCe8p31sJsYN58TeT94MoLxk8DjDyLktyE2lzU36CrX3dvNeL7k3N6AaIvJw1
 gXk9foVCJsVKNHcvYO2c/jJ0yXHmquXjBxvQ4fx0KO9troKxgqh47qlxgFjHeQ2R/0A83TBj
 +GGoQd92Y9cJGuZhUuegp7uWWq2W0=;
From: Yi Jiang <yi.jiang@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	quirin.gylstorff@siemens.com,
	Yi Jiang <yi.jiang@siemens.com>
Subject: [PATCH 1/4] ci: specify the dtb file for rpi4 in machine conf
Date: Fri, 28 Jun 2024 14:21:14 +0200
Message-Id: <20240628122117.19059-2-yi.jiang@siemens.com>
In-Reply-To: <20240628122117.19059-1-yi.jiang@siemens.com>
References: <20240628122117.19059-1-yi.jiang@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325609:519-21489:flowmailer

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

