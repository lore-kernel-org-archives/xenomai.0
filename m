From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/5] testsuite/smokey/gdb: Catch dup and write errors
Date: Wed, 12 Jun 2019 17:31:14 +0200
Message-Id: <11a1d6e0d78c2190137ae0a05ff1ab916f4d21cd.1560353478.git.jan.kiszka@siemens.com>
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

Reported by compiler settings in travis.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/gdb/gdb.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index a0308d9b2e..7a20314e0b 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -1,7 +1,7 @@
 /*
  * gdb test.
  *
- * Copyright (C) Siemens AG, 2015
+ * Copyright (C) Siemens AG, 2015-2019
  *
  * Authors.
  *  Jan Kiszka <jan.kiszka@siemens.com>
@@ -104,7 +104,10 @@ static void wait_for_pattern(const char *string)
 
 static void send_command(const char *string, int wait_for_prompt)
 {
-	write(pipe_in[1], string, strlen(string));
+	int ret;
+
+	ret = write(pipe_in[1], string, strlen(string));
+	check("write(pipe_in)", ret, strlen(string));
 	if (wait_for_prompt)
 		wait_for_pattern("(gdb) ");
 }
@@ -142,8 +145,12 @@ static void eval_expression_inner(const char *fn, int line,
 				  const char *expression,
 				  const char *expected_value)
 {
-	write(pipe_in[1], "p ", 2);
-	write(pipe_in[1], expression, strlen(expression));
+	int ret;
+
+	ret = write(pipe_in[1], "p ", 2);
+	check("write(pipe_in)", ret, 2);
+	ret = write(pipe_in[1], expression, strlen(expression));
+	check("write(pipe_in)", ret, strlen(expression));
 	send_command("\n", 0);
 
 	check_output(fn, line, expression, "$");
@@ -261,13 +268,16 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 		case 0:
 			/* redirect input */
 			close(0);
-			dup(pipe_in[0]);
+			err = dup(pipe_in[0]);
+			check_no_error("dup(pipe_in)", err < 0 ? err : 0);
 
 			/* redirect output and stderr */
 			close(1);
-			dup(pipe_out[1]);
+			err = dup(pipe_out[1]);
+			check_no_error("dup(pipe_out)", err < 0 ? err : 0);
 			close(2);
-			dup(1);
+			err = dup(1);
+			check_no_error("dup(1)", err < 0 ? err : 0);
 
 			snprintf(run_param, sizeof(run_param), "--run=%d",
 				 t->__reserved.id);
-- 
2.16.4


