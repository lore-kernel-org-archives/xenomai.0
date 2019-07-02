From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite: Smokey: Use argv[0] in favor of hard-coded paths
Message-ID: <38b922cd-4192-d558-fe1b-77ce3cacd93b@siemens.com>
Date: Tue, 2 Jul 2019 18:30:17 +0200
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

Whenever possible (dlopen test excluded so far), use argv[0] when
calling the smokey binary again or running it under gdb. This reduces
the dependency on hard-coded paths and also supports invocation from the
build folder.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/gdb/gdb.c               | 3 +--
 testsuite/smokey/posix-fork/posix-fork.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index 2fad3da19a..a6909d595b 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -274,8 +274,7 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 			snprintf(run_param, sizeof(run_param), "--run=%d",
 				 t->__reserved.id);
 			execl("/usr/bin/gdb", "gdb", "--args",
-			      CONFIG_XENO_PREFIX "/bin/smokey", run_param,
-			      "run_target", NULL);
+			      argv[0], run_param, "run_target", NULL);
 			_exit(ESRCH);
 
 		default:
diff --git a/testsuite/smokey/posix-fork/posix-fork.c b/testsuite/smokey/posix-fork/posix-fork.c
index 57909a67ce..3541a8a9ff 100644
--- a/testsuite/smokey/posix-fork/posix-fork.c
+++ b/testsuite/smokey/posix-fork/posix-fork.c
@@ -32,5 +32,5 @@ static int run_posix_fork(struct smokey_test *t, int argc, char *const argv[])
 	 * Re-exec ourselves without running any test, this is
 	 * enough for creating a shadow context.
 	 */
-	return smokey_fork_exec(XENO_TEST_DIR "/smokey", "smokey");
+	return smokey_fork_exec(argv[0], "smokey");
 }
-- 
2.16.4

