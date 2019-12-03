From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 3/7] lib/cobalt: Use new thread_setschedprio syscall
Date: Tue,  3 Dec 2019 12:32:13 +0100
Message-Id: <4e5c96d58adeb69cdb6faaa482b16e74c28b0c60.1575372737.git.jan.kiszka@siemens.com>
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

Switch the implementation of pthread_setschedprio to the new cobalt
syscall in order to avoid scheduler setting corruptions for SCHED_QUOTA
and similar complex policies.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/thread.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
index 86db6343c9..bb23cdcb97 100644
--- a/lib/cobalt/thread.c
+++ b/lib/cobalt/thread.c
@@ -666,11 +666,36 @@ int pthread_setschedparam_ex(pthread_t thread,
 
 COBALT_IMPL(int, pthread_setschedprio, (pthread_t thread, int prio))
 {
-	struct sched_param_ex param_ex = {
-		.sched_priority = prio,
-	};
+	__u32 u_winoff, *u_winoff_ptr;
+	int ret, promoted;
 
-	return pthread_setschedparam_ex(thread, __SCHED_CURRENT, &param_ex);
+	/* See pthread_setschedparam_ex. */
+	if (cobalt_eager_setsched()) {
+		ret = __STD(pthread_setschedprio(thread, prio));
+		if (ret)
+			return ret;
+	}
+
+	/* only request promotion when this targets the current thread */
+	u_winoff_ptr = thread == pthread_self() ? &u_winoff : NULL;
+
+	ret = -XENOMAI_SYSCALL4(sc_cobalt_thread_setschedprio,
+				thread, prio, u_winoff_ptr, &promoted);
+
+	/*
+	 * If the kernel has no reference to the target thread. let glibc
+	 * handle the call.
+	 */
+	if (ret == ESRCH)
+		return __STD(pthread_setschedprio(thread, prio));
+
+	if (ret == 0 && promoted) {
+		cobalt_sigshadow_install_once();
+		cobalt_set_tsd(u_winoff);
+		cobalt_thread_harden();
+	}
+
+	return ret;
 }
 
 /**
-- 
2.16.4


