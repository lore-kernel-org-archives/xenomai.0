Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616311E3DFF
	for <xenomai@lists.linux.dev>; Fri, 31 Jan 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338149; cv=none; b=VkP4I8ED+vzJWnFZACHmR68TAEfUHcGNOlyKhx5jZvw6UY2/AU4zsFwvicCDZqAGfVzjHuEAuhfKllx2i6zcvGY2FbK2FgG0b9nr8Ibe3hh9WaFp5Ah6PXFLXwEGO2SSdTTV5pi8O9SwC/OTrueFNAS7MGx3hC1Ejud1pl8IPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338149; c=relaxed/simple;
	bh=DViA+pTAwqN3I7cJ/JrdZcuI5/rsKHReDeejeTldVuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W4rGXvnCM4uJj5Hz5UDHQCwuoJVbEX0fFMr0G8lryxATDUc2QpmYM8YSpCgzyU2r+SDsjQYLWeIdmn+UtiN2Ead3fzH+xkJHGxOJTdN7brm2BphM9gYqpCI/9OU1i+/FiS2NYLXKNeWDtE93bvMbefN37KwBLEf2/OhUHqkzyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=e+CPtRlE; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="e+CPtRlE"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250131154216c26195f24d67a212de
        for <xenomai@lists.linux.dev>;
        Fri, 31 Jan 2025 16:42:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ktCHL0wQjNb+q0VuN6Hsl5pkfXCT8Yk5ag7G+xKvbOY=;
 b=e+CPtRlENhKDNUlrxaCkeg1RmFBojqknF3YkONjntkeN/9X2Qc4mPDMBOSSbXZiAfuULYJ
 FaESyhcBnM/H3qM14SqWZbX39gWKhgu6NhRlipNCwzHxVeC09r0wry/vn+JGA/5sLL2MpqZP
 LrAU9lWOtNKFlMmknvGViBwWhSfNc+Vg/bj3qofMOjR21NRGpHuHnNhn43q5K4yAn+NSicwx
 lH/6jhqreQqJRvxt5g3FTEt2oNhNnKr7AEgQ3+cGlWiEfkqw9TPbGh72DG2J4RgR+t402+mA
 Zs9XAY13vb0rYx6QpdZDSgU2D3LKQX8mJt3dp4zJMfGFpkNgFLE06owg==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH RFC] latency: measure min/avg/max execution time for a non-blocking syscall
Date: Fri, 31 Jan 2025 16:41:59 +0100
Message-Id: <20250131154200.1221616-1-florian.bezdeka@siemens.com>
In-Reply-To: <68d9f583-59de-4bbf-8ea2-af8ece427495@siemens.com>
References: <68d9f583-59de-4bbf-8ea2-af8ece427495@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

RFC only. Will be referenced in the following mail as "measurement
patch".

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/latency/latency.c | 63 +++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index fe688b9b8..74a6d6ea6 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -107,6 +107,58 @@ static inline long long diff_ts(struct timespec *left, struct timespec *right)
 		+ left->tv_nsec - right->tv_nsec;
 }
 
+#include <cobalt/syscall.h>
+#include <stdbool.h>
+
+static unsigned int min_sc_exec_time = 0;
+static unsigned int max_sc_exec_time = 0;
+static double avg_sc_exec_time = 0;
+static unsigned int nr_sc_calls = 0;
+
+static inline void inject_syscall(bool *do_init)
+{
+	struct timespec t1, t2;
+	struct ts64 {
+		int64_t tv_sec;
+		int64_t tv_nsec;
+	} now;
+	long long delta_in_ns;
+	int ret;
+
+	/*
+	 * Syscall under test: clock_gettime64 (non-blocking)
+	 * We get called every cycle (1ms) with load (do_hell) running in
+	 * parallel. That should give us a cold cache.
+	 */
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &t1);
+	if (ret)
+		error(1, errno, "unable to fetch t1\n");
+
+	/* do the syscall (no vdso!) */
+	ret = XENOMAI_SYSCALL2(sc_cobalt_clock_gettime64, CLOCK_MONOTONIC,
+			       &now);
+	if (ret)
+		error(1, errno, "syscall injection failed\n");
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &t2);
+	if (ret)
+		error(1, errno, "unable to fetch t2\n");
+
+	delta_in_ns = diff_ts(&t2, &t1);
+
+	nr_sc_calls += 1;
+	avg_sc_exec_time += (delta_in_ns - avg_sc_exec_time) / nr_sc_calls;
+
+	if (delta_in_ns < min_sc_exec_time || *do_init)
+		min_sc_exec_time = delta_in_ns;
+
+	if (delta_in_ns > max_sc_exec_time || *do_init)
+		max_sc_exec_time = delta_in_ns;
+
+	*do_init = false;
+}
+
 static void *latency(void *cookie)
 {
 	int err, count, nsamples, warmup = 1;
@@ -114,6 +166,7 @@ static void *latency(void *cookie)
 	struct itimerspec timer_conf;
 	struct timespec expected;
 	unsigned old_relaxed = 0;
+	bool do_init = true;
 	char task_name[16];
 	int tfd;
 
@@ -166,7 +219,10 @@ static void *latency(void *cookie)
 
 			err = read(tfd, &ticks, sizeof(ticks));
 
+			inject_syscall(&do_init);
+
 			clock_gettime(CLOCK_MONOTONIC, &now);
+
 			dt = (int32_t)diff_ts(&now, &expected);
 			new_relaxed = sampling_relaxed;
 			if (dt > maxj) {
@@ -526,6 +582,11 @@ static void cleanup(void)
 	       (long long)((actual_duration / 60) % 60),
 	       (long long)(actual_duration % 60), test_duration / 3600,
 	       (test_duration / 60) % 60, test_duration % 60);
+	printf("Syscall results: \n"
+	       "   |%11.3f|%11.3f|%11.3f\n",
+	       (double)min_sc_exec_time / 1000, (double)avg_sc_exec_time / 1000,
+	       (double)max_sc_exec_time / 1000);
+
 	if (max_relaxed > 0)
 		printf(
 "Warning! some latency peaks may have been due to involuntary mode switches.\n"
@@ -556,8 +617,6 @@ static void faulthand(int sig)
 
 #ifdef CONFIG_XENO_COBALT
 
-#include <cobalt/uapi/syscall.h>
-
 static const char *reason_str[] = {
 	[SIGDEBUG_UNDEFINED] = "received SIGDEBUG for unknown reason",
 	[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",
-- 
2.39.5

