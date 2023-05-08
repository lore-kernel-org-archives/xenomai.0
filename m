Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5497168A5
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:36 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202305080813273572da74b2a4f3aa03
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dI7+rCqSIZGzNDpZ2DQhpS8ENiieubU1nHaWgrQ2sbo=;
 b=YiwL6CAALaxs58+jc4rfmfSgzjWfecsAHArlRQ8P+GTpp5NgX8KQrIDcBgb52YyTPFWcBW
 lxwXKQk3AmSffIHL3RP402A4CTE+3lnaZiK+dOT5uEyUVI+Xiegtu/9Fo3iShTNleuGTEyoc
 YoIWub62E27+jMNmnz27+bBTlFIfA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:26 +0200
Subject: [PATCH 04/13] y2038: testsuite/smokey/y2038: Adding tests for
 timer_settime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-4-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Extending the smokey testsuite to do some tests for the recently added
timer_settime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index ef8c72225..312d1b041 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -25,6 +25,11 @@ struct xn_timespec64 {
 	int64_t tv_nsec;
 };
 
+struct xn_itimerspec64 {
+	struct xn_timespec64 interval;
+	struct xn_timespec64 value;
+};
+
 struct xn_timex_timeval {
 	int64_t tv_sec;
 	int64_t	tv_usec;
@@ -1212,6 +1217,69 @@ out_mutex:
 	return ret;
 }
 
+static int test_sc_cobalt_timer_settime64(void)
+{
+	long sc_nr = sc_cobalt_timer_settime64;
+	struct xn_itimerspec64 its;
+	struct sigevent sev;
+	sigset_t sigset;
+	timer_t t;
+	int sig;
+	int ret;
+
+	sig = SIGUSR1;
+	sigemptyset(&sigset);
+	sigaddset(&sigset, sig);
+
+	memset(&sev, 0, sizeof(sev));
+	memset(&its, 0, sizeof(its));
+
+	sev.sigev_signo = sig;
+	sev.sigev_notify = SIGEV_THREAD_ID | SIGEV_SIGNAL;
+	sev.sigev_notify_thread_id = gettid();
+
+	ret = smokey_check_errno(timer_create(CLOCK_REALTIME, &sev, &t));
+	if (ret)
+		return ret;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL4(sc_nr, t, 0, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timer_settime64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	its.value.tv_sec = -1;
+	its.value.tv_nsec = 100000;
+
+	/* Provide an invalid expiration time, should deliver -EINVAL */
+	ret = XENOMAI_SYSCALL4(sc_nr, t, 0, &its, NULL);
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* Provide a valid expiration time, should succeed */
+	its.value.tv_sec = 0;
+	ret = XENOMAI_SYSCALL4(sc_nr, t, 0, &its, NULL);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	/* Wait for the timer to deliver the signal */
+	sigwait(&sigset, &sig);
+
+out:
+	timer_delete(t);
+
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1301,5 +1369,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timer_settime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

