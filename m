Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863373C197C
	for <xenomai@lists.linux.dev>; Thu, 26 Feb 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116651; cv=none; b=RXZuM/Bwrq9tEG04WpWMfKOzewfJUlRIm1F/irNdLCCes+x80SuaUUOtKhHAQdHSqT477f9myNNlWI/wAV69IB8oGO2iBoPRABV2Nle/9AH3Rs3dNQrwseyhEzn2bGO0XAcr+pLdczqLqgQ9K/BpWGalVH6Hmg+3J0jakXGfelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116651; c=relaxed/simple;
	bh=RXfDqvCoCJKZzrItR1pg1JK7cB7jrhBnYyrQbjVgfa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQiqpTpMC+4hgb+86QFW8OTISkmDA7l1NESFzoUTF/PgwVdi/blFDn0DRLX30sZSv7iPXJeuH9eyBacPa1QA9wJ+SrBFpIZt0HIt725N/EAzdUzTAPTTU+ELefwAjJhTkdxV3QEiuxWh6v0vJo2Xm/fCsA0VzcnCSONPY6hCISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Vs6iCnd1; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Vs6iCnd1"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202602261437146568e2d8fc00020796
        for <xenomai@lists.linux.dev>;
        Thu, 26 Feb 2026 15:37:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YMTz0U/20xZSMzq+2/J+2JBxpDEa/+4VTHiMIEu0mII=;
 b=Vs6iCnd1wkoeallv66+GMK3YybkcK+pCMI86halZHmW1sFrk5RAezIgRZTYHFLn4Sh3HKn
 8r0enyA8x+qW3xUaYeauTzoiTP28SprdEGEPxccYs9vvJkipq17Kf91QTmYNsWa65wg/rCKC
 nXA6kiEWsVcf2c37sYBt+LBA8TxLZ4zRONwJMfMAo06JLLLLa8SVm9U9Ss57E3blyxOaBprn
 cWwyKd01o6drhA1qXvj24UiJUVvUN8mXadG7dBcVDj/M0soKAh3OpJ70Gq8xSyLYQvo7+LKk
 fq7UhW0n8mQ7Q8rl74Sg3EOcc6zvt4YYuYURFCtW1HCqVIk3rPTqkD0A==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 26 Feb 2026 15:37:15 +0100
Subject: [PATCH v3 4/5] cobalt/rtdm: Prepare for new signature of
 mm_get_unmapped_area() in 6.19
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-wip-flo-prepare-for-6-19-v3-4-e730e85eda81@siemens.com>
References: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
In-Reply-To: <20260226-wip-flo-prepare-for-6-19-v3-0-e730e85eda81@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Since 6.19 the signature of mm_get_unmapped_area() has one parameter
less. The (previously) first struct mm_struct *mm parameter has been
removed.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 ++++++--
 kernel/cobalt/rtdm/drvlib.c                          | 3 +--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 838085d338b51a4fdd89218aa512de8d60a853a0..baf54dcfe7bb5071a1abea48bd87f471eb938297 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -63,8 +63,12 @@
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,10,0)
-#define mm_get_unmapped_area(__mm, __filp, __addr, __len, __pgoff, __flags) \
-	(__mm)->get_unmapped_area(__filp, __addr, __len, __pgoff, __flags)
+#define mm_get_unmapped_area(__filp, __addr, __len, __pgoff, __flags)          \
+	(current->mm)                                                          \
+		->get_unmapped_area(__filp, __addr, __len, __pgoff, __flags)
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
+#define mm_get_unmapped_area(filp, addr, len, pgoff, flags)                    \
+	mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags)
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(6,16,0)
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 86788743fe47b228662ef16831b4281ddefd04ff..d9de62946611c63728b43ff43543374e6ca8d34c 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1907,8 +1907,7 @@ driver_get_unmapped_area(struct file *filp,
 
 #ifdef CONFIG_MMU
 	/* Run default handler. */
-	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff,
-				    flags);
+	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
 #else
 	return -ENODEV;
 #endif

-- 
2.53.0

