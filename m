Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F04C84
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 07:21:07 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023050507210565417c17452c38bb1d
        for <xenomai@lists.linux.dev>;
        Fri, 05 May 2023 09:21:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=IxJMIeJY3txSNfcgC1lzGKRmB33hOCz8NN/UlhzE1WQ=;
 b=o+C7Mi3v/u1RQ4RnLeBqZgusQKPfb1Qb9CcEzZZyh6iCGTNaebxG4ekb3H+sk3NWxZxyXV
 /FVOdreqcmKobSOcjNS30njB9M2mJSruOpoamVzXp/sRY+0rKDeLk+h9Nao9DeV0g1LsISYP
 NoZ3VF8hlyBsx7ieTyJIBXm8h8Jnw=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 05 May 2023 09:21:09 +0200
Subject: [PATCH 14/17] y2038: posix/mq: Harmonize mq_receive and
 mq_timedreceive
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230428-florian-y2038-part-one-v1-14-64a972ff2189@siemens.com>
References: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
In-Reply-To: <20230428-florian-y2038-part-one-v1-0-64a972ff2189@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Let both callers of the cobalt_mq_timedcreceive service care about
y2038 safety. The old code was correct but confusing. The mq_receive
service is not y2038 affected because it does not forward a timeout,
but it still calls the same service.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/mq.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/lib/cobalt/mq.c b/lib/cobalt/mq.c
index 88a74095b..365a28e7a 100644
--- a/lib/cobalt/mq.c
+++ b/lib/cobalt/mq.c
@@ -414,6 +414,19 @@ COBALT_IMPL(int, mq_timedsend, (mqd_t q,
 	return -1;
 }
 
+static inline int __do_mq_timedreceive(mqd_t q, char *buffer, ssize_t *len,
+				       unsigned int *prio,
+				       const struct timespec *timeout)
+{
+#ifdef __USE_TIME_BITS64
+	long sc_nr = sc_cobalt_mq_timedreceive64;
+#else
+	long sc_nr = sc_cobalt_mq_timedreceive;
+#endif
+
+	return XENOMAI_SYSCALL5(sc_nr, q, buffer, len, prio, timeout);
+}
+
 /**
  * Receive a message from a message queue.
  *
@@ -461,8 +474,7 @@ COBALT_IMPL(ssize_t, mq_receive, (mqd_t q, char *buffer, size_t len, unsigned *p
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedreceive,
-			       q, buffer, &rlen, prio, NULL);
+	err = __do_mq_timedreceive(q, buffer, &rlen, prio, NULL);
 
 	pthread_setcanceltype(oldtype, NULL);
 
@@ -526,13 +538,7 @@ COBALT_IMPL(ssize_t, mq_timedreceive, (mqd_t q,
 
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
 
-#ifdef __USE_TIME_BITS64
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedreceive64,
-			       q, buffer, &rlen, prio, timeout);
-#else
-	err = XENOMAI_SYSCALL5(sc_cobalt_mq_timedreceive,
-			       q, buffer, &rlen, prio, timeout);
-#endif
+	err = __do_mq_timedreceive(q, buffer, &rlen, prio, timeout);
 
 	pthread_setcanceltype(oldtype, NULL);
 

-- 
2.39.2

