From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1177706363.5010.158.camel@domain.hid>
References: <1177686318.5010.106.camel@domain.hid>
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>
	<1177685762.5010.104.camel@domain.hid>
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>
	<1177706363.5010.158.camel@domain.hid>
Content-Type: multipart/mixed; boundary="=-Tjue0eMXNAY1/J2mSJC4"
Date: Mon, 30 Apr 2007 17:39:56 +0200
Message-Id: <1177947596.32698.47.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid


--=-Tjue0eMXNAY1/J2mSJC4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2007-04-27 at 22:39 +0200, Philippe Gerum wrote:
> On Fri, 2007-04-27 at 17:10 +0200, M. Koehrer wrote:
> > Hi Philippe,
> > 
> > here is the next result (I have switched off the "quiet" kernel parameter to get everything).
> > 
> 
> There is a SMP-related bugfix regarding our IPI namespace I need to
> backport from x86_64 to x86. Not sure this is what bites us here yet,
> but there is no use to chase the wild goose. In any case, CONFIG_PCI_MSI
> clearly worsens the situation regarding this issue.

Here we are, please apply the first patch against a stock I-pipe 1.7-03
kernel, then the second one against a vanilla Xenomai v2.3.x tree.

What the first patch does is moving the system IRQs out of the regular
interrupt namespace wrt Adeos handling, which could solve possible
conflicts whenever CONFIG_PCI_MSI is on. The second patch makes the
Xenomai tree aware of the differentiated namespaces.

-- 
Philippe.


--=-Tjue0eMXNAY1/J2mSJC4
Content-Disposition: attachment; filename=adeos.patch
Content-Type: text/x-patch; name=adeos.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/arch/i386/kernel/ipipe.c b/arch/i386/kernel/ipipe.c
index ff45e25..c83a65f 100644
--- a/arch/i386/kernel/ipipe.c
+++ b/arch/i386/kernel/ipipe.c
@@ -207,49 +207,49 @@ void __init __ipipe_enable_pipeline(void)
 	/* Map the APIC system vectors. */
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     LOCAL_TIMER_VECTOR - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR),
 			     (ipipe_irq_handler_t)&smp_apic_timer_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     SPURIOUS_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(SPURIOUS_APIC_VECTOR),
 			     (ipipe_irq_handler_t)&smp_spurious_interrupt,
 			     NULL,
 			     &__ipipe_noack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     ERROR_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(ERROR_APIC_VECTOR),
 			     (ipipe_irq_handler_t)&smp_error_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     IPIPE_SERVICE_VECTOR0 - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR0),
 			     &__ipipe_null_handler,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     IPIPE_SERVICE_VECTOR1 - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR1),
 			     &__ipipe_null_handler,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     IPIPE_SERVICE_VECTOR2 - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR2),
 			     &__ipipe_null_handler,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     IPIPE_SERVICE_VECTOR3 - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR3),
 			     &__ipipe_null_handler,
 			     NULL,
 			     &__ipipe_ack_apic,
@@ -257,7 +257,7 @@ void __init __ipipe_enable_pipeline(void)
 
 #ifdef CONFIG_X86_MCE_P4THERMAL
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     THERMAL_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(THERMAL_APIC_VECTOR),
 			     (ipipe_irq_handler_t)&smp_thermal_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
@@ -265,7 +265,7 @@ void __init __ipipe_enable_pipeline(void)
 #endif /* CONFIG_X86_MCE_P4THERMAL */
 
 	__ipipe_tick_irq =
-	    using_apic_timer ? LOCAL_TIMER_VECTOR - FIRST_EXTERNAL_VECTOR : 0;
+		using_apic_timer ? ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR) : 0;
 
 #else	/* !CONFIG_X86_LOCAL_APIC */
 
@@ -275,21 +275,21 @@ void __init __ipipe_enable_pipeline(void)
 
 #ifdef CONFIG_SMP
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     RESCHEDULE_VECTOR - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(RESCHEDULE_VECTOR),
 			     (ipipe_irq_handler_t)&smp_reschedule_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     INVALIDATE_TLB_VECTOR - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(INVALIDATE_TLB_VECTOR),
 			     (ipipe_irq_handler_t)&smp_invalidate_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     CALL_FUNCTION_VECTOR - FIRST_EXTERNAL_VECTOR,
+			     ipipe_apic_vector_irq(CALL_FUNCTION_VECTOR),
 			     (ipipe_irq_handler_t)&smp_call_function_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
@@ -772,10 +772,17 @@ int __ipipe_handle_irq(struct pt_regs regs)
 	ipipe_declare_cpuid;
 	int m_ack;
 
-	if (regs.orig_eax < 0) {
+	if ((long)regs.orig_eax < 0) {
 		irq = ~irq;
+#ifdef CONFIG_X86_LOCAL_APIC
+		{
+			unsigned vector = irq + FIRST_EXTERNAL_VECTOR;
+			if (vector >= FIRST_SYSTEM_VECTOR)
+				irq = ipipe_apic_vector_irq(vector);
+		}
+#endif
 		m_ack = 0;
-	} else
+	} else /* This is a self-triggered interrupt. */
 		m_ack = 1;
 
 	ipipe_load_cpuid();
@@ -881,7 +888,7 @@ finalize_nosync:
 	 * preemptible kernels along the way out through
 	 * ret_from_intr.
 	 */
-	if (regs.orig_eax < 0)
+	if ((long)regs.orig_eax < 0)
 		__set_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
 #endif	/* CONFIG_SMP */
 
diff --git a/include/asm-i386/ipipe.h b/include/asm-i386/ipipe.h
index 43efd34..8a501a9 100644
--- a/include/asm-i386/ipipe.h
+++ b/include/asm-i386/ipipe.h
@@ -27,28 +27,35 @@
 #include <linux/threads.h>
 #include <irq_vectors.h>
 
-#define IPIPE_ARCH_STRING	"1.7-03"
+#define IPIPE_ARCH_STRING	"1.8-devel"
 #define IPIPE_MAJOR_NUMBER	1
-#define IPIPE_MINOR_NUMBER	7
-#define IPIPE_PATCH_NUMBER	3
+#define IPIPE_MINOR_NUMBER	7
+#define IPIPE_PATCH_NUMBER	99
 
 #ifdef CONFIG_X86_LOCAL_APIC
-/* We want to cover the whole IRQ space when the APIC is enabled. */
-#ifdef CONFIG_PCI_MSI
-#define IPIPE_NR_XIRQS NR_IRQS
-#else	/* CONFIG_PCI_MSI */
-#define IPIPE_NR_XIRQS   224
-#endif	/* CONFIG_PCI_MSI */
+/* We want to cover the whole IRQ space when the APIC is enabled.
+   Reserve 32 IRQs for APIC interrupts, we don't want them to mess
+   with the normally assigned interrupts.*/
+#if (NR_IRQS > 16)
+#define IPIPE_NR_XIRQS		(NR_IRQS + 32)
+#define IPIPE_FIRST_APIC_IRQ	NR_IRQS
+#else
+#define IPIPE_NR_XIRQS		256
+#define IPIPE_FIRST_APIC_IRQ	224
+#endif
+#define ipipe_apic_irq_vector(irq)  ((irq) - IPIPE_FIRST_APIC_IRQ + FIRST_SYSTEM_VECTOR)
+#define ipipe_apic_vector_irq(vec)  ((vec) - FIRST_SYSTEM_VECTOR + IPIPE_FIRST_APIC_IRQ)
+
 /* If the APIC is enabled, then we expose four service vectors in the
    APIC space which are freely available to domains. */
 #define IPIPE_SERVICE_VECTOR0	0xf5
-#define IPIPE_SERVICE_IPI0	(IPIPE_SERVICE_VECTOR0 - FIRST_EXTERNAL_VECTOR)
+#define IPIPE_SERVICE_IPI0	ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR0)
 #define IPIPE_SERVICE_VECTOR1	0xf6
-#define IPIPE_SERVICE_IPI1	(IPIPE_SERVICE_VECTOR1 - FIRST_EXTERNAL_VECTOR)
+#define IPIPE_SERVICE_IPI1	ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR1)
 #define IPIPE_SERVICE_VECTOR2	0xf7
-#define IPIPE_SERVICE_IPI2	(IPIPE_SERVICE_VECTOR2 - FIRST_EXTERNAL_VECTOR)
+#define IPIPE_SERVICE_IPI2	ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR2)
 #define IPIPE_SERVICE_VECTOR3	0xf8
-#define IPIPE_SERVICE_IPI3	(IPIPE_SERVICE_VECTOR3 - FIRST_EXTERNAL_VECTOR)
+#define IPIPE_SERVICE_IPI3	ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR3)
 #else	/* !CONFIG_X86_LOCAL_APIC */
 #define IPIPE_NR_XIRQS		NR_IRQS
 #endif	/* CONFIG_X86_LOCAL_APIC */
@@ -93,7 +100,7 @@
 #include <linux/thread_info.h>
 
 #define IPIPE_CRITICAL_VECTOR  0xf9	/* Used by ipipe_critical_enter/exit() */
-#define IPIPE_CRITICAL_IPI     (IPIPE_CRITICAL_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define IPIPE_CRITICAL_IPI     ipipe_apic_vector_irq(IPIPE_CRITICAL_VECTOR)
 
 extern int (*__ipipe_logical_cpuid)(void);
 

--=-Tjue0eMXNAY1/J2mSJC4
Content-Disposition: attachment; filename=xeno.patch
Content-Type: text/x-patch; name=xeno.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: include/asm-i386/bits/shadow.h
===================================================================
--- include/asm-i386/bits/shadow.h	(revision 2395)
+++ include/asm-i386/bits/shadow.h	(working copy)
@@ -56,9 +56,9 @@
 		switch (irq) {
 #ifdef CONFIG_SMP
 		case RTHAL_CRITICAL_IPI:
-		case INVALIDATE_TLB_VECTOR - FIRST_EXTERNAL_VECTOR:
-		case CALL_FUNCTION_VECTOR - FIRST_EXTERNAL_VECTOR:
-		case RESCHEDULE_VECTOR - FIRST_EXTERNAL_VECTOR:
+		case ipipe_apic_vector_irq(INVALIDATE_TLB_VECTOR):
+		case ipipe_apic_vector_irq(CALL_FUNCTION_VECTOR):
+		case ipipe_apic_vector_irq(RESCHEDULE_VECTOR):
 
 			/* Never lock out these ones. */
 			continue;
@@ -79,9 +79,9 @@
 		switch (irq) {
 #ifdef CONFIG_SMP
 		case RTHAL_CRITICAL_IPI:
-		case INVALIDATE_TLB_VECTOR - FIRST_EXTERNAL_VECTOR:
-		case CALL_FUNCTION_VECTOR - FIRST_EXTERNAL_VECTOR:
-		case RESCHEDULE_VECTOR - FIRST_EXTERNAL_VECTOR:
+		case ipipe_apic_vector_irq(INVALIDATE_TLB_VECTOR):
+		case ipipe_apic_vector_irq(CALL_FUNCTION_VECTOR):
+		case ipipe_apic_vector_irq(RESCHEDULE_VECTOR):
 
 			continue;
 #endif /* CONFIG_SMP */
Index: include/asm-i386/hal.h
===================================================================
--- include/asm-i386/hal.h	(revision 2395)
+++ include/asm-i386/hal.h	(working copy)
@@ -142,6 +142,11 @@
 #define RTHAL_APIC_TIMER_IPI       RTHAL_SERVICE_IPI3
 #define RTHAL_APIC_ICOUNT          ((RTHAL_TIMER_FREQ + HZ/2)/HZ)
 #define RTHAL_TIMER_IRQ 	   RTHAL_APIC_TIMER_IPI
+#ifndef ipipe_apic_vector_irq
+/* Older I-pipe versions do not differentiate the normal IRQ space
+   from the system IRQ range, which is wrong... */
+#define ipipe_apic_vector_irq(vec) (vec - FIRST_EXTERNAL_VECTOR)
+#endif
 #else  /* !CONFIG_X86_LOCAL_APIC */
 #define RTHAL_TIMER_IRQ		   RTHAL_8254_IRQ
 #endif /* CONFIG_X86_LOCAL_APIC */
Index: ksrc/arch/i386/hal.c
===================================================================
--- ksrc/arch/i386/hal.c	(revision 2395)
+++ ksrc/arch/i386/hal.c	(working copy)
@@ -165,7 +165,7 @@
 #ifdef CONFIG_SMP
 	send_IPI_all(LOCAL_TIMER_VECTOR);
 #else
-	rthal_trigger_irq(LOCAL_TIMER_VECTOR -  FIRST_EXTERNAL_VECTOR);
+	rthal_trigger_irq(ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR));
 #endif
 	return IRQ_HANDLED;
 }

--=-Tjue0eMXNAY1/J2mSJC4--


