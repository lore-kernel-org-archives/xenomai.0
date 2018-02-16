From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 16 Feb 2018 14:13:33 +0100
Message-Id: <c1c78f010639a44e60a6138bc3b8e0ce6069606f.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 3/5] smokey/posix-fork: move fork/exec
	functionality into libsmokey
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

One of the following patches will use that function as well.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 include/smokey/smokey.h                  |  8 ++++++
 lib/smokey/helpers.c                     | 31 +++++++++++++++++++++++
 testsuite/smokey/posix-fork/posix-fork.c | 42 ++++----------------------------
 3 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
index 835156335..5fea66c70 100644
--- a/include/smokey/smokey.h
+++ b/include/smokey/smokey.h
@@ -25,6 +25,12 @@
 #include <copperplate/clockobj.h>
 #include <xenomai/init.h>
 
+#ifdef HAVE_FORK
+#define do_fork fork
+#else
+#define do_fork vfork
+#endif
+
 #define SMOKEY_INT(__name) {		\
 	 .name = # __name,		\
 	 .parser = smokey_int,		\
@@ -230,6 +236,8 @@ int smokey_barrier_timedwait(struct smokey_barrier *b,
 			     struct timespec *ts);
   
 void smokey_barrier_release(struct smokey_barrier *b);
+
+int smokey_fork_exec(const char *path, const char *arg);
 	
 #ifdef __cplusplus
 }
diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
index 2b9985d87..fd1fca354 100644
--- a/lib/smokey/helpers.c
+++ b/lib/smokey/helpers.c
@@ -20,7 +20,11 @@
 #include <ctype.h>
 #include <stdlib.h>
 #include <string.h>
+#include <error.h>
 #include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include <boilerplate/ancillaries.h>
 #include <smokey/smokey.h>
 
@@ -239,3 +243,30 @@ void smokey_barrier_release(struct smokey_barrier *b)
 	__RT(pthread_cond_broadcast(&b->barrier));
 	__RT(pthread_mutex_unlock(&b->lock));
 }
+
+int smokey_fork_exec(const char *path, const char *arg)
+{
+	int wstatus = 0;
+	pid_t pid;
+
+	pid = do_fork();
+	switch (pid) {
+	case -1:
+		error(1, errno, "fork/vfork");
+	case 0:
+		execl(path, arg, NULL);
+		error(1, errno, "execl %s", path);
+	default:
+		waitpid(pid, &wstatus, 0);
+	}
+
+	if WIFEXITED(wstatus)
+		return WEXITSTATUS(wstatus);
+
+	if WIFSIGNALED(wstatus)
+		fprintf(stderr, "%s %s\n",
+			strsignal(WTERMSIG(wstatus)),
+			WCOREDUMP(wstatus) ? "(core dumped)" : "");
+	return 1;
+
+}
diff --git a/testsuite/smokey/posix-fork/posix-fork.c b/testsuite/smokey/posix-fork/posix-fork.c
index d88ac527d..57909a67c 100644
--- a/testsuite/smokey/posix-fork/posix-fork.c
+++ b/testsuite/smokey/posix-fork/posix-fork.c
@@ -7,11 +7,6 @@
  */
 #include <stdio.h>
 #include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <error.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <xeno_config.h>
 #include <boilerplate/libc.h>
 #include <smokey/smokey.h>
@@ -21,12 +16,6 @@ smokey_test_plugin(posix_fork,
 		   "Check POSIX fork->exec sequence."
 );
 
-#ifdef HAVE_FORK
-#define do_fork fork
-#else
-#define do_fork vfork
-#endif
-
 /*
  * The purpose of this test is to check whether Cobalt detects and
  * handles a fork->exec sequence properly for Xenomai-enabled threads,
@@ -39,30 +28,9 @@ smokey_test_plugin(posix_fork,
  */
 static int run_posix_fork(struct smokey_test *t, int argc, char *const argv[])
 {
-	int wstatus = 0;
-	pid_t pid;
-
-	pid = do_fork();
-	switch (pid) {
-	case -1:
-		error(1, errno, "fork/vfork");
-	case 0:
-		/*
-		 * Re-exec ourselves without running any test, this is
-		 * enough for creating a shadow context.
-		 */
-		execl(XENO_TEST_DIR "/smokey", "smokey", NULL);
-		error(1, errno, "execl %s/smokey", XENO_TEST_DIR);
-	default:
-		waitpid(pid, &wstatus, 0);
-	}
-
-	if WIFEXITED(wstatus)
-		return WEXITSTATUS(wstatus);
-
-	if WIFSIGNALED(wstatus)
-		fprintf(stderr, "%s %s\n",
-			strsignal(WTERMSIG(wstatus)),
-			WCOREDUMP(wstatus) ? "(core dumped)" : "");
-	return 1;
+	/*
+	 * Re-exec ourselves without running any test, this is
+	 * enough for creating a shadow context.
+	 */
+	return smokey_fork_exec(XENO_TEST_DIR "/smokey", "smokey");
 }
-- 
2.16.1


