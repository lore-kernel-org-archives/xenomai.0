From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey/posix-cond: Make more robust for execution
 in VMs
Message-ID: <630f5fa7-9e54-2e93-44ea-67986ff56b0f@siemens.com>
Date: Wed, 27 Nov 2019 14:38:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Specifically when running over QEMU on ARM64, there are frequent
failures of this test case on check_sleep("mutex_lock"). Apparently,
the context calling thread_spawn runs while the new thread is not yet
executed. When the latter finally will, the creator already released
the mutex, and the sleep check fails. This ensures that both contexts
are running before starting the measurements.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/posix-cond/posix-cond.c | 90 ++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 33 deletions(-)

diff --git a/testsuite/smokey/posix-cond/posix-cond.c b/testsuite/smokey/posix-cond/posix-cond.c
index 53d707d048..e49c44727e 100644
--- a/testsuite/smokey/posix-cond/posix-cond.c
+++ b/testsuite/smokey/posix-cond/posix-cond.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <pthread.h>
+#include <semaphore.h>
 #include <smokey/smokey.h>
 
 smokey_test_plugin(posix_cond,
@@ -42,6 +43,38 @@ static inline unsigned long long timer_tsc2ns(unsigned long long tsc)
 	return clockobj_tsc_to_ns(tsc);
 }
 
+static void check_inner(const char *file, int line, const char *fn, const char *msg, int status, int expected)
+{
+	if (status == expected)
+		return;
+
+	fprintf(stderr, "FAILED %s %s: returned %d instead of %d - %s\n",
+		fn, msg, status, expected, strerror(-status));
+	exit(EXIT_FAILURE);
+}
+#define check(msg, status, expected) \
+	check_inner(__FILE__, __LINE__, __func__, msg, status, expected)
+
+#define check_unix(msg, status, expected)				\
+	({								\
+		int s = (status);					\
+		check_inner(__FILE__, __LINE__, __func__, msg, s < 0 ? -errno : s, expected); \
+	})
+
+static void check_sleep_inner(const char *fn,
+		       const char *prefix, unsigned long long start)
+{
+	unsigned long long diff = timer_tsc2ns(timer_get_tsc() - start);
+
+	if (diff < 10 * NS_PER_MS) {
+		fprintf(stderr, "%s waited %Ld.%03u us\n",
+			prefix, diff / 1000, (unsigned)(diff % 1000));
+		exit(EXIT_FAILURE);
+	}
+}
+#define check_sleep(prefix, start) \
+	check_sleep_inner(__func__, prefix, start)
+
 static int mutex_init(pthread_mutex_t *mutex, int type, int proto)
 {
 	pthread_mutexattr_t mattr;
@@ -120,13 +153,33 @@ static int thread_msleep(unsigned ms)
 	return -nanosleep(&ts, NULL);
 }
 
+struct thread_startup {
+	sem_t ready;
+	void *(*handler)(void *);
+	void *cookie;
+};
+
+static void *thread_trampoline(void *arg)
+{
+	struct thread_startup *startup = arg;
+
+	sem_post(&startup->ready);
+
+	return startup->handler(startup->cookie);
+}
+
 static int thread_spawn(pthread_t *thread, int prio,
 			void *(*handler)(void *cookie), void *cookie)
 {
+	struct thread_startup startup;
 	struct sched_param param;
 	pthread_attr_t tattr;
 	int err;
 
+	sem_init(&startup.ready, 0, 0);
+	startup.handler = handler;
+	startup.cookie = cookie;
+
 	pthread_attr_init(&tattr);
 	pthread_attr_setinheritsched(&tattr, PTHREAD_EXPLICIT_SCHED);
 	pthread_attr_setschedpolicy(&tattr, SCHED_FIFO);
@@ -134,9 +187,12 @@ static int thread_spawn(pthread_t *thread, int prio,
 	pthread_attr_setschedparam(&tattr, &param);
 	pthread_attr_setdetachstate(&tattr, PTHREAD_CREATE_JOINABLE);
 
-	err = pthread_create(thread, &tattr, handler, cookie);
+	err = pthread_create(thread, &tattr, thread_trampoline, &startup);
+
+	check("wait startup", sem_wait(&startup.ready), 0);
 
 	pthread_attr_destroy(&tattr);
+	sem_destroy(&startup.ready);
 
 	return -err;
 }
@@ -145,38 +201,6 @@ static int thread_spawn(pthread_t *thread, int prio,
 #define thread_self() pthread_self()
 #define thread_join(thread) (-pthread_join(thread, NULL))
 
-static void check_inner(const char *file, int line, const char *fn, const char *msg, int status, int expected)
-{
-	if (status == expected)
-		return;
-
-	fprintf(stderr, "FAILED %s %s: returned %d instead of %d - %s\n",
-		fn, msg, status, expected, strerror(-status));
-	exit(EXIT_FAILURE);
-}
-#define check(msg, status, expected) \
-	check_inner(__FILE__, __LINE__, __func__, msg, status, expected)
-
-#define check_unix(msg, status, expected)				\
-	({								\
-		int s = (status);					\
-		check_inner(__FILE__, __LINE__, __func__, msg, s < 0 ? -errno : s, expected); \
-	})
-
-static void check_sleep_inner(const char *fn,
-		       const char *prefix, unsigned long long start)
-{
-	unsigned long long diff = timer_tsc2ns(timer_get_tsc() - start);
-
-	if (diff < 10 * NS_PER_MS) {
-		fprintf(stderr, "%s waited %Ld.%03u us\n",
-			prefix, diff / 1000, (unsigned)(diff % 1000));
-		exit(EXIT_FAILURE);
-	}
-}
-#define check_sleep(prefix, start) \
-	check_sleep_inner(__func__, prefix, start)
-
 struct cond_mutex {
 	pthread_mutex_t *mutex;
 	pthread_cond_t *cond;
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

