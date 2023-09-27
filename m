Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AC34CF7
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 14:31:00 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023092713504238004922858d51a289
        for <xenomai@lists.linux.dev>;
        Wed, 27 Sep 2023 15:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8T4WTAmnBY+F1ECEkNX4WYPmenv3LfeNPtXv5xZVqjI=;
 b=fFP3Juh0M98LbzpIuqhKOVks8l74SJ1SNfH0RlUeyJsfwIPp8JBtViOoSfw7004fpUrOKY
 A9Te3T61ASbek//6Px4GcnoOb3McILYMihE8UESSlRHR4+98gCen3CgnFseVpvpLenq7ka9r
 b5oBskTvtrXyExYs/0vTjpnkh0iCg=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 27 Sep 2023 15:50:16 +0200
Subject: [PATCH v2 3/9] y2038: testsuite/clocktest: Fix reading of
 reference clock
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-florian-y2038-2-v2-3-05f710464d83@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

With y2038 support enabled the wrong syscall was triggered for reading
the reference clock. struct timeval is "auto-converted" to time64_t so
we have to call the time64 based syscall as well.

There is no gettimeofday64 syscall so we have to migrate to
clock_gettime using CLOCK_REALTIME.

Old output:
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.0            0.000          0            0.0
  0   1009065219904768.5     -1000000.000          0            0.0
  0    715530549306452.6     -1000000.000          0            0.0

New output:
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  1.8           -5.803          0            0.0
  1                  0.0            0.000          0            0.0

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/clocktest/clocktest.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testsuite/clocktest/clocktest.c b/testsuite/clocktest/clocktest.c
index c2b9ee5f4..a611ee889 100644
--- a/testsuite/clocktest/clocktest.c
+++ b/testsuite/clocktest/clocktest.c
@@ -80,14 +80,19 @@ static inline uint64_t read_clock(clockid_t clock_id)
 
 static inline uint64_t read_reference_clock(void)
 {
-	struct timeval tv;
+	struct timespec ts;
 
 	/*
 	 * Make sure we do not pick the vsyscall variant. It won't
 	 * switch us into secondary mode and can easily deadlock.
 	 */
-	syscall(SYS_gettimeofday, &tv, NULL);
-	return tv.tv_usec * 1000ULL + tv.tv_sec * 1000000000ULL;
+#if __USE_TIME_BITS64
+	syscall(SYS_clock_gettime64, CLOCK_REALTIME, &ts);
+#else
+	syscall(SYS_clock_gettime, CLOCK_REALTIME, &ts);
+#endif
+
+	return ts.tv_nsec + ts.tv_sec * 1000000000ULL;
 }
 
 static void check_reference(struct per_cpu_data *per_cpu_data)

-- 
2.39.2

