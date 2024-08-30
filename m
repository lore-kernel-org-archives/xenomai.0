Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066A1D131D
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016824; cv=none; b=m/gpQliDVCEyRkrziBaQB6d1g9TAMRCZpXMs/BuHmO2n3Xh3ldilF+EkK0zJvIw8Lr9jKQu9Nc4hxXJ3iIpf8jv4qi6w+eLZSG09h/Oxv79eqNGO8+Q8GR38V5Rk5SBXoa1cnCIdYUYwXN6uQNQSZFUl1mMdzhe/1rc4fqwA41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016824; c=relaxed/simple;
	bh=Hrdks4MsTLqJp2J+2m1LnCxxD1yskKKWR6KS2BalMB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qROdE50LzOGEgpK/n1aI+6aw+KBpIzXvYPOkXUZ4BtNrlVAP4ZEAQm2FviEBE3Mmh9vvjYuWHI9fmfxVl/nt1oERiLu7Zyz/jgN6tyrkvVJ9tlSY6VQjOfys41WsXz1asOiu7WaT6IqnQqLpTjPmG7EchWzv54bZU6ZvsJOsDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=NBOgl9yu; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="NBOgl9yu"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240830112016183d10c7a4bc25cf21
        for <xenomai@lists.linux.dev>;
        Fri, 30 Aug 2024 13:20:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=yUGfYHRvSTvF/t1uod1kwKHj5BmAQegZOudai2Dpkf8=;
 b=NBOgl9yuFccRY+F7/qzCi+YdkUZXtDEE2zPXdMRi/ua/IA89ZL+pnS5b+UlAscrMoVjVRs
 6g3ahvtu3u5rB1QMx9/nIWWaUQwT1uzs5jcsegTA/c/voThuAgOMH5FBEGj9LztanYoA9JCW
 innrQ1Of5fhOFQuc0GI1I1nYC6pLnONWO1nALj3qZnH/6ZViZ35KgpkL4OpQK/LYdVJcw0pv
 qsesmIbt/1BN4QdNraidmw7Y/ItXdcn5mM5eI6VBqfGAksjiUKGDxpeBR1wtnZC1ebO2tCKG
 h29KaxMsTp+aR5i5q6Ah3SXl+9u8qoaRvqEJMcBLrkwhNPQSx0v9Z4IQ==;
From: Fabian.Scheler@siemens.com
To: xenomai@lists.linux.dev
Cc: Fabian Scheler <Fabian.Scheler@siemens.com>
Subject: [PATCH] testsuite/smokey/posix-mutex: Fix race-condition
Date: Fri, 30 Aug 2024 13:19:38 +0200
Message-ID: <20240830111952.26651-1-Fabian.Scheler@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325281:519-21489:flowmailer

From: Fabian Scheler <Fabian.Scheler@siemens.com>

In the testcase pi_nesting_contend_multicore the thread low may be unblocked to
early preventing the thread medium from running until the end of the testcase,
making the testcase fail, as the thread medium is expected to run before the
thread low exits.

This is fixed by ensuring that all threads are properly setup within the
init-phase of the testcase, by additional instances of smokey_barrier used to
signal that a particular thread has been started during the init-phase of the
testcase.

Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
---
 testsuite/smokey/posix-mutex/posix-mutex.c | 54 ++++++++++++++++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 5cca0d2a1..249fc6c06 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -551,17 +551,20 @@ struct multicore_low_context {
 	struct smokey_barrier *locker1_barrier;
 	struct smokey_barrier *locker2_barrier;
 	struct smokey_barrier *medium_barrier;
+	struct smokey_barrier *ready_barrier;
 	int *medium_flag;
 };
 
 struct multicore_mutex_locker_context {
 	pthread_mutex_t *mutex;
 	struct smokey_barrier *barrier;
+	struct smokey_barrier *ready_barrier;
 };
 
 struct multicore_medium_context {
 	int *flag;
 	struct smokey_barrier *barrier;
+	struct smokey_barrier *ready_barrier;
 };
 
 static void *pi_nesting_contend_multicore_low(void *arg)
@@ -570,6 +573,8 @@ static void *pi_nesting_contend_multicore_low(void *arg)
 		(struct multicore_low_context *)arg;
 	int ret;
 
+	smokey_barrier_release(context->ready_barrier);
+
 	if (!__T(ret, smokey_barrier_wait(context->low_barrier)))
 		return (void *)(long)ret;
 
@@ -604,6 +609,8 @@ static void *pi_nesting_contend_multicore_mutex_locker(void *arg)
 		(struct multicore_mutex_locker_context *)arg;
 	int ret;
 
+	smokey_barrier_release(context->ready_barrier);
+
 	if (!__T(ret, smokey_barrier_wait(context->barrier)))
 		return (void *)(long)ret;
 
@@ -622,6 +629,8 @@ static void *pi_nesting_contend_multicore_medium(void *arg)
 		(struct multicore_medium_context *)arg;
 	int ret;
 
+	smokey_barrier_release(context->ready_barrier);
+
 	if (!__T(ret, smokey_barrier_wait(context->barrier)))
 		return (void *)(long)ret;
 
@@ -687,9 +696,11 @@ static int pi_nesting_contend_multicore_getcpu(cpu_set_t *rt_cpus,
 static int pi_nesting_contend_multicore(void)
 {
 	struct multicore_mutex_locker_context locker1_args, locker2_args;
-	int cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
-	struct smokey_barrier locker1_barrier, locker2_barrier;
-	struct smokey_barrier low_barrier, medium_barrier;
+	int ret, cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
+	struct smokey_barrier locker1_barrier, locker1_ready_barrier;
+	struct smokey_barrier locker2_barrier, locker2_ready_barrier;
+	struct smokey_barrier medium_barrier, medium_ready_barrier;
+	struct smokey_barrier low_barrier, low_ready_barrier;
 	struct multicore_medium_context medium_args;
 	pthread_t low, locker1, locker2, medium;
 	struct multicore_low_context low_args;
@@ -697,7 +708,6 @@ static int pi_nesting_contend_multicore(void)
 	cpu_set_t rt_cpus, online_cpus;
 	int medium_flag = 0;
 	void *status;
-	int ret;
 
 	/* setup test */
 
@@ -718,18 +728,33 @@ static int pi_nesting_contend_multicore(void)
 	locker2_cpu = pi_nesting_contend_multicore_getcpu(
 		&rt_cpus, &online_cpus, num_cpus, locker1_cpu);
 
+	smokey_trace("low_medium_cpu: %d, locker1_cpu: %d, locker2_cpu: %d\n",
+		low_medium_cpu, locker1_cpu, locker2_cpu);
+
 	if (!__T(ret, smokey_barrier_init(&low_barrier)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_init(&low_ready_barrier)))
+		return ret;
+
 	if (!__T(ret, smokey_barrier_init(&locker1_barrier)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_init(&locker1_ready_barrier)))
+		return ret;
+
 	if (!__T(ret, smokey_barrier_init(&locker2_barrier)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_init(&locker2_ready_barrier)))
+		return ret;
+
 	if (!__T(ret, smokey_barrier_init(&medium_barrier)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_init(&medium_ready_barrier)))
+		return ret;
+
 	ret = do_init_mutex(&mutex1, PTHREAD_MUTEX_NORMAL,
 			    PTHREAD_PRIO_INHERIT);
 	if (ret)
@@ -746,40 +771,56 @@ static int pi_nesting_contend_multicore(void)
 	low_args.locker1_barrier = &locker1_barrier;
 	low_args.locker2_barrier = &locker2_barrier;
 	low_args.medium_barrier = &medium_barrier;
+	low_args.ready_barrier = &low_ready_barrier;
 	low_args.medium_flag = &medium_flag;
 
 	locker1_args.mutex = &mutex1;
 	locker1_args.barrier = &locker1_barrier;
+	locker1_args.ready_barrier = &locker1_ready_barrier;
 
 	locker2_args.mutex = &mutex2;
 	locker2_args.barrier = &locker2_barrier;
+	locker2_args.ready_barrier = &locker2_ready_barrier;
 
 	medium_args.barrier = &medium_barrier;
 	medium_args.flag = &medium_flag;
+	medium_args.ready_barrier = &medium_ready_barrier;
 
 	if (!__T(ret, create_thread(
 			      &low, SCHED_FIFO, THREAD_PRIO_LOW, low_medium_cpu,
 			      pi_nesting_contend_multicore_low, &low_args)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_wait(&low_ready_barrier)))
+		return ret;
+
 	if (!__T(ret, create_thread(&locker1, SCHED_FIFO, THREAD_PRIO_HIGH,
 				    locker1_cpu,
 				    pi_nesting_contend_multicore_mutex_locker,
 				    &locker1_args)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_wait(&locker1_ready_barrier)))
+		return ret;
+
 	if (!__T(ret, create_thread(&locker2, SCHED_FIFO, THREAD_PRIO_VERY_HIGH,
 				    locker2_cpu,
 				    pi_nesting_contend_multicore_mutex_locker,
 				    &locker2_args)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_wait(&locker2_ready_barrier)))
+		return ret;
+
 	if (!__T(ret, create_thread(&medium, SCHED_FIFO, THREAD_PRIO_MEDIUM,
 				    low_medium_cpu,
 				    pi_nesting_contend_multicore_medium,
 				    &medium_args)))
 		return ret;
 
+	if (!__T(ret, smokey_barrier_wait(&medium_ready_barrier)))
+		return ret;
+
 	/* start test */
 
 	smokey_barrier_release(&low_barrier);
@@ -813,6 +854,11 @@ static int pi_nesting_contend_multicore(void)
 	smokey_barrier_destroy(&locker2_barrier);
 	smokey_barrier_destroy(&medium_barrier);
 
+	smokey_barrier_destroy(&low_ready_barrier);
+	smokey_barrier_destroy(&locker1_ready_barrier);
+	smokey_barrier_destroy(&locker2_ready_barrier);
+	smokey_barrier_destroy(&medium_ready_barrier);
+
 	if (!__T(ret, pthread_mutex_destroy(&mutex1)))
 		return ret;
 	if (!__T(ret, pthread_mutex_destroy(&mutex2)))
-- 
2.46.0

