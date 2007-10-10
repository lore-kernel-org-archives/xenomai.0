Message-ID: <305035a40710092312h64dc118fk56df93b8ee06090a@domain.hid>
Date: Wed, 10 Oct 2007 08:12:08 +0200
From: "Gregory CLEMENT" <gclement00@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-core] Adeos patch to make RTAI works on AT91SAM926x
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main <adeos-main@gna.org>, xenomai@xenomai.org

Here it is the patch to make RTAI works on AT91SAM926x, maybe it will
ring some bells.

Some parts are for enabling interrupts on gpio.
Some are especially for RTAI.
There is the modification of priority level for System Peripherals. By
the way, setting it at 7 was an error in the beginning of the adaption
for AT91SAM926x.


diff -NaurdpbB -X nodiff linux-2.6.20.13-clean/arch/arm/kernel/ipipe.c
linux-2.6.20.13/arch/arm/kernel/ipipe.c
--- linux-2.6.20.13-clean/arch/arm/kernel/ipipe.c=092007-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/arch/arm/kernel/ipipe.c=092007-08-23 13:44:07.000000000=
 +0200
@@ -192,6 +192,21 @@ void __ipipe_enable_irqdesc(unsigned irq
 =09irq_desc[irq].status &=3D ~IRQ_DISABLED;
 }

+/*
+ * In Linux setup_irq, status is used to manage nested IRQ
+ */
+void __ipipe_enable_depth(unsigned irq)
+{
+=09if(!(irq_desc[irq].status & IRQ_NOAUTOEN))
+=09=09irq_desc[irq].depth =3D 1;
+}
+
+void __ipipe_disable_depth(unsigned irq)
+{
+=09if(!(irq_desc[irq].status & IRQ_NOAUTOEN))
+=09=09irq_desc[irq].depth =3D 0;
+}
+
 static void __ipipe_enable_sync(void)
 {
 =09__ipipe_decr_next[ipipe_processor_id()] =3D
@@ -353,9 +368,9 @@ asmlinkage int __ipipe_syscall_root(unsi
 =09 * tail work has to be performed (for handling signals etc).
 =09 */

-=09if (__ipipe_syscall_watched_p(current, regs->ARM_r7) &&
+=09if (__ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,regs) > 0 &&
 =09    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
-=09    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,regs) > 0) {
+=09    __ipipe_syscall_watched_p(current, regs->ARM_r7)) {
 =09=09if (ipipe_current_domain =3D=3D ipipe_root_domain && !in_atomic()) {
 =09=09=09/*
 =09=09=09 * Sync pending VIRQs before _TIF_NEED_RESCHED
@@ -469,6 +484,11 @@ finalize:
 =09__ipipe_walk_pipeline(head, cpuid);
 }

+int (*extern_timer_isr)(struct pt_regs *regs);
+EXPORT_SYMBOL(extern_timer_isr);
+
+#include <asm/arch/at91_pio.h>
+
 asmlinkage int __ipipe_grab_irq(int irq, struct pt_regs *regs)
 {
 =09ipipe_declare_cpuid;
@@ -478,6 +498,8 @@ asmlinkage int __ipipe_grab_irq(int irq,
 =09=09__ipipe_tick_regs[cpuid].ARM_cpsr =3D regs->ARM_cpsr;
 =09=09__ipipe_tick_regs[cpuid].ARM_pc =3D regs->ARM_pc;

+=09=09if (extern_timer_isr) return extern_timer_isr(regs);
+
 =09=09if (__ipipe_decr_ticks !=3D __ipipe_mach_ticks_per_jiffy) {
 =09=09=09unsigned long long next_date, now;

@@ -517,6 +539,15 @@ asmlinkage int __ipipe_grab_irq(int irq,
 =09=09=09  &ipipe_root_domain->cpudata[cpuid].status));
 }

+void *ipipe_irq_handler =3D __ipipe_handle_irq;
+EXPORT_SYMBOL(ipipe_irq_handler);
+EXPORT_SYMBOL(__ipipe_tick_regs);
+__attribute__((regparm(3))) void do_notify_resume(struct pt_regs *,
void *, __u32);
+EXPORT_SYMBOL(do_notify_resume);
+extern void *sys_call_table;
+EXPORT_SYMBOL(sys_call_table);
+extern void ret_from_intr(void);
+
 EXPORT_SYMBOL(__ipipe_decr_ticks);
 EXPORT_SYMBOL(__ipipe_decr_next);
 EXPORT_SYMBOL(ipipe_critical_enter);
@@ -525,6 +556,7 @@ EXPORT_SYMBOL(ipipe_trigger_irq);
 EXPORT_SYMBOL(ipipe_get_sysinfo);
 EXPORT_SYMBOL(ipipe_tune_timer);

+EXPORT_SYMBOL_GPL(irq_desc);
 EXPORT_SYMBOL_GPL(show_stack);
 #ifndef MULTI_CPU
 EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
diff -NaurdpbB -X nodiff
linux-2.6.20.13-clean/arch/arm/mach-at91rm9200/at91rm9200_time.c
linux-2.6.20.13/arch/arm/mach-at91rm9200/at91rm9200_time.c
--- linux-2.6.20.13-clean/arch/arm/mach-at91rm9200/at91rm9200_time.c=092007=
-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/arch/arm/mach-at91rm9200/at91rm9200_time.c=092007-07-12
09:34:28.000000000 +0200
@@ -338,6 +338,22 @@ notrace unsigned long long __ipipe_mach_
 EXPORT_SYMBOL(__ipipe_mach_get_tsc);

 /*
+ * getter/setter available for easy use of local_tsc
+ */
+
+notrace unsigned long long __ipipe_get_tsc(void)
+{
+=09return (&tsc[ipipe_processor_id()])->full;
+}
+EXPORT_SYMBOL(__ipipe_get_tsc);
+
+notrace void __ipipe_set_tsc(unsigned long long value)
+{
+=09(&tsc[ipipe_processor_id()])->full =3D value;
+}
+EXPORT_SYMBOL(__ipipe_set_tsc);
+
+/*
  * Reprogram the timer
  */

diff -NaurdpbB -X nodiff
linux-2.6.20.13-clean/arch/arm/mach-at91rm9200/at91sam9261.c
linux-2.6.20.13/arch/arm/mach-at91rm9200/at91sam9261.c
--- linux-2.6.20.13-clean/arch/arm/mach-at91rm9200/at91sam9261.c=092007-07-=
12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/arch/arm/mach-at91rm9200/at91sam9261.c=092007-08-24
17:18:07.000000000 +0200
@@ -287,7 +287,7 @@ static unsigned int at91sam9261_default_
 /* Give the highest priority to TC, since they are used as timer interrupt=
 by
    I-pipe. */
 =097,=09/* Advanced Interrupt Controller */
-=097,=09/* System Peripherals */
+=096,=09/* System Peripherals */
 =090,=09/* Parallel IO Controller A */
 =090,=09/* Parallel IO Controller B */
 =090,=09/* Parallel IO Controller C */
diff -NaurdpbB -X nodiff
linux-2.6.20.13-clean/arch/arm/mach-at91rm9200/at91sam926x_time.c
linux-2.6.20.13/arch/arm/mach-at91rm9200/at91sam926x_time.c
--- linux-2.6.20.13-clean/arch/arm/mach-at91rm9200/at91sam926x_time.c=09200=
7-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/arch/arm/mach-at91rm9200/at91sam926x_time.c=092007-07-1=
2
09:34:28.000000000 +0200
@@ -325,6 +325,22 @@ notrace unsigned long long __ipipe_mach_
 EXPORT_SYMBOL(__ipipe_mach_get_tsc);

 /*
+ * getter/setter available for easy use of local_tsc
+ */
+
+notrace unsigned long long __ipipe_get_tsc(void)
+{
+=09return (&tsc[ipipe_processor_id()])->full;
+}
+EXPORT_SYMBOL(__ipipe_get_tsc);
+
+notrace void __ipipe_set_tsc(unsigned long long value)
+{
+=09(&tsc[ipipe_processor_id()])->full =3D value;
+}
+EXPORT_SYMBOL(__ipipe_set_tsc);
+
+/*
  * Reprogram the timer
  */

diff -NaurdpbB -X nodiff linux-2.6.20.13-clean/include/asm-arm/ipipe.h
linux-2.6.20.13/include/asm-arm/ipipe.h
--- linux-2.6.20.13-clean/include/asm-arm/ipipe.h=092007-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/include/asm-arm/ipipe.h=092007-07-13 14:05:00.000000000=
 +0200
@@ -70,7 +70,8 @@ do {=09=09=09=09=09=09=09=09\
 #define IPIPE_NR_FAULTS=09=09 8

 /* Pseudo-vectors used for kernel events */
-#define IPIPE_FIRST_EVENT=09IPIPE_NR_FAULTS
+#define IPIPE_FIRST_EVENT=09IPIPE_NR_FAULTS + 2=09/* on x86,
HAL_SCHEDULE_TAIL =3D IPIPE_FIRST_EVENT - 2 is not used
+=09=09=09=09=09=09=09 * on ARM, this trap can be used by VFP, so we add an=
 offset
on IPIPE_FIRST_EVENT */
 #define IPIPE_EVENT_SYSCALL=09(IPIPE_FIRST_EVENT)
 #define IPIPE_EVENT_SCHEDULE=09(IPIPE_FIRST_EVENT + 1)
 #define IPIPE_EVENT_SIGWAKE=09(IPIPE_FIRST_EVENT + 2)
@@ -166,6 +167,10 @@ void __ipipe_init_platform(void);

 void __ipipe_enable_irqdesc(unsigned irq);

+void __ipipe_enable_depth(unsigned irq);
+
+void __ipipe_disable_depth(unsigned irq);
+
 void __ipipe_enable_pipeline(void);

 void __ipipe_do_IRQ(int irq,
diff -NaurdpbB -X nodiff
linux-2.6.20.13-clean/include/asm-arm/irqflags.h
linux-2.6.20.13/include/asm-arm/irqflags.h
--- linux-2.6.20.13-clean/include/asm-arm/irqflags.h=092007-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/include/asm-arm/irqflags.h=092007-08-06
09:59:29.000000000 +0200
@@ -170,13 +170,13 @@ void __ipipe_restore_root(unsigned long
 } while (0)
 #define local_irq_save_hw(x) do { \
 =09local_save_flags_hw(x); \
-=09if (raw_irqs_disabled_flags(x)) { \
+=09if (!raw_irqs_disabled_flags(x)) { \
 =09=09local_irq_disable_hw_notrace(); \
 =09=09ipipe_trace_begin(0x80000001); \
 =09} \
 } while (0)
 #define local_irq_restore_hw(x) do { \
-=09if (raw_irqs_disabled_flags(x)) \
+=09if (!raw_irqs_disabled_flags(x)) \
 =09=09ipipe_trace_end(0x80000001); \
 =09local_irq_restore_hw_notrace(x); \
 } while (0)
diff -NaurdpbB -X nodiff
linux-2.6.20.13-clean/include/asm-arm/system.h
linux-2.6.20.13/include/asm-arm/system.h
--- linux-2.6.20.13-clean/include/asm-arm/system.h=092007-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/include/asm-arm/system.h=092007-07-12 09:34:28.00000000=
0 +0200
@@ -347,6 +347,46 @@ static inline unsigned long __xchg(unsig
 extern void disable_hlt(void);
 extern void enable_hlt(void);

+/*
+ * We only implement cmpxchg in ASM on ARMv6 where we have LDREX/STREX
+ * available, and we only implement it for word-sized exchanges
+ */
+#if __LINUX_ARM_ARCH__ >=3D 6
+extern void __bad_cmpxchg(volatile void *, int);
+
+#define cmpxchg(ptr, old, new)=09=09=09=09=09=09\
+({=09=09=09=09=09=09=09=09=09\
+=09__typeof__ (ptr) ____p =3D (ptr);=09=09=09=09=09\
+=09__typeof__(*ptr) ____old =3D (old);=09=09=09=09\
+=09__typeof__(*ptr) ____new =3D (new);=09=09=09=09\
+=09__typeof__(*ptr) ____oldval;=09=09=09=09=09\
+=09__typeof__(*ptr) ____res;=09=09=09=09=09\
+=09=09=09=09=09=09=09=09=09\
+=09switch (sizeof(____res)) {=09=09=09=09=09\
+=09case 4:=09=09=09=09=09=09=09=09\
+=09=09do {=09=09=09=09=09=09=09\
+=09=09=09__asm__ __volatile__("@ cmpxchg\n"=09=09\
+=09=09=09"ldrex=09%1, [%2]\n"=09=09=09=09\
+=09=09=09"mov=09%0, #0\n"=09=09=09=09\
+=09=09=09"teq=09%1, %3\n"=09=09=09=09\
+=09=09=09"strexeq %0, %4, [%2]\n"=09=09=09\
+=09=09=09: "=3D&r" (____res), "=3D&r" (____oldval)=09=09\
+=09=09=09: "r" (____p), "Ir" (____old), "r" (____new)=09\
+=09=09=09: "cc");=09=09=09=09=09\
+=09=09} while(____res);=09=09=09=09=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09default:=09=09=09=09=09=09=09\
+=09=09__bad_cmpxchg(____p, sizeof(____res));=09=09=09\
+=09=09____oldval =3D 0;=09=09=09=09=09=09\
+=09=09break;=09=09=09=09=09=09=09\
+=09}=09=09=09=09=09=09=09=09\
+=09____oldval;=09=09=09=09=09=09=09\
+})
+
+#else
+#include <asm-generic/cmpxchg.h>
+#endif
+
 #endif /* __ASSEMBLY__ */

 #define arch_align_stack(x) (x)
diff -NaurdpbB -X nodiff
linux-2.6.20.13-clean/include/asm-arm/thread_info.h
linux-2.6.20.13/include/asm-arm/thread_info.h
--- linux-2.6.20.13-clean/include/asm-arm/thread_info.h=092007-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/include/asm-arm/thread_info.h=092007-07-12
09:34:28.000000000 +0200
@@ -143,6 +143,7 @@ extern void iwmmxt_task_switch(struct th
 #define TIF_NOTIFY_RESUME=090
 #define TIF_SIGPENDING=09=091
 #define TIF_NEED_RESCHED=092
+#define TIF_RESTORE_SIGMASK=096=09/* restore signal mask in do_signal() */
 #define TIF_SYSCALL_TRACE=098
 #define TIF_POLLING_NRFLAG=0916
 #define TIF_USING_IWMMXT=0917
@@ -155,6 +156,7 @@ extern void iwmmxt_task_switch(struct th
 #define _TIF_NOTIFY_RESUME=09(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING=09=09(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED=09(1 << TIF_NEED_RESCHED)
+#define _TIF_RESTORE_SIGMASK=09(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_SYSCALL_TRACE=09(1 << TIF_SYSCALL_TRACE)
 #define _TIF_POLLING_NRFLAG=09(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT=09(1 << TIF_USING_IWMMXT)
diff -NaurdpbB -X nodiff
linux-2.6.20.13-clean/include/asm-generic/cmpxchg.h
linux-2.6.20.13/include/asm-generic/cmpxchg.h
--- linux-2.6.20.13-clean/include/asm-generic/cmpxchg.h=091970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.20.13/include/asm-generic/cmpxchg.h=092007-07-12
09:34:28.000000000 +0200
@@ -0,0 +1,46 @@
+/* Generic cmpxchg for those arches that don't implement it themselves
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@domain.hid)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_GENERIC_CMPXCHG_H
+#define _ASM_GENERIC_CMPXCHG_H
+
+#if !defined(cmpxchg) && !defined(CONFIG_SMP)
+
+/**
+ * cmpxchg - Atomically conditionally exchange one value for another.
+ * @ptr - Pointer to the value to be altered.
+ * @old - The value to change from.
+ * @new - The value to change to.
+ *
+ * This function atomically compares the current value at the word pointed=
 to
+ * by @ptr, and if it's the same as @old, changes it to @new.  If it's not=
 the
+ * same then it's left unchanged.
+ *
+ * The value that was in the word pointed to by @ptr is returned, whether =
or
+ * not it was changed to @new.
+ */
+#define cmpxchg(ptr, old, new)=09=09=09\
+({=09=09=09=09=09=09\
+=09unsigned long ____flags;=09=09\
+=09__typeof__ (ptr) ____p =3D (ptr);=09=09\
+=09__typeof__(*ptr) ____old =3D (old);=09\
+=09__typeof__(*ptr) ____new =3D (new);=09\
+=09__typeof__(*ptr) ____res;=09=09\
+=09raw_local_irq_save(____flags);=09=09\
+=09____res =3D *____p;=09=09=09\
+=09if (likely(____res =3D=3D (____old)))=09\
+=09=09*____p =3D (____new);=09=09\
+=09raw_local_irq_restore(____flags);=09\
+=09____res;=09=09=09=09\
+})
+
+#endif /* !cmpxchg && !SMP */
+#endif /* _ASM_GENERIC_CMPXCHG_H */
diff -NaurdpbB -X nodiff linux-2.6.20.13-clean/kernel/ipipe/core.c
linux-2.6.20.13/kernel/ipipe/core.c
--- linux-2.6.20.13-clean/kernel/ipipe/core.c=092007-07-12
11:44:04.000000000 +0200
+++ linux-2.6.20.13/kernel/ipipe/core.c=092007-07-30 14:10:11.000000000 +02=
00
@@ -531,10 +531,12 @@ int ipipe_virtualize_irq(struct ipipe_do

 =09=09if ((modemask & IPIPE_STICKY_MASK) !=3D 0)
 =09=09=09modemask |=3D IPIPE_HANDLE_MASK;
-=09} else
+=09} else {
 =09=09modemask &=3D
 =09=09    ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK |
 =09=09      IPIPE_EXCLUSIVE_MASK | IPIPE_WIRED_MASK);
+=09=09__ipipe_enable_depth(irq);
+=09}

 =09if (acknowledge =3D=3D NULL && !ipipe_virtual_irq_p(irq))
 =09=09/* Acknowledge handler unspecified for a hw interrupt:
@@ -548,6 +550,7 @@ int ipipe_virtualize_irq(struct ipipe_do

 =09if (irq < NR_IRQS && handler !=3D NULL && !ipipe_virtual_irq_p(irq)) {
 =09=09__ipipe_enable_irqdesc(irq);
+=09=09__ipipe_disable_depth(irq);

 =09=09if ((modemask & IPIPE_ENABLE_MASK) !=3D 0) {
 =09=09=09if (ipd !=3D ipipe_current_domain) {
@@ -617,6 +620,12 @@ int ipipe_control_irq(unsigned irq, unsi

 int fastcall __ipipe_dispatch_event (unsigned event, void *data)
 {
+=09extern void *ipipe_irq_handler;
+=09void *handler;
+=09if (ipipe_irq_handler !=3D __ipipe_handle_irq && (handler =3D
ipipe_root_domain->evhand[event])) {
+=09=09return ((int (*)(unsigned long, void *))handler)(event, data);
+=09} else {
+
 =09struct ipipe_domain *start_domain, *this_domain, *next_domain;
 =09ipipe_event_handler_t evhand;
 =09struct list_head *pos, *npos;
@@ -677,7 +686,7 @@ int fastcall __ipipe_dispatch_event (uns
 =09ipipe_unlock_cpu(flags);

 =09return !propagate;
-}
+} }

 /*
  * __ipipe_dispatch_wired -- Wired interrupt dispatcher. Wired
@@ -1443,3 +1452,4 @@ EXPORT_SYMBOL(ipipe_get_ptd);
 EXPORT_SYMBOL(ipipe_set_irq_affinity);
 EXPORT_SYMBOL(ipipe_send_ipi);
 EXPORT_SYMBOL(__ipipe_schedule_irq);
+EXPORT_SYMBOL(__ipipe_sync_stage);
diff -NaurdpbB -X nodiff linux-2.6.20.13-clean/kernel/sched.c
linux-2.6.20.13/kernel/sched.c
--- linux-2.6.20.13-clean/kernel/sched.c=092007-07-12 11:44:04.000000000 +0=
200
+++ linux-2.6.20.13/kernel/sched.c=092007-08-23 13:44:00.000000000 +0200
@@ -1845,6 +1845,12 @@ context_switch(struct rq *rq, struct tas
 =09struct mm_struct *mm =3D next->mm;
 =09struct mm_struct *oldmm =3D prev->active_mm;

+#ifdef CONFIG_IPIPE
+if (!rq) {
+=09switch_mm(oldmm, next->active_mm, next);
+=09if (!mm) enter_lazy_tlb(oldmm, next);
+} else {
+#endif
 =09if (!mm) {
 =09=09next->active_mm =3D oldmm;
 =09=09atomic_inc(&oldmm->mm_count);
@@ -1857,6 +1863,9 @@ context_switch(struct rq *rq, struct tas
 =09=09WARN_ON(rq->prev_mm);
 =09=09rq->prev_mm =3D oldmm;
 =09}
+#ifdef CONFIG_IPIPE
+}
+#endif
 =09/*
 =09 * Since the runqueue lock will be released by the next
 =09 * task (which is an invalid locking op but in the case
@@ -1864,12 +1873,19 @@ context_switch(struct rq *rq, struct tas
 =09 * do an early lockdep release here:
 =09 */
 #ifndef __ARCH_WANT_UNLOCKED_CTXSW
+#ifdef CONFIG_IPIPE
+if (rq)
+#endif /* CONFIG_IPIPE */
 =09spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
 #endif

 =09/* Here we just switch the register state and the stack. */
 =09switch_to(prev, next, prev);

+#ifdef CONFIG_IPIPE
+=09current->ptd[IPIPE_ROOT_NPTDKEYS - 1] =3D prev;
+#endif /* CONFIG_IPIPE */
+
 =09return prev;
 }

@@ -3567,6 +3583,9 @@ switch_tasks:
 =09=09barrier();
  =09=09if (task_hijacked(prev))
  =09=09    return;
+=09=09#ifdef CONFIG_IPIPE
+=09=09=09__ipipe_dispatch_event(IPIPE_FIRST_EVENT - 2, 0);
+=09=09#endif /* CONFIG_IPIPE */
 =09=09/*
 =09=09 * this_rq must be evaluated again because prev may have moved
 =09=09 * CPUs since it called schedule(), thus the 'rq' on its stack
@@ -7115,6 +7134,7 @@ int ipipe_reenter_root (struct task_stru
 =09return 0;
 }

+EXPORT_SYMBOL(context_switch);
 EXPORT_SYMBOL(ipipe_reenter_root);

 #endif /* CONFIG_IPIPE */


--=20
Gregory CLEMENT
Adeneo
Adetel Group
2, chemin du Ruisseau
69134 ECULLY - FRANCE
T=E9l. : +33 (0)4 72 18 08 40 - Fax : +33 (0)4 72 18 08 41

www.adetelgroup.com

