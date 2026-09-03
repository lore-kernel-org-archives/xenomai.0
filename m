Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB77377EB0
	for <xenomai@lists.linux.dev>; Thu,  3 Sep 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435211; cv=none; b=J8fJTQjZMu7+FxZq/IXQACmHCr7uWeHs1FiVyuhtgAMttF1edR388pHPicFaT0iYNKHlMVIbcxAehRWkswRAebVGn08aOVmCBV/nFs2v3fP7rClU5OWW2BZIciKkdTCQSbnYm0TL72EKOjPjNVoJTQdmOoG70vxqnIx7gZSZJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435211; c=relaxed/simple;
	bh=XAyYE9N323dM6/yxse6G9LNurJ4JgDQMOZj2YiAHQoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWLckS5Hy6bdPxat1oFxAiQUT9WLVYnTHLc2LbTEUjDw1r5n+UuHzGfvvxvHND/82XUM7g83/53MrweCYiskSxbf0ETWE3/E2MCdGA3bAZCEYX/IIRSG8HmPIDnex4BTZofGisucdpcCkf9Fsz0EKv0cOWHavn75kkPwBWDuzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b=Bl5H0mK+; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=clara.kowalsky@siemens.com header.b="Bl5H0mK+"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202609031133173276b9fbbf00020766
        for <xenomai@lists.linux.dev>;
        Thu, 03 Sep 2026 13:33:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=clara.kowalsky@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3cUakMFKF9i2CyWgnEql8vAIXGiZslrNXzw0g295o6o=;
 b=Bl5H0mK+IgZkMA+RHs1LXAsMx9pbOhG2ZUNpg2jW0yMLMtlKy8ae4VGDcqHDkl+61UVTdt
 mICEe0u08Mb77oZ24yfJ6lIXTgWlgw5Pit8is/jkfdeGDG1x2bt543mVqN0wTJ2SQ/R4vmLN
 HqMM5xhNoK59hTRGHgc7sQeJojzcjr1rIywM4asL+hQtFL7VEkfMDfnTYRniCbQ8kReXjzzl
 mtrxJ9KdKJcFp+Jgl0q7p06jv3BccA3l+Q/mRDxgk06VVcgtbplVAkRBor3xslZ0xxiQpm8n
 UgByy2GTFOPTrnTl2mJ2KkgN4L4liEMtlMj9UTHdJmQgRZIyDHDr23Vg==;
From: Clara Kowalsky <clara.kowalsky@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: [PATCH v2 2/2] docs: Remove @return marker for rtdm_printk_ratelimited
Date: Thu,  3 Sep 2026 13:33:04 +0200
Message-ID: <20260903113304.2425313-2-clara.kowalsky@siemens.com>
In-Reply-To: <20260903113304.2425313-1-clara.kowalsky@siemens.com>
References: <20260903113304.2425313-1-clara.kowalsky@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1047747:519-21489:flowmailer

rtdm_printk_ratelimited is a "do { } while (0)" macro and does not
return anything. Remove the @return marker from the documentation.

This fixes the warning

kernel/cobalt/rtdm/drvlib.c:2265: warning: found documented return type for rtdm_printk_ratelimited that does not return anything

Closes #18.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 kernel/cobalt/rtdm/drvlib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index d9de62946..f7dd830ea 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -2265,9 +2265,6 @@ EXPORT_SYMBOL_GPL(rtdm_get_iov_flatlen);
  * @param[in] format Format string (conforming standard @c printf())
  * @param ... Arguments referred by @a format
  *
- * @return On success, this service returns the number of characters printed.
- * Otherwise, a negative error code is returned.
- *
  * @coretags{unrestricted}
  */
 void rtdm_printk_ratelimited(const char *format, ...);
-- 
2.55.0

