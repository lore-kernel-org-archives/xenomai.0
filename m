From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 04/12] drivers/udd: Consolidate over ENOSYS on disabled core
Date: Fri, 13 Sep 2019 18:46:47 +0200
Message-Id: <08e16ba30f2f08ef3795805910efeb5db9b5f470.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
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

Drop the duplicate checks - rtdm_dev_register will already fail. And as
udd_register_device fails, there is no point in protecting
udd_unregister_device because there will be no device to unregister.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/udd/udd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index b086096ccd..e32d40f665 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -347,8 +347,7 @@ undo:
  *
  * - -EINVAL, if udd_device.device_flags contains invalid flags.
  *
- * - -ENXIO can be received if this service is called while the Cobalt
- * kernel is disabled.
+ * - -ENOSYS, if this service is called while the real-time core is disabled.
  *
  * @coretags{secondary-only}
  */
@@ -360,9 +359,6 @@ int udd_register_device(struct udd_device *udd)
 	struct udd_memregion *rn;
 	int ret, n;
 
-	if (!realtime_core_enabled())
-		return -ENXIO;
-
 	if (udd->device_flags & RTDM_PROTOCOL_DEVICE)
 		return -EINVAL;
 
@@ -459,9 +455,6 @@ int udd_unregister_device(struct udd_device *udd)
 	struct udd_memregion *rn;
 	int n;
 
-	if (!realtime_core_enabled())
-		return -ENXIO;
-
 	rtdm_event_destroy(&ur->pulse);
 
 	if (udd->irq != UDD_IRQ_NONE && udd->irq != UDD_IRQ_CUSTOM)
-- 
2.16.4


