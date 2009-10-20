Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.104@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:25 +0200
Message-ID: <20091020113725.9069.91604.stgit@domain.hid>
In-Reply-To: <20091020113724.9069.23594.stgit@domain.hid>
References: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 1/9] native: Release fastlock to the
	proper heap
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Don't assume rt_task_delete is only called for in-kernel users, it may
be triggered via auto-cleanup also on user space objects. So check for
the creator and release the fastlock to the correct heap.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/skins/native/mutex.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/ksrc/skins/native/mutex.c b/ksrc/skins/native/mutex.c
index 20eb484..6cf7eb1 100644
--- a/ksrc/skins/native/mutex.c
+++ b/ksrc/skins/native/mutex.c
@@ -47,6 +47,7 @@
 #include <nucleus/pod.h>
 #include <nucleus/registry.h>
 #include <nucleus/heap.h>
+#include <nucleus/sys_ppd.h>
 #include <native/task.h>
 #include <native/mutex.h>
 
@@ -316,8 +317,17 @@ int rt_mutex_delete(RT_MUTEX *mutex)
 	err = rt_mutex_delete_inner(mutex);
 
 #ifdef CONFIG_XENO_FASTSYNCH
-	if (!err)
-		xnfree(mutex->synch_base.fastlock);
+	if (!err) {
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+		if (mutex->cpid) {
+			int global = xnsynch_test_flags(&mutex->synch_base,
+							RT_MUTEX_EXPORTED);
+			xnheap_free(&xnsys_ppd_get(global)->sem_heap,
+				    mutex->synch_base.fastlock);
+		} else
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+			xnfree(mutex->synch_base.fastlock);
+	}
 #endif /* CONFIG_XENO_FASTSYNCH */
 
 	return err;


