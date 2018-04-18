From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ab079dfb-98cd-887b-6b54-33f0fa15f74b@siemens.com>
Date: Wed, 18 Apr 2018 14:51:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 1/2] testsuite/smokey: Add handover test for
 prio-ceiling mutexes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

This triggers a bug in the PP implementation.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/posix-mutex/posix-mutex.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 7b0ed10c7..182f8c0e5 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -904,6 +904,52 @@ static int protect_trylock(void)
 	return 0;
 }
 
+static int protect_handover(void)
+{
+	struct smokey_barrier barrier;
+	struct locker_context args;
+	pthread_mutex_t mutex;
+	pthread_t tid;
+	int ret;
+
+	ret = do_init_mutex_ceiling(&mutex, PTHREAD_MUTEX_NORMAL,
+				    THREAD_PRIO_HIGH);
+	if (ret)
+		return ret;
+
+	if (!__T(ret, pthread_mutex_lock(&mutex)))
+		return ret;
+
+	args.mutex = &mutex;
+	smokey_barrier_init(&barrier);
+	args.barrier = &barrier;
+	args.lock_acquired = 0;
+	ret = create_thread(&tid, SCHED_FIFO, THREAD_PRIO_LOW,
+			    mutex_locker, &args);
+	if (ret)
+		return ret;
+
+	sleep_ms(1);	/* Wait for the locker to contend on the mutex. */
+
+	if (!__T(ret, pthread_mutex_unlock(&mutex)))
+		return ret;
+
+	/* Make sure the locker thread released the lock again. */
+	if (!__T(ret, smokey_barrier_wait(&barrier)))
+		return ret;
+
+	if (!__T(ret, pthread_mutex_lock(&mutex)))
+		return ret;
+
+	if (!__T(ret, pthread_mutex_unlock(&mutex)))
+		return ret;
+
+	if (!__T(ret, pthread_mutex_destroy(&mutex)))
+		return ret;
+
+	return 0;
+}
+
 /* Detect obviously wrong execution times. */
 static int check_time_limit(const struct timespec *start,
 			    xnticks_t limit_ns)
@@ -963,6 +1009,7 @@ static int run_posix_mutex(struct smokey_test *t, int argc, char *const argv[])
 	do_test(protect_weak, MAX_100_MS);
 	do_test(protect_dynamic, MAX_100_MS);
 	do_test(protect_trylock, MAX_100_MS);
+	do_test(protect_handover, MAX_100_MS);
 
 	return 0;
 }
-- 
2.13.6

