Message-ID: <b647ffbd0512291103y383a96c1i@domain.hid>
Date: Thu, 29 Dec 2005 21:03:38 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_356_5332618.1135883018608"
Subject: [Xenomai-core] [rt shared irqs] changes on the adeos-ipipe layer v.2
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_356_5332618.1135883018608
Content-Type: multipart/alternative; 
	boundary="----=_Part_357_1438914.1135883018608"

------=_Part_357_1438914.1135883018608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

the recent patches are enclosed here. Mmm I haven't ported it to the recent
adeos-ipipe && xeno though but I guess it's not a big obstacle for possible
design-related comments etc.

just to note some main issues...

o  the ipipe_virtualize_irq() interface now includes an additional param,
namely - void *cookie.

o  ipipe_domain::cpudata::irq_hits has been renamed to irq_pending_hits
while irq_hits now stands for the former rthal_realtime_irq::irq_hits.

It's incremeneted in ipipe_irq_handle() and ipipe_schedule_irq(), IOW at th=
e
places where irqs (normal or virtual) become visible on the adeos radar
first time.

Another approach would be to increment it in ipipe_sync_stage() right befor=
e
calling actual isr handlers. This way, accounting (well, it depends what ar=
e
we going to count though) would be wrong for virq and ipipe_tick_irq
handler.

er.. I was confused by the fact that sum of all apcs in /proc/xenomai/apc !=
=3D
virq from /proc/xenomai/irq, but ipipe_printk_virq is not listed since it's
registered without rthal::apc interface. Ok, should take a look at it
closer, i.e. maybe at least rthal_linux_irq can be reworked now.


--
Best regards,
Dmitry Adamushko

------=_Part_357_1438914.1135883018608
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hi everybody,<br>
<br>
the recent patches are enclosed here. Mmm I haven't ported it to the
recent adeos-ipipe &amp;&amp; xeno though but I guess it's not a big
obstacle for possible design-related comments etc.<br>
<br>
just to note some main issues...<br>
<br>
o&nbsp; the ipipe_virtualize_irq() interface now includes an additional par=
am, namely - void *cookie.<br>
<br>
o&nbsp; ipipe_domain::cpudata::irq_hits has been renamed to
irq_pending_hits while irq_hits now stands for the former
rthal_realtime_irq::irq_hits.<br>
<br>
It's incremeneted in ipipe_irq_handle() and ipipe_schedule_irq(), IOW
at the places where irqs (normal or virtual) become visible on the
adeos radar first time.<br>
<br>
Another approach would be to increment it in ipipe_sync_stage() right
before calling actual isr handlers. This way, accounting (well, it
depends what are we going to count though) would be wrong for virq and
ipipe_tick_irq handler.<br>
<br>
er.. I was confused by the fact that sum of all apcs in
/proc/xenomai/apc !=3D virq from /proc/xenomai/irq, but ipipe_printk_virq
is not listed since it's registered without rthal::apc interface. Ok,
should take a look at it closer, i.e. maybe at least rthal_linux_irq
can be reworked now.<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_357_1438914.1135883018608--

------=_Part_356_5332618.1135883018608
Content-Type: application/octet-stream; name=ipipe-i386-1.0-10-ext-2.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ipipe-i386-1.0-10-ext-2.patch"

diff -urp linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-core.c linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-core.c
--- linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-core.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-core.c	2005-12-29 18:56:40.000000000 +0100
@@ -98,13 +98,14 @@ static void (*__ipipe_cpu_sync) (void);
 	                 "pushl %%edx\n\t" \
 	                 "pushl %%ecx\n\t" \
 	                 "pushl %%ebx\n\t" \
+			 "pushl %2\n\t" \
                          "pushl %%eax\n\t" \
                          "call *%1\n\t" \
-			 "addl $4,%%esp\n\t" \
+			 "addl $8,%%esp\n\t" \
 	                 "jmp ret_from_intr\n\t" \
 	                 "1:\n" \
 			 : /* no output */ \
-			 : "a" (irq), "m" ((ipd)->irqs[irq].handler))
+			 : "a" (irq), "m" ((ipd)->irqs[irq].handler), "r" ((ipd)->irqs[irq].cookie))
 
 static __inline__ unsigned long flnz(unsigned long word)
 {
@@ -125,7 +126,7 @@ int __ipipe_ack_system_irq(unsigned irq)
 
 /* Always called with hw interrupts off. */
 
-void __ipipe_do_critical_sync(unsigned irq)
+void __ipipe_do_critical_sync(unsigned irq, void *cookie)
 {
 	ipipe_declare_cpuid;
 
@@ -275,7 +276,7 @@ void fastcall __ipipe_sync_stage(unsigne
 				continue;
 			}
 
-			if (--cpudata->irq_hits[irq] == 0) {
+			if (--cpudata->irq_pending_hits[irq] == 0) {
 				__clear_bit(rank,
 					    &cpudata->irq_pending_lo[level]);
 				ipipe_mark_irq_delivery(ipd,irq,cpuid);
@@ -301,7 +302,7 @@ void fastcall __ipipe_sync_stage(unsigne
 				local_irq_disable_hw();
 			} else {
 				__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);
-				ipd->irqs[irq].handler(irq);
+				ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
 				__set_bit(IPIPE_SYNC_FLAG, &cpudata->status);
 			}
 
@@ -415,8 +416,9 @@ int fastcall __ipipe_send_ipi (unsigned 
 
 int ipipe_virtualize_irq(struct ipipe_domain *ipd,
 			 unsigned irq,
-			 void (*handler) (unsigned irq),
-			 int (*acknowledge) (unsigned irq),
+			 ipipe_irq_handler_t handler,
+			 void *cookie,
+			 ipipe_irq_ackfn_t acknowledge,
 			 unsigned modemask)
 {
 	unsigned long flags;
@@ -434,6 +436,7 @@ int ipipe_virtualize_irq(struct ipipe_do
 
 		if (handler == IPIPE_SAME_HANDLER) {
 			handler = ipd->irqs[irq].handler;
+			cookie = ipd->irqs[irq].cookie;
 
 			if (handler == NULL) {
 				err = -EINVAL;
@@ -473,6 +476,7 @@ int ipipe_virtualize_irq(struct ipipe_do
 	}
 
 	ipd->irqs[irq].handler = handler;
+	ipd->irqs[irq].cookie = cookie;
 	ipd->irqs[irq].acknowledge = acknowledge;
 	ipd->irqs[irq].control = modemask;
 
diff -urp linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-root.c linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-root.c
--- linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-root.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-root.c	2005-12-29 18:59:12.000000000 +0100
@@ -78,7 +78,7 @@ static int __ipipe_ack_common_irq(unsign
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-static void __ipipe_null_handler(unsigned irq)
+static void __ipipe_null_handler(unsigned irq, void *cookie)
 {
 	/* Nop. */
 }
@@ -124,50 +124,58 @@ void __init __ipipe_enable_pipeline(void
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     LOCAL_TIMER_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_apic_timer_interrupt,
+			     (ipipe_irq_handler_t)&smp_apic_timer_interrupt,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     SPURIOUS_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_spurious_interrupt,
+			     (ipipe_irq_handler_t)&smp_spurious_interrupt,
+			     NULL,
 			     &__ipipe_noack_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     ERROR_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_error_interrupt,
+			     (ipipe_irq_handler_t)&smp_error_interrupt,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     IPIPE_SERVICE_VECTOR0 - FIRST_EXTERNAL_VECTOR,
 			     &__ipipe_null_handler,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     IPIPE_SERVICE_VECTOR1 - FIRST_EXTERNAL_VECTOR,
 			     &__ipipe_null_handler,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     IPIPE_SERVICE_VECTOR2 - FIRST_EXTERNAL_VECTOR,
 			     &__ipipe_null_handler,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     IPIPE_SERVICE_VECTOR3 - FIRST_EXTERNAL_VECTOR,
 			     &__ipipe_null_handler,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 #ifdef CONFIG_X86_MCE_P4THERMAL
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     THERMAL_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_thermal_interrupt,
+			     (ipipe_irq_handler_t)&smp_thermal_interrupt,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 #endif /* CONFIG_X86_MCE_P4THERMAL */
@@ -185,19 +193,22 @@ void __init __ipipe_enable_pipeline(void
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     RESCHEDULE_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_reschedule_interrupt,
+			     (ipipe_irq_handler_t)&smp_reschedule_interrupt,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     INVALIDATE_TLB_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_invalidate_interrupt,
+			     (ipipe_irq_handler_t)&smp_invalidate_interrupt,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     CALL_FUNCTION_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_call_function_interrupt,
+			     (ipipe_irq_handler_t)&smp_call_function_interrupt,
+			     NULL,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
@@ -224,7 +235,8 @@ void __init __ipipe_enable_pipeline(void
 		/* Fails for IPIPE_CRITICAL_IPI but that's ok. */
 		ipipe_virtualize_irq(ipipe_root_domain,
 				     irq,
-				     (void (*)(unsigned))&do_IRQ,
+				     (ipipe_irq_handler_t)&do_IRQ,
+				     NULL,
 				     &__ipipe_ack_common_irq,
 				     IPIPE_STDROOT_MASK);
 	}
@@ -530,6 +542,7 @@ int __ipipe_handle_irq(struct pt_regs re
 			   status flags before the PIC is unlocked. */
 
 			next_domain->cpudata[cpuid].irq_hits[irq]++;
+			next_domain->cpudata[cpuid].irq_pending_hits[irq]++;
 			__ipipe_set_irq_bit(next_domain, cpuid, irq);
 			ipipe_mark_irq_receipt(next_domain, irq, cpuid);
 
@@ -563,11 +576,11 @@ int __ipipe_handle_irq(struct pt_regs re
 		__ipipe_tick_regs[cpuid].ebp = regs.ebp;
 #endif	/* CONFIG_SMP && CONFIG_FRAME_POINTER */
 		if (__ipipe_pipeline_head_p(ipipe_root_domain) &&
-		    ipipe_root_domain->cpudata[cpuid].irq_hits[irq] > 1)
+		    ipipe_root_domain->cpudata[cpuid].irq_pending_hits[irq] > 1)
 			/* Emulate a loss of clock ticks if Linux is
 			 * owning the time source. The drift will be
 			 * compensated by the timer support code.*/
-			ipipe_root_domain->cpudata[cpuid].irq_hits[irq] = 1;
+			ipipe_root_domain->cpudata[cpuid].irq_pending_hits[irq] = 1;
 	}
 
 	/* Now walk the pipeline, yielding control to the highest
diff -urp linux-2.6.14.2-ipipe-1.0-10/include/asm-i386/ipipe.h linux-2.6.14.2-ipipe-1.0-10-ext/include/asm-i386/ipipe.h
--- linux-2.6.14.2-ipipe-1.0-10/include/asm-i386/ipipe.h	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/include/asm-i386/ipipe.h	2005-12-23 16:27:12.000000000 +0100
@@ -173,7 +173,7 @@ int __ipipe_ack_system_irq(unsigned irq)
 
 int __ipipe_handle_irq(struct pt_regs regs);
 
-void __ipipe_do_critical_sync(unsigned irq);
+void __ipipe_do_critical_sync(unsigned irq, void *cookie);
 
 extern struct pt_regs __ipipe_tick_regs[];
 
diff -urp linux-2.6.14.2-ipipe-1.0-10/include/linux/ipipe.h linux-2.6.14.2-ipipe-1.0-10-ext/include/linux/ipipe.h
--- linux-2.6.14.2-ipipe-1.0-10/include/linux/ipipe.h	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/include/linux/ipipe.h	2005-12-29 18:51:40.000000000 +0100
@@ -39,7 +39,6 @@
 
 #define IPIPE_RESET_TIMER	0x1
 #define IPIPE_GRAB_TIMER	0x2
-#define IPIPE_SAME_HANDLER	((void (*)(unsigned))(-1))
 
 /* Global domain flags */
 #define IPIPE_SPRINTK_FLAG	0	/* Synchronous printk() allowed */
@@ -116,6 +115,13 @@
 #define ipipe_virtual_irq_p(irq)	((irq) >= IPIPE_VIRQ_BASE && \
 					 (irq) < IPIPE_NR_IRQS)
 
+typedef void (*ipipe_irq_handler_t)(unsigned irq,
+				    void *cookie);
+
+typedef int (*ipipe_irq_ackfn_t)(unsigned irq);
+
+#define IPIPE_SAME_HANDLER	((ipipe_irq_handler_t)(-1))
+
 struct ipipe_domain {
 
 	struct list_head p_link;	/* Link in pipeline */
@@ -124,14 +130,16 @@ struct ipipe_domain {
 		unsigned long status;
 		unsigned long irq_pending_hi;
 		unsigned long irq_pending_lo[IPIPE_IRQ_IWORDS];
+		unsigned long irq_pending_hits[IPIPE_NR_IRQS];
 		unsigned long irq_hits[IPIPE_NR_IRQS];
-	} cpudata[IPIPE_NR_CPUS];
+	} ____cacheline_aligned_in_smp cpudata[IPIPE_NR_CPUS];
 
 	struct {
-		int (*acknowledge) (unsigned irq);
-		void (*handler) (unsigned irq);
 		unsigned long control;
-	} irqs[IPIPE_NR_IRQS];
+		ipipe_irq_ackfn_t acknowledge;
+		ipipe_irq_handler_t handler;
+		void *cookie;
+	} ____cacheline_aligned irqs[IPIPE_NR_IRQS];
 
 	int (*evhand[IPIPE_NR_EVENTS])(unsigned event,
 				       struct ipipe_domain *from,
@@ -148,7 +156,7 @@ struct ipipe_domain {
 			unsigned long long last_receipt_date;
 			unsigned long max_delivery_time;
 		} irq_stats[IPIPE_NR_IRQS];
-	} stats[IPIPE_NR_CPUS];
+	} ____cacheline_aligned_in_smp stats[IPIPE_NR_CPUS];
 #endif /* CONFIG_IPIPE_STATS */
 	unsigned long flags;
 	unsigned domid;
@@ -168,6 +176,11 @@ struct ipipe_domain_attr {
 
 /* The following macros must be used hw interrupts off. */
 
+#define __ipipe_irq_cookie(ipd,irq)	(ipd)->irqs[irq].cookie
+#define __ipipe_irq_handler(ipd,irq)	(ipd)->irqs[irq].handler
+
+#define __ipipe_cpudata_irq_hits(ipd,cpuid,irq)	(ipd)->cpudata[cpuid].irq_hits[irq]
+
 #define __ipipe_set_irq_bit(ipd,cpuid,irq) \
 do { \
 	if (!test_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) { \
@@ -194,7 +207,7 @@ do { \
 	int __cpuid, __nr_cpus = num_online_cpus(); \
 	if (test_and_clear_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) \
 		for (__cpuid = 0; __cpuid < __nr_cpus; __cpuid++) \
-			if ((ipd)->cpudata[__cpuid].irq_hits[irq] > 0) { /* We need atomic ops next. */ \
+			if ((ipd)->cpudata[__cpuid].irq_pending_hits[irq] > 0) { /* We need atomic ops next. */ \
 				set_bit(irq & IPIPE_IRQ_IMASK,&(ipd)->cpudata[__cpuid].irq_pending_lo[irq >> IPIPE_IRQ_ISHIFT]); \
 				set_bit(irq >> IPIPE_IRQ_ISHIFT,&(ipd)->cpudata[__cpuid].irq_pending_hi); \
 			} \
@@ -205,7 +218,7 @@ do { \
 	int __cpuid, __nr_cpus = num_online_cpus(); \
 	clear_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control); \
 	for (__cpuid = 0; __cpuid < __nr_cpus; __cpuid++) { \
-		(ipd)->cpudata[__cpuid].irq_hits[irq] = 0; \
+		(ipd)->cpudata[__cpuid].irq_pending_hits[irq] = 0; \
 		__ipipe_clear_pend(ipd,__cpuid,irq); \
 	} \
 } while(0)
@@ -313,7 +326,7 @@ void __ipipe_add_domain_proc(struct ipip
 
 void __ipipe_remove_domain_proc(struct ipipe_domain *ipd);
 
-void __ipipe_flush_printk(unsigned irq);
+void __ipipe_flush_printk(unsigned irq, void *cookie);
 
 void __ipipe_stall_root(void);
 
@@ -472,16 +485,18 @@ void ipipe_suspend_domain(void);
 
 int ipipe_virtualize_irq(struct ipipe_domain *ipd,
 			 unsigned irq,
-			 void (*handler) (unsigned irq),
-			 int (*acknowledge) (unsigned irq),
+			 ipipe_irq_handler_t handler,
+			 void *cookie,
+			 ipipe_irq_ackfn_t acknowledge,
 			 unsigned modemask);
 
 static inline int ipipe_share_irq(unsigned irq,
-				  int (*acknowledge) (unsigned irq))
+				  ipipe_irq_ackfn_t acknowledge)
 {
 	return ipipe_virtualize_irq(ipipe_current_domain,
 				    irq,
 				    IPIPE_SAME_HANDLER,
+				    NULL,
 				    acknowledge,
 				    IPIPE_SHARED_MASK | IPIPE_HANDLE_MASK |
 				    IPIPE_PASS_MASK);
diff -urp linux-2.6.14.2-ipipe-1.0-10/kernel/ipipe/core.c linux-2.6.14.2-ipipe-1.0-10-ext/kernel/ipipe/core.c
--- linux-2.6.14.2-ipipe-1.0-10/kernel/ipipe/core.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/kernel/ipipe/core.c	2005-12-29 12:59:35.000000000 +0100
@@ -78,6 +78,7 @@ void ipipe_init(void)
 
 	__ipipe_printk_virq = ipipe_alloc_virq();	/* Cannot fail here. */
 	ipd->irqs[__ipipe_printk_virq].handler = &__ipipe_flush_printk;
+	ipd->irqs[__ipipe_printk_virq].cookie = NULL;
 	ipd->irqs[__ipipe_printk_virq].acknowledge = NULL;
 	ipd->irqs[__ipipe_printk_virq].control = IPIPE_HANDLE_MASK;
 
@@ -97,8 +98,10 @@ void __ipipe_init_stage(struct ipipe_dom
 		for (n = 0; n < IPIPE_IRQ_IWORDS; n++)
 			ipd->cpudata[cpuid].irq_pending_lo[n] = 0;
 
-		for (n = 0; n < IPIPE_NR_IRQS; n++)
+		for (n = 0; n < IPIPE_NR_IRQS; n++) {
+			ipd->cpudata[cpuid].irq_pending_hits[n] = 0;
 			ipd->cpudata[cpuid].irq_hits[n] = 0;
+		}
 	}
 
 	for (n = 0; n < IPIPE_NR_IRQS; n++) {
@@ -115,6 +118,7 @@ void __ipipe_init_stage(struct ipipe_dom
 #ifdef CONFIG_SMP
 	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge = &__ipipe_ack_system_irq;
 	ipd->irqs[IPIPE_CRITICAL_IPI].handler = &__ipipe_do_critical_sync;
+	ipd->irqs[IPIPE_CRITICAL_IPI].cookie = NULL;
 	/* Immediately handle in the current domain but *never* pass */
 	ipd->irqs[IPIPE_CRITICAL_IPI].control =
 		IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK;
diff -urp linux-2.6.14.2-ipipe-1.0-10/kernel/ipipe/generic.c linux-2.6.14.2-ipipe-1.0-10-ext/kernel/ipipe/generic.c
--- linux-2.6.14.2-ipipe-1.0-10/kernel/ipipe/generic.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/kernel/ipipe/generic.c	2005-12-29 17:44:35.000000000 +0100
@@ -175,7 +175,7 @@ int ipipe_unregister_domain(struct ipipe
 
 		for (_cpuid = 0; _cpuid < nr_cpus; _cpuid++)
 			for (irq = 0; irq < IPIPE_NR_IRQS; irq++)
-				while (ipd->cpudata[_cpuid].irq_hits[irq] > 0)
+				while (ipd->cpudata[_cpuid].irq_pending_hits[irq] > 0)
 					cpu_relax();
 	}
 #endif	/* CONFIG_SMP */
@@ -226,6 +226,7 @@ int fastcall __ipipe_schedule_irq(unsign
 
 		if (test_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control)) {
 			ipd->cpudata[cpuid].irq_hits[irq]++;
+			ipd->cpudata[cpuid].irq_pending_hits[irq]++;
 			__ipipe_set_irq_bit(ipd, cpuid, irq);
 			ipipe_mark_irq_receipt(ipd, irq, cpuid);
 			ipipe_unlock_cpu(flags);
diff -urp linux-2.6.14.2-ipipe-1.0-10/kernel/printk.c linux-2.6.14.2-ipipe-1.0-10-ext/kernel/printk.c
--- linux-2.6.14.2-ipipe-1.0-10/kernel/printk.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/kernel/printk.c	2005-12-23 16:30:57.000000000 +0100
@@ -515,7 +515,7 @@ static int __ipipe_printk_fill;
 
 static char __ipipe_printk_buf[__LOG_BUF_LEN];
 
-void __ipipe_flush_printk (unsigned virq)
+void __ipipe_flush_printk (unsigned virq, void *cookie)
 {
 	char *p = __ipipe_printk_buf;
 	int out = 0, len;





------=_Part_356_5332618.1135883018608
Content-Type: application/octet-stream; name=xenomai-2.1-i386-ext-2.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xenomai-2.1-i386-ext-2.patch"

diff -urp xenomai-2.1-clean/include/asm-generic/hal.h xenomai-2.1-ext/include/asm-generic/hal.h
--- xenomai-2.1-clean/include/asm-generic/hal.h	2005-11-21 21:52:35.000000000 +0100
+++ xenomai-2.1-ext/include/asm-generic/hal.h	2005-12-29 19:33:41.000000000 +0100
@@ -86,6 +86,11 @@ typedef rwlock_t rthal_rwlock_t;
 #endif /* RAW_RW_LOCK_UNLOCKED */
 #endif /* IPIPE_RW_LOCK_UNLOCKED */
 
+#define rthal_irq_cookie(ipd,irq)	__ipipe_irq_cookie(ipd,irq)
+#define rthal_irq_handler(ipd,irq)	__ipipe_irq_handler(ipd,irq)
+
+#define rthal_cpudata_irq_hits(ipd,cpu,irq)	__ipipe_cpudata_irq_hits(ipd,cpu,irq)
+
 #define rthal_local_irq_disable()	ipipe_stall_pipeline_from(&rthal_domain)
 #define rthal_local_irq_enable()	ipipe_unstall_pipeline_from(&rthal_domain)
 #define rthal_local_irq_save(x)		((x) = !!ipipe_test_and_stall_pipeline_from(&rthal_domain))
@@ -118,7 +123,7 @@ typedef rwlock_t rthal_rwlock_t;
 #define rthal_propagate_irq(irq)		ipipe_propagate_irq(irq)
 #define rthal_set_irq_affinity(irq,aff)		ipipe_set_irq_affinity(irq,aff)
 #define rthal_schedule_irq(irq)			ipipe_schedule_irq(irq)
-#define rthal_virtualize_irq(dom,irq,isr,ackfn,mode) ipipe_virtualize_irq(dom,irq,isr,ackfn,mode)
+#define rthal_virtualize_irq(dom,irq,isr,cookie,ackfn,mode) ipipe_virtualize_irq(dom,irq,isr,cookie,ackfn,mode)
 #define rthal_alloc_virq()			ipipe_alloc_virq()
 #define rthal_free_virq(irq)			ipipe_free_virq(irq)
 #define rthal_trigger_irq(irq)			ipipe_trigger_irq(irq)
@@ -447,8 +452,8 @@ do {  \
 
 #define rthal_printk	printk
 
-typedef void (*rthal_irq_handler_t)(unsigned irq,
-				    void *cookie);
+typedef ipipe_irq_handler_t rthal_irq_handler_t;
+typedef ipipe_irq_ackfn_t   rthal_irq_ackfn_t;
 
 struct rthal_calibration_data {
 
@@ -497,8 +502,8 @@ int rthal_init(void);
 void rthal_exit(void);
 
 int rthal_irq_request(unsigned irq,
-		      void (*handler)(unsigned irq, void *cookie),
-		      int (*ackfn)(unsigned irq),
+		      rthal_irq_handler_t handler,
+		      rthal_irq_ackfn_t ackfn,
 		      void *cookie);
 
 int rthal_irq_release(unsigned irq);
diff -urp xenomai-2.1-clean/include/asm-generic/system.h xenomai-2.1-ext/include/asm-generic/system.h
--- xenomai-2.1-clean/include/asm-generic/system.h	2005-11-21 21:52:35.000000000 +0100
+++ xenomai-2.1-ext/include/asm-generic/system.h	2005-12-29 19:34:32.000000000 +0100
@@ -349,7 +349,8 @@ static inline int xnarch_hook_ipi (void 
 {
     return rthal_virtualize_irq(&rthal_domain,
 				RTHAL_SERVICE_IPI0,
-				(void (*)(unsigned)) handler,
+				(rthal_irq_handler_t) handler,
+				NULL,
 				NULL,
 				IPIPE_HANDLE_MASK);
 }
@@ -361,6 +362,7 @@ static inline int xnarch_release_ipi (vo
 				RTHAL_SERVICE_IPI0,
 				NULL,
 				NULL,
+				NULL,
 				IPIPE_PASS_MASK);
 }
 
@@ -387,7 +389,8 @@ static inline void xnarch_notify_halt(vo
 
     rthal_virtualize_irq(rthal_current_domain,
 			 RTHAL_SERVICE_IPI2,
-			 xnarch_finalize_cpu,
+			 (rthal_irq_handler_t)xnarch_finalize_cpu,
+			 NULL,
 			 NULL,
 			 IPIPE_HANDLE_MASK);
 
@@ -403,6 +406,7 @@ static inline void xnarch_notify_halt(vo
 			 RTHAL_SERVICE_IPI2,
 			 NULL,
 			 NULL,
+			 NULL,
 			 IPIPE_PASS_MASK);
 
     rthal_release_control();
@@ -481,9 +485,8 @@ static inline unsigned long long xnarch_
 #ifdef XENO_INTR_MODULE
 
 static inline int xnarch_hook_irq (unsigned irq,
-				   void (*handler)(unsigned irq,
-						   void *cookie),
-				   int (*ackfn)(unsigned irq),
+				   rthal_irq_handler_t handler,
+				   rthal_irq_ackfn_t ackfn,
 				   void *cookie)
 {
     return rthal_irq_request(irq,handler,ackfn,cookie);
diff -urp xenomai-2.1-clean/include/asm-i386/system.h xenomai-2.1-ext/include/asm-i386/system.h
--- xenomai-2.1-clean/include/asm-i386/system.h	2005-11-21 21:52:39.000000000 +0100
+++ xenomai-2.1-ext/include/asm-i386/system.h	2005-12-29 19:04:07.000000000 +0100
@@ -542,7 +542,7 @@ static inline void xnarch_init_shadow_tc
     tcb->fpup = &task->thread.i387;
 }
 
-static inline void xnarch_grab_xirqs (void (*handler)(unsigned irq))
+static inline void xnarch_grab_xirqs (rthal_irq_handler_t handler)
 
 {
     unsigned irq;
@@ -551,6 +551,7 @@ static inline void xnarch_grab_xirqs (vo
         rthal_virtualize_irq(rthal_current_domain,
 			     irq,
                              handler,
+			     NULL,
                              NULL,
                              IPIPE_DYNAMIC_MASK);
 }
@@ -726,7 +727,8 @@ static inline int xnarch_init (void)
 
     rthal_virtualize_irq(&rthal_domain,
 			 xnarch_escalation_virq,
-			 (void (*)(unsigned))&xnpod_schedule_handler,
+			 (rthal_irq_handler_t)&xnpod_schedule_handler,
+			 NULL,
 			 NULL,
 			 IPIPE_HANDLE_MASK);
 
diff -urp xenomai-2.1-clean/include/rtdm/rtdm_driver.h xenomai-2.1-ext/include/rtdm/rtdm_driver.h
--- xenomai-2.1-clean/include/rtdm/rtdm_driver.h	2005-11-21 21:52:39.000000000 +0100
+++ xenomai-2.1-ext/include/rtdm/rtdm_driver.h	2005-12-29 19:05:28.000000000 +0100
@@ -793,7 +793,7 @@ static inline int rtdm_nrtsig_init(rtdm_
     if (*nrt_sig == 0)
         return -EAGAIN;
 
-    rthal_virtualize_irq(rthal_root_domain, *nrt_sig, handler, NULL,
+    rthal_virtualize_irq(rthal_root_domain, *nrt_sig, (rthal_irq_handler_t)handler, NULL, NULL,
                          IPIPE_HANDLE_MASK);
     return 0;
 }
diff -urp xenomai-2.1-clean/ksrc/arch/generic/hal.c xenomai-2.1-ext/ksrc/arch/generic/hal.c
--- xenomai-2.1-clean/ksrc/arch/generic/hal.c	2005-11-21 21:53:09.000000000 +0100
+++ xenomai-2.1-ext/ksrc/arch/generic/hal.c	2005-12-29 19:47:03.000000000 +0100
@@ -57,14 +57,6 @@ module_param_named(timerfreq,rthal_timer
 
 static struct {
 
-    void (*handler)(unsigned irq, void *cookie);
-    void *cookie;
-    unsigned long hits[RTHAL_NR_CPUS];
-
-} rthal_realtime_irq[IPIPE_NR_IRQS];
-
-static struct {
-
     unsigned long flags;
     int count;
 
@@ -123,13 +115,6 @@ void rthal_critical_exit (unsigned long 
     rthal_release_superlock(flags);
 }
 
-static void rthal_irq_trampoline (unsigned irq)
-
-{
-    rthal_realtime_irq[irq].hits[rthal_processor_id()]++;
-    rthal_realtime_irq[irq].handler(irq,rthal_realtime_irq[irq].cookie);
-}
-
 /**
  * @fn int rthal_irq_request(unsigned irq, void (*handler)(unsigned irq, void *cookie), int (*ackfn)(unsigned irq), void *cookie)
  *
@@ -179,8 +164,8 @@ static void rthal_irq_trampoline (unsign
  */
 
 int rthal_irq_request (unsigned irq,
-		       void (*handler)(unsigned irq, void *cookie),
-		       int (*ackfn)(unsigned irq),
+		       rthal_irq_handler_t handler,
+		       rthal_irq_ackfn_t ackfn,
 		       void *cookie)
 {
     unsigned long flags;
@@ -191,7 +176,7 @@ int rthal_irq_request (unsigned irq,
 
     flags = rthal_critical_enter(NULL);
 
-    if (rthal_realtime_irq[irq].handler != NULL)
+    if (rthal_irq_handler(&rthal_domain, irq) != NULL)
 	{
 	err = -EBUSY;
 	goto unlock_and_exit;
@@ -199,14 +184,10 @@ int rthal_irq_request (unsigned irq,
 
     err = rthal_virtualize_irq(&rthal_domain,
 			       irq,
-			       &rthal_irq_trampoline,
+			       handler,
+			       cookie,
 			       ackfn,
 			       IPIPE_DYNAMIC_MASK);
-    if (!err)
-	{
-	rthal_realtime_irq[irq].handler = handler;
-	rthal_realtime_irq[irq].cookie = cookie;
-	}
 
  unlock_and_exit:
 
@@ -253,9 +234,8 @@ int rthal_irq_release (unsigned irq)
 			       irq,
 			       NULL,
 			       NULL,
+			       NULL,
 			       IPIPE_PASS_MASK);
-    if (!err)
-        xchg(&rthal_realtime_irq[irq].handler,NULL);
 
     return err;
 }
@@ -580,8 +560,7 @@ rthal_trap_handler_t rthal_trap_catch (r
     return (rthal_trap_handler_t)xchg(&rthal_trap_handler,handler);
 }
 
-static void rthal_apc_handler (unsigned virq)
-
+static void rthal_apc_handler (unsigned virq, void *arg)
 {
     void (*handler)(void *), *cookie;
     rthal_declare_cpuid;
@@ -650,7 +629,7 @@ static int rthal_apc_thread (void *data)
     return 0;
 }
 
-void rthal_apc_kicker (unsigned virq)
+void rthal_apc_kicker (unsigned virq, void *cookie)
 
 {
     wake_up_process(rthal_apc_servers[smp_processor_id()]);
@@ -877,13 +856,13 @@ static int irq_read_proc (char *page,
 
     for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
 
-	if (rthal_realtime_irq[irq].handler == NULL)
+	if (rthal_irq_handler(&rthal_domain, irq) == NULL)
 	    continue;
 
 	p += sprintf(p,"\n%3d:",irq);
 
 	for_each_online_cpu(cpu) {
-	    p += sprintf(p,"%12lu",rthal_realtime_irq[irq].hits[cpu]);
+	    p += sprintf(p,"%12lu",rthal_cpudata_irq_hits(&rthal_domain,cpu,irq));
 	}
     }
 
@@ -1092,7 +1071,9 @@ int rthal_init (void)
 			       rthal_apc_virq,
 			       &rthal_apc_trampoline,
 			       NULL,
+			       NULL,
 			       IPIPE_HANDLE_MASK);
+
     if (err)
     {
         printk(KERN_ERR "Xenomai: Failed to virtualize IRQ.\n");
@@ -1145,7 +1126,7 @@ out_kthread_stop:
       }
     }
 #endif /* CONFIG_PREEMPT_RT */
-    rthal_virtualize_irq(rthal_current_domain,rthal_apc_virq,NULL,NULL,0);
+    rthal_virtualize_irq(rthal_current_domain,rthal_apc_virq,NULL,NULL,NULL,0);
    
 out_free_irq:
     rthal_free_virq(rthal_apc_virq);
@@ -1172,7 +1153,7 @@ void rthal_exit (void)
 
     if (rthal_apc_virq)
 	{
-	rthal_virtualize_irq(rthal_current_domain,rthal_apc_virq,NULL,NULL,0);
+	rthal_virtualize_irq(rthal_current_domain,rthal_apc_virq,NULL,NULL,NULL,0);
 	rthal_free_virq(rthal_apc_virq);
 #ifdef CONFIG_PREEMPT_RT
 	{
diff -urp xenomai-2.1-clean/ksrc/skins/rtai/intr.c xenomai-2.1-ext/ksrc/skins/rtai/intr.c
--- xenomai-2.1-clean/ksrc/skins/rtai/intr.c	2005-11-21 21:52:58.000000000 +0100
+++ xenomai-2.1-ext/ksrc/skins/rtai/intr.c	2005-12-22 13:38:34.000000000 +0100
@@ -24,7 +24,7 @@ int rt_request_irq (unsigned irq,
 		    void (*handler)(unsigned irq, void *cookie),
 		    void *cookie)
 {
-    return rthal_irq_request(irq,handler,NULL,cookie);
+    return xnarch_hook_irq(irq,handler,NULL,cookie);
 }
 
 int rt_release_irq (unsigned irq)
diff -urp xenomai-2.1-clean/sim/include/asm-mvm/system.h xenomai-2.1-ext/sim/include/asm-mvm/system.h
--- xenomai-2.1-clean/sim/include/asm-mvm/system.h	2005-11-21 21:52:48.000000000 +0100
+++ xenomai-2.1-ext/sim/include/asm-mvm/system.h	2005-12-29 19:36:57.000000000 +0100
@@ -365,9 +365,8 @@ void mvm_tcl_build_pendq(mvm_tcl_listobj
 #ifdef XENO_INTR_MODULE
 
 static inline int xnarch_hook_irq (unsigned irq,
-				   void (*handler)(unsigned irq,
-						   void *cookie),
-				   int (*ackfn)(unsigned irq), /* Ignored. */
+				   rthal_irq_handler_t handler,
+				   rthal_irq_ackfn_t ackfn, /* Ignored. */
 				   void *cookie)
 {
     return mvm_hook_irq(irq,handler,cookie);
diff -urp xenomai-2.1-clean/src/include/asm-uvm/system.h xenomai-2.1-ext/src/include/asm-uvm/system.h
--- xenomai-2.1-clean/src/include/asm-uvm/system.h	2005-11-21 21:52:41.000000000 +0100
+++ xenomai-2.1-ext/src/include/asm-uvm/system.h	2005-12-29 19:36:34.000000000 +0100
@@ -272,9 +272,8 @@ void xnarch_sync_irq (void) /* Synchroni
 }
 
 static inline int xnarch_hook_irq (unsigned irq,
-				   void (*handler)(unsigned irq,
-						   void *cookie),
-				   int (*ackfn)(unsigned irq),
+				   rthal_irq_handler_t handler,
+				   rthal_irq_ackfn_t ackfn,
 				   void *cookie)
 {
     return -ENOSYS;





------=_Part_356_5332618.1135883018608--

