From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH v2 5/5] smokey: add tests for mutex/condvar autoinit
Date: Thu,  7 Mar 2019 14:31:56 +0100
Message-Id: <20190307133156.31749-6-norbert.lange@andritz.com>
In-Reply-To: <20190307133156.31749-1-norbert.lange@andritz.com>
References: <20190307133156.31749-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

add a few testcases where destroy is called as first function,
and test failure if the state is a non-standard initializer.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 testsuite/smokey/posix-cond/posix-cond.c   | 14 +++++++
 testsuite/smokey/posix-mutex/posix-mutex.c | 47 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/testsuite/smokey/posix-cond/posix-cond.c b/testsuite/smokey/posix-cond/posix-cond.c
index 153c64599..ad915c724 100644
--- a/testsuite/smokey/posix-cond/posix-cond.c
+++ b/testsuite/smokey/posix-cond/posix-cond.c
@@ -198,6 +198,19 @@ static void *cond_signaler(void *cookie)
 	return NULL;
 }
 
+static void autoinit_simple_conddestroy(void)
+{
+	pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+	pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;
+	unsigned invalmagic = ~0x86860505; // ~COBALT_COND_MAGIC
+
+	memcpy((char *)&cond2 + sizeof(cond2) - sizeof(invalmagic), &invalmagic, sizeof(invalmagic));
+
+	smokey_trace("%s", __func__);
+	check("cond_destroy", cond_destroy(&cond), 0);
+	check("cond_destroy invalid", cond_destroy(&cond2), -EINVAL);
+}
+
 static void autoinit_simple_condwait(void)
 {
 	pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
@@ -731,6 +744,7 @@ int run_posix_cond(struct smokey_test *t, int argc, char *const argv[])
 	sparam.sched_priority = 2;
 	pthread_setschedparam(pthread_self(), SCHED_FIFO, &sparam);
 
+	autoinit_simple_conddestroy();
 	autoinit_simple_condwait();
 	simple_condwait();
 	relative_condwait();
diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
index 182f8c0e5..a42c52033 100644
--- a/testsuite/smokey/posix-mutex/posix-mutex.c
+++ b/testsuite/smokey/posix-mutex/posix-mutex.c
@@ -296,6 +296,28 @@ static int do_contend(pthread_mutex_t *mutex, int type)
 	return 0;
 }
 
+static int do_destroy(pthread_mutex_t *mutex, pthread_mutex_t *invalmutex, int type)
+{
+	int ret;
+	if (!__T(ret, pthread_mutex_destroy(mutex)))
+		return ret;
+	if (!__F(ret, pthread_mutex_destroy(invalmutex)) &&
+		__Tassert(ret == -EINVAL))
+		return -1;
+	return 0;
+}
+
+static int static_init_normal_destroy(void)
+{
+	pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+	pthread_mutex_t invalmutex = PTHREAD_MUTEX_INITIALIZER;
+
+	unsigned invalmagic = ~0x86860303; // ~COBALT_MUTEX_MAGIC
+
+	memcpy((char *)&invalmutex + sizeof(invalmutex) - sizeof(invalmagic), &invalmagic, sizeof(invalmagic));
+	return do_destroy(&mutex, &invalmutex, PTHREAD_MUTEX_NORMAL);
+}
+
 static int static_init_normal_contend(void)
 {
 	pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -320,6 +342,17 @@ static int dynamic_init_normal_contend(void)
 	return __dynamic_init_contend(PTHREAD_MUTEX_NORMAL);
 }
 
+static int static_init_recursive_destroy(void)
+{
+	pthread_mutex_t mutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
+	pthread_mutex_t invalmutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
+
+	unsigned invalmagic = ~0x86860303; // ~COBALT_MUTEX_MAGIC
+
+	memcpy((char *)&invalmutex + sizeof(invalmutex) - sizeof(invalmagic), &invalmagic, sizeof(invalmagic));
+	return do_destroy(&mutex, &invalmutex, PTHREAD_MUTEX_RECURSIVE);
+}
+
 static int static_init_recursive_contend(void)
 {
 	pthread_mutex_t mutex = PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP;
@@ -332,6 +365,17 @@ static int dynamic_init_recursive_contend(void)
 	return __dynamic_init_contend(PTHREAD_MUTEX_RECURSIVE);
 }
 
+static int static_init_errorcheck_destroy(void)
+{
+	pthread_mutex_t mutex = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
+	pthread_mutex_t invalmutex = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
+
+	unsigned invalmagic = ~0x86860303; // ~COBALT_MUTEX_MAGIC
+
+	memcpy((char *)&invalmutex + sizeof(invalmutex) - sizeof(invalmagic), &invalmagic, sizeof(invalmagic));
+	return do_destroy(&mutex, &invalmutex, PTHREAD_MUTEX_ERRORCHECK);
+}
+
 static int static_init_errorcheck_contend(void)
 {
 	pthread_mutex_t mutex = PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP;
@@ -991,10 +1035,13 @@ static int run_posix_mutex(struct smokey_test *t, int argc, char *const argv[])
 					    SCHED_FIFO, &param)))
 		return ret;
 
+	do_test(static_init_normal_destroy, MAX_100_MS);
 	do_test(static_init_normal_contend, MAX_100_MS);
 	do_test(dynamic_init_normal_contend, MAX_100_MS);
+	do_test(static_init_recursive_destroy, MAX_100_MS);
 	do_test(static_init_recursive_contend, MAX_100_MS);
 	do_test(dynamic_init_recursive_contend, MAX_100_MS);
+	do_test(static_init_errorcheck_destroy, MAX_100_MS);
 	do_test(static_init_errorcheck_contend, MAX_100_MS);
 	do_test(dynamic_init_errorcheck_contend, MAX_100_MS);
 	do_test(timed_contend, MAX_100_MS);
-- 
2.20.1


