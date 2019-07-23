From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: Respect return codes of ipipe_enable_irq and
 ipipe_set_irq_affinity
Message-ID: <32e91482-57ba-5e65-a10c-2b45673f37bc@siemens.com>
Date: Tue, 23 Jul 2019 20:40:45 +0200
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

Since 4.19 kernels, we need to account for those two ipipe helpers
returning an error code. Luckily, all in-tree users, i.e. RTDM, are
prepared to forward that.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I'll wait with applying this until both our 4.19 archs, x86 and arm,
have released a patch which contains that change.

 include/cobalt/kernel/intr.h                        |  5 ++---
 include/cobalt/kernel/rtdm/driver.h                 |  3 +--
 .../cobalt/include/asm-generic/xenomai/wrappers.h   | 12 ++++++++++++
 kernel/cobalt/intr.c                                | 21 +++++++++++++++------
 kernel/cobalt/rtdm/drvlib.c                         | 16 ++++++++++------
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/cobalt/kernel/intr.h b/include/cobalt/kernel/intr.h
index af20ca1f92..78c309cfac 100644
--- a/include/cobalt/kernel/intr.h
+++ b/include/cobalt/kernel/intr.h
@@ -127,12 +127,11 @@ int xnintr_attach(struct xnintr *intr,
 
 void xnintr_detach(struct xnintr *intr);
 
-void xnintr_enable(struct xnintr *intr);
+int xnintr_enable(struct xnintr *intr);
 
 void xnintr_disable(struct xnintr *intr);
 
-void xnintr_affinity(struct xnintr *intr,
-		     cpumask_t cpumask);
+int xnintr_affinity(struct xnintr *intr, cpumask_t cpumask);
 
 int xnintr_query_init(struct xnintr_iterator *iterator);
 
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 72f75388da..0666ec7050 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -865,8 +865,7 @@ static inline int rtdm_irq_free(rtdm_irq_t *irq_handle)
 
 static inline int rtdm_irq_enable(rtdm_irq_t *irq_handle)
 {
-	xnintr_enable(irq_handle);
-	return 0;
+	return xnintr_enable(irq_handle);
 }
 
 static inline int rtdm_irq_disable(rtdm_irq_t *irq_handle)
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index c4cad114c2..e95373026c 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -38,6 +38,18 @@
  *   symbol, so that obsolete wrappers can be spotted.
  */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,19,0)
+#define ipipe_enable_irq(irq) ({					\
+	ipipe_enable_irq(irq);						\
+	0;								\
+})
+
+#define ipipe_set_irq_affinity(irq, mask) ({				\
+	ipipe_set_irq_affinity(irq, mask);				\
+	0;								\
+})
+#endif /* < 4.19 */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,15,0)
 #define get_compat_sigset(set, compat)					\
 ({									\
diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 9c3f555088..f7a0020067 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -901,18 +901,21 @@ void xnintr_detach(struct xnintr *intr)
 EXPORT_SYMBOL_GPL(xnintr_detach);
 
 /**
- * @fn void xnintr_enable(struct xnintr *intr)
+ * @fn int xnintr_enable(struct xnintr *intr)
  * @brief Enable an interrupt line.
  *
  * Enables the interrupt line associated with an interrupt descriptor.
  *
  * @param intr The address of the interrupt descriptor.
  *
+ * @return 0 is returned on success, otherwise a negative error code.
+ *
  * @coretags{secondary-only}
  */
-void xnintr_enable(struct xnintr *intr)
+int xnintr_enable(struct xnintr *intr)
 {
 	unsigned long flags;
+	int ret = 0;
 
 	secondary_mode_only();
 	trace_cobalt_irq_enable(intr->irq);
@@ -924,9 +927,11 @@ void xnintr_enable(struct xnintr *intr)
 	 * disable_irq_line().
 	 */
 	if (test_and_clear_bit(XN_IRQSTAT_DISABLED, &intr->status))
-		ipipe_enable_irq(intr->irq);
+		ret = ipipe_enable_irq(intr->irq);
 
 	raw_spin_unlock_irqrestore(&intr->lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(xnintr_enable);
 
@@ -965,7 +970,7 @@ void xnintr_disable(struct xnintr *intr)
 EXPORT_SYMBOL_GPL(xnintr_disable);
 
 /**
- * @fn void xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
+ * @fn int xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
  * @brief Set processor affinity of interrupt.
  *
  * Restricts the IRQ line associated with the interrupt descriptor @a
@@ -976,16 +981,20 @@ EXPORT_SYMBOL_GPL(xnintr_disable);
  *
  * @param cpumask The new processor affinity.
  *
+ * @return 0 is returned on success, otherwise a negative error code.
+ *
  * @note Depending on architectures, setting more than one bit in @a
  * cpumask could be meaningless.
  *
  * @coretags{secondary-only}
  */
-void xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
+int xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
 {
 	secondary_mode_only();
 #ifdef CONFIG_SMP
-	ipipe_set_irq_affinity(intr->irq, cpumask);
+	return ipipe_set_irq_affinity(intr->irq, cpumask);
+#else
+	return 0;
 #endif
 }
 EXPORT_SYMBOL_GPL(xnintr_affinity);
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 316d87b29d..950925a3ae 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1412,7 +1412,7 @@ EXPORT_SYMBOL_GPL(rtdm_mutex_timedlock);
  * @param[in] device_name Device name to show up in real-time IRQ lists
  * @param[in] arg Pointer to be passed to the interrupt handler on invocation
  *
- * @return 0 on success, otherwise:
+ * @return 0 on success, otherwise a negative error code, e.g.:
  *
  * - -EINVAL is returned if an invalid parameter was passed.
  *
@@ -1434,14 +1434,18 @@ int rtdm_irq_request(rtdm_irq_t *irq_handle, unsigned int irq_no,
 		return err;
 
 	err = xnintr_attach(irq_handle, arg);
-	if (err) {
-		xnintr_destroy(irq_handle);
-		return err;
-	}
+	if (err)
+		goto err_out;
 
-	xnintr_enable(irq_handle);
+	err = xnintr_enable(irq_handle);
+	if (err)
+		goto err_out;
 
 	return 0;
+
+err_out:
+	xnintr_destroy(irq_handle);
+	return err;
 }
 
 EXPORT_SYMBOL_GPL(rtdm_irq_request);
-- 
2.16.4

