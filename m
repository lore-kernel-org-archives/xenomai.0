Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CE5810F
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434679; cv=none; b=qVRFl1wMTqgajVxod1HLb3NzFqCgGdQP0P4EVsvSbGIOSJfqQDDk2iqRov4VuPXfmsZMnSWiWQXygGDWoPJlWzaKZ8DlDtUAbektkNMWS7XoUdPvmWxAZFR8nlzKRPoRaNdBSPwJ4bOp8sxPQKJ3ew1d9CMQ9tvUAu8JSSH5S9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434679; c=relaxed/simple;
	bh=KdtDl8jZmAh8yo+8M9GYz9XiSPnwkM7k1dbYLK5ULfs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcN8imuJWMJCbGbpljpmT9LH6jVO238oN8ZpIWYtr68C8wJrF9qroEp7kZN01cHacIxAYw2HVZywg3HpFzM+/hkj8AHjVMVSOIz1wGlQDgYOZ1JAe6d2XXvOCkU43EveKubL8mcSvzit302IaSD6HC0r+OzqXTXNTgvRDLZA0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=BSYxKzrF; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="BSYxKzrF"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240326063106e25977315d00452616
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=W50ZOJN1wkv9IpDMz56mxILYKM/f8sPHNdDYIe6yc9I=;
 b=BSYxKzrFtfWMGAb2YIva06mJR50bfI3H91mx7ejEMK3EIqvz8dMo22Byp/kEfi2wV9U+nB
 IGvAkIgOSmPd69M597ZyQZDQx+ATvzk/9vUYVgh4kVquLfsLyh0+Sn9GRGP0GYEx2n4dq8lk
 Sg20zeOuo5h+xQYOWMwT1DAlK2GW8=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 03/25] cobalt/rtdm: Drop __rtdm_synch_flush from public interface
Date: Tue, 26 Mar 2024 07:30:42 +0100
Message-Id: <8c9a8516e10baae433eb81b898600262d2add8ca.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This was once needed for static-inline wrappers, but those are long
gone. Let's clean up, also fixing missing prototype warnings in kernel
6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/drvlib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 620be27fa5..7378f2c018 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -636,7 +636,7 @@ void rtdm_timer_stop_in_handler(rtdm_timer_t *timer);
 
 #define RTDM_SYNCH_DELETED          XNSYNCH_SPARE0
 
-void __rtdm_synch_flush(struct xnsynch *synch, unsigned long reason)
+static void __rtdm_synch_flush(struct xnsynch *synch, unsigned long reason)
 {
 	spl_t s;
 
@@ -651,8 +651,6 @@ void __rtdm_synch_flush(struct xnsynch *synch, unsigned long reason)
 	xnlock_put_irqrestore(&nklock, s);
 }
 
-EXPORT_SYMBOL_GPL(__rtdm_synch_flush);
-
 /**
  * @ingroup rtdm_driver_interface
  * @defgroup rtdm_sync Synchronisation Services
-- 
2.35.3

