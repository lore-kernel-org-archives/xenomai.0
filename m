Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EA19924
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 19:07:19 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230530185706def5f173721e01bb94
        for <xenomai@lists.linux.dev>;
        Tue, 30 May 2023 20:57:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Au/ftp7JZtQB2vTLWYIlh2wZ3JZ2b+iIVrj5WIcBiEM=;
 b=JdkvjxvZHI7NrpTe2nHna1oB3Y10qpCQgeuxtYP3SFA9jRxYo2NCv7ITlDakoGqPIvWyB4
 GncYmXwRpaRwbvYYLHw9q8pq0A6zonZLNlxyBKfgC9iiFZbaestYrN9KGAuiFXQ6JwiBkhot
 FBDHgparhv87xCsrnV7PIol7rcnro=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 30 May 2023 20:57:07 +0200
Subject: [PATCH v3 4/4] cobalt/posix/select: Fix timeout update in case of
 -EINTR
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-florian-y2038-part-three-v3-4-ecb4d58538d7@siemens.com>
References: <20230516-florian-y2038-part-three-v3-0-ecb4d58538d7@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v3-0-ecb4d58538d7@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

When the select() syscall was interrupted (e.g. for handling a Linux
signal) the supplied timeout has not been updated. __cobalt_select()
bailed out too early.

This is not a critical thing as the manpage states:
  On  Linux,  select()  modifies timeout to reflect the amount of time
  not slept; most other implementations do not do this.  (POSIX.1
  permits either behavior.)

  This causes problems both when Linux code
  which reads timeout is ported to other operating systems, and when
  code is ported to Linux that reuses a struct timeval for multiple
  select()s in a loop without reinitializing it.  Consider timeout to
  be undefined after select() returns."

The Xenomai select() implementation is now aligned with Linux.

The testsuite has been improved to cover this case as well.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/posix/io.c               | 18 +++----
 testsuite/smokey/y2038/syscall-tests.c | 94 +++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 10 deletions(-)

diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index f8e1b91c3..9e6f3edfa 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -319,6 +319,15 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 		}
 	} while (err == -ECHRNG);
 
+out:
+	if (to && (err > 0 || err == -EINTR)) {
+		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
+		if (diff > 0)
+			ticks2ts64(to, diff);
+		else
+			to->tv_sec = to->tv_nsec = 0;
+	}
+
 	if (err == -EINTR && signal_pending(current)) {
 		xnthread_set_localinfo(curr, XNSYSRST);
 
@@ -329,15 +338,6 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 		return -ERESTARTSYS;
 	}
 
-out:
-	if (to && (err > 0 || err == -EINTR)) {
-		xnsticks_t diff = timeout - clock_get_ticks(CLOCK_MONOTONIC);
-		if (diff > 0)
-			ticks2ts64(to, diff);
-		else
-			to->tv_sec = to->tv_nsec = 0;
-	}
-
 	if (err >= 0)
 		for (i = 0; i < XNSELECT_MAX_TYPES; i++) {
 			if (!ufd_sets[i])
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index d1e1f46bf..af27f2bce 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -123,6 +123,7 @@ static inline bool ts_less(const struct xn_timespec64 *a,
  */
 struct thread_context {
 	int sc_nr;
+	int sock;
 	pthread_mutex_t *mutex;
 	struct xn_timespec64 *ts;
 	bool timedwait_timecheck;
@@ -1443,6 +1444,94 @@ out:
 	return ret;
 }
 
+static void pselect64_sig_handler(int sig)
+{
+	smokey_trace("pselect64: signal received");
+}
+
+static void *pselect64_waiting_thread(void *arg)
+{
+	struct thread_context *ctx = (struct thread_context *)arg;
+	struct xn_timespec64 ts;
+	int sock = ctx->sock;
+	struct sigaction sa;
+	fd_set rfds;
+	int ret;
+
+	FD_ZERO(&rfds);
+	FD_SET(ctx->sock, &rfds);
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_handler = pselect64_sig_handler;
+
+	ret = smokey_check_errno(sigaction(SIGUSR1, &sa, NULL));
+	if (ret)
+		goto out;
+
+	/* Waiting for 1sec should be enough to get a signal */
+	ts.tv_sec = 1;
+	ts.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL5(ctx->sc_nr, sock + 1, &rfds, NULL, NULL, &ts);
+	if (!smokey_assert(ret == -EINTR)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* The remaining timeout has to be less than 1 sec */
+	if (!smokey_assert(ts.tv_sec == 0 && ts.tv_nsec > 0)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+out:
+	return (void *)(long)ret;
+}
+
+static int test_pselect64_interruption(void)
+{
+	struct timespec ts = { .tv_sec = 0, .tv_nsec = 100000 };
+	struct thread_context ctx = { 0 };
+	void *w_ret = NULL;
+	pthread_t w;
+	int sock;
+	int ret;
+
+	sock = smokey_check_errno(socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP));
+	if (sock == -EAFNOSUPPORT) {
+		smokey_note("pselect64: skipped timeout write back test");
+		return 0;
+	}
+	if (sock < 0)
+		return sock;
+
+	ctx.sock = sock;
+	ctx.sc_nr = sc_cobalt_pselect64;
+
+	ret = smokey_check_status(
+		pthread_create(&w, NULL, pselect64_waiting_thread, &ctx));
+	if (ret)
+		goto out_sock;
+
+	/* Allow the waiting thread to enter the pselect64() syscall */
+	nanosleep(&ts, NULL);
+
+	/* Send a signal to interrupt the syscall and trigger -EINTR */
+	__STD(pthread_kill(w, SIGUSR1));
+
+	ret = smokey_check_status(pthread_join(w, &w_ret));
+	if (ret)
+		goto out_sock;
+
+	ret = smokey_assert((long)w_ret == -EINTR);
+	if (ret)
+		w_ret = NULL;
+
+out_sock:
+	close(sock);
+	return (int)(long)w_ret;
+}
+
 static int test_sc_cobalt_pselect64(void)
 {
 	long sc_nr = sc_cobalt_pselect64;
@@ -1506,7 +1595,10 @@ static int test_sc_cobalt_pselect64(void)
 			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
 
 out:
-	return ret;
+	if (ret)
+		return ret;
+
+	return test_pselect64_interruption();
 }
 
 static int check_kernel_version(void)

-- 
2.39.2

