From: hauptmech <hauptmech@gmail.com>
Subject: Smokey GDB test
Message-ID: <c6b7686a-f939-1ba2-82ae-fb1942a36cbe@gmail.com>
Date: Wed, 24 Jul 2019 18:33:35 +1200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

The smokey GDB test was failing for me.

Xenomai was built with ./configure --enable-smp --enable-pshared on a 
x86_64 system with cobalt

GCC version (Ubuntu 7.4.0-lubuntu1~18.04.1) 7.4.0

GDB version (Ubuntu 8.1-0ubuntu3) 8.1.0.20180409-git

Running the test by hand I found gdb complaining that it did not know 
the type of the expressions.

Casting the type in the expressions as below fixed things for me:

diff --git a/testsuite/smokey/gdb/gdb.c b/testsuite/smokey/gdb/gdb.c
index 2fad3da19..538346a04 100644
--- a/testsuite/smokey/gdb/gdb.c
+++ b/testsuite/smokey/gdb/gdb.c
@@ -285,15 +285,15 @@ static int run_gdb(struct smokey_test *t, int 
argc, char *const argv[])

              smokey_trace("resume in primary");
              send_command("c\n", 1);
-            eval_expression("primary_mode", "1");
+            eval_expression("(int)primary_mode", "1");
              send_command("c\n", 1);

              smokey_trace("synchronous stop");
-            eval_expression("thread_loops==expected_loops", "1");
+            eval_expression("(unsigned long 
long)thread_loops==(unsigned long long)expected_loops", "1");
              send_command("c\n", 1);

              smokey_trace("synchronous continue");
-            eval_expression("thread_loops==expected_loops", "1");
+            eval_expression("(unsigned long 
long)thread_loops==(unsigned long long)expected_loops", "1");

              send_command("q\n", 0);
              pause();


