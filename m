Subject: [PATCH 7/7] testsuite/smokey: gdb: Catch dup and write errors
References: <cover.1543608201.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0a96c6bb-0c8b-928c-2277-5c31a01c0134@siemens.com>
Date: Tue, 4 Jun 2019 20:32:24 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

Reported by compiler settings in travis.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

There is still one breakage remaining, arm on legacy 4.4, not critical
for 3.1 likely, but I will fix that soon as well.

 testsuite/smokey/gdb/gdb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index a0308d9b2e..fc843cbbbd 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -104,7 +104,10 @@ static void wait_for_pattern(const char *string)
 
 static void send_command(const char *string, int wait_for_prompt)
 {
-	write(pipe_in[1], string, strlen(string));
+	int err;
+
+	err = write(pipe_in[1], string, strlen(string));
+	check_no_error("write(pipe_in)", err);
 	if (wait_for_prompt)
 		wait_for_pattern("(gdb) ");
 }
@@ -142,8 +145,12 @@ static void eval_expression_inner(const char *fn, int line,
 				  const char *expression,
 				  const char *expected_value)
 {
-	write(pipe_in[1], "p ", 2);
-	write(pipe_in[1], expression, strlen(expression));
+	int err;
+
+	err = write(pipe_in[1], "p ", 2);
+	check_no_error("write(pipe_in)", err);
+	err = write(pipe_in[1], expression, strlen(expression));
+	check_no_error("write(pipe_in)", err);
 	send_command("\n", 0);
 
 	check_output(fn, line, expression, "$");
@@ -261,13 +268,16 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 		case 0:
 			/* redirect input */
 			close(0);
-			dup(pipe_in[0]);
+			err = dup(pipe_in[0]);
+			check_no_error("dup(pipe_in)", err);
 
 			/* redirect output and stderr */
 			close(1);
-			dup(pipe_out[1]);
+			err = dup(pipe_out[1]);
+			check_no_error("dup(pipe_out)", err);
 			close(2);
-			dup(1);
+			err = dup(1);
+			check_no_error("dup(1)", err);
 
 			snprintf(run_param, sizeof(run_param), "--run=%d",
 				 t->__reserved.id);
-- 
2.16.4

