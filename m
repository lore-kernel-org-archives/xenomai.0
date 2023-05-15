Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F7D536
	for <xenomai@lists.linux.dev>; Mon, 15 May 2023 14:50:30 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230515145028c9865f97469e8e1286
        for <xenomai@lists.linux.dev>;
        Mon, 15 May 2023 16:50:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L0GNc2vvJZ7AYQsxo7BYJMljxcf18iF+Nle+0Y5gpl0=;
 b=a6lICeGZKWa5pEYF9Z5I+2QFhKi2Yb4Iv1jFU6fxBf6RUk8OWkcg/SRw93OAyR3XXxFw9X
 M2oLoViNVOsI0sFX55E3JJCS9Sg9+qrTEZYkiu+8FByUu4+krQTYgB5aDFcEC0xM1VKiYNAE
 kqQkif06JdCxQbd9jGCODqL5poGw8=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 15 May 2023 16:50:14 +0200
Subject: [PATCH v2 14/14] y2038: testsuite/smokey/y2038: Adding tests for
 timerfd_gettime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v2-14-a12f69d870d7@siemens.com>
References: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v2-0-a12f69d870d7@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Extending the smokey testsuite to do some tests for the recently added
timerfd_gettime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 87d85b9df..2e3b81e0c 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1397,6 +1397,52 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_timerfd_gettime64(void)
+{
+	long sc_nr = sc_cobalt_timerfd_gettime64;
+	struct xn_itimerspec64 its = { 0 };
+	uint64_t buf = 0;
+	int ret;
+	int fd;
+
+	fd = timerfd_create(CLOCK_REALTIME, 0);
+	if (fd == -1)
+		return -errno;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL2(sc_nr, fd, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timerfd_gettime64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Set some random values, allows us to detect that the kernel has
+	 * written the time
+	 */
+	its.value.tv_sec = 123;
+	its.value.tv_nsec = 456;
+
+	/* Fetch the time from the timer, should succeed */
+	ret = XENOMAI_SYSCALL2(sc_nr, fd, &its);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	smokey_assert(buf == 0);
+	smokey_assert(its.value.tv_sec == 0);
+	smokey_assert(its.value.tv_nsec == 0);
+out:
+	smokey_check_errno(close(fd));
+
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1498,5 +1544,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timerfd_gettime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

