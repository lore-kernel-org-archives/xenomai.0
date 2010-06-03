Message-ID: <4C07BA93.1070403@domain.hid>
Date: Thu, 03 Jun 2010 16:22:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [RFC][PATCH 1/2] Introduce generic ipipe_get_irq_regs
	interface
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

This service allows to obtain a reference to the register set of the
context preempted by the currently processed IRQ. It will return NULL
when used outside an IRQ call stack.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/linux/ipipe_percpu.h |    5 +++++
 kernel/ipipe/core.c          |    8 ++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/linux/ipipe_percpu.h b/include/linux/ipipe_percpu.h
index f6727e3..1cf2438 100644
--- a/include/linux/ipipe_percpu.h
+++ b/include/linux/ipipe_percpu.h
@@ -68,6 +68,9 @@ DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
 
 DECLARE_PER_CPU(unsigned long, ipipe_nmi_saved_root);
 
+struct pt_regs;
+DECLARE_PER_CPU(struct pt_regs *, ipipe_irq_regs);
+
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
 DECLARE_PER_CPU(int, ipipe_percpu_context_check);
 DECLARE_PER_CPU(int, ipipe_saved_context_check_state);
@@ -86,4 +89,6 @@ DECLARE_PER_CPU(int, ipipe_saved_context_check_state);
 
 #define ipipe_head_cpudom_var(var)	ipipe_head_cpudom_ptr()->var
 
+#define ipipe_get_irq_regs()		__ipipe_get_cpu_var(ipipe_irq_regs)
+
 #endif	/* !__LINUX_IPIPE_PERCPU_H */
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 1d9e861..2370995 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -84,6 +84,8 @@ DEFINE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain) = { &ipipe_root };
 
 DEFINE_PER_CPU(unsigned long, ipipe_nmi_saved_root); /* Copy of root status during NMI */
 
+DEFINE_PER_CPU(struct pt_regs *, ipipe_irq_regs);
+
 static IPIPE_DEFINE_SPINLOCK(__ipipe_pipelock);
 
 LIST_HEAD(__ipipe_pipeline);
@@ -1197,6 +1199,7 @@ void __ipipe_dispatch_wired_nocheck(struct ipipe_domain *head, unsigned irq) /*
 void __ipipe_sync_stage(int dovirt)
 {
 	struct ipipe_percpu_domain_data *p;
+	struct pt_regs *orig_regs, regs;
 	struct ipipe_domain *ipd;
 	int cpu, irq;
 
@@ -1216,6 +1219,8 @@ void __ipipe_sync_stage(int dovirt)
 
 	cpu = ipipe_processor_id();
 
+	__ipipe_setup_irq_regs(&orig_regs, &regs);
+
 	for (;;) {
 		irq = __ipipe_next_irq(p, dovirt);
 		if (irq < 0)
@@ -1269,6 +1274,8 @@ void __ipipe_sync_stage(int dovirt)
 		__clear_bit(IPIPE_STALL_FLAG, &p->status);
 	}
 
+	__ipipe_cleanup_irq_regs(orig_regs, &regs);
+
 	__clear_bit(IPIPE_SYNC_FLAG, &p->status);
 }
 
@@ -1940,6 +1947,7 @@ EXPORT_SYMBOL(ipipe_suspend_domain);
 EXPORT_SYMBOL(ipipe_alloc_virq);
 EXPORT_PER_CPU_SYMBOL(ipipe_percpu_domain);
 EXPORT_PER_CPU_SYMBOL(ipipe_percpu_darray);
+EXPORT_PER_CPU_SYMBOL(ipipe_irq_regs);
 EXPORT_SYMBOL(ipipe_root);
 EXPORT_SYMBOL(ipipe_stall_pipeline_from);
 EXPORT_SYMBOL(ipipe_test_and_stall_pipeline_from);

