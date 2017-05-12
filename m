From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 12 May 2017 13:41:45 +0200
Message-Id: <20170512114145.20024-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH] smokey/sigdebug: check kernel features with
	corectl
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

One of the subtests depends on a kernel feature, skip it if the feature
was not enabled.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 testsuite/smokey/sigdebug/sigdebug.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/sigdebug/sigdebug.c b/testsuite/smokey/sigdebug/sigdebug.c
index a643305..87f0be6 100644
--- a/testsuite/smokey/sigdebug/sigdebug.c
+++ b/testsuite/smokey/sigdebug/sigdebug.c
@@ -33,6 +33,7 @@ smokey_test_plugin(sigdebug,
 unsigned int expected_reason;
 bool sigdebug_received;
 pthread_mutex_t prio_invert;
+int corectl_debug;
 sem_t send_signal;
 char *mem;
 FILE *wd;
@@ -110,10 +111,15 @@ static void *rt_thread_body(void *cookie)
 	check_sigdebug_received("SIGDEBUG_MIGRATE_SIGNAL");
 
 	smokey_trace("relaxed mutex owner");
-	setup_checkdebug(SIGDEBUG_MIGRATE_PRIOINV);
-	err = pthread_mutex_lock(&prio_invert);
-	check_no_error("pthread_mutex_lock", err);
-	check_sigdebug_received("SIGDEBUG_MIGRATE_PRIOINV");
+	if (corectl_debug & _CC_COBALT_DEBUG_MUTEX_RELAXED) {
+		setup_checkdebug(SIGDEBUG_MIGRATE_PRIOINV);
+		err = pthread_mutex_lock(&prio_invert);
+		check_no_error("pthread_mutex_lock", err);
+		check_sigdebug_received("SIGDEBUG_MIGRATE_PRIOINV");
+	} else {
+		smokey_note("sigdebug \"SIGDEBUG_MIGRATE_PRIOINV\" skipped "
+			    "(no kernel support)");
+	}
 
 	smokey_trace("page fault");
 	setup_checkdebug(SIGDEBUG_MIGRATE_FAULT);
@@ -189,6 +195,11 @@ static int run_sigdebug(struct smokey_test *t, int argc, char *const argv[])
 	if (err || wdog_delay == 0)
 		return -ENOSYS;
 
+	err = cobalt_corectl(_CC_COBALT_GET_DEBUG, &corectl_debug,
+			     sizeof(corectl_debug));
+	if (err)
+		return -ENOSYS;
+
 	smokey_parse_args(t, argc, argv);
 	if (!SMOKEY_ARG_ISSET(sigdebug, no_watchdog) ||
 	    !SMOKEY_ARG_BOOL(sigdebug, no_watchdog)) {
-- 
2.10.2


