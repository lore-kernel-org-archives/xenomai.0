From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Date: Tue, 19 May 2015 08:59:10 +0000
Message-ID: <C9F8415089354E4FB76F4548B3515AF48CD382E9@edb0.wapice.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] [RFC] [PATCH] Backport for chained interrupt handling fix
 - Linux 3.1.10 PowerPC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello

We have a platform with Freescale MPC8309 and we are using Linux 3.1.10
with the adeos-ipipe patch. We stumbled upon a problem where the chained
interrupts from the QE have large interrupt latencies. The problem was
also described in this mailing list topic:
http://comments.gmane.org/gmane.linux.real-time.xenomai.users/13917

We backported the fixes suggested by Philippe and Gilles to our platform.
We used Gilles' backport for ARM as a basis (because we have pre ipipe-core
version of the I-pipe) and integrated also some changes from Philippe's pat=
ches
(which were for the ipipe-core version).

The patch of the backport is attached in this email. The large interrupt la=
tencies were fixed
and the system seems to be stable. Currently changes were done only to MPC8=
3xx
specific parts because other PowerPC platforms are not available for testin=
g.

BR,
Jouko Haapaluoma
Wapice Oy
Tampere, Finland


From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Date: Tue, 12 May 2015 15:35:22 +0300
Subject: [PATCH] Refactor chained interrupts handling to fix latency proble=
ms

--- arch/powerpc/include/asm/ipipe.h   | 42 +++++--------------------------=
-------
 arch/powerpc/include/asm/qe_ic.h   | 20 ++++++------------
 arch/powerpc/kernel/ipipe.c        | 13 ++++++------
 arch/powerpc/sysdev/qe_lib/qe_ic.c |  6 ++----
 4 files changed, 20 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/include/asm/ipipe.h b/arch/powerpc/include/asm/ip=
ipe.h
index 977028d..4fc5ab2 100644
--- a/arch/powerpc/include/asm/ipipe.h
+++ b/arch/powerpc/include/asm/ipipe.h
@@ -51,6 +51,9 @@
 #define IPIPE_MINOR_NUMBER	13
 #define IPIPE_PATCH_NUMBER	6
=20
+#define IPIPE_IRQF_NOACK    0x1
+#define IPIPE_IRQF_NOSYNC   0x2
+
 #ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
=20
 struct mm;
@@ -182,14 +185,12 @@ void __ipipe_register_ipi(unsigned int irq);
=20
 DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
=20
-void __ipipe_handle_irq(int irq, struct pt_regs *regs);
+void __ipipe_handle_irq(int irq, int flags);
=20
 static inline void ipipe_handle_chained_irq(unsigned int irq)
 {
-	struct pt_regs regs;	/* dummy */
-
 	ipipe_trace_irq_entry(irq);
-	__ipipe_handle_irq(irq, &regs);
+	__ipipe_handle_irq(irq, IPIPE_IRQF_NOSYNC);
 	ipipe_trace_irq_exit(irq);
 }
=20
@@ -227,30 +228,6 @@ void handle_one_irq(unsigned int irq);
=20
 void check_stack_overflow(void);
=20
-static inline void ipipe_pre_cascade_noeoi(struct irq_desc *desc)
-{
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	chip->irq_mask(&desc->irq_data);
-}
-
-static inline void ipipe_post_cascade_noeoi(struct irq_desc *desc)
-{
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	chip->irq_unmask(&desc->irq_data);
-}
-
-static inline void ipipe_pre_cascade_eoi(struct irq_desc *desc)
-{
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	chip->irq_eoi(&desc->irq_data); /* EOI will mask too. */
-}
-
-static inline void ipipe_post_cascade_eoi(struct irq_desc *desc)
-{
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	chip->irq_unmask(&desc->irq_data);
-}
-
 #else /* !CONFIG_IPIPE */
=20
 #include <linux/interrupt.h>
@@ -261,15 +238,6 @@ static inline void ipipe_post_cascade_eoi(struct irq_d=
esc *desc)
=20
 #define ipipe_mm_switch_protect(flags)		do { (void)(flags); } while(0)
 #define ipipe_mm_switch_unprotect(flags)	do { (void)(flags); } while(0)
-#define	ipipe_pre_cascade_noeoi(desc)		do { } while (0)
-#define	ipipe_post_cascade_noeoi(desc)		do { } while (0)
-#define	ipipe_pre_cascade_eoi(desc)		do { } while (0)
-
-static inline void ipipe_post_cascade_eoi(struct irq_desc *desc)
-{
-	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	chip->irq_eoi(&desc->irq_data);
-}
=20
 #define __ipipe_serial_debug(fmt, args...)	do { } while (0)
=20
diff --git a/arch/powerpc/include/asm/qe_ic.h b/arch/powerpc/include/asm/qe=
_ic.h
index 9f6a441..b58da12 100644
--- a/arch/powerpc/include/asm/qe_ic.h
+++ b/arch/powerpc/include/asm/qe_ic.h
@@ -91,12 +91,8 @@ static inline void qe_ic_cascade_low_ipic(unsigned int i=
rq,
 	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq =3D qe_ic_get_low_irq(qe_ic);
=20
-	ipipe_pre_cascade_noeoi(desc);
-
 	if (cascade_irq !=3D NO_IRQ)
 		qe_ic_cascade_irq(qe_ic, cascade_irq);
-
-	ipipe_post_cascade_noeoi(desc);
 }
=20
 static inline void qe_ic_cascade_high_ipic(unsigned int irq,
@@ -105,12 +101,8 @@ static inline void qe_ic_cascade_high_ipic(unsigned in=
t irq,
 	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq =3D qe_ic_get_high_irq(qe_ic);
=20
-	ipipe_pre_cascade_noeoi(desc);
-
 	if (cascade_irq !=3D NO_IRQ)
 		qe_ic_cascade_irq(qe_ic, cascade_irq);
-
-	ipipe_post_cascade_noeoi(desc);
 }
=20
 static inline void qe_ic_cascade_low_mpic(unsigned int irq,
@@ -119,12 +111,12 @@ static inline void qe_ic_cascade_low_mpic(unsigned in=
t irq,
 	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq =3D qe_ic_get_low_irq(qe_ic);
=20
-	ipipe_pre_cascade_eoi(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
=20
 	if (cascade_irq !=3D NO_IRQ)
 		qe_ic_cascade_irq(qe_ic, cascade_irq);
=20
-	ipipe_post_cascade_eoi(desc);
+	chip->irq_eoi(&desc->irq_data);
 }
=20
 static inline void qe_ic_cascade_high_mpic(unsigned int irq,
@@ -133,12 +125,12 @@ static inline void qe_ic_cascade_high_mpic(unsigned i=
nt irq,
 	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq =3D qe_ic_get_high_irq(qe_ic);
=20
-	ipipe_pre_cascade_eoi(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
=20
 	if (cascade_irq !=3D NO_IRQ)
 		qe_ic_cascade_irq(qe_ic, cascade_irq);
=20
-	ipipe_post_cascade_eoi(desc);
+	chip->irq_eoi(&desc->irq_data);
 }
=20
 static inline void qe_ic_cascade_muxed_mpic(unsigned int irq,
@@ -147,7 +139,7 @@ static inline void qe_ic_cascade_muxed_mpic(unsigned in=
t irq,
 	struct qe_ic *qe_ic =3D irq_desc_get_handler_data(desc);
 	unsigned int cascade_irq;
=20
-	ipipe_pre_cascade_eoi(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
=20
 	cascade_irq =3D qe_ic_get_high_irq(qe_ic);
 	if (cascade_irq =3D=3D NO_IRQ)
@@ -156,7 +148,7 @@ static inline void qe_ic_cascade_muxed_mpic(unsigned in=
t irq,
 	if (cascade_irq !=3D NO_IRQ)
 		qe_ic_cascade_irq(qe_ic, cascade_irq);
=20
-	ipipe_post_cascade_eoi(desc);
+	chip->irq_eoi(&desc->irq_data);
 }
=20
 #endif /* _ASM_POWERPC_QE_IC_H */
diff --git a/arch/powerpc/kernel/ipipe.c b/arch/powerpc/kernel/ipipe.c
index 7252c78..ee8c3ae 100644
--- a/arch/powerpc/kernel/ipipe.c
+++ b/arch/powerpc/kernel/ipipe.c
@@ -320,7 +320,7 @@ int ipipe_trigger_irq(unsigned irq)
 		return -EINVAL;
 #endif
 	local_irq_save_hw(flags);
-	__ipipe_handle_irq(irq, NULL);
+	__ipipe_handle_irq(irq, IPIPE_IRQF_NOACK);
 	local_irq_restore_hw(flags);
=20
 	return 1;
@@ -331,14 +331,14 @@ int ipipe_trigger_irq(unsigned irq)
  * interrupt protection log is maintained here for each domain. Hw
  * interrupts are off on entry.
  */
-void __ipipe_handle_irq(int irq, struct pt_regs *regs)
+void __ipipe_handle_irq(int irq, int flags)
 {
 	struct ipipe_domain *this_domain, *next_domain;
 	struct list_head *head, *pos;
 	int m_ack;
=20
 	/* Software-triggered IRQs do not need any ack. */
-	m_ack =3D (regs =3D=3D NULL);
+	m_ack =3D (flags & IPIPE_IRQF_NOACK) !=3D 0;
=20
 #ifdef CONFIG_IPIPE_DEBUG
 	if (unlikely(irq >=3D IPIPE_NR_IRQS) ||
@@ -354,7 +354,8 @@ void __ipipe_handle_irq(int irq, struct pt_regs *regs)
 	else {
 		head =3D __ipipe_pipeline.next;
 		next_domain =3D list_entry(head, struct ipipe_domain, p_link);
-		if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control)))=
 {
+		if (!(flags & IPIPE_IRQF_NOSYNC)
+			&& likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control)))=
 {
 			if (!m_ack && next_domain->irqs[irq].acknowledge)
 				next_domain->irqs[irq].acknowledge(irq, irq_to_desc(irq));
 			__ipipe_dispatch_wired(next_domain, irq);
@@ -472,7 +473,7 @@ asmlinkage int __ipipe_grab_irq(struct pt_regs *regs)
 			__ipipe_ipi_demux(irq, regs);
 		else
 #endif /* CONFIG_SMP */
-			__ipipe_handle_irq(irq, regs);
+			__ipipe_handle_irq(irq, 0);
 	}
=20
 	ipipe_trace_irq_exit(irq);
@@ -531,7 +532,7 @@ asmlinkage int __ipipe_grab_timer(struct pt_regs *regs)
 		 */
 		__ipipe_dispatch_wired_nocheck(head, IPIPE_TIMER_VIRQ);
 	else
-		__ipipe_handle_irq(IPIPE_TIMER_VIRQ, NULL);
+		__ipipe_handle_irq(IPIPE_TIMER_VIRQ, IPIPE_IRQF_NOACK);
=20
 	ipipe_trace_irq_exit(IPIPE_TIMER_VIRQ);
=20
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_li=
b/qe_ic.c
index d2f82df..9449e18 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -243,11 +243,9 @@ static void qe_ic_mask_irq(struct irq_data *d)
=20
 void __ipipe_qe_ic_cascade_irq(struct qe_ic *qe_ic, unsigned int virq)
 {
-	struct pt_regs regs;    /* Contents not used. */
-
 	ipipe_trace_irq_entry(virq);
-        __ipipe_handle_irq(virq, &regs);
-        ipipe_trace_irq_exit(virq);
+	__ipipe_handle_irq(virq, IPIPE_IRQF_NOSYNC);
+	ipipe_trace_irq_exit(virq);
 }
=20
 #endif
--=20
1.8.4


