From: Jean-Pascal JULIEN <jean-pascal.julien@insiteo.com>
Date: Wed, 23 May 2012 10:22:13 +0200
Message-ID: <C7408997F5B0784C970ED53C11855FAE011112339167@INSITEOSBS01.insiteo.local>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and
 GPIO IRQ handling for ARM, leading to extreme latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles,


The maximum latency response to the irq is less than 100us.
I performed the test during more than 12 hours.
I re do the first test with the internal timer which toggles a GPIO each 1m=
s and i have no regression.

To avoid any confusion i give you the patches which were applied :

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 25c17a3..3e5a88d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1221,7 +1221,7 @@ static void omap_gpio_free(struct gpio_chip *chip, un=
signed offset)
         spin_unlock_irqrestore(&bank->lock, flags);
 }
=20
-static void gpio_demux_inner(struct gpio_bank *bank, u32 isr, int nonroot)
+static void gpio_demux_inner(struct gpio_bank *bank, u32 isr)
 {
         unsigned int gpio_irq, gpio_index;
=20
@@ -1230,13 +1230,6 @@ static void gpio_demux_inner(struct gpio_bank *bank,=
 u32 isr, int nonroot)
                 if (!(isr & 1))
                         continue;
=20
-#ifdef CONFIG_IPIPE
-               if (!nonroot) {
-                       local_irq_enable_hw();
-                       local_irq_disable_hw();
-               }
-#endif /* CONFIG_IPIPE */
-
 #ifdef CONFIG_ARCH_OMAP1
                 gpio_index =3D get_gpio_index(irq_to_gpio(gpio_irq));
=20
@@ -1272,11 +1265,7 @@ static void gpio_irq_handler(unsigned int irq, struc=
t irq_desc *desc)
         u32 retrigger =3D 0;
         int unmasked =3D 0;
=20
-#ifndef CONFIG_IPIPE
         desc->irq_data.chip->irq_ack(&desc->irq_data);
-#else /* CONFIG_IPIPE */
-       desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
-#endif /* CONFIG_IPIPE */
=20
         bank =3D get_irq_data(irq);
 #ifdef CONFIG_ARCH_OMAP1
@@ -1312,13 +1301,6 @@ static void gpio_irq_handler(unsigned int irq, struc=
t irq_desc *desc)
                 u32 isr_saved, level_mask =3D 0;
                 u32 enabled;
=20
-#ifdef CONFIG_IPIPE
-               if (!bank->nonroot_gpios) {
-                       local_irq_enable_hw();
-                       local_irq_disable_hw();
-               }
-#endif /* CONFIG_IPIPE */
-
                 enabled =3D _get_gpio_irqbank_mask(bank);
                 isr_saved =3D isr =3D __raw_readl(isr_reg) & enabled;
=20
@@ -1336,27 +1318,19 @@ static void gpio_irq_handler(unsigned int irq, stru=
ct irq_desc *desc)
                 _clear_gpio_irqbank(bank, isr_saved & ~level_mask);
                 _enable_gpio_irqbank(bank, isr_saved & ~level_mask, 1);
=20
-#ifndef CONFIG_IPIPE
                 /* if there is only edge sensitive GPIO pin interrupts
                 configured, we could unmask GPIO bank interrupt immediatel=
y */
                 if (!level_mask && !unmasked) {
                         unmasked =3D 1;
                         desc->irq_data.chip->irq_unmask(&desc->irq_data);
                 }
-#endif /* !CONFIG_IPIPE */
=20
                 isr |=3D retrigger;
                 retrigger =3D 0;
                 if (!isr)
                         break;
=20
-#ifdef CONFIG_IPIPE
-               if (bank->nonroot_gpios)
-                       gpio_demux_inner(bank, isr & bank->nonroot_gpios, 1=
);
-               gpio_demux_inner(bank, isr & ~bank->nonroot_gpios, 0);
-#else /* !CONFIG_IPIPE */
-               gpio_demux_inner(bank, isr, 0);
-#endif /* !CONFIG_IPIPE */
+               gpio_demux_inner(bank, isr);
=20
         }
         /* if bank has any level sensitive GPIO pin interrupt


diff --git a/arch/arm/include/asm/ipipe.h b/arch/arm/include/asm/ipipe.h
index 9b17c06..a510b09 100644
--- a/arch/arm/include/asm/ipipe.h
+++ b/arch/arm/include/asm/ipipe.h
@@ -285,14 +285,15 @@ void __ipipe_grab_irq(int irq, struct pt_regs *regs);
=20
 void __ipipe_exit_irq(struct pt_regs *regs);
=20
-void __ipipe_handle_irq(int irq, struct pt_regs *regs);
+#define IPIPE_IRQF_NOACK    0x1
+#define IPIPE_IRQF_NOSYNC   0x2
+
+void __ipipe_handle_irq(int irq, int flags);
=20
 static inline void ipipe_handle_chained_irq(unsigned int irq)
 {
-       struct pt_regs regs;    /* dummy */
-
         ipipe_trace_irq_entry(irq);
-       __ipipe_handle_irq(irq, &regs);
+       __ipipe_handle_irq(irq, IPIPE_IRQF_NOSYNC);
         ipipe_trace_irq_exit(irq);
 }
=20
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.=
h
index b49c8ac..f655b27 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -55,7 +55,7 @@ extern void __iomem *twd_base;
 #define __ipipe_mach_relay_ipi(ipi, thiscpu)    \
         ({                                      \
                 (void)(thiscpu);                \
-               __ipipe_handle_irq(ipi, NULL);  \
+               __ipipe_handle_irq(ipi, IPIPE_IRQF_NOACK);      \
         })
=20
 struct irq_desc;
diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
index f2f618c..ff93fa9 100644
--- a/arch/arm/kernel/ipipe.c
+++ b/arch/arm/kernel/ipipe.c
@@ -254,7 +254,7 @@ int ipipe_trigger_irq(unsigned irq)
                 return -EINVAL;
 #endif
         local_irq_save_hw(flags);
-       __ipipe_handle_irq(irq, NULL);
+       __ipipe_handle_irq(irq, IPIPE_IRQF_NOACK);
         local_irq_restore_hw(flags);
=20
         return 1;
@@ -462,7 +462,7 @@ out:
  * interrupt protection log is maintained here for each domain. Hw
  * interrupts are off on entry.
  */
-void __ipipe_handle_irq(int irq, struct pt_regs *regs)
+void __ipipe_handle_irq(int irq, int flags)
 {
         struct ipipe_domain *this_domain, *next_domain;
         struct list_head *head, *pos;
@@ -470,7 +470,7 @@ void __ipipe_handle_irq(int irq, struct pt_regs *regs)
         int m_ack;
=20
         /* Software-triggered IRQs do not need any ack. */
-       m_ack =3D (regs =3D=3D NULL);
+       m_ack =3D (flags & IPIPE_IRQF_NOACK) !=3D 0;
=20
 #ifdef CONFIG_IPIPE_DEBUG
         if (unlikely(irq >=3D IPIPE_NR_IRQS) ||
@@ -490,7 +490,11 @@ void __ipipe_handle_irq(int irq, struct pt_regs *regs)
                                 desc =3D ipipe_virtual_irq_p(irq) ? NULL :=
 irq_to_desc(irq);
                                 next_domain->irqs[irq].acknowledge(irq, de=
sc);
                         }
-                       __ipipe_dispatch_wired(next_domain, irq);
+                       if ((flags & IPIPE_IRQF_NOSYNC) =3D=3D 0)
+                               __ipipe_dispatch_wired(next_domain, irq);
+                       else
+                               __ipipe_set_irq_pending(next_domain, irq);
+
                         return;
                 }
         }
@@ -604,7 +608,7 @@ asmlinkage void __ipipe_grab_irq(int irq, struct pt_reg=
s *regs)
         ipipe_trace_begin(regs->ARM_ORIG_r0);
 #endif
=20
-       __ipipe_handle_irq(irq, regs);
+       __ipipe_handle_irq(irq, 0);
=20
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
         ipipe_trace_end(regs->ARM_ORIG_r0);
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 9ea207d..af02caa 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -527,7 +527,7 @@ __ipipe_grab_ipi(unsigned svc, struct pt_regs *regs) /*=
 hw IRQs off */
                 __ipipe_do_vnmi(IPIPE_SERVICE_VNMI, NULL);
         else if ((1 << svc) & IPI_IPIPE_ALL) {
                 virq =3D svc - IPI_IPIPE_CRITICAL + IPIPE_FIRST_IPI;
-               __ipipe_handle_irq(virq, NULL);
+               __ipipe_handle_irq(virq, IPIPE_IRQF_NOACK);
         } else
                 __ipipe_mach_relay_ipi(svc, cpu);
=20


Thanks you very much for your help.


Best Regards.

Jean-Pascal

