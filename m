Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6129154BD
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:39 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305080813306aae2022e484dea4cc
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UlT6gGRK8DxBxtFpa3ST9pW/MUTeTftkrAaDNp5gLYM=;
 b=L14Umyt+xfGSNw+P24j7dkNurfb8iGmE+djK4MK9PVGkkgihCqaPFaMx+CbYXstbEAZiSj
 5EDGS4HNi2t+4L3nhOPjF35u1xiCUllekPWEmUlEjYzC6SRfbKu/rN4sgQENjdJvz6CydXXf
 ATUOqACDJ5d3YiG+gIZN46wTHYhvw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:34 +0200
Subject: [PATCH 12/13] y2038: lib/cobalt: Dispatch timerfd_gettime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-12-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
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

