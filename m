From: roman.stratiienko@globallogic.com
Subject: [PATCH] drivers: net: use atomic_fetch_add_unless() for v4.19 and
 higher
Date: Thu,  4 Apr 2019 19:58:21 +0300
Message-Id: <20190404165821.7174-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

After changes introduced in kernel v4.19, commit bfc18e389c7a
("atomics/treewide: Rename __atomic_add_unless() => atomic_fetch_add_unless()")
use atomic_fetch_add_unless() function instead of __atomic_add_unless().

Add wrapper for backward campatibility.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 kernel/drivers/net/stack/rtdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 7ece792e7..b2d0687da 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -52,10 +52,14 @@ DEFINE_MUTEX(rtnet_devices_nrt_lock);
 
 static int rtdev_locked_xmit(struct rtskb *skb, struct rtnet_device *rtdev);
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
+#define atomic_fetch_add_unless __atomic_add_unless
+#endif
+
 int rtdev_reference(struct rtnet_device *rtdev)
 {
     smp_mb__before_atomic();
-    if (rtdev->rt_owner && __atomic_add_unless(&rtdev->refcount, 1, 0) == 0) {
+    if (rtdev->rt_owner && atomic_fetch_add_unless(&rtdev->refcount, 1, 0) == 0) {
 	if (!try_module_get(rtdev->rt_owner))
 	    return 0;
 	if (atomic_inc_return(&rtdev->refcount) != 1)
-- 
2.17.1


