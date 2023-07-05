Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD34138F
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 06:48:37 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230705063828f6a3f94ae3e2e8bb06
        for <xenomai@lists.linux.dev>;
        Wed, 05 Jul 2023 08:38:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=VVHV19W9Lt+N3YQhheRjV8AdlI3wyOuIFHaGABXNfOc=;
 b=S/kspTR0FyKir3So6AdRw8RAjjsirhuzF1r9VdV9nqfNDPgZ84xGNYQkyG6MdEWap9Piff
 l6hpBEEXuMLLVKPPIvLxOsoZ+87qnvqws85Wjpx6qS5nPHmbGyp1IETw18LUNH+8UNA1P0oQ
 V1t4hKgd9n5XtccVC62kgOfNplukI=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 05 Jul 2023 08:38:32 +0200
Subject: [PATCH 10/12] y2038: testsuite/smokey/y2038: Fix a race in the
 pselect interruption test
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230630-florian-y2038-part-four-upstreaming-v1-10-604a089542c2@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

It might have happened that the signal was sent and handled before
we reached the blocking point inside the pselect syscall. Adding
another synchronization point right before the context switch should
fix that.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index ab7c3bb4c..0ee0bc48c 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -124,6 +124,7 @@ static inline bool ts_less(const struct xn_timespec64 *a,
 struct thread_context {
 	int sc_nr;
 	int sock;
+	sem_t *sem;
 	pthread_mutex_t *mutex;
 	struct xn_timespec64 *ts;
 	bool timedwait_timecheck;
@@ -1472,6 +1473,7 @@ static void *pselect64_waiting_thread(void *arg)
 	/* Waiting for 1sec should be enough to get a signal */
 	ts.tv_sec = 1;
 	ts.tv_nsec = 0;
+	sem_post(ctx->sem);
 	ret = XENOMAI_SYSCALL5(ctx->sc_nr, sock + 1, &rfds, NULL, NULL, &ts);
 	if (!smokey_assert(ret == -EINTR)) {
 		ret = ret ?: -EINVAL;
@@ -1494,6 +1496,7 @@ static int test_pselect64_interruption(void)
 	struct thread_context ctx = { 0 };
 	void *w_ret = NULL;
 	pthread_t w;
+	sem_t sem;
 	int sock;
 	int ret;
 
@@ -1505,14 +1508,22 @@ static int test_pselect64_interruption(void)
 	if (sock < 0)
 		return sock;
 
+	ret = smokey_check_errno(sem_init(&sem, 0, 0));
+	if (ret)
+		return ret;
+
 	ctx.sock = sock;
 	ctx.sc_nr = sc_cobalt_pselect64;
+	ctx.sem = &sem;
 
 	ret = smokey_check_status(
 		pthread_create(&w, NULL, pselect64_waiting_thread, &ctx));
 	if (ret)
 		goto out_sock;
 
+	/* Wait for the waiting thread to be ready */
+	sem_wait(&sem);
+
 	/* Allow the waiting thread to enter the pselect64() syscall */
 	nanosleep(&ts, NULL);
 
@@ -1528,6 +1539,7 @@ static int test_pselect64_interruption(void)
 		w_ret = NULL;
 
 out_sock:
+	sem_destroy(&sem);
 	close(sock);
 	return (int)(long)w_ret;
 }

-- 
2.39.2

