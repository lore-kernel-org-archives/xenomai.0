From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:06 +0200
Message-Id: <20180925102716.4492-2-rpm@xenomai.org>
In-Reply-To: <20180925102716.4492-1-rpm@xenomai.org>
References: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 01/11] arm64: ipipe: add pipeline core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Introduce the arm64-specific bits enabling the interrupt pipeline
exclusively.
---
 arch/arm64/Kconfig                   |   3 +
 arch/arm64/include/asm/assembler.h   |  12 ++
 arch/arm64/include/asm/ipipe.h       | 205 +++++++++++++++++++++++++++++
 arch/arm64/include/asm/ipipe_base.h  |  86 ++++++++++++
 arch/arm64/include/asm/ipipe_hwirq.h | 191 +++++++++++++++++++++++++++
 arch/arm64/include/asm/irqflags.h    |  18 ++-
 arch/arm64/include/asm/percpu.h      |   1 +
 arch/arm64/include/asm/thread_info.h |  14 ++
 arch/arm64/include/asm/uaccess.h     |   5 +-
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/entry.S            |  38 +++++-
 arch/arm64/kernel/ipipe.c            | 246 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c              |  10 ++
 arch/arm64/kernel/process.c          |  32 +++++
 arch/arm64/kernel/signal.c           |  13 +-
 arch/arm64/kernel/smp.c              | 150 ++++++++++++++++++---
 arch/arm64/mm/context.c              |   2 +-
 18 files changed, 998 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/include/asm/ipipe.h
 create mode 100644 arch/arm64/include/asm/ipipe_base.h
 create mode 100644 arch/arm64/include/asm/ipipe_hwirq.h
 create mode 100644 arch/arm64/kernel/ipipe.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c30cd78b6918..1bfd99ad800b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,6 +108,8 @@ config ARM64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_IPIPE_SUPPORT
+	select HAVE_IPIPE_TRACER_SUPPORT
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
@@ -694,6 +696,7 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 config HOLES_IN_ZONE
 	def_bool y
 
+source kernel/ipipe/Kconfig
 source kernel/Kconfig.preempt
 source kernel/Kconfig.hz
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 66aea4aa455d..7fa36aa86025 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -51,6 +51,18 @@
 	msr	daif, \flags
 	.endm
 
+	.macro	disable_irq_cond
+#ifdef CONFIG_IPIPE
+	msr	daifset, #2
+#endif
+	.endm
+
+	.macro	enable_irq_cond
+#ifdef CONFIG_IPIPE
+	msr	daifclr, #2
+#endif
+	.endm
+
 /*
  * Enable and disable debug exceptions.
  */
diff --git a/arch/arm64/include/asm/ipipe.h b/arch/arm64/include/asm/ipipe.h
new file mode 100644
index 000000000000..2c25513ec017
--- /dev/null
+++ b/arch/arm64/include/asm/ipipe.h
@@ -0,0 +1,205 @@
+/* -*- linux-c -*-
+ * arch/arm/include/asm/ipipe.h
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2005 Stelian Pop.
+ * Copyright (C) 2006-2008 Gilles Chanteperdrix.
+ * Copyright (C) 2010 Philippe Gerum (SMP port).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __ARM_IPIPE_H
+#define __ARM_IPIPE_H
+
+#include <linux/irqdomain.h>
+
+#ifdef CONFIG_IPIPE
+
+#include <linux/jump_label.h>
+#include <linux/ipipe_trace.h>
+#include <linux/ipipe_debug.h>
+
+#define IPIPE_CORE_RELEASE	2
+
+struct ipipe_domain;
+
+#define IPIPE_TSC_TYPE_NONE			0
+#define IPIPE_TSC_TYPE_FREERUNNING		1
+#define IPIPE_TSC_TYPE_DECREMENTER		2
+#define IPIPE_TSC_TYPE_FREERUNNING_COUNTDOWN	3
+#define IPIPE_TSC_TYPE_FREERUNNING_TWICE	4
+#define IPIPE_TSC_TYPE_FREERUNNING_ARCH		5
+
+/* tscinfo, exported to user-space */
+struct __ipipe_tscinfo {
+	unsigned type;
+	unsigned freq;
+	unsigned long counter_vaddr;
+	union {
+		struct {
+			unsigned long counter_paddr;
+			unsigned long long mask;
+		};
+		struct {
+			unsigned *counter; /* Hw counter physical address */
+			unsigned long long mask; /* Significant bits in the hw counter. */
+			unsigned long long *tsc; /* 64 bits tsc value. */
+		} fr;
+		struct {
+			unsigned *counter; /* Hw counter physical address */
+			unsigned long long mask; /* Significant bits in the hw counter. */
+			unsigned *last_cnt; /* Counter value when updating
+						tsc value. */
+			unsigned long long *tsc; /* 64 bits tsc value. */
+		} dec;
+	} u;
+};
+
+struct ipipe_arch_sysinfo {
+	struct __ipipe_tscinfo tsc;
+};
+
+
+/* arch specific stuff */
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info);
+
+static inline void __ipipe_mach_update_tsc(void) {}
+
+static inline notrace unsigned long long __ipipe_mach_get_tsc(void)
+{
+	return arch_counter_get_cntvct();
+}
+
+#define __ipipe_tsc_get() __ipipe_mach_get_tsc()
+void __ipipe_tsc_register(struct __ipipe_tscinfo *info);
+static inline void __ipipe_tsc_update(void) {}
+#ifndef __ipipe_hrclock_freq
+extern unsigned long __ipipe_hrtimer_freq;
+#define __ipipe_hrclock_freq __ipipe_hrtimer_freq
+#endif /* !__ipipe_mach_hrclock_freq */
+
+#ifdef CONFIG_IPIPE_DEBUG_INTERNAL
+extern void (*__ipipe_mach_hrtimer_debug)(unsigned irq);
+#endif /* CONFIG_IPIPE_DEBUG_INTERNAL */
+
+#define ipipe_read_tsc(t)	do { t = __ipipe_tsc_get(); } while(0)
+#define __ipipe_read_timebase()	__ipipe_tsc_get()
+
+#define ipipe_tsc2ns(t) \
+({ \
+	unsigned long long delta = (t)*1000; \
+	do_div(delta, __ipipe_hrclock_freq / 1000000 + 1); \
+	(unsigned long)delta; \
+})
+#define ipipe_tsc2us(t) \
+({ \
+	unsigned long long delta = (t); \
+	do_div(delta, __ipipe_hrclock_freq / 1000000 + 1); \
+	(unsigned long)delta; \
+})
+
+static inline const char *ipipe_clock_name(void)
+{
+	return "ipipe_tsc";
+}
+
+/* Private interface -- Internal use only */
+
+#define __ipipe_enable_irq(irq)		enable_irq(irq)
+#define __ipipe_disable_irq(irq)	disable_irq(irq)
+
+#define ipipe_notify_root_preemption() do { } while(0)
+
+#ifdef CONFIG_SMP
+void __ipipe_early_core_setup(void);
+void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd);
+void __ipipe_root_localtimer(unsigned int irq, void *cookie);
+void __ipipe_grab_ipi(unsigned sgi, struct pt_regs *regs);
+void __ipipe_ipis_alloc(void);
+void __ipipe_ipis_request(void);
+
+#ifdef CONFIG_SMP_ON_UP
+extern struct static_key __ipipe_smp_key;
+#define ipipe_smp_p (static_key_true(&__ipipe_smp_key))
+#endif /* SMP_ON_UP */
+#else /* !CONFIG_SMP */
+#define __ipipe_early_core_setup()	do { } while(0)
+#define __ipipe_hook_critical_ipi(ipd)	do { } while(0)
+#endif /* !CONFIG_SMP */
+#ifndef __ipipe_mach_init_platform
+#define __ipipe_mach_init_platform()	do { } while(0)
+#endif
+
+void __ipipe_enable_pipeline(void);
+
+void __ipipe_do_critical_sync(unsigned irq, void *cookie);
+
+void __ipipe_grab_irq(int irq, struct pt_regs *regs);
+
+void __ipipe_exit_irq(struct pt_regs *regs);
+
+static inline
+int ipipe_handle_domain_irq(struct irq_domain *domain,
+			    unsigned int hwirq, struct pt_regs *regs)
+{
+	unsigned int irq;
+
+	irq = irq_find_mapping(domain, hwirq);
+	__ipipe_grab_irq(irq, regs);
+
+	return 0;
+}
+
+static inline void ipipe_handle_multi_ipi(int irq, struct pt_regs *regs)
+{
+	__ipipe_grab_ipi(irq, regs);
+}
+
+static inline unsigned long __ipipe_ffnz(unsigned long ul)
+{
+	int __r;
+
+	/* zero input is not valid */
+	IPIPE_WARN(ul == 0);
+
+	__asm__ ("rbit\t%0, %1\n"
+	         "clz\t%0, %0\n"
+	        : "=r" (__r) : "r"(ul) : "cc");
+
+	return __r;
+}
+
+#define __ipipe_syscall_watched_p(p, sc)				\
+	(ipipe_notifier_enabled_p(p) || (unsigned long)sc >= __NR_syscalls)
+
+#define __ipipe_root_tick_p(regs) (!arch_irqs_disabled_flags(regs->pstate))
+
+#else /* !CONFIG_IPIPE */
+
+#ifdef CONFIG_SMP
+static inline void ipipe_handle_multi_ipi(int irq, struct pt_regs *regs)
+{
+	handle_IPI(irq, regs);
+}
+#endif /* CONFIG_SMP */
+
+#define __ipipe_tsc_update()	do { } while(0)
+
+#endif /* CONFIG_IPIPE */
+
+#endif	/* !__ARM_IPIPE_H */
diff --git a/arch/arm64/include/asm/ipipe_base.h b/arch/arm64/include/asm/ipipe_base.h
new file mode 100644
index 000000000000..e3f8d4f45201
--- /dev/null
+++ b/arch/arm64/include/asm/ipipe_base.h
@@ -0,0 +1,86 @@
+/* -*- linux-c -*-
+ * arch/arm/include/asm/ipipe_base.h
+ *
+ * Copyright (C) 2007 Gilles Chanteperdrix.
+ * Copyright (C) 2010 Philippe Gerum (SMP port).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __ASM_ARM_IPIPE_BASE_H
+#define __ASM_ARM_IPIPE_BASE_H
+
+#include <asm-generic/ipipe.h>
+
+#ifdef CONFIG_IPIPE
+
+#include <asm/hardirq.h>
+
+#define IPIPE_NR_ROOT_IRQS	1024
+
+#define IPIPE_NR_XIRQS		IPIPE_NR_ROOT_IRQS
+
+#ifdef CONFIG_SMP
+/*
+ * Out-of-band IPIs are directly mapped to SGI1-3, instead of
+ * multiplexed over SGI0 like regular in-band messages.
+ */
+#define IPIPE_IPI_BASE         IPIPE_VIRQ_BASE
+#define IPIPE_OOB_IPI_NR       3
+#define IPIPE_CRITICAL_IPI     (IPIPE_IPI_BASE + NR_IPI)
+#define IPIPE_HRTIMER_IPI      (IPIPE_IPI_BASE + NR_IPI + 1)
+#define IPIPE_RESCHEDULE_IPI   (IPIPE_IPI_BASE + NR_IPI + 2)
+
+#define hard_smp_processor_id()	raw_smp_processor_id()
+
+#ifdef CONFIG_SMP_ON_UP
+unsigned __ipipe_processor_id(void);
+
+#define ipipe_processor_id()						\
+	({								\
+		register unsigned int cpunum __asm__ ("r0");		\
+		register unsigned int r1 __asm__ ("r1");		\
+		register unsigned int r2 __asm__ ("r2");		\
+		register unsigned int r3 __asm__ ("r3");		\
+		register unsigned int ip __asm__ ("ip");		\
+		register unsigned int lr __asm__ ("lr");		\
+		__asm__ __volatile__ ("\n"				\
+			"1:	bl __ipipe_processor_id\n"		\
+			"	.pushsection \".alt.smp.init\", \"a\"\n" \
+			"	.long	1b\n"				\
+			"	mov	%0, #0\n"			\
+			"	.popsection"				\
+				: "=r"(cpunum),	"=r"(r1), "=r"(r2), "=r"(r3), \
+				  "=r"(ip), "=r"(lr)			\
+				: /* */ : "cc");			\
+		cpunum;						\
+	})
+#else /* !SMP_ON_UP */
+#define ipipe_processor_id() raw_smp_processor_id()
+#endif /* !SMP_ON_UP */
+
+#define IPIPE_ARCH_HAVE_VIRQ_IPI
+
+#else /* !CONFIG_SMP */
+#define ipipe_processor_id()  (0)
+#endif /* !CONFIG_SMP */
+
+/* ARM64 traps */
+#define IPIPE_TRAP_MAYDAY        0	/* Internal recovery trap */
+
+#endif /* CONFIG_IPIPE */
+
+#endif /* __ASM_ARM_IPIPE_BASE_H */
diff --git a/arch/arm64/include/asm/ipipe_hwirq.h b/arch/arm64/include/asm/ipipe_hwirq.h
new file mode 100644
index 000000000000..9da127c349d0
--- /dev/null
+++ b/arch/arm64/include/asm/ipipe_hwirq.h
@@ -0,0 +1,191 @@
+/* -*- linux-c -*-
+ * arch/arm/include/asm/ipipe_hwirq.h
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2005 Stelian Pop.
+ * Copyright (C) 2006-2008 Gilles Chanteperdrix.
+ * Copyright (C) 2010 Philippe Gerum (SMP port).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef _ASM_ARM_IPIPE_HWIRQ_H
+#define _ASM_ARM_IPIPE_HWIRQ_H
+
+#include <asm-generic/ipipe.h>
+
+#ifdef CONFIG_IPIPE
+
+#define hard_local_irq_restore_notrace(x)				\
+	__asm__ __volatile__(						\
+	"msr	daif, %0"	\
+	:								\
+	: "r" (x)							\
+	: "memory", "cc")
+
+static inline void hard_local_irq_disable_notrace(void)
+{
+	__asm__ __volatile__("msr daifset, #2" : : : "memory", "cc");
+}
+
+static inline void hard_local_irq_enable_notrace(void)
+{
+	__asm__ __volatile__("msr daifclr, #2" : : : "memory", "cc");
+}
+
+static inline void hard_local_fiq_disable_notrace(void)
+{
+	__asm__ __volatile__("msr daifset, #1" : : : "memory", "cc");
+}
+
+static inline void hard_local_fiq_enable_notrace(void)
+{
+	__asm__ __volatile__("msr daifclr, #1" : : : "memory", "cc");
+}
+
+static inline unsigned long hard_local_irq_save_notrace(void)
+{
+	unsigned long res;
+	__asm__ __volatile__(
+		"mrs	%0, daif\n"
+		"msr daifset, #2"
+		: "=r" (res) : : "memory", "cc");
+	return res;
+}
+
+#include <linux/ipipe_trace.h>
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (int)((flags) & PSR_I_BIT);
+}
+
+static inline unsigned long hard_local_save_flags(void)
+{
+	unsigned long flags;
+	__asm__ __volatile__(
+		"mrs	%0, daif"
+		: "=r" (flags) : : "memory", "cc");
+	return flags;
+}
+
+#define hard_irqs_disabled_flags(flags) arch_irqs_disabled_flags(flags)
+
+static inline int hard_irqs_disabled(void)
+{
+	return hard_irqs_disabled_flags(hard_local_save_flags());
+}
+
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+
+static inline void hard_local_irq_disable(void)
+{
+	if (!hard_irqs_disabled()) {
+		hard_local_irq_disable_notrace();
+		ipipe_trace_begin(0x80000000);
+	}
+}
+
+static inline void hard_local_irq_enable(void)
+{
+	if (hard_irqs_disabled()) {
+		ipipe_trace_end(0x80000000);
+		hard_local_irq_enable_notrace();
+	}
+}
+
+static inline unsigned long hard_local_irq_save(void)
+{
+	unsigned long flags;
+
+	flags = hard_local_irq_save_notrace();
+	if (!arch_irqs_disabled_flags(flags))
+		ipipe_trace_begin(0x80000001);
+
+	return flags;
+}
+
+static inline void hard_local_irq_restore(unsigned long x)
+{
+	if (!arch_irqs_disabled_flags(x))
+		ipipe_trace_end(0x80000001);
+
+	hard_local_irq_restore_notrace(x);
+}
+
+#else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#define hard_local_irq_disable    hard_local_irq_disable_notrace
+#define hard_local_irq_enable     hard_local_irq_enable_notrace
+#define hard_local_irq_save       hard_local_irq_save_notrace
+#define hard_local_irq_restore    hard_local_irq_restore_notrace
+
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+
+#define arch_local_irq_disable()		\
+	({					\
+		ipipe_stall_root();		\
+		barrier();			\
+	})
+
+#define arch_local_irq_enable()				\
+	do {						\
+		barrier();				\
+		ipipe_unstall_root();			\
+	} while (0)
+
+#define arch_local_irq_restore(flags)			\
+	do {						\
+		if (!arch_irqs_disabled_flags(flags))	\
+			arch_local_irq_enable();	\
+	} while (0)
+
+#define arch_local_irq_save()						\
+	({								\
+		unsigned long _flags;					\
+		_flags = ipipe_test_and_stall_root() << 7;		\
+		barrier();						\
+		_flags;							\
+	})
+
+#define arch_local_save_flags()						\
+	({								\
+		unsigned long _flags;					\
+		_flags = ipipe_test_root() << 7;			\
+		barrier();						\
+		_flags;							\
+	})
+
+#define arch_irqs_disabled()		ipipe_test_root()
+#define hard_irq_disable()		hard_local_irq_disable()
+
+static inline unsigned long arch_mangle_irq_bits(int virt, unsigned long real)
+{
+	/* Merge virtual and real interrupt mask bits into a single
+	   32bit word. */
+	return (real & ~(1L << 8)) | ((virt != 0) << 8);
+}
+
+static inline int arch_demangle_irq_bits(unsigned long *x)
+{
+	int virt = (*x & (1 << 8)) != 0;
+	*x &= ~(1L << 8);
+	return virt;
+}
+
+#endif /* !CONFIG_IPIPE */
+
+#endif /* _ASM_ARM_IPIPE_HWIRQ_H */
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 8c581281fa12..de28b8cdd5d8 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -20,6 +20,10 @@
 
 #include <asm/ptrace.h>
 
+#include <asm/ipipe_hwirq.h>
+
+#ifndef CONFIG_IPIPE
+
 /*
  * CPU interrupt mask handling.
  */
@@ -53,12 +57,6 @@ static inline void arch_local_irq_disable(void)
 		: "memory");
 }
 
-#define local_fiq_enable()	asm("msr	daifclr, #1" : : : "memory")
-#define local_fiq_disable()	asm("msr	daifset, #1" : : : "memory")
-
-#define local_async_enable()	asm("msr	daifclr, #4" : : : "memory")
-#define local_async_disable()	asm("msr	daifset, #4" : : : "memory")
-
 /*
  * Save the current interrupt enable state.
  */
@@ -90,6 +88,14 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return flags & PSR_I_BIT;
 }
 
+#endif /* !IPIPE */
+
+#define local_fiq_enable()	asm("msr	daifclr, #1" : : : "memory")
+#define local_fiq_disable()	asm("msr	daifset, #1" : : : "memory")
+
+#define local_async_enable()	asm("msr	daifclr, #4" : : : "memory")
+#define local_async_disable()	asm("msr	daifset, #4" : : : "memory")
+
 /*
  * save and restore debug state
  */
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 43393208229e..c5468038eb29 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -18,6 +18,7 @@
 
 #include <asm/alternative.h>
 #include <asm/stack_pointer.h>
+#include <asm/ipipe_base.h>
 
 static inline void set_my_cpu_offset(unsigned long off)
 {
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index fc786d344e46..8c6d7b1b68b4 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -30,6 +30,7 @@ struct task_struct;
 #include <asm/memory.h>
 #include <asm/stack_pointer.h>
 #include <asm/types.h>
+#include <ipipe/thread_info.h>
 
 typedef unsigned long mm_segment_t;
 
@@ -43,6 +44,10 @@ struct thread_info {
 	u64			ttbr0;		/* saved TTBR0_EL1 */
 #endif
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
+#ifdef CONFIG_IPIPE
+	unsigned long		ipipe_flags;
+#endif
+	struct ipipe_threadinfo ipipe_data;
 };
 
 #define INIT_THREAD_INFO(tsk)						\
@@ -115,5 +120,14 @@ void arch_setup_new_exec(void);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_NOHZ)
 
+/* ti->ipipe_flags */
+#define TIP_MAYDAY	0	/* MAYDAY call is pending */
+#define TIP_NOTIFY	1	/* Notify head domain about kernel events */
+#define TIP_HEAD	2	/* Runs in head domain */
+
+#define _TIP_MAYDAY	(1 << TIP_MAYDAY)
+#define _TIP_NOTIFY	(1 << TIP_NOTIFY)
+#define _TIP_HEAD	(1 << TIP_HEAD)
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index fad8c1b2ca3e..9857c78c3dba 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -29,6 +29,7 @@
 #include <linux/kasan-checks.h>
 #include <linux/string.h>
 
+#include <asm-generic/ipipe.h>
 #include <asm/cpufeature.h>
 #include <asm/ptrace.h>
 #include <asm/memory.h>
@@ -297,7 +298,7 @@ do {									\
 #define __get_user_check(x, ptr, err)					\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
+	__ipipe_uaccess_might_fault();					\
 	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
 		__get_user_err((x), __p, (err));			\
@@ -366,7 +367,7 @@ do {									\
 #define __put_user_check(x, ptr, err)					\
 ({									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
+	__ipipe_uaccess_might_fault();					\
 	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
 		__p = uaccess_mask_ptr(__p);				\
 		__put_user_err((x), __p, (err));			\
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 714fe90dbf66..de0817ea241c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -62,6 +62,7 @@ endif
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-m					+= $(arm64-obj-m)
+obj-$(CONFIG_IPIPE)			+= ipipe.o
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b5e43b01b396..f7f0dd9933da 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -38,6 +38,9 @@ int main(void)
   DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
   BLANK();
   DEFINE(TSK_TI_FLAGS,		offsetof(struct task_struct, thread_info.flags));
+#ifdef CONFIG_IPIPE
+  DEFINE(TSK_TI_IPIPE,		offsetof(struct task_struct, thread_info.ipipe_flags));
+#endif
   DEFINE(TSK_TI_PREEMPT,	offsetof(struct task_struct, thread_info.preempt_count));
   DEFINE(TSK_TI_ADDR_LIMIT,	offsetof(struct task_struct, thread_info.addr_limit));
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c1ffa95c0ad2..75e52672914a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -416,7 +416,11 @@ tsk	.req	x28		// current thread_info
  * Interrupt handling.
  */
 	.macro	irq_handler
+#ifdef CONFIG_IPIPE
+	ldr	x1, =handle_arch_irq_pipelined
+#else
 	ldr_l	x1, handle_arch_irq
+#endif
 	mov	x0, sp
 	irq_stack_entry
 	blr	x1
@@ -629,12 +633,15 @@ ENDPROC(el1_sync)
 el1_irq:
 	kernel_entry 1
 	enable_dbg
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_off
-#endif
 
 	irq_handler
 
+#ifdef CONFIG_IPIPE
+	cbz     w0, 2f
+#endif
+#ifdef CONFIG_TRACE_IRQFLAGS
+	bl	trace_hardirqs_off
+#endif
 #ifdef CONFIG_PREEMPT
 	ldr	w24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
 	cbnz	w24, 1f				// preempt count != 0
@@ -644,15 +651,20 @@ el1_irq:
 1:
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on
+	bl	trace_hardirqs_on_virt
 #endif
+2:
 	kernel_exit 1
 ENDPROC(el1_irq)
 
 #ifdef CONFIG_PREEMPT
 el1_preempt:
 	mov	x24, lr
+#ifdef CONFIG_IPIPE
+1:	bl	__ipipe_preempt_schedule_irq
+#else
 1:	bl	preempt_schedule_irq		// irq en/disable is done inside
+#endif
 	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
 	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
 	ret	x24
@@ -858,10 +870,13 @@ el0_irq_naked:
 #endif
 	irq_handler
 
+#ifdef CONFIG_IPIPE
+	cbz	w0, work_done
+#endif	/* CONFIG_IPIPE */
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bl	trace_hardirqs_on
+	bl	trace_hardirqs_on_virt
 #endif
-	b	ret_to_user
+	b	ret_to_user_nocheck
 ENDPROC(el0_irq)
 
 /*
@@ -891,13 +906,23 @@ work_pending:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on		// enabled while in userspace
 #endif
+work_done:
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
 	b	finish_ret_to_user
 /*
  * "slow" syscall return path.
  */
 ret_to_user:
+#ifdef CONFIG_IPIPE
+	disable_irq
+	ldr	x0, [tsk, #TSK_TI_IPIPE]
+	tst	x0, #_TIP_HEAD
+	b.eq	ret_to_user_noirq
+	kernel_exit 0
+#endif
+ret_to_user_nocheck:
 	disable_irq				// disable interrupts
+ret_to_user_noirq:
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
@@ -1128,6 +1153,7 @@ NOKPROBE(cpu_switch_to)
  * This is how we return from a fork.
  */
 ENTRY(ret_from_fork)
+	enable_irq_cond
 	bl	schedule_tail
 	cbz	x19, 1f				// not a kernel thread
 	mov	x0, x20
diff --git a/arch/arm64/kernel/ipipe.c b/arch/arm64/kernel/ipipe.c
new file mode 100644
index 000000000000..9c0e5913905f
--- /dev/null
+++ b/arch/arm64/kernel/ipipe.c
@@ -0,0 +1,246 @@
+/* -*- linux-c -*-
+ * linux/arch/arm64/kernel/ipipe.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ * Copyright (C) 2004 Wolfgang Grandegger (Adeos/arm port over 2.4).
+ * Copyright (C) 2005 Heikki Lindholm (PowerPC 970 fixes).
+ * Copyright (C) 2005 Stelian Pop.
+ * Copyright (C) 2006-2008 Gilles Chanteperdrix.
+ * Copyright (C) 2010 Philippe Gerum (SMP port).
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Architecture-dependent I-PIPE support for ARM64.
+ */
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kallsyms.h>
+#include <linux/kprobes.h>
+#include <linux/ipipe_trace.h>
+#include <linux/irq.h>
+#include <linux/irqnr.h>
+#include <linux/prefetch.h>
+#include <linux/cpu.h>
+#include <linux/sched/debug.h>
+#include <linux/ipipe_domain.h>
+#include <linux/ipipe_tickdev.h>
+#include <asm/atomic.h>
+#include <asm/hardirq.h>
+#include <asm/io.h>
+#include <asm/unistd.h>
+#include <asm/mmu_context.h>
+#include <asm/exception.h>
+#include <asm/arch_timer.h>
+
+static void __ipipe_do_IRQ(unsigned irq, void *cookie);
+
+#ifdef CONFIG_IPIPE_DEBUG_INTERNAL
+void (*__ipipe_mach_hrtimer_debug)(unsigned irq);
+#endif
+
+#ifdef CONFIG_SMP
+
+void __ipipe_early_core_setup(void)
+{
+	__ipipe_mach_init_platform();
+}
+
+static inline void
+hook_internal_ipi(struct ipipe_domain *ipd, int virq,
+		  void (*handler)(unsigned int irq, void *cookie))
+{
+	ipd->irqs[virq].ackfn = NULL;
+	ipd->irqs[virq].handler = handler;
+	ipd->irqs[virq].cookie = NULL;
+	/* Immediately handle in the current domain but *never* pass */
+	ipd->irqs[virq].control = IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK;
+}
+
+void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd)
+{
+	__ipipe_ipis_alloc();
+	hook_internal_ipi(ipd, IPIPE_CRITICAL_IPI, __ipipe_do_critical_sync);
+}
+
+void ipipe_set_irq_affinity(unsigned int irq, cpumask_t cpumask)
+{
+	if (ipipe_virtual_irq_p(irq) ||
+	    irq_get_chip(irq)->irq_set_affinity == NULL)
+		return;
+
+	cpumask_and(&cpumask, &cpumask, cpu_online_mask);
+	if (WARN_ON_ONCE(cpumask_empty(&cpumask)))
+		return;
+
+	irq_get_chip(irq)->irq_set_affinity(irq_get_irq_data(irq), &cpumask, true);
+}
+EXPORT_SYMBOL_GPL(ipipe_set_irq_affinity);
+
+#endif	/* CONFIG_SMP */
+
+#ifdef CONFIG_SMP_ON_UP
+struct static_key __ipipe_smp_key = STATIC_KEY_INIT_TRUE;
+
+unsigned __ipipe_processor_id(void)
+{
+	return raw_smp_processor_id();
+}
+EXPORT_SYMBOL_GPL(__ipipe_processor_id);
+
+static int ipipe_disable_smp(void)
+{
+	if (num_online_cpus() == 1) {
+		unsigned long flags;
+
+		printk("I-pipe: disabling SMP code\n");
+
+		flags = hard_local_irq_save();
+		static_key_slow_dec(&__ipipe_smp_key);
+		hard_local_irq_restore(flags);
+	}
+	return 0;
+}
+arch_initcall(ipipe_disable_smp);
+#endif /* SMP_ON_UP */
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
+{
+	info->sys_nr_cpus = num_online_cpus();
+	info->sys_cpu_freq = __ipipe_hrclock_freq;
+	info->sys_hrtimer_irq = per_cpu(ipipe_percpu.hrtimer_irq, 0);
+	info->sys_hrtimer_freq = __ipipe_hrtimer_freq;
+	info->sys_hrclock_freq = __ipipe_hrclock_freq;
+	__ipipe_mach_get_tscinfo(&info->arch.tsc);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ipipe_get_sysinfo);
+
+/*
+ * __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
+ * interrupts are off, and secondary CPUs are still lost in space.
+ */
+void __ipipe_enable_pipeline(void)
+{
+	unsigned long flags;
+	unsigned int irq;
+
+	flags = ipipe_critical_enter(NULL);
+
+	/* virtualize all interrupts from the root domain. */
+	for (irq = 0; irq < IPIPE_NR_ROOT_IRQS; irq++)
+		ipipe_request_irq(ipipe_root_domain,
+				  irq,
+				  (ipipe_irq_handler_t)__ipipe_do_IRQ,
+				  NULL, NULL);
+
+#ifdef CONFIG_SMP
+	__ipipe_ipis_request();
+#endif /* CONFIG_SMP */
+
+	ipipe_critical_exit(flags);
+}
+
+void __ipipe_exit_irq(struct pt_regs *regs)
+{
+	/*
+	 * Testing for user_regs() eliminates foreign stack contexts,
+	 * including from legacy domains which did not set the foreign
+	 * stack bit (foreign stacks are always kernel-based).
+	 */
+	if (user_mode(regs) &&
+	    ipipe_test_thread_flag(TIP_MAYDAY)) {
+		/*
+		 * MAYDAY is never raised under normal circumstances,
+		 * so prefer test then maybe clear over
+		 * test_and_clear.
+		 */
+		ipipe_clear_thread_flag(TIP_MAYDAY);
+		__ipipe_notify_trap(IPIPE_TRAP_MAYDAY, regs);
+	}
+}
+
+/* hw irqs off */
+asmlinkage void __exception __ipipe_grab_irq(int irq, struct pt_regs *regs)
+{
+	struct ipipe_percpu_data *p = __ipipe_raw_cpu_ptr(&ipipe_percpu);
+
+	ipipe_trace_irq_entry(irq);
+
+	if (p->hrtimer_irq == -1)
+		goto copy_regs;
+
+	if (irq == p->hrtimer_irq) {
+		/*
+		 * Given our deferred dispatching model for regular IRQs, we
+		 * only record CPU regs for the last timer interrupt, so that
+		 * the timer handler charges CPU times properly. It is assumed
+		 * that other interrupt handlers don't actually care for such
+		 * information.
+		 */
+#ifdef CONFIG_IPIPE_DEBUG_INTERNAL
+		if (__ipipe_mach_hrtimer_debug)
+			__ipipe_mach_hrtimer_debug(irq);
+#endif /* CONFIG_IPIPE_DEBUG_INTERNAL */
+	  copy_regs:
+		p->tick_regs.pstate =
+			(p->curr == &p->root
+			 ? regs->pstate
+			 : regs->pstate | PSR_I_BIT);
+		p->tick_regs.pc = regs->pc;
+	}
+
+	__ipipe_dispatch_irq(irq, 0);
+
+	ipipe_trace_irq_exit(irq);
+
+	__ipipe_exit_irq(regs);
+}
+
+static void __ipipe_do_IRQ(unsigned irq, void *cookie)
+{
+	struct pt_regs *regs = raw_cpu_ptr(&ipipe_percpu.tick_regs);
+	__handle_domain_irq(NULL, irq, false, regs);
+}
+
+static struct __ipipe_tscinfo tsc_info;
+
+void __init __ipipe_tsc_register(struct __ipipe_tscinfo *info)
+{
+	tsc_info = *info;
+	__ipipe_hrclock_freq = info->freq;
+}
+
+void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
+{
+	*info = tsc_info;
+}
+
+EXPORT_SYMBOL_GPL(do_munmap);
+EXPORT_SYMBOL_GPL(show_stack);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+EXPORT_SYMBOL_GPL(tasklist_lock);
+#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
+
+#ifndef CONFIG_SPARSE_IRQ
+EXPORT_SYMBOL_GPL(irq_desc);
+#endif
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 713561e5bcab..865b5e147930 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -43,6 +43,16 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 void (*handle_arch_irq)(struct pt_regs *) = NULL;
 
+#ifdef CONFIG_IPIPE
+
+asmlinkage int handle_arch_irq_pipelined(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+	return __ipipe_root_p && !irqs_disabled();
+}
+
+#endif
+
 void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
 	if (handle_arch_irq)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 9e773732520c..e958102fc69b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -73,6 +73,36 @@ EXPORT_SYMBOL_GPL(pm_power_off);
 
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 
+#ifdef CONFIG_IPIPE
+static void __ipipe_halt_root(void)
+{
+	struct ipipe_percpu_domain_data *p;
+
+	/*
+	 * Emulate idle entry sequence over the root domain, which is
+	 * stalled on entry.
+	 */
+	hard_local_irq_disable();
+
+	p = ipipe_this_cpu_root_context();
+	__clear_bit(IPIPE_STALL_FLAG, &p->status);
+
+	if (unlikely(__ipipe_ipending_p(p)))
+		__ipipe_sync_stage();
+	else {
+		cpu_do_idle();
+	}
+}
+
+#else /* !CONFIG_IPIPE */
+
+static void __ipipe_halt_root(void)
+{
+	cpu_do_idle();
+}
+
+#endif /* !CONFIG_IPIPE */
+
 /*
  * This is our default idle handler.
  */
@@ -83,6 +113,8 @@ void arch_cpu_idle(void)
 	 * tricks
 	 */
 	trace_cpu_idle_rcuidle(1, smp_processor_id());
+	if (!need_resched())
+		__ipipe_halt_root();
 	cpu_do_idle();
 	local_irq_enable();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 43442b3a463f..083daf9a63a2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -745,6 +745,8 @@ static void do_signal(struct pt_regs *regs)
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned int thread_flags)
 {
+	bool stalled = irqs_disabled();
+
 	/*
 	 * The assembly code enters us with IRQs off, but it hasn't
 	 * informed the tracing code of that for efficiency reasons.
@@ -757,9 +759,13 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		addr_limit_user_check();
 
 		if (thread_flags & _TIF_NEED_RESCHED) {
+			if (IS_ENABLED(CONFIG_IPIPE)) {
+				local_irq_disable();
+				hard_local_irq_enable();
+			}
 			schedule();
 		} else {
-			local_irq_enable();
+			local_irq_enable(); /* also hard enables IRQs */
 
 			if (thread_flags & _TIF_UPROBE)
 				uprobe_notify_resume(regs);
@@ -776,7 +782,10 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 				fpsimd_restore_current_state();
 		}
 
-		local_irq_disable();
+		hard_local_irq_disable();
 		thread_flags = READ_ONCE(current_thread_info()->flags);
 	} while (thread_flags & _TIF_WORK_MASK);
+
+	if (IS_ENABLED(CONFIG_IPIPE) && stalled)
+		local_irq_disable();
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b7ad41d7b6ee..89f1403140df 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -57,6 +57,8 @@
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
 #include <asm/virt.h>
+#include <asm/exception.h>
+#include <asm/ipipe.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ipi.h>
@@ -80,7 +82,7 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
 };
 
 #ifdef CONFIG_ARM64_VHE
@@ -774,12 +776,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
-
 void show_ipi_list(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
@@ -805,6 +801,127 @@ u64 smp_irq_stat_cpu(unsigned int cpu)
 	return sum;
 }
 
+#ifdef CONFIG_IPIPE
+
+static DEFINE_PER_CPU(unsigned long, ipi_messages);
+
+#define noipipe_irq_enter()			\
+	do {					\
+	} while (0)
+#define noipipe_irq_exit()			\
+	do {					\
+	} while (0)
+
+
+static void  __ipipe_do_IPI(unsigned int virq, void *cookie)
+{
+	unsigned int ipinr = virq - IPIPE_IPI_BASE;
+
+	handle_IPI(ipinr, raw_cpu_ptr(&ipipe_percpu.tick_regs));
+}
+
+void __ipipe_ipis_alloc(void)
+{
+	unsigned int virq, ipi;
+	static bool done;
+
+	if (done)
+		return;
+
+	/*
+	 * We have to get virtual IRQs in the range
+	 * [ IPIPE_IPI_BASE..IPIPE_IPI_BASE + NR_IPI + IPIPE_OOB_IPI_NR - 1 ],
+	 * otherwise something is wrong (likely someone would have
+	 * allocated virqs before we do, and this would break our
+	 * fixed numbering scheme for IPIs).
+	 */
+	for (ipi = 0; ipi < NR_IPI + IPIPE_OOB_IPI_NR; ipi++) {
+		virq = ipipe_alloc_virq();
+		WARN_ON_ONCE(virq != IPIPE_IPI_BASE + ipi);
+	}
+
+	done = true;
+}
+
+void __ipipe_ipis_request(void)
+{
+	unsigned int virq;
+
+	/*
+	 * Attach a handler to each VIRQ mapping an IPI which might be
+	 * posted by __ipipe_grab_ipi(). This handler will invoke
+	 * handle_IPI() from the root stage in turn, passing it the
+	 * corresponding IPI message number.
+	 */
+	for (virq = IPIPE_IPI_BASE;
+	     virq < IPIPE_IPI_BASE + NR_IPI + IPIPE_OOB_IPI_NR; virq++)
+		ipipe_request_irq(ipipe_root_domain,
+				  virq,
+				  (ipipe_irq_handler_t)__ipipe_do_IPI,
+				  NULL, NULL);
+}
+
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
+{
+	unsigned int cpu, sgi;
+
+	if (ipinr < NR_IPI) {
+		/* regular in-band IPI (multiplexed over SGI0). */
+		trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+		for_each_cpu(cpu, target)
+			set_bit(ipinr, &per_cpu(ipi_messages, cpu));
+		smp_mb();
+		sgi = 0;
+	} else  /* out-of-band IPI (SGI1-3). */
+		sgi = ipinr - NR_IPI + 1;
+
+	__smp_cross_call(target, sgi);
+}
+
+void ipipe_send_ipi(unsigned int ipi, cpumask_t cpumask)
+{
+	unsigned int ipinr = ipi - IPIPE_IPI_BASE;
+
+	smp_cross_call(&cpumask, ipinr);
+}
+EXPORT_SYMBOL_GPL(ipipe_send_ipi);
+
+ /* hw IRQs off */
+asmlinkage void __ipipe_grab_ipi(unsigned int sgi, struct pt_regs *regs)
+{
+	unsigned int ipinr, irq;
+	unsigned long *pmsg;
+
+	if (sgi) {		/* SGI1-3, OOB messages. */
+		irq = sgi + NR_IPI - 1 + IPIPE_IPI_BASE;
+		__ipipe_dispatch_irq(irq, IPIPE_IRQF_NOACK);
+	} else {
+		/* In-band IPI (0..NR_IPI-1) multiplexed over SGI0. */
+		pmsg = raw_cpu_ptr(&ipi_messages);
+		while (*pmsg) {
+			ipinr = ffs(*pmsg) - 1;
+			clear_bit(ipinr, pmsg);
+			irq = IPIPE_IPI_BASE + ipinr;
+			__ipipe_dispatch_irq(irq, IPIPE_IRQF_NOACK);
+		}
+	}
+
+	__ipipe_exit_irq(regs);
+}
+
+#else
+
+#define noipipe_irq_enter()	irq_enter()
+#define noipipe_irq_exit()	irq_exit()
+
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
+{
+	trace_ipi_raise(target, ipi_types[ipinr]);
+	__smp_cross_call(target, ipinr);
+}
+
+#endif /* CONFIG_IPIPE */
+
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_CALL_FUNC);
@@ -885,15 +1002,15 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
+		noipipe_irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
+		noipipe_irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
+		noipipe_irq_enter();
 		ipi_cpu_stop(cpu);
-		irq_exit();
+		noipipe_irq_exit();
 		break;
 
 	case IPI_CPU_CRASH_STOP:
@@ -907,17 +1024,20 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
+		noipipe_irq_enter();
+#ifdef CONFIG_IPIPE
+		__ipipe_mach_update_tsc();
+#endif
 		tick_receive_broadcast();
-		irq_exit();
+		noipipe_irq_exit();
 		break;
 #endif
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
+		noipipe_irq_enter();
 		irq_work_run();
-		irq_exit();
+		noipipe_irq_exit();
 		break;
 #endif
 
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 9284788733d6..df73eda70f72 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -28,7 +28,7 @@
 #include <asm/tlbflush.h>
 
 static u32 asid_bits;
-static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
+static IPIPE_DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 
 static atomic64_t asid_generation;
 static unsigned long *asid_map;
-- 
2.14.4


