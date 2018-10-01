From: Philippe Gerum <rpm@xenomai.org>
Date: Mon,  1 Oct 2018 15:56:16 +0200
Message-Id: <20181001135619.24883-4-rpm@xenomai.org>
In-Reply-To: <20181001135619.24883-1-rpm@xenomai.org>
References: <20181001135619.24883-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 3/6] cobalt/intr: IRQ affinity depends on
 xnsched_realtime_cpus
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

cobalt_cpu_affinity defines the CPU set which may run Cobalt threads,
which is a subset of xnsched_realtime_cpus. I.e. we may handle IRQs
over CPUs which do not run threads.
---
 kernel/cobalt/intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 69faa23ba..184ffad13 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -822,7 +822,7 @@ int xnintr_attach(struct xnintr *intr, void *cookie)
 	clear_irqstats(intr);
 
 #ifdef CONFIG_SMP
-	ipipe_set_irq_affinity(intr->irq, cobalt_cpu_affinity);
+	ipipe_set_irq_affinity(intr->irq, xnsched_realtime_cpus);
 #endif /* CONFIG_SMP */
 
 	raw_spin_lock(&intr->lock);
-- 
2.14.4


