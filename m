Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B815ECC6
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781344; cv=none; b=LPehThB52SRebGn2oNNzcuGjxLuikx4waxuE97Mf2wn44u+o/CC5fMyaPQOHbhEEzcPW3is6MH0Zd13N9l2s7Y1GF5IfCjEdUwM4Mm51CWvOQGKihKUeyMag4kWk00DGhB141PohAWZG50GevJLch5bNhLZ5pwUwgeN/8lwuRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781344; c=relaxed/simple;
	bh=8c/tljpR5DPL/cKajTLhP2CaFtfvw37SUQIQYWeGoE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6sUvCa0CmWmBHB0CQAxz3Uoo5iBSbheEEOZro33c80D0rrhS/78mjgkyolbt3gjISnJdZKVkUOGegErfPGEP3UG0uFgaUHpz/ARBGQ6VZ7NKxYAO2zwF1h/Q4X0u0JYlK0vqrDf2uEz8u3axzHD86slTvhvQoM3aEkKs7vyZ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=avFpv8ON; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="avFpv8ON"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240712104902d652626f5622b57164
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bvGjtlnTabFIFmZL+zOWo1xVTYyIW4Hc6HfN5Fa4hW8=;
 b=avFpv8ONa4b3NJqoSjizGljv8P3kOZo2dFk2Jmd/VsC04G65oLa4+sMT9JyjhJuvV9dQqv
 FHtZVihT7wfNjeyZGVesL8GX66NQN5qZRe2zgoA/JvahPLmsxvC9hOGG6hxU8YfXI+tCBYSE
 4XfYmlfA7DSyOvVOTnK8MnEEbBI+4=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:49:19 +0200
Subject: [PATCH v2 33/33] cobalt/rtdm: Finally remove rtdm_printk()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-33-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
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

