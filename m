From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0ab5b536-2e75-fdfe-96e9-f6321aca107d@siemens.com>
Date: Tue, 2 Oct 2018 19:03:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] cobalt/posix/mqueue: Remove unused cobalt_mqq and
 fix error cleanup bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

cobalt_mqq was only maintained but never queried. Remove it.

This also simplify the fix for the broken error recovery in mq_open: If
xnregistry_enter, we never entered the new element in cobalt_mqq and
also already decremented the reference counter. But then we asked via
rtdm_fd_close to remove the entry as if it was registered. That could
easily crash the system.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

We've seen a crash along this, but testing this patch against that
scenario is pending. So the commit is not yet in next, rather looks
for early review.

 kernel/cobalt/posix/mqueue.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index 859e12ed7b..5daae79845 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -37,8 +37,6 @@
 struct cobalt_mq {
 	unsigned magic;
 
-	struct list_head link;
-
 	struct xnsynch receivers;
 	struct xnsynch senders;
 	size_t memsize;
@@ -84,8 +82,6 @@ static struct mq_attr default_attr = {
       .mq_msgsize = 8192,
 };
 
-static LIST_HEAD(cobalt_mqq);
-
 static inline struct cobalt_msg *mq_msg_alloc(struct cobalt_mq *mq)
 {
 	if (list_empty(&mq->avail))
@@ -163,7 +159,6 @@ static inline void mq_destroy(struct cobalt_mq *mq)
 	xnlock_get_irqsave(&nklock, s);
 	resched = (xnsynch_destroy(&mq->receivers) == XNSYNCH_RESCHED);
 	resched = (xnsynch_destroy(&mq->senders) == XNSYNCH_RESCHED) || resched;
-	list_del(&mq->link);
 	xnlock_put_irqrestore(&nklock, s);
 	xnselect_destroy(&mq->read_select);
 	xnselect_destroy(&mq->write_select);
@@ -354,10 +349,6 @@ static int mq_open(int uqd, const char *name, int oflags,
 
 		xnlock_get_irqsave(&nklock, s);
 		err = xnregistry_enter(mq->name, mq, &mq->handle, NULL);
-		if (err < 0)
-			--mq->refs;
-		else
-			list_add_tail(&mq->link, &cobalt_mqq);
 		xnlock_put_irqrestore(&nklock, s);
 		if (err < 0) {
 			rtdm_fd_close(uqd, COBALT_MQD_MAGIC);
-- 
2.16.4

