Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED0712B74
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 11:11:35 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202305311111261c7c950fb0f4c7eec3
        for <xenomai@lists.linux.dev>;
        Wed, 31 May 2023 13:11:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LWoZFXlhW4e911sW4TsGnGV+/V32vWPDj8QRmJaZdSQ=;
 b=egHmJYbauvNVyhBr+YrkjNGptW+ohh3bfoT3m1aVVZ0I8UdcUCbx1S6oI0ohX+ulVBxG9H
 +fTJwo5wmfj2KHBUuSNjA4l/qCUn4pWnPDINxhmtk5j8oKXzkJMjCR5grpL88L5ffdvtY2ZB
 Wi7ym9qZ/Z8j0KBWyQIOVH1CoRxOk=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH [REPOST] 2/4] cobalt/registry: Convert export_mutex to real mutex
Date: Wed, 31 May 2023 13:11:24 +0200
Message-Id: <1d69e75ef183f2e1bd156f7fb598e52071c76d63.1685531485.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1685531485.git.jan.kiszka@siemens.com>
References: <cover.1685531485.git.jan.kiszka@siemens.com>
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

