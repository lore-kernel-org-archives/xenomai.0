From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 16 Feb 2018 14:13:32 +0100
Message-Id: <c1e52ea5a49bf0649acccc1be65458d3cf6f7e2c.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 2/5] smokey/posix-fork: actually wait for the
	process to exit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The comment says that it would be enough to just trigger the chain of
events. This test did not even fail if the binary to execute was not
there, not sure how much of the chain was exercised.
This patch makes the parent wait for what actually happens and should
return errors, should they happen. It prepares for another patch using
fork/exec.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 testsuite/smokey/posix-fork/posix-fork.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/testsuite/smokey/posix-fork/posix-fork.c b/testsuite/smokey/posix-fork/posix-fork.c
index 8a44510b3..d88ac527d 100644
--- a/testsuite/smokey/posix-fork/posix-fork.c
+++ b/testsuite/smokey/posix-fork/posix-fork.c
@@ -10,6 +10,8 @@
 #include <unistd.h>
 #include <errno.h>
 #include <error.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include <xeno_config.h>
 #include <boilerplate/libc.h>
 #include <smokey/smokey.h>
@@ -37,9 +39,11 @@ smokey_test_plugin(posix_fork,
  */
 static int run_posix_fork(struct smokey_test *t, int argc, char *const argv[])
 {
-	struct timespec req;
+	int wstatus = 0;
+	pid_t pid;
 
-	switch (do_fork()) {
+	pid = do_fork();
+	switch (pid) {
 	case -1:
 		error(1, errno, "fork/vfork");
 	case 0:
@@ -48,12 +52,17 @@ static int run_posix_fork(struct smokey_test *t, int argc, char *const argv[])
 		 * enough for creating a shadow context.
 		 */
 		execl(XENO_TEST_DIR "/smokey", "smokey", NULL);
-		_exit(99);
+		error(1, errno, "execl %s/smokey", XENO_TEST_DIR);
 	default:
-		req.tv_sec = 0;
-		req.tv_nsec = 20000000;
-		clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
+		waitpid(pid, &wstatus, 0);
 	}
 
-	return 0;
+	if WIFEXITED(wstatus)
+		return WEXITSTATUS(wstatus);
+
+	if WIFSIGNALED(wstatus)
+		fprintf(stderr, "%s %s\n",
+			strsignal(WTERMSIG(wstatus)),
+			WCOREDUMP(wstatus) ? "(core dumped)" : "");
+	return 1;
 }
-- 
2.16.1


