Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22123D8
	for <xenomai@lists.linux.dev>; Fri, 26 May 2023 05:46:10 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230526053600aed8b9f3ac592f836f
        for <xenomai@lists.linux.dev>;
        Fri, 26 May 2023 07:36:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mYmSgbW9hCCmyjvn0MANbTgvPqeDYmERQdnqZxWQpVo=;
 b=hb0adb4fpll2kj7knlppt9gs+ZEPgJmBL9S0Iy3M2f7jIGIkbvcqSzGKYIT2oIAW8ge742
 bW7lq9q3qiMfxr4992dfLOTqbRfbktIO666f0+G/q5w8nBqlgtRckGBIQKcN6GPypMr79KEL
 Ob0paXr6G3kul2U9+uhGsDVFRSCdA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 26 May 2023 07:35:59 +0200
Subject: [PATCH v2 3/4] y2038: testsuite/smokey/y2038: Adding tests for
 pselect64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230516-florian-y2038-part-three-v2-3-3fc689b21a32@siemens.com>
References: <20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
In-Reply-To: <20230516-florian-y2038-part-three-v2-0-3fc689b21a32@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Extending the smokey testsuite to do some tests for the recently added
pselect64 syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 70 ++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 2e3b81e0c..d1e1f46bf 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1443,6 +1443,72 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_pselect64(void)
+{
+	long sc_nr = sc_cobalt_pselect64;
+	struct xn_timespec64 t1, t2;
+	struct timespec ts_nat;
+	int ret;
+
+	/* Supplying an invalid timeout should deliver -EINVAL */
+	t1.tv_sec = -1;
+	t1.tv_nsec = 0;
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, &t1);
+	if (ret == -ENOSYS) {
+		smokey_note("cobalt_pselect64: skipped. (no kernel support)");
+		ret = 0;
+		goto out; // Not implemented, nothing to test, success
+	}
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* Supplying an invalid address should deliver -EFAULT */
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL,
+			       (void *)0xdeadbeefUL);
+	if (!smokey_assert(ret == -EFAULT)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Providing a valid timeout, waiting for it to time out and check
+	 * that we didn't come back to early.
+	 */
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
+	if (ret)
+		goto out;
+
+	t1.tv_sec = 0;
+	t1.tv_nsec = 500000;
+
+	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, &t1);
+	if (!smokey_assert(!ret)) {
+		ret = ret ? ret : -EINVAL;
+		goto out;
+	}
+
+	t1.tv_sec = ts_nat.tv_sec;
+	t1.tv_nsec = ts_nat.tv_nsec;
+
+	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
+	if (ret)
+		goto out;
+
+	t2.tv_sec = ts_nat.tv_sec;
+	t2.tv_nsec = ts_nat.tv_nsec;
+
+	if (ts_less(&t2, &t1))
+		smokey_warning("pselect64 returned to early!\n"
+			       "Expected wakeup at: %lld sec %lld nsec\n"
+			       "Back at           : %lld sec %lld nsec\n",
+			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
+
+out:
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1548,5 +1614,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_pselect64();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

