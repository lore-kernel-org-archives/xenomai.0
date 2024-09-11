Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04921A00F4
	for <xenomai@lists.linux.dev>; Wed, 11 Sep 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065904; cv=none; b=mvxIrPQwW1clIInEYxAakN/NNlJcPEh/lA/4NA1BvK1kDQVaWH9dF0qeD/g2ylmqFy1AQM0W8xDsz02CNcekIf1sIXuwMoGRW1+GiFcB5Ki/AFu7nGOns76br/P48kWsa8ZL+jhKxKedKCkhXw889dJp78we5TMBXMNX1FGnvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065904; c=relaxed/simple;
	bh=wBCdjO7yGMe1+A3rHzff+yON81AmNZymYDML8d3UcP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MnpuwPj5ZUN6YAixmPV1ryAJKMIlIq1Nr4bbE9nC9V3LTYrF2Hjro4E4o+mTUlY47RTKC7JHmGjd8p7vRV70UObv04AaMK7/nbkC+VxPjUqUVAq6RrD10mNwp+A4MCfX+g126Y/IybUQNWDtoYPvrBZRue4vJ4M4zpxxdpUSqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Y21jxqEG; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Y21jxqEG"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202409111444546e9161678492f466d2
        for <xenomai@lists.linux.dev>;
        Wed, 11 Sep 2024 16:44:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Nojq/yD+SNwbAKt4tSg/2mBH65vQgFpvPBe3TV3fHY0=;
 b=Y21jxqEGfwJZaOdoh7hjMTlIdQvpOSogD6SNhKxlcSMdxv4h5xYa0Vi4GRYJQ3dyMrAfGd
 5AQBQKdUZu7ZRRCumBNNKwG0pPZC6+RMv+pAVzKHGBuw2+cgfON/n3xyxbNTOAgvkzA36yC/
 pwWxiYzdFbLKYh+OCoGk/qcKO16CJHB061a05aAjzg412mSbViyDJJgfE9DOQDKv1AlPIBhx
 DHOHDZku6pjoZELKXsLsB53ut0dnbA1VvMCXuJayGCTBnPFgZiB+PgDvedtIWf6fWfqgIWga
 WzwHlu6bBD7PWRi067s7pLLvhgTYQrt2EKATT1EWHpoAIHrBXmwfR5qw==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] y2038: testsuite/smokey: Cleanup coding style
Date: Wed, 11 Sep 2024 16:44:52 +0200
Message-Id: <20240911144452.182645-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Seems that we didn't follow the kernel coding style strictly in the
early days of the y2038 implementation. At least we partially ignored
the "reverse christmas tree" style for variable declarations.

No functional changes.

A redundant GPLv2 hint has been removed as this file already has a
correct SPDX tag.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 58 +++++++++++++-------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 91ef5258e..0817d2004 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -2,12 +2,10 @@
 /*
  * y2038 tests
  *
- * Copyright (c) Siemens AG 2021
+ * Copyright (c) Siemens AG 2021-2024
  *
  * Authors:
  *  Florian Bezdeka <florian.bezdeka@siemens.com>
- *
- * Released under the terms of GPLv2.
  */
 #include <asm/xenomai/syscall.h>
 #include <smokey/smokey.h>
@@ -161,11 +159,11 @@ static int run_thread(void *(*thread)(void *), void *arg, int exp_result)
 
 static int test_sc_cobalt_sem_timedwait64(void)
 {
-	int ret;
-	sem_t sem;
 	int sc_nr = sc_cobalt_sem_timedwait64;
 	struct xn_timespec64 ts64, ts_wu;
 	struct timespec ts_nat;
+	sem_t sem;
+	int ret;
 
 	sem_init(&sem, 0, 0);
 
@@ -245,9 +243,9 @@ static int test_sc_cobalt_sem_timedwait64(void)
 
 static int test_sc_cobalt_clock_gettime64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_clock_gettime64;
 	struct xn_timespec64 ts64 = {0};
+	int ret;
 
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
@@ -276,8 +274,8 @@ static int test_sc_cobalt_clock_gettime64(void)
 
 static int test_sc_cobalt_clock_settime64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_clock_settime64;
+	int ret;
 
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
@@ -294,11 +292,11 @@ static int test_sc_cobalt_clock_settime64(void)
 
 static int test_sc_cobalt_clock_nanosleep64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_clock_nanosleep64;
 	struct xn_timespec64 next, rmt;
 	struct timespec ts1, ts2, delta;
 	long interval = 1;
+	int ret;
 
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL4(sc_nr, NULL, NULL, NULL, NULL);
@@ -358,9 +356,9 @@ static int test_sc_cobalt_clock_nanosleep64(void)
 
 static int test_sc_cobalt_clock_getres64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_clock_getres64;
 	struct xn_timespec64 ts64;
+	int ret;
 
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
@@ -389,9 +387,9 @@ static int test_sc_cobalt_clock_getres64(void)
 
 static int test_sc_cobalt_clock_adjtime64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_clock_adjtime64;
 	struct xn_timex64 tx64 = {};
+	int ret;
 
 	/* Make sure we don't crash because of NULL pointers */
 	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
@@ -461,11 +459,11 @@ static void *timedlock64_thread(void *arg)
 
 static int test_sc_cobalt_mutex_timedlock64(void)
 {
-	int ret;
-	pthread_mutex_t mutex;
 	int sc_nr = sc_cobalt_mutex_timedlock64;
-	struct xn_timespec64 ts64;
 	struct thread_context ctx = {0};
+	struct xn_timespec64 ts64;
+	pthread_mutex_t mutex;
+	int ret;
 
 	if (!__T(ret, pthread_mutex_init(&mutex, NULL)))
 		return ret;
@@ -567,10 +565,10 @@ static int test_sc_cobalt_mutex_timedlock64(void)
 
 static int test_sc_cobalt_mq_timedsend64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_mq_timedsend64;
 	struct xn_timespec64 t1, t2;
 	struct timespec ts_nat;
+	int ret;
 
 	mqd_t mq;
 	struct mq_attr qa;
@@ -650,10 +648,10 @@ static int test_sc_cobalt_mq_timedsend64(void)
 
 static int test_sc_cobalt_mq_timedreceive64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_mq_timedreceive64;
 	struct xn_timespec64 t1, t2;
 	struct timespec ts_nat;
+	int ret;
 
 	mqd_t mq;
 	struct mq_attr qa;
@@ -746,11 +744,11 @@ static int test_sc_cobalt_mq_timedreceive64(void)
 
 static int test_sc_cobalt_sigtimedwait64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_sigtimedwait64;
 	struct xn_timespec64 t1, t2;
 	struct timespec ts_nat;
 	sigset_t set;
+	int ret;
 
 	sigaddset(&set, SIGINT);
 
@@ -821,11 +819,11 @@ static int test_sc_cobalt_sigtimedwait64(void)
 
 static int test_sc_cobalt_monitor_wait64(void)
 {
-	int ret, opret;
 	int sc_nr = sc_cobalt_monitor_wait64;
+	struct cobalt_monitor_shadow mon;
 	struct xn_timespec64 t1, t2, to;
 	struct timespec ts_nat;
-	struct cobalt_monitor_shadow mon;
+	int ret, opret;
 
 	ret = cobalt_monitor_init(&mon, CLOCK_REALTIME, 0);
 	if (ret)
@@ -893,12 +891,12 @@ static int test_sc_cobalt_monitor_wait64(void)
 
 static int test_sc_cobalt_event_wait64(void)
 {
-	int ret;
 	int sc_nr = sc_cobalt_event_wait64;
+	struct cobalt_event_shadow evt;
 	struct xn_timespec64 t1, t2;
 	struct timespec ts_nat;
-	struct cobalt_event_shadow evt;
 	unsigned int flags;
+	int ret;
 
 	ret = cobalt_event_init(&evt, 0, COBALT_EVENT_FIFO);
 	if (ret)
@@ -972,14 +970,14 @@ static int test_sc_cobalt_event_wait64(void)
 
 static int test_sc_cobalt_recvmmsg64(void)
 {
-	int ret = 0;
-	int sock;
 	int sc_nr = sc_cobalt_recvmmsg64;
-	long data;
-	struct xn_timespec64 t1, t2;
-	struct timespec ts_nat;
 	struct rtipc_port_label plabel;
+	struct xn_timespec64 t1, t2;
 	struct sockaddr_ipc saddr;
+	struct timespec ts_nat;
+	int ret = 0;
+	long data;
+	int sock;
 
 	struct iovec iov = {
 		.iov_base = &data,
@@ -1097,14 +1095,14 @@ out:
 
 static int test_sc_cobalt_cond_wait_prologue64(void)
 {
-	int ret = 0;
-	int err = 0;
 	int sc_nr = sc_cobalt_cond_wait_prologue64;
-	pthread_mutex_t m;
-	pthread_cond_t c;
-	pthread_condattr_t attr;
 	struct xn_timespec64 t1, t2;
+	pthread_condattr_t attr;
 	struct timespec ts_nat;
+	pthread_mutex_t m;
+	pthread_cond_t c;
+	int ret = 0;
+	int err = 0;
 
 	if (!__T(ret, pthread_mutex_init(&m, NULL)))
 		return ret;
-- 
2.39.2

