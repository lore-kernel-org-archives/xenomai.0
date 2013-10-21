Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <31c8dbe8d4bce4a0827e.1382364573@devws164.be.alcatel-lucent.com>
In-Reply-To: <patchbomb.1382364570@devws164.be.alcatel-lucent.com>
References: <patchbomb.1382364570@devws164.be.alcatel-lucent.com>
Date: Mon, 21 Oct 2013 16:09:33 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 3 of 3 v2] Xenomai-forge extend psos testsuite
	task-9
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Extend the task-9 test with different root task priorities and
with both incrementing and decrementing priorities for the test tasks.

Signed-off-by: Kim De Mey <kim.demey@gmail.com>

---

 lib/psos/testsuite/task-9.c |  38 ++++++++++++++++++++++++++++++++++++--
 1 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/lib/psos/testsuite/task-9.c b/lib/psos/testsuite/task-9.c
--- a/lib/psos/testsuite/task-9.c
+++ b/lib/psos/testsuite/task-9.c
@@ -14,7 +14,7 @@ static void test_task(u_long a0, u_long 
 	traceobj_exit(&trobj);
 }
 
-static void root_task(u_long a0, u_long a1, u_long a2, u_long a3)
+static void root_task(u_long increment, u_long a1, u_long a2, u_long a3)
 {
 	u_long args[] = { 1, 2, 3, 4 }, ret, tid;
 	int n;
@@ -22,7 +22,10 @@ static void root_task(u_long a0, u_long 
 	traceobj_enter(&trobj);
 
 	for (n = 0; n < 512; n++) {
-		ret = t_create ("TEST", (n % MAX_PRIO) + 2,100000, 0, 0, &tid);
+		if(increment)
+			ret = t_create ("TEST", (n % MAX_PRIO) + 2,100000, 0, 0, &tid);
+		else
+			ret = t_create ("TEST", MAX_PRIO - (n % MAX_PRIO) + 1,100000, 0, 0, &tid);
 		traceobj_assert(&trobj, ret == SUCCESS);
 		ret = t_start(tid, T_PREEMPT, test_task, args);
 		traceobj_assert(&trobj, ret == SUCCESS);
@@ -39,6 +42,7 @@ int main(int argc, char *const argv[])
 
 	traceobj_init(&trobj, argv[0], 0);
 
+	// Low priority root task, loop incr. priority test tasks
 	ret = t_create("root", 3, 0, 0, 0, &tid);
 	traceobj_assert(&trobj, ret == SUCCESS);
 
@@ -47,5 +51,35 @@ int main(int argc, char *const argv[])
 
 	traceobj_join(&trobj);
 
+	// Low priority root task, loop decr. priority test tasks
+	args[0] = 0;
+	ret = t_create("root", 3, 0, 0, 0, &tid);
+	traceobj_assert(&trobj, ret == SUCCESS);
+
+	ret = t_start(tid, 0, root_task, args);
+	traceobj_assert(&trobj, ret == SUCCESS);
+
+	traceobj_join(&trobj);
+
+	// High priority root task, loop incr. priority test tasks
+	args[0] = 1;
+	ret = t_create("root", 90, 0, 0, 0, &tid);
+	traceobj_assert(&trobj, ret == SUCCESS);
+
+	ret = t_start(tid, 0, root_task, args);
+	traceobj_assert(&trobj, ret == SUCCESS);
+
+	traceobj_join(&trobj);
+
+	// High priority root task, loop decr. priority test tasks 
+	args[0] = 0;
+	ret = t_create("root", 90, 0, 0, 0, &tid);
+	traceobj_assert(&trobj, ret == SUCCESS);
+
+	ret = t_start(tid, 0, root_task, args);
+	traceobj_assert(&trobj, ret == SUCCESS);
+	
+	traceobj_join(&trobj);
+
 	exit(0);
 }

