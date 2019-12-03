From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 6/7] testsuite/smokey: Add pthread_setschedprio to setsched
 test case
Date: Tue,  3 Dec 2019 12:32:16 +0100
Message-Id: <32cce80f7a2c715d03b57548adf6853916245883.1575372737.git.jan.kiszka@siemens.com>
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

Now that this path goes via an own syscall, better test it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/setsched/setsched.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/testsuite/smokey/setsched/setsched.c b/testsuite/smokey/setsched/setsched.c
index 16bfc49571..fc348a86ed 100644
--- a/testsuite/smokey/setsched/setsched.c
+++ b/testsuite/smokey/setsched/setsched.c
@@ -102,6 +102,27 @@ static void *thread_body(void *arg)
 
 	check_linux_schedparams(SCHED_FIFO, 2);
 
+	cobalt_thread_harden();
+
+#ifdef CONFIG_XENO_LAZY_SETSCHED
+	if (smokey_check_status(cobalt_thread_stat(thread_pid, &stats)))
+		pthread_exit((void *)(long)-EINVAL);
+	msw = stats.msw;
+#endif
+
+	if (smokey_check_status(pthread_setschedprio(pthread_self(), 3)))
+		pthread_exit((void *)(long)-EINVAL);
+
+	check_rt_schedparams(SCHED_FIFO, 3);
+
+#ifdef CONFIG_XENO_LAZY_SETSCHED
+	if (smokey_check_status(cobalt_thread_stat(thread_pid, &stats)) ||
+	    !smokey_assert(stats.msw == msw))
+		pthread_exit((void *)(long)-EINVAL);
+#endif
+
+	check_linux_schedparams(SCHED_FIFO, 3);
+
 	return (void *)0L;
 }
 
-- 
2.16.4


