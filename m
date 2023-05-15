Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A3D2E6
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 14:50:26 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202305151450231e49500603971f51eb
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5IdN+MQYGUZOBkjXIyeVXJR3ZfP6ubo5TUGlaP3oSfw=;
 b=PQMbw/nWgRkEMriyhWy1ZZBmOuXAyMFRgXh/WVGLem9Kdlh52C6FyLgdf/4uw7txwDwN2z
 jE4hi5AcUa6iE5UQf4RfqWVDFUziuT1lFk6XW+cjg6gQSapm5c//Z4m8GPrk/aRAd0tMki2U
 YE3S8cDRf6PAegXampjy1b44Zso8g=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 15 May 2023 16:50:04 +0200
Subject: [PATCH v2 04/14] y2038: lib/cobalt: Dispatch timer_settime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v2-4-a12f69d870d7@siemens.com>
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

If libc reports time64_t support, timer_settime is now dispatched
to the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index e3a1e88c2..4a57623c2 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -166,8 +166,13 @@ COBALT_IMPL(int, timer_settime, (timer_t timerid,
 {
 	int ret;
 
-	ret = -XENOMAI_SYSCALL4(sc_cobalt_timer_settime, timerid,
-				flags, value, ovalue);
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timer_settime64;
+#else
+	long sc_nr = sc_cobalt_timer_settime;
+#endif
+
+	ret = -XENOMAI_SYSCALL4(sc_nr, timerid, flags, value, ovalue);
 	if (ret == 0)
 		return 0;
 

-- 
2.39.2

