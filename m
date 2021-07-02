From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/4] cobalt/rtdm: Introduce IRQ affinity services
Date: Fri,  2 Jul 2021 16:27:47 +0200
Message-Id: <76dca51abecc3062d09dcea2b5bde4d066a98266.1625236067.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1625236067.git.jan.kiszka@siemens.com>
References: <cover.1625236067.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add rtdm_irq_request_affine and rtdm_irq_set_affinity to start IRQs or
specific CPUs or move them around. So far, this was unsupported and made
users bypass layer to configure the desired affinity. Starting with the
right affinity also avoids hitting the wrong CPU at least once before
the IRQ can be live-migrated.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/rtdm/driver.h | 12 +++++++
 kernel/cobalt/rtdm/drvlib.c         | 52 +++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 1955254cc6..db1dfc6367 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -27,6 +27,7 @@
 #define _COBALT_RTDM_DRIVER_H
 
 #include <asm/atomic.h>
+#include <linux/cpumask.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
@@ -854,6 +855,11 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 		     rtdm_irq_handler_t handler, unsigned long flags,
 		     const char *device_name, void *arg);
 
+int rtdm_irq_request_affine(rtdm_irq_t *irq_handle, unsigned int irq_no,
+			    rtdm_irq_handler_t handler, unsigned long flags,
+			    const char *device_name, void *arg,
+			    const cpumask_t *cpumask);
+
 #ifndef DOXYGEN_CPP /* Avoid static inline tags for RTDM in doxygen */
 static inline int rtdm_irq_free(rtdm_irq_t *irq_handle)
 {
@@ -874,6 +880,12 @@ static inline int rtdm_irq_disable(rtdm_irq_t *irq_handle)
 	xnintr_disable(irq_handle);
 	return 0;
 }
+
+static inline int rtdm_irq_set_affinity(rtdm_irq_t *irq_handle,
+					const cpumask_t *cpumask)
+{
+	return xnintr_affinity(irq_handle, cpumask);
+}
 #endif /* !DOXYGEN_CPP */
 
 /* --- non-real-time signalling services --- */
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index e97a475c9a..7b7b0830c2 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1442,6 +1442,41 @@ EXPORT_SYMBOL_GPL(rtdm_mutex_timedlock);
 int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 		     rtdm_irq_handler_t handler, unsigned long flags,
 		     const char *device_name, void *arg)
+{
+	return rtdm_irq_request_affine(irq_handle, irq_no, handler, flags,
+				       device_name, arg, NULL);
+}
+
+EXPORT_SYMBOL_GPL(rtdm_irq_request);
+
+/**
+ * @brief Register an interrupt handler
+ *
+ * This function registers the provided handler with an IRQ line and enables
+ * the line.
+ *
+ * @param[in,out] irq_handle IRQ handle
+ * @param[in] irq_no Line number of the addressed IRQ
+ * @param[in] handler Interrupt handler
+ * @param[in] flags Registration flags, see @ref RTDM_IRQTYPE_xxx for details
+ * @param[in] device_name Device name to show up in real-time IRQ lists
+ * @param[in] arg Pointer to be passed to the interrupt handler on invocation
+ * @param[in] cpumask CPU affinity of the interrupt
+ *
+ * @return 0 on success, otherwise:
+ *
+ * - -EINVAL is returned if an invalid parameter was passed.
+ *
+ * - -EBUSY is returned if the specified IRQ line is already in use.
+ *
+ * - -ENOSYS is returned if the real-time core is disabled.
+ *
+ * @coretags{secondary-only}
+ */
+int rtdm_irq_request_affine(rtdm_irq_t *irq_handle, unsigned int irq_no,
+			    rtdm_irq_handler_t handler, unsigned long flags,
+			    const char *device_name, void *arg,
+			    const cpumask_t *cpumask)
 {
 	int err;
 
@@ -1455,7 +1490,7 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 	if (err)
 		return err;
 
-	err = xnintr_attach(irq_handle, arg, NULL);
+	err = xnintr_attach(irq_handle, arg, cpumask);
 	if (err) {
 		xnintr_destroy(irq_handle);
 		return err;
@@ -1466,7 +1501,7 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(rtdm_irq_request);
+EXPORT_SYMBOL_GPL(rtdm_irq_request_affine);
 
 #ifdef DOXYGEN_CPP /* Only used for doxygen doc generation */
 /**
@@ -1524,6 +1559,19 @@ int rtdm_irq_enable(rtdm_irq_t *irq_handle);
  * @coretags{secondary-only}
  */
 int rtdm_irq_disable(rtdm_irq_t *irq_handle);
+
+/**
+ * @brief Set interrupt affinity
+ *
+ * @param[in] irq_handle IRQ handle as returned by rtdm_irq_request()
+ *
+ * @param[in] cpumask The new CPU affinity of the interrupt
+ *
+ * @return 0 on success, otherwise negative error code
+ *
+ * @coretags{secondary-only}
+ */
+int rtdm_irq_set_affinity(rtdm_irq_t *irq_handle, const cpumask_t *cpumask);
 #endif /* DOXYGEN_CPP */
 
 /** @} Interrupt Management Services */
-- 
2.26.2


