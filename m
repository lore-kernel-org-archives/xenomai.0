From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <1132841651.27409.1.camel@domain.hid>
References: <1132841651.27409.1.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 15:17:14 +0100
Message-Id: <1132841834.27409.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 1/2] Adeos ARM/2.6 support - generic code
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

This is the "generic" (not arch specific) part of the ARM I-Pipe patch.

It was ripped off adeos-ipipe-2.6.14-ppc-1.0-06.patch (downloadable at
http://download.gna.org/adeos/patches/v2.6/adeos/ppc/adeos-ipipe-2.6.14-ppc-1.0-06.patch).

Signed-off-by: Stelian Pop <stelian@domain.hid>
---

 include/linux/hardirq.h |   13 
 include/linux/ipipe.h   |  748 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/preempt.h |   59 ++-
 include/linux/sched.h   |    4 
 init/Kconfig            |    1 
 init/main.c             |    9 
 kernel/Makefile         |    1 
 kernel/exit.c           |    1 
 kernel/fork.c           |    8 
 kernel/ipipe/Kconfig    |   18 +
 kernel/ipipe/Makefile   |    2 
 kernel/ipipe/core.c     |  678 +++++++++++++++++++++++++++++++++++++++++++
 kernel/ipipe/generic.c  |  390 +++++++++++++++++++++++++
 kernel/irq/handle.c     |   15 
 kernel/printk.c         |   61 +++
 kernel/sched.c          |   58 +++
 kernel/signal.c         |    1 
 lib/smp_processor_id.c  |    5 
 lib/spinlock_debug.c    |   19 +
 mm/vmalloc.c            |    5 
 20 files changed, 2074 insertions(+), 22 deletions(-)

diff -uNrp 2.6.14/include/linux/hardirq.h 2.6.14-ipipe/include/linux/hardirq.h
--- 2.6.14/include/linux/hardirq.h	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/include/linux/hardirq.h	2005-10-31 10:15:18.000000000 +0100
@@ -87,8 +87,21 @@ extern void synchronize_irq(unsigned int
 # define synchronize_irq(irq)	barrier()
 #endif
 
+#ifdef CONFIG_IPIPE
+#define nmi_enter() \
+do { \
+    if (ipipe_current_domain == ipipe_root_domain) \
+	irq_enter(); \
+} while(0)
+#define nmi_exit() \
+do { \
+    if (ipipe_current_domain == ipipe_root_domain) \
+	sub_preempt_count(HARDIRQ_OFFSET); \
+} while(0)
+#else /* !CONFIG_IPIPE */
 #define nmi_enter()		irq_enter()
 #define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
+#endif /* CONFIG_IPIPE */
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING
 static inline void account_user_vtime(struct task_struct *tsk)
diff -uNrp 2.6.14/include/linux/ipipe.h 2.6.14-ipipe/include/linux/ipipe.h
--- 2.6.14/include/linux/ipipe.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.14-ipipe/include/linux/ipipe.h	2005-11-02 15:24:34.000000000 +0100
@@ -0,0 +1,748 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe.h
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
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
+#ifndef __LINUX_IPIPE_H
+#define __LINUX_IPIPE_H
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <asm/ipipe.h>
+
+#ifdef CONFIG_IPIPE
+
+#define IPIPE_VERSION_STRING	IPIPE_ARCH_STRING
+#define IPIPE_RELEASE_NUMBER	((IPIPE_MAJOR_NUMBER << 16) | \
+				 (IPIPE_MINOR_NUMBER <<  8) | \
+				 (IPIPE_PATCH_NUMBER))
+
+#define IPIPE_ROOT_PRIO		100
+#define IPIPE_ROOT_ID		0
+#define IPIPE_ROOT_NPTDKEYS	4	/* Must be <= BITS_PER_LONG */
+
+#define IPIPE_RESET_TIMER	0x1
+#define IPIPE_GRAB_TIMER	0x2
+#define IPIPE_SAME_HANDLER	((void (*)(unsigned))(-1))
+
+/* Global domain flags */
+#define IPIPE_SPRINTK_FLAG	0	/* Synchronous printk() allowed */
+#define IPIPE_PPRINTK_FLAG	1	/* Asynchronous printk() request pending */
+
+#define IPIPE_STALL_FLAG	0	/* Stalls a pipeline stage */
+#define IPIPE_SYNC_FLAG		1	/* The interrupt syncer is running for the domain */
+
+#define IPIPE_HANDLE_FLAG	0
+#define IPIPE_PASS_FLAG		1
+#define IPIPE_ENABLE_FLAG	2
+#define IPIPE_DYNAMIC_FLAG	IPIPE_HANDLE_FLAG
+#define IPIPE_STICKY_FLAG	3
+#define IPIPE_SYSTEM_FLAG	4
+#define IPIPE_LOCK_FLAG		5
+#define IPIPE_SHARED_FLAG	6
+#define IPIPE_EXCLUSIVE_FLAG	31	/* ipipe_catch_event() is the reason why. */
+
+#define IPIPE_HANDLE_MASK	(1 << IPIPE_HANDLE_FLAG)
+#define IPIPE_PASS_MASK		(1 << IPIPE_PASS_FLAG)
+#define IPIPE_ENABLE_MASK	(1 << IPIPE_ENABLE_FLAG)
+#define IPIPE_DYNAMIC_MASK	IPIPE_HANDLE_MASK
+#define IPIPE_EXCLUSIVE_MASK	(1 << IPIPE_EXCLUSIVE_FLAG)
+#define IPIPE_STICKY_MASK	(1 << IPIPE_STICKY_FLAG)
+#define IPIPE_SYSTEM_MASK	(1 << IPIPE_SYSTEM_FLAG)
+#define IPIPE_LOCK_MASK		(1 << IPIPE_LOCK_FLAG)
+#define IPIPE_SHARED_MASK	(1 << IPIPE_SHARED_FLAG)
+#define IPIPE_SYNC_MASK		(1 << IPIPE_SYNC_FLAG)
+
+#define IPIPE_DEFAULT_MASK	(IPIPE_HANDLE_MASK|IPIPE_PASS_MASK)
+#define IPIPE_STDROOT_MASK	(IPIPE_HANDLE_MASK|IPIPE_PASS_MASK|IPIPE_SYSTEM_MASK)
+
+/* Number of virtual IRQs */
+#define IPIPE_NR_VIRQS		BITS_PER_LONG
+/* First virtual IRQ # */
+#define IPIPE_VIRQ_BASE		(((IPIPE_NR_XIRQS + BITS_PER_LONG - 1) / BITS_PER_LONG) * BITS_PER_LONG)
+/* Total number of IRQ slots */
+#define IPIPE_NR_IRQS		(IPIPE_VIRQ_BASE + IPIPE_NR_VIRQS)
+/* Number of indirect words needed to map the whole IRQ space. */
+#define IPIPE_IRQ_IWORDS	((IPIPE_NR_IRQS + BITS_PER_LONG - 1) / BITS_PER_LONG)
+#define IPIPE_IRQ_IMASK		(BITS_PER_LONG - 1)
+#define IPIPE_IRQMASK_ANY	(~0L)
+#define IPIPE_IRQMASK_VIRT	(IPIPE_IRQMASK_ANY << (IPIPE_VIRQ_BASE / BITS_PER_LONG))
+
+#ifdef CONFIG_SMP
+
+#define IPIPE_NR_CPUS		NR_CPUS
+#define ipipe_declare_cpuid	int cpuid
+#define ipipe_load_cpuid()	do { \
+					(cpuid) = ipipe_processor_id();	\
+				} while(0)
+#define ipipe_lock_cpu(flags)	do { \
+					local_irq_save_hw(flags); \
+					(cpuid) = ipipe_processor_id(); \
+				} while(0)
+#define ipipe_unlock_cpu(flags)	local_irq_restore_hw(flags)
+#define ipipe_get_cpu(flags)	ipipe_lock_cpu(flags)
+#define ipipe_put_cpu(flags)	ipipe_unlock_cpu(flags)
+#define ipipe_current_domain	(ipipe_percpu_domain[ipipe_processor_id()])
+
+#else /* !CONFIG_SMP */
+
+#define IPIPE_NR_CPUS		1
+#define ipipe_declare_cpuid	const int cpuid = 0
+#define ipipe_load_cpuid()	do { } while(0)
+#define ipipe_lock_cpu(flags)	local_irq_save_hw(flags)
+#define ipipe_unlock_cpu(flags)	local_irq_restore_hw(flags)
+#define ipipe_get_cpu(flags)	do { flags = 0; } while(0)
+#define ipipe_put_cpu(flags)	do { } while(0)
+#define ipipe_current_domain	(ipipe_percpu_domain[0])
+
+#endif /* CONFIG_SMP */
+
+#define ipipe_virtual_irq_p(irq)	((irq) >= IPIPE_VIRQ_BASE && \
+					 (irq) < IPIPE_NR_IRQS)
+
+struct ipipe_domain {
+
+	struct list_head p_link;	/* Link in pipeline */
+
+	struct ipcpudata {
+		unsigned long status;
+		unsigned long irq_pending_hi;
+		unsigned long irq_pending_lo[IPIPE_IRQ_IWORDS];
+		unsigned long irq_hits[IPIPE_NR_IRQS];
+	} cpudata[IPIPE_NR_CPUS];
+
+	struct {
+		int (*acknowledge) (unsigned irq);
+		void (*handler) (unsigned irq);
+		unsigned long control;
+	} irqs[IPIPE_NR_IRQS];
+
+	int (*evhand[IPIPE_NR_EVENTS])(unsigned event,
+				       struct ipipe_domain *from,
+				       void *data); /* Event handlers. */
+	unsigned long evexcl;	/* Exclusive event bits. */
+
+#ifdef CONFIG_IPIPE_STATS
+	struct ipipe_stats { /* All in timebase units. */
+		unsigned long long last_stall_date;
+		unsigned long last_stall_eip;
+		unsigned long max_stall_time;
+		unsigned long max_stall_eip;
+		struct ipipe_irq_stats {
+			unsigned long long last_receipt_date;
+			unsigned long max_delivery_time;
+		} irq_stats[IPIPE_NR_IRQS];
+	} stats[IPIPE_NR_CPUS];
+#endif /* CONFIG_IPIPE_STATS */
+	unsigned long flags;
+	unsigned domid;
+	const char *name;
+	int priority;
+	void *pdd;
+};
+
+struct ipipe_domain_attr {
+
+	unsigned domid;		/* Domain identifier -- Magic value set by caller */
+	const char *name;	/* Domain name -- Warning: won't be dup'ed! */
+	int priority;		/* Priority in interrupt pipeline */
+	void (*entry) (void);	/* Domain entry point */
+	void *pdd;		/* Per-domain (opaque) data pointer */
+};
+
+/* The following macros must be used hw interrupts off. */
+
+#define __ipipe_set_irq_bit(ipd,cpuid,irq) \
+do { \
+	if (!test_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) { \
+		__set_bit(irq & IPIPE_IRQ_IMASK,&(ipd)->cpudata[cpuid].irq_pending_lo[irq >> IPIPE_IRQ_ISHIFT]); \
+		__set_bit(irq >> IPIPE_IRQ_ISHIFT,&(ipd)->cpudata[cpuid].irq_pending_hi); \
+	} \
+} while(0)
+
+#define __ipipe_clear_pend(ipd,cpuid,irq) \
+do { \
+	__clear_bit(irq & IPIPE_IRQ_IMASK,&(ipd)->cpudata[cpuid].irq_pending_lo[irq >> IPIPE_IRQ_ISHIFT]); \
+	if ((ipd)->cpudata[cpuid].irq_pending_lo[irq >> IPIPE_IRQ_ISHIFT] == 0) \
+		__clear_bit(irq >> IPIPE_IRQ_ISHIFT,&(ipd)->cpudata[cpuid].irq_pending_hi); \
+} while(0)
+
+#define __ipipe_lock_irq(ipd,cpuid,irq) \
+do { \
+	if (!test_and_set_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) \
+		__ipipe_clear_pend(ipd,cpuid,irq); \
+} while(0)
+
+#define __ipipe_unlock_irq(ipd,irq) \
+do { \
+	int __cpuid, __nr_cpus = num_online_cpus(); \
+	if (test_and_clear_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) \
+		for (__cpuid = 0; __cpuid < __nr_cpus; __cpuid++) \
+			if ((ipd)->cpudata[__cpuid].irq_hits[irq] > 0) { /* We need atomic ops next. */ \
+				set_bit(irq & IPIPE_IRQ_IMASK,&(ipd)->cpudata[__cpuid].irq_pending_lo[irq >> IPIPE_IRQ_ISHIFT]); \
+				set_bit(irq >> IPIPE_IRQ_ISHIFT,&(ipd)->cpudata[__cpuid].irq_pending_hi); \
+			} \
+} while(0)
+
+#define __ipipe_clear_irq(ipd,irq) \
+do { \
+	int __cpuid, __nr_cpus = num_online_cpus(); \
+	clear_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control); \
+	for (__cpuid = 0; __cpuid < __nr_cpus; __cpuid++) { \
+		(ipd)->cpudata[__cpuid].irq_hits[irq] = 0; \
+		__ipipe_clear_pend(ipd,__cpuid,irq); \
+	} \
+} while(0)
+
+#ifdef __RAW_SPIN_LOCK_UNLOCKED
+#define spin_lock_hw(x)			_raw_spin_lock(x)
+#define spin_unlock_hw(x)		_raw_spin_unlock(x)
+#define spin_trylock_hw(x)		_raw_spin_trylock(x)
+#define write_lock_hw(x)		_raw_write_lock(x)
+#define write_unlock_hw(x)		_raw_write_unlock(x)
+#define write_trylock_hw(x)		_raw_write_trylock(x)
+#define read_lock_hw(x)			_raw_read_lock(x)
+#define read_unlock_hw(x)		_raw_read_unlock(x)
+#else	/* !__RAW_SPIN_LOCK_UNLOCKED */
+#define spin_lock_hw(x)			_spin_lock(x)
+#define spin_unlock_hw(x)		_spin_unlock(x)
+#define spin_trylock_hw(x)		_spin_trylock(x)
+#define write_lock_hw(x)		_write_lock(x)
+#define write_unlock_hw(x)		_write_unlock(x)
+#define write_trylock_hw(x)		_write_trylock(x)
+#define read_lock_hw(x)			_read_lock(x)
+#define read_unlock_hw(x)		_read_unlock(x)
+#endif	/* __RAW_SPIN_LOCK_UNLOCKED */
+
+typedef spinlock_t			ipipe_spinlock_t;
+typedef rwlock_t			ipipe_rwlock_t;
+#define IPIPE_SPIN_LOCK_UNLOCKED	SPIN_LOCK_UNLOCKED
+#define IPIPE_RW_LOCK_UNLOCKED		RW_LOCK_UNLOCKED
+
+#define spin_lock_irqsave_hw(x,flags)		\
+do {						\
+	local_irq_save_hw(flags);		\
+	spin_lock_hw(x);			\
+} while (0)
+
+#define spin_unlock_irqrestore_hw(x,flags)	\
+do {						\
+	spin_unlock_hw(x);			\
+	local_irq_restore_hw(flags);		\
+} while (0)
+
+#define spin_lock_irq_hw(x)			\
+do {						\
+	local_irq_disable_hw();			\
+	spin_lock_hw(x);			\
+} while (0)
+
+#define spin_unlock_irq_hw(x)			\
+do {						\
+	spin_unlock_hw(x);			\
+	local_irq_enable_hw();			\
+} while (0)
+
+#define read_lock_irqsave_hw(lock, flags)	\
+do {						\
+	local_irq_save_hw(flags);		\
+	read_lock_hw(lock);			\
+} while (0)
+
+#define read_unlock_irqrestore_hw(lock, flags)	\
+do {						\
+	read_unlock_hw(lock);			\
+	local_irq_restore_hw(flags);		\
+} while (0)
+
+#define write_lock_irqsave_hw(lock, flags)	\
+do {						\
+	local_irq_save_hw(flags);		\
+	write_lock_hw(lock);			\
+} while (0)
+
+#define write_unlock_irqrestore_hw(lock, flags)	\
+do {						\
+	write_unlock_hw(lock);			\
+	local_irq_restore_hw(flags);		\
+} while (0)
+
+extern struct ipipe_domain *ipipe_percpu_domain[], *ipipe_root_domain;
+
+extern unsigned __ipipe_printk_virq;
+
+extern unsigned long __ipipe_virtual_irq_map;
+
+extern struct list_head __ipipe_pipeline;
+
+extern ipipe_spinlock_t __ipipe_pipelock;
+
+extern int __ipipe_event_monitors[];
+
+/* Private interface */
+
+void ipipe_init(void);
+
+#ifdef CONFIG_PROC_FS
+void ipipe_init_proc(void);
+#else	/* !CONFIG_PROC_FS */
+#define ipipe_init_proc()	do { } while(0)
+#endif	/* CONFIG_PROC_FS */
+
+void __ipipe_init_stage(struct ipipe_domain *ipd);
+
+void __ipipe_cleanup_domain(struct ipipe_domain *ipd);
+
+void __ipipe_add_domain_proc(struct ipipe_domain *ipd);
+
+void __ipipe_remove_domain_proc(struct ipipe_domain *ipd);
+
+void __ipipe_flush_printk(unsigned irq);
+
+void __ipipe_stall_root(void);
+
+void __ipipe_unstall_root(void);
+
+unsigned long __ipipe_test_root(void);
+
+unsigned long __ipipe_test_and_stall_root(void);
+
+void fastcall __ipipe_restore_root(unsigned long flags);
+
+int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);
+
+int fastcall __ipipe_dispatch_event(unsigned event, void *data);
+
+#define __ipipe_pipeline_head_p(ipd) (&(ipd)->p_link == __ipipe_pipeline.next)
+
+#ifdef CONFIG_SMP
+
+cpumask_t __ipipe_set_irq_affinity(unsigned irq,
+				   cpumask_t cpumask);
+
+int fastcall __ipipe_send_ipi(unsigned ipi,
+			      cpumask_t cpumask);
+
+#endif /* CONFIG_SMP */
+
+/* Called with hw interrupts off. */
+static inline void __ipipe_switch_to(struct ipipe_domain *out,
+				     struct ipipe_domain *in, int cpuid)
+{
+	void ipipe_suspend_domain(void);
+
+	/*
+	 * "in" is guaranteed to be closer than "out" from the head of the
+	 * pipeline (and obviously different).
+	 */
+
+	ipipe_percpu_domain[cpuid] = in;
+
+	ipipe_suspend_domain();	/* Sync stage and propagate interrupts. */
+	ipipe_load_cpuid();	/* Processor might have changed. */
+
+	if (ipipe_percpu_domain[cpuid] == in)
+		/*
+		 * Otherwise, something has changed the current domain under
+		 * our feet recycling the register set; do not override.
+		 */
+		ipipe_percpu_domain[cpuid] = out;
+}
+
+static inline void ipipe_sigwake_notify(struct task_struct *p)
+{
+	if (__ipipe_event_monitors[IPIPE_EVENT_SIGWAKE] > 0)
+		__ipipe_dispatch_event(IPIPE_EVENT_SIGWAKE,p);
+}
+
+static inline void ipipe_setsched_notify(struct task_struct *p)
+{
+	if (__ipipe_event_monitors[IPIPE_EVENT_SETSCHED] > 0)
+		__ipipe_dispatch_event(IPIPE_EVENT_SETSCHED,p);
+}
+
+static inline void ipipe_exit_notify(struct task_struct *p)
+{
+	if (__ipipe_event_monitors[IPIPE_EVENT_EXIT] > 0)
+		__ipipe_dispatch_event(IPIPE_EVENT_EXIT,p);
+}
+
+static inline int ipipe_trap_notify(int ex, struct pt_regs *regs)
+{
+	return __ipipe_event_monitors[ex] ? __ipipe_dispatch_event(ex,regs) : 0;
+}
+
+#ifdef CONFIG_IPIPE_STATS
+
+#define ipipe_mark_domain_stall(ipd, cpuid)			\
+do {								\
+	__label__ here;						\
+	struct ipipe_stats *ips;				\
+here:								\
+	ips = (ipd)->stats + cpuid;				\
+	if (ips->last_stall_date == 0) {			\
+		ipipe_read_tsc(ips->last_stall_date);		\
+		ips->last_stall_eip = (unsigned long)&&here;	\
+	}							\
+} while(0)
+
+static inline void ipipe_mark_domain_unstall(struct ipipe_domain *ipd, int cpuid)
+{ /* Called w/ hw interrupts off. */
+	struct ipipe_stats *ips = ipd->stats + cpuid;
+	unsigned long long t, d;
+
+	if (ips->last_stall_date != 0) {
+		ipipe_read_tsc(t);
+		d = t - ips->last_stall_date;
+		if (d > ips->max_stall_time) {
+			ips->max_stall_time = d;
+			ips->max_stall_eip = ips->last_stall_eip;
+		}
+		ips->last_stall_date = 0;
+	}
+}
+
+static inline void ipipe_mark_irq_receipt(struct ipipe_domain *ipd, unsigned irq, int cpuid)
+{
+	struct ipipe_stats *ips = ipd->stats + cpuid;
+
+	if (ips->irq_stats[irq].last_receipt_date == 0) {
+		ipipe_read_tsc(ips->irq_stats[irq].last_receipt_date);
+	}
+}
+
+static inline void ipipe_mark_irq_delivery(struct ipipe_domain *ipd, unsigned irq, int cpuid)
+{ /* Called w/ hw interrupts off. */
+	struct ipipe_stats *ips = ipd->stats + cpuid;
+	unsigned long long t, d;
+
+	if (ips->irq_stats[irq].last_receipt_date != 0) {
+		ipipe_read_tsc(t);
+		d = t - ips->irq_stats[irq].last_receipt_date;
+		ips->irq_stats[irq].last_receipt_date = 0;
+		if (d > ips->irq_stats[irq].max_delivery_time)
+			ips->irq_stats[irq].max_delivery_time = d;
+	}
+}
+
+static inline void ipipe_reset_stats (void)
+{
+	int cpu, irq;
+	for_each_online_cpu(cpu) {
+		ipipe_root_domain->stats[cpu].last_stall_date = 0LL;
+		for (irq = 0; irq < IPIPE_NR_IRQS; irq++)
+			ipipe_root_domain->stats[cpu].irq_stats[irq].last_receipt_date = 0LL;
+	}
+}
+
+#else /* !CONFIG_IPIPE_STATS */
+
+#define ipipe_mark_domain_stall(ipd,cpuid)	do { } while(0)
+#define ipipe_mark_domain_unstall(ipd,cpuid)	do { } while(0)
+#define ipipe_mark_irq_receipt(ipd,irq,cpuid)	do { } while(0)
+#define ipipe_mark_irq_delivery(ipd,irq,cpuid)	do { } while(0)
+#define ipipe_reset_stats()			do { } while(0)
+
+#endif /* CONFIG_IPIPE_STATS */
+
+/* Public interface */
+
+int ipipe_register_domain(struct ipipe_domain *ipd,
+			  struct ipipe_domain_attr *attr);
+
+int ipipe_unregister_domain(struct ipipe_domain *ipd);
+
+void ipipe_suspend_domain(void);
+
+int ipipe_virtualize_irq(struct ipipe_domain *ipd,
+			 unsigned irq,
+			 void (*handler) (unsigned irq),
+			 int (*acknowledge) (unsigned irq),
+			 unsigned modemask);
+
+static inline int ipipe_share_irq(unsigned irq,
+				  int (*acknowledge) (unsigned irq))
+{
+	return ipipe_virtualize_irq(ipipe_current_domain,
+				    irq,
+				    IPIPE_SAME_HANDLER,
+				    acknowledge,
+				    IPIPE_SHARED_MASK | IPIPE_HANDLE_MASK |
+				    IPIPE_PASS_MASK);
+}
+
+int ipipe_control_irq(unsigned irq,
+		      unsigned clrmask,
+		      unsigned setmask);
+
+unsigned ipipe_alloc_virq(void);
+
+int ipipe_free_virq(unsigned virq);
+
+int fastcall ipipe_trigger_irq(unsigned irq);
+
+static inline int ipipe_propagate_irq(unsigned irq)
+{
+
+	return __ipipe_schedule_irq(irq, ipipe_current_domain->p_link.next);
+}
+
+static inline int ipipe_schedule_irq(unsigned irq)
+{
+
+	return __ipipe_schedule_irq(irq, &ipipe_current_domain->p_link);
+}
+
+static inline void ipipe_stall_pipeline_from(struct ipipe_domain *ipd)
+{
+	ipipe_declare_cpuid;
+#ifdef CONFIG_SMP
+	unsigned long flags;
+
+	ipipe_lock_cpu(flags); /* Care for migration. */
+
+	__set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_mark_domain_stall(ipd, cpuid);
+
+	if (!__ipipe_pipeline_head_p(ipd))
+		ipipe_unlock_cpu(flags);
+#else	/* CONFIG_SMP */
+	set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_mark_domain_stall(ipd, cpuid);
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_disable_hw();
+#endif	/* CONFIG_SMP */
+}
+
+static inline unsigned long ipipe_test_pipeline_from(struct ipipe_domain *ipd)
+{
+	unsigned long flags, s;
+	ipipe_declare_cpuid;
+
+	ipipe_get_cpu(flags);
+	s = test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_put_cpu(flags);
+
+	return s;
+}
+
+static inline unsigned long ipipe_test_and_stall_pipeline_from(struct
+							       ipipe_domain
+							       *ipd)
+{
+	ipipe_declare_cpuid;
+	unsigned long s;
+#ifdef CONFIG_SMP
+	unsigned long flags;
+
+	ipipe_lock_cpu(flags); /* Care for migration. */
+
+	s = __test_and_set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_mark_domain_stall(ipd, cpuid);
+
+	if (!__ipipe_pipeline_head_p(ipd))
+		ipipe_unlock_cpu(flags);
+#else	/* CONFIG_SMP */
+	s = test_and_set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_mark_domain_stall(ipd, cpuid);
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_disable_hw();
+#endif	/* CONFIG_SMP */
+
+	return s;
+}
+
+void fastcall ipipe_unstall_pipeline_from(struct ipipe_domain *ipd);
+
+static inline unsigned long ipipe_test_and_unstall_pipeline_from(struct
+								 ipipe_domain
+								 *ipd)
+{
+	unsigned long flags, s;
+	ipipe_declare_cpuid;
+
+	ipipe_get_cpu(flags);
+	s = test_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+	ipipe_unstall_pipeline_from(ipd);
+	ipipe_put_cpu(flags);
+
+	return s;
+}
+
+static inline void ipipe_unstall_pipeline(void)
+{
+	ipipe_unstall_pipeline_from(ipipe_current_domain);
+}
+
+static inline unsigned long ipipe_test_and_unstall_pipeline(void)
+{
+	return ipipe_test_and_unstall_pipeline_from(ipipe_current_domain);
+}
+
+static inline unsigned long ipipe_test_pipeline(void)
+{
+	return ipipe_test_pipeline_from(ipipe_current_domain);
+}
+
+static inline unsigned long ipipe_test_and_stall_pipeline(void)
+{
+	return ipipe_test_and_stall_pipeline_from(ipipe_current_domain);
+}
+
+static inline void ipipe_restore_pipeline_from(struct ipipe_domain *ipd,
+					       unsigned long flags)
+{
+	if (flags)
+		ipipe_stall_pipeline_from(ipd);
+	else
+		ipipe_unstall_pipeline_from(ipd);
+}
+
+static inline void ipipe_stall_pipeline(void)
+{
+	ipipe_stall_pipeline_from(ipipe_current_domain);
+}
+
+static inline void ipipe_restore_pipeline(unsigned long flags)
+{
+	ipipe_restore_pipeline_from(ipipe_current_domain, flags);
+}
+
+static inline void ipipe_restore_pipeline_nosync(struct ipipe_domain *ipd,
+						 unsigned long flags, int cpuid)
+{
+	/*
+	 * If cpuid is current, then it must be held on entry
+	 * (ipipe_get_cpu/local_irq_save_hw/local_irq_disable_hw).
+	 */
+
+	if (flags) {
+		__set_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+		ipipe_mark_domain_stall(ipd,cpuid);
+	}
+	else {
+		__clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+		ipipe_mark_domain_unstall(ipd,cpuid);
+	}
+}
+
+void ipipe_init_attr(struct ipipe_domain_attr *attr);
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *sysinfo);
+
+int ipipe_tune_timer(unsigned long ns,
+		     int flags);
+
+unsigned long ipipe_critical_enter(void (*syncfn) (void));
+
+void ipipe_critical_exit(unsigned long flags);
+
+static inline void ipipe_set_printk_sync(struct ipipe_domain *ipd)
+{
+	set_bit(IPIPE_SPRINTK_FLAG, &ipd->flags);
+}
+
+static inline void ipipe_set_printk_async(struct ipipe_domain *ipd)
+{
+	clear_bit(IPIPE_SPRINTK_FLAG, &ipd->flags);
+}
+
+int ipipe_catch_event(struct ipipe_domain *ipd,
+		      unsigned event,
+		      int (*handler)(unsigned event,
+				     struct ipipe_domain *ipd,
+				     void *data));
+
+cpumask_t ipipe_set_irq_affinity(unsigned irq,
+				 cpumask_t cpumask);
+
+int fastcall ipipe_send_ipi(unsigned ipi,
+			    cpumask_t cpumask);
+
+int ipipe_setscheduler_root(struct task_struct *p,
+			    int policy,
+			    int prio);
+
+int ipipe_reenter_root(struct task_struct *prev,
+		       int policy,
+		       int prio);
+
+int ipipe_alloc_ptdkey(void);
+
+int ipipe_free_ptdkey(int key);
+
+int fastcall ipipe_set_ptd(int key,
+			   void *value);
+
+void fastcall *ipipe_get_ptd(int key);
+
+#define local_irq_enable_hw_cond()		local_irq_enable_hw()
+#define local_irq_disable_hw_cond()		local_irq_disable_hw()
+#define local_irq_save_hw_cond(flags)		local_irq_save_hw(flags)
+#define local_irq_restore_hw_cond(flags)	local_irq_restore_hw(flags)
+#define spin_lock_irqsave_hw_cond(lock,flags)	spin_lock_irqsave_hw(lock,flags)
+#define spin_unlock_irqrestore_hw_cond(lock,flags) spin_unlock_irqrestore_hw(lock,flags)
+
+#define ipipe_irq_lock(irq)						\
+	do {								\
+		ipipe_declare_cpuid;					\
+		ipipe_load_cpuid();					\
+		__ipipe_lock_irq(ipipe_percpu_domain[cpuid], cpuid, irq);\
+	} while(0)
+
+#define ipipe_irq_unlock(irq)						\
+	do {								\
+		ipipe_declare_cpuid;					\
+		ipipe_load_cpuid();					\
+		__ipipe_unlock_irq(ipipe_percpu_domain[cpuid], irq);	\
+	} while(0)
+
+#else	/* !CONFIG_IPIPE */
+
+#define ipipe_init()				do { } while(0)
+#define ipipe_suspend_domain()			do { } while(0)
+#define ipipe_sigwake_notify(p)			do { } while(0)
+#define ipipe_setsched_notify(p)		do { } while(0)
+#define ipipe_exit_notify(p)			do { } while(0)
+#define ipipe_init_proc()			do { } while(0)
+#define ipipe_reset_stats()			do { } while(0)
+#define ipipe_trap_notify(t,r)			0
+
+#define spin_lock_hw(lock)			spin_lock(lock)
+#define spin_unlock_hw(lock)			spin_unlock(lock)
+#define spin_lock_irq_hw(lock)			spin_lock_irq(lock)
+#define spin_unlock_irq_hw(lock)		spin_unlock_irq(lock)
+#define spin_lock_irqsave_hw(lock,flags)	spin_lock_irqsave(lock, flags)
+#define spin_unlock_irqrestore_hw(lock,flags)	spin_unlock_irqrestore(lock, flags)
+
+#define local_irq_enable_hw_cond()		do { } while(0)
+#define local_irq_disable_hw_cond()		do { } while(0)
+#define local_irq_save_hw_cond(flags)		do { flags = 0; /* Optimized out */ } while(0)
+#define local_irq_restore_hw_cond(flags)	do { } while(0)
+#define spin_lock_irqsave_hw_cond(lock,flags)	do { flags = 0; spin_lock(lock); } while(0)
+#define spin_unlock_irqrestore_hw_cond(lock,flags)	spin_unlock(lock)
+
+#define ipipe_irq_lock(irq)			do { } while(0)
+#define ipipe_irq_unlock(irq)			do { } while(0)
+
+#endif	/* CONFIG_IPIPE */
+
+#endif	/* !__LINUX_IPIPE_H */
diff -uNrp 2.6.14/include/linux/preempt.h 2.6.14-ipipe/include/linux/preempt.h
--- 2.6.14/include/linux/preempt.h	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/include/linux/preempt.h	2005-10-31 10:15:18.000000000 +0100
@@ -13,41 +13,58 @@
   extern void fastcall add_preempt_count(int val);
   extern void fastcall sub_preempt_count(int val);
 #else
-# define add_preempt_count(val)	do { preempt_count() += (val); } while (0)
-# define sub_preempt_count(val)	do { preempt_count() -= (val); } while (0)
+#define add_preempt_count(val)	do { preempt_count() += (val); } while (0)
+#define sub_preempt_count(val)	do { preempt_count() -= (val); } while (0)
 #endif
 
-#define inc_preempt_count() add_preempt_count(1)
-#define dec_preempt_count() sub_preempt_count(1)
+#define inc_preempt_count()	add_preempt_count(1)
+#define dec_preempt_count()	sub_preempt_count(1)
 
-#define preempt_count()	(current_thread_info()->preempt_count)
+#define preempt_count()		(current_thread_info()->preempt_count)
 
 #ifdef CONFIG_PREEMPT
 
 asmlinkage void preempt_schedule(void);
 
-#define preempt_disable() \
-do { \
-	inc_preempt_count(); \
-	barrier(); \
+#ifdef CONFIG_IPIPE
+
+#include <asm/ipipe.h>
+
+extern struct ipipe_domain *ipipe_percpu_domain[], *ipipe_root_domain;
+
+#define ipipe_preempt_guard()	(ipipe_percpu_domain[ipipe_processor_id()] == ipipe_root_domain)
+#else
+#define ipipe_preempt_guard()	1
+#endif
+
+#define preempt_disable()						\
+do {									\
+	if (ipipe_preempt_guard()) {					\
+		inc_preempt_count();					\
+		barrier();						\
+	}								\
 } while (0)
 
-#define preempt_enable_no_resched() \
-do { \
-	barrier(); \
-	dec_preempt_count(); \
+#define preempt_enable_no_resched()					\
+do {									\
+	if (ipipe_preempt_guard()) {					\
+		barrier();						\
+		dec_preempt_count();					\
+	}								\
 } while (0)
 
-#define preempt_check_resched() \
-do { \
-	if (unlikely(test_thread_flag(TIF_NEED_RESCHED))) \
-		preempt_schedule(); \
+#define preempt_check_resched()						\
+do {									\
+	if (ipipe_preempt_guard()) {					\
+		if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))	\
+			preempt_schedule();				\
+	}								\
 } while (0)
 
-#define preempt_enable() \
-do { \
-	preempt_enable_no_resched(); \
-	preempt_check_resched(); \
+#define preempt_enable()						\
+do {									\
+	preempt_enable_no_resched();					\
+	preempt_check_resched();					\
 } while (0)
 
 #else
diff -uNrp 2.6.14/include/linux/sched.h 2.6.14-ipipe/include/linux/sched.h
--- 2.6.14/include/linux/sched.h	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/include/linux/sched.h	2005-10-31 10:15:18.000000000 +0100
@@ -4,6 +4,7 @@
 #include <asm/param.h>	/* for HZ */
 
 #include <linux/config.h>
+#include <linux/ipipe.h>
 #include <linux/capability.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
@@ -813,6 +814,9 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
+#ifdef CONFIG_IPIPE
+        void *ptd[IPIPE_ROOT_NPTDKEYS];
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -uNrp 2.6.14/init/Kconfig 2.6.14-ipipe/init/Kconfig
--- 2.6.14/init/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/init/Kconfig	2005-10-31 10:15:18.000000000 +0100
@@ -69,6 +69,7 @@ menu "General setup"
 
 config LOCALVERSION
 	string "Local version - append to kernel release"
+	default "-ipipe"
 	help
 	  Append an extra string to the end of your kernel version.
 	  This will show up when you type uname, for example.
diff -uNrp 2.6.14/init/main.c 2.6.14-ipipe/init/main.c
--- 2.6.14/init/main.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/init/main.c	2005-10-31 10:15:18.000000000 +0100
@@ -402,8 +402,9 @@ static void noinline rest_init(void)
 	 */
 	schedule();
 
+ 	ipipe_reset_stats();
 	cpu_idle();
-} 
+}
 
 /* Check for early params. */
 static int __init do_early_param(char *param, char *val)
@@ -487,6 +488,11 @@ asmlinkage void __init start_kernel(void
 	init_timers();
 	softirq_init();
 	time_init();
+	/*
+	 * We need to wait for the interrupt and time subsystems to be
+	 * initialized before enabling the pipeline.
+	 */
+ 	ipipe_init();
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
@@ -611,6 +617,7 @@ static void __init do_basic_setup(void)
 #ifdef CONFIG_SYSCTL
 	sysctl_init();
 #endif
+	ipipe_init_proc();
 
 	/* Networking initialization needs a process context */ 
 	sock_init();
diff -uNrp 2.6.14/kernel/Makefile 2.6.14-ipipe/kernel/Makefile
--- 2.6.14/kernel/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/kernel/Makefile	2005-10-31 10:15:18.000000000 +0100
@@ -32,6 +32,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_IPIPE) += ipipe/
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@domain.hid>, the -fno-omit-frame-pointer is
diff -uNrp 2.6.14/kernel/exit.c 2.6.14-ipipe/kernel/exit.c
--- 2.6.14/kernel/exit.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/kernel/exit.c	2005-10-31 10:15:18.000000000 +0100
@@ -846,6 +846,7 @@ fastcall NORET_TYPE void do_exit(long co
 		exit_itimers(tsk->signal);
 		acct_process(code);
 	}
+ 	ipipe_exit_notify(tsk);
 	exit_mm(tsk);
 
 	exit_sem(tsk);
diff -uNrp 2.6.14/kernel/fork.c 2.6.14-ipipe/kernel/fork.c
--- 2.6.14/kernel/fork.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/kernel/fork.c	2005-10-31 10:15:18.000000000 +0100
@@ -1153,6 +1153,14 @@ static task_t *copy_process(unsigned lon
 	total_forks++;
 	write_unlock_irq(&tasklist_lock);
 	retval = 0;
+#ifdef CONFIG_IPIPE
+	{
+	int k;
+
+	for (k = 0; k < IPIPE_ROOT_NPTDKEYS; k++)
+	    p->ptd[k] = NULL;
+	}
+#endif /* CONFIG_IPIPE */
 
 fork_out:
 	if (retval)
diff -uNrp 2.6.14/kernel/ipipe/Kconfig 2.6.14-ipipe/kernel/ipipe/Kconfig
--- 2.6.14/kernel/ipipe/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.14-ipipe/kernel/ipipe/Kconfig	2005-09-07 14:30:42.000000000 +0200
@@ -0,0 +1,18 @@
+config IPIPE
+	bool "Interrupt pipeline"
+	default y
+	---help---
+	  Activate this option if you want the interrupt pipeline to be
+	  compiled in.
+
+config IPIPE_STATS
+	bool "Collect statistics"
+	depends on IPIPE
+	default n
+	---help---
+	  Activate this option if you want runtime statistics to be collected
+	  while the I-pipe is operating. This option adds a small overhead, but
+	  is useful to detect unexpected latency points.
+
+config IPIPE_EXTENDED
+	def_bool IPIPE
diff -uNrp 2.6.14/kernel/ipipe/Makefile 2.6.14-ipipe/kernel/ipipe/Makefile
--- 2.6.14/kernel/ipipe/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.14-ipipe/kernel/ipipe/Makefile	2005-09-07 13:17:29.000000000 +0200
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_IPIPE)	+= core.o generic.o
diff -uNrp 2.6.14/kernel/ipipe/core.c 2.6.14-ipipe/kernel/ipipe/core.c
--- 2.6.14/kernel/ipipe/core.c	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.14-ipipe/kernel/ipipe/core.c	2005-11-02 12:51:53.000000000 +0100
@@ -0,0 +1,678 @@
+/* -*- linux-c -*-
+ * linux/kernel/ipipe/core.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
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
+ * Architecture-independent I-PIPE core support.
+ */
+
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif	/* CONFIG_PROC_FS */
+
+static struct ipipe_domain ipipe_root =
+	{ .cpudata = {[0 ... IPIPE_NR_CPUS-1] =
+		{ .status = (1<<IPIPE_STALL_FLAG) } } };
+
+struct ipipe_domain *ipipe_root_domain = &ipipe_root;
+
+struct ipipe_domain *ipipe_percpu_domain[IPIPE_NR_CPUS] =
+	{[0 ... IPIPE_NR_CPUS - 1] = &ipipe_root };
+
+ipipe_spinlock_t __ipipe_pipelock = IPIPE_SPIN_LOCK_UNLOCKED;
+
+struct list_head __ipipe_pipeline;
+
+unsigned long __ipipe_virtual_irq_map = 0;
+
+unsigned __ipipe_printk_virq;
+
+int __ipipe_event_monitors[IPIPE_NR_EVENTS];
+
+/*
+ * ipipe_init() -- Initialization routine of the IPIPE layer. Called
+ * by the host kernel early during the boot procedure.
+ */
+void ipipe_init(void)
+{
+	struct ipipe_domain *ipd = &ipipe_root;
+
+	__ipipe_check_platform();	/* Do platform dependent checks first. */
+
+	/*
+	 * A lightweight registration code for the root domain. We are
+	 * running on the boot CPU, hw interrupts are off, and
+	 * secondary CPUs are still lost in space.
+	 */
+
+	INIT_LIST_HEAD(&__ipipe_pipeline);
+
+	ipd->name = "Linux";
+	ipd->domid = IPIPE_ROOT_ID;
+	ipd->priority = IPIPE_ROOT_PRIO;
+
+	__ipipe_init_stage(ipd);
+
+	INIT_LIST_HEAD(&ipd->p_link);
+	list_add_tail(&ipd->p_link, &__ipipe_pipeline);
+
+	__ipipe_init_platform();
+
+	__ipipe_printk_virq = ipipe_alloc_virq();	/* Cannot fail here. */
+	ipd->irqs[__ipipe_printk_virq].handler = &__ipipe_flush_printk;
+	ipd->irqs[__ipipe_printk_virq].acknowledge = NULL;
+	ipd->irqs[__ipipe_printk_virq].control = IPIPE_HANDLE_MASK;
+
+	__ipipe_enable_pipeline();
+
+	printk(KERN_INFO "I-pipe %s: pipeline enabled.\n",
+	       IPIPE_VERSION_STRING);
+}
+
+void __ipipe_init_stage(struct ipipe_domain *ipd)
+{
+	int cpuid, n;
+
+	for (cpuid = 0; cpuid < IPIPE_NR_CPUS; cpuid++) {
+		ipd->cpudata[cpuid].irq_pending_hi = 0;
+
+		for (n = 0; n < IPIPE_IRQ_IWORDS; n++)
+			ipd->cpudata[cpuid].irq_pending_lo[n] = 0;
+
+		for (n = 0; n < IPIPE_NR_IRQS; n++)
+			ipd->cpudata[cpuid].irq_hits[n] = 0;
+	}
+
+	for (n = 0; n < IPIPE_NR_IRQS; n++) {
+		ipd->irqs[n].acknowledge = NULL;
+		ipd->irqs[n].handler = NULL;
+		ipd->irqs[n].control = IPIPE_PASS_MASK;	/* Pass but don't handle */
+	}
+
+	for (n = 0; n < IPIPE_NR_EVENTS; n++)
+		ipd->evhand[n] = NULL;
+
+	ipd->evexcl = 0;
+
+#ifdef CONFIG_SMP
+	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge = &__ipipe_ack_system_irq;
+	ipd->irqs[IPIPE_CRITICAL_IPI].handler = &__ipipe_do_critical_sync;
+	/* Immediately handle in the current domain but *never* pass */
+	ipd->irqs[IPIPE_CRITICAL_IPI].control =
+		IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK;
+#endif	/* CONFIG_SMP */
+}
+
+void __ipipe_stall_root(void)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	ipipe_get_cpu(flags); /* Care for migration. */
+
+	set_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
+
+#ifdef CONFIG_SMP
+	if (!__ipipe_pipeline_head_p(ipipe_root_domain))
+		ipipe_put_cpu(flags);
+#else /* CONFIG_SMP */
+	if (__ipipe_pipeline_head_p(ipipe_root_domain))
+		local_irq_disable_hw();
+#endif /* CONFIG_SMP */
+	ipipe_mark_domain_stall(ipipe_root_domain,cpuid);
+}
+
+void __ipipe_cleanup_domain(struct ipipe_domain *ipd)
+{
+	ipipe_unstall_pipeline_from(ipd);
+
+#ifdef CONFIG_SMP
+	{
+		int cpu;
+
+		for_each_online_cpu(cpu) {
+			while (ipd->cpudata[cpu].irq_pending_hi != 0)
+				cpu_relax();
+		}
+	}
+#endif	/* CONFIG_SMP */
+}
+
+void __ipipe_unstall_root(void)
+{
+	ipipe_declare_cpuid;
+
+	local_irq_disable_hw();
+
+	ipipe_load_cpuid();
+
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
+
+	ipipe_mark_domain_unstall(ipipe_root_domain, cpuid);
+
+	if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi != 0)
+		__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+
+	local_irq_enable_hw();
+}
+
+unsigned long __ipipe_test_root(void)
+{
+	unsigned long flags, s;
+	ipipe_declare_cpuid;
+
+	ipipe_get_cpu(flags); /* Care for migration. */
+	s = test_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
+	ipipe_put_cpu(flags);
+
+	return s;
+}
+
+unsigned long __ipipe_test_and_stall_root(void)
+{
+	unsigned long flags, s;
+	ipipe_declare_cpuid;
+
+	ipipe_get_cpu(flags); /* Care for migration. */
+	s = test_and_set_bit(IPIPE_STALL_FLAG,
+			     &ipipe_root_domain->cpudata[cpuid].status);
+	ipipe_mark_domain_stall(ipipe_root_domain,cpuid);
+	ipipe_put_cpu(flags);
+
+	return s;
+}
+
+void fastcall __ipipe_restore_root(unsigned long flags)
+{
+	if (flags)
+		__ipipe_stall_root();
+	else
+		__ipipe_unstall_root();
+}
+
+/*
+ * ipipe_unstall_pipeline_from() -- Unstall the pipeline and
+ * synchronize pending interrupts for a given domain. See
+ * __ipipe_walk_pipeline() for more information.
+ */
+void fastcall ipipe_unstall_pipeline_from(struct ipipe_domain *ipd)
+{
+	struct ipipe_domain *this_domain;
+	struct list_head *pos;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(flags);
+
+	__clear_bit(IPIPE_STALL_FLAG, &ipd->cpudata[cpuid].status);
+
+	ipipe_mark_domain_unstall(ipd, cpuid);
+
+	this_domain = ipipe_percpu_domain[cpuid];
+
+	if (ipd == this_domain) {
+		if (ipd->cpudata[cpuid].irq_pending_hi != 0)
+			__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+
+		goto release_cpu_and_exit;
+	}
+
+	list_for_each(pos, &__ipipe_pipeline) {
+
+		struct ipipe_domain *next_domain =
+			list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG,
+			     &next_domain->cpudata[cpuid].status))
+			break;	/* Stalled stage -- do not go further. */
+
+		if (next_domain->cpudata[cpuid].irq_pending_hi != 0) {
+
+			if (next_domain == this_domain)
+				__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			else {
+				__ipipe_switch_to(this_domain, next_domain,
+						  cpuid);
+
+				ipipe_load_cpuid();	/* Processor might have changed. */
+
+				if (this_domain->cpudata[cpuid].
+				    irq_pending_hi != 0
+				    && !test_bit(IPIPE_STALL_FLAG,
+						 &this_domain->cpudata[cpuid].
+						 status))
+					__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			}
+
+			break;
+		} else if (next_domain == this_domain)
+			break;
+	}
+
+release_cpu_and_exit:
+
+	if (__ipipe_pipeline_head_p(ipd))
+		local_irq_enable_hw();
+	else
+		ipipe_unlock_cpu(flags);
+}
+
+/*
+ * ipipe_suspend_domain() -- Suspend the current domain, switching to
+ * the next one which has pending work down the pipeline.
+ */
+void ipipe_suspend_domain(void)
+{
+	struct ipipe_domain *this_domain, *next_domain;
+	struct list_head *ln;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(flags);
+
+	this_domain = next_domain = ipipe_percpu_domain[cpuid];
+
+	__clear_bit(IPIPE_STALL_FLAG, &this_domain->cpudata[cpuid].status);
+
+	ipipe_mark_domain_unstall(this_domain, cpuid);
+
+	if (this_domain->cpudata[cpuid].irq_pending_hi != 0)
+		goto sync_stage;
+
+	for (;;) {
+		ln = next_domain->p_link.next;
+
+		if (ln == &__ipipe_pipeline)
+			break;
+
+		next_domain = list_entry(ln, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_STALL_FLAG,
+			     &next_domain->cpudata[cpuid].status))
+			break;
+
+		if (next_domain->cpudata[cpuid].irq_pending_hi == 0)
+			continue;
+
+		ipipe_percpu_domain[cpuid] = next_domain;
+
+sync_stage:
+
+		__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+
+		ipipe_load_cpuid();	/* Processor might have changed. */
+
+		if (ipipe_percpu_domain[cpuid] != next_domain)
+			/*
+			 * Something has changed the current domain under our
+			 * feet, recycling the register set; take note.
+			 */
+			this_domain = ipipe_percpu_domain[cpuid];
+	}
+
+	ipipe_percpu_domain[cpuid] = this_domain;
+
+	ipipe_unlock_cpu(flags);
+}
+
+/* ipipe_alloc_virq() -- Allocate a pipelined virtual/soft interrupt.
+ * Virtual interrupts are handled in exactly the same way than their
+ * hw-generated counterparts wrt pipelining.
+ */
+unsigned ipipe_alloc_virq(void)
+{
+	unsigned long flags, irq = 0;
+	int ipos;
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+
+	if (__ipipe_virtual_irq_map != ~0) {
+		ipos = ffz(__ipipe_virtual_irq_map);
+		set_bit(ipos, &__ipipe_virtual_irq_map);
+		irq = ipos + IPIPE_VIRQ_BASE;
+	}
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+
+	return irq;
+}
+
+/* __ipipe_dispatch_event() -- Low-level event dispatcher. */
+
+int fastcall __ipipe_dispatch_event (unsigned event, void *data)
+{
+	struct ipipe_domain *start_domain, *this_domain, *next_domain;
+	struct list_head *pos, *npos;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+	int propagate = 1;
+
+	ipipe_lock_cpu(flags);
+
+	start_domain = this_domain = ipipe_percpu_domain[cpuid];
+
+	list_for_each_safe(pos,npos,&__ipipe_pipeline) {
+
+		next_domain = list_entry(pos,struct ipipe_domain,p_link);
+
+		/*
+		 * Note: Domain migration may occur while running
+		 * event or interrupt handlers, in which case the
+		 * current register set is going to be recycled for a
+		 * different domain than the initiating one. We do
+		 * care for that, always tracking the current domain
+		 * descriptor upon return from those handlers.
+		 */
+		if (next_domain->evhand[event] != NULL)	{
+			ipipe_percpu_domain[cpuid] = next_domain;
+			ipipe_unlock_cpu(flags);
+			propagate = !next_domain->evhand[event](event,start_domain,data);
+			ipipe_lock_cpu(flags);
+			if (ipipe_percpu_domain[cpuid] != next_domain)
+				this_domain = ipipe_percpu_domain[cpuid];
+		}
+
+		if (next_domain != ipipe_root_domain &&	/* NEVER sync the root stage here. */
+		    next_domain->cpudata[cpuid].irq_pending_hi != 0 &&
+		    !test_bit(IPIPE_STALL_FLAG,&next_domain->cpudata[cpuid].status)) {
+			ipipe_percpu_domain[cpuid] = next_domain;
+			__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			ipipe_load_cpuid();
+			if (ipipe_percpu_domain[cpuid] != next_domain)
+				this_domain = ipipe_percpu_domain[cpuid];
+		}
+
+		ipipe_percpu_domain[cpuid] = this_domain;
+
+		if (next_domain == this_domain || !propagate)
+			break;
+	}
+
+	ipipe_unlock_cpu(flags);
+
+	return !propagate;
+}
+
+#ifdef CONFIG_PROC_FS
+
+#include <linux/proc_fs.h>
+
+static struct proc_dir_entry *ipipe_proc_root;
+
+static int __ipipe_version_info_proc(char *page,
+				     char **start,
+				     off_t off, int count, int *eof, void *data)
+{
+	int len = sprintf(page, "%s\n", IPIPE_VERSION_STRING);
+
+	len -= off;
+
+	if (len <= off + count)
+		*eof = 1;
+
+	*start = page + off;
+
+	if(len > count)
+		len = count;
+
+	if(len < 0)
+		len = 0;
+
+	return len;
+}
+
+static int __ipipe_common_info_proc(char *page,
+				    char **start,
+				    off_t off, int count, int *eof, void *data)
+{
+	struct ipipe_domain *ipd = (struct ipipe_domain *)data;
+	unsigned long ctlbits;
+	unsigned irq, _irq;
+	char *p = page;
+	int len;
+
+	spin_lock(&__ipipe_pipelock);
+
+	p += sprintf(p, "Priority=%d, Id=0x%.8x\n",
+		     ipd->priority, ipd->domid);
+	irq = 0;
+
+	while (irq < IPIPE_NR_IRQS) {
+		ctlbits =
+			(ipd->irqs[irq].
+			 control & (IPIPE_HANDLE_MASK | IPIPE_PASS_MASK |
+				    IPIPE_STICKY_MASK));
+		if (irq >= IPIPE_NR_XIRQS && !ipipe_virtual_irq_p(irq)) {
+			/*
+			 * There might be a hole between the last external
+			 * IRQ and the first virtual one; skip it.
+			 */
+			irq++;
+			continue;
+		}
+
+		if (ipipe_virtual_irq_p(irq)
+		    && !test_bit(irq - IPIPE_VIRQ_BASE,
+				 &__ipipe_virtual_irq_map)) {
+			/* Non-allocated virtual IRQ; skip it. */
+			irq++;
+			continue;
+		}
+
+		/*
+		 * Attempt to group consecutive IRQ numbers having the
+		 * same virtualization settings in a single line.
+		 */
+
+		_irq = irq;
+
+		while (++_irq < IPIPE_NR_IRQS) {
+			if (ipipe_virtual_irq_p(_irq) !=
+			    ipipe_virtual_irq_p(irq)
+			    || (ipipe_virtual_irq_p(_irq)
+				&& !test_bit(_irq - IPIPE_VIRQ_BASE,
+					     &__ipipe_virtual_irq_map))
+			    || ctlbits != (ipd->irqs[_irq].
+			     control & (IPIPE_HANDLE_MASK |
+					IPIPE_PASS_MASK |
+					IPIPE_STICKY_MASK)))
+				break;
+		}
+
+		if (_irq == irq + 1)
+			p += sprintf(p, "irq%u: ", irq);
+		else
+			p += sprintf(p, "irq%u-%u: ", irq, _irq - 1);
+
+		/*
+		 * Statuses are as follows:
+		 * o "accepted" means handled _and_ passed down the pipeline.
+		 * o "grabbed" means handled, but the interrupt might be
+		 * terminated _or_ passed down the pipeline depending on
+		 * what the domain handler asks for to the I-pipe.
+		 * o "passed" means unhandled by the domain but passed
+		 * down the pipeline.
+		 * o "discarded" means unhandled and _not_ passed down the
+		 * pipeline. The interrupt merely disappears from the
+		 * current domain down to the end of the pipeline.
+		 */
+		if (ctlbits & IPIPE_HANDLE_MASK) {
+			if (ctlbits & IPIPE_PASS_MASK)
+				p += sprintf(p, "accepted");
+			else
+				p += sprintf(p, "grabbed");
+		} else if (ctlbits & IPIPE_PASS_MASK)
+			p += sprintf(p, "passed");
+		else
+			p += sprintf(p, "discarded");
+
+		if (ctlbits & IPIPE_STICKY_MASK)
+			p += sprintf(p, ", sticky");
+
+		if (ipipe_virtual_irq_p(irq))
+			p += sprintf(p, ", virtual");
+
+		p += sprintf(p, "\n");
+
+		irq = _irq;
+	}
+
+	spin_unlock(&__ipipe_pipelock);
+
+	len = p - page;
+
+	if (len <= off + count)
+		*eof = 1;
+
+	*start = page + off;
+
+	len -= off;
+
+	if (len > count)
+		len = count;
+
+	if (len < 0)
+		len = 0;
+
+	return len;
+}
+
+#ifdef CONFIG_IPIPE_STATS
+
+static int __ipipe_stat_info_proc(char *page,
+				  char **start,
+				  off_t off, int count, int *eof, void *data)
+{
+	struct ipipe_domain *ipd = (struct ipipe_domain *)data;
+	int len = 0, cpu, irq;
+	char *p = page;
+
+	p += sprintf(p,"> STALL TIME:\n");
+
+	for_each_online_cpu(cpu) {
+		unsigned long eip = ipd->stats[cpu].max_stall_eip;
+		char namebuf[KSYM_NAME_LEN+1];
+		unsigned long offset, size, t;
+		const char *name;
+		char *modname;
+
+		name = kallsyms_lookup(eip, &size, &offset, &modname, namebuf);
+		t = ipipe_tsc2ns(ipd->stats[cpu].max_stall_time);
+
+		if (name) {
+			if (modname)
+				p += sprintf(p,"CPU%d  %12lu  (%s+%#lx [%s])\n",
+					     cpu,t,name,offset,modname);
+			else
+				p += sprintf(p,"CPU%d  %12lu  (%s+%#lx)\n",
+					     cpu,t,name,offset);
+		}
+		else
+			p += sprintf(p,"CPU%d  %12lu  (%lx)\n",
+				     cpu,t,eip);
+	}
+
+	p += sprintf(p,"> PROPAGATION TIME:\nIRQ");
+
+	for_each_online_cpu(cpu) {
+		p += sprintf(p,"         CPU%d",cpu);
+	}
+
+	for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
+
+		unsigned long long t = 0;
+
+		for_each_online_cpu(cpu) {
+			t += ipd->stats[cpu].irq_stats[irq].max_delivery_time;
+		}
+
+		if (!t)
+			continue;
+
+		p += sprintf(p,"\n%3d:",irq);
+
+		for_each_online_cpu(cpu) {
+			p += sprintf(p,"%13lu",
+				     ipipe_tsc2ns(ipd->stats[cpu].irq_stats[irq].max_delivery_time));
+		}
+	}
+
+	p += sprintf(p,"\n");
+
+	len = p - page - off;
+	if (len <= off + count) *eof = 1;
+	*start = page + off;
+	if (len > count) len = count;
+	if (len < 0) len = 0;
+
+	return len;
+}
+
+#endif /* CONFIG_IPIPE_STATS */
+
+void __ipipe_add_domain_proc(struct ipipe_domain *ipd)
+{
+
+	create_proc_read_entry(ipd->name,0444,ipipe_proc_root,&__ipipe_common_info_proc,ipd);
+#ifdef CONFIG_IPIPE_STATS
+	{
+		char name[64];
+		snprintf(name,sizeof(name),"%s_stats",ipd->name);
+		create_proc_read_entry(name,0444,ipipe_proc_root,&__ipipe_stat_info_proc,ipd);
+	}
+#endif /* CONFIG_IPIPE_STATS */
+}
+
+void __ipipe_remove_domain_proc(struct ipipe_domain *ipd)
+{
+	remove_proc_entry(ipd->name,ipipe_proc_root);
+#ifdef CONFIG_IPIPE_STATS
+	{
+		char name[64];
+		snprintf(name,sizeof(name),"%s_stats",ipd->name);
+		remove_proc_entry(name,ipipe_proc_root);
+	}
+#endif /* CONFIG_IPIPE_STATS */
+}
+
+void ipipe_init_proc(void)
+{
+	ipipe_proc_root = create_proc_entry("ipipe",S_IFDIR, 0);
+	create_proc_read_entry("version",0444,ipipe_proc_root,&__ipipe_version_info_proc,NULL);
+	__ipipe_add_domain_proc(ipipe_root_domain);
+}
+
+#endif	/* CONFIG_PROC_FS */
+
+EXPORT_SYMBOL(ipipe_suspend_domain);
+EXPORT_SYMBOL(ipipe_alloc_virq);
+EXPORT_SYMBOL(ipipe_unstall_pipeline_from);
+EXPORT_SYMBOL(ipipe_percpu_domain);
+EXPORT_SYMBOL(ipipe_root_domain);
+EXPORT_SYMBOL(__ipipe_unstall_root);
+EXPORT_SYMBOL(__ipipe_stall_root);
+EXPORT_SYMBOL(__ipipe_restore_root);
+EXPORT_SYMBOL(__ipipe_test_and_stall_root);
+EXPORT_SYMBOL(__ipipe_test_root);
+EXPORT_SYMBOL(__ipipe_dispatch_event);
+EXPORT_SYMBOL(__ipipe_pipeline);
+EXPORT_SYMBOL(__ipipe_pipelock);
+EXPORT_SYMBOL(__ipipe_virtual_irq_map);
diff -uNrp 2.6.14/kernel/ipipe/generic.c 2.6.14-ipipe/kernel/ipipe/generic.c
--- 2.6.14/kernel/ipipe/generic.c	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.14-ipipe/kernel/ipipe/generic.c	2005-10-16 23:28:19.000000000 +0200
@@ -0,0 +1,390 @@
+/* -*- linux-c -*-
+ * linux/kernel/ipipe/generic.c
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
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
+ * Architecture-independent I-PIPE services.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#endif	/* CONFIG_PROC_FS */
+
+MODULE_DESCRIPTION("I-pipe");
+MODULE_LICENSE("GPL");
+
+static int __ipipe_ptd_key_count;
+
+static unsigned long __ipipe_ptd_key_map;
+
+/* ipipe_register_domain() -- Link a new domain to the pipeline. */
+
+int ipipe_register_domain(struct ipipe_domain *ipd,
+			  struct ipipe_domain_attr *attr)
+{
+	struct list_head *pos;
+	unsigned long flags;
+
+	if (ipipe_current_domain != ipipe_root_domain) {
+		printk(KERN_WARNING
+		       "I-pipe: Only the root domain may register a new domain.\n");
+		return -EPERM;
+	}
+
+	flags = ipipe_critical_enter(NULL);
+
+	list_for_each(pos, &__ipipe_pipeline) {
+		struct ipipe_domain *_ipd =
+			list_entry(pos, struct ipipe_domain, p_link);
+		if (_ipd->domid == attr->domid)
+			break;
+	}
+
+	ipipe_critical_exit(flags);
+
+	if (pos != &__ipipe_pipeline)
+		/* A domain with the given id already exists -- fail. */
+		return -EBUSY;
+
+	ipd->name = attr->name;
+	ipd->priority = attr->priority;
+	ipd->domid = attr->domid;
+	ipd->pdd = attr->pdd;
+	ipd->flags = 0;
+
+#ifdef CONFIG_IPIPE_STATS
+	{
+		int cpu, irq;
+		for_each_online_cpu(cpu) {
+			ipd->stats[cpu].last_stall_date = 0LL;
+			for (irq = 0; irq < IPIPE_NR_IRQS; irq++)
+				ipd->stats[cpu].irq_stats[irq].last_receipt_date = 0LL;
+		}
+	}
+#endif /* CONFIG_IPIPE_STATS */
+
+	__ipipe_init_stage(ipd);
+
+	INIT_LIST_HEAD(&ipd->p_link);
+
+#ifdef CONFIG_PROC_FS
+	__ipipe_add_domain_proc(ipd);
+#endif /* CONFIG_PROC_FS */
+
+	flags = ipipe_critical_enter(NULL);
+
+	list_for_each(pos, &__ipipe_pipeline) {
+		struct ipipe_domain *_ipd =
+			list_entry(pos, struct ipipe_domain, p_link);
+		if (ipd->priority > _ipd->priority)
+			break;
+	}
+
+	list_add_tail(&ipd->p_link, pos);
+
+	ipipe_critical_exit(flags);
+
+	printk(KERN_WARNING "I-pipe: Domain %s registered.\n", ipd->name);
+
+	/*
+	 * Finally, allow the new domain to perform its initialization
+	 * chores.
+	 */
+
+	if (attr->entry != NULL) {
+		ipipe_declare_cpuid;
+
+		ipipe_lock_cpu(flags);
+
+		ipipe_percpu_domain[cpuid] = ipd;
+		attr->entry();
+		ipipe_percpu_domain[cpuid] = ipipe_root_domain;
+
+		ipipe_load_cpuid();	/* Processor might have changed. */
+
+		if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi != 0 &&
+		    !test_bit(IPIPE_STALL_FLAG,
+			      &ipipe_root_domain->cpudata[cpuid].status))
+			__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+
+		ipipe_unlock_cpu(flags);
+	}
+
+	return 0;
+}
+
+/* ipipe_unregister_domain() -- Remove a domain from the pipeline. */
+
+int ipipe_unregister_domain(struct ipipe_domain *ipd)
+{
+	unsigned long flags;
+
+	if (ipipe_current_domain != ipipe_root_domain) {
+		printk(KERN_WARNING
+		       "I-pipe: Only the root domain may unregister a domain.\n");
+		return -EPERM;
+	}
+
+	if (ipd == ipipe_root_domain) {
+		printk(KERN_WARNING
+		       "I-pipe: Cannot unregister the root domain.\n");
+		return -EPERM;
+	}
+#ifdef CONFIG_SMP
+	{
+		int nr_cpus = num_online_cpus(), _cpuid;
+		unsigned irq;
+
+		/*
+		 * In the SMP case, wait for the logged events to drain on
+		 * other processors before eventually removing the domain
+		 * from the pipeline.
+		 */
+
+		ipipe_unstall_pipeline_from(ipd);
+
+		flags = ipipe_critical_enter(NULL);
+
+		for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
+			clear_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control);
+			clear_bit(IPIPE_STICKY_FLAG, &ipd->irqs[irq].control);
+			set_bit(IPIPE_PASS_FLAG, &ipd->irqs[irq].control);
+		}
+
+		ipipe_critical_exit(flags);
+
+		for (_cpuid = 0; _cpuid < nr_cpus; _cpuid++)
+			for (irq = 0; irq < IPIPE_NR_IRQS; irq++)
+				while (ipd->cpudata[_cpuid].irq_hits[irq] > 0)
+					cpu_relax();
+	}
+#endif	/* CONFIG_SMP */
+
+#ifdef CONFIG_PROC_FS
+	__ipipe_remove_domain_proc(ipd);
+#endif /* CONFIG_PROC_FS */
+
+	/*
+	 * Simply remove the domain from the pipeline and we are almost done.
+	 */
+
+	flags = ipipe_critical_enter(NULL);
+	list_del_init(&ipd->p_link);
+	ipipe_critical_exit(flags);
+
+	__ipipe_cleanup_domain(ipd);
+
+	printk(KERN_WARNING "I-pipe: Domain %s unregistered.\n", ipd->name);
+
+	return 0;
+}
+
+/*
+ * ipipe_propagate_irq() -- Force a given IRQ propagation on behalf of
+ * a running interrupt handler to the next domain down the pipeline.
+ * ipipe_schedule_irq() -- Does almost the same as above, but attempts
+ * to pend the interrupt for the current domain first.
+ */
+int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head)
+{
+	struct list_head *ln;
+	unsigned long flags;
+	ipipe_declare_cpuid;
+
+	if (irq >= IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq)
+	     && !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	ipipe_lock_cpu(flags);
+
+	ln = head;
+
+	while (ln != &__ipipe_pipeline) {
+		struct ipipe_domain *ipd =
+			list_entry(ln, struct ipipe_domain, p_link);
+
+		if (test_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control)) {
+			ipd->cpudata[cpuid].irq_hits[irq]++;
+			__ipipe_set_irq_bit(ipd, cpuid, irq);
+			ipipe_mark_irq_receipt(ipd, irq, cpuid);
+			ipipe_unlock_cpu(flags);
+			return 1;
+		}
+
+		ln = ipd->p_link.next;
+	}
+
+	ipipe_unlock_cpu(flags);
+
+	return 0;
+}
+
+/* ipipe_free_virq() -- Release a virtual/soft interrupt. */
+
+int ipipe_free_virq(unsigned virq)
+{
+	if (!ipipe_virtual_irq_p(virq))
+		return -EINVAL;
+
+	clear_bit(virq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map);
+
+	return 0;
+}
+
+void ipipe_init_attr(struct ipipe_domain_attr *attr)
+{
+	attr->name = "anon";
+	attr->domid = 1;
+	attr->entry = NULL;
+	attr->priority = IPIPE_ROOT_PRIO;
+	attr->pdd = NULL;
+}
+
+/*
+ * ipipe_catch_event() -- Interpose or remove an event handler for a
+ * given domain.
+ */
+int ipipe_catch_event(struct ipipe_domain *ipd,
+		      unsigned event,
+		      int (*handler)(unsigned event, struct ipipe_domain *ipd, void *data))
+{
+	if (event >= IPIPE_NR_EVENTS)
+		return -EINVAL;
+
+	if (!xchg(&ipd->evhand[event],handler))	{
+		if (handler)
+			__ipipe_event_monitors[event]++;
+	}
+	else if (!handler)
+		__ipipe_event_monitors[event]--;
+
+	return 0;
+}
+
+cpumask_t ipipe_set_irq_affinity (unsigned irq, cpumask_t cpumask)
+{
+#ifdef CONFIG_SMP
+	if (irq >= IPIPE_NR_XIRQS)
+		/* Allow changing affinity of external IRQs only. */
+		return CPU_MASK_NONE;
+
+	if (num_online_cpus() > 1)
+		/* Allow changing affinity of external IRQs only. */
+		return __ipipe_set_irq_affinity(irq,cpumask);
+#endif /* CONFIG_SMP */
+
+	return CPU_MASK_NONE;
+}
+
+int fastcall ipipe_send_ipi (unsigned ipi, cpumask_t cpumask)
+
+{
+#ifdef CONFIG_SMP
+	switch (ipi) {
+
+	case IPIPE_SERVICE_IPI0:
+	case IPIPE_SERVICE_IPI1:
+	case IPIPE_SERVICE_IPI2:
+	case IPIPE_SERVICE_IPI3:
+
+		break;
+
+	default:
+
+		return -EINVAL;
+	}
+
+	return __ipipe_send_ipi(ipi,cpumask);
+#endif /* CONFIG_SMP */
+
+	return -EINVAL;
+}
+
+int ipipe_alloc_ptdkey (void)
+{
+	unsigned long flags;
+	int key = -1;
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock,flags);
+
+	if (__ipipe_ptd_key_count < IPIPE_ROOT_NPTDKEYS) {
+		key = ffz(__ipipe_ptd_key_map);
+		set_bit(key,&__ipipe_ptd_key_map);
+		__ipipe_ptd_key_count++;
+	}
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock,flags);
+
+	return key;
+}
+
+int ipipe_free_ptdkey (int key)
+{
+	unsigned long flags;
+
+	if (key < 0 || key >= IPIPE_ROOT_NPTDKEYS)
+		return -EINVAL;
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock,flags);
+
+	if (test_and_clear_bit(key,&__ipipe_ptd_key_map))
+		__ipipe_ptd_key_count--;
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock,flags);
+
+	return 0;
+}
+
+int fastcall ipipe_set_ptd (int key, void *value)
+
+{
+	if (key < 0 || key >= IPIPE_ROOT_NPTDKEYS)
+		return -EINVAL;
+
+	current->ptd[key] = value;
+
+	return 0;
+}
+
+void fastcall *ipipe_get_ptd (int key)
+
+{
+	if (key < 0 || key >= IPIPE_ROOT_NPTDKEYS)
+		return NULL;
+
+	return current->ptd[key];
+}
+
+EXPORT_SYMBOL(ipipe_register_domain);
+EXPORT_SYMBOL(ipipe_unregister_domain);
+EXPORT_SYMBOL(ipipe_free_virq);
+EXPORT_SYMBOL(ipipe_init_attr);
+EXPORT_SYMBOL(ipipe_catch_event);
+EXPORT_SYMBOL(ipipe_alloc_ptdkey);
+EXPORT_SYMBOL(ipipe_free_ptdkey);
+EXPORT_SYMBOL(ipipe_set_ptd);
+EXPORT_SYMBOL(ipipe_get_ptd);
+EXPORT_SYMBOL(ipipe_set_irq_affinity);
+EXPORT_SYMBOL(ipipe_send_ipi);
+EXPORT_SYMBOL(__ipipe_schedule_irq);
diff -uNrp 2.6.14/kernel/irq/handle.c 2.6.14-ipipe/kernel/irq/handle.c
--- 2.6.14/kernel/irq/handle.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/kernel/irq/handle.c	2005-10-31 10:15:18.000000000 +0100
@@ -81,6 +81,17 @@ fastcall int handle_IRQ_event(unsigned i
 {
 	int ret, retval = 0, status = 0;
 
+#ifdef CONFIG_IPIPE
+	/*
+	 * If processing a timer tick, pass the original regs as
+	 * collected during preemption and not our phony - always
+	 * kernel-originated - frame, so that we don't wreck the
+	 * profiling code.
+	 */
+	if (__ipipe_tick_irq == irq)
+		regs = __ipipe_tick_regs + smp_processor_id();
+#endif /* CONFIG_IPIPE */
+
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
@@ -117,14 +128,18 @@ fastcall unsigned int __do_IRQ(unsigned 
 		/*
 		 * No locking required for CPU-local interrupts:
 		 */
+#ifndef CONFIG_IPIPE
 		desc->handler->ack(irq);
+#endif /* CONFIG_IPIPE */
 		action_ret = handle_IRQ_event(irq, regs, desc->action);
 		desc->handler->end(irq);
 		return 1;
 	}
 
 	spin_lock(&desc->lock);
+#ifndef CONFIG_IPIPE
 	desc->handler->ack(irq);
+#endif /* CONFIG_IPIPE */
 	/*
 	 * REPLAY is when Linux resends an IRQ that was dropped earlier
 	 * WAITING is used by probe to mark irqs that are being tested
diff -uNrp 2.6.14/kernel/printk.c 2.6.14-ipipe/kernel/printk.c
--- 2.6.14/kernel/printk.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/kernel/printk.c	2005-11-02 12:51:25.000000000 +0100
@@ -507,6 +507,66 @@ __attribute__((weak)) unsigned long long
  * is inspected when the actual printing occurs.
  */
 
+#ifdef CONFIG_IPIPE
+
+static ipipe_spinlock_t __ipipe_printk_lock = IPIPE_SPIN_LOCK_UNLOCKED;
+
+static int __ipipe_printk_fill;
+
+static char __ipipe_printk_buf[__LOG_BUF_LEN];
+
+void __ipipe_flush_printk (unsigned virq)
+{
+	char *p = __ipipe_printk_buf;
+	int out = 0, len;
+
+	clear_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags);
+
+	while (out < __ipipe_printk_fill) {
+		len = strlen(p) + 1;
+		printk("%s",p);
+		p += len;
+		out += len;
+	}
+	__ipipe_printk_fill = 0;
+}
+
+asmlinkage int printk(const char *fmt, ...)
+{
+	unsigned long flags;
+	int r, fbytes;
+	va_list args;
+
+	va_start(args, fmt);
+
+	if (ipipe_current_domain == ipipe_root_domain ||
+	    test_bit(IPIPE_SPRINTK_FLAG,&ipipe_current_domain->flags) ||
+	    oops_in_progress) {
+		r = vprintk(fmt, args);
+		goto out;
+	}
+
+	spin_lock_irqsave_hw(&__ipipe_printk_lock,flags);
+
+	fbytes = __LOG_BUF_LEN - __ipipe_printk_fill;
+
+	if (fbytes > 1)	{
+		r = vscnprintf(__ipipe_printk_buf + __ipipe_printk_fill,
+			       fbytes, fmt, args) + 1; /* account for the null byte */
+		__ipipe_printk_fill += r;
+	} else
+		r = 0;
+
+	spin_unlock_irqrestore_hw(&__ipipe_printk_lock,flags);
+
+	if (!test_and_set_bit(IPIPE_PPRINTK_FLAG,&ipipe_root_domain->flags))
+		ipipe_trigger_irq(__ipipe_printk_virq);
+out: 
+	va_end(args);
+
+	return r;
+}
+#else /* !CONFIG_IPIPE */
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
@@ -518,6 +578,7 @@ asmlinkage int printk(const char *fmt, .
 
 	return r;
 }
+#endif /* CONFIG_IPIPE */
 
 /* cpu currently holding logbuf_lock */
 static volatile unsigned int printk_cpu = UINT_MAX;
diff -uNrp 2.6.14/kernel/sched.c 2.6.14-ipipe/kernel/sched.c
--- 2.6.14/kernel/sched.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/kernel/sched.c	2005-10-31 10:32:02.000000000 +0100
@@ -3010,6 +3010,8 @@ switch_tasks:
 		prepare_task_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
+ 		if (task_hijacked(prev))
+ 		    return;
 		/*
 		 * this_rq must be evaluated again because prev may have moved
 		 * CPUs since it called schedule(), thus the 'rq' on its stack
@@ -3042,6 +3044,11 @@ asmlinkage void __sched preempt_schedule
 	struct task_struct *task = current;
 	int saved_lock_depth;
 #endif
+#ifdef CONFIG_IPIPE
+	/* Do not reschedule over non-Linux domains. */
+	if (ipipe_current_domain != ipipe_root_domain)
+		return;
+#endif /* CONFIG_IPIPE */
 	/*
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task.  Just return..
@@ -3670,6 +3677,7 @@ recheck:
 		deactivate_task(p, rq);
 	oldprio = p->prio;
 	__setscheduler(p, policy, param->sched_priority);
+	ipipe_setsched_notify(p);
 	if (array) {
 		__activate_task(p, rq);
 		/*
@@ -5647,3 +5655,53 @@ void set_curr_task(int cpu, task_t *p)
 }
 
 #endif
+
+#ifdef CONFIG_IPIPE
+
+int ipipe_setscheduler_root (struct task_struct *p, int policy, int prio)
+{
+	prio_array_t *array;
+	unsigned long flags;
+	runqueue_t *rq;
+	int oldprio;
+
+	if (prio < 1 || prio > MAX_RT_PRIO-1)
+		return -EINVAL;
+
+	rq = task_rq_lock(p, &flags);
+	array = p->array;
+	if (array)
+		deactivate_task(p, rq);
+	oldprio = p->prio;
+	__setscheduler(p, policy, prio);
+	if (array) {
+		__activate_task(p, rq);
+		if (task_running(rq, p)) {
+			if (p->prio > oldprio)
+				resched_task(rq->curr);
+		} else if (TASK_PREEMPTS_CURR(p, rq))
+			resched_task(rq->curr);
+	}
+	task_rq_unlock(rq, &flags);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(ipipe_setscheduler_root);
+
+int ipipe_reenter_root (struct task_struct *prev, int policy, int prio)
+{
+	finish_task_switch(this_rq(), prev);
+	if (reacquire_kernel_lock(current) < 0)
+		;
+	preempt_enable_no_resched();
+
+	if (current->policy != policy || current->rt_priority != prio)
+		return ipipe_setscheduler_root(current,policy,prio);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(ipipe_reenter_root);
+
+#endif /* CONFIG_IPIPE */
diff -uNrp 2.6.14/kernel/signal.c 2.6.14-ipipe/kernel/signal.c
--- 2.6.14/kernel/signal.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/kernel/signal.c	2005-10-31 10:15:18.000000000 +0100
@@ -601,6 +601,7 @@ void signal_wake_up(struct task_struct *
 	unsigned int mask;
 
 	set_tsk_thread_flag(t, TIF_SIGPENDING);
+	ipipe_sigwake_notify(t); /* TIF_SIGPENDING must be set first. */
 
 	/*
 	 * For SIGKILL, we want to wake it up in the stopped/traced case.
diff -uNrp 2.6.14/lib/smp_processor_id.c 2.6.14-ipipe/lib/smp_processor_id.c
--- 2.6.14/lib/smp_processor_id.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/lib/smp_processor_id.c	2005-10-31 10:15:18.000000000 +0100
@@ -12,6 +12,11 @@ unsigned int debug_smp_processor_id(void
 	int this_cpu = raw_smp_processor_id();
 	cpumask_t this_mask;
 
+#ifdef CONFIG_IPIPE
+ 	if (ipipe_current_domain != ipipe_root_domain)
+	    return this_cpu;
+#endif /* CONFIG_IPIPE */
+
 	if (likely(preempt_count))
 		goto out;
 
diff -uNrp 2.6.14/lib/spinlock_debug.c 2.6.14-ipipe/lib/spinlock_debug.c
--- 2.6.14/lib/spinlock_debug.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/lib/spinlock_debug.c	2005-11-02 19:21:20.000000000 +0100
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 
 static void spin_bug(spinlock_t *lock, const char *msg)
 {
@@ -93,6 +94,8 @@ void _raw_spin_lock(spinlock_t *lock)
 	debug_spin_lock_after(lock);
 }
 
+EXPORT_SYMBOL(_raw_spin_lock);
+
 int _raw_spin_trylock(spinlock_t *lock)
 {
 	int ret = __raw_spin_trylock(&lock->raw_lock);
@@ -108,12 +111,16 @@ int _raw_spin_trylock(spinlock_t *lock)
 	return ret;
 }
 
+EXPORT_SYMBOL(_raw_spin_trylock);
+
 void _raw_spin_unlock(spinlock_t *lock)
 {
 	debug_spin_unlock(lock);
 	__raw_spin_unlock(&lock->raw_lock);
 }
 
+EXPORT_SYMBOL(_raw_spin_unlock);
+
 static void rwlock_bug(rwlock_t *lock, const char *msg)
 {
 	static long print_once = 1;
@@ -162,6 +169,8 @@ void _raw_read_lock(rwlock_t *lock)
 		__read_lock_debug(lock);
 }
 
+EXPORT_SYMBOL(_raw_read_lock);
+
 int _raw_read_trylock(rwlock_t *lock)
 {
 	int ret = __raw_read_trylock(&lock->raw_lock);
@@ -175,12 +184,16 @@ int _raw_read_trylock(rwlock_t *lock)
 	return ret;
 }
 
+EXPORT_SYMBOL(_raw_read_trylock);
+
 void _raw_read_unlock(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
 	__raw_read_unlock(&lock->raw_lock);
 }
 
+EXPORT_SYMBOL(_raw_read_unlock);
+
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
@@ -235,6 +248,8 @@ void _raw_write_lock(rwlock_t *lock)
 	debug_write_lock_after(lock);
 }
 
+EXPORT_SYMBOL(_raw_write_lock);
+
 int _raw_write_trylock(rwlock_t *lock)
 {
 	int ret = __raw_write_trylock(&lock->raw_lock);
@@ -250,8 +265,12 @@ int _raw_write_trylock(rwlock_t *lock)
 	return ret;
 }
 
+EXPORT_SYMBOL(_raw_write_trylock);
+
 void _raw_write_unlock(rwlock_t *lock)
 {
 	debug_write_unlock(lock);
 	__raw_write_unlock(&lock->raw_lock);
 }
+
+EXPORT_SYMBOL(_raw_write_unlock);
diff -uNrp 2.6.14/mm/vmalloc.c 2.6.14-ipipe/mm/vmalloc.c
--- 2.6.14/mm/vmalloc.c	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/mm/vmalloc.c	2005-10-31 10:15:18.000000000 +0100
@@ -18,6 +18,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 
 DEFINE_RWLOCK(vmlist_lock);
@@ -148,10 +149,14 @@ int map_vm_area(struct vm_struct *area, 
 	pgd = pgd_offset_k(addr);
 	spin_lock(&init_mm.page_table_lock);
 	do {
+		pgd_t oldpgd;
+		memcpy(&oldpgd,pgd,sizeof(pgd_t));
 		next = pgd_addr_end(addr, end);
 		err = vmap_pud_range(pgd, addr, next, prot, pages);
 		if (err)
 			break;
+		if (pgd_val(oldpgd) != pgd_val(*pgd))
+			set_pgdir(addr, *pgd);
 	} while (pgd++, addr = next, addr != end);
 	spin_unlock(&init_mm.page_table_lock);
 	flush_cache_vmap((unsigned long) area->addr, end);

-- 
Stelian Pop <stelian@domain.hid>


