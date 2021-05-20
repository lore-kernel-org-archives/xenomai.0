From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 01/25] cobalt/kernel: ipipe: rename xnsched_realtime_domain to
 xnsched_primary_domain
Date: Thu, 20 May 2021 23:44:11 +0200
Message-Id: <4c0a897e5287cd0c6c10258945027615a20ba022.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

This symbol is now I-pipe specific, stick to the I-pipe nomenclature
when referring to the high priority execution domain.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   |  2 +-
 kernel/cobalt/ipipe/init.c                    | 12 +++++------
 kernel/cobalt/ipipe/intr.c                    | 20 +++++++++----------
 kernel/cobalt/ipipe/kevents.c                 |  2 +-
 kernel/cobalt/ipipe/syscall.c                 |  2 +-
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
index e9e357bb06..fda962568a 100644
--- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
+++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
@@ -12,7 +12,7 @@
 #include <pipeline/machine.h>
 #include <asm/xenomai/features.h>
 
-#define xnsched_realtime_domain  cobalt_pipeline.domain
+#define xnsched_primary_domain  cobalt_pipeline.domain
 
 #define PIPELINE_NR_IRQS  IPIPE_NR_IRQS
 
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
index 1b3696b2f2..c199f00def 100644
--- a/kernel/cobalt/ipipe/init.c
+++ b/kernel/cobalt/ipipe/init.c
@@ -30,7 +30,7 @@ int __init pipeline_init(void)
 			return ret;
 	}
 
-	ipipe_register_head(&xnsched_realtime_domain, "Xenomai");
+	ipipe_register_head(&xnsched_primary_domain, "Xenomai");
 
 	virq = ipipe_alloc_virq();
 	if (virq == 0)
@@ -38,7 +38,7 @@ int __init pipeline_init(void)
 
 	cobalt_pipeline.escalate_virq = virq;
 
-	ipipe_request_irq(&xnsched_realtime_domain,
+	ipipe_request_irq(&xnsched_primary_domain,
 			  cobalt_pipeline.escalate_virq,
 			  (ipipe_irq_handler_t)__xnsched_run_handler,
 			  NULL, NULL);
@@ -50,11 +50,11 @@ int __init pipeline_init(void)
 	return 0;
 
 fail_clock:
-	ipipe_free_irq(&xnsched_realtime_domain,
+	ipipe_free_irq(&xnsched_primary_domain,
 		       cobalt_pipeline.escalate_virq);
 	ipipe_free_virq(cobalt_pipeline.escalate_virq);
 fail_escalate:
-	ipipe_unregister_head(&xnsched_realtime_domain);
+	ipipe_unregister_head(&xnsched_primary_domain);
 
 	if (cobalt_machine.cleanup)
 		cobalt_machine.cleanup();
@@ -72,8 +72,8 @@ int __init pipeline_late_init(void)
 
 __init void pipeline_cleanup(void)
 {
-	ipipe_unregister_head(&xnsched_realtime_domain);
-	ipipe_free_irq(&xnsched_realtime_domain,
+	ipipe_unregister_head(&xnsched_primary_domain);
+	ipipe_free_irq(&xnsched_primary_domain,
 		       cobalt_pipeline.escalate_virq);
 	ipipe_free_virq(cobalt_pipeline.escalate_virq);
 	ipipe_timers_release();
diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c
index 91b63d4900..0c1cc4be45 100644
--- a/kernel/cobalt/ipipe/intr.c
+++ b/kernel/cobalt/ipipe/intr.c
@@ -464,7 +464,7 @@ static inline bool cobalt_owns_irq(int irq)
 {
 	ipipe_irq_handler_t h;
 
-	h = __ipipe_irq_handler(&xnsched_realtime_domain, irq);
+	h = __ipipe_irq_handler(&xnsched_primary_domain, irq);
 
 	return h == xnintr_vec_handler ||
 		h == xnintr_edge_vec_handler ||
@@ -507,7 +507,7 @@ static inline int xnintr_irq_attach(struct xnintr *intr)
 		}
 		vec->unhandled = 0;
 
-		ret = ipipe_request_irq(&xnsched_realtime_domain,
+		ret = ipipe_request_irq(&xnsched_primary_domain,
 					intr->irq, handler, intr,
 					(ipipe_irq_ackfn_t)intr->iack);
 		if (ret)
@@ -540,7 +540,7 @@ static inline void xnintr_irq_detach(struct xnintr *intr)
 
 			/* Release the IRQ line if this was the last user */
 			if (vec->handlers == NULL)
-				ipipe_free_irq(&xnsched_realtime_domain, intr->irq);
+				ipipe_free_irq(&xnsched_primary_domain, intr->irq);
 
 			return;
 		}
@@ -564,7 +564,7 @@ static inline bool cobalt_owns_irq(int irq)
 {
 	ipipe_irq_handler_t h;
 
-	h = __ipipe_irq_handler(&xnsched_realtime_domain, irq);
+	h = __ipipe_irq_handler(&xnsched_primary_domain, irq);
 
 	return h == xnintr_irq_handler;
 }
@@ -572,7 +572,7 @@ static inline bool cobalt_owns_irq(int irq)
 static inline struct xnintr *xnintr_vec_first(unsigned int irq)
 {
 	return cobalt_owns_irq(irq) ?
-		__ipipe_irq_cookie(&xnsched_realtime_domain, irq) : NULL;
+		__ipipe_irq_cookie(&xnsched_primary_domain, irq) : NULL;
 }
 
 static inline struct xnintr *xnintr_vec_next(struct xnintr *prev)
@@ -582,7 +582,7 @@ static inline struct xnintr *xnintr_vec_next(struct xnintr *prev)
 
 static inline int xnintr_irq_attach(struct xnintr *intr)
 {
-	return ipipe_request_irq(&xnsched_realtime_domain,
+	return ipipe_request_irq(&xnsched_primary_domain,
 				 intr->irq, xnintr_irq_handler, intr,
 				 (ipipe_irq_ackfn_t)intr->iack);
 }
@@ -592,7 +592,7 @@ static inline void xnintr_irq_detach(struct xnintr *intr)
 	int irq = intr->irq;
 
 	xnlock_get(&vectors[irq].lock);
-	ipipe_free_irq(&xnsched_realtime_domain, irq);
+	ipipe_free_irq(&xnsched_primary_domain, irq);
 	xnlock_put(&vectors[irq].lock);
 
 	sync_stat_references(intr);
@@ -630,7 +630,7 @@ static void xnintr_irq_handler(unsigned int irq, void *cookie)
 	 * interrupt service routine, so the scheduler pointer will
 	 * remain valid throughout this function.
 	 */
-	intr = __ipipe_irq_cookie(&xnsched_realtime_domain, irq);
+	intr = __ipipe_irq_cookie(&xnsched_primary_domain, irq);
 	if (unlikely(intr == NULL))
 		goto done;
 #else
@@ -1162,14 +1162,14 @@ static int irq_vfile_show(struct xnvfile_regular_iterator *it,
 		xnvfile_printf(it, "        CPU%d", cpu);
 
 	for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
-		if (__ipipe_irq_handler(&xnsched_realtime_domain, irq) == NULL)
+		if (__ipipe_irq_handler(&xnsched_primary_domain, irq) == NULL)
 			continue;
 
 		xnvfile_printf(it, "\n%5d:", irq);
 
 		for_each_realtime_cpu(cpu) {
 			xnvfile_printf(it, "%12lu",
-				       __ipipe_cpudata_irq_hits(&xnsched_realtime_domain, cpu,
+				       __ipipe_cpudata_irq_hits(&xnsched_primary_domain, cpu,
 								irq));
 		}
 
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index f0314cd440..617e5cb6af 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -853,7 +853,7 @@ int pipeline_trap_kevents(void)
 {
 	init_hostrt();
 	ipipe_set_hooks(ipipe_root_domain, IPIPE_SYSCALL|IPIPE_KEVENT);
-	ipipe_set_hooks(&xnsched_realtime_domain, IPIPE_SYSCALL|IPIPE_TRAP);
+	ipipe_set_hooks(&xnsched_primary_domain, IPIPE_SYSCALL|IPIPE_TRAP);
 
 	return 0;
 }
diff --git a/kernel/cobalt/ipipe/syscall.c b/kernel/cobalt/ipipe/syscall.c
index 18aa996bd0..867a81ec24 100644
--- a/kernel/cobalt/ipipe/syscall.c
+++ b/kernel/cobalt/ipipe/syscall.c
@@ -15,7 +15,7 @@ int ipipe_syscall_hook(struct ipipe_domain *ipd, struct pt_regs *regs)
 	if (unlikely(is_secondary_domain()))
 		return handle_root_syscall(regs);
 
-	return handle_head_syscall(ipd != &xnsched_realtime_domain, regs);
+	return handle_head_syscall(ipd != &xnsched_primary_domain, regs);
 }
 
 int ipipe_fastcall_hook(struct pt_regs *regs)
-- 
2.26.2


