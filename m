Message-ID: <4E0C439B.8090908@domain.hid>
Date: Thu, 30 Jun 2011 11:36:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/2] native: Do not acquire non-existent MPS
	fastlock
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Fix a build warning at this chance as well.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Applies on top of xenomai-gch.git gch/u_mode

 ksrc/skins/native/task.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
index da4e626..af62d56 100644
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -256,7 +256,9 @@ void __native_task_pkg_cleanup(void)
 int rt_task_create(RT_TASK *task,
 		   const char *name, int stksize, int prio, int mode)
 {
+#if defined(CONFIG_XENO_OPT_NATIVE_MPS) && defined(CONFIG_XENO_FASTSYNCH)
 	xnarch_atomic_t *fastlock = NULL;
+#endif
 	union xnsched_policy_param param;
 	struct xnthread_init_attr attr;
 	int err = 0, cpumask, cpu;
@@ -336,8 +338,11 @@ int rt_task_create(RT_TASK *task,
 		xnheap_free(&xnsys_ppd_get(0)->sem_heap, fastlock);
 #endif
 		xnpod_delete_thread(&task->thread_base);
-	} else
+	}
+#if defined(CONFIG_XENO_OPT_NATIVE_MPS) && defined(CONFIG_XENO_FASTSYNCH)
+	else
 		xnsynch_fast_acquire(fastlock, xnthread_handle(&task->thread_base));
+#endif
 
 	return err;
 }
-- 
1.7.1

