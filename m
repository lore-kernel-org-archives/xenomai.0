From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2 6/7] testsuite/smokey/leaks: Fix error reporting from child
 to parent process
Date: Wed, 25 Aug 2021 12:32:29 +0200
Message-Id: <20210825103230.27274-7-florian.bezdeka@siemens.com>
In-Reply-To: <20210825103230.27274-1-florian.bezdeka@siemens.com>
References: <20210825103230.27274-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The exit code of the child process was never correctly reported to the
parent process. Hence, the status code check was wrong at all. The
variable previously named subprocess_status was not shared between both
processes.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/leaks/leaks.c | 41 +++++++++++++++-------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/testsuite/smokey/leaks/leaks.c b/testsuite/smokey/leaks/leaks.c
index d5577d85e..bbe5fc3ad 100644
--- a/testsuite/smokey/leaks/leaks.c
+++ b/testsuite/smokey/leaks/leaks.c
@@ -91,9 +91,7 @@ static void *empty(void *cookie)
 	return cookie;
 }
 
-static int subprocess_status;
-
-static inline void subprocess_leak(void)
+static inline int subprocess_leak(void)
 {
 	struct sigevent sevt;
 	pthread_mutex_t mutex;
@@ -105,36 +103,36 @@ static inline void subprocess_leak(void)
 
 	ret = smokey_check_status(pthread_create(&thread, NULL, empty, NULL));
 	if (ret)
-		goto fail;
+		return ret;
 	
 	ret = smokey_check_status(pthread_mutex_init(&mutex, NULL));
 	if (ret)
-		goto fail;
+		return ret;
 	
 	ret = smokey_check_status(pthread_cond_init(&cond, NULL));
 	if (ret)
-		goto fail;
+		return ret;
 
 	ret = smokey_check_errno(sem_init(&sem, 0, 0));
 	if (ret)
-		goto fail;
+		return ret;
 
 	ret = smokey_check_errno(-!(sem_open(SEM_NAME, O_CREAT, 0644, 1)));
 	if (ret)
-		goto fail;
+		return ret;
 
 	sevt.sigev_notify = SIGEV_THREAD_ID;
 	sevt.sigev_signo = SIGALRM;
 	sevt.sigev_notify_thread_id = syscall(__NR_gettid);
 	ret = smokey_check_errno(timer_create(CLOCK_MONOTONIC, &sevt, &tm));
 	if (ret)
-		goto fail;
-	
+		return ret;
+
 	ret = smokey_check_errno(mq_open(MQ_NAME, O_RDWR | O_CREAT, 0644, NULL));
-	if (ret >= 0)
-		return;
-fail:
-	subprocess_status = ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
@@ -143,7 +141,7 @@ static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
 	struct sigevent sevt;
 	pthread_mutex_t mutex;
 	pthread_cond_t cond;
-	int fd, failed = 0, i, ret;
+	int fd, failed = 0, i, ret, child_ret;
 	pthread_t thread;
 	sem_t sem, *psem;
 	timer_t tm;
@@ -235,11 +233,9 @@ static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
 	child = smokey_check_errno(fork());
 	if (child < 0)
 		return child;
-	if (!child) {
-		subprocess_leak();
-		exit(EXIT_SUCCESS);
-	}
-	while (waitpid(child, NULL, 0) == -1 && errno == EINTR);
+	if (!child)
+		exit(-subprocess_leak());
+	while (waitpid(child, &child_ret, 0) == -1 && errno == EINTR);
 	sleep(1);
 
 	ret = smokey_check_errno(sem_unlink(SEM_NAME));
@@ -248,9 +244,8 @@ static int run_leaks(struct smokey_test *t, int argc, char *const argv[])
 	ret = smokey_check_errno(mq_unlink(MQ_NAME));
 	if (ret)
 		return ret;
-	if (subprocess_status)
-		return subprocess_status;
-		
+	if (WIFEXITED(child_ret) && WEXITSTATUS(child_ret))
+		return -WEXITSTATUS(child_ret);
 	check_used("fork", before, failed);
 #endif
 
-- 
2.30.2


