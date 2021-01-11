From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 01/10] dovetail/sirq: implement sirq request and free and post
Date: Mon, 11 Jan 2021 01:43:09 -0500
Message-Id: <20210111064318.6154-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

inband sirq request through synthetic_irq_domain and free and post
srq.

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 .../cobalt/kernel/dovetail/pipeline/sirq.h    | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/sirq.h b/include/cobalt/kernel/dovetail/pipeline/sirq.h
index be9dc587f..1da9d13b2 100644
--- a/include/cobalt/kernel/dovetail/pipeline/sirq.h
+++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
@@ -23,9 +23,24 @@ int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
 	 * Allocate an IRQ from the synthetic interrupt domain then
 	 * trap it to @handler, to be fired from the in-band stage.
 	 */
-	TODO();
+	int sirq, ret;
 
-	return 0;
+	sirq = irq_create_direct_mapping(synthetic_irq_domain);
+	if (sirq == 0)
+		return -EAGAIN;
+
+	ret = __request_percpu_irq(sirq,
+			handler,
+			IRQF_NO_THREAD,
+			"Inband sirq",
+			&cobalt_machine_cpudata);
+
+	if (ret) {
+		irq_dispose_mapping(sirq);
+		return ret;
+	}
+
+	return sirq;
 }
 
 static inline
@@ -35,13 +50,16 @@ void pipeline_delete_inband_sirq(int sirq)
 	 * Free the synthetic IRQ then deallocate it to its
 	 * originating domain.
 	 */
-	TODO();
+	free_percpu_irq(sirq,
+		&cobalt_machine_cpudata);
+
+	irq_dispose_mapping(sirq);
 }
 
 static inline void pipeline_post_sirq(int sirq)
 {
 	/* Trigger the synthetic IRQ */
-	TODO();
+	irq_post_inband(sirq);
 }
 
-#endif /* !_COBALT_KERNEL_IPIPE_SIRQ_H */
+#endif /* !_COBALT_KERNEL_DOVETAIL_SIRQ_H */
-- 
2.17.1


