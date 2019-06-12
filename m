From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/5] testsuite/smokey/gdb: Cleanup check helpers
Date: Wed, 12 Jun 2019 17:31:15 +0200
Message-Id: <930e7852f249badbd1e4bc96be9222cfe8e075db.1560353478.git.jan.kiszka@siemens.com>
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

check_inner() is only called with exp_flag = 1.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/gdb/gdb.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index 7a20314e0b..2fad3da19a 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -25,37 +25,29 @@
 static void send_command(const char *string, int wait_for_prompt);
 
 static void check_inner(const char *fn, int line, const char *msg,
-			int status, int expected, int exp_flag)
+			int status, int expected)
 {
-	if (exp_flag) {
-		if (status == expected)
-			return;
-	}
-	else if (status != -1)
-			return;
+	if (status == expected)
+		return;
 
 	rt_print_flush_buffers();
-	if (exp_flag)
-		fprintf(stderr, "FAILURE %s:%d: %s returned %d instead of %d - %s\n",
-				fn, line, msg, status, expected, strerror(status));
-	else
-		fprintf(stderr, "FAILURE %s:%d: %s returned %d [errno=%d] - %s\n",
-				fn, line, msg, status, expected, strerror(expected));
+	fprintf(stderr, "FAILURE %s:%d: %s returned %d instead of %d - %s\n",
+		fn, line, msg, status, expected, strerror(status));
 	send_command("q\n", 0);
 	exit(EXIT_FAILURE);
 }
 
 #define check(msg, status, expected) ({					\
-int __status = status;						\
-check_inner(__FUNCTION__, __LINE__, msg, __status, expected, 1);	\
-__status;							\
+	int __status = status;						\
+	check_inner(__FUNCTION__, __LINE__, msg, __status, expected);	\
+	__status;							\
 })
 
 #define check_no_error(msg, status) ({					\
-int __status = status;						\
-check_inner(__FUNCTION__, __LINE__, msg,			\
-__status < 0 ? errno : __status, 0, 1);			\
-__status;							\
+	int __status = status;						\
+	check_inner(__func__, __LINE__, msg,				\
+		    __status < 0 ? errno : __status, 0);		\
+	__status;							\
 })
 
 smokey_test_plugin(gdb,
-- 
2.16.4


