From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 16 Feb 2018 14:13:31 +0100
Message-Id: <b7fcf8fd039b1511ba3c8274b7aedd420a71c94e.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/5] smokey/posix-fork: fix binary path for
	configure --with-testdir
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

./configure allows to place test binaries in a non-default location.
Change the testcase to still find the "smokey" executable.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 testsuite/smokey/posix-fork/Makefile.am  | 5 +++--
 testsuite/smokey/posix-fork/posix-fork.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/posix-fork/Makefile.am b/testsuite/smokey/posix-fork/Makefile.am
index c4232cfd3..516c243be 100644
--- a/testsuite/smokey/posix-fork/Makefile.am
+++ b/testsuite/smokey/posix-fork/Makefile.am
@@ -5,6 +5,7 @@ libposix_fork_a_SOURCES = posix-fork.c
 
 CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
-libposix_fork_a_CPPFLAGS = 	\
-	@XENO_USER_CFLAGS@	\
+libposix_fork_a_CPPFLAGS =			\
+	@XENO_USER_CFLAGS@			\
+	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'	\
 	-I$(top_srcdir)/include
diff --git a/testsuite/smokey/posix-fork/posix-fork.c b/testsuite/smokey/posix-fork/posix-fork.c
index bb809e176..8a44510b3 100644
--- a/testsuite/smokey/posix-fork/posix-fork.c
+++ b/testsuite/smokey/posix-fork/posix-fork.c
@@ -47,7 +47,7 @@ static int run_posix_fork(struct smokey_test *t, int argc, char *const argv[])
 		 * Re-exec ourselves without running any test, this is
 		 * enough for creating a shadow context.
 		 */
-		execl(CONFIG_XENO_PREFIX "/bin/smokey", "smokey", NULL);
+		execl(XENO_TEST_DIR "/smokey", "smokey", NULL);
 		_exit(99);
 	default:
 		req.tv_sec = 0;
-- 
2.16.1


