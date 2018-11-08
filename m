From: Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] testsuite/xeno-test: do not swallow exit status anymore
Date: Thu,  8 Nov 2018 13:42:02 +0100
Message-Id: <20181108124202.28018-1-henning.schild@siemens.com>
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

xeno-test-run always returned SUCCESS, even if its children exited with
non zero. So xeno-test can not be used programmatically i.e. in CI.

This patch adds some more verbosity and makes xeno-test-run exit FAILURE
if at least one child returned non-zero.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 testsuite/xeno-test/xeno-test-run.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/testsuite/xeno-test/xeno-test-run.c b/testsuite/xeno-test/xeno-test-run.c
index bfede63fd..6d1bb96c0 100644
--- a/testsuite/xeno-test/xeno-test-run.c
+++ b/testsuite/xeno-test/xeno-test-run.c
@@ -51,6 +51,8 @@ void handle_checked_child(struct child *child, fd_set *fds);
 void handle_script_child(struct child *child, fd_set *fds);
 void handle_load_child(struct child *child, fd_set *fds);
 
+static int exit_global = EXIT_SUCCESS;
+
 static inline time_t mono_time(void)
 {
 	struct timespec ts;
@@ -319,6 +321,18 @@ void sigchld_handler(int sig)
 
 		child->exit_status = status;
 		child->dead = 1;
+		fprintf(stderr, "child %d returned: ", pid);
+		if (WIFEXITED(status)) {
+			if (WEXITSTATUS(status))
+				exit_global = EXIT_FAILURE;
+			fprintf(stderr, "exited with status %d\n",
+				WEXITSTATUS(status));
+		} else if WIFSIGNALED(status) {
+			fprintf(stderr, "killed by signal %d\n",
+				WTERMSIG(status));
+		} else {
+			fprintf(stderr, "unknown reason\n");
+		}
 	}
 }
 
@@ -660,5 +674,5 @@ int main(int argc, char *argv[])
 		signal(sigexit, SIG_DFL);
 		raise(sigexit);
 	}
-	exit(EXIT_SUCCESS);
+	exit(exit_global);
 }
-- 
2.19.1


