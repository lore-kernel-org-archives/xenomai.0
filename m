Message-ID: <525FBAD0.6080407@cantastic.org>
Date: Thu, 17 Oct 2013 12:24:16 +0200
From: Ralf Roesch <xenomai@cantastic.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>	<525E7D85.9020307@xenomai.org>	<525E81CD.6000603@steinkuehler.net>	<525E8665.8000705@steinkuehler.net>	<525E8A43.5090601@xenomai.org>	<525E8BFF.1060201@steinkuehler.net>	<525EAFFD.3010207@steinkuehler.net>	<525EB7A2.1050601@xenomai.org>
	<525EBAD4.3080100@steinkuehler.net>
	<525EEBE2.8080708@steinkuehler.net>
	<525F362F.6080109@steinkuehler.net> <525FADFA.2020009@xenomai.org>
In-Reply-To: <525FADFA.2020009@xenomai.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu Oct 17 2013 11:29:30 GMT+0200, Gilles Chanteperdrix =

<gilles.chanteperdrix@xenomai.org>  wrote:
> On 10/17/2013 02:58 AM, Charles Steinkuehler wrote:
>> On 10/16/2013 2:41 PM, Charles Steinkuehler wrote:
>>> On 10/16/2013 11:12 AM, Charles Steinkuehler wrote:
>>>> I'll test with ipipe disabled, go through the Arm Porting guide, =

>>>> and see
>>>> where that gets me...
>>>
>>> After building a patched kernel without ipipe or xenomai enabled:
>>>
>>> $ egrep '(IPIPE|XENO)' KERNEL/.config
>>> # CONFIG_XENOMAI is not set
>>> CONFIG_XENO_GENERIC_STACKPOOL=3Dy
>>> CONFIG_XENO_FASTSYNCH_DEP=3Dy
>>> CONFIG_XENO_FASTSYNCH=3Dy
>>> # CONFIG_IPIPE is not set
>>>
>>> ...the mmc issue seems fixed.  So according to the porting guide, this
>>> indicates a likely problem with interrupts or the interrupt controller
>>> (as Gilles indicated).
>>
>> Based on the ARM porting guide, the first thing I did was to disable IRQ
>> muting by simply commenting out the two calls to:
>>
>>    ipipe_pic_muter_register
>>
>> ...in <linux>/drivers/gpio/gpio-omap.c
>>
>> This results in a kernel that DOES NOT HANG with ipipe enabled!
>
> It does not really make sense: when I-pipe is enabled but Xenomai =

> disabled, the PIC muting is only used to tweak the interrupt =

> controller priority. Since there are only secondary mode irqs, they =

> all should use the same priority.
>
> Is arch/arm/mach-omap2/irq.c modified by the BeagleBone patches, if =

> yes, could you put the modified version somewhere I could have a look =

> at it?
>
> Regards.
>
I think following additional patch has been applied by the bone patch set:

 From 931f9fa298dcbdddfc82f9227596a445fd174f17 Mon Sep 17 00:00:00 2001
From: =3D?utf8?q?H=3DC3=3DA5kan=3D20Engblom?=3D <hkengblom@gmail.com>
Date: Wed, 24 Apr 2013 10:53:46 +0200
Subject: [PATCH] omap2 irq: fix interrupt latency

The problem in my system was that interrutp latency for GPIO interrupts =

(GPIO used as interrupt source by use of "echo rising > =

/sys/class/gpio/gpioXX/edge") was _very_ long, probably until somother =

interrupt made GPIO interrupts "visable". The problem that the patch =

corrects is that also a AM33XX has four registers to check in the =

interrupt controller to find out which interrupt that caused the =

controlled to assert an interrupt.
---
  arch/arm/mach-omap2/irq.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 3926f37..57d1b7d 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -233,7 +233,7 @@ static inline void omap_intc_handle_irq(void __iomem =

*base_addr, struct pt_regs
              goto out;

          irqnr =3D readl_relaxed(base_addr + 0xd8);
-#ifdef CONFIG_SOC_TI81XX
+#if defined(CONFIG_SOC_TI81XX) || defined(CONFIG_SOC_AM33XX)
          if (irqnr)
              goto out;
          irqnr =3D readl_relaxed(base_addr + 0xf8);
-- =

1.8.4.rc3

(complete source attached)

regards
Ralf


-------------- next part --------------
/*
 * linux/arch/arm/mach-omap2/irq.c
 *
 * Interrupt handler for OMAP2 boards.
 *
 * Copyright (C) 2005 Nokia Corporation
 * Author: Paul Mundt <paul.mundt@nokia.com>
 *
 * This file is subject to the terms and conditions of the GNU General Publ=
ic
 * License. See the file "COPYING" in the main directory of this archive
 * for more details.
 */
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <asm/ipipe.h>

#include <asm/exception.h>
#include <asm/mach/irq.h>
#include <linux/irqdomain.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/of_irq.h>

#include "soc.h"
#include "iomap.h"
#include "common.h"

/* selected INTC register offsets */

#define INTC_REVISION		0x0000
#define INTC_SYSCONFIG		0x0010
#define INTC_SYSSTATUS		0x0014
#define INTC_SIR		0x0040
#define INTC_CONTROL		0x0048
#define INTC_PROTECTION		0x004C
#define INTC_IDLE		0x0050
#define INTC_THRESHOLD		0x0068
#define INTC_MIR0		0x0084
#define INTC_MIR_CLEAR0		0x0088
#define INTC_MIR_SET0		0x008c
#define INTC_PENDING_IRQ0	0x0098
#define INTC_PRIO               0x0100
/* Number of IRQ state bits in each MIR register */
#define IRQ_BITS_PER_REG	32

#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
#define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
#define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
#define INTCPS_NR_MIR_REGS	3
#define INTCPS_NR_IRQS		96

#if !defined(MULTI_OMAP1) && !defined(MULTI_OMAP2)
#define inline_single inline
#else
#define inline_single
#endif

/*
 * OMAP2 has a number of different interrupt controllers, each interrupt
 * controller is identified as its own "bank". Register definitions are
 * fairly consistent for each bank, but not all registers are implemented
 * for each bank.. when in doubt, consult the TRM.
 */
static struct omap_irq_bank {
	void __iomem *base_reg;
	unsigned int nr_irqs;
} __attribute__ ((aligned(4))) irq_banks[] =3D {
	{
		/* MPU INTC */
		.nr_irqs	=3D 96,
	},
};

static struct irq_domain *domain;

/* Structure to save interrupt controller context */
struct omap3_intc_regs {
	u32 sysconfig;
	u32 protection;
	u32 idle;
	u32 threshold;
	u32 ilr[INTCPS_NR_IRQS];
	u32 mir[INTCPS_NR_MIR_REGS];
};

/* INTC bank register get/set */

static inline_single void intc_bank_write_reg(u32 val, struct omap_irq_bank=
 *bank, u16 reg)
{
	__raw_writel(val, bank->base_reg + reg);
}

static inline_single u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16=
 reg)
{
	return __raw_readl(bank->base_reg + reg);
}

/* XXX: FIQ and additional INTC support (only MPU at the moment) */
static inline_single void omap_ack_irq(struct irq_data *d)
{
	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
	dsb();
}

static void omap_mask_ack_irq(struct irq_data *d)
{
	irq_gc_mask_disable_reg(d);
	omap_ack_irq(d);
}

static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
{
	unsigned long tmp;

	tmp =3D intc_bank_read_reg(bank, INTC_REVISION) & 0xff;
	pr_info("IRQ: Found an INTC at 0x%p (revision %ld.%ld) with %d interrupts\=
n",
		bank->base_reg, tmp >> 4, tmp & 0xf, bank->nr_irqs);

	tmp =3D intc_bank_read_reg(bank, INTC_SYSCONFIG);
	tmp |=3D 1 << 1;	/* soft reset */
	intc_bank_write_reg(tmp, bank, INTC_SYSCONFIG);

	while (!(intc_bank_read_reg(bank, INTC_SYSSTATUS) & 0x1))
		/* Wait for reset to complete */;

#ifndef CONFIG_IPIPE
	/* Enable autoidle */
	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
	intc_bank_write_reg(0x2, bank, INTC_IDLE);
#else /* CONFIG_IPIPE */
	/* Disable autoidle */
	intc_bank_write_reg(0, bank, INTC_SYSCONFIG);
	intc_bank_write_reg(0x1, bank, INTC_IDLE);
#endif /* CONFIG_IPIPE */
}

int omap_irq_pending(void)
{
	int i;

	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
		struct omap_irq_bank *bank =3D irq_banks + i;
		int irq;

		for (irq =3D 0; irq < bank->nr_irqs; irq +=3D 32)
			if (intc_bank_read_reg(bank, INTC_PENDING_IRQ0 +
					       ((irq >> 5) << 5)))
				return 1;
	}
	return 0;
}

static __init void
omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
{
	struct irq_chip_generic *gc;
	struct irq_chip_type *ct;

	gc =3D irq_alloc_generic_chip("INTC", 1, irq_start, base,
					handle_level_irq);
	ct =3D gc->chip_types;
	ct->chip.irq_ack =3D omap_mask_ack_irq;
	ct->chip.irq_mask =3D irq_gc_mask_disable_reg;
#ifdef CONFIG_IPIPE
	ct->chip.irq_mask_ack =3D omap_mask_ack_irq;
#endif
	ct->chip.irq_unmask =3D irq_gc_unmask_enable_reg;
	ct->chip.flags |=3D IRQCHIP_SKIP_SET_WAKE;

	ct->regs.enable =3D INTC_MIR_CLEAR0;
	ct->regs.disable =3D INTC_MIR_SET0;
	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
				IRQ_NOREQUEST | IRQ_NOPROBE, 0);
}

static void __init omap_init_irq(u32 base, int nr_irqs,
				 struct device_node *node)
{
	void __iomem *omap_irq_base;
	unsigned long nr_of_irqs =3D 0;
	unsigned int nr_banks =3D 0;
	int i, j, irq_base;

	omap_irq_base =3D ioremap(base, SZ_4K);
	if (WARN_ON(!omap_irq_base))
		return;

	irq_base =3D irq_alloc_descs(-1, 0, nr_irqs, 0);
	if (irq_base < 0) {
		pr_warn("Couldn't allocate IRQ numbers\n");
		irq_base =3D 0;
	}

	domain =3D irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
				       &irq_domain_simple_ops, NULL);

	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
		struct omap_irq_bank *bank =3D irq_banks + i;

		bank->nr_irqs =3D nr_irqs;

		/* Static mapping, never released */
		bank->base_reg =3D ioremap(base, SZ_4K);
		if (!bank->base_reg) {
			pr_err("Could not ioremap irq bank%i\n", i);
			continue;
		}

		omap_irq_bank_init_one(bank);

		for (j =3D 0; j < bank->nr_irqs; j +=3D 32)
			omap_alloc_gc(bank->base_reg + j, j + irq_base, 32);

		nr_of_irqs +=3D bank->nr_irqs;
		nr_banks++;
	}

	pr_info("Total of %ld interrupts on %d active controller%s\n",
		nr_of_irqs, nr_banks, nr_banks > 1 ? "s" : "");
}

void __init omap2_init_irq(void)
{
	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
}

void __init omap3_init_irq(void)
{
	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
}

void __init ti81xx_init_irq(void)
{
	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
}

static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_=
regs *regs)
{
	u32 irqnr;

	do {
		irqnr =3D readl_relaxed(base_addr + 0x98);
		if (irqnr)
			goto out;

		irqnr =3D readl_relaxed(base_addr + 0xb8);
		if (irqnr)
			goto out;

		irqnr =3D readl_relaxed(base_addr + 0xd8);
#if defined(CONFIG_SOC_TI81XX) || defined(CONFIG_SOC_AM33XX)
		if (irqnr)
			goto out;
		irqnr =3D readl_relaxed(base_addr + 0xf8);
#endif

out:
		if (!irqnr)
			break;

		irqnr =3D readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
		irqnr &=3D ACTIVEIRQ_MASK;

		if (irqnr) {
			irqnr =3D irq_find_mapping(domain, irqnr);
			ipipe_handle_multi_irq(irqnr, regs);
		}
	} while (irqnr);
}

asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs =
*regs)
{
	void __iomem *base_addr =3D OMAP2_IRQ_BASE;
	omap_intc_handle_irq(base_addr, regs);
}

int __init intc_of_init(struct device_node *node,
			     struct device_node *parent)
{
	struct resource res;
	u32 nr_irq =3D 96;

	if (WARN_ON(!node))
		return -ENODEV;

	if (of_address_to_resource(node, 0, &res)) {
		WARN(1, "unable to get intc registers\n");
		return -EINVAL;
	}

	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
		pr_warn("unable to get intc-size, default to %d\n", nr_irq);

	omap_init_irq(res.start, nr_irq, of_node_get(node));

	return 0;
}

static struct of_device_id irq_match[] __initdata =3D {
	{ .compatible =3D "ti,omap2-intc", .data =3D intc_of_init, },
	{ }
};

void __init omap_intc_of_init(void)
{
	of_irq_init(irq_match);
}

 =

#if defined(CONFIG_IPIPE) && defined(CONFIG_ARCH_OMAP2PLUS)
#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
void omap3_intc_mute(void)
{
	struct omap_irq_bank *bank =3D &irq_banks[0];

	intc_bank_write_reg(0x1, bank, INTC_THRESHOLD);
	intc_bank_write_reg(0x1, bank, INTC_CONTROL);
}

void omap3_intc_unmute(void)
{
	struct omap_irq_bank *bank =3D &irq_banks[0];

	intc_bank_write_reg(0xff, bank, INTC_THRESHOLD);
}

void omap3_intc_set_irq_prio(int irq, int hi)
{
	struct omap_irq_bank *bank =3D &irq_banks[0];

	if (irq >=3D INTCPS_NR_MIR_REGS * 32)
		return;
	intc_bank_write_reg(hi ? 0 : 0xfc, bank, INTC_PRIO + 4 * irq);
}
#endif /* CONFIG_ARCH_OMAP3 */
#endif /* CONFIG_IPIPE && ARCH_OMAP2PLUS */

#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];

void omap_intc_save_context(void)
{
	int ind =3D 0, i =3D 0;
	for (ind =3D 0; ind < ARRAY_SIZE(irq_banks); ind++) {
		struct omap_irq_bank *bank =3D irq_banks + ind;
		intc_context[ind].sysconfig =3D
			intc_bank_read_reg(bank, INTC_SYSCONFIG);
		intc_context[ind].protection =3D
			intc_bank_read_reg(bank, INTC_PROTECTION);
		intc_context[ind].idle =3D
			intc_bank_read_reg(bank, INTC_IDLE);
		intc_context[ind].threshold =3D
			intc_bank_read_reg(bank, INTC_THRESHOLD);
		for (i =3D 0; i < INTCPS_NR_IRQS; i++)
			intc_context[ind].ilr[i] =3D
				intc_bank_read_reg(bank, (0x100 + 0x4*i));
		for (i =3D 0; i < INTCPS_NR_MIR_REGS; i++)
			intc_context[ind].mir[i] =3D
				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
				(0x20 * i));
	}
}

void omap_intc_restore_context(void)
{
	int ind =3D 0, i =3D 0;

	for (ind =3D 0; ind < ARRAY_SIZE(irq_banks); ind++) {
		struct omap_irq_bank *bank =3D irq_banks + ind;
		intc_bank_write_reg(intc_context[ind].sysconfig,
					bank, INTC_SYSCONFIG);
		intc_bank_write_reg(intc_context[ind].sysconfig,
					bank, INTC_SYSCONFIG);
		intc_bank_write_reg(intc_context[ind].protection,
					bank, INTC_PROTECTION);
		intc_bank_write_reg(intc_context[ind].idle,
					bank, INTC_IDLE);
		intc_bank_write_reg(intc_context[ind].threshold,
					bank, INTC_THRESHOLD);
		for (i =3D 0; i < INTCPS_NR_IRQS; i++)
			intc_bank_write_reg(intc_context[ind].ilr[i],
				bank, (0x100 + 0x4*i));
		for (i =3D 0; i < INTCPS_NR_MIR_REGS; i++)
			intc_bank_write_reg(intc_context[ind].mir[i],
				 &irq_banks[0], INTC_MIR0 + (0x20 * i));
	}
	/* MIRs are saved and restore with other PRCM registers */
}

void omap3_intc_suspend(void)
{
	/* A pending interrupt would prevent OMAP from entering suspend */
	omap_ack_irq(NULL);
}

void omap3_intc_prepare_idle(void)
{
	/*
	 * Disable autoidle as it can stall interrupt controller,
	 * cf. errata ID i540 for 3430 (all revisions up to 3.1.x)
	 */
	intc_bank_write_reg(0, &irq_banks[0], INTC_SYSCONFIG);
}

void omap3_intc_resume_idle(void)
{
	/* Re-enable autoidle */
	intc_bank_write_reg(1, &irq_banks[0], INTC_SYSCONFIG);
}

asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs =
*regs)
{
	void __iomem *base_addr =3D OMAP3_IRQ_BASE;
	omap_intc_handle_irq(base_addr, regs);
}
#endif /* CONFIG_ARCH_OMAP3 */
