From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/posix/sem: Pull xnregistry_remove out of nklock
Message-ID: <33aedba3-088f-db8d-66e4-36515cf644f7@siemens.com>
Date: Wed, 25 Aug 2021 14:06:55 +0200
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

Neither needed nor correct for named semaphores where xnregistry_remove
will trigger a flush_work when running over the secondary domain.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/sem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index b6709e6927..6fb4dc2c2a 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -94,7 +94,6 @@ int __cobalt_sem_destroy(xnhandle_t handle)
 	}
 
 	cobalt_mark_deleted(sem);
-	xnregistry_remove(sem->resnode.handle);
 	if (!sem->pathname)
 		cobalt_del_resource(&sem->resnode);
 	if (xnsynch_destroy(&sem->synchbase) == XNSYNCH_RESCHED) {
@@ -104,6 +103,7 @@ int __cobalt_sem_destroy(xnhandle_t handle)
 
 	xnlock_put_irqrestore(&nklock, s);
 
+	xnregistry_remove(sem->resnode.handle);
 	if (sem->pathname)
 		putname(sem->pathname);
 
-- 
2.31.1

