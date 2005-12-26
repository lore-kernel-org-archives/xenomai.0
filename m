Message-ID: <b647ffbd0512260117n7023fb93h@domain.hid>
Date: Mon, 26 Dec 2005 11:17:50 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10423_13114686.1135588670132"
Subject: [Xenomai-core] [rt shared irqs] ipipe-related changes (draft)
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

------=_Part_10423_13114686.1135588670132
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

the enclosed patches (the first version, hence it's still raw) are
supposed to build the basis needed on the ipipe layer for adding
support of real-time shared interrupts. As a side effect, the
irq_trampoline() layer has been eliminated and the irq processing
chain has become shorter.

Some points are more likely to be changed in the next iteration (e.g.
__ipipe_irq_cookie() vs. changing the ipipe_virtualize_irq()
interface).
The struct rthal_realtime_irq::hits[per-IRQ] is missed so far.

Anyway, comments are very wellcome.


--
Best regards,
Dmitry Adamushko

------=_Part_10423_13114686.1135588670132
Content-Type: text/plain; name=ipipe-1.0-10-i386-ext.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ipipe-1.0-10-i386-ext.patch"

diff -urp linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-core.c linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-core.c
--- linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-core.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-core.c	2005-12-23 16:37:32.000000000 +0100
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
 
@@ -301,7 +302,7 @@ void fastcall __ipipe_sync_stage(unsigne
 				local_irq_disable_hw();
 			} else {
 				__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);
-				ipd->irqs[irq].handler(irq);
+				ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);
 				__set_bit(IPIPE_SYNC_FLAG, &cpudata->status);
 			}
 
@@ -415,7 +416,7 @@ int fastcall __ipipe_send_ipi (unsigned 
 
 int ipipe_virtualize_irq(struct ipipe_domain *ipd,
 			 unsigned irq,
-			 void (*handler) (unsigned irq),
+			 ipipe_irq_handler_t handler,
 			 int (*acknowledge) (unsigned irq),
 			 unsigned modemask)
 {
diff -urp linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-root.c linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-root.c
--- linux-2.6.14.2-ipipe-1.0-10/arch/i386/kernel/ipipe-root.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/arch/i386/kernel/ipipe-root.c	2005-12-23 16:57:25.000000000 +0100
@@ -78,7 +78,7 @@ static int __ipipe_ack_common_irq(unsign
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
-static void __ipipe_null_handler(unsigned irq)
+static void __ipipe_null_handler(unsigned irq, void *cookie)
 {
 	/* Nop. */
 }
@@ -124,19 +124,19 @@ void __init __ipipe_enable_pipeline(void
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     LOCAL_TIMER_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_apic_timer_interrupt,
+			     (ipipe_irq_handler_t)&smp_apic_timer_interrupt,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     SPURIOUS_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_spurious_interrupt,
+			     (ipipe_irq_handler_t)&smp_spurious_interrupt,
 			     &__ipipe_noack_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     ERROR_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_error_interrupt,
+			     (ipipe_irq_handler_t)&smp_error_interrupt,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
@@ -167,7 +167,7 @@ void __init __ipipe_enable_pipeline(void
 #ifdef CONFIG_X86_MCE_P4THERMAL
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     THERMAL_APIC_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_thermal_interrupt,
+			     (ipipe_irq_handler_t)&smp_thermal_interrupt,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 #endif /* CONFIG_X86_MCE_P4THERMAL */
@@ -185,19 +185,19 @@ void __init __ipipe_enable_pipeline(void
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     RESCHEDULE_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_reschedule_interrupt,
+			     (ipipe_irq_handler_t)&smp_reschedule_interrupt,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     INVALIDATE_TLB_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_invalidate_interrupt,
+			     (ipipe_irq_handler_t)&smp_invalidate_interrupt,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
 			     CALL_FUNCTION_VECTOR - FIRST_EXTERNAL_VECTOR,
-			     (void (*)(unsigned))&smp_call_function_interrupt,
+			     (ipipe_irq_handler_t)&smp_call_function_interrupt,
 			     &__ipipe_ack_system_irq,
 			     IPIPE_STDROOT_MASK);
 
@@ -224,7 +224,7 @@ void __init __ipipe_enable_pipeline(void
 		/* Fails for IPIPE_CRITICAL_IPI but that's ok. */
 		ipipe_virtualize_irq(ipipe_root_domain,
 				     irq,
-				     (void (*)(unsigned))&do_IRQ,
+				     (ipipe_irq_handler_t)&do_IRQ,
 				     &__ipipe_ack_common_irq,
 				     IPIPE_STDROOT_MASK);
 	}
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
+++ linux-2.6.14.2-ipipe-1.0-10-ext/include/linux/ipipe.h	2005-12-23 16:30:28.000000000 +0100
@@ -39,7 +39,6 @@
 
 #define IPIPE_RESET_TIMER	0x1
 #define IPIPE_GRAB_TIMER	0x2
-#define IPIPE_SAME_HANDLER	((void (*)(unsigned))(-1))
 
 /* Global domain flags */
 #define IPIPE_SPRINTK_FLAG	0	/* Synchronous printk() allowed */
@@ -116,6 +115,11 @@
 #define ipipe_virtual_irq_p(irq)	((irq) >= IPIPE_VIRQ_BASE && \
 					 (irq) < IPIPE_NR_IRQS)
 
+typedef void (*ipipe_irq_handler_t)(unsigned irq,
+				    void *cookie);
+
+#define IPIPE_SAME_HANDLER	((ipipe_irq_handler_t)(-1))
+
 struct ipipe_domain {
 
 	struct list_head p_link;	/* Link in pipeline */
@@ -125,13 +129,14 @@ struct ipipe_domain {
 		unsigned long irq_pending_hi;
 		unsigned long irq_pending_lo[IPIPE_IRQ_IWORDS];
 		unsigned long irq_hits[IPIPE_NR_IRQS];
-	} cpudata[IPIPE_NR_CPUS];
+	} ____cacheline_aligned_in_smp cpudata[IPIPE_NR_CPUS];
 
 	struct {
-		int (*acknowledge) (unsigned irq);
-		void (*handler) (unsigned irq);
 		unsigned long control;
-	} irqs[IPIPE_NR_IRQS];
+		int (*acknowledge) (unsigned irq);
+		ipipe_irq_handler_t handler;
+		void *cookie;
+	} ____cacheline_aligned irqs[IPIPE_NR_IRQS];
 
 	int (*evhand[IPIPE_NR_EVENTS])(unsigned event,
 				       struct ipipe_domain *from,
@@ -148,7 +153,7 @@ struct ipipe_domain {
 			unsigned long long last_receipt_date;
 			unsigned long max_delivery_time;
 		} irq_stats[IPIPE_NR_IRQS];
-	} stats[IPIPE_NR_CPUS];
+	} ____cacheline_aligned_in_smp stats[IPIPE_NR_CPUS];
 #endif /* CONFIG_IPIPE_STATS */
 	unsigned long flags;
 	unsigned domid;
@@ -168,6 +173,9 @@ struct ipipe_domain_attr {
 
 /* The following macros must be used hw interrupts off. */
 
+#define __ipipe_irq_cookie(ipd,irq)	ipd->irqs[irq].cookie
+#define __ipipe_irq_handler(ipd,irq)	ipd->irqs[irq].handler
+
 #define __ipipe_set_irq_bit(ipd,cpuid,irq) \
 do { \
 	if (!test_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) { \
@@ -313,7 +321,7 @@ void __ipipe_add_domain_proc(struct ipip
 
 void __ipipe_remove_domain_proc(struct ipipe_domain *ipd);
 
-void __ipipe_flush_printk(unsigned irq);
+void __ipipe_flush_printk(unsigned irq, void *cookie);
 
 void __ipipe_stall_root(void);
 
@@ -472,7 +480,7 @@ void ipipe_suspend_domain(void);
 
 int ipipe_virtualize_irq(struct ipipe_domain *ipd,
 			 unsigned irq,
-			 void (*handler) (unsigned irq),
+			 ipipe_irq_handler_t handler,
 			 int (*acknowledge) (unsigned irq),
 			 unsigned modemask);
 
diff -urp linux-2.6.14.2-ipipe-1.0-10/kernel/ipipe/core.c linux-2.6.14.2-ipipe-1.0-10-ext/kernel/ipipe/core.c
--- linux-2.6.14.2-ipipe-1.0-10/kernel/ipipe/core.c	2005-12-22 14:15:17.000000000 +0100
+++ linux-2.6.14.2-ipipe-1.0-10-ext/kernel/ipipe/core.c	2005-12-23 16:31:33.000000000 +0100
@@ -78,6 +78,7 @@ void ipipe_init(void)
 
 	__ipipe_printk_virq = ipipe_alloc_virq();	/* Cannot fail here. */
 	ipd->irqs[__ipipe_printk_virq].handler = &__ipipe_flush_printk;
+	ipd->irqs[__ipipe_printk_virq].cookie = NULL;
 	ipd->irqs[__ipipe_printk_virq].acknowledge = NULL;
 	ipd->irqs[__ipipe_printk_virq].control = IPIPE_HANDLE_MASK;
 
@@ -115,6 +116,7 @@ void __ipipe_init_stage(struct ipipe_dom
 #ifdef CONFIG_SMP
 	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge = &__ipipe_ack_system_irq;
 	ipd->irqs[IPIPE_CRITICAL_IPI].handler = &__ipipe_do_critical_sync;
+	ipd->irqs[IPIPE_CRITICAL_IPI].cookie = NULL;
 	/* Immediately handle in the current domain but *never* pass */
 	ipd->irqs[IPIPE_CRITICAL_IPI].control =
 		IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK;
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


------=_Part_10423_13114686.1135588670132
Content-Type: text/plain; name=xenomai-2.1-i386-ext.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xenomai-2.1-i386-ext.patch"

diff -urp xenomai-2.1-clean/include/asm-generic/hal.h xenomai-2.1-ext/include/asm-generic/hal.h
--- xenomai-2.1-clean/include/asm-generic/hal.h	2005-11-21 21:52:35.000000000 +0100
+++ xenomai-2.1-ext/include/asm-generic/hal.h	2005-12-23 17:18:05.000000000 +0100
@@ -86,6 +86,9 @@ typedef rwlock_t rthal_rwlock_t;
 #endif /* RAW_RW_LOCK_UNLOCKED */
 #endif /* IPIPE_RW_LOCK_UNLOCKED */
 
+#define rthal_irq_cookie(ipd,irq)	__ipipe_irq_cookie((ipd),irq)
+#define rthal_irq_handler(ipd,irq)	__ipipe_irq_handler((ipd),irq)
+
 #define rthal_local_irq_disable()	ipipe_stall_pipeline_from(&rthal_domain)
 #define rthal_local_irq_enable()	ipipe_unstall_pipeline_from(&rthal_domain)
 #define rthal_local_irq_save(x)		((x) = !!ipipe_test_and_stall_pipeline_from(&rthal_domain))
@@ -447,8 +450,8 @@ do {  \
 
 #define rthal_printk	printk
 
-typedef void (*rthal_irq_handler_t)(unsigned irq,
-				    void *cookie);
+typedef ipipe_irq_handler_t rthal_irq_handler_t;
+
 
 struct rthal_calibration_data {
 
@@ -497,7 +500,7 @@ int rthal_init(void);
 void rthal_exit(void);
 
 int rthal_irq_request(unsigned irq,
-		      void (*handler)(unsigned irq, void *cookie),
+		      rthal_irq_handler_t handler,
 		      int (*ackfn)(unsigned irq),
 		      void *cookie);
 
diff -urp xenomai-2.1-clean/include/asm-generic/system.h xenomai-2.1-ext/include/asm-generic/system.h
--- xenomai-2.1-clean/include/asm-generic/system.h	2005-11-21 21:52:35.000000000 +0100
+++ xenomai-2.1-ext/include/asm-generic/system.h	2005-12-22 13:36:12.000000000 +0100
@@ -349,7 +349,7 @@ static inline int xnarch_hook_ipi (void 
 {
     return rthal_virtualize_irq(&rthal_domain,
 				RTHAL_SERVICE_IPI0,
-				(void (*)(unsigned)) handler,
+				(rthal_irq_handler_t) handler,
 				NULL,
 				IPIPE_HANDLE_MASK);
 }
@@ -387,7 +387,7 @@ static inline void xnarch_notify_halt(vo
 
     rthal_virtualize_irq(rthal_current_domain,
 			 RTHAL_SERVICE_IPI2,
-			 xnarch_finalize_cpu,
+			 (rthal_irq_handler_t)xnarch_finalize_cpu,
 			 NULL,
 			 IPIPE_HANDLE_MASK);
 
@@ -481,8 +481,7 @@ static inline unsigned long long xnarch_
 #ifdef XENO_INTR_MODULE
 
 static inline int xnarch_hook_irq (unsigned irq,
-				   void (*handler)(unsigned irq,
-						   void *cookie),
+				   rthal_irq_handler_t handler,
 				   int (*ackfn)(unsigned irq),
 				   void *cookie)
 {
diff -urp xenomai-2.1-clean/include/asm-i386/system.h xenomai-2.1-ext/include/asm-i386/system.h
--- xenomai-2.1-clean/include/asm-i386/system.h	2005-11-21 21:52:39.000000000 +0100
+++ xenomai-2.1-ext/include/asm-i386/system.h	2005-12-22 13:12:57.000000000 +0100
@@ -542,7 +542,7 @@ static inline void xnarch_init_shadow_tc
     tcb->fpup = &task->thread.i387;
 }
 
-static inline void xnarch_grab_xirqs (void (*handler)(unsigned irq))
+static inline void xnarch_grab_xirqs (rthal_irq_handler_t handler)
 
 {
     unsigned irq;
@@ -726,7 +726,7 @@ static inline int xnarch_init (void)
 
     rthal_virtualize_irq(&rthal_domain,
 			 xnarch_escalation_virq,
-			 (void (*)(unsigned))&xnpod_schedule_handler,
+			 (rthal_irq_handler_t)&xnpod_schedule_handler,
 			 NULL,
 			 IPIPE_HANDLE_MASK);
 
diff -urp xenomai-2.1-clean/include/rtdm/rtdm_driver.h xenomai-2.1-ext/include/rtdm/rtdm_driver.h
--- xenomai-2.1-clean/include/rtdm/rtdm_driver.h	2005-11-21 21:52:39.000000000 +0100
+++ xenomai-2.1-ext/include/rtdm/rtdm_driver.h	2005-12-22 13:18:07.000000000 +0100
@@ -793,7 +793,7 @@ static inline int rtdm_nrtsig_init(rtdm_
     if (*nrt_sig == 0)
         return -EAGAIN;
 
-    rthal_virtualize_irq(rthal_root_domain, *nrt_sig, handler, NULL,
+    rthal_virtualize_irq(rthal_root_domain, *nrt_sig, (rthal_irq_handler_t)handler, NULL,
                          IPIPE_HANDLE_MASK);
     return 0;
 }
diff -urp xenomai-2.1-clean/ksrc/arch/generic/hal.c xenomai-2.1-ext/ksrc/arch/generic/hal.c
--- xenomai-2.1-clean/ksrc/arch/generic/hal.c	2005-11-21 21:53:09.000000000 +0100
+++ xenomai-2.1-ext/ksrc/arch/generic/hal.c	2005-12-23 17:20:38.000000000 +0100
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
@@ -179,7 +164,7 @@ static void rthal_irq_trampoline (unsign
  */
 
 int rthal_irq_request (unsigned irq,
-		       void (*handler)(unsigned irq, void *cookie),
+		       rthal_irq_handler_t handler,
 		       int (*ackfn)(unsigned irq),
 		       void *cookie)
 {
@@ -191,7 +176,7 @@ int rthal_irq_request (unsigned irq,
 
     flags = rthal_critical_enter(NULL);
 
-    if (rthal_realtime_irq[irq].handler != NULL)
+    if (rthal_irq_handler(&rthal_domain, irq) != NULL)
 	{
 	err = -EBUSY;
 	goto unlock_and_exit;
@@ -199,14 +184,12 @@ int rthal_irq_request (unsigned irq,
 
     err = rthal_virtualize_irq(&rthal_domain,
 			       irq,
-			       &rthal_irq_trampoline,
+			       handler,
 			       ackfn,
 			       IPIPE_DYNAMIC_MASK);
+
     if (!err)
-	{
-	rthal_realtime_irq[irq].handler = handler;
-	rthal_realtime_irq[irq].cookie = cookie;
-	}
+	rthal_irq_cookie(&rthal_domain, irq) = cookie;
 
  unlock_and_exit:
 
@@ -254,8 +237,6 @@ int rthal_irq_release (unsigned irq)
 			       NULL,
 			       NULL,
 			       IPIPE_PASS_MASK);
-    if (!err)
-        xchg(&rthal_realtime_irq[irq].handler,NULL);
 
     return err;
 }
@@ -580,7 +561,7 @@ rthal_trap_handler_t rthal_trap_catch (r
     return (rthal_trap_handler_t)xchg(&rthal_trap_handler,handler);
 }
 
-static void rthal_apc_handler (unsigned virq)
+static void rthal_apc_handler (unsigned virq, void *cookie)
 
 {
     void (*handler)(void *), *cookie;
@@ -650,7 +631,7 @@ static int rthal_apc_thread (void *data)
     return 0;
 }
 
-void rthal_apc_kicker (unsigned virq)
+void rthal_apc_kicker (unsigned virq, void *cookie)
 
 {
     wake_up_process(rthal_apc_servers[smp_processor_id()]);
@@ -877,14 +858,14 @@ static int irq_read_proc (char *page,
 
     for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
 
-	if (rthal_realtime_irq[irq].handler == NULL)
-	    continue;
+//	if (rthal_realtime_irq[irq].handler == NULL)
+//	    continue;
 
 	p += sprintf(p,"\n%3d:",irq);
 
-	for_each_online_cpu(cpu) {
-	    p += sprintf(p,"%12lu",rthal_realtime_irq[irq].hits[cpu]);
-	}
+//	for_each_online_cpu(cpu) {
+//	    p += sprintf(p,"%12lu",rthal_realtime_irq[irq].hits[cpu]);
+//	}
     }
 
     p += sprintf(p,"\n");
@@ -1093,6 +1074,9 @@ int rthal_init (void)
 			       &rthal_apc_trampoline,
 			       NULL,
 			       IPIPE_HANDLE_MASK);
+
+    rthal_irq_cookie(rthal_current_domain, irq) = NULL;
+
     if (err)
     {
         printk(KERN_ERR "Xenomai: Failed to virtualize IRQ.\n");
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
+++ xenomai-2.1-ext/sim/include/asm-mvm/system.h	2005-12-22 13:37:33.000000000 +0100
@@ -365,8 +365,7 @@ void mvm_tcl_build_pendq(mvm_tcl_listobj
 #ifdef XENO_INTR_MODULE
 
 static inline int xnarch_hook_irq (unsigned irq,
-				   void (*handler)(unsigned irq,
-						   void *cookie),
+				   rthal_irq_handler_t handler,
 				   int (*ackfn)(unsigned irq), /* Ignored. */
 				   void *cookie)
 {
diff -urp xenomai-2.1-clean/src/include/asm-uvm/system.h xenomai-2.1-ext/src/include/asm-uvm/system.h
--- xenomai-2.1-clean/src/include/asm-uvm/system.h	2005-11-21 21:52:41.000000000 +0100
+++ xenomai-2.1-ext/src/include/asm-uvm/system.h	2005-12-22 13:37:05.000000000 +0100
@@ -272,8 +272,7 @@ void xnarch_sync_irq (void) /* Synchroni
 }
 
 static inline int xnarch_hook_irq (unsigned irq,
-				   void (*handler)(unsigned irq,
-						   void *cookie),
+				   rthal_irq_handler_t handler,
 				   int (*ackfn)(unsigned irq),
 				   void *cookie)
 {

------=_Part_10423_13114686.1135588670132--

