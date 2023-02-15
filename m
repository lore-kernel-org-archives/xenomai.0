Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E3F53BB
	for <xenomai@lists.linux.dev>; Wed, 15 Feb 2023 14:04:31 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230215140423f857ce9d0318eb103e
        for <xenomai@lists.linux.dev>;
        Wed, 15 Feb 2023 15:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=rjHddW65g6lhgzLiMrlEOeOACNmdh02b0qoFtKwcdFU=;
 b=o93quIDC/HhX0nfPN6lYmpfWn2itGntj1NN+S/cPV9ILRc2m+Xc5SkJZdYF/pxY/ETtMQo
 3hr+k+7GeG3ZdoITHAv5mhgJ/7PqZTh7abVgptjXUWhT0WevMmSYblTchvP63RfXqoPPMD9l
 lFSFQ+CUgOUbOHbDv4eXtkAhXI60E=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] testsuite/smokey/sched-quota: Allow building with gcc 12
Date: Wed, 15 Feb 2023 15:04:22 +0100
Message-Id: <20230215140422.1980192-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The build wich gcc 12 failed with two overflow warnings. gcc is more strict
in checking specifier overflows now.

In this case %d alone would require up to 10 characters but only 8 where
available.

The warning:

sched-quota.c: In function ‘calibrate’:
sched-quota.c:244:34: error: ‘%d’ directive writing between 1 and 10 bytes into a region of size 7 [-Werror=format-overflow=]
  244 |                 sprintf(label, "t%d", n);
      |                                  ^~
sched-quota.c:244:32: note: directive argument in the range [0, 2147483646]
  244 |                 sprintf(label, "t%d", n);
      |                                ^~~~~
sched-quota.c:244:17: note: ‘sprintf’ output between 3 and 12 bytes into a destination of size 8
  244 |                 sprintf(label, "t%d", n);

Fixed by migrating to snprintf and adding a limit to the actual buffer
size.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Hi all,

this patch can be applied to the following (stable) branches:
 - next
 - stable/v3.0.x
 - stable/v3.1.x
 - stable/v3.2.x

It allows to use gcc 12 (coming with Debian 12) as compiler for the
Xenomai code base.

Best regards,
Florian

 testsuite/smokey/sched-quota/sched-quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index acb9055fd..093f7db43 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -184,7 +184,7 @@ static double run_quota(int quota)
 		     tgid, cf.quota.info.quota_sum);
 
 	for (n = 0; n < nrthreads; n++) {
-		sprintf(label, "t%d", n);
+		snprintf(label, sizeof(label), "t%d", n);
 		create_quota_thread(threads[n], label, tgid, counts[n]);
 		sem_wait(&ready);
 	}
@@ -241,7 +241,7 @@ static unsigned long long calibrate(void)
 	crunch_per_sec = (unsigned long long)((double)ONE_BILLION / (double)ns * crunch_loops);
 
 	for (n = 0; n < nrthreads; n++) {
-		sprintf(label, "t%d", n);
+		snprintf(label, sizeof(label), "t%d", n);
 		create_fifo_thread(threads[n], label, counts[n]);
 		sem_wait(&ready);
 	}
-- 
2.39.1

