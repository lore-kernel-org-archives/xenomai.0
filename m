From: Wolfgang Grandegger <wg@grandegger.com>
Date: Thu, 27 Sep 2012 17:29:13 +0200
Message-Id: <1348759755-13500-2-git-send-email-wg@grandegger.com>
In-Reply-To: <1348759755-13500-1-git-send-email-wg@grandegger.com>
References: <1348759755-13500-1-git-send-email-wg@grandegger.com>
Subject: [Xenomai] [PATCH 1/3] rtcan: add some macro definitions for
	compatibility with Linux-CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org
Cc: Wolfgang Grandegger <wg@denx.de>

From: Wolfgang Grandegger <wg@denx.de>

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 include/rtdm/rtcan.h              |   12 ++++++++++--
 ksrc/drivers/can/rtcan_internal.h |   10 ++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/rtdm/rtcan.h b/include/rtdm/rtcan.h
index 4c0749d..b8bd762 100644
--- a/include/rtdm/rtcan.h
+++ b/include/rtdm/rtcan.h
@@ -422,6 +422,11 @@ typedef enum CAN_MODE can_mode_t;
  * test operation. */
 #define CAN_CTRLMODE_LOOPBACK   0x2
 
+/*! Triple sampling mode
+ *
+ * In this mode the CAN controller uses Triple sampling. */
+#define CAN_CTRLMODE_3_SAMPLES  0x4
+
 /** @} */
 
 /** See @ref CAN_CTRLMODE */
@@ -433,13 +438,16 @@ typedef int can_ctrlmode_t;
  * @{ */
 enum CAN_STATE {
 	/** CAN controller is error active */
+	CAN_STATE_ERROR_ACTIVE = 0,
 	CAN_STATE_ACTIVE = 0,
 
 	/** CAN controller is error active, warning level is reached */
-	CAN_STATE_BUS_WARNING,
+	CAN_STATE_ERROR_WARNING = 1,
+	CAN_STATE_BUS_WARNING = 1,
 
 	/** CAN controller is error passive */
-	CAN_STATE_BUS_PASSIVE,
+	CAN_STATE_ERROR_PASSIVE = 2,
+	CAN_STATE_BUS_PASSIVE = 2,
 
 	/** CAN controller went into Bus Off */
 	CAN_STATE_BUS_OFF,
diff --git a/ksrc/drivers/can/rtcan_internal.h b/ksrc/drivers/can/rtcan_internal.h
index 626cae7..35b778a 100644
--- a/ksrc/drivers/can/rtcan_internal.h
+++ b/ksrc/drivers/can/rtcan_internal.h
@@ -115,4 +115,14 @@
 # define RTCAN_RTDM_DBG(fmt,args...) do {} while (0)
 #endif
 
+#define rtcan_priv(dev)			(dev)->priv
+#define rtcandev_dbg(dev, fmt, args...)				\
+	printk(KERN_DEBUG "%s: " fmt, (dev)->name, ##args)
+#define rtcandev_info(dev, fmt, args...)			\
+	printk(KERN_INFO "%s: " fmt, (dev)->name, ##args)
+#define rtcandev_warn(dev, fmt, args...)			\
+	printk(KERN_WARNING "%s: " fmt, (dev)->name, ##args)
+#define rtcandev_err(dev, fmt, args...)				\
+	printk(KERN_ERR "%s: " fmt, (dev)->name, ##args)
+
 #endif /* __RTCAN_INTERNAL_H_ */
-- 
1.7.7.6


