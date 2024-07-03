Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12817A589
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013149; cv=none; b=SfVn2rPxA1ahTE8H4bM7acCjl8AKeHyNovIA5j6fUCsgwN1Tb/mf6+j0SGN9DBuOkpH8ibfC/wZCKbHebmfyQoFBY7cbKjtZO/NuHROuIv5bFs/FvnCnXnqURluwJG8pAhAmO0VkmhXGIkKGMvEuTr/9/gV2h5lAbrIFo7SYTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013149; c=relaxed/simple;
	bh=vbqiKj944w26U6Ben9vYdEe/c5UItqg2Z1EHh6Rf1Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WB+O9DZEkC8nXS3vx0NDwrxaW82zA1agKgCuv03UjP9RpsAqOcJkWorUuNgc+WjiPRYOSr29cM91tU6fzg9wBk2eFYaapefxs7Y+1sQL47ZxwE25czQy7Bwej41C6xuvmgym/XWWpgmYBto66jT/Q6K155q7jJRLRs3AbUqZjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=TDIxJJ1v; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="TDIxJJ1v"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240703132537afd0ce55f0a10dd95c
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s5ZHPFK3pZP5m/20KOmiGZecAd3IkRHIvEnidmIVsHM=;
 b=TDIxJJ1v14xnKgiFiGVG5VwWJopxXDP03dHl6QOx+bEJSvG/jPlw/Y8mee6YlF1a0vAfAR
 0t2RxBUlDCF4v3GrNHYivz5vm6Ubpq23GwOTVq0A2qckevaP+jCDNCcl8aW8GsSomde0bmlc
 OX66G/NWYN5iC+yQT11+5VpDPMwiM=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:24 +0200
Subject: [PATCH 01/33] cobalt/clock: Use xenomai specific log level
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-1-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a Xenomai specific error so we should use the Xenomai specific
log level.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/clock.c b/kernel/cobalt/clock.c
index adbfc6512..f316f6684 100644
--- a/kernel/cobalt/clock.c
+++ b/kernel/cobalt/clock.c
@@ -81,7 +81,7 @@ int __xnclock_ratelimit(struct xnclock_ratelimit_state *rs, const char *func)
 		rs->begin = xnclock_read_realtime(&nkclock);
 	if (xnclock_read_realtime(&nkclock) >= rs->begin + rs->interval) {
 		if (rs->missed)
-			printk(KERN_WARNING "%s: %d callbacks suppressed\n",
+			printk(XENO_WARNING "%s: %d callbacks suppressed\n",
 			       func, rs->missed);
 		rs->begin   = 0;
 		rs->printed = 0;

-- 
2.39.2

