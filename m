From: Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH] testsuite/smokey: Do not load .gdbinit in gdb test
Date: Thu, 23 Apr 2020 09:45:35 +0300
Message-Id: <20200423064535.6261-1-vt@altlinux.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

Avoid possible prompt being redefined in `.gdbinit' which could break
gdb test.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 testsuite/smokey/gdb/gdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git testsuite/smokey/gdb/gdb.c testsuite/smokey/gdb/gdb.c
index cc11d2352..eabf75e6a 100644
--- testsuite/smokey/gdb/gdb.c
+++ testsuite/smokey/gdb/gdb.c
@@ -273,7 +273,7 @@ static int run_gdb(struct smokey_test *t, int argc, char *const argv[])
 
 			snprintf(run_param, sizeof(run_param), "--run=%d",
 				 t->__reserved.id);
-			execlp("gdb", "gdb", "--args",
+			execlp("gdb", "gdb", "--nx", "--args",
 			      argv[0], run_param, "run_target", (char *)NULL);
 			_exit(ESRCH);
 
-- 
2.21.0


