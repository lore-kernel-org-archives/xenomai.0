Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18897D2F3
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 15:00:34 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202305151450244b7959d64b1a9aeac5
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oKx7CP6H/3Om6e4e4tIGGuEjBRxiHzTS3fLOabNImiw=;
 b=i5IBlcRu63sWrOQaq2SBQfFn++m8hGjCRGBB4oESVWx03lOMuNRozDpO3xg/o2QdxObUzw
 DYBVDi3SC9vCb610HU+YUmJYtoZd5KD9KGahQFdndFpM63i62f35Da74CGnBBgd4hqHc7nrX
 Kx/y3+9xuwaHc6Z3uj/UxrzakNbJE=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 15 May 2023 16:50:07 +0200
Subject: [PATCH v2 07/14] y2038: lib/cobalt: Dispatch timer_gettime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v2-7-a12f69d870d7@siemens.com>
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

If glibc reports time64_t support, timer_gettime is now dispatched
to the time64_t based syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/cobalt/timer.c b/lib/cobalt/timer.c
index 4a57623c2..d8955832e 100644
--- a/lib/cobalt/timer.c
+++ b/lib/cobalt/timer.c
@@ -214,7 +214,13 @@ COBALT_IMPL(int, timer_gettime, (timer_t timerid, struct itimerspec *value))
 {
 	int ret;
 
-	ret = -XENOMAI_SYSCALL2(sc_cobalt_timer_gettime, timerid, value);
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_timer_gettime64;
+#else
+	long sc_nr = sc_cobalt_timer_gettime;
+#endif
+
+	ret = -XENOMAI_SYSCALL2(sc_nr, timerid, value);
 	if (ret == 0)
 		return 0;
 

-- 
2.39.2

