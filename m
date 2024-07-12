Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03D152163
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781943; cv=none; b=G9zXPZh8gpvmweZlge8bfPTsu/ehm1+pO/UIydTr6P+C/OhwkwgEJn1ofaFcnz/hWsS16MgQTaRuU2CvptV6zOHYXEHSzbCKCZuNklwz/zwtct+ObDqpmE5dTFX5biNsrDVPnys1q2ielrpYVx4Plr6hZpT7+cSwrENPcbuhc7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781943; c=relaxed/simple;
	bh=vqT8t5+13tL+Y3yESLIvlf8BPLB+GTby9gQmUgFk0TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGC0fNiW+iIGmiR17GT2tuDu9sT1LNlFPX+2wbCYFDhIHGROt1I6pZXLmimePa97LLd8XNRD+5guymV+BV2nQ3FRAbqgKXcevtVgEEfXquPUlu0t1h5SWECVQbgs4KLmrxmNVxQRDQVQgk8UM3p2KGuZKtRShGO1xqQrr9z58QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=qaL9ZGHA; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="qaL9ZGHA"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202407121048499b282c2dd758da62cd
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FeL0Y+nURrK8ZJD7kda4zR0RHTOE3SytVWuk2LQEOBM=;
 b=qaL9ZGHA66dh71JdsyL/9fq3VBTHq0uoCsEB+Y8WOQEXR7xymi9jJ8CCYcJdW63oV5j133
 UpgiiH+4mLTd4aJcg/kP0zol565gEaCDYhI6saACE7ff40qOk2i/ZRpPFiLCourUkC8D5S8I
 VxzTx8JkXZ/leNnZPRcwLgo/noJfU=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:47 +0200
Subject: [PATCH v2 01/33] cobalt/clock: Use xenomai specific log level
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-1-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

This is a Xenomai specific error so we should use the Xenomai specific
log level.

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

