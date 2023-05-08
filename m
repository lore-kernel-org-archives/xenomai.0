Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1CD168A9
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:37 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230508081326a25bcb66090d3093b4
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5IdN+MQYGUZOBkjXIyeVXJR3ZfP6ubo5TUGlaP3oSfw=;
 b=ZBW6o7OADp7/QFlH3N0j/in9croe9tPyygE+P18KTrrb1sITmU/gt4c2ekwx9NquHfxDxN
 lfRPj2lwBt0d3Zawk/6oImwdH9dxoHLlUQ3kwokpvF/kLUNd8OczfKcgJFekXLt2sB4T4mCz
 a0SRDcNT+YVf+8+sG/gh/KV+9vHIo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:25 +0200
Subject: [PATCH 03/13] y2038: lib/cobalt: Dispatch timer_settime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-3-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
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

