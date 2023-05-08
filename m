Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19651168A6
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:36 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202305080813289f7badd9215c645233
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Z+ywMKqG55mqDmrHWOEQHN3ZQP8nMDFuhP2j8/8/8UM=;
 b=Mtg58WNYJTDcbq4v2rul3f0V99Yxt6Ye3YDkxwj6UjGuCAfWdOdVXfog4Mrienc0Csc/s1
 z9dwjR3zvjIOIdXZ1851GPwZwdh5QQOBLkyR7Yn3p2nlYWHWYtqkFzDh1UjmNG1wdB+eiCKl
 5PQCETzSbSrehA/HQzdBEMSQrCMwA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:29 +0200
Subject: [PATCH 07/13] y2038: testsuite/smokey/y2038: Adding tests for
 timer_gettime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-7-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Extending the smokey testsuite to do some tests for the recently added
timer_gettime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 312d1b041..069553f37 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1280,6 +1280,65 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_timer_gettime64(void)
+{
+	long sc_nr = sc_cobalt_timer_gettime64;
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
+	ret = XENOMAI_SYSCALL2(sc_nr, t, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timer_gettime64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Init some random values, allows us to identify that the kernel has
+	 * written the time
+	 */
+	its.value.tv_sec = 123;
+	its.value.tv_nsec = 456;
+
+	/* Fetch the time from the timer, should succeed */
+	ret = XENOMAI_SYSCALL2(sc_nr, t, &its);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	smokey_assert(its.value.tv_sec == 0);
+	smokey_assert(its.value.tv_nsec == 0);
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
@@ -1373,5 +1432,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timer_gettime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

