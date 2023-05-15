Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F09D537
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 15:00:38 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230515145027c855745b84d7c71620
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UlT6gGRK8DxBxtFpa3ST9pW/MUTeTftkrAaDNp5gLYM=;
 b=fX6omT5mCkmtGljjt4vn5lvv3WNy67EpnEGUk6A0v+kfJyX1EuDMH5qq31L8QCrga05vo0
 VES8vjfeJHmP/goaIhKcRrX626OiZda94Ev2qltACdLE7u4wLJiOyWY37FPxZdr3doLRtm/+
 rV0pGj7n3taIvAtcXkHeVaE0g2yO0=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 15 May 2023 16:50:13 +0200
Subject: [PATCH v2 13/14] y2038: lib/cobalt: Dispatch timerfd_gettime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v2-13-a12f69d870d7@siemens.com>
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

If libc reports time64_t support, timerfd_gettime is now dispatched to
the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timerfd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/timerfd.c b/lib/cobalt/timerfd.c
index a564d5076..c0e64929a 100644
--- a/lib/cobalt/timerfd.c
+++ b/lib/cobalt/timerfd.c
@@ -58,8 +58,14 @@ COBALT_IMPL(int, timerfd_settime,
 COBALT_IMPL(int, timerfd_gettime, (int fd, struct itimerspec *curr_value))
 {
 	int ret;
-	
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_timerfd_gettime, fd, curr_value);
+
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timerfd_gettime64;
+#else
+	long sc_nr = sc_cobalt_timerfd_gettime;
+#endif
+
+	ret = -XENOMAI_SYSCALL2(sc_nr, fd, curr_value);
 	if (ret == 0)
 		return ret;
 	

-- 
2.39.2

