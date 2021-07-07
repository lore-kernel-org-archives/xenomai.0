From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/3] testsuite/smokey/gdb: Add test cases for ptrace-based
 debugging helper
Date: Wed,  7 Jul 2021 22:16:17 +0200
Message-Id: <466b2e428a8e7809e26e7d36443fe6b82a27ed1e.1625688977.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625688977.git.jan.kiszka@siemens.com>
References: <cover.1625688977.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Extend the gdb test with cases that stress the debugging helper thread.
We check if the helper is run on hitting a breakpoint as well as before
resuming the process afterwards.

This should be extended in the future by also testing error cases.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/gdb/gdb.c | 84 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index eabf75e6a2..ff97debd32 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -18,6 +18,7 @@
 #include <semaphore.h>
 #include <sys/wait.h>
 #include <xeno_config.h>
+#include <cobalt/ptrace.h>
 #include <boilerplate/libc.h>
 #include <smokey/smokey.h>
 #include "lib/cobalt/current.h"
@@ -65,10 +66,12 @@ smokey_test_plugin(gdb,
 
 static int pipe_in[2], pipe_out[2];
 static volatile unsigned long long thread_loops, expected_loops;
+static volatile unsigned int stop_events, cont_events;
+static volatile int terminate, ptrace_helper_terminated;
 static volatile int primary_mode;
-static volatile int terminate;
 static int child_terminated;
-static sem_t kickoff_lo;
+static sem_t kickoff_lo, kickoff_helper;
+static pthread_t thread_ptrace_helper;
 
 static void handle_sigchld(int signum)
 {
@@ -184,9 +187,61 @@ static void *thread_hi_func(void *arg)
 	breakpoint_target();
 
 	/* 2nd bp: synchronous continue */
+	breakpoint_target();
+
+	err = sem_post(&kickoff_helper);
+	check_no_error("sem_post", err);
+
+	nanosleep(&ts, NULL);
+
+	/* 3rd bp: synchronous stop with ptrace helper in place */
 	expected_loops = thread_loops;
 	breakpoint_target();
+
+	/* 4th bp: synchronous continue with ptrace helper */
+	breakpoint_target();
+
+	/* 5th bp: terminate ptrace helper (and spinning thread) */
 	terminate = 1;
+	err = pthread_cancel(thread_ptrace_helper);
+	check_no_error("pthread_cancel", err);
+	err = pthread_join(thread_ptrace_helper, NULL);
+	check_no_error("pthread_join", err);
+	ptrace_helper_terminated = 1;
+	breakpoint_target();
+
+	return NULL;
+}
+
+static void *thread_ptrace_helper_func(void *arg)
+{
+	int err, event = COBALT_PTRACE_EVENT_STOP;
+
+	pthread_setname_np(pthread_self(), "pthelper");
+
+	err = sem_wait(&kickoff_helper);
+	check_no_error("sem_wait", err);
+
+	err = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
+	check_no_error("pthread_setcanceltype", err);
+
+	err = cobalt_ptrace_helper_init();
+	check_no_error("cobalt_ptrace_helper_init", err);
+
+	while (1) {
+		err = cobalt_ptrace_event_wait(event);
+		check_no_error("cobalt_ptrace_event_wait", err);
+
+		if (event == COBALT_PTRACE_EVENT_STOP) {
+			stop_events++;
+			event = COBALT_PTRACE_EVENT_RESUME;
+		} else {
+			check("event is COBALT_PTRACE_EVENT_RESUME",
+			      event, COBALT_PTRACE_EVENT_RESUME);
+			cont_events++;
+			event = COBALT_PTRACE_EVENT_STOP;
+		}
+	}
 
 	return NULL;
 }
@@ -223,6 +278,8 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 
 		err = sem_init(&kickoff_lo, 0, 0);
 		check_no_error("sem_init", err);
+		err = sem_init(&kickoff_helper, 0, 0);
+		check_no_error("sem_init", err);
 
 		err = pthread_attr_init(&attr);
 		check_no_error("pthread_attr_init", err);
@@ -233,6 +290,13 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 		err = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set), &cpu_set);
 		check_no_error("pthread_attr_setaffinity_np", err);
 
+		params.sched_priority = 3;
+		err = pthread_attr_setschedparam(&attr, &params);
+		check_no_error("pthread_attr_setschedparam", err);
+		err = pthread_create(&thread_ptrace_helper, &attr,
+				     thread_ptrace_helper_func, NULL);
+		check_no_error("pthread_create", err);
+
 		params.sched_priority = 2;
 		err = pthread_attr_setschedparam(&attr, &params);
 		check_no_error("pthread_attr_setschedparam", err);
@@ -293,6 +357,22 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 
 			smokey_trace("synchronous continue");
 			eval_expression("thread_loops==expected_loops", "1");
+			send_command("c\n", 1);
+
+			smokey_trace("stop with event");
+			eval_expression("thread_loops==expected_loops", "1");
+			eval_expression("stop_events", "1");
+			eval_expression("cont_events", "0");
+			send_command("c\n", 1);
+
+			smokey_trace("continue with event");
+			eval_expression("thread_loops==expected_loops", "1");
+			eval_expression("stop_events", "2");
+			eval_expression("cont_events", "1");
+			send_command("c\n", 1);
+
+			smokey_trace("terminate ptrace helper");
+			eval_expression("ptrace_helper_terminated", "1");
 
 			send_command("q\n", 0);
 			pause();
-- 
2.26.2


