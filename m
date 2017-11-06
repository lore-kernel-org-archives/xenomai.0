From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Mon,  6 Nov 2017 10:46:44 +0100
Message-Id: <20171106094646.28769-2-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
References: <20171106094646.28769-1-christoph.muellner@theobroma-systems.com>
Subject: [Xenomai] [PATCH v2 1/3] cobalt: rtdm: Add function
	rtdm_irq_affinity().
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org

This patch adds a RTDM API to set a IRQ's CPU affinity.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 include/cobalt/kernel/rtdm/driver.h |  6 ++++++
 kernel/cobalt/rtdm/drvlib.c         | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 0c7b62e75..803cdbfe4 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -874,6 +874,12 @@ static inline int rtdm_irq_disable(rtdm_irq_t *irq_handle)
 	xnintr_disable(irq_handle);
 	return 0;
 }
+
+static inline int rtdm_irq_affinity(rtdm_irq_t *irq_handle, cpumask_t tgt)
+{
+	xnintr_affinity(irq_handle, tgt);
+	return 0;
+}
 #endif /* !DOXYGEN_CPP */
 
 /* --- non-real-time signalling services --- */
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 6f4f51e30..fdecb6ec9 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1501,6 +1501,24 @@ int rtdm_irq_enable(rtdm_irq_t *irq_handle);
  * @coretags{secondary-only}
  */
 int rtdm_irq_disable(rtdm_irq_t *irq_handle);
+
+/**
+ * @brief Set processor affinity of interrupt line.
+ *
+ * Restricts the interrupt line associated with the IRQ handle @a irq_handle
+ * to be received only on processors with a set bit in @a cpumask.
+ *
+ * @param[in,out] irq_handle IRQ handle as returned by rtdm_irq_request()
+ * @param[in] cpumask The CPU mask representing the new CPU affinity.
+ *
+ * @return 0 on success, otherwise negative error code
+ *
+ * @note Depending on architectures, setting more than one bit in @a
+ * cpumask could be meaningless.
+ *
+ * @coretags{secondary-only}
+ */
+int rtdm_irq_affinity(rtdm_irq_t *irq_handle, cpumask_t cpumask);
 #endif /* DOXYGEN_CPP */
 
 /** @} Interrupt Management Services */
-- 
2.11.0


