Message-ID: <505B0CE0.4080100@siemens.com>
Date: Thu, 20 Sep 2012 14:32:32 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] rtdm: Restrict/clarify usage of
	rtdm_irq_request/free/enable/disable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

We cannot support line enabling/disabling over non-Linux contexts for
all IRQ types (e.g.: changes to legacy MSIs). Requesting and releasing
IRQs includes enabling/disabling them, so we better avoid conflicts by
restricting the usage of rtdm_irq_request/free.

On the other hand, there are users of rtdm_irq_enable/disable over
interrupt context for supported IRQ types. Therefore, clarify the
documentation of those functions that even more extreme care has to be
applied when relying on them.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/rtdm/rtdm_driver.h |    1 +
 ksrc/skins/rtdm/drvlib.c   |   16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
index 68135e4..3006d59 100644
--- a/include/rtdm/rtdm_driver.h
+++ b/include/rtdm/rtdm_driver.h
@@ -899,6 +899,7 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline int rtdm_irq_free(rtdm_irq_t *irq_handle)
 {
+	XENO_ASSERT(RTDM, xnpod_root_p(), return -EPERM;);
 	return xnintr_detach(irq_handle);
 }
 
diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index 4b74042..e5c470c 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -1617,8 +1617,7 @@ EXPORT_SYMBOL_GPL(rtdm_mutex_timedlock);
  * This service can be called from:
  *
  * - Kernel module initialization/cleanup code
- * - Kernel-based task
- * - User-space task (RT, non-RT)
+ * - User-space task (non-RT)
  *
  * Rescheduling: never.
  */
@@ -1628,6 +1627,8 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 {
 	int err;
 
+	XENO_ASSERT(RTDM, xnpod_root_p(), return -EPERM;);
+
 	xnintr_init(irq_handle, device_name, irq_no, handler, NULL, flags);
 
 	err = xnintr_attach(irq_handle, arg);
@@ -1661,8 +1662,7 @@ EXPORT_SYMBOL_GPL(rtdm_irq_request);
  * This service can be called from:
  *
  * - Kernel module initialization/cleanup code
- * - Kernel-based task
- * - User-space task (RT, non-RT)
+ * - User-space task (non-RT)
  *
  * Rescheduling: never.
  */
@@ -1679,7 +1679,9 @@ int rtdm_irq_free(rtdm_irq_t *irq_handle);
  * interrupt masking at device level (via corresponding control registers etc.)
  * over masking at line level. Keep in mind that the latter is incompatible
  * with IRQ line sharing and can also be more costly as interrupt controller
- * access requires broader synchronization.
+ * access requires broader synchronization. Also, certain IRQ types may not
+ * allow the invocation over RT and interrupt contexts. The caller is
+ * responsible for excluding such conflicts.
  *
  * Environments:
  *
@@ -1705,7 +1707,9 @@ int rtdm_irq_enable(rtdm_irq_t *irq_handle);
  * interrupt masking at device level (via corresponding control registers etc.)
  * over masking at line level. Keep in mind that the latter is incompatible
  * with IRQ line sharing and can also be more costly as interrupt controller
- * access requires broader synchronization.
+ * access requires broader synchronization. Also, certain IRQ types may not
+ * allow the invocation over RT and interrupt contexts. The caller is
+ * responsible for excluding such conflicts.
  *
  * Environments:
  *
-- 
1.7.3.4

