References: <239ad2a2-c093-86ee-3d1f-f38abd2df673@sina.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: linux-evl-5.10.46-evl1: INTC/gpmc is not pipeline-safe warning
In-reply-to: <239ad2a2-c093-86ee-3d1f-f38abd2df673@sina.com>
Date: Tue, 29 Jun 2021 18:35:46 +0200
Message-ID: <87v95wiq71.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: wayhoo <wayhoo@sina.com>
Cc: xenomai@xenomai.org


wayhoo via Xenomai <xenomai@xenomai.org> writes:

> Hello,
>
>     Ported linux-evl-5.10.46-evl1 to an am335x board, two warnings
> occurred at kernel startup, but evl test passed.
>
>     1. when CONFIG_SMP was not enabled, INTC warning information occurred:
>
> [    0.002179] IRQ pipeline enabled
> [    0.002190] TI gptimer clocksource: always-on
> /ocp/interconnect@44c00000/segment@200000/target-module@31000
> [    0.002196] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
> every 89478484971ns
> [    0.002202] clocksource: dmtimer: freq: 24000000 Hz, mask:
> 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
> [    0.002206] ------------[ cut here ]------------
> [    0.002211] WARNING: CPU: 0 PID: 0 at kernel/irq/chip.c:53
> irq_set_chip+0xc0/0xe0
> [    0.002215] irqchip INTC is not pipeline-safe!Modules linked in:
>

[SNIP]

>     2. when CONFIG_SMP was enabled,  there was no INTC warning, but
> gpmc warning occurred:
>
> [    7.596903] omap-gpmc 50000000.gpmc: GPMC revision 6.0
> [    7.602570] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> [    7.613268] ------------[ cut here ]------------
> [    7.613283] WARNING: CPU: 0 PID: 50 at kernel/irq/chip.c:53
> irq_set_chip+0xc0/0xe0
> [    7.613291] irqchip gpmc is not pipeline-safe!Modules linked in:
>

[SNIP]

These issues would require two fixups: one applied to the INTC
controller, the other to the generic irq chip support the former is
using:

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index d360a6eddd6d369..a8647443cc7b806 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -211,7 +211,7 @@ static int __init omap_alloc_gc_of(struct irq_domain *d, void __iomem *base)
 		ct->chip.irq_mask = irq_gc_mask_disable_reg;
 		ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 
-		ct->chip.flags |= IRQCHIP_SKIP_SET_WAKE;
+		ct->chip.flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE;
 
 		ct->regs.enable = INTC_MIR_CLEAR0 + 32 * i;
 		ct->regs.disable = INTC_MIR_SET0 + 32 * i;


diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index e2999a070a99a2b..378fb58219c6544 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -16,7 +16,7 @@
 #include "internals.h"
 
 static LIST_HEAD(gc_list);
-static DEFINE_RAW_SPINLOCK(gc_lock);
+static DEFINE_HARD_SPINLOCK(gc_lock);
 
 /**
  * irq_gc_noop - NOOP function

You may want to read this page [1], which explains the rationale for
those changes to the irqchip code.

>     3. below is the patch for gpmc warning, it just simply masks the
> warning.
>
> diff -uNr a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> --- a/drivers/memory/omap-gpmc.c    2021-06-27 23:33:13.000000000 +0800
> +++ b/drivers/memory/omap-gpmc.c    2021-06-29 13:09:45.151032676 +0800
> @@ -1405,6 +1405,7 @@
>      gpmc->irq_chip.irq_mask = gpmc_irq_mask;
>      gpmc->irq_chip.irq_unmask = gpmc_irq_unmask;
>      gpmc->irq_chip.irq_set_type = gpmc_irq_set_type;
> +    gpmc->irq_chip.flags = IRQCHIP_PIPELINE_SAFE;
>
>      gpmc_irq_domain = irq_domain_add_linear(gpmc->dev->of_node,
>                          gpmc->nirqs,
>
>     4. What more needs to be done to timer-ti-dm-timer.c and/or
> omap-gpmc.c? any advice, please.
>
>

Regarding the the gpmc, you may need to run the IRQ demultiplexer
directly from the out-of-band stage, the following patch would ensure
this.

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index f80c2ea39ca4c1c..ebcda04da440b8f 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1405,6 +1405,7 @@ static int gpmc_setup_irq(struct gpmc_device *gpmc)
 	gpmc->irq_chip.irq_mask = gpmc_irq_mask;
 	gpmc->irq_chip.irq_unmask = gpmc_irq_unmask;
 	gpmc->irq_chip.irq_set_type = gpmc_irq_set_type;
+	gpmc->irq_chip.flags = IRQCHIP_PIPELINE_SAFE;
 
 	gpmc_irq_domain = irq_domain_add_linear(gpmc->dev->of_node,
 						gpmc->nirqs,
@@ -1415,7 +1416,7 @@ static int gpmc_setup_irq(struct gpmc_device *gpmc)
 		return -ENODEV;
 	}
 
-	rc = request_irq(gpmc->irq, gpmc_handle_irq, 0, "gpmc", gpmc);
+	rc = request_irq(gpmc->irq, gpmc_handle_irq, IRQF_OOB, "gpmc", gpmc);
 	if (rc) {
 		dev_err(gpmc->dev, "failed to request irq %d: %d\n",
 			gpmc->irq, rc);


Feedback welcome and needed so that proper fixes for your hardware could
be part of the next Dovetail and EVL releases.

[1] https://evlproject.org/dovetail/porting/irqflow/#irqchip-fixup

-- 
Philippe.

