From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Date: Mon, 23 Oct 2017 16:59:42 +0200
Message-Id: <20171023145944.11262-2-christoph.muellner@theobroma-systems.com>
In-Reply-To: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
References: <20171023145944.11262-1-christoph.muellner@theobroma-systems.com>
Subject: [Xenomai] [PATCH 1/3] cobalt: rtdm: Add function
	rtdm_irq_affinity().
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This patch adds a RTDM API to set a IRQ's CPU affinity.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 include/cobalt/kernel/rtdm/driver.h | 6 ++++++
 1 file changed, 6 insertions(+)

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
-- 
2.11.0


