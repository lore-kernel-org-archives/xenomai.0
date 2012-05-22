From: Jean-Pascal JULIEN <jean-pascal.julien@insiteo.com>
Date: Tue, 22 May 2012 10:34:12 +0200
Message-ID: <C7408997F5B0784C970ED53C11855FAE01111233915D@INSITEOSBS01.insiteo.local>
References: <4FBADE7D.5030609@bbn.com>,<4FBB4951.5070803@xenomai.org>
In-Reply-To: <4FBB4951.5070803@xenomai.org>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RE : A possible mis-interaction between CONFIG_PREEMPT
 and GPIO IRQ handling for ARM, leading to extreme latency
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

Hi,

I have patch with the http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommit;=
h=3D81bfc05c4716b76e79f5e486baf4c52015a3b92c. for avoid my IRQ latency.
Unfortunately, I have the same result.=20

Between the new patch and the patch of the next week this piece of code is =
missing.
@@ -483,7 +483,8 @@ void __ipipe_handle_irq(int irq, struct pt_regs *regs)
        else {
                head =3D __ipipe_pipeline.next;
                next_domain =3D list_entry(head, struct ipipe_domain, p_lin=
k);
-               if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[ir=
q].control))) {
+               if (!(flags & IPIPE_IRQF_NOSYNC)
+                   && likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs=
[irq].control))) {
                        if (!m_ack && next_domain->irqs[irq].acknowledge) {
                                desc =3D ipipe_virtual_irq_p(irq) ? NULL : =
irq_to_desc(irq);
                                next_domain->irqs[irq].acknowledge(irq, des=
c);

It is normally?

JP
________________________________________
De : xenomai-bounces@xenomai.org [xenomai-bounces@xenomai.org] de la part d=
e Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Date d'envoi : mardi 22 mai 2012 10:07
=C0 : Mitchell Tasman
Cc : xenomai@xenomai.org
Objet : Re: [Xenomai] A possible mis-interaction between CONFIG_PREEMPT and=
 GPIO IRQ handling for ARM, leading to extreme latency

On 05/22/2012 02:31 AM, Mitchell Tasman wrote:
> Hi.  I'm running an OMAP DM3725-based board with a 2.6.38.8 kernel, a
> mid-May 2012 git snapshot of xenomai-2.6, and a backport (really just
> application) of the patch that Gilles referenced in the "IRQ latency"
> thread last week:
>
> http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommit;h=3D81bfc05c4716b76e=
79f5e486baf4c52015a3b92c

Please try the following patch instead:

diff --git a/arch/arm/include/asm/ipipe.h b/arch/arm/include/asm/ipipe.h
index 9b17c06..a510b09 100644
--- a/arch/arm/include/asm/ipipe.h
+++ b/arch/arm/include/asm/ipipe.h
@@ -285,14 +285,15 @@ void __ipipe_grab_irq(int irq, struct pt_regs *regs);

 void __ipipe_exit_irq(struct pt_regs *regs);

-void __ipipe_handle_irq(int irq, struct pt_regs *regs);
+#define IPIPE_IRQF_NOACK    0x1
+#define IPIPE_IRQF_NOSYNC   0x2
+
+void __ipipe_handle_irq(int irq, int flags);

 static inline void ipipe_handle_chained_irq(unsigned int irq)
 {
-       struct pt_regs regs;    /* dummy */
-
        ipipe_trace_irq_entry(irq);
-       __ipipe_handle_irq(irq, &regs);
+       __ipipe_handle_irq(irq, IPIPE_IRQF_NOSYNC);
        ipipe_trace_irq_exit(irq);
 }

diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.=
h
index b49c8ac..f655b27 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -55,7 +55,7 @@ extern void __iomem *twd_base;
 #define __ipipe_mach_relay_ipi(ipi, thiscpu)   \
        ({                                      \
                (void)(thiscpu);                \
-               __ipipe_handle_irq(ipi, NULL);  \
+               __ipipe_handle_irq(ipi, IPIPE_IRQF_NOACK);      \
        })

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

        /* Software-triggered IRQs do not need any ack. */
-       m_ack =3D (regs =3D=3D NULL);
+       m_ack =3D (flags & IPIPE_IRQF_NOACK) !=3D 0;

 #ifdef CONFIG_IPIPE_DEBUG
        if (unlikely(irq >=3D IPIPE_NR_IRQS) ||
@@ -490,7 +490,11 @@ void __ipipe_handle_irq(int irq, struct pt_regs *regs)
                                desc =3D ipipe_virtual_irq_p(irq) ? NULL : =
irq_to_desc(irq);
                                next_domain->irqs[irq].acknowledge(irq, des=
c);
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

-       __ipipe_handle_irq(irq, regs);
+       __ipipe_handle_irq(irq, 0);

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


--
                                                                Gilles.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai

