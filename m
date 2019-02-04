From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 15/18] net/stack: rtskb: do not run nop locking calls
Date: Mon,  4 Feb 2019 11:56:44 +0100
Message-Id: <20190204105647.5034-16-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Checking whether calling a lock operation is actually needed is better
wrt I-cache performance.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/rtskb.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
index cc7563719..a19ef9f2d 100644
--- a/kernel/drivers/net/stack/rtskb.c
+++ b/kernel/drivers/net/stack/rtskb.c
@@ -156,10 +156,11 @@ static struct rtskb *__rtskb_pool_dequeue(struct rtskb_pool *pool)
     struct rtskb_queue *queue = &pool->queue;
     struct rtskb *skb;
 
-    if (!pool->lock_ops->trylock(pool->lock_cookie))
+    if (pool->lock_ops &&
+	!pool->lock_ops->trylock(pool->lock_cookie))
 	    return NULL;
     skb = __rtskb_dequeue(queue);
-    if (skb == NULL)
+    if (skb == NULL && pool->lock_ops)
 	    pool->lock_ops->unlock(pool->lock_cookie);
 
     return skb;
@@ -184,7 +185,8 @@ static void __rtskb_pool_queue_tail(struct rtskb_pool *pool, struct rtskb *skb)
     struct rtskb_queue *queue = &pool->queue;
 
     __rtskb_queue_tail(queue,skb);
-    pool->lock_ops->unlock(pool->lock_cookie);
+    if (pool->lock_ops)
+	    pool->lock_ops->unlock(pool->lock_cookie);
 }
 
 void rtskb_pool_queue_tail(struct rtskb_pool *pool, struct rtskb *skb)
@@ -292,21 +294,6 @@ void kfree_rtskb(struct rtskb *skb)
 EXPORT_SYMBOL_GPL(kfree_rtskb);
 
 
-static int rtskb_nop_pool_trylock(void *cookie)
-{
-    return 1;
-}
-
-static void rtskb_nop_pool_unlock(void *cookie)
-{
-}
-
-static const struct rtskb_pool_lock_ops rtskb_nop_pool_lock_ops = {
-    .trylock = rtskb_nop_pool_trylock,
-    .unlock = rtskb_nop_pool_unlock,
-};
-
-
 /***
  *  rtskb_pool_init
  *  @pool: pool to be initialized
@@ -328,7 +315,7 @@ unsigned int rtskb_pool_init(struct rtskb_pool *pool,
     if (rtskb_pools > rtskb_pools_max)
 	rtskb_pools_max = rtskb_pools;
 
-    pool->lock_ops = lock_ops ?: &rtskb_nop_pool_lock_ops;
+    pool->lock_ops = lock_ops;
     pool->lock_cookie = lock_cookie;
 
     return i;
-- 
2.17.2


