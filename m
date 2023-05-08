Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D3168AE
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 08:13:37 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230508081329686792052a59076937
        for <xenomai@lists.linux.dev>;
        Mon, 08 May 2023 10:13:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SnNsc014fpDqJChqBtW7uazoondiF0IohzvloJaGe90=;
 b=Bn4v7VbZ00m2pOkycdhJsRi8qlBseKIanK5He5HeeYglhcw8URS/OPGb3RYkMHqjSnmGrF
 NSVQxPjkAdTUt+nKMl0w/Rkes2m2lZlR5uFxB04m5o370Gm3e/kqwfdXM63ebRmTjSzfHgJM
 1USwdzzOIyqsi0e4NAf11k0lLjmrc=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Mon, 08 May 2023 10:13:32 +0200
Subject: [PATCH 10/13] y2038: testsuite/smokey/y2038: Adding tests for
 timerfd_settime
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-florian-y2038-part-two-v1-10-a417812fba85@siemens.com>
References: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
In-Reply-To: <20230508-florian-y2038-part-two-v1-0-a417812fba85@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Extending the smokey testsuite to do some tests for the recently added
timerfd_settime syscall.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 069553f37..87d85b9df 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -11,6 +11,7 @@
  */
 #include <asm/xenomai/syscall.h>
 #include <smokey/smokey.h>
+#include <sys/timerfd.h>
 #include <sys/utsname.h>
 #include <mqueue.h>
 #include <rtdm/ipc.h>
@@ -1339,6 +1340,63 @@ out:
 	return ret;
 }
 
+static int test_sc_cobalt_timerfd_settime64(void)
+{
+	long sc_nr = sc_cobalt_timerfd_settime64;
+	struct xn_itimerspec64 its = { 0 };
+	uint64_t buf = 0;
+	ssize_t sz;
+	int ret;
+	int fd;
+
+	fd = smokey_check_errno(timerfd_create(CLOCK_REALTIME, 0));
+	if (fd < 0)
+		return fd;
+
+	/* Make sure we don't crash because of NULL pointers */
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, NULL, NULL);
+	if (ret == -ENOSYS) {
+		smokey_note(
+			"cobalt_timerfd_settime64: skipped. (no kernel support)");
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
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, &its, NULL);
+	if (!smokey_assert(ret == -EINVAL)) {
+		ret = ret ?: -EINVAL;
+		goto out;
+	}
+
+	/* Provide a valid expiration time, should succeed */
+	its.value.tv_sec = 0;
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, &its, NULL);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	ret = XENOMAI_SYSCALL4(sc_nr, fd, 0, &its, NULL);
+	if (!smokey_assert(!ret))
+		goto out;
+
+	sz = smokey_check_errno(read(fd, &buf, sizeof(buf)));
+	if (sz != sizeof(buf))
+		goto out;
+
+	smokey_assert(buf == 1);
+out:
+	smokey_check_errno(close(fd));
+
+	return ret;
+}
+
 static int check_kernel_version(void)
 {
 	int ret, major, minor;
@@ -1436,5 +1494,9 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
+	ret = test_sc_cobalt_timerfd_settime64();
+	if (ret)
+		return ret;
+
 	return 0;
 }

-- 
2.39.2

