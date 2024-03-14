Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E55BADF
	for <xenomai@lists.linux.dev>; Thu, 14 Mar 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423080; cv=none; b=SJDk8WNDLwZQqZI1vKHMZxe2KLHws5eNxAFUMgWLKIDoV+afEImk+6ny5X/67SBKMKc6BAIGdeMKAWhNFxrnWYCagVpCspebEC7ecHDnwh/iLosXdUqa+LsiuqTLjfW1T7FhNk5P0ypljkMQUCwk3mxnweqwNjC9L1NKmpQ02uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423080; c=relaxed/simple;
	bh=JazIMu3I5NIM6F16JJLm6ZD9wYjtsB1hs4W/6IjfbxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF0zPjg0UgsbjUoec/N1lxzYFA2kDT0zunL7IfkEOCxGRh8LYyH3vl0fV7iVi/9TrtJ8loa+FQQsdWiAdxCBjeyingZip10aNDA5nC1wOJCNRTaXTvBKQzWmektuD2ESP5uKqg4gqhOj5pSelo2keqpsiuNELi64qidclLnuAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=IhE12dVH; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="IhE12dVH"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240314132051255c54db054ea366b4
        for <xenomai@lists.linux.dev>;
        Thu, 14 Mar 2024 14:20:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4CGhsVl2js3UDbKxTcv3Yyp0Q9JcT/AvfHefDcOj1EQ=;
 b=IhE12dVHtqvFRoERDbuHZWvG9bsuEXDwiWsOXhxGui0tCuPgfMVBGn7Dp91mwdHPbEu5oj
 YQoskzQuvtnMSYI7nEQB5p4GActrDMu7V6YPUoRivGG7C/Jmtj9eTdteGNxCiGCSOI8oTv7P
 x9dMbjF0vTkZQ0+t6d4jgGDOYxcPk=;
From: Fabian Scheler <Fabian.Scheler@siemens.com>
To: xenomai@lists.linux.dev
Cc: Fabian Scheler <Fabian.Scheler@siemens.com>
Subject: [PATCH v2] testsuite: smokey - new testcase pi_nesting_contend_multicore
Date: Thu, 14 Mar 2024 14:19:27 +0100
Message-ID: <20240314131927.27417-1-Fabian.Scheler@siemens.com>
In-Reply-To: <df16b465-e1b3-4783-ab0d-749bbdc0f802@siemens.com>
References: <df16b465-e1b3-4783-ab0d-749bbdc0f802@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325281:519-21489:flowmailer

The testcase ensures that the correct handling of priority boosts in a nested
priority-inheritance scenario in a multi-core environment by assigning different
threads to different cores if this is possible. On single-core targets all
threads are assigned to the same core. In contrast to protect_nesting_protect
and protect_nesting_pi only priority-inheritance is involved here.

For more details please refer to the detailed comment before
pi_nesting_contend_multicore.

Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
---
 testsuite/smokey/posix-mutex/posix-mutex.c | 303 ++++++++++++++++++++-
 1 file changed, 296 insertions(+), 7 deletions(-)

diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 4aad24964..5cca0d2a1 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -86,11 +86,12 @@ static int get_effective_prio(void)
 	return stat.cprio;
 }
 
-static int create_thread(pthread_t *tid, int policy, int prio,
+static int create_thread(pthread_t *tid, int policy, int prio, int cpu,
 			 void *(*thread)(void *), void *arg)
 {
 	struct sched_param param;
 	pthread_attr_t thattr;
+	cpu_set_t cpuset;
 	int ret;
 
 	pthread_attr_init(&thattr);
@@ -99,6 +100,16 @@ static int create_thread(pthread_t *tid, int policy, int prio,
 	pthread_attr_setschedparam(&thattr, &param);
 	pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
 
+	if (cpu != -1) {
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+
+		if (!__T(ret, pthread_attr_setaffinity_np(&thattr,
+							  sizeof(cpu_set_t),
+							  &cpuset)))
+			return ret;
+	}
+
 	if (!__T(ret, pthread_create(tid, &thattr, thread, arg)))
 		return ret;
 
@@ -194,7 +205,7 @@ static int do_timed_contend(pthread_mutex_t *mutex, int prio)
 		return ret;
 
 	args.mutex = mutex;
-	ret = create_thread(&tid, SCHED_FIFO, prio,
+	ret = create_thread(&tid, SCHED_FIFO, prio, -1,
 			    mutex_timed_locker, &args);
 	if (ret)
 		return ret;
@@ -256,7 +267,7 @@ static int do_contend(pthread_mutex_t *mutex, int type)
 	smokey_barrier_init(&barrier);
 	args.barrier = &barrier;
 	args.lock_acquired = 0;
-	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_MEDIUM,
+	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_MEDIUM, -1,
 			    mutex_locker, &args);
 	if (ret)
 		return ret;
@@ -496,7 +507,7 @@ static int do_pi_contend(int prio)
 	args.mutex = &mutex;
 	smokey_barrier_init(&barrier);
 	args.barrier = &barrier;
-	ret = create_thread(&tid, SCHED_FIFO, prio,
+	ret = create_thread(&tid, SCHED_FIFO, prio, -1,
 			    mutex_timed_locker, &args);
 	if (ret)
 		return ret;
@@ -533,6 +544,283 @@ static int pi_contend(void)
 	return do_pi_contend(THREAD_PRIO_HIGH);
 }
 
+struct multicore_low_context {
+	pthread_mutex_t *mutex1;
+	pthread_mutex_t *mutex2;
+	struct smokey_barrier *low_barrier;
+	struct smokey_barrier *locker1_barrier;
+	struct smokey_barrier *locker2_barrier;
+	struct smokey_barrier *medium_barrier;
+	int *medium_flag;
+};
+
+struct multicore_mutex_locker_context {
+	pthread_mutex_t *mutex;
+	struct smokey_barrier *barrier;
+};
+
+struct multicore_medium_context {
+	int *flag;
+	struct smokey_barrier *barrier;
+};
+
+static void *pi_nesting_contend_multicore_low(void *arg)
+{
+	struct multicore_low_context *context =
+		(struct multicore_low_context *)arg;
+	int ret;
+
+	if (!__T(ret, smokey_barrier_wait(context->low_barrier)))
+		return (void *)(long)ret;
+
+	if (!__T(ret, pthread_mutex_lock(context->mutex1)))
+		return (void *)(long)ret;
+
+	if (!__T(ret, pthread_mutex_lock(context->mutex2)))
+		return (void *)(long)ret;
+
+	smokey_barrier_release(context->locker1_barrier);
+	smokey_barrier_release(context->locker2_barrier);
+	smokey_barrier_release(context->medium_barrier);
+
+	if (!__T(ret, pthread_mutex_unlock(context->mutex1)))
+		return (void *)(long)ret;
+
+	if (!__Tassert(*(context->medium_flag) == 0))
+		return (void *)(long)-10;
+
+	if (!__T(ret, pthread_mutex_unlock(context->mutex2)))
+		return (void *)(long)ret;
+
+	if (!__Tassert(*(context->medium_flag) == 1))
+		return (void *)(long)-20;
+
+	return NULL;
+}
+
+static void *pi_nesting_contend_multicore_mutex_locker(void *arg)
+{
+	struct multicore_mutex_locker_context *context =
+		(struct multicore_mutex_locker_context *)arg;
+	int ret;
+
+	if (!__T(ret, smokey_barrier_wait(context->barrier)))
+		return (void *)(long)ret;
+
+	if (!__T(ret, pthread_mutex_lock(context->mutex)))
+		return (void *)(long)ret;
+
+	if (!__T(ret, pthread_mutex_unlock(context->mutex)))
+		return (void *)(long)ret;
+
+	return NULL;
+}
+
+static void *pi_nesting_contend_multicore_medium(void *arg)
+{
+	struct multicore_medium_context *context =
+		(struct multicore_medium_context *)arg;
+	int ret;
+
+	if (!__T(ret, smokey_barrier_wait(context->barrier)))
+		return (void *)(long)ret;
+
+	*(context->flag) = 1;
+
+	return NULL;
+}
+
+static int pi_nesting_contend_multicore_getcpu(cpu_set_t *rt_cpus,
+					       cpu_set_t *online_cpus,
+					       int num_cpus, int start_cpu)
+{
+	int tmp_cpu = start_cpu;
+	int result_cpu = 0;
+	do {
+		result_cpu = ++tmp_cpu % num_cpus;
+		if (result_cpu == start_cpu) {
+			break;
+		}
+	} while (CPU_ISSET(tmp_cpu, rt_cpus) == 0 ||
+		 CPU_ISSET(tmp_cpu, online_cpus));
+
+	return result_cpu;
+}
+
+/*
+ * This testcase exercises a nested priority-inheritance-scenario preventing
+ * uncrontrolled prioritoty-inversion caused by a thread with a medium
+ * priority.
+ *
+ * In this test there are four threads involved:
+ *
+ * - low (prio THREAD_PRIO_LOW): holds mutexes mutex1 and mutex2
+ * - locker1 (prio THREAD_PRIO_HIGH): blocked by mutex1
+ * - locker2 (prio THREAD_PRIO_VERY_HIGH): blocked by mutex2
+ * - medium (prio THREAD_PRIO_MEDIUM): "tries" to preempt low
+ *
+ * The test ensures that the priority of the low-prio thread is correctly
+ * restored when it unlocks the pi-mutex and thus is deboosted. This test also
+ * checks this behavior in a multi-core environment by assigning different
+ * threads to different cores if this is possible. If only a single core is
+ * available, all threads are assigned to that core, i.e. the test also works on
+ * single-core targets.
+ *
+ * The threads are allocated to processor cores as follows:
+ * - low & medium: same core => low_medium_cpu, this is necessary, otherwise
+ *   medium could not prevent low from running
+ * - locker1: locker1_cpu != low_medium_cpu if possible
+ * - locker2: locker2_cpu != low_medium_cpu && locker1_cpu != locker2_cpu if possible
+ *
+ * (rough) execution sequence:
+ * 1.  setup test
+ * 2.  unblock thread low
+ * 3.  low: lock mutex1 and mutex2
+ * 4.  low: unblock locker1, locker2 and medium (in that order)
+ * 5.  locker1 and locker2: block when locking mutex1 and mutex2 respectively
+ * 6.  medium: blocked by low due to priority inheritance
+ * 7.  low: unlock mutex1 => locker1 can finish, medium => still blocked
+ * 8.  low: unlock mutex2 => locker2 can finish
+ * 9.  medium: run to completion
+ * 10. low: run to completion
+ */
+static int pi_nesting_contend_multicore(void)
+{
+	struct multicore_mutex_locker_context locker1_args, locker2_args;
+	int cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
+	struct smokey_barrier locker1_barrier, locker2_barrier;
+	struct smokey_barrier low_barrier, medium_barrier;
+	struct multicore_medium_context medium_args;
+	pthread_t low, locker1, locker2, medium;
+	struct multicore_low_context low_args;
+	pthread_mutex_t mutex1, mutex2;
+	cpu_set_t rt_cpus, online_cpus;
+	int medium_flag = 0;
+	void *status;
+	int ret;
+
+	/* setup test */
+
+	cpu = get_current_cpu();
+
+	num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+
+	if (!__T(ret, get_realtime_cpu_set(&rt_cpus)))
+		return ret;
+
+	if (!__T(ret, get_online_cpu_set(&online_cpus)))
+		return ret;
+
+	low_medium_cpu = pi_nesting_contend_multicore_getcpu(
+		&rt_cpus, &online_cpus, num_cpus, cpu);
+	locker1_cpu = pi_nesting_contend_multicore_getcpu(
+		&rt_cpus, &online_cpus, num_cpus, low_medium_cpu);
+	locker2_cpu = pi_nesting_contend_multicore_getcpu(
+		&rt_cpus, &online_cpus, num_cpus, locker1_cpu);
+
+	if (!__T(ret, smokey_barrier_init(&low_barrier)))
+		return ret;
+
+	if (!__T(ret, smokey_barrier_init(&locker1_barrier)))
+		return ret;
+
+	if (!__T(ret, smokey_barrier_init(&locker2_barrier)))
+		return ret;
+
+	if (!__T(ret, smokey_barrier_init(&medium_barrier)))
+		return ret;
+
+	ret = do_init_mutex(&mutex1, PTHREAD_MUTEX_NORMAL,
+			    PTHREAD_PRIO_INHERIT);
+	if (ret)
+		return ret;
+
+	ret = do_init_mutex(&mutex2, PTHREAD_MUTEX_NORMAL,
+			    PTHREAD_PRIO_INHERIT);
+	if (ret)
+		return ret;
+
+	low_args.mutex1 = &mutex1;
+	low_args.mutex2 = &mutex2;
+	low_args.low_barrier = &low_barrier;
+	low_args.locker1_barrier = &locker1_barrier;
+	low_args.locker2_barrier = &locker2_barrier;
+	low_args.medium_barrier = &medium_barrier;
+	low_args.medium_flag = &medium_flag;
+
+	locker1_args.mutex = &mutex1;
+	locker1_args.barrier = &locker1_barrier;
+
+	locker2_args.mutex = &mutex2;
+	locker2_args.barrier = &locker2_barrier;
+
+	medium_args.barrier = &medium_barrier;
+	medium_args.flag = &medium_flag;
+
+	if (!__T(ret, create_thread(
+			      &low, SCHED_FIFO, THREAD_PRIO_LOW, low_medium_cpu,
+			      pi_nesting_contend_multicore_low, &low_args)))
+		return ret;
+
+	if (!__T(ret, create_thread(&locker1, SCHED_FIFO, THREAD_PRIO_HIGH,
+				    locker1_cpu,
+				    pi_nesting_contend_multicore_mutex_locker,
+				    &locker1_args)))
+		return ret;
+
+	if (!__T(ret, create_thread(&locker2, SCHED_FIFO, THREAD_PRIO_VERY_HIGH,
+				    locker2_cpu,
+				    pi_nesting_contend_multicore_mutex_locker,
+				    &locker2_args)))
+		return ret;
+
+	if (!__T(ret, create_thread(&medium, SCHED_FIFO, THREAD_PRIO_MEDIUM,
+				    low_medium_cpu,
+				    pi_nesting_contend_multicore_medium,
+				    &medium_args)))
+		return ret;
+
+	/* start test */
+
+	smokey_barrier_release(&low_barrier);
+
+	/* wait for threads to finish */
+
+	if (!__T(ret, pthread_join(low, &status)))
+		return ret;
+	if (!__Tassert(status == NULL))
+		return -EINVAL;
+
+	if (!__T(ret, pthread_join(locker1, &status)))
+		return ret;
+	if (!__Tassert(status == NULL))
+		return -EINVAL;
+
+	if (!__T(ret, pthread_join(locker2, &status)))
+		return ret;
+	if (!__Tassert(status == NULL))
+		return -EINVAL;
+
+	if (!__T(ret, pthread_join(medium, &status)))
+		return ret;
+	if (!__Tassert(status == NULL))
+		return -EINVAL;
+
+	/* cleanup test */
+
+	smokey_barrier_destroy(&low_barrier);
+	smokey_barrier_destroy(&locker1_barrier);
+	smokey_barrier_destroy(&locker2_barrier);
+	smokey_barrier_destroy(&medium_barrier);
+
+	if (!__T(ret, pthread_mutex_destroy(&mutex1)))
+		return ret;
+	if (!__T(ret, pthread_mutex_destroy(&mutex2)))
+		return ret;
+
+	return 0;
+}
+
 static void *mutex_locker_steal(void *arg)
 {
 	struct locker_context *p = arg;
@@ -572,7 +860,7 @@ static int do_steal(int may_steal)
 	smokey_barrier_init(&barrier);
 	args.barrier = &barrier;
 	args.lock_acquired = 0;
-	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
+	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
 			    mutex_locker_steal, &args);
 	if (ret)
 		return ret;
@@ -974,7 +1262,7 @@ static int protect_handover(void)
 	smokey_barrier_init(&barrier);
 	args.barrier = &barrier;
 	args.lock_acquired = 0;
-	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
+	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
 			    mutex_locker, &args);
 	if (ret)
 		return ret;
@@ -1040,7 +1328,7 @@ static int check_timedlock_abstime_validation(void)
 	 * validate the (invalid) timeout
 	 */
 	args.mutex = &mutex;
-	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
+	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW, -1,
 			    mutex_timed_locker_inv_timeout, &args);
 
 	if (ret)
@@ -1114,6 +1402,7 @@ static int run_posix_mutex(struct smokey_test *t, int argc, char *const argv[])
 	do_test(timed_contend, MAX_100_MS);
 	do_test(weak_mode_switch, MAX_100_MS);
 	do_test(pi_contend, MAX_100_MS);
+	do_test(pi_nesting_contend_multicore, MAX_100_MS);
 	do_test(steal, MAX_100_MS);
 	do_test(no_steal, MAX_100_MS);
 	do_test(protect_raise, MAX_100_MS);
-- 
2.44.0

