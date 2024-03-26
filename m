Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DF839E4
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434681; cv=none; b=fDMFmNGNUL2K0mATO0Ujcu+6IJalu7TRQ3oWKtOyknVNavReAJtih1uOTtJzgLfIEsfe2o6P8BaTsQA+AaP1/qMvWtBLBM2ZeErIabV3sCXClfobpYqmnARlmi6yeQP8MA/yWvnB/J6kiakyZOmBkcRLJVikWQ7RMv3O1zBO21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434681; c=relaxed/simple;
	bh=dpSTFYxHLnrFPo+8Ri3ZaVWUYEWUFnPhTqgt1lcs3/4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIkAN9Mhf3QmWyBZL5pZKDCQDM2sXb7QZdDvFstXMxSsro6XeTXY5d6Af8br2LPcd1Vli+G/ghqTgxWqabOJmAkquHPfJ5ZR/fBLhayDe7vmYS32n/QTc/Z6B6fAwkAav2r6/3Dqo9+L8kbRNpGa16+8/e6gNkjJH0EXBRGtlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=qNRW+D/E; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="qNRW+D/E"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240326063108e8fb1f73842ea18728
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=GzeInxARjavZ47xUEDgtftWWOgp3Bh5mQPA43hO/GTM=;
 b=qNRW+D/E5jTwiqrJyQB5q7nYzKZkya9TVwxS1S18seoPgm/1LvEWbIQAPlEK0ATZxtIxkt
 S+GQE+g/rrxTGuacA8vfsRYs2vtSxa3XUnYCD3808qp1/Y2XzQSgtoT62E/VPQnn19XsbX9z
 //LBecFWU3ssycts26B9fa+LMZvR8=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 11/25] drivers/can/corectl: Provide proper prototypes via corectl.h
Date: Tue, 26 Mar 2024 07:30:50 +0100
Message-Id: <0d62a3af2111324d5c8b31cfe07d4dadb3f1de43.1711434664.git.jan.kiszka@siemens.com>
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

Addresses missing prototype warnings with kernel 6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/corectl.c      | 1 +
 kernel/drivers/can/corectl.h      | 7 +++++++
 kernel/drivers/can/rtcan_module.c | 5 ++---
 3 files changed, 10 insertions(+), 3 deletions(-)
 create mode 100644 kernel/drivers/can/corectl.h

diff --git a/kernel/drivers/can/corectl.c b/kernel/drivers/can/corectl.c
index 73ae34b389..16d695d284 100644
--- a/kernel/drivers/can/corectl.c
+++ b/kernel/drivers/can/corectl.c
@@ -5,6 +5,7 @@
 
 #include <asm/xenomai/syscall.h>
 #include <xenomai/posix/corectl.h>
+#include "corectl.h"
 
 static int rtcan_corectl_call(struct notifier_block *self, unsigned long arg,
 			      void *cookie)
diff --git a/kernel/drivers/can/corectl.h b/kernel/drivers/can/corectl.h
new file mode 100644
index 0000000000..295b485f84
--- /dev/null
+++ b/kernel/drivers/can/corectl.h
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021, Dario Binacchi <dariobin@libero.it>
+ */
+
+void rtcan_corectl_register(void);
+void rtcan_corectl_unregister(void);
diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 81fdc7ffea..82f96d7ef7 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -33,10 +33,9 @@
 #include <rtcan_dev.h>
 #include <rtcan_raw.h>
 
-MODULE_LICENSE("GPL");
+#include "corectl.h"
 
-void rtcan_corectl_register(void);
-void rtcan_corectl_unregister(void);
+MODULE_LICENSE("GPL");
 
 const char rtcan_rtdm_provider_name[] =
     "(C) 2006 RT-Socket-CAN Development Team";
-- 
2.35.3

