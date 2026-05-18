Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCE3E4C71
	for <xenomai@lists.linux.dev>; Mon, 18 May 2026 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094973; cv=none; b=Qk0JKcwuC0x+SoWDrvLJMW0+XhIbPFaEgE6DAZOcTrMBVhEX0H4433m22PZPHLGY6AcCUlgVUmCKBtqAYmnrtZuVHt9AB+qXWNtb6AoiR5TAwW2hjBHHmjBaCws0xo/FOZ6k+LdjJGSEg3q4xGxxJU9/BQRXwlrO9JXKZHkUqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094973; c=relaxed/simple;
	bh=fDNAX73K6jtjaXG07+ImHRc2H6lfVVVAQI1G38GrJV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQ4cjbES0mHTnQI5N2okISojhZjukvV4yLaEmHFEn/Utqw/4j3fxESdhB2Mi44HmgknpOpq/XzqSGCafCMQsy7aULKdyvfNKkNHqD+juE7NfBGWk6c77hvD1odYTn6oO//OqHunRS78yPCdBv+H+gMhgxG128sDMyvZJzwzW99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=fjo7b/Fh; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="fjo7b/Fh"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202605180902444ed7939c1300020744
        for <xenomai@lists.linux.dev>;
        Mon, 18 May 2026 11:02:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VN2hra6s8sVCpeq87NUQYInVqit9F0d3iFhsc+l4BfM=;
 b=fjo7b/FhPjpYvr+PZSQ10tvsRLa6bgX6mrezHN6NjbDO9+Omdp+rBCt4pRK35fzjw78LFo
 jrOq0uBZd/6tQu0naToadyIS5nMXEj8m6yJufe7SPr1dWUvoxWdHUJj2HzedFhuO5CebwzHJ
 MP+Grjym7owim5vDPKL7Nx27/RYEaokpjpMqz/gCNs6vzSCEgc/tli7tqfPZXqLCYnt73cbO
 7sgGtfEsUdEj1acQlSyRhYZsrgZpmcK9AhZZH6izKuD6vcaHyJqlk7l6NbQAjaUJYXDZzbz8
 8SVmMIqgoNqMfIO1dGVQPALdu1j9yg9ZqYz2annfJ9jJJ0jaLapbnHWg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 18 May 2026 11:02:44 +0200
Subject: [PATCH v2 3/4] testsuite/smokey/vxworktests: Fix compile error
 seen with gcc 16
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-wip-flo-gcc-16-v2-3-f93562624fb4@siemens.com>
References: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
In-Reply-To: <20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fixes the following error:

task-2.c: In function ‘backgroundTask’:
task-2.c:26:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
   26 |         unsigned int safety = 100000000, count = 0;
      |                                          ^~~~~
cc1: all warnings being treated as errors

The busy waiting loop - to my understanding - is keeping the background
task alive, so that the foreground task is able to call taskSuspend()
for the background task.

As the background task is calling safe_pause(), the task will wait
for the termination signal anyhow, so busy waiting upfront is not
necessary.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/vxworkstests/task-2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 0cbb9e18a13383418c4360241ef244b8a24da975..60462e64ea7b2b4ddc810f336eea906cf6ca8c8f 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -23,7 +23,6 @@ static SEM_ID sem_id, fdone_sem_id;
 
 static void backgroundTask(long arg, ...)
 {
-	unsigned int safety = 100000000, count = 0;
 	int ret;
 
 	traceobj_enter(&trobj);
@@ -35,9 +34,6 @@ static void backgroundTask(long arg, ...)
 
 	traceobj_mark(&trobj, 2);
 
-	while (--safety > 0)
-		count++;
-
 	/*
 	 * Enter infinite pause so that any pending cancellation is
 	 * taken regardless of whether async-cancel is enabled or not.

-- 
2.54.0

