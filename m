From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 5/7] testsuite/smokey: Fix setsched /wrt lazy scheduling
 parameter application
Date: Tue,  3 Dec 2019 12:32:15 +0100
Message-Id: <23ff1e3f022cd86e3d01a4aa9d42721d461475b8.1575372737.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575372737.git.jan.kiszka@siemens.com>
References: <cover.1575372737.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575372737.git.jan.kiszka@siemens.com>
References: <cover.1575372737.git.jan.kiszka@siemens.com>
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

As we didn't migrate to RT, we didn't test properly if lazy parameter
application actually works. Fix that, also taking into account the
related config switch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/setsched/setsched.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/setsched/setsched.c b/testsuite/smokey/setsched/setsched.c
index f227f654cc..16bfc49571 100644
--- a/testsuite/smokey/setsched/setsched.c
+++ b/testsuite/smokey/setsched/setsched.c
@@ -68,18 +68,24 @@ static void __check_rt_schedparams(int expected_policy, int expected_prio,
 
 static void *thread_body(void *arg)
 {
-	struct cobalt_threadstat stats;
 	struct sched_param param;
+#ifdef CONFIG_XENO_LAZY_SETSCHED
+	struct cobalt_threadstat stats;
 	unsigned long long msw;
+#endif
 
 	thread_pid = syscall(SYS_gettid);
 
 	check_rt_schedparams(SCHED_FIFO, 1);
 	check_linux_schedparams(SCHED_FIFO, 1);
 
+	cobalt_thread_harden();
+
+#ifdef CONFIG_XENO_LAZY_SETSCHED
 	if (smokey_check_status(cobalt_thread_stat(thread_pid, &stats)))
 		pthread_exit((void *)(long)-EINVAL);
 	msw = stats.msw;
+#endif
 
 	param.sched_priority = 2;
 	if (smokey_check_status(pthread_setschedparam(pthread_self(),
@@ -88,9 +94,11 @@ static void *thread_body(void *arg)
 
 	check_rt_schedparams(SCHED_FIFO, 2);
 
+#ifdef CONFIG_XENO_LAZY_SETSCHED
 	if (smokey_check_status(cobalt_thread_stat(thread_pid, &stats)) ||
 	    !smokey_assert(stats.msw == msw))
 		pthread_exit((void *)(long)-EINVAL);
+#endif
 
 	check_linux_schedparams(SCHED_FIFO, 2);
 
-- 
2.16.4


