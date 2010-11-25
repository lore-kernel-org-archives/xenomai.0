Message-ID: <4CEE9112.90808@domain.hid>
Date: Thu, 25 Nov 2010 17:38:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CEE8FF0.6000704@domain.hid>
In-Reply-To: <4CEE8FF0.6000704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 1/3] ipipe: Provide wrapper for IRQ mask/unmask
	at chip level
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

We need to overload these services for irqchips that cannot be hardened
to work from arbitrary contexts.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

I'm still lagging behind with making use of this for MSI masking or
refactoring the Xenomai HAL to use it, but it's a start.

 include/linux/ipipe.h      |   22 ++++++++++++++++++++++
 include/linux/ipipe_base.h |    1 +
 include/linux/irq.h        |    2 ++
 kernel/ipipe/core.c        |    6 ++++++
 4 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index 854f132..da2bd68 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/linkage.h>
 #include <linux/ipipe_base.h>
+#include <linux/irq.h>
 #include <asm/ipipe.h>
 #include <asm/bug.h>
 
@@ -440,6 +441,27 @@ int ipipe_control_irq(struct ipipe_domain *ipd,
 		      unsigned clrmask,
 		      unsigned setmask);
 
+static inline void ipipe_irq_chip_mask(unsigned int irq, struct irq_desc *desc)
+{
+	desc->ipipe_mask(irq);
+}
+
+static inline void
+ipipe_irq_chip_unmask(unsigned int irq, struct irq_desc *desc)
+{
+	desc->ipipe_unmask(irq);
+}
+
+void __ipipe_irq_chip_nop(unsigned int irq);
+
+#ifndef HAVE_IPIPE_IRQ_DESC_SET_HANDLERS
+static inline void ipipe_irq_desc_set_handlers(struct irq_desc *desc)
+{
+	desc->ipipe_mask = desc->chip->mask ? : __ipipe_irq_chip_nop;
+	desc->ipipe_unmask = desc->chip->unmask ? : __ipipe_irq_chip_nop;
+}
+#endif
+
 unsigned ipipe_alloc_virq(void);
 
 int ipipe_free_virq(unsigned virq);
diff --git a/include/linux/ipipe_base.h b/include/linux/ipipe_base.h
index 3f43ba5..7152485 100644
--- a/include/linux/ipipe_base.h
+++ b/include/linux/ipipe_base.h
@@ -110,6 +110,7 @@ static inline void ipipe_check_context(struct ipipe_domain *border_ipd) { }
 #define __IPIPE_FEATURE_PREPARE_PANIC		1
 #define __IPIPE_FEATURE_ROOT_PREEMPT_NOTIFIER	1
 #define __IPIPE_FEATURE_CONTROL_IRQ		1
+#define __IPIPE_FEATURE_IRQ_CHIP_MASK		1
 
 #else /* !CONFIG_IPIPE */
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 630e995..a6969d6 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -181,6 +181,8 @@ struct irq_desc {
 					     struct irq_desc *desc);
 	void			(*ipipe_end)(unsigned int irq,
 					     struct irq_desc *desc);
+	void			(*ipipe_mask)(unsigned int irq);
+	void			(*ipipe_unmask)(unsigned int irq);
 #endif /* CONFIG_IPIPE */
 	unsigned int		irq;
 	struct timer_rand_state *timer_rand_state;
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 9d025b2..756ad02 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -889,6 +889,10 @@ unsigned ipipe_alloc_virq(void)
 	return irq;
 }
 
+void __ipipe_irq_chip_nop(unsigned int irq)
+{
+}
+
 /*
  * ipipe_virtualize_irq() -- Set a per-domain pipelined interrupt
  * handler.
@@ -981,6 +985,8 @@ int ipipe_virtualize_irq(struct ipipe_domain *ipd,
 	if (desc == NULL)
 		goto unlock_and_exit;
 
+	ipipe_irq_desc_set_handlers(desc);
+
 	if (irq < NR_IRQS && !ipipe_virtual_irq_p(irq)) {
 		__ipipe_enable_irqdesc(ipd, irq);
 		/*

