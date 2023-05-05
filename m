Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144F4C7D
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:07 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202305050721077705c877f005db28a0
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+ntWWqw5+OT2/Gt7V4bCHaIowygiuxuNp12gNbAd+Z8=;
 b=bAa+8RE3NrmCf20nZPszX91bpG0Rk2ayFeiu+GURZf4HadRYXP02GCewdqQzZWJU/EqK5N
 kmjfUlLgggGFTvpU6E/uScTqUdvTRvoLx5dyMpJECMbeIjyrzUJKdjEMc6zEgAKbVB6g5NO8
 ySHIRb69hxZT1Dfnx57Ko18bqeHZY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:12 +0200
Subject: [PATCH 17/17] y2038: Prepare code base for 64bit time_t
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-17-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Compiling the Xenomai code base with CFLAGS set to
"-D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64" - which is the requirement for
y2038 safety on 32 bit platforms - failed. We had some problems with
printf format specifiers which are now too small when time_t is lifted
to 64 bit.

Casting to (long long) should do it on all platforms we support.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 demo/alchemy/altency.c      | 26 +++++++++++++-------------
 testsuite/latency/latency.c | 34 ++++++++++++++++++----------------
 testsuite/spitest/spitest.c |  6 ++++--
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
index e7c31d7c1..b15930567 100644
--- a/demo/alchemy/altency.c
+++ b/demo/alchemy/altency.c
@@ -258,12 +258,12 @@ static void display(void *cookie)
 				time_t now, dt;
 				time(&now);
 				dt = now - start - WARMUP_TIME;
-				printf
-				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
-				     "priority %d)\n", dt / 3600,
-				     (dt / 60) % 60, dt % 60,
-				     test_mode_names[test_mode],
-				     period_ns / 1000, priority);
+				printf("RTT|  %.2lld:%.2lld:%.2lld  (%s, %lld us period, priority %d)\n",
+				       (long long)(dt / 3600),
+				       (long long)((dt / 60) % 60),
+				       (long long)(dt % 60),
+				       test_mode_names[test_mode],
+				       period_ns / 1000, priority);
 				printf("RTH|%11s|%11s|%11s|%8s|%6s|%11s|%11s\n",
 				       "----lat min", "----lat avg",
 				       "----lat max", "-overrun", "---msw",
@@ -413,13 +413,13 @@ static void cleanup(void)
 	if (!test_duration)
 		test_duration = actual_duration;
 
-	printf
-	    ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
-	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
-	     (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
-	     goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
-	     actual_duration % 60, test_duration / 3600,
-	     (test_duration / 60) % 60, test_duration % 60);
+	printf("---|-----------|-----------|-----------|--------|------|-------------------------\n"
+	       "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2lld:%.2lld:%.2lld/%.2d:%.2d:%.2d\n",
+	       (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
+	       goverrun, max_relaxed, (long long)(actual_duration / 3600),
+	       (long long)((actual_duration / 60) % 60),
+	       (long long)(actual_duration % 60), test_duration / 3600,
+	       (test_duration / 60) % 60, test_duration % 60);
 	if (max_relaxed > 0)
 		printf(
 "Warning! some latency peaks may have been due to involuntary mode switches.\n"
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index 6cd3a28b4..7856b48b8 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -322,12 +322,12 @@ static void *display(void *cookie)
 				time_t now, dt;
 				time(&now);
 				dt = now - start - WARMUP_TIME;
-				printf
-				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
-				     "priority %d)\n", dt / 3600,
-				     (dt / 60) % 60, dt % 60,
-				     test_mode_names[test_mode],
-				     period_ns / 1000, priority);
+				printf("RTT|  %.2lld:%.2lld:%.2lld  (%s, %lld us period, priority %d)\n",
+				       (long long)(dt / 3600),
+				       (long long)((dt / 60) % 60),
+				       (long long)(dt % 60),
+				       test_mode_names[test_mode],
+				       period_ns / 1000, priority);
 				printf("RTH|%11s|%11s|%11s|%8s|%6s|%11s|%11s\n",
 				       "----lat min", "----lat avg",
 				       "----lat max", "-overrun", "---msw",
@@ -386,9 +386,10 @@ static void dump_histo_gnuplot(int32_t *histogram, time_t duration)
 			return;
 	}
 
-	fprintf(ofp, "# %.2ld:%.2ld:%.2ld (%s, %Ld us period, priority %d)\n",
-		duration / 3600, (duration / 60) % 60, duration % 60,
-		test_mode_names[test_mode],
+	fprintf(ofp,
+		"# %.2lld:%.2lld:%.2lld (%s, %lld us period, priority %d)\n",
+		(long long)duration / 3600, (long long)((duration / 60) % 60),
+		(long long)(duration % 60), test_mode_names[test_mode],
 		period_ns / 1000, priority);
 	fprintf(ofp, "# %11s|%11s|%11s|%8s|%6s|\n",
 		"----lat min", "----lat avg",
@@ -515,13 +516,14 @@ static void cleanup(void)
 	if (need_histo())
 		dump_hist_stats(actual_duration);
 
-	printf
-	    ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
-	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
-	     (double)gminjitter / 1000, (double)gavgjitter / 1000, (double)gmaxjitter / 1000,
-	     goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
-	     actual_duration % 60, test_duration / 3600,
-	     (test_duration / 60) % 60, test_duration % 60);
+	printf("---|-----------|-----------|-----------|--------|------|-------------------------\n"
+	       "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2lld:%.2lld:%.2lld/%.2d:%.2d:%.2d\n",
+	       (double)gminjitter / 1000, (double)gavgjitter / 1000,
+	       (double)gmaxjitter / 1000, goverrun, max_relaxed,
+	       (long long)(actual_duration / 3600),
+	       (long long)((actual_duration / 60) % 60),
+	       (long long)(actual_duration % 60), test_duration / 3600,
+	       (test_duration / 60) % 60, test_duration % 60);
 	if (max_relaxed > 0)
 		printf(
 "Warning! some latency peaks may have been due to involuntary mode switches.\n"
diff --git a/testsuite/spitest/spitest.c b/testsuite/spitest/spitest.c
index 6163e54bf..99d609403 100644
--- a/testsuite/spitest/spitest.c
+++ b/testsuite/spitest/spitest.c
@@ -233,8 +233,10 @@ static void *display_thread(void *arg)
 		if (data_lines && (n++ % data_lines) == 0) {
 			time(&now);
 			dt = now - start;
-			printf("RTT|  %.2ld:%.2ld:%.2ld  (%Ld us period)\n",
-			       dt / 3600, (dt / 60) % 60, dt % 60,
+			printf("RTT|  %.2lld:%.2lld:%.2lld  (%lld us period)\n",
+			       (long long)(dt / 3600),
+			       (long long)((dt / 60) % 60),
+			       (long long)(dt % 60),
 			       (long long)period_ns / 1000);
 			printf("RTH|%11s|%11s|%11s|%8s|%8s|%11s|%11s\n",
 			       "----lat min", "----lat avg",

-- 
2.39.2

