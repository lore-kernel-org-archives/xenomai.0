From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/5] testsuite/smokey/sigdebug: Fix check_no_error and some
 callers
Date: Wed, 12 Jun 2019 17:31:18 +0200
Message-Id: <7431454cc26eb2554c2f0ab706602585cad71e23.1560353478.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1560353478.git.jan.kiszka@siemens.com>
References: <cover.1560353478.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1560353478.git.jan.kiszka@siemens.com>
References: <cover.1560353478.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Aligning check_no_error with the gdb test case revealed a number of
smaller issues in the sigdebug test - and the bigger one with syscall
restarted fixed in "cobalt/thread: Clear XNSYSRST when migrating to
Linux".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/sigdebug/sigdebug.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testsuite/smokey/sigdebug/sigdebug.c b/testsuite/smokey/sigdebug/sigdebug.c
index 87f0be6310..15f9e4dae3 100644
--- a/testsuite/smokey/sigdebug/sigdebug.c
+++ b/testsuite/smokey/sigdebug/sigdebug.c
@@ -1,10 +1,10 @@
 /*
  * Functional testing of unwanted domain switch debugging mechanism.
  *
- * Copyright (C) Siemens AG, 2012-2014
+ * Copyright (C) Siemens AG, 2012-2019
  *
  * Authors:
- *  Jan Kiszka  <jan.kiszka@siemens.com>
+ *  Jan Kiszka <jan.kiszka@siemens.com>
  *
  * Released under the terms of GPLv2.
  */
@@ -53,7 +53,7 @@ static void check_inner(const char *fn, int line, const char *msg,
 	pthread_setmode_np(PTHREAD_WARNSW, 0, NULL);
 	rt_print_flush_buffers();
 	fprintf(stderr, "FAILURE %s:%d: %s returned %d instead of %d - %s\n",
-		fn, line, msg, status, expected, strerror(-status));
+		fn, line, msg, status, expected, strerror(status));
 	exit(EXIT_FAILURE);
 }
 
@@ -77,7 +77,7 @@ static void check_sigdebug_inner(const char *fn, int line, const char *reason)
 #define check_no_error(msg, status) ({					\
 	int __status = status;						\
 	check_inner(__func__, __LINE__, msg,				\
-		    __status < 0 ? __status : 0, 0);			\
+		    __status < 0 ? errno : __status, 0);		\
 	__status;							\
 })
 
@@ -107,7 +107,7 @@ static void *rt_thread_body(void *cookie)
 	err = sem_post(&send_signal);
 	check_no_error("sem_post", err);
 	err = clock_nanosleep(CLOCK_MONOTONIC, 0, &delay, NULL);
-	check_no_error("clock_nanosleep", err);
+	check("clock_nanosleep", err, EINTR);
 	check_sigdebug_received("SIGDEBUG_MIGRATE_SIGNAL");
 
 	smokey_trace("relaxed mutex owner");
@@ -116,6 +116,8 @@ static void *rt_thread_body(void *cookie)
 		err = pthread_mutex_lock(&prio_invert);
 		check_no_error("pthread_mutex_lock", err);
 		check_sigdebug_received("SIGDEBUG_MIGRATE_PRIOINV");
+		err = pthread_mutex_unlock(&prio_invert);
+		check_no_error("pthread_mutex_unlock", err);
 	} else {
 		smokey_note("sigdebug \"SIGDEBUG_MIGRATE_PRIOINV\" skipped "
 			    "(no kernel support)");
@@ -263,7 +265,8 @@ static int run_sigdebug(struct smokey_test *t, int argc, char *const argv[])
 	munlockall();
 	setup_checkdebug(SIGDEBUG_NOMLOCK);
 	err = pthread_create(&rt_thread, &attr, rt_thread_body, NULL);
-	check("pthread_setschedparam", err, EINTR);
+	/* Note: EINTR is against the spec, but that's OK in this scenario. */
+	check("pthread_create", err, EINTR);
 	check_sigdebug_received("SIGDEBUG_NOMLOCK");
 	mlockall(MCL_CURRENT | MCL_FUTURE);
 
-- 
2.16.4


