Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E553C2B
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:07 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230903150459eb18a8b54e2055978e
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:04:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=7uJ33nsEwnw0jNsxjarna90lfeLDu5pfB2B4fAYg0SA=;
 b=ZbvHyWfEBqkuetuEMJ9H7hKizeHPe6644zqEylOF3BAVADGreqh4eIwl7GopoiYkVHQ2j2
 UJ0LZCpUtwmto534Gwn9xljibVCaUnMy/H27I9Hd7GZs9VcvedXemxs4u8ySh7ihm888oMLk
 iyb6tz43N4avL/VISG3q/2ghwQpf4=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 02/20] drivers/udd: Drop self element from irqswitch_work
Date: Sun,  3 Sep 2023 17:04:39 +0200
Message-Id: <d309531113bb7054ee0c3eebdecb751289307205.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
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

This was only needed for I-pipe which was dropped.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/udd/udd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index 958208ec7e..b1efcebd0f 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -520,7 +520,6 @@ struct irqswitch_work {
 	rtdm_irq_t *irqh;
 	int enabled;
 	rtdm_event_t *done;
-	struct irqswitch_work *self; /* Revisit: I-pipe requirement */
 };
 
 static void lostage_irqswitch_line(struct pipeline_inband_work *inband_work)
@@ -540,7 +539,7 @@ static void lostage_irqswitch_line(struct pipeline_inband_work *inband_work)
 	if (rq->done)
 		rtdm_event_signal(rq->done);
 
-	xnfree(rq->self);
+	xnfree(rq);
 }
 
 static void switch_irq_line(rtdm_irq_t *irqh, int enable, rtdm_event_t *done)
@@ -556,7 +555,6 @@ static void switch_irq_line(rtdm_irq_t *irqh, int enable, rtdm_event_t *done)
 	rq->irqh = irqh;
 	rq->enabled = enable;
 	rq->done = done;
-	rq->self = rq;	/* Revisit: I-pipe requirement */
 
 	/*
 	 * Not pretty, but we may not traverse the kernel code for
-- 
2.35.3

