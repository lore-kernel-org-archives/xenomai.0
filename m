From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey/sched-quote: Fix throttling
Message-ID: <be15f4cb-3e13-c200-fcac-c2440c1b88a8@siemens.com>
Date: Sat, 6 Mar 2021 09:31:20 +0100
MIME-Version: 1.0
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
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

A missing volatile caused some compiler versions (e.g. gcc-8) to skip
updating the variable inside the loop. At this chance, drop the
pointless and misleading usage of atomic_t for this variable.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/sched-quota/sched-quota.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index ff7c584e39..acb9055fd0 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -18,7 +18,6 @@
 #include <sys/cobalt.h>
 #include <boilerplate/time.h>
 #include <boilerplate/ancillaries.h>
-#include <boilerplate/atomic.h>
 #include <smokey/smokey.h>
 
 smokey_test_plugin(sched_quota,
@@ -60,7 +59,7 @@ static int started;
 
 static sem_t ready;
 
-static atomic_t throttle;
+static volatile int throttle;
 
 static unsigned long __attribute__(( noinline ))
 __do_work(unsigned long count)
@@ -98,7 +97,7 @@ static void *thread_body(void *arg)
 
 	for (;;) {
 		do_work(loops, count_r);
-		if (atomic_read(&throttle))
+		if (throttle)
 			sleep(1);
 		else if (nrthreads > 1)
 			sched_yield();
@@ -204,7 +203,7 @@ static double run_quota(int quota)
 
 	percent = ((double)count / TEST_SECS) * 100.0 / loops_per_sec;
 
-	atomic_set(&throttle, 1);
+	throttle = 1;
 	smp_wmb();
 
 	for (n = 0; n < nrthreads; n++) {
@@ -259,7 +258,7 @@ static unsigned long long calibrate(void)
 	for (n = 0, lps = 0; n < nrthreads; n++)
 		lps += counts[n];
 
-	atomic_set(&throttle, 1);
+	throttle = 1;
 	smp_wmb();
 
 	for (n = 0; n < nrthreads; n++) {
@@ -268,7 +267,7 @@ static unsigned long long calibrate(void)
 	}
 
 	started = 0;
-	atomic_set(&throttle, 0);
+	throttle = 0;
 
 	return lps;
 }
-- 
2.26.2

