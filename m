Message-ID: <47837350.3050105@domain.hid>
Date: Tue, 08 Jan 2008 13:57:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070006010908070300020409"
Subject: [Adeos-main] [PATCH 1/3] 2.6.24-x86: remove legacy code
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------070006010908070300020409
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This is a rebased version of [1] over 2.6.24-rc6-x86-2.0-01. No
regressions were found while testing over the last days.

Jan

[1] https://mail.gna.org/public/adeos-main/2007-12/msg00058.html

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------070006010908070300020409
Content-Type: text/x-patch;
 name="remove-legacy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-legacy.patch"

---
 arch/x86/kernel/apic_64.c       |    6 ------
 arch/x86/kernel/ipipe_32.c      |    2 --
 arch/x86/kernel/ipipe_64.c      |   10 +---------
 include/asm-x86/ipipe_64.h      |   21 +++++++++++----------
 include/asm-x86/ipipe_base_64.h |    4 ----
 5 files changed, 12 insertions(+), 31 deletions(-)

Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/apic_64.c
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/apic_64.c
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/apic_64.c
@@ -939,9 +939,6 @@ static void __init calibrate_APIC_clock(
 
 	printk(KERN_INFO "Detected %d.%03d MHz APIC timer.\n",
 		result / 1000 / 1000, result / 1000 % 1000);
-#ifdef CONFIG_IPIPE
-	__ipipe_apic_timer_freq = result;
-#endif
 
 	/* Calculate the scaled math multiplication factor */
 	lapic_clockevent.mult = div_sc(result, NSEC_PER_SEC, 32);
@@ -970,9 +967,6 @@ void __init setup_boot_APIC_clock (void)
 	}
 
 	printk(KERN_INFO "Using local APIC timer interrupts.\n");
-#ifdef CONFIG_IPIPE
-	__ipipe_tick_irq = ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR);
-#endif
 	calibrate_APIC_clock();
 
 	/*
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe_64.c
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/ipipe_64.c
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe_64.c
@@ -46,8 +46,7 @@
 
 asmlinkage void preempt_schedule_irq(void);
 
-int __ipipe_tick_irq;
-unsigned long __ipipe_apic_timer_freq;
+int __ipipe_tick_irq = TIMER_IRQ;
 
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
 
@@ -102,12 +101,6 @@ int ipipe_get_sysinfo(struct ipipe_sysin
 	return 0;
 }
 
-int ipipe_tune_timer(unsigned long ns, int flags)
-{
-	printk(KERN_WARNING "I-pipe: %s is deprecated - no action taken\n", __FUNCTION__);
-	return -ENOSYS;
-}
-
 asmlinkage unsigned int do_IRQ(struct pt_regs *regs);
 asmlinkage void smp_apic_timer_interrupt(struct pt_regs *regs);
 asmlinkage void smp_spurious_interrupt(struct pt_regs *regs);
@@ -792,7 +785,6 @@ EXPORT_SYMBOL(ipipe_critical_enter);
 EXPORT_SYMBOL(ipipe_critical_exit);
 EXPORT_SYMBOL(ipipe_trigger_irq);
 EXPORT_SYMBOL(ipipe_get_sysinfo);
-EXPORT_SYMBOL(ipipe_tune_timer);
 
 EXPORT_SYMBOL_GPL(irq_desc);
 struct task_struct *__switch_to(struct task_struct *prev_p,
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_64.h
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_64.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_64.h
@@ -79,13 +79,6 @@ extern unsigned cpu_khz;
 #define ipipe_tsc2ns(t)	(((t) * 1000UL) / (ipipe_cpu_freq() / 1000000UL))
 #define ipipe_tsc2us(t)	((t) / (ipipe_cpu_freq() / 1000000UL))
 
-/*
- * The following interface will be deprecated once generic clockevents
- * are supported by this architecture, at which point
- * ipipe_request_tickdev() should be used instead.
- */
-extern unsigned long __ipipe_apic_timer_freq;
-
 /* Private interface -- Internal use only */
 
 #define __ipipe_check_platform()	do { } while(0)
@@ -133,6 +126,15 @@ static inline unsigned long __ipipe_ffnz
       return ul;
 }
 
+#define ipipe_update_tick_evtdev(evtdev)				\
+	do {								\
+		if (strcmp((evtdev)->name, "lapic") == 0)		\
+			__ipipe_tick_irq =				\
+				ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR); \
+		else							\
+			__ipipe_tick_irq = TIMER_IRQ;			\
+	} while (0)
+
 struct irq_desc;
 
 void __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc);
@@ -175,10 +177,9 @@ int __ipipe_check_tickdev(const char *de
 
 #else /* !CONFIG_IPIPE */
 
-#define task_hijacked(p)	0
+#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
+#define task_hijacked(p)			0
 
 #endif /* CONFIG_IPIPE */
 
-#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
-
 #endif	/* !__X86_IPIPE_64_H */
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base_64.h
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_base_64.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base_64.h
@@ -182,8 +182,4 @@ static inline unsigned long __ipipe_test
 
 #endif /* !__ASSEMBLY__ */
 
-/* Arch-dependent features */
-
-#define __IPIPE_FEATURE_APIC_TIMER_FREQ  1
-
 #endif	/* !__X86_IPIPE_BASE_64_H */
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe_32.c
===================================================================
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/ipipe_32.c
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe_32.c
@@ -48,8 +48,6 @@
 #include <mach_ipi.h>
 #endif	/* CONFIG_X86_LOCAL_APIC */
 
-extern struct clock_event_device *global_clock_event;
-
 int __ipipe_tick_irq = TIMER_IRQ;
 
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);

--------------070006010908070300020409--

