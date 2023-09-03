Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9B525A
	for <xenomai@lists.linux.dev>; Sun,  3 Sep 2023 15:05:09 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230903150459f22dee3ea318b51a09
        for <xenomai@lists.linux.dev>;
        Sun, 03 Sep 2023 17:04:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=UBv8MObHIizYKNP3gnS7DFHD0OZys7W2XK3sHgS7is8=;
 b=iswO+DUEeviXU4ocB7KMrd6hmd+8FNQPXjqg0MUxUz37AsipZhXb7MCXsRrHpZSiSFWdJ4
 iz/kmqsR2ERHsiUghkWRYpdwBpcexdY99F2ida9S+VfCoBjhKntCyHJlCNj+nN7+do3Q+UdK
 fZ9rYWvr5eUZOaxZfWi7MShbJA1uc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 04/20] testsuite/smokey/y2038: Activate minimal clock_settime64
Date: Sun,  3 Sep 2023 17:04:41 +0200
Message-Id: <c5c4fa95852cd25596d07beffb6d8664562c5370.1693753497.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1693753497.git.jan.kiszka@siemens.com>
References: <cover.1693753497.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The clock_settime64 syscall is theoretically still relevant, even with
libc-based settime for standard clocks, but only for external clocks -
which we do not have in-tree. But we can at least check that invalid
parameters are detected and rejected

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 30 --------------------------
 1 file changed, 30 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 0c7de52161..3d4a9106bd 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -278,18 +278,9 @@ static int test_sc_cobalt_clock_settime64(void)
 {
 	int ret;
 	int sc_nr = sc_cobalt_clock_settime64;
-	struct xn_timespec64 ts64, now64;
-	struct timespec now;
-
-	if (!cobalt_use_legacy_tsc())
-		return 0; // Not implemented, nothing to test, success
 
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
-	if (ret == -ENOSYS) {
-		smokey_note("clock_settime64: skipped. (no kernel support)");
-		return 0; // Not implemented, nothing to test, success
-	}
 	if (!smokey_assert(ret == -EFAULT))
 		return ret ? ret : -EINVAL;
 
@@ -298,27 +289,6 @@ static int test_sc_cobalt_clock_settime64(void)
 	if (!smokey_assert(ret == -EFAULT))
 		return ret ? ret : -EINVAL;
 
-	ret = clock_gettime(CLOCK_REALTIME, &now);
-	if (ret)
-		return -errno;
-
-	/* Provide a valid 64bit timespec */
-	ts64.tv_sec  = now.tv_sec + 1;
-	ts64.tv_nsec = now.tv_nsec;
-	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_REALTIME, &ts64);
-	if (!smokey_assert(!ret))
-		return ret;
-
-	ret = clock_gettime(CLOCK_REALTIME, &now);
-	if (ret)
-		return -errno;
-
-	now64.tv_sec = now.tv_sec;
-	now64.tv_nsec = now.tv_nsec;
-
-	if (ts_less(&now64, &ts64))
-		smokey_warning("clock_settime() reported no error but no new time seen");
-
 	return 0;
 }
 
-- 
2.35.3

