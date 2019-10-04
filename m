From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/2] testsuite/smokey/gdb: Only run basic test if
 _CC_COBALT_DEBUG_SYNC_BP is missing
Message-ID: <f717642d-ab59-c9cd-29b8-ad59af247dba@siemens.com>
Date: Fri, 4 Oct 2019 15:47:10 +0200
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/gdb/gdb.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index a6909d595b..33c16fe876 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -16,6 +16,7 @@
 #include <fcntl.h>
 #include <pthread.h>
 #include <semaphore.h>
+#include <sys/cobalt.h>
 #include <sys/wait.h>
 #include <xeno_config.h>
 #include <boilerplate/libc.h>
@@ -198,6 +199,7 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 	pthread_attr_t attr;
 	char run_param[32];
 	cpu_set_t cpu_set;
+	int corectl_debug;
 	int err;
 
 	smokey_parse_args(t, argc, argv);
@@ -245,6 +247,11 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 	} else {
 		/* we are the gdb controller */
 
+		err = cobalt_corectl(_CC_COBALT_GET_DEBUG, &corectl_debug,
+				    sizeof(corectl_debug));
+		if (err)
+			error(1, -err, "cobalt_corectl");
+
 		signal(SIGCHLD, handle_sigchld);
 
 		err = pipe(pipe_in);
@@ -282,17 +289,24 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 			send_command("b breakpoint_target\n", 1);
 			send_command("r\n", 1);
 
-			smokey_trace("resume in primary");
-			send_command("c\n", 1);
-			eval_expression("primary_mode", "1");
-			send_command("c\n", 1);
-
-			smokey_trace("synchronous stop");
-			eval_expression("thread_loops==expected_loops", "1");
-			send_command("c\n", 1);
-
-			smokey_trace("synchronous continue");
-			eval_expression("thread_loops==expected_loops", "1");
+			if (corectl_debug & _CC_COBALT_DEBUG_SYNC_BP) {
+				smokey_trace("resume in primary");
+				send_command("c\n", 1);
+				eval_expression("primary_mode", "1");
+				send_command("c\n", 1);
+
+				smokey_trace("synchronous stop");
+				eval_expression("thread_loops==expected_loops",
+						"1");
+				send_command("c\n", 1);
+
+				smokey_trace("synchronous continue");
+				eval_expression("thread_loops==expected_loops",
+						"1");
+			} else {
+				smokey_trace("basic continue");
+				send_command("c\n", 1);
+			}
 
 			send_command("q\n", 0);
 			pause();
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

