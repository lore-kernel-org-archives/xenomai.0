From: Stefan Roese <sr@denx.de>
Date: Thu, 22 Jan 2015 10:57:47 +0100
Message-Id: <1421920667-437-1-git-send-email-sr@denx.de>
Subject: [Xenomai] [PATCH v2] hal/arm: Add Zynq v3.14.17 patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Xilinx Zynq is already supported in the mainline Xenomai git repository.
This patch adds support for the v3.14.17 Linux Kernel additionally to the
already present v3.5 and v3.8 support.

This version was tested with the following ipipe core arm patch:
- ipipe-core-3.14.17-arm-4.patch

Signed-off-by: Stefan Roese <sr@denx.de>
---
v2:
- Update README and commit message to not specify which arm-* ipipe
  core patch has to be used. And mentioned the version it has been
  tested with.

 ksrc/arch/arm/patches/README                       |   9 +
 .../zynq/ipipe-core-3.14.17-zynq-post.patch        |  21 ++
 .../patches/zynq/ipipe-core-3.14.17-zynq-pre.patch | 236 +++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-post.patch
 create mode 100644 ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-pre.patch

diff --git a/ksrc/arch/arm/patches/README b/ksrc/arch/arm/patches/README
index 8b4f744..af4a42b 100644
--- a/ksrc/arch/arm/patches/README
+++ b/ksrc/arch/arm/patches/README
@@ -95,6 +95,15 @@ From [5]:
 4- apply ipipe-core-3.5.7-zynq-post.patch
 5- you can resume to generic installation instructions.
 
+---- Zynq (v3.14.17)
+
+1- Checkout the "xilinx-zynq-v3.14.17" branch from the DENX Linux git
+   repository [2]
+2- apply zynq/ipipe-core-3.14.17-zynq-pre.patch
+3- apply ipipe-core-3.14.17-arm-*.patch
+4- apply zynq/ipipe-core-3.14.17-zynq-post.patch
+5- you can resume to generic installation instructions.
+
 -- External links
 
 [1] http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
diff --git a/ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-post.patch b/ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-post.patch
new file mode 100644
index 0000000..3c87d80
--- /dev/null
+++ b/ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-post.patch
@@ -0,0 +1,21 @@
+diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
+index 1f5fdfc..c4e682a 100644
+--- a/drivers/gpio/gpio-zynq.c
++++ b/drivers/gpio/gpio-zynq.c
+@@ -14,6 +14,7 @@
+ #include <linux/init.h>
+ #include <linux/interrupt.h>
+ #include <linux/io.h>
++#include <linux/ipipe.h>
+ #include <linux/irq.h>
+ #include <linux/irqchip/chained_irq.h>
+ #include <linux/irqdomain.h>
+@@ -446,7 +447,7 @@ static void zynq_gpio_irqhandler(unsigned int irq, struct irq_desc *desc)
+ 			chip->irq_ack(&gpio_irq_desc->irq_data);
+ 
+ 			/* call the pin specific handler */
+-			generic_handle_irq(gpio_irq);
++			ipipe_handle_demuxed_irq(gpio_irq);
+ 		}
+ 		/* shift to first virtual irq of next bank */
+ 		gpio_irq = gpio->irq_base + zynq_gpio_pin_table[bank_num] + 1;
diff --git a/ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-pre.patch b/ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-pre.patch
new file mode 100644
index 0000000..9613614
--- /dev/null
+++ b/ksrc/arch/arm/patches/zynq/ipipe-core-3.14.17-zynq-pre.patch
@@ -0,0 +1,236 @@
+diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
+index 86e384c..b7b4c86 100644
+--- a/arch/arm/kernel/smp.c
++++ b/arch/arm/kernel/smp.c
+@@ -461,30 +461,16 @@ void arch_irq_work_raise(void)
+ }
+ #endif
+ 
+-struct ipi {
+-	const char *desc;
+-	void (*handler)(void);
+-};
+-
+-static void ipi_cpu_stop(void);
+-static void ipi_complete(void);
+-
+-static struct ipi ipi_types[NR_IPI] = {
+-#define S(x, s, f)	[x].desc = s, [x].handler = f
+-	S(IPI_WAKEUP, "CPU wakeup interrupts", NULL),
+-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+-	S(IPI_TIMER, "Timer broadcast interrupts", tick_receive_broadcast),
+-#endif
+-	S(IPI_RESCHEDULE, "Rescheduling interrupts", scheduler_ipi),
+-	S(IPI_CALL_FUNC, "Function call interrupts",
+-					generic_smp_call_function_interrupt),
+-	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts",
+-				generic_smp_call_function_single_interrupt),
+-	S(IPI_CPU_STOP, "CPU stop interrupts", ipi_cpu_stop),
+-#ifdef CONFIG_IRQ_WORK
+-	S(IPI_IRQ_WORK, "IRQ work interrupts", irq_work_run),
+-#endif
+-	S(IPI_COMPLETION, "completion interrupts", ipi_complete),
++static const char *ipi_types[NR_IPI] = {
++#define S(x,s)	[x] = s
++	S(IPI_WAKEUP, "CPU wakeup interrupts"),
++	S(IPI_TIMER, "Timer broadcast interrupts"),
++	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
++	S(IPI_CALL_FUNC, "Function call interrupts"),
++	S(IPI_CALL_FUNC_SINGLE, "Single function call interrupts"),
++	S(IPI_CPU_STOP, "CPU stop interrupts"),
++	S(IPI_IRQ_WORK, "IRQ work interrupts"),
++	S(IPI_COMPLETION, "completion interrupts"),
+ };
+ 
+ void show_ipi_list(struct seq_file *p, int prec)
+@@ -492,13 +478,13 @@ void show_ipi_list(struct seq_file *p, int prec)
+ 	unsigned int cpu, i;
+ 
+ 	for (i = 0; i < NR_IPI; i++) {
+-		if (ipi_types[i].handler) {
+-			seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
+-			for_each_present_cpu(cpu)
+-				seq_printf(p, "%10u ",
+-					__get_irq_stat(cpu, ipi_irqs[i]));
+-			seq_printf(p, " %s\n", ipi_types[i].desc);
+-		}
++		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
++
++		for_each_online_cpu(cpu)
++			seq_printf(p, "%10u ",
++				   __get_irq_stat(cpu, ipi_irqs[i]));
++
++		seq_printf(p, " %s\n", ipi_types[i]);
+ 	}
+ }
+ 
+@@ -525,10 +511,8 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
+ /*
+  * ipi_cpu_stop - handle IPI from smp_send_stop()
+  */
+-static void ipi_cpu_stop(void)
++static void ipi_cpu_stop(unsigned int cpu)
+ {
+-	unsigned int cpu = smp_processor_id();
+-
+ 	if (system_state == SYSTEM_BOOTING ||
+ 	    system_state == SYSTEM_RUNNING) {
+ 		raw_spin_lock(&stop_lock);
+@@ -554,10 +538,8 @@ int register_ipi_completion(struct completion *completion, int cpu)
+ 	return IPI_COMPLETION;
+ }
+ 
+-static void ipi_complete(void)
++static void ipi_complete(unsigned int cpu)
+ {
+-	unsigned int cpu = smp_processor_id();
+-
+ 	complete(per_cpu(cpu_completion, cpu));
+ }
+ 
+@@ -574,48 +556,64 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
+ 	unsigned int cpu = smp_processor_id();
+ 	struct pt_regs *old_regs = set_irq_regs(regs);
+ 
+-	if (ipi_types[ipinr].handler) {
++	if (ipinr < NR_IPI)
+ 		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
++
++	switch (ipinr) {
++	case IPI_WAKEUP:
++		break;
++
++#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
++	case IPI_TIMER:
+ 		irq_enter();
+-		(*ipi_types[ipinr].handler)();
++		tick_receive_broadcast();
+ 		irq_exit();
+-	} else
+-		pr_debug("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
++		break;
++#endif
+ 
+-	set_irq_regs(old_regs);
+-}
++	case IPI_RESCHEDULE:
++		scheduler_ipi();
++		break;
+ 
+-/*
+- * set_ipi_handler:
+- * Interface provided for a kernel module to specify an IPI handler function.
+- */
+-int set_ipi_handler(int ipinr, void *handler, char *desc)
+-{
+-	unsigned int cpu = smp_processor_id();
++	case IPI_CALL_FUNC:
++		irq_enter();
++		generic_smp_call_function_interrupt();
++		irq_exit();
++		break;
+ 
+-	if (ipi_types[ipinr].handler) {
+-		pr_crit("CPU%u: IPI handler 0x%x already registered to %pf\n",
+-					cpu, ipinr, ipi_types[ipinr].handler);
+-		return -1;
+-	}
++	case IPI_CALL_FUNC_SINGLE:
++		irq_enter();
++		generic_smp_call_function_single_interrupt();
++		irq_exit();
++		break;
+ 
+-	ipi_types[ipinr].handler = handler;
+-	ipi_types[ipinr].desc = desc;
++	case IPI_CPU_STOP:
++		irq_enter();
++		ipi_cpu_stop(cpu);
++		irq_exit();
++		break;
+ 
+-	return 0;
+-}
+-EXPORT_SYMBOL(set_ipi_handler);
++#ifdef CONFIG_IRQ_WORK
++	case IPI_IRQ_WORK:
++		irq_enter();
++		irq_work_run();
++		irq_exit();
++		break;
++#endif
+ 
+-/*
+- * clear_ipi_handler:
+- * Interface provided for a kernel module to clear an IPI handler function.
+- */
+-void clear_ipi_handler(int ipinr)
+-{
+-	ipi_types[ipinr].handler = NULL;
+-	ipi_types[ipinr].desc = NULL;
++	case IPI_COMPLETION:
++		irq_enter();
++		ipi_complete(cpu);
++		irq_exit();
++		break;
++
++	default:
++		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
++		       cpu, ipinr);
++		break;
++	}
++	set_irq_regs(old_regs);
+ }
+-EXPORT_SYMBOL(clear_ipi_handler);
+ 
+ void smp_send_reschedule(int cpu)
+ {
+diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
+index ceffac7..12698ee 100644
+--- a/drivers/irqchip/irq-gic.c
++++ b/drivers/irqchip/irq-gic.c
+@@ -247,14 +247,13 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+ 			    bool force)
+ {
+ 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
+-	unsigned int shift = (gic_irq(d) % 4) * 8;
+-	unsigned int cpu;
++	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
+ 	u32 val, mask, bit;
+ 
+-	if (force)
+-		cpu = cpumask_any_and(mask_val, cpu_possible_mask);
+-	else
++	if (!force)
+ 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
++	else
++		cpu = cpumask_first(mask_val);
+ 
+ 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
+ 		return -EINVAL;
+@@ -268,17 +267,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+ 
+ 	return IRQ_SET_MASK_OK;
+ }
+-
+-void gic_set_cpu(unsigned int cpu, unsigned int irq)
+-{
+-	struct irq_data *d = irq_get_irq_data(irq);
+-	struct cpumask mask;
+-
+-	cpumask_clear(&mask);
+-	cpumask_set_cpu(cpu, &mask);
+-	gic_set_affinity(d, &mask, true);
+-}
+-EXPORT_SYMBOL(gic_set_cpu);
+ #endif
+ 
+ #ifdef CONFIG_PM
+@@ -687,7 +675,6 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
+ 
+ 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+ }
+-EXPORT_SYMBOL(gic_raise_softirq);
+ #endif
+ 
+ #ifdef CONFIG_BL_SWITCHER
-- 
2.2.2


