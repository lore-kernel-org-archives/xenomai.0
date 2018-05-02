From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ac9368a5-6f44-64ae-5999-0e60d2d9ffb8@siemens.com>
Date: Wed, 2 May 2018 18:33:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 1/2] testsuite/smokey: Add cond + pp-mutex test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

This stresses the case of fast-path mutex acquire plus pthread_cond_wait
with that mutex, which currently triggers a bug in xnsynch_release.

Along this, drop the HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL conditional -
libboilerplate takes care of that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/posix-cond/posix-cond.c | 96 ++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 24 deletions(-)

diff --git a/testsuite/smokey/posix-cond/posix-cond.c b/testsuite/smokey/posix-cond/posix-cond.c
index 6c9a458b9..153c64599 100644
--- a/testsuite/smokey/posix-cond/posix-cond.c
+++ b/testsuite/smokey/posix-cond/posix-cond.c
@@ -42,27 +42,21 @@ static inline unsigned long long timer_tsc2ns(unsigned long long tsc)
 	return clockobj_tsc_to_ns(tsc);
 }
 
-static int mutex_init(pthread_mutex_t *mutex, int type, int pi)
+static int mutex_init(pthread_mutex_t *mutex, int type, int proto)
 {
 	pthread_mutexattr_t mattr;
 	int err;
 
 	pthread_mutexattr_init(&mattr);
 	pthread_mutexattr_settype(&mattr, type);
-#ifdef HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL
-	if (pi != 0)
-		pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
-
-	err = pthread_mutex_init(mutex, &mattr);
-#else
-	if (pi != 0) {
-		err = ENOSYS;
+	err = pthread_mutexattr_setprotocol(&mattr, proto);
+	if (err)
 		goto out;
-	}
-	err = pthread_mutex_init(mutex, &mattr);
+	if (proto == PTHREAD_PRIO_PROTECT)
+		pthread_mutexattr_setprioceiling(&mattr, 3);
 
+	err = pthread_mutex_init(mutex, &mattr);
   out:
-#endif
 	pthread_mutexattr_destroy(&mattr);
 
 	return -err;
@@ -217,7 +211,8 @@ static void autoinit_simple_condwait(void)
 
 	smokey_trace("%s", __func__);
 
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
 	      thread_spawn(&cond_signaler_tid, 2, cond_signaler, &cm), 0);
@@ -246,7 +241,8 @@ static void simple_condwait(void)
 
 	smokey_trace("%s", __func__);
 
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -271,7 +267,8 @@ static void relative_condwait(void)
 
 	smokey_trace("%s", __func__);
 
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 
@@ -294,7 +291,8 @@ static void autoinit_absolute_condwait(void)
 
 	smokey_trace("%s", __func__);
 
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 
 	start = timer_get_tsc();
@@ -316,7 +314,8 @@ static void absolute_condwait(void)
 
 	smokey_trace("%s", __func__);
 
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 1), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 
@@ -373,7 +372,8 @@ static void sig_norestart_condwait(void)
 	smokey_trace("%s", __func__);
 
 	check_unix("sigaction", sigaction(SIGRTMIN, &sa, NULL), 0);
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -411,7 +411,8 @@ static void sig_restart_condwait(void)
 	smokey_trace("%s", __func__);
 
 	check_unix("sigaction", sigaction(SIGRTMIN, &sa, NULL), 0);
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -465,7 +466,8 @@ static void sig_norestart_condwait_mutex(void)
 	smokey_trace("%s", __func__);
 
 	check_unix("sigaction", sigaction(SIGRTMIN, &sa, NULL), 0);
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -505,7 +507,8 @@ static void sig_restart_condwait_mutex(void)
 	smokey_trace("%s", __func__);
 
 	check_unix("sigaction", sigaction(SIGRTMIN, &sa, NULL), 0);
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -561,7 +564,8 @@ static void sig_norestart_double(void)
 	smokey_trace("%s", __func__);
 
 	check_unix("sigaction", sigaction(SIGRTMIN, &sa, NULL), 0);
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -601,7 +605,8 @@ static void sig_restart_double(void)
 	smokey_trace("%s", __func__);
 
 	check_unix("sigaction", sigaction(SIGRTMIN, &sa, NULL), 0);
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -657,7 +662,8 @@ static void cond_destroy_whilewait(void)
 	smokey_trace("%s", __func__);
 
 	check_unix("sigaction", sigaction(SIGRTMIN, &sa, NULL), 0);
-	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT, 0), 0);
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_NONE), 0);
 	check("cond_init", cond_init(&cond, 0), 0);
 	check("mutex_lock", mutex_lock(&mutex), 0);
 	check("thread_spawn",
@@ -676,6 +682,47 @@ static void cond_destroy_whilewait(void)
 	check("cond_destroy", cond_destroy(&cond), 0);
 }
 
+static void *cond_delayed_signaler(void *cookie)
+{
+	struct cond_mutex *cm = cookie;
+
+	thread_msleep(10);
+
+	check("mutex_lock", mutex_lock(cm->mutex), 0);
+	check("cond_signal", cond_signal(cm->cond), 0);
+	check("mutex_unlock", mutex_unlock(cm->mutex), 0);
+
+	return NULL;
+}
+
+static void cond_ppmutex(void)
+{
+	pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+	pthread_mutex_t mutex;
+	struct cond_mutex cm = {
+		.mutex = &mutex,
+		.cond = &cond,
+	};
+	pthread_t cond_signaler_tid;
+
+	smokey_trace("%s", __func__);
+
+	check("mutex_init", mutex_init(&mutex, PTHREAD_MUTEX_DEFAULT,
+				       PTHREAD_PRIO_PROTECT), 0);
+	check("thread_spawn",
+	      thread_spawn(&cond_signaler_tid, 3, cond_delayed_signaler,
+			   &cm), 0);
+
+	thread_msleep(1);
+	check("mutex_lock", mutex_lock(&mutex), 0);
+
+	check("cond_wait", cond_wait(&cond, &mutex, 0), 0);
+	check("mutex_unlock", mutex_unlock(&mutex), 0);
+	check("thread_join", thread_join(cond_signaler_tid), 0);
+	check("mutex_destroy", mutex_destroy(&mutex), 0);
+	check("cond_destroy", cond_destroy(&cond), 0);
+}
+
 int run_posix_cond(struct smokey_test *t, int argc, char *const argv[])
 {
 	struct sched_param sparam;
@@ -696,6 +743,7 @@ int run_posix_cond(struct smokey_test *t, int argc, char *const argv[])
 	sig_norestart_double();
 	sig_restart_double();
 	cond_destroy_whilewait();
+	cond_ppmutex();
 
 	return 0;
 }
-- 
2.13.6

