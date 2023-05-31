Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE9C2E0
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:03:29 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id DD9E9100006
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:03:21 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DA053D8065F
	for <xenomai@xenomai.org>; Wed, 31 May 2023 11:03:20 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230531110320a867b2e4829dcbf405
        for <xenomai@xenomai.org>;
        Wed, 31 May 2023 13:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LWoZFXlhW4e911sW4TsGnGV+/V32vWPDj8QRmJaZdSQ=;
 b=A7TCGysww2gkPrIFSw+XRxdRj8p5FsBGYSGRWKY4tB59SIeOPcnBoyOUMKfTs9dt7nU/Ht
 fOJd+GCgpVI57qmhQxIuUoUrNJs5K4UZZoe1kGC6EKEKaNxXbDfB+roTWWf1P5biIYCWFZBl
 4A4RzDmPX3vRzAwEza5qdYtF4mBLc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 2/4] cobalt/registry: Convert export_mutex to real mutex
Date: Wed, 31 May 2023 13:03:12 +0200
Message-Id: <1d69e75ef183f2e1bd156f7fb598e52071c76d63.1685530994.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1685530994.git.jan.kiszka@siemens.com>
References: <cover.1685530994.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool5: domain of rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) client-ip=185.136.64.226; envelope-from=fm-294854-20230531110320a867b2e4829dcbf405-wFv_wY@rts-flowmailer.siemens.com; helo=mta-64-226.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=A7TCGysw;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20230531110320a867b2e4829dcbf405-wFv_wY@rts-flowmailer.siemens.com designates 185.136.64.226 as permitted sender) smtp.mailfrom=fm-294854-20230531110320a867b2e4829dcbf405-wFv_wY@rts-flowmailer.siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

A semaphore is semantically not a mutex, plus there are now changes in
its definition in 6.4. Therefore, just convert the export_mutex to a
real one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/registry.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
index 211e0f76f0..02f4ebbbae 100644
--- a/kernel/cobalt/registry.c
+++ b/kernel/cobalt/registry.c
@@ -16,6 +16,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
@@ -209,7 +210,7 @@ void xnregistry_cleanup(void)
 
 #ifdef CONFIG_XENO_OPT_VFILE
 
-static DEFINE_SEMAPHORE(export_mutex);
+static DEFINE_MUTEX(export_mutex);
 
 /*
  * The following stuff implements the mechanism for delegating
@@ -232,7 +233,7 @@ static void proc_callback(struct work_struct *work)
 	int ret;
 	spl_t s;
 
-	down(&export_mutex);
+	mutex_lock(&export_mutex);
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -324,7 +325,7 @@ static void proc_callback(struct work_struct *work)
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	up(&export_mutex);
+	mutex_unlock(&export_mutex);
 }
 
 static irqreturn_t registry_proc_schedule(int virq, void *dev_id)
-- 
2.35.3

