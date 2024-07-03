Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038B173345
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013155; cv=none; b=S22IulwUe/3BvicwMGc2bIQFgoXGCkR1wXNc9f88VOgfi5HQRsMlR57Iu65DuGV8MqNedWwv/IcIJ2K6E6SqH5MtVR38vo/L6jl0f7ZZBj3qHWhkwRvYGNkKZrhkPACxXpBFu/Pkay6sUcNAZANjwkzkxo81VBngwjvExyodLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013155; c=relaxed/simple;
	bh=8c/tljpR5DPL/cKajTLhP2CaFtfvw37SUQIQYWeGoE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mht57np47jov8axvfQt5GD2F+ZT0rgQUroXR/v7ezQ4UX48kvlWk9YZQ1U8rwt7M/9gtnO1wrUcPtewNyP+XFnkbwKG8g1E65IPgdGyAlbR8XE8TOlDFcJWhttFrVnVduipPqCcpgIT6vFyxx98gIXLPBMNAq9tighqqrJaPZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=iQeDf7Oa; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iQeDf7Oa"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024070313255142917dbb4ed8d76611
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bvGjtlnTabFIFmZL+zOWo1xVTYyIW4Hc6HfN5Fa4hW8=;
 b=iQeDf7OaISDgOy8nlqTyStaJ0go4NSV8MUSL1Z/DKXDx1hSPkk6XGT4SeZoTCadGM/9+QP
 4ihuOPdwLCYUHIFQifSy2eYVTXQ0y0L7+SbJWeGlFXVI6u1Zf+0DP9K6cOyrJ6FNrOEK4uMX
 BOJiWy1Re4ispLpw4OoRsp+Dy5cTw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:56 +0200
Subject: [PATCH 33/33] cobalt/rtdm: Finally remove rtdm_printk()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-33-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

All users have been migrated, we can finally remove rtdm_printk().

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/rtdm/driver.h      |  2 --
 kernel/cobalt/rtdm/drvlib.c              | 13 -------------
 kernel/drivers/net/doc/README.drvporting |  3 +--
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index d5f3dad34..8fb326b1c 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1230,8 +1230,6 @@ void rtdm_mutex_destroy(rtdm_mutex_t *mutex);
 
 /* --- utility functions --- */
 
-#define rtdm_printk(format, ...)	printk(format, ##__VA_ARGS__)
-
 #define rtdm_printk_ratelimited(fmt, ...)  do {				\
 	if (xnclock_ratelimit())					\
 		printk(fmt, ##__VA_ARGS__);				\
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 7378f2c01..53b7c7bef 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -2275,19 +2275,6 @@ EXPORT_SYMBOL_GPL(rtdm_get_iov_flatlen);
  */
 void rtdm_printk_ratelimited(const char *format, ...);
 
-/**
- * Real-time safe message printing on kernel console
- *
- * @param[in] format Format string (conforming standard @c printf())
- * @param ... Arguments referred by @a format
- *
- * @return On success, this service returns the number of characters printed.
- * Otherwise, a negative error code is returned.
- *
- * @coretags{unrestricted}
- */
-void rtdm_printk(const char *format, ...);
-
 /**
  * Allocate memory block
  *
diff --git a/kernel/drivers/net/doc/README.drvporting b/kernel/drivers/net/doc/README.drvporting
index 038097196..24a7becc4 100644
--- a/kernel/drivers/net/doc/README.drvporting
+++ b/kernel/drivers/net/doc/README.drvporting
@@ -149,8 +149,7 @@ waiting on hardware events.
     interrupt handler
 
 
-20. replace printk in xmit function, interrupt handler, and any function called
-    within this context with rtdm_printk. Where avoidable, disable output in
+20. Where avoidable, disable output (like printk(), pr_*()), in
     critical functions (i.e. when interrupts are off) completely.
 
 

-- 
2.39.2

