Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB604C8C
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:12 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230505072104fc2330f941039ebf73
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hHCVNN/dXlFh1eywQJNNUmYkd4RnnQmKGGIhKcLzYKw=;
 b=qRPaI8GI9rtGTcFJnauM/7PafBDTmbJMKKFBPSPA6+boAQa0i1iClQ4mjVl4IR7YPMNBVx
 dSF/q0UVRl8GKbang8OX8DBiH7jBaBuXoSe6MDknmHtLnI49ldxsxGwJ5l/zdjsVG8opjXGc
 tSWtyga6l3rW03j8leAV16tOE4vWo=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:08 +0200
Subject: [PATCH 13/17] y2038: posix/mq: Fix mq_timedsend syscall routing
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-13-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

The sc_cobalt_mq_timedsend syscall was used twice, once for the
mq_timedsend service and once for the mq_send service which re-uses the
same cobalt service without supplying a timeout.

The mq_timedsend case - which actually counts y2038 wise - has been
overlooked by Song when introducing y2038 support for some reason.

Both services fall back to the same helper now, so we can handle them
the same way.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/mq.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index a8c88b406..88a74095b 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -289,6 +289,18 @@ COBALT_IMPL(int, mq_setattr, (mqd_t mqd,
 	return -1;
 }
 
+static inline int __do_mq_timesend(mqd_t q, const char *buffer, size_t len,
+				   unsigned int prio, const struct timespec *to)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_mq_timedsend64;
+#else
+	long sc_nr = sc_cobalt_mq_timedsend;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, to);
+}
+
 /**
  * Send a message to a message queue.
  *
@@ -332,13 +344,7 @@ COBALT_IMPL(int, mq_send, (mqd_t q, const char *buffer, size_t len, unsigned pri
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-#ifdef __USE_TIME_BITS64
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend64,
-			       q, buffer, len, prio, NULL);
-#else
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend,
-			       q, buffer, len, prio, NULL);
-#endif
+	err = __do_mq_timesend(q, buffer, len, prio, NULL);
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -397,8 +403,7 @@ COBALT_IMPL(int, mq_timedsend, (mqd_t q,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedsend,
-			       q, buffer, len, prio, timeout);
+	err = __do_mq_timesend(q, buffer, len, prio, timeout);
 
 	pthread_setcanceltype(oldtype, NULL);
 

-- 
2.39.2

