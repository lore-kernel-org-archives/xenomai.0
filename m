Message-ID: <4776D498.4000802@domain.hid>
Date: Sun, 30 Dec 2007 00:13:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD8B5A7430BC8761D3F18CF9E"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 5/5] consolidate common 32/64-bit code
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8B5A7430BC8761D3F18CF9E
Content-Type: multipart/mixed;
 boundary="------------000603030006000605040201"

This is a multi-part message in MIME format.
--------------000603030006000605040201
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Long patch, short summary: removes more than 700 LOC by pushing common
code in commonly used files. Specifically, there is now only
arch/x86/ipipe.c again.

Jan

--------------000603030006000605040201
Content-Type: text/x-patch;
 name="consolidate-common-code.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="consolidate-common-code.patch"

---
 arch/x86/kernel/Makefile_32     |    2=20
 arch/x86/kernel/Makefile_64     |    2=20
 arch/x86/kernel/entry_64.S      |   30 -
 arch/x86/kernel/ipipe.c         | 1003 +++++++++++++++++++++++++++++++++=
+++++++
 arch/x86/kernel/ipipe_32.c      |  838 ---------------------------------=

 arch/x86/kernel/ipipe_64.c      |  803 --------------------------------
 include/asm-x86/ipipe.h         |  116 ++++
 include/asm-x86/ipipe_32.h      |   85 ---
 include/asm-x86/ipipe_64.h      |   85 ---
 include/asm-x86/ipipe_base.h    |   93 +++
 include/asm-x86/ipipe_base_32.h |   63 --
 include/asm-x86/ipipe_base_64.h |   63 --
 include/asm-x86/unistd_64.h     |    2=20
 13 files changed, 1229 insertions(+), 1956 deletions(-)

Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_base.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base.h
@@ -1,5 +1,98 @@
+/*   -*- linux-c -*-
+ *   include/asm-x86/ipipe_base.h
+ *
+ *   Copyright (C) 2007 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modif=
y
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
+ *   USA; either version 2 of the License, or (at your option) any later=

+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
+ */
+
+#ifndef __X86_IPIPE_BASE_H
+#define __X86_IPIPE_BASE_H
+
 #ifdef CONFIG_X86_32
 # include "ipipe_base_32.h"
 #else
 # include "ipipe_base_64.h"
 #endif
+
+#define ex_do_divide_error			0
+#define ex_do_debug				1
+/* NMI not pipelined. */
+#define ex_do_int3				3
+#define ex_do_overflow				4
+#define ex_do_bounds				5
+#define ex_do_invalid_op			6
+#define ex_device_not_available			7	/* x86_32 */
+#define ex_math_state_restore			7	/* x86_64 */
+/* Double fault not pipelined. */
+#define ex_do_coprocessor_segment_overrun	9
+#define ex_do_invalid_TSS			10
+#define ex_do_segment_not_present		11
+#define ex_do_stack_segment			12
+#define ex_do_general_protection		13
+#define ex_do_page_fault			14
+#define ex_do_spurious_interrupt_bug		15
+#define ex_do_coprocessor_error			16
+#define ex_do_alignment_check			17
+#define ex_machine_check_vector			18
+#define ex_reserved				ex_machine_check_vector
+#define ex_do_simd_coprocessor_error		19
+#define ex_do_iret_error			32
+
+#if !defined(__ASSEMBLY__) && !defined(CONFIG_SMP)
+
+#if __GNUC__ >=3D 4
+/* Alias to ipipe_root_cpudom_var(status) */
+extern unsigned long __ipipe_root_status;
+#else
+extern unsigned long *const __ipipe_root_status_addr;
+#define __ipipe_root_status	(*__ipipe_root_status_addr)
+#endif
+
+static inline void __ipipe_stall_root(void)
+{
+	volatile unsigned long *p =3D &__ipipe_root_status;
+	__asm__ __volatile__("btsl $0,%0;"
+			     :"+m" (*p) : : "memory");
+}
+
+static inline unsigned long __ipipe_test_and_stall_root(void)
+{
+	volatile unsigned long *p =3D &__ipipe_root_status;
+	int oldbit;
+
+	__asm__ __volatile__("btsl $0,%1;"
+			     "sbbl %0,%0;"
+			     :"=3Dr" (oldbit), "+m" (*p)
+			     : : "memory");
+	return oldbit;
+}
+
+static inline unsigned long __ipipe_test_root(void)
+{
+	volatile unsigned long *p =3D &__ipipe_root_status;
+	int oldbit;
+
+	__asm__ __volatile__("btl $0,%1;"
+			     "sbbl %0,%0;"
+			     :"=3Dr" (oldbit)
+			     :"m" (*p));
+	return oldbit;
+}
+
+#endif	/* !__ASSEMBLY__ && !CONFIG_SMP */
+
+#endif	/* !__X86_IPIPE_BASE_H */
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_base_32.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base_32.h
@@ -50,28 +50,6 @@
=20
 #define IPIPE_IRQ_ISHIFT  	5	/* 2^5 for 32bits arch. */
=20
-#define ex_do_divide_error		0
-#define ex_do_debug			1
-/* NMI not pipelined. */
-#define ex_do_int3			3
-#define ex_do_overflow			4
-#define ex_do_bounds			5
-#define ex_do_invalid_op		6
-#define ex_device_not_available		7
-/* Double fault not pipelined. */
-#define ex_do_coprocessor_segment_overrun 9
-#define ex_do_invalid_TSS		10
-#define ex_do_segment_not_present	11
-#define ex_do_stack_segment		12
-#define ex_do_general_protection	13
-#define ex_do_page_fault		14
-#define ex_do_spurious_interrupt_bug	15
-#define ex_do_coprocessor_error		16
-#define ex_do_alignment_check		17
-#define ex_machine_check_vector		18
-#define ex_do_simd_coprocessor_error	19
-#define ex_do_iret_error		32
-
 /* IDT fault vectors */
 #define IPIPE_NR_FAULTS		33 /* 32 from IDT + iret_error */
 /* Pseudo-vectors used for kernel events */
@@ -134,47 +112,6 @@ static inline unsigned long __ipipe_test
 	return oldbit;
 }
=20
-#else /* ! CONFIG_SMP */
-
-#if __GNUC__ >=3D 4
-/* Alias to ipipe_root_cpudom_var(status) */
-extern unsigned long __ipipe_root_status;
-#else
-extern unsigned long *const __ipipe_root_status_addr;
-#define __ipipe_root_status	(*__ipipe_root_status_addr)
-#endif
-
-static inline void __ipipe_stall_root(void)
-{
-	volatile unsigned long *p =3D &__ipipe_root_status;
-	__asm__ __volatile__("btsl $0,%0;"
-			     :"+m" (*p) : : "memory");
-}
-
-static inline unsigned long __ipipe_test_and_stall_root(void)
-{
-	volatile unsigned long *p =3D &__ipipe_root_status;
-	int oldbit;
-
-	__asm__ __volatile__("btsl $0,%1;"
-			     "sbbl %0,%0;"
-			     :"=3Dr" (oldbit), "+m" (*p)
-			     : : "memory");
-	return oldbit;
-}
-
-static inline unsigned long __ipipe_test_root(void)
-{
-	volatile unsigned long *p =3D &__ipipe_root_status;
-	int oldbit;
-
-	__asm__ __volatile__("btl $0,%1;"
-			     "sbbl %0,%0;"
-			     :"=3Dr" (oldbit)
-			     :"m" (*p));
-	return oldbit;
-}
-
 #endif	/* CONFIG_SMP */
=20
 #endif /* !__ASSEMBLY__ */
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_base_64.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_base_64.h
@@ -50,28 +50,6 @@
=20
 #define IPIPE_IRQ_ISHIFT  	6	/* 2^6 for 64bits arch. */
=20
-#define ex_divide_error			0
-#define ex_debug			1
-/* NMI not pipelined. */
-#define ex_int3				3
-#define ex_overflow			4
-#define ex_bounds			5
-#define ex_invalid_op			6
-#define ex_math_state_restore		7
-/* Double fault not pipelined. */
-#define ex_coprocessor_segment_overrun	9
-#define ex_invalid_TSS			10
-#define ex_segment_not_present		11
-#define ex_stack_segment		12
-#define ex_general_protection		13
-#define ex_page_fault			14
-#define ex_spurious_interrupt_bug	15
-#define ex_coprocessor_error		16
-#define ex_alignment_check		17
-#define ex_reserved			18
-#define ex_machine_check_vector		ex_reserved
-#define ex_simd_coprocessor_error	19
-
 /* IDT fault vectors */
 #define IPIPE_NR_FAULTS		32
 /* Pseudo-vectors used for kernel events */
@@ -137,47 +115,6 @@ static inline unsigned long __ipipe_test
 	return oldbit;
 }
=20
-#else /* !CONFIG_SMP */
-
-#if __GNUC__ >=3D 4
-/* Alias to ipipe_root_cpudom_var(status) */
-extern unsigned long __ipipe_root_status;
-#else
-extern unsigned long *const __ipipe_root_status_addr;
-#define __ipipe_root_status	(*__ipipe_root_status_addr)
-#endif
-
-static inline void __ipipe_stall_root(void)
-{
-	volatile unsigned long *p =3D &__ipipe_root_status;
-	__asm__ __volatile__("btsl $0,%0;"
-			     :"+m" (*p) : : "memory");
-}
-
-static inline unsigned long __ipipe_test_and_stall_root(void)
-{
-	volatile unsigned long *p =3D &__ipipe_root_status;
-	int oldbit;
-
-	__asm__ __volatile__("btsl $0,%1;"
-			     "sbbl %0,%0;"
-			     :"=3Dr" (oldbit), "+m" (*p)
-			     : : "memory");
-	return oldbit;
-}
-
-static inline unsigned long __ipipe_test_root(void)
-{
-	volatile unsigned long *p =3D &__ipipe_root_status;
-	int oldbit;
-
-	__asm__ __volatile__("btl $0,%1;"
-			     "sbbl %0,%0;"
-			     :"=3Dr" (oldbit)
-			     :"m" (*p));
-	return oldbit;
-}
-
 #endif	/* CONFIG_SMP */
=20
 #endif /* !__ASSEMBLY__ */
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/Makefile_32
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/Makefile_32
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/Makefile_32
@@ -34,7 +34,7 @@ obj-$(CONFIG_X86_SUMMIT_NUMA)	+=3D summit_
 obj-$(CONFIG_KPROBES)		+=3D kprobes_32.o
 obj-$(CONFIG_MODULES)		+=3D module_32.o
 obj-y				+=3D sysenter_32.o vsyscall_32.o
-obj-$(CONFIG_IPIPE)		+=3D ipipe_32.o
+obj-$(CONFIG_IPIPE)		+=3D ipipe.o
 obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+=3D mcount_32.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat_32.o
 obj-$(CONFIG_EFI) 		+=3D efi_32.o efi_stub_32.o
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/Makefile_64
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/Makefile_64
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/Makefile_64
@@ -35,7 +35,7 @@ obj-$(CONFIG_X86_PM_TIMER)	+=3D pmtimer_64
 obj-$(CONFIG_X86_VSMP)		+=3D vsmp_64.o
 obj-$(CONFIG_K8_NB)		+=3D k8.o
 obj-$(CONFIG_AUDIT)		+=3D audit_64.o
-obj-$(CONFIG_IPIPE)		+=3D ipipe_64.o
+obj-$(CONFIG_IPIPE)		+=3D ipipe.o
 obj-$(CONFIG_IPIPE_TRACE_MCOUNT)	+=3D mcount_64.o
=20
 obj-$(CONFIG_MODULES)		+=3D module_64.o
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe.c
@@ -0,0 +1,1003 @@
+/*   -*- linux-c -*-
+ *   linux/arch/x86/kernel/ipipe.c
+ *
+ *   Copyright (C) 2002-2007 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modif=
y
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
+ *   USA; either version 2 of the License, or (at your option) any later=

+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
+ *
+ *   Architecture-dependent I-PIPE support for x86.
+ */
+
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/clockchips.h>
+#include <asm/unistd.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/hw_irq.h>
+#include <asm/irq.h>
+#include <asm/desc.h>
+#include <asm/io.h>
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/tlbflush.h>
+#include <asm/fixmap.h>
+#include <asm/bitops.h>
+#include <asm/mpspec.h>
+#ifdef CONFIG_X86_IO_APIC
+#include <asm/io_apic.h>
+#endif	/* CONFIG_X86_IO_APIC */
+#ifdef CONFIG_X86_32
+#include <asm/apic.h>
+#include <mach_ipi.h>
+#else /* !CONFIG_X86_32 */
+#include <asm/ipi.h>
+#include <asm/mach_apic.h>
+#endif /* !CONFIG_X86_32 */
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+int __ipipe_tick_irq =3D TIMER_IRQ;
+
+DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
+
+#ifdef CONFIG_SMP
+
+static cpumask_t __ipipe_cpu_sync_map;
+
+static cpumask_t __ipipe_cpu_lock_map;
+
+static IPIPE_DEFINE_SPINLOCK(__ipipe_cpu_barrier);
+
+static atomic_t __ipipe_critical_count =3D ATOMIC_INIT(0);
+
+static void (*__ipipe_cpu_sync) (void);
+
+#endif /* CONFIG_SMP */
+
+/* ipipe_trigger_irq() -- Push the interrupt at front of the pipeline
+   just like if it has been actually received from a hw source. Also
+   works for virtual interrupts. */
+
+int ipipe_trigger_irq(unsigned irq)
+{
+	struct pt_regs regs;
+	unsigned long flags;
+
+	if (irq >=3D IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq) &&
+	     !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	local_irq_save_hw(flags);
+
+	regs.eflags =3D flags;
+#ifdef CONFIG_X86_32
+	regs.orig_eax =3D irq;	/* Positive value - IRQ won't be acked */
+	regs.xcs =3D __KERNEL_CS;
+
+	__ipipe_handle_irq(regs);
+
+#else /* !CONFIG_X86_32 */
+	regs.orig_rax =3D irq;	/* Positive value - IRQ won't be acked */
+	regs.cs =3D __KERNEL_CS;
+
+	__ipipe_handle_irq(&regs);
+#endif /* !CONFIG_X86_32 */
+
+	local_irq_restore_hw(flags);
+
+	return 1;
+}
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
+{
+	info->ncpus =3D num_online_cpus();
+	info->cpufreq =3D ipipe_cpu_freq();
+	info->archdep.tmirq =3D __ipipe_tick_irq;
+#ifdef CONFIG_X86_TSC
+	info->archdep.tmfreq =3D ipipe_cpu_freq();
+#else	/* !CONFIG_X86_TSC */
+	info->archdep.tmfreq =3D CLOCK_TICK_RATE;
+#endif	/* CONFIG_X86_TSC */
+
+	return 0;
+}
+
+unsigned int do_IRQ(struct pt_regs *regs);
+void smp_apic_timer_interrupt(struct pt_regs *regs);
+void smp_spurious_interrupt(struct pt_regs *regs);
+void smp_error_interrupt(struct pt_regs *regs);
+void smp_thermal_interrupt(struct pt_regs *regs);
+void smp_reschedule_interrupt(struct pt_regs *regs);
+void smp_invalidate_interrupt(struct pt_regs *regs);
+void smp_call_function_interrupt(struct pt_regs *regs);
+void mce_threshold_interrupt(struct pt_regs *regs);
+
+static int __ipipe_ack_irq(unsigned irq)
+{
+	irq_desc_t *desc =3D irq_desc + irq;
+	desc->ipipe_ack(irq, desc);
+	return 1;
+}
+
+void __ipipe_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
+{
+	irq_desc[irq].status &=3D ~IRQ_DISABLED;
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+static int __ipipe_noack_apic(unsigned irq)
+{
+	return 1;
+}
+
+int __ipipe_ack_apic(unsigned irq)
+{
+	__ack_APIC_irq();
+	return 1;
+}
+
+static void __ipipe_null_handler(unsigned irq, void *cookie)
+{
+}
+
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+/* __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
+   interrupts are off, and secondary CPUs are still lost in space. */
+
+void __init __ipipe_enable_pipeline(void)
+{
+	unsigned irq;
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+	/* Map the APIC system vectors. */
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR),
+			     (ipipe_irq_handler_t)&smp_apic_timer_interrupt,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(SPURIOUS_APIC_VECTOR),
+			     (ipipe_irq_handler_t)&smp_spurious_interrupt,
+			     NULL,
+			     &__ipipe_noack_apic,
+			     IPIPE_STDROOT_MASK);
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(ERROR_APIC_VECTOR),
+			     (ipipe_irq_handler_t)&smp_error_interrupt,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR0),
+			     &__ipipe_null_handler,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR1),
+			     &__ipipe_null_handler,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR2),
+			     &__ipipe_null_handler,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR3),
+			     &__ipipe_null_handler,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+#if defined(CONFIG_X86_MCE_P4THERMAL) || defined(CONFIG_X86_64)
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(THERMAL_APIC_VECTOR),
+			     (ipipe_irq_handler_t)&smp_thermal_interrupt,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+#endif /* CONFIG_X86_MCE_P4THERMAL || CONFIG_X86_64 */
+
+#ifdef CONFIG_X86_64
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(THRESHOLD_APIC_VECTOR),
+			     (ipipe_irq_handler_t)&mce_threshold_interrupt,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+#endif /* CONFIG_X86_64 */
+
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+#ifdef CONFIG_SMP
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(RESCHEDULE_VECTOR),
+			     (ipipe_irq_handler_t)&smp_reschedule_interrupt,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+#ifdef CONFIG_X86_32
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(INVALIDATE_TLB_VECTOR),
+			     (ipipe_irq_handler_t)&smp_invalidate_interrupt,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+#else /* !CONFIG_X86_32 */
+	{
+		unsigned vector;
+
+		for (vector =3D INVALIDATE_TLB_VECTOR_START;
+		     vector <=3D INVALIDATE_TLB_VECTOR_END; ++vector)
+			ipipe_virtualize_irq(ipipe_root_domain,
+					     ipipe_apic_vector_irq(vector),
+					     (ipipe_irq_handler_t)&smp_invalidate_interrupt,
+					     NULL,
+					     &__ipipe_ack_apic,
+					     IPIPE_STDROOT_MASK);
+	}
+#endif /* !CONFIG_X86_32 */
+
+	ipipe_virtualize_irq(ipipe_root_domain,
+			     ipipe_apic_vector_irq(CALL_FUNCTION_VECTOR),
+			     (ipipe_irq_handler_t)&smp_call_function_interrupt,
+			     NULL,
+			     &__ipipe_ack_apic,
+			     IPIPE_STDROOT_MASK);
+
+#endif	/* CONFIG_SMP */
+
+	/* Finally, virtualize the remaining ISA and IO-APIC
+	 * interrupts. Interrupts which have already been virtualized
+	 * will just beget a silent -EPERM error since
+	 * IPIPE_SYSTEM_MASK has been passed for them, that's ok. */
+
+	for (irq =3D 0; irq < NR_IRQS; irq++)
+		/* Fails for IPIPE_CRITICAL_IPI but that's ok. */
+		ipipe_virtualize_irq(ipipe_root_domain,
+				     irq,
+				     (ipipe_irq_handler_t)&do_IRQ,
+				     NULL,
+				     &__ipipe_ack_irq,
+				     IPIPE_STDROOT_MASK);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+	/* Eventually allow these vectors to be reprogrammed. */
+	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI0].control &=3D ~IPIPE_SYSTEM_=
MASK;
+	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI1].control &=3D ~IPIPE_SYSTEM_=
MASK;
+	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI2].control &=3D ~IPIPE_SYSTEM_=
MASK;
+	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI3].control &=3D ~IPIPE_SYSTEM_=
MASK;
+#endif	/* CONFIG_X86_LOCAL_APIC */
+}
+
+#ifdef CONFIG_SMP
+
+cpumask_t __ipipe_set_irq_affinity(unsigned irq, cpumask_t cpumask)
+{
+	cpumask_t oldmask =3D irq_desc[irq].affinity;
+
+	if (irq_desc[irq].chip->set_affinity =3D=3D NULL)
+		return CPU_MASK_NONE;
+
+	if (cpus_empty(cpumask))
+		return oldmask; /* Return mask value -- no change. */
+
+	cpus_and(cpumask,cpumask,cpu_online_map);
+
+	if (cpus_empty(cpumask))
+		return CPU_MASK_NONE;	/* Error -- bad mask value or non-routable IRQ. =
*/
+
+	irq_desc[irq].chip->set_affinity(irq,cpumask);
+
+	return oldmask;
+}
+
+int __ipipe_send_ipi(unsigned ipi, cpumask_t cpumask)
+{
+	unsigned long flags;
+	int self;
+
+	if (ipi !=3D IPIPE_SERVICE_IPI0 &&
+	    ipi !=3D IPIPE_SERVICE_IPI1 &&
+	    ipi !=3D IPIPE_SERVICE_IPI2 &&
+	    ipi !=3D IPIPE_SERVICE_IPI3)
+		return -EINVAL;
+
+	local_irq_save_hw(flags);
+
+	self =3D cpu_isset(ipipe_processor_id(),cpumask);
+	cpu_clear(ipipe_processor_id(), cpumask);
+
+	if (!cpus_empty(cpumask))
+		send_IPI_mask(cpumask, ipipe_apic_irq_vector(ipi));
+
+	if (self)
+		ipipe_trigger_irq(ipi);
+
+	local_irq_restore_hw(flags);
+
+	return 0;
+}
+
+/* Always called with hw interrupts off. */
+
+void __ipipe_do_critical_sync(unsigned irq, void *cookie)
+{
+	int cpu =3D ipipe_processor_id();
+
+	cpu_set(cpu, __ipipe_cpu_sync_map);
+
+	/* Now we are in sync with the lock requestor running on another
+	   CPU. Enter a spinning wait until he releases the global
+	   lock. */
+	spin_lock(&__ipipe_cpu_barrier);
+
+	/* Got it. Now get out. */
+
+	if (__ipipe_cpu_sync)
+		/* Call the sync routine if any. */
+		__ipipe_cpu_sync();
+
+	spin_unlock(&__ipipe_cpu_barrier);
+
+	cpu_clear(cpu, __ipipe_cpu_sync_map);
+}
+
+void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd)
+{
+	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge =3D &__ipipe_ack_apic;
+	ipd->irqs[IPIPE_CRITICAL_IPI].handler =3D &__ipipe_do_critical_sync;
+	ipd->irqs[IPIPE_CRITICAL_IPI].cookie =3D NULL;
+	/* Immediately handle in the current domain but *never* pass */
+	ipd->irqs[IPIPE_CRITICAL_IPI].control =3D
+		IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK;
+}
+
+#endif	/* CONFIG_SMP */
+
+/* ipipe_critical_enter() -- Grab the superlock excluding all CPUs
+   but the current one from a critical section. This lock is used when
+   we must enforce a global critical section for a single CPU in a
+   possibly SMP system whichever context the CPUs are running. */
+
+unsigned long ipipe_critical_enter(void (*syncfn) (void))
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+#ifdef CONFIG_SMP
+	if (unlikely(num_online_cpus() =3D=3D 1))	/* We might be running a SMP-=
kernel on a UP box... */
+		return flags;
+
+	{
+		int cpu =3D ipipe_processor_id();
+		cpumask_t lock_map;
+
+		if (!cpu_test_and_set(cpu, __ipipe_cpu_lock_map)) {
+			while (cpu_test_and_set(BITS_PER_LONG - 1, __ipipe_cpu_lock_map)) {
+				int n =3D 0;
+				do {
+					cpu_relax();
+				} while (++n < cpu);
+			}
+
+			spin_lock(&__ipipe_cpu_barrier);
+
+			__ipipe_cpu_sync =3D syncfn;
+
+			/* Send the sync IPI to all processors but the current one. */
+			send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
+
+			cpus_andnot(lock_map, cpu_online_map, __ipipe_cpu_lock_map);
+
+			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
+				cpu_relax();
+		}
+
+		atomic_inc(&__ipipe_critical_count);
+	}
+#endif	/* CONFIG_SMP */
+
+	return flags;
+}
+
+/* ipipe_critical_exit() -- Release the superlock. */
+
+void ipipe_critical_exit(unsigned long flags)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() =3D=3D 1)
+		goto out;
+
+	if (atomic_dec_and_test(&__ipipe_critical_count)) {
+		spin_unlock(&__ipipe_cpu_barrier);
+
+		while (!cpus_empty(__ipipe_cpu_sync_map))
+			cpu_relax();
+
+		cpu_clear(ipipe_processor_id(), __ipipe_cpu_lock_map);
+		cpu_clear(BITS_PER_LONG - 1, __ipipe_cpu_lock_map);
+	}
+out:
+#endif	/* CONFIG_SMP */
+
+	local_irq_restore_hw(flags);
+}
+
+static inline void __fixup_if(struct pt_regs *regs)
+{
+	if (!ipipe_root_domain_p)
+		return;
+
+	/*
+	 * Have the saved hw state look like the domain stall bit, so
+	 * that __ipipe_unstall_iret_root() restores the proper
+	 * pipeline state for the root stage upon exit.
+	 */
+
+	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
+		regs->eflags &=3D ~X86_EFLAGS_IF;
+	else
+		regs->eflags |=3D X86_EFLAGS_IF;
+}
+
+#ifdef CONFIG_X86_32
+
+/*
+ * Check the stall bit of the root domain to make sure the existing
+ * preemption opportunity upon in-kernel resumption could be
+ * exploited. In case a rescheduling could take place, the root stage
+ * is stalled before the hw interrupts are re-enabled. This routine
+ * must be called with hw interrupts off.
+ */
+
+asmlinkage int __ipipe_kpreempt_root(struct pt_regs regs)
+{
+	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
+		/* Root stage is stalled: rescheduling denied. */
+		return 0;
+
+	__ipipe_stall_root();
+	local_irq_enable_hw_notrace();
+
+	return 1;	/* Ok, may reschedule now. */
+}
+
+asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
+{
+	/* Emulate IRET's handling of the interrupt flag. */
+
+	local_irq_disable_hw();
+
+	/* Restore the software state as it used to be on kernel
+	   entry. CAUTION: NMIs must *not* return through this
+	   emulation. */
+
+	if (!(regs.eflags & X86_EFLAGS_IF)) {
+		if (!__test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(statu=
s)))
+			trace_hardirqs_off();
+		regs.eflags |=3D X86_EFLAGS_IF;
+	} else {
+		if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status))) {
+			trace_hardirqs_on();
+			__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+		}
+
+		/* Only sync virtual IRQs here, so that we don't recurse
+		   indefinitely in case of an external interrupt flood. */
+
+		if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) !=3D =
0)
+			__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+	}
+#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
+	ipipe_trace_end(0x8000000D);
+#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
+}
+
+asmlinkage int __ipipe_syscall_root(struct pt_regs regs)
+{
+	unsigned long flags;
+
+	__fixup_if(&regs);
+
+	/* This routine either returns:
+	    0 -- if the syscall is to be passed to Linux;
+	   >0 -- if the syscall should not be passed to Linux, and no
+	   tail work should be performed;
+	   <0 -- if the syscall should not be passed to Linux but the
+	   tail work has to be performed (for handling signals etc). */
+
+	if (__ipipe_syscall_watched_p(current, regs.orig_eax) &&
+	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
+	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,&regs) > 0) {
+		/* We might enter here over a non-root domain and exit
+		 * over the root one as a result of the syscall
+		 * (i.e. by recycling the register set of the current
+		 * context across the migration), so we need to fixup
+		 * the interrupt flag upon return too, so that
+		 * __ipipe_unstall_iret_root() resets the correct
+		 * stall bit on exit. */
+		__fixup_if(&regs);
+
+		if (ipipe_root_domain_p && !in_atomic()) {
+			/* Sync pending VIRQs before _TIF_NEED_RESCHED is tested. */
+			local_irq_save_hw(flags);
+			if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) !=3D=
 0)
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+			local_irq_restore_hw(flags);
+			return -1;
+		}
+		return 1;
+	}
+
+	return 0;
+}
+
+#else /* !CONFIG_X86_32 */
+
+#ifdef CONFIG_PREEMPT
+/*
+ * Check the stall bit of the root domain to make sure the existing
+ * preemption opportunity upon in-kernel resumption could be
+ * exploited. In case a rescheduling could take place, the root stage
+ * is stalled before the hw interrupts are re-enabled. This routine
+ * must be called with hw interrupts off.
+ */
+asmlinkage int __ipipe_preempt_schedule_irq(void)
+{
+	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
+		/* Root stage is stalled: rescheduling denied. */
+		return 0;
+
+	__set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+	local_irq_enable_hw();
+	preempt_schedule_irq(); /* Ok, may reschedule now. */
+	local_irq_disable_hw();
+	__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+
+	return 1;
+}
+#endif
+
+asmlinkage int __ipipe_syscall_root(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	__fixup_if(regs);
+
+	/* This routine either returns:
+	    0 -- if the syscall is to be passed to Linux;
+	   >0 -- if the syscall should not be passed to Linux, and no
+	   tail work should be performed;
+	   <0 -- if the syscall should not be passed to Linux but the
+	   tail work has to be performed (for handling signals etc). */
+
+	if (__ipipe_syscall_watched_p(current, regs->orig_rax) &&
+	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
+	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL, regs) > 0) {
+		/* We might enter here over a non-root domain and exit
+		 * over the root one as a result of the syscall
+		 * (i.e. by recycling the register set of the current
+		 * context across the migration), so we need to fixup
+		 * the interrupt flag upon return too, so that
+		 * __ipipe_unstall_iret_root() resets the correct
+		 * stall bit on exit. */
+		__fixup_if(regs);
+
+		if (ipipe_root_domain_p && !in_atomic()) {
+			/* Sync pending VIRQs before _TIF_NEED_RESCHED is tested. */
+			local_irq_save_hw(flags);
+			if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) !=3D=
 0)
+				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
+			local_irq_restore_hw(flags);
+			return -1;
+		}
+		/*
+		 * We are about to run the atomic syscall epilogue;
+		 * switch interrupts off before branching to it.
+		 */
+		local_irq_disable_hw();
+		return 1;
+	}
+
+    return 0;
+}
+
+#endif /* !CONFIG_X86_32 */
+
+static void do_machine_check_vector(struct pt_regs *regs, long error_cod=
e)
+{
+#ifdef CONFIG_X86_MCE
+	void do_machine_check(struct pt_regs *, long);
+	do_machine_check(regs,error_code);
+#endif /* CONFIG_X86_MCE */
+}
+
+void do_divide_error(struct pt_regs *regs, long error_code);
+void do_overflow(struct pt_regs *regs, long error_code);
+void do_bounds(struct pt_regs *regs, long error_code);
+void do_invalid_op(struct pt_regs *regs, long error_code);
+void math_state_restore(struct pt_regs *regs, long error_code);
+void do_coprocessor_segment_overrun(struct pt_regs *regs, long error_cod=
e);
+void do_invalid_TSS(struct pt_regs *regs, long error_code);
+void do_segment_not_present(struct pt_regs *regs, long error_code);
+void do_stack_segment(struct pt_regs *regs, long error_code);
+void do_general_protection(struct pt_regs *regs, long error_code);
+void do_page_fault(struct pt_regs *regs, long error_code);
+void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
+void do_coprocessor_error(struct pt_regs *regs, long error_code);
+void do_alignment_check(struct pt_regs *regs, long error_code);
+void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
+void do_iret_error(struct pt_regs *regs, long error_code);
+
+/* Work around genksyms's issue with over-qualification in decls. */
+
+typedef void __ipipe_exhandler(struct pt_regs *, long);
+
+typedef __ipipe_exhandler *__ipipe_exptr;
+
+static __ipipe_exptr __ipipe_std_extable[] =3D {
+
+	[ex_do_divide_error] =3D &do_divide_error,
+	[ex_do_overflow] =3D &do_overflow,
+	[ex_do_bounds] =3D &do_bounds,
+	[ex_do_invalid_op] =3D &do_invalid_op,
+	[ex_do_coprocessor_segment_overrun] =3D &do_coprocessor_segment_overrun=
,
+	[ex_do_invalid_TSS] =3D &do_invalid_TSS,
+	[ex_do_segment_not_present] =3D &do_segment_not_present,
+	[ex_do_stack_segment] =3D &do_stack_segment,
+	[ex_do_general_protection] =3D do_general_protection,
+	[ex_do_page_fault] =3D &do_page_fault,
+	[ex_do_spurious_interrupt_bug] =3D &do_spurious_interrupt_bug,
+	[ex_do_coprocessor_error] =3D &do_coprocessor_error,
+	[ex_do_alignment_check] =3D &do_alignment_check,
+	[ex_machine_check_vector] =3D &do_machine_check_vector,
+	[ex_do_simd_coprocessor_error] =3D &do_simd_coprocessor_error,
+#ifdef CONFIG_X86_32
+	[ex_do_iret_error] =3D &do_iret_error,
+#else
+	[ex_math_state_restore] =3D &math_state_restore,
+#endif
+};
+
+#ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+
+static int __ipipe_xlate_signo[] =3D {
+
+	[ex_do_divide_error] =3D SIGFPE,
+	[ex_do_debug] =3D SIGTRAP,
+	[2] =3D -1,
+	[ex_do_int3] =3D SIGTRAP,
+	[ex_do_overflow] =3D SIGSEGV,
+	[ex_do_bounds] =3D SIGSEGV,
+	[ex_do_invalid_op] =3D SIGILL,
+	[ex_device_not_available] =3D -1, /* =3D=3D ex_math_state_restore on x8=
6_64 */
+	[8] =3D -1,
+	[ex_do_coprocessor_segment_overrun] =3D SIGFPE,
+	[ex_do_invalid_TSS] =3D SIGSEGV,
+	[ex_do_segment_not_present] =3D SIGBUS,
+	[ex_do_stack_segment] =3D SIGBUS,
+	[ex_do_general_protection] =3D SIGSEGV,
+	[ex_do_page_fault] =3D SIGSEGV,
+	[ex_do_spurious_interrupt_bug] =3D -1,
+	[ex_do_coprocessor_error] =3D -1,
+	[ex_do_alignment_check] =3D SIGBUS,
+	[ex_machine_check_vector] =3D -1,
+	[ex_do_simd_coprocessor_error] =3D -1,
+	[20 ... 31] =3D -1,
+#ifndef CONFIG_X86_64
+	[ex_do_iret_error] =3D SIGSEGV,
+#endif
+};
+#endif /* CONFIG_KGDB */
+
+int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int =
vector)
+{
+	unsigned long flags;
+
+	local_save_flags(flags);
+
+	/* Track the hw interrupt state before calling the Linux
+	 * exception handler, replicating it into the virtual mask. */
+
+	if (irqs_disabled_hw()) {
+		/* Do not trigger the alarm in ipipe_check_context() by using
+		 * plain local_irq_disable(). */
+		__ipipe_stall_root();
+		trace_hardirqs_off();
+		barrier();
+	}
+
+#ifdef CONFIG_KGDB
+	/* catch exception KGDB is interested in over non-root domains */
+	if (!ipipe_root_domain_p &&
+	    __ipipe_xlate_signo[vector] >=3D 0 &&
+	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_c=
ode, regs)) {
+		local_irq_restore(flags);
+		return 1;
+	}
+#endif /* CONFIG_KGDB */
+
+	if (unlikely(ipipe_trap_notify(vector, regs))) {
+		local_irq_restore(flags);
+		return 1;
+	}
+
+	/* Detect unhandled faults over non-root domains. */
+
+	if (unlikely(!ipipe_root_domain_p)) {
+		struct ipipe_domain *ipd =3D ipipe_current_domain;
+
+		/* Switch to root so that Linux can handle the fault cleanly. */
+		ipipe_current_domain =3D ipipe_root_domain;
+
+		ipipe_trace_panic_freeze();
+
+		/* Always warn about user land and unfixable faults. */
+		if ((error_code & 4) || !search_exception_tables(instruction_pointer(r=
egs)))
+			printk(KERN_ERR "BUG: Unhandled exception over domain"
+			       " %s at 0x%lx - switching to ROOT\n",
+			       ipd->name, instruction_pointer(regs));
+#ifdef CONFIG_IPIPE_DEBUG
+		/* Also report fixable ones when debugging is enabled. */
+		else
+			printk(KERN_WARNING "WARNING: Fixable exception over "
+			       "domain %s at 0x%lx - switching to ROOT\n",
+			       ipd->name, instruction_pointer(regs));
+#endif /* CONFIG_IPIPE_DEBUG */
+
+		dump_stack();
+	}
+
+	__ipipe_std_extable[vector](regs, error_code);
+	local_irq_restore(flags);
+	__fixup_if(regs);
+
+	return 0;
+}
+
+int __ipipe_divert_exception(struct pt_regs *regs, int vector)
+{
+#ifdef CONFIG_KGDB
+	/* catch int1 and int3 over non-root domains */
+#ifdef CONFIG_X86_32
+	if (!ipipe_root_domain_p && vector !=3D ex_do_device_not_available) {
+#else
+	if (!ipipe_root_domain_p) {
+#endif
+		unsigned int condition =3D 0;
+
+		if (vector =3D=3D 1)
+			get_debugreg(condition, 6);
+		if (!kgdb_handle_exception(vector, SIGTRAP, condition, regs))
+			return 1;
+	}
+#endif /* CONFIG_KGDB */
+
+	if (ipipe_trap_notify(vector, regs))
+		return 1;
+
+	__fixup_if(regs);
+
+	return 0;
+}
+
+/* __ipipe_handle_irq() -- IPIPE's generic IRQ handler. An optimistic
+   interrupt protection log is maintained here for each domain.  Hw
+   interrupts are off on entry. */
+
+#ifdef CONFIG_X86_32
+int __ipipe_handle_irq(struct pt_regs regs)
+{
+	struct ipipe_domain *this_domain, *next_domain;
+	unsigned irq =3D regs.orig_eax;
+	struct list_head *head, *pos;
+	int m_ack;
+
+	if ((long)regs.orig_eax < 0) {
+		irq =3D ~irq;
+		m_ack =3D 0;
+	} else /* This is a self-triggered interrupt. */
+		m_ack =3D 1;
+
+#else /* !CONFIG_X86_32 */
+int __ipipe_handle_irq(struct pt_regs *regs)
+{
+	struct ipipe_domain *this_domain, *next_domain;
+	unsigned vector =3D regs->orig_rax, irq;
+	struct list_head *head, *pos;
+	int m_ack;
+
+	if ((long)regs->orig_rax < 0) {
+		vector =3D ~vector;
+		if (vector >=3D FIRST_SYSTEM_VECTOR)
+			irq =3D ipipe_apic_vector_irq(vector);
+		else
+			irq =3D __get_cpu_var(vector_irq)[vector];
+		m_ack =3D 0;
+	} else { /* This is a self-triggered one. */
+		irq =3D vector;
+		m_ack =3D 1;
+	}
+
+#endif /* !CONFIG_X86_32 */
+	head =3D __ipipe_pipeline.next;
+	next_domain =3D list_entry(head, struct ipipe_domain, p_link);
+	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))=
) {
+		if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
+			next_domain->irqs[irq].acknowledge(irq);
+		if (likely(__ipipe_dispatch_wired(next_domain, irq))) {
+			goto finalize;
+		} else
+			goto finalize_nosync;
+	}
+
+	this_domain =3D ipipe_current_domain;
+
+	if (test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control))
+		head =3D &this_domain->p_link;
+
+	/* Ack the interrupt. */
+
+	pos =3D head;
+
+	while (pos !=3D &__ipipe_pipeline) {
+		next_domain =3D list_entry(pos, struct ipipe_domain, p_link);
+
+		/*
+		 * For each domain handling the incoming IRQ, mark it
+		 * as pending in its log.
+		 */
+		if (test_bit(IPIPE_HANDLE_FLAG, &next_domain->irqs[irq].control)) {
+			/*
+			 * Domains that handle this IRQ are polled for
+			 * acknowledging it by decreasing priority
+			 * order. The interrupt must be made pending
+			 * _first_ in the domain's status flags before
+			 * the PIC is unlocked.
+			 */
+			__ipipe_set_irq_pending(next_domain, irq);
+
+			if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
+				m_ack =3D next_domain->irqs[irq].acknowledge(irq);
+		}
+
+		/*
+		 * If the domain does not want the IRQ to be passed
+		 * down the interrupt pipe, exit the loop now.
+		 */
+
+		if (!test_bit(IPIPE_PASS_FLAG, &next_domain->irqs[irq].control))
+			break;
+
+		pos =3D next_domain->p_link.next;
+	}
+
+finalize:
+
+	/* Given our deferred dispatching model for regular IRQs, we
+	 * only record CPU regs for the last timer interrupt, so that
+	 * the timer handler charges CPU times properly. It is assumed
+	 * that other interrupt handlers don't actually care for such
+	 * information. */
+
+	if (irq =3D=3D __ipipe_tick_irq) {
+		struct pt_regs *tick_regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
+#ifdef CONFIG_X86_32
+		tick_regs->eflags =3D regs.eflags;
+		tick_regs->xcs =3D regs.xcs;
+		tick_regs->eip =3D regs.eip;
+		tick_regs->ebp =3D regs.ebp;
+#else /* !CONFIG_X86_32 */
+		tick_regs->ss =3D regs->ss;
+		tick_regs->rsp =3D regs->rsp;
+		tick_regs->eflags =3D regs->eflags;
+		tick_regs->cs =3D regs->cs;
+		tick_regs->rip =3D regs->rip;
+		tick_regs->rbp =3D regs->rbp;
+#endif /* !CONFIG_X86_32 */
+	}
+
+	/*
+	 * Now walk the pipeline, yielding control to the highest
+	 * priority domain that has pending interrupt(s) or
+	 * immediately to the current domain if the interrupt has been
+	 * marked as 'sticky'. This search does not go beyond the
+	 * current domain in the pipeline.
+	 */
+
+	__ipipe_walk_pipeline(head);
+
+finalize_nosync:
+
+	if (!ipipe_root_domain_p ||
+	    test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
+		return 0;
+
+#if defined(CONFIG_X86_32) && defined(CONFIG_SMP)
+	/*
+	 * Prevent a spurious rescheduling from being triggered on
+	 * preemptible kernels along the way out through
+	 * ret_from_intr.
+	 */
+	if ((long)regs.orig_eax < 0)
+		__set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
+#endif	/* CONFIG_SMP */
+
+	return 1;
+}
+
+int __ipipe_check_tickdev(const char *devname)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	if (!strcmp(devname, "lapic"))
+		return __ipipe_check_lapic();
+#endif
+
+	return 1;
+}
+
+EXPORT_SYMBOL(__ipipe_tick_irq);
+EXPORT_SYMBOL(ipipe_critical_enter);
+EXPORT_SYMBOL(ipipe_critical_exit);
+EXPORT_SYMBOL(ipipe_trigger_irq);
+EXPORT_SYMBOL(ipipe_get_sysinfo);
+
+EXPORT_SYMBOL_GPL(irq_desc);
+struct task_struct *__switch_to(struct task_struct *prev_p,
+				struct task_struct *next_p);
+EXPORT_SYMBOL_GPL(__switch_to);
+EXPORT_SYMBOL_GPL(show_stack);
+
+#ifdef CONFIG_X86_32
+EXPORT_PER_CPU_SYMBOL_GPL(init_tss);
+#ifdef CONFIG_SMP
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
+#endif /* CONFIG_SMP */
+#else /* !CONFIG_X86_32 */
+EXPORT_SYMBOL_GPL(cpu_gdt_descr);
+#endif /* !CONFIG_X86_32 */
+
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+EXPORT_SYMBOL(tasklist_lock);
+#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
+
+#ifdef CONFIG_IPIPE_TRACE_MCOUNT
+void notrace mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/ipipe_32.c
+++ /dev/null
@@ -1,838 +0,0 @@
-/*   -*- linux-c -*-
- *   linux/arch/x86/kernel/ipipe_32.c
- *
- *   Copyright (C) 2002-2007 Philippe Gerum.
- *
- *   This program is free software; you can redistribute it and/or modif=
y
- *   it under the terms of the GNU General Public License as published b=
y
- *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
- *   USA; either version 2 of the License, or (at your option) any later=

- *   version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
- *
- *   Architecture-dependent I-PIPE support for x86_32.
- */
-
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <linux/clockchips.h>
-#include <asm/unistd.h>
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/hw_irq.h>
-#include <asm/irq.h>
-#include <asm/desc.h>
-#include <asm/io.h>
-#ifdef CONFIG_X86_LOCAL_APIC
-#include <asm/tlbflush.h>
-#include <asm/fixmap.h>
-#include <asm/bitops.h>
-#include <asm/mpspec.h>
-#ifdef CONFIG_X86_IO_APIC
-#include <asm/io_apic.h>
-#endif	/* CONFIG_X86_IO_APIC */
-#include <asm/apic.h>
-#include <mach_ipi.h>
-#endif	/* CONFIG_X86_LOCAL_APIC */
-
-int __ipipe_tick_irq =3D TIMER_IRQ;
-
-DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
-
-#ifdef CONFIG_SMP
-
-static cpumask_t __ipipe_cpu_sync_map;
-
-static cpumask_t __ipipe_cpu_lock_map;
-
-static IPIPE_DEFINE_SPINLOCK(__ipipe_cpu_barrier);
-
-static atomic_t __ipipe_critical_count =3D ATOMIC_INIT(0);
-
-static void (*__ipipe_cpu_sync) (void);
-
-#endif /* CONFIG_SMP */
-
-/* ipipe_trigger_irq() -- Push the interrupt at front of the pipeline
-   just like if it has been actually received from a hw source. Also
-   works for virtual interrupts. */
-
-int fastcall ipipe_trigger_irq(unsigned irq)
-{
-	struct pt_regs regs;
-	unsigned long flags;
-
-	if (irq >=3D IPIPE_NR_IRQS ||
-	    (ipipe_virtual_irq_p(irq) &&
-	     !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
-		return -EINVAL;
-
-	local_irq_save_hw(flags);
-
-	regs.orig_eax =3D irq;	/* Won't be acked */
-	regs.xcs =3D __KERNEL_CS;
-	regs.eflags =3D flags;
-
-	__ipipe_handle_irq(regs);
-
-	local_irq_restore_hw(flags);
-
-	return 1;
-}
-
-int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
-{
-	info->ncpus =3D num_online_cpus();
-	info->cpufreq =3D ipipe_cpu_freq();
-	info->archdep.tmirq =3D __ipipe_tick_irq;
-#ifdef CONFIG_X86_TSC
-	info->archdep.tmfreq =3D ipipe_cpu_freq();
-#else	/* !CONFIG_X86_TSC */
-	info->archdep.tmfreq =3D CLOCK_TICK_RATE;
-#endif	/* CONFIG_X86_TSC */
-
-	return 0;
-}
-
-fastcall unsigned int do_IRQ(struct pt_regs *regs);
-fastcall void smp_apic_timer_interrupt(struct pt_regs *regs);
-fastcall void smp_spurious_interrupt(struct pt_regs *regs);
-fastcall void smp_error_interrupt(struct pt_regs *regs);
-fastcall void smp_thermal_interrupt(struct pt_regs *regs);
-fastcall void smp_reschedule_interrupt(struct pt_regs *regs);
-fastcall void smp_invalidate_interrupt(struct pt_regs *regs);
-fastcall void smp_call_function_interrupt(struct pt_regs *regs);
-
-static int __ipipe_ack_irq(unsigned irq)
-{
-	irq_desc_t *desc =3D irq_desc + irq;
-	desc->ipipe_ack(irq, desc);
-	return 1;
-}
-
-void __ipipe_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
-{
-	irq_desc[irq].status &=3D ~IRQ_DISABLED;
-}
-
-#ifdef CONFIG_X86_LOCAL_APIC
-
-static int __ipipe_noack_apic(unsigned irq)
-{
-	return 1;
-}
-
-int __ipipe_ack_apic(unsigned irq)
-{
-	__ack_APIC_irq();
-	return 1;
-}
-
-static void __ipipe_null_handler(unsigned irq, void *cookie)
-{
-}
-
-#endif	/* CONFIG_X86_LOCAL_APIC */
-
-/* __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
-   interrupts are off, and secondary CPUs are still lost in space. */
-
-void __init __ipipe_enable_pipeline(void)
-{
-	unsigned irq;
-
-#ifdef CONFIG_X86_LOCAL_APIC
-
-	/* Map the APIC system vectors. */
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR),
-			     (ipipe_irq_handler_t)&smp_apic_timer_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(SPURIOUS_APIC_VECTOR),
-			     (ipipe_irq_handler_t)&smp_spurious_interrupt,
-			     NULL,
-			     &__ipipe_noack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(ERROR_APIC_VECTOR),
-			     (ipipe_irq_handler_t)&smp_error_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR0),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR1),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR2),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR3),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-#ifdef CONFIG_X86_MCE_P4THERMAL
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(THERMAL_APIC_VECTOR),
-			     (ipipe_irq_handler_t)&smp_thermal_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-#endif /* CONFIG_X86_MCE_P4THERMAL */
-
-#endif	/* CONFIG_X86_LOCAL_APIC */
-
-#ifdef CONFIG_SMP
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(RESCHEDULE_VECTOR),
-			     (ipipe_irq_handler_t)&smp_reschedule_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(INVALIDATE_TLB_VECTOR),
-			     (ipipe_irq_handler_t)&smp_invalidate_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(CALL_FUNCTION_VECTOR),
-			     (ipipe_irq_handler_t)&smp_call_function_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-#endif	/* CONFIG_SMP */
-
-	/* Finally, virtualize the remaining ISA and IO-APIC
-	 * interrupts. Interrupts which have already been virtualized
-	 * will just beget a silent -EPERM error since
-	 * IPIPE_SYSTEM_MASK has been passed for them, that's ok. */
-
-	for (irq =3D 0; irq < NR_IRQS; irq++)
-		/* Fails for IPIPE_CRITICAL_IPI but that's ok. */
-		ipipe_virtualize_irq(ipipe_root_domain,
-				     irq,
-				     (ipipe_irq_handler_t)&do_IRQ,
-				     NULL,
-				     &__ipipe_ack_irq,
-				     IPIPE_STDROOT_MASK);
-
-#ifdef CONFIG_X86_LOCAL_APIC
-	/* Eventually allow these vectors to be reprogrammed. */
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI0].control &=3D ~IPIPE_SYSTEM_=
MASK;
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI1].control &=3D ~IPIPE_SYSTEM_=
MASK;
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI2].control &=3D ~IPIPE_SYSTEM_=
MASK;
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI3].control &=3D ~IPIPE_SYSTEM_=
MASK;
-#endif	/* CONFIG_X86_LOCAL_APIC */
-}
-
-#ifdef CONFIG_SMP
-
-cpumask_t __ipipe_set_irq_affinity (unsigned irq, cpumask_t cpumask)
-{
-	cpumask_t oldmask =3D irq_desc[irq].affinity;
-
-	if (irq_desc[irq].chip->set_affinity =3D=3D NULL)
-		return CPU_MASK_NONE;
-
-	if (cpus_empty(cpumask))
-		return oldmask; /* Return mask value -- no change. */
-
-	cpus_and(cpumask,cpumask,cpu_online_map);
-
-	if (cpus_empty(cpumask))
-		return CPU_MASK_NONE;	/* Error -- bad mask value or non-routable IRQ. =
*/
-
-	irq_desc[irq].chip->set_affinity(irq,cpumask);
-
-	return oldmask;
-}
-
-int fastcall __ipipe_send_ipi (unsigned ipi, cpumask_t cpumask)
-{
-	unsigned long flags;
-	int self;
-
-	if (ipi !=3D IPIPE_SERVICE_IPI0 &&
-	    ipi !=3D IPIPE_SERVICE_IPI1 &&
-	    ipi !=3D IPIPE_SERVICE_IPI2 &&
-	    ipi !=3D IPIPE_SERVICE_IPI3)
-		return -EINVAL;
-
-	local_irq_save_hw(flags);
-
-	self =3D cpu_isset(ipipe_processor_id(),cpumask);
-	cpu_clear(ipipe_processor_id(), cpumask);
-
-	if (!cpus_empty(cpumask))
-		send_IPI_mask(cpumask,ipipe_apic_irq_vector(ipi));
-
-	if (self)
-		ipipe_trigger_irq(ipi);
-
-	local_irq_restore_hw(flags);
-
-	return 0;
-}
-
-/* Always called with hw interrupts off. */
-
-void __ipipe_do_critical_sync(unsigned irq, void *cookie)
-{
-	int cpu =3D ipipe_processor_id();
-
-	cpu_set(cpu, __ipipe_cpu_sync_map);
-
-	/* Now we are in sync with the lock requestor running on another
-	   CPU. Enter a spinning wait until he releases the global
-	   lock. */
-	spin_lock(&__ipipe_cpu_barrier);
-
-	/* Got it. Now get out. */
-
-	if (__ipipe_cpu_sync)
-		/* Call the sync routine if any. */
-		__ipipe_cpu_sync();
-
-	spin_unlock(&__ipipe_cpu_barrier);
-
-	cpu_clear(cpu, __ipipe_cpu_sync_map);
-}
-
-void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd)
-{
-	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge =3D &__ipipe_ack_apic;
-	ipd->irqs[IPIPE_CRITICAL_IPI].handler =3D &__ipipe_do_critical_sync;
-	ipd->irqs[IPIPE_CRITICAL_IPI].cookie =3D NULL;
-	/* Immediately handle in the current domain but *never* pass */
-	ipd->irqs[IPIPE_CRITICAL_IPI].control =3D
-		IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK;
-}
-
-#endif	/* CONFIG_SMP */
-
-/* ipipe_critical_enter() -- Grab the superlock excluding all CPUs
-   but the current one from a critical section. This lock is used when
-   we must enforce a global critical section for a single CPU in a
-   possibly SMP system whichever context the CPUs are running. */
-
-unsigned long ipipe_critical_enter(void (*syncfn) (void))
-{
-	unsigned long flags;
-
-	local_irq_save_hw(flags);
-
-#ifdef CONFIG_SMP
-	if (unlikely(num_online_cpus() =3D=3D 1))	/* We might be running a SMP-=
kernel on a UP box... */
-		return flags;
-
-	{
-		int cpu =3D ipipe_processor_id();
-		cpumask_t lock_map;
-
-		if (!cpu_test_and_set(cpu, __ipipe_cpu_lock_map)) {
-			while (cpu_test_and_set(BITS_PER_LONG - 1, __ipipe_cpu_lock_map)) {
-				int n =3D 0;
-				do {
-					cpu_relax();
-				} while (++n < cpu);
-			}
-
-			spin_lock(&__ipipe_cpu_barrier);
-
-			__ipipe_cpu_sync =3D syncfn;
-
-			/* Send the sync IPI to all processors but the current one. */
-			send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
-
-			cpus_andnot(lock_map, cpu_online_map, __ipipe_cpu_lock_map);
-
-			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
-				cpu_relax();
-		}
-
-		atomic_inc(&__ipipe_critical_count);
-	}
-#endif	/* CONFIG_SMP */
-
-	return flags;
-}
-
-/* ipipe_critical_exit() -- Release the superlock. */
-
-void ipipe_critical_exit(unsigned long flags)
-{
-#ifdef CONFIG_SMP
-	if (num_online_cpus() =3D=3D 1)
-		goto out;
-
-	if (atomic_dec_and_test(&__ipipe_critical_count)) {
-		spin_unlock(&__ipipe_cpu_barrier);
-
-		while (!cpus_empty(__ipipe_cpu_sync_map))
-			cpu_relax();
-
-		cpu_clear(ipipe_processor_id(), __ipipe_cpu_lock_map);
-		cpu_clear(BITS_PER_LONG - 1, __ipipe_cpu_lock_map);
-	}
-out:
-#endif	/* CONFIG_SMP */
-
-	local_irq_restore_hw(flags);
-}
-
-static inline void __fixup_if(struct pt_regs *regs)
-{
-	if (!ipipe_root_domain_p)
-		return;
-
-	/*
-	 * Have the saved hw state look like the domain stall bit, so
-	 * that __ipipe_unstall_iret_root() restores the proper
-	 * pipeline state for the root stage upon exit.
-	 */
-
-	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
-		regs->eflags &=3D ~X86_EFLAGS_IF;
-	else
-		regs->eflags |=3D X86_EFLAGS_IF;
-}
-
-/*  Check the stall bit of the root domain to make sure the existing
-    preemption opportunity upon in-kernel resumption could be
-    exploited. In case a rescheduling could take place, the root stage
-    is stalled before the hw interrupts are re-enabled. This routine
-    must be called with hw interrupts off. */
-
-asmlinkage int __ipipe_kpreempt_root(struct pt_regs regs)
-{
-	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
-		/* Root stage is stalled: rescheduling denied. */
-		return 0;
-
-	__ipipe_stall_root();
-	local_irq_enable_hw_notrace();
-
-	return 1;	/* Ok, may reschedule now. */
-}
-
-asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
-{
-	/* Emulate IRET's handling of the interrupt flag. */
-
-	local_irq_disable_hw();
-
-	/* Restore the software state as it used to be on kernel
-	   entry. CAUTION: NMIs must *not* return through this
-	   emulation. */
-
-	if (!(regs.eflags & X86_EFLAGS_IF)) {
-		if (!__test_and_set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(statu=
s)))
-			trace_hardirqs_off();
-		regs.eflags |=3D X86_EFLAGS_IF;
-	} else {
-		if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status))) {
-			trace_hardirqs_on();
-			__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
-		}
-
-		/* Only sync virtual IRQs here, so that we don't recurse
-		   indefinitely in case of an external interrupt flood. */
-
-		if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) !=3D =
0)
-			__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
-	}
-#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
-	ipipe_trace_end(0x8000000D);
-#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
-}
-
-asmlinkage int __ipipe_syscall_root(struct pt_regs regs)
-{
-	unsigned long flags;
-
-	__fixup_if(&regs);
-
-	/* This routine either returns:
-	    0 -- if the syscall is to be passed to Linux;
-	   >0 -- if the syscall should not be passed to Linux, and no
-	   tail work should be performed;
-	   <0 -- if the syscall should not be passed to Linux but the
-	   tail work has to be performed (for handling signals etc). */
-
-	if (__ipipe_syscall_watched_p(current, regs.orig_eax) &&
-	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
-	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,&regs) > 0) {
-		/* We might enter here over a non-root domain and exit
-		 * over the root one as a result of the syscall
-		 * (i.e. by recycling the register set of the current
-		 * context across the migration), so we need to fixup
-		 * the interrupt flag upon return too, so that
-		 * __ipipe_unstall_iret_root() resets the correct
-		 * stall bit on exit. */
-		__fixup_if(&regs);
-
-		if (ipipe_root_domain_p && !in_atomic()) {
-			/* Sync pending VIRQs before _TIF_NEED_RESCHED is tested. */
-			local_irq_save_hw(flags);
-			if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) !=3D=
 0)
-				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
-			local_irq_restore_hw(flags);
-			return -1;
-		}
-		return 1;
-	}
-
-    return 0;
-}
-
-static fastcall void do_machine_check_vector(struct pt_regs *regs, long =
error_code)
-{
-#ifdef CONFIG_X86_MCE
-	extern fastcall void (*machine_check_vector)(struct pt_regs *, long);
-	machine_check_vector(regs,error_code);
-#endif /* CONFIG_X86_MCE */
-}
-
-fastcall void do_divide_error(struct pt_regs *regs, long error_code);
-fastcall void do_overflow(struct pt_regs *regs, long error_code);
-fastcall void do_bounds(struct pt_regs *regs, long error_code);
-fastcall void do_invalid_op(struct pt_regs *regs, long error_code);
-fastcall void do_coprocessor_segment_overrun(struct pt_regs *regs, long =
error_code);
-fastcall void do_invalid_TSS(struct pt_regs *regs, long error_code);
-fastcall void do_segment_not_present(struct pt_regs *regs, long error_co=
de);
-fastcall void do_stack_segment(struct pt_regs *regs, long error_code);
-fastcall void do_general_protection(struct pt_regs *regs, long error_cod=
e);
-fastcall void do_page_fault(struct pt_regs *regs, long error_code);
-fastcall void do_spurious_interrupt_bug(struct pt_regs *regs, long error=
_code);
-fastcall void do_coprocessor_error(struct pt_regs *regs, long error_code=
);
-fastcall void do_alignment_check(struct pt_regs *regs, long error_code);=

-fastcall void do_simd_coprocessor_error(struct pt_regs *regs, long error=
_code);
-fastcall void do_iret_error(struct pt_regs *regs, long error_code);
-
-/* Work around genksyms's issue with over-qualification in decls. */
-
-typedef fastcall void __ipipe_exhandler(struct pt_regs *, long);
-
-typedef __ipipe_exhandler *__ipipe_exptr;
-
-static __ipipe_exptr __ipipe_std_extable[] =3D {
-
-	[ex_do_divide_error] =3D &do_divide_error,
-	[ex_do_overflow] =3D &do_overflow,
-	[ex_do_bounds] =3D &do_bounds,
-	[ex_do_invalid_op] =3D &do_invalid_op,
-	[ex_do_coprocessor_segment_overrun] =3D &do_coprocessor_segment_overrun=
,
-	[ex_do_invalid_TSS] =3D &do_invalid_TSS,
-	[ex_do_segment_not_present] =3D &do_segment_not_present,
-	[ex_do_stack_segment] =3D &do_stack_segment,
-	[ex_do_general_protection] =3D do_general_protection,
-	[ex_do_page_fault] =3D &do_page_fault,
-	[ex_do_spurious_interrupt_bug] =3D &do_spurious_interrupt_bug,
-	[ex_do_coprocessor_error] =3D &do_coprocessor_error,
-	[ex_do_alignment_check] =3D &do_alignment_check,
-	[ex_machine_check_vector] =3D &do_machine_check_vector,
-	[ex_do_simd_coprocessor_error] =3D &do_simd_coprocessor_error,
-	[ex_do_iret_error] =3D &do_iret_error,
-};
-
-#ifdef CONFIG_KGDB
-#include <linux/kgdb.h>
-
-static int __ipipe_xlate_signo[] =3D {
-
-	[ex_do_divide_error] =3D SIGFPE,
-	[ex_do_debug] =3D SIGTRAP,
-	[2] =3D -1,
-	[ex_do_int3] =3D SIGTRAP,
-	[ex_do_overflow] =3D SIGSEGV,
-	[ex_do_bounds] =3D SIGSEGV,
-	[ex_do_invalid_op] =3D SIGILL,
-	[ex_device_not_available] =3D -1,
-	[8] =3D -1,
-	[ex_do_coprocessor_segment_overrun] =3D SIGFPE,
-	[ex_do_invalid_TSS] =3D SIGSEGV,
-	[ex_do_segment_not_present] =3D SIGBUS,
-	[ex_do_stack_segment] =3D SIGBUS,
-	[ex_do_general_protection] =3D SIGSEGV,
-	[ex_do_page_fault] =3D SIGSEGV,
-	[ex_do_spurious_interrupt_bug] =3D -1,
-	[ex_do_coprocessor_error] =3D -1,
-	[ex_do_alignment_check] =3D SIGBUS,
-	[ex_machine_check_vector] =3D -1,
-	[ex_do_simd_coprocessor_error] =3D -1,
-	[20 ... 31] =3D -1,
-	[ex_do_iret_error] =3D SIGSEGV,
-};
-#endif /* CONFIG_KGDB */
-
-fastcall int __ipipe_handle_exception(struct pt_regs *regs, long error_c=
ode, int vector)
-{
-	unsigned long flags;
-
-	local_save_flags(flags);
-
-	/* Track the hw interrupt state before calling the Linux
-	 * exception handler, replicating it into the virtual mask. */
-
-	if (irqs_disabled_hw()) {
-		/* Do not trigger the alarm in ipipe_check_context() by using
-		 * plain local_irq_disable(). */
-		__ipipe_stall_root();
-		trace_hardirqs_off();
-		barrier();
-	}
-
-#ifdef CONFIG_KGDB
-	/* catch exception KGDB is interested in over non-root domains */
-	if (!ipipe_root_domain_p &&
-	    __ipipe_xlate_signo[vector] >=3D 0 &&
-	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_c=
ode, regs)) {
-		local_irq_restore(flags);
-		return 1;
-	}
-#endif /* CONFIG_KGDB */
-
-	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore(flags);
-		return 1;
-	}
-
-	/* Detect unhandled faults over non-root domains. */
-
-	if (unlikely(!ipipe_root_domain_p)) {
-		struct ipipe_domain *ipd =3D ipipe_current_domain;
-
-		/* Switch to root so that Linux can handle the fault cleanly. */
-		ipipe_current_domain =3D ipipe_root_domain;
-
-		ipipe_trace_panic_freeze();
-
-		/* Always warn about user land and unfixable faults. */
-		if ((error_code & 4) || !search_exception_tables(regs->eip))
-			printk(KERN_ERR "BUG: Unhandled exception over domain"
-			       " %s at 0x%lx - switching to ROOT\n",
-			       ipd->name, regs->eip);
-#ifdef CONFIG_IPIPE_DEBUG
-		/* Also report fixable ones when debugging is enabled. */
-		else
-			printk(KERN_WARNING "WARNING: Fixable exception over "
-			       "domain %s at 0x%lx - switching to ROOT\n",
-			       ipd->name, regs->eip);
-#endif /* CONFIG_IPIPE_DEBUG */
-
-		dump_stack();
-	}
-
-	__ipipe_std_extable[vector](regs, error_code);
-	local_irq_restore(flags);
-	__fixup_if(regs);
-
-	return 0;
-}
-
-fastcall int __ipipe_divert_exception(struct pt_regs *regs, int vector)
-{
-#ifdef CONFIG_KGDB
-	/* catch int1 and int3 over non-root domains */
-	if (!ipipe_root_domain_p && vector !=3D ex_device_not_available) {
-		unsigned int condition =3D 0;
-		if (vector =3D=3D 1)
-			get_debugreg(condition, 6);
-		if (!kgdb_handle_exception(vector, SIGTRAP, condition, regs))
-			return 1;
-	}
-#endif /* CONFIG_KGDB */
-
-	if (ipipe_trap_notify(vector, regs))
-		return 1;
-
-	__fixup_if(regs);
-
-	return 0;
-}
-
-/* __ipipe_handle_irq() -- IPIPE's generic IRQ handler. An optimistic
-   interrupt protection log is maintained here for each domain.  Hw
-   interrupts are off on entry. */
-
-int __ipipe_handle_irq(struct pt_regs regs)
-{
-	struct ipipe_domain *this_domain, *next_domain;
-	unsigned irq =3D regs.orig_eax;
-	struct list_head *head, *pos;
-	int m_ack;
-
-	if ((long)regs.orig_eax < 0) {
-		irq =3D ~irq;
-		m_ack =3D 0;
-	} else /* This is a self-triggered interrupt. */
-		m_ack =3D 1;
-
-	head =3D __ipipe_pipeline.next;
-	next_domain =3D list_entry(head, struct ipipe_domain, p_link);
-	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))=
) {
-		if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
-			next_domain->irqs[irq].acknowledge(irq);
-		if (likely(__ipipe_dispatch_wired(next_domain, irq))) {
-			goto finalize;
-		} else
-			goto finalize_nosync;
-	}
-
-	this_domain =3D ipipe_current_domain;
-
-	if (test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control))
-		head =3D &this_domain->p_link;
-
-	/* Ack the interrupt. */
-
-	pos =3D head;
-
-	while (pos !=3D &__ipipe_pipeline) {
-		next_domain =3D list_entry(pos, struct ipipe_domain, p_link);
-
-		/*
-		 * For each domain handling the incoming IRQ, mark it
-		 * as pending in its log.
-		 */
-		if (test_bit(IPIPE_HANDLE_FLAG, &next_domain->irqs[irq].control)) {
-			/*
-			 * Domains that handle this IRQ are polled for
-			 * acknowledging it by decreasing priority
-			 * order. The interrupt must be made pending
-			 * _first_ in the domain's status flags before
-			 * the PIC is unlocked.
-			 */
-			__ipipe_set_irq_pending(next_domain, irq);
-
-			if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
-				m_ack =3D next_domain->irqs[irq].acknowledge(irq);
-		}
-
-		/*
-		 * If the domain does not want the IRQ to be passed
-		 * down the interrupt pipe, exit the loop now.
-		 */
-
-		if (!test_bit(IPIPE_PASS_FLAG, &next_domain->irqs[irq].control))
-			break;
-
-		pos =3D next_domain->p_link.next;
-	}
-
-finalize:
-
-	/* Given our deferred dispatching model for regular IRQs, we
-	 * only record CPU regs for the last timer interrupt, so that
-	 * the timer handler charges CPU times properly. It is assumed
-	 * that other interrupt handlers don't actually care for such
-	 * information. */
-
-	if (irq =3D=3D __ipipe_tick_irq) {
-		struct pt_regs *tick_regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
-		tick_regs->eflags =3D regs.eflags;
-		tick_regs->xcs =3D regs.xcs;
-		tick_regs->eip =3D regs.eip;
-		tick_regs->ebp =3D regs.ebp;
-	}
-
-	/*
-	 * Now walk the pipeline, yielding control to the highest
-	 * priority domain that has pending interrupt(s) or
-	 * immediately to the current domain if the interrupt has been
-	 * marked as 'sticky'. This search does not go beyond the
-	 * current domain in the pipeline.
-	 */
-
-	__ipipe_walk_pipeline(head);
-
-finalize_nosync:
-
-	if (!ipipe_root_domain_p ||
-	    test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
-		return 0;
-
-#ifdef CONFIG_SMP
-	/*
-	 * Prevent a spurious rescheduling from being triggered on
-	 * preemptible kernels along the way out through
-	 * ret_from_intr.
-	 */
-	if ((long)regs.orig_eax < 0)
-		__set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
-#endif	/* CONFIG_SMP */
-
-	return 1;
-}
-
-int __ipipe_check_tickdev(const char *devname)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	if (!strcmp(devname, "lapic"))
-		return __ipipe_check_lapic();
-#endif
-
-	return 1;
-}
-
-EXPORT_SYMBOL(__ipipe_tick_irq);
-EXPORT_SYMBOL(ipipe_critical_enter);
-EXPORT_SYMBOL(ipipe_critical_exit);
-EXPORT_SYMBOL(ipipe_trigger_irq);
-EXPORT_SYMBOL(ipipe_get_sysinfo);
-
-EXPORT_SYMBOL_GPL(irq_desc);
-EXPORT_SYMBOL_GPL(__switch_to);
-EXPORT_SYMBOL_GPL(show_stack);
-EXPORT_PER_CPU_SYMBOL_GPL(init_tss);
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-EXPORT_SYMBOL(tasklist_lock);
-#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
-#ifdef CONFIG_SMP
-EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
-#endif /* CONFIG_SMP */
-
-#ifdef CONFIG_IPIPE_TRACE_MCOUNT
-void notrace mcount(void);
-EXPORT_SYMBOL(mcount);
-#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/ipipe_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/ipipe_64.c
+++ /dev/null
@@ -1,803 +0,0 @@
-/*   -*- linux-c -*-
- *   linux/arch/x86/kernel/ipipe_64.c
- *
- *   Copyright (C) 2007 Philippe Gerum.
- *
- *   This program is free software; you can redistribute it and/or modif=
y
- *   it under the terms of the GNU General Public License as published b=
y
- *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
- *   USA; either version 2 of the License, or (at your option) any later=

- *   version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
- *
- *   Architecture-dependent I-PIPE support for x86_64.
- */
-
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <asm/unistd.h>
-#include <asm/system.h>
-#include <asm/atomic.h>
-#include <asm/hw_irq.h>
-#include <asm/irq.h>
-#include <asm/desc.h>
-#include <asm/io.h>
-#include <asm/tlbflush.h>
-#include <asm/fixmap.h>
-#include <asm/bitops.h>
-#include <asm/mpspec.h>
-#include <asm/io_apic.h>
-#include <asm/smp.h>
-#include <asm/ipi.h>
-#include <asm/mach_apic.h>
-
-asmlinkage void preempt_schedule_irq(void);
-
-int __ipipe_tick_irq =3D TIMER_IRQ;
-
-DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
-
-#ifdef CONFIG_SMP
-
-static cpumask_t __ipipe_cpu_sync_map;
-
-static cpumask_t __ipipe_cpu_lock_map;
-
-static IPIPE_DEFINE_SPINLOCK(__ipipe_cpu_barrier);
-
-static atomic_t __ipipe_critical_count =3D ATOMIC_INIT(0);
-
-static void (*__ipipe_cpu_sync) (void);
-
-#endif /* CONFIG_SMP */
-
-/* ipipe_trigger_irq() -- Push the interrupt at front of the pipeline
-   just like if it has been actually received from a hw source. Also
-   works for virtual interrupts. */
-
-int ipipe_trigger_irq(unsigned irq)
-{
-	struct pt_regs regs;
-	unsigned long flags;
-
-	if (irq >=3D IPIPE_NR_IRQS ||
-	    (ipipe_virtual_irq_p(irq) &&
-	     !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
-		return -EINVAL;
-
-	local_irq_save_hw(flags);
-
-	regs.orig_rax =3D irq;	/* Positive value - IRQ won't be acked */
-	regs.cs =3D __KERNEL_CS;
-	regs.eflags =3D flags;
-
-	__ipipe_handle_irq(&regs);
-
-	local_irq_restore_hw(flags);
-
-	return 1;
-}
-
-int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
-{
-	info->ncpus =3D num_online_cpus();
-	info->cpufreq =3D ipipe_cpu_freq();
-	info->archdep.tmirq =3D __ipipe_tick_irq;
-	info->archdep.tmfreq =3D ipipe_cpu_freq();
-
-	return 0;
-}
-
-asmlinkage unsigned int do_IRQ(struct pt_regs *regs);
-asmlinkage void smp_apic_timer_interrupt(struct pt_regs *regs);
-asmlinkage void smp_spurious_interrupt(struct pt_regs *regs);
-asmlinkage void smp_error_interrupt(struct pt_regs *regs);
-asmlinkage void smp_thermal_interrupt(struct pt_regs *regs);
-asmlinkage void smp_reschedule_interrupt(struct pt_regs *regs);
-asmlinkage void smp_invalidate_interrupt(struct pt_regs *regs);
-asmlinkage void smp_call_function_interrupt(struct pt_regs *regs);
-asmlinkage void mce_threshold_interrupt(struct pt_regs *regs);
-
-static int __ipipe_ack_irq(unsigned irq)
-{
-	irq_desc_t *desc =3D irq_desc + irq;
-	desc->ipipe_ack(irq, desc);
-	return 1;
-}
-
-void __ipipe_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq)
-{
-	irq_desc[irq].status &=3D ~IRQ_DISABLED;
-}
-
-static int __ipipe_noack_apic(unsigned irq)
-{
-	return 1;
-}
-
-int __ipipe_ack_apic(unsigned irq)
-{
-	__ack_APIC_irq();
-	return 1;
-}
-
-static void __ipipe_null_handler(unsigned irq, void *cookie)
-{
-}
-
-/* __ipipe_enable_pipeline() -- We are running on the boot CPU, hw
-   interrupts are off, and secondary CPUs are still lost in space. */
-
-void __init __ipipe_enable_pipeline(void)
-{
-	unsigned irq;
-
-	/* Map the APIC system vectors. */
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR),
-			     (ipipe_irq_handler_t)&smp_apic_timer_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(SPURIOUS_APIC_VECTOR),
-			     (ipipe_irq_handler_t)&smp_spurious_interrupt,
-			     NULL,
-			     &__ipipe_noack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(ERROR_APIC_VECTOR),
-			     (ipipe_irq_handler_t)&smp_error_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR0),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR1),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR2),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IPIPE_SERVICE_VECTOR3),
-			     &__ipipe_null_handler,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(THRESHOLD_APIC_VECTOR),
-			     (ipipe_irq_handler_t)&mce_threshold_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(THERMAL_APIC_VECTOR),
-			     (ipipe_irq_handler_t)&smp_thermal_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-#ifdef CONFIG_SMP
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(RESCHEDULE_VECTOR),
-			     (ipipe_irq_handler_t)&smp_reschedule_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-
-	{
-		unsigned vector;
-
-		for (vector =3D INVALIDATE_TLB_VECTOR_START;
-		     vector <=3D INVALIDATE_TLB_VECTOR_END; ++vector)
-			ipipe_virtualize_irq(ipipe_root_domain,
-					     ipipe_apic_vector_irq(vector),
-					     (ipipe_irq_handler_t)&smp_invalidate_interrupt,
-					     NULL,
-					     &__ipipe_ack_apic,
-					     IPIPE_STDROOT_MASK);
-	}
-
-	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(CALL_FUNCTION_VECTOR),
-			     (ipipe_irq_handler_t)&smp_call_function_interrupt,
-			     NULL,
-			     &__ipipe_ack_apic,
-			     IPIPE_STDROOT_MASK);
-#endif	/* CONFIG_SMP */
-
-	/* Finally, virtualize the remaining ISA and IO-APIC
-	 * interrupts. Interrupts which have already been virtualized
-	 * will just beget a silent -EPERM error since
-	 * IPIPE_SYSTEM_MASK has been passed for them, that's ok. */
-
-	for (irq =3D 0; irq < NR_IRQS; irq++)
-		/* Fails for IPIPE_CRITICAL_IPI but that's ok. */
-		ipipe_virtualize_irq(ipipe_root_domain,
-				     irq,
-				     (ipipe_irq_handler_t)&do_IRQ, /* Via thunk. */
-				     NULL,
-				     &__ipipe_ack_irq,
-				     IPIPE_STDROOT_MASK);
-
-	/* Eventually allow these vectors to be reprogrammed. */
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI0].control &=3D ~IPIPE_SYSTEM_=
MASK;
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI1].control &=3D ~IPIPE_SYSTEM_=
MASK;
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI2].control &=3D ~IPIPE_SYSTEM_=
MASK;
-	ipipe_root_domain->irqs[IPIPE_SERVICE_IPI3].control &=3D ~IPIPE_SYSTEM_=
MASK;
-}
-
-#ifdef CONFIG_SMP
-
-cpumask_t __ipipe_set_irq_affinity(unsigned irq, cpumask_t cpumask)
-
-{
-	cpumask_t oldmask =3D irq_desc[irq].affinity;
-
-	if (irq_desc[irq].chip->set_affinity =3D=3D NULL)
-		return CPU_MASK_NONE;
-
-	if (cpus_empty(cpumask))
-		return oldmask; /* Return mask value -- no change. */
-
-	cpus_and(cpumask,cpumask,cpu_online_map);
-
-	if (cpus_empty(cpumask))
-		return CPU_MASK_NONE;	/* Error -- bad mask value or non-routable IRQ. =
*/
-
-	irq_desc[irq].chip->set_affinity(irq,cpumask);
-
-	return oldmask;
-}
-
-int asmlinkage __ipipe_send_ipi(unsigned ipi, cpumask_t cpumask)
-
-{
-	unsigned long flags;
-	int self;
-
-	if (ipi !=3D IPIPE_SERVICE_IPI0 &&
-	    ipi !=3D IPIPE_SERVICE_IPI1 &&
-	    ipi !=3D IPIPE_SERVICE_IPI2 &&
-	    ipi !=3D IPIPE_SERVICE_IPI3)
-		return -EINVAL;
-
-	local_irq_save_hw(flags);
-
-	self =3D cpu_isset(ipipe_processor_id(),cpumask);
-	cpu_clear(ipipe_processor_id(), cpumask);
-
-	if (!cpus_empty(cpumask))
-		send_IPI_mask(cpumask, ipipe_apic_irq_vector(ipi));
-
-	if (self)
-		ipipe_trigger_irq(ipi);
-
-	local_irq_restore_hw(flags);
-
-	return 0;
-}
-
-/* Always called with hw interrupts off. */
-
-void __ipipe_do_critical_sync(unsigned irq, void *cookie)
-{
-	int cpu =3D ipipe_processor_id();
-
-	cpu_set(cpu, __ipipe_cpu_sync_map);
-
-	/* Now we are in sync with the lock requestor running on another
-	   CPU. Enter a spinning wait until he releases the global
-	   lock. */
-	spin_lock(&__ipipe_cpu_barrier);
-
-	/* Got it. Now get out. */
-
-	if (__ipipe_cpu_sync)
-		/* Call the sync routine if any. */
-		__ipipe_cpu_sync();
-
-	spin_unlock(&__ipipe_cpu_barrier);
-
-	cpu_clear(cpu, __ipipe_cpu_sync_map);
-}
-
-void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd)
-{
-	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge =3D &__ipipe_ack_apic;
-	ipd->irqs[IPIPE_CRITICAL_IPI].handler =3D &__ipipe_do_critical_sync;
-	ipd->irqs[IPIPE_CRITICAL_IPI].cookie =3D NULL;
-	/* Immediately handle in the current domain but *never* pass */
-	ipd->irqs[IPIPE_CRITICAL_IPI].control =3D
-		IPIPE_HANDLE_MASK|IPIPE_STICKY_MASK|IPIPE_SYSTEM_MASK;
-}
-
-#endif	/* CONFIG_SMP */
-
-/* ipipe_critical_enter() -- Grab the superlock excluding all CPUs
-   but the current one from a critical section. This lock is used when
-   we must enforce a global critical section for a single CPU in a
-   possibly SMP system whichever context the CPUs are running. */
-
-unsigned long ipipe_critical_enter(void (*syncfn) (void))
-{
-	unsigned long flags;
-
-	local_irq_save_hw(flags);
-
-#ifdef CONFIG_SMP
-	if (unlikely(num_online_cpus() =3D=3D 1))	/* We might be running a SMP-=
kernel on a UP box... */
-		return flags;
-
-	{
-		int cpu =3D ipipe_processor_id();
-		cpumask_t lock_map;
-
-		if (!cpu_test_and_set(cpu, __ipipe_cpu_lock_map)) {
-			while (cpu_test_and_set(BITS_PER_LONG - 1, __ipipe_cpu_lock_map)) {
-				int n =3D 0;
-				do {
-					cpu_relax();
-				} while (++n < cpu);
-			}
-
-			spin_lock(&__ipipe_cpu_barrier);
-
-			__ipipe_cpu_sync =3D syncfn;
-
-			/* Send the sync IPI to all processors but the current one. */
-			send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
-
-			cpus_andnot(lock_map, cpu_online_map, __ipipe_cpu_lock_map);
-
-			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
-				cpu_relax();
-		}
-
-		atomic_inc(&__ipipe_critical_count);
-	}
-#endif	/* CONFIG_SMP */
-
-	return flags;
-}
-
-/* ipipe_critical_exit() -- Release the superlock. */
-
-void ipipe_critical_exit(unsigned long flags)
-{
-#ifdef CONFIG_SMP
-	if (num_online_cpus() =3D=3D 1)
-		goto out;
-
-	if (atomic_dec_and_test(&__ipipe_critical_count)) {
-		spin_unlock(&__ipipe_cpu_barrier);
-
-		while (!cpus_empty(__ipipe_cpu_sync_map))
-			cpu_relax();
-
-		cpu_clear(ipipe_processor_id(), __ipipe_cpu_lock_map);
-		cpu_clear(BITS_PER_LONG - 1, __ipipe_cpu_lock_map);
-	}
-out:
-#endif	/* CONFIG_SMP */
-
-	local_irq_restore_hw(flags);
-}
-
-static inline void __fixup_if(struct pt_regs *regs)
-{
-	if (!ipipe_root_domain_p)
-		return;
-
-	/* Have the saved hw state look like the domain stall bit. */
-
-	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
-		regs->eflags &=3D ~X86_EFLAGS_IF;
-	else
-		regs->eflags |=3D X86_EFLAGS_IF;
-}
-
-#ifdef CONFIG_PREEMPT
-
-/*
- * Check the stall bit of the root domain to make sure the existing
- * preemption opportunity upon in-kernel resumption could be
- * exploited. In case a rescheduling could take place, the root stage
- * is stalled before the hw interrupts are re-enabled. This routine
- * must be called with hw interrupts off.
- */
-asmlinkage int __ipipe_preempt_schedule_irq(void)
-{
-	if (test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
-		/* Root stage is stalled: rescheduling denied. */
-		return 0;
-
-	__set_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
-	local_irq_enable_hw();
-	preempt_schedule_irq(); /* Ok, may reschedule now. */
-	local_irq_disable_hw();
-	__clear_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status));
-
-	return 1;
-}
-
-#endif
-
-asmlinkage int __ipipe_syscall_root(struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	__fixup_if(regs);
-
-	/* This routine either returns:
-	    0 -- if the syscall is to be passed to Linux;
-	   >0 -- if the syscall should not be passed to Linux, and no
-	   tail work should be performed;
-	   <0 -- if the syscall should not be passed to Linux but the
-	   tail work has to be performed (for handling signals etc). */
-
-	if (__ipipe_syscall_watched_p(current, regs->orig_rax) &&
-	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
-	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL, regs) > 0) {
-		/* We might enter here over a non-root domain and exit
-		 * over the root one as a result of the syscall
-		 * (i.e. by recycling the register set of the current
-		 * context across the migration), so we need to fixup
-		 * the interrupt flag upon return too, so that
-		 * __ipipe_unstall_iret_root() resets the correct
-		 * stall bit on exit. */
-		__fixup_if(regs);
-
-		if (ipipe_root_domain_p && !in_atomic()) {
-			/* Sync pending VIRQs before _TIF_NEED_RESCHED is tested. */
-			local_irq_save_hw(flags);
-			if ((ipipe_root_cpudom_var(irqpend_himask) & IPIPE_IRQMASK_VIRT) !=3D=
 0)
-				__ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
-			local_irq_restore_hw(flags);
-			return -1;
-		}
-		/*
-		 * We are about to run the atomic syscall epilogue;
-		 * switch interrupts off before branching to it.
-		 */
-		local_irq_disable_hw();
-		return 1;
-	}
-
-    return 0;
-}
-
-static asmlinkage void do_machine_check_vector(struct pt_regs *regs, lon=
g error_code)
-{
-#ifdef CONFIG_X86_MCE
-	void do_machine_check(struct pt_regs * regs, long error_code);
-	do_machine_check(regs,error_code);
-#endif /* CONFIG_X86_MCE */
-}
-
-asmlinkage void do_divide_error(struct pt_regs *regs, long error_code);
-asmlinkage void do_overflow(struct pt_regs *regs, long error_code);
-asmlinkage void do_bounds(struct pt_regs *regs, long error_code);
-asmlinkage void do_invalid_op(struct pt_regs *regs, long error_code);
-asmlinkage void math_state_restore(struct pt_regs *regs, long error_code=
);
-asmlinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, lon=
g error_code);
-asmlinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
-asmlinkage void do_segment_not_present(struct pt_regs *regs, long error_=
code);
-asmlinkage void do_stack_segment(struct pt_regs *regs, long error_code);=

-asmlinkage void do_general_protection(struct pt_regs *regs, long error_c=
ode);
-asmlinkage void do_page_fault(struct pt_regs *regs, long error_code);
-asmlinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long err=
or_code);
-asmlinkage void do_coprocessor_error(struct pt_regs *regs, long error_co=
de);
-asmlinkage void do_alignment_check(struct pt_regs *regs, long error_code=
);
-asmlinkage void do_simd_coprocessor_error(struct pt_regs *regs, long err=
or_code);
-
-/* Work around genksyms's issue with over-qualification in decls. */
-
-typedef asmlinkage void __ipipe_exhandler(struct pt_regs *, long);
-
-typedef __ipipe_exhandler *__ipipe_exptr;
-
-static __ipipe_exptr __ipipe_std_extable[] =3D {
-
-	[ex_divide_error] =3D &do_divide_error,
-	[ex_overflow] =3D &do_overflow,
-	[ex_bounds] =3D &do_bounds,
-	[ex_invalid_op] =3D &do_invalid_op,
-	[ex_math_state_restore] =3D &math_state_restore,
-	[ex_coprocessor_segment_overrun] =3D &do_coprocessor_segment_overrun,
-	[ex_invalid_TSS] =3D &do_invalid_TSS,
-	[ex_segment_not_present] =3D &do_segment_not_present,
-	[ex_stack_segment] =3D &do_stack_segment,
-	[ex_general_protection] =3D do_general_protection,
-	[ex_page_fault] =3D &do_page_fault,
-	[ex_spurious_interrupt_bug] =3D &do_spurious_interrupt_bug,
-	[ex_coprocessor_error] =3D &do_coprocessor_error,
-	[ex_alignment_check] =3D &do_alignment_check,
-	[ex_machine_check_vector] =3D &do_machine_check_vector,
-	[ex_simd_coprocessor_error] =3D &do_simd_coprocessor_error,
-};
-
-#ifdef CONFIG_KGDB
-#include <linux/kgdb.h>
-
-static int __ipipe_xlate_signo[] =3D {
-
-	[ex_divide_error] =3D SIGFPE,
-	[ex_debug] =3D SIGTRAP,
-	[2] =3D -1,
-	[ex_int3] =3D SIGTRAP,
-	[ex_overflow] =3D SIGSEGV,
-	[ex_bounds] =3D SIGSEGV,
-	[ex_invalid_op] =3D SIGILL,
-	[ex_math_state_restore] =3D -1,
-	[8] =3D -1,
-	[ex_coprocessor_segment_overrun] =3D SIGFPE,
-	[ex_invalid_TSS] =3D SIGSEGV,
-	[ex_segment_not_present] =3D SIGBUS,
-	[ex_stack_segment] =3D SIGBUS,
-	[ex_general_protection] =3D SIGSEGV,
-	[ex_page_fault] =3D SIGSEGV,
-	[ex_spurious_interrupt_bug] =3D -1,
-	[ex_coprocessor_error] =3D -1,
-	[ex_alignment_check] =3D SIGBUS,
-	[ex_machine_check_vector] =3D -1,
-	[ex_simd_coprocessor_error] =3D -1,
-	[20 ... 31] =3D -1,
-};
-#endif /* CONFIG_KGDB */
-
-asmlinkage int __ipipe_handle_exception(struct pt_regs *regs, long error=
_code, int vector)
-{
-	unsigned long flags;
-
-	local_save_flags(flags);
-
-	/* Track the hw interrupt state before calling the Linux
-	 * exception handler, replicating it into the virtual mask. */
-
-	if (irqs_disabled_hw()) {
-		/* Do not trigger the alarm in ipipe_check_context() by using
-		 * plain local_irq_disable(). */
-		__ipipe_stall_root();
-		trace_hardirqs_off();
-		barrier();
-	}
-
-#ifdef CONFIG_KGDB
-	/* catch exception KGDB is interested in over non-root domains */
-	if (ipipe_current_domain !=3D ipipe_root_domain &&
-	    __ipipe_xlate_signo[vector] >=3D 0 &&
-	    !kgdb_handle_exception(vector, __ipipe_xlate_signo[vector], error_c=
ode, regs)) {
-		local_irq_restore(flags);
-		return 1;
-	}
-#endif /* CONFIG_KGDB */
-
-	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore(flags);
-		return 1;
-	}
-
-	/* Detect unhandled faults over non-root domains. */
-
-	if (unlikely(!ipipe_root_domain_p)) {
-		struct ipipe_domain *ipd =3D ipipe_current_domain;
-
-		/* Switch to root so that Linux can handle the fault cleanly. */
-		ipipe_current_domain =3D ipipe_root_domain;
-
-		ipipe_trace_panic_freeze();
-
-		/* Always warn about user land and unfixable faults. */
-		if ((error_code & 4) || !search_exception_tables(regs->rip))
-			printk(KERN_ERR "BUG: Unhandled exception over domain"
-			       " %s at 0x%lx - switching to ROOT\n",
-			       ipd->name, regs->rip);
-#ifdef CONFIG_IPIPE_DEBUG
-		/* Also report fixable ones when debugging is enabled. */
-		else
-			printk(KERN_WARNING "WARNING: Fixable exception over "
-			       "domain %s at 0x%lx - switching to ROOT\n",
-			       ipd->name, regs->rip);
-#endif /* CONFIG_IPIPE_DEBUG */
-
-		dump_stack();
-	}
-
-	__ipipe_std_extable[vector](regs, error_code);
-	local_irq_restore(flags);
-	__fixup_if(regs);
-
-	return 0;
-}
-
-asmlinkage int __ipipe_divert_exception(struct pt_regs *regs, int vector=
)
-{
-#ifdef CONFIG_KGDB
-	/* catch int1 and int3 over non-root domains */
-	if (ipipe_current_domain !=3D ipipe_root_domain) {
-		unsigned int condition =3D 0;
-
-		if (vector =3D=3D 1)
-			get_debugreg(condition, 6);
-		if (!kgdb_handle_exception(vector, SIGTRAP, condition, regs))
-			return 1;
-	}
-#endif /* CONFIG_KGDB */
-
-	if (ipipe_trap_notify(vector, regs))
-		return 1;
-
-	__fixup_if(regs);
-
-	return 0;
-}
-
-/* __ipipe_handle_irq() -- IPIPE's generic IRQ handler. An optimistic
-   interrupt protection log is maintained here for each domain.  Hw
-   interrupts are off on entry. */
-
-int __ipipe_handle_irq(struct pt_regs *regs)
-{
-	struct ipipe_domain *this_domain, *next_domain;
-	unsigned vector =3D regs->orig_rax, irq;
-	struct list_head *head, *pos;
-	int m_ack;
-
-	if ((long)regs->orig_rax < 0) {
-		vector =3D ~vector;
-		if (vector >=3D FIRST_SYSTEM_VECTOR)
-			irq =3D ipipe_apic_vector_irq(vector);
-		else
-			irq =3D __get_cpu_var(vector_irq)[vector];
-		m_ack =3D 0;
-	} else { /* This is a self-triggered one. */
-		irq =3D vector;
-		m_ack =3D 1;
-	}
-
-	head =3D __ipipe_pipeline.next;
-	next_domain =3D list_entry(head, struct ipipe_domain, p_link);
-	if (likely(test_bit(IPIPE_WIRED_FLAG, &next_domain->irqs[irq].control))=
) {
-		if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
-			next_domain->irqs[irq].acknowledge(irq);
-		if (likely(__ipipe_dispatch_wired(next_domain, irq))) {
-			goto finalize;
-		} else
-			goto finalize_nosync;
-	}
-
-	this_domain =3D ipipe_current_domain;
-
-	if (test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control))
-		head =3D &this_domain->p_link;
-
-	/* Ack the interrupt. */
-
-	pos =3D head;
-
-	while (pos !=3D &__ipipe_pipeline) {
-		next_domain =3D list_entry(pos, struct ipipe_domain, p_link);
-
-		/*
-		 * For each domain handling the incoming IRQ, mark it
-		 * as pending in its log.
-		 */
-		if (test_bit(IPIPE_HANDLE_FLAG, &next_domain->irqs[irq].control)) {
-			/*
-			 * Domains that handle this IRQ are polled for
-			 * acknowledging it by decreasing priority
-			 * order. The interrupt must be made pending
-			 * _first_ in the domain's status flags before
-			 * the PIC is unlocked.
-			 */
-			__ipipe_set_irq_pending(next_domain, irq);
-
-			if (!m_ack && next_domain->irqs[irq].acknowledge !=3D NULL)
-				m_ack =3D next_domain->irqs[irq].acknowledge(irq);
-		}
-
-		/*
-		 * If the domain does not want the IRQ to be passed
-		 * down the interrupt pipe, exit the loop now.
-		 */
-
-		if (!test_bit(IPIPE_PASS_FLAG, &next_domain->irqs[irq].control))
-			break;
-
-		pos =3D next_domain->p_link.next;
-	}
-
-finalize:
-
-	if (irq =3D=3D __ipipe_tick_irq) {
-		struct pt_regs *tick_regs =3D &__raw_get_cpu_var(__ipipe_tick_regs);
-		tick_regs->ss =3D regs->ss;
-		tick_regs->rsp =3D regs->rsp;
-		tick_regs->eflags =3D regs->eflags;
-		tick_regs->cs =3D regs->cs;
-		tick_regs->rip =3D regs->rip;
-		tick_regs->rbp =3D regs->rbp;
-	}
-
-	/*
-	 * Now walk the pipeline, yielding control to the highest
-	 * priority domain that has pending interrupt(s) or
-	 * immediately to the current domain if the interrupt has been
-	 * marked as 'sticky'. This search does not go beyond the
-	 * current domain in the pipeline.
-	 */
-
-	__ipipe_walk_pipeline(head);
-
-finalize_nosync:
-
-	if (!ipipe_root_domain_p ||
-	    test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)))
-		return 0;
-
-	return 1;
-}
-
-int __ipipe_check_tickdev(const char *devname)
-{
-	if (!strcmp(devname, "lapic"))
-		return __ipipe_check_lapic();
-
-	return 1;
-}
-
-EXPORT_SYMBOL(__ipipe_tick_irq);
-EXPORT_SYMBOL(ipipe_critical_enter);
-EXPORT_SYMBOL(ipipe_critical_exit);
-EXPORT_SYMBOL(ipipe_trigger_irq);
-EXPORT_SYMBOL(ipipe_get_sysinfo);
-
-EXPORT_SYMBOL_GPL(irq_desc);
-struct task_struct *__switch_to(struct task_struct *prev_p,
-				struct task_struct *next_p);
-EXPORT_SYMBOL_GPL(__switch_to);
-EXPORT_SYMBOL_GPL(show_stack);
-EXPORT_SYMBOL_GPL(cpu_gdt_descr);
-
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-EXPORT_SYMBOL(tasklist_lock);
-#endif /* CONFIG_SMP || CONFIG_DEBUG_SPINLOCK */
-
-#ifdef CONFIG_IPIPE_TRACE_MCOUNT
-void notrace mcount(void);
-EXPORT_SYMBOL(mcount);
-#endif /* CONFIG_IPIPE_TRACE_MCOUNT */
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe.h
@@ -1,11 +1,125 @@
-#if defined(CONFIG_IPIPE) && !defined(IPIPE_ARCH_STRING)
+/*   -*- linux-c -*-
+ *   include/asm-x86/ipipe.h
+ *
+ *   Copyright (C) 2007 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modif=
y
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 0213=
9,
+ *   USA; either version 2 of the License, or (at your option) any later=

+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-130=
7, USA.
+ */
+
+#ifndef __X86_IPIPE_H
+#define __X86_IPIPE_H
+
+#ifdef CONFIG_IPIPE
+
+#ifndef IPIPE_ARCH_STRING
 #define IPIPE_ARCH_STRING	"2.0-00"
 #define IPIPE_MAJOR_NUMBER	2
 #define IPIPE_MINOR_NUMBER	0
 #define IPIPE_PATCH_NUMBER	0
 #endif
+
+DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
+
 #ifdef CONFIG_X86_32
 # include "ipipe_32.h"
 #else
 # include "ipipe_64.h"
 #endif
+
+/*
+ * The logical processor id is read from the PDA, so this is always
+ * safe, regardless of the underlying stack.
+ */
+#define ipipe_processor_id()	raw_smp_processor_id()
+
+#define prepare_arch_switch(next)		\
+do {						\
+	ipipe_schedule_notify(current, next);	\
+	local_irq_disable_hw();			\
+} while(0)
+
+#define task_hijacked(p)						\
+	({ int x =3D !ipipe_root_domain_p; \
+	__clear_bit(IPIPE_SYNC_FLAG, &ipipe_root_cpudom_var(status));	\
+	local_irq_enable_hw(); x; })
+
+struct ipipe_domain;
+
+struct ipipe_sysinfo {
+
+	int ncpus;		/* Number of CPUs on board */
+	u64 cpufreq;		/* CPU frequency (in Hz) */
+
+	/* Arch-dependent block */
+
+	struct {
+		unsigned tmirq;	/* Timer tick IRQ */
+		u64 tmfreq;	/* Timer frequency */
+	} archdep;
+};
+
+/* Private interface -- Internal use only */
+
+#define __ipipe_check_platform()	do { } while(0)
+#define __ipipe_init_platform()		do { } while(0)
+#define __ipipe_enable_irq(irq)		irq_desc[irq].chip->enable(irq)
+#define __ipipe_disable_irq(irq)	irq_desc[irq].chip->disable(irq)
+
+#ifdef CONFIG_SMP
+void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd);
+#else
+#define __ipipe_hook_critical_ipi(ipd) do { } while(0)
+#endif
+
+#define __ipipe_disable_irqdesc(ipd, irq)	do { } while(0)
+
+void __ipipe_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq);
+
+void __ipipe_enable_pipeline(void);
+
+void __ipipe_do_critical_sync(unsigned irq, void *cookie);
+
+extern int __ipipe_tick_irq;
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#define ipipe_update_tick_evtdev(evtdev)				\
+	do {								\
+		if (strcmp((evtdev)->name, "lapic") =3D=3D 0)		\
+			__ipipe_tick_irq =3D				\
+				ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR); \
+		else							\
+			__ipipe_tick_irq =3D TIMER_IRQ;			\
+	} while (0)
+#else
+#define ipipe_update_tick_evtdev(evtdev)				\
+	__ipipe_tick_irq =3D TIMER_IRQ
+#endif
+
+int __ipipe_check_lapic(void);
+
+int __ipipe_check_tickdev(const char *devname);
+
+#define __ipipe_syscall_watched_p(p, sc)	\
+	(((p)->flags & PF_EVNOTIFY) || (unsigned long)sc >=3D NR_syscalls)
+
+#else /* !CONFIG_IPIPE */
+
+#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
+#define task_hijacked(p)			0
+
+#endif /* CONFIG_IPIPE */
+
+#endif	/* !__X86_IPIPE_H */
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_32.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_32.h
@@ -22,44 +22,12 @@
 #ifndef __X86_IPIPE_32_H
 #define __X86_IPIPE_32_H
=20
-#ifdef CONFIG_IPIPE
-
-#ifndef __ASSEMBLY__
-
 #include <linux/cpumask.h>
 #include <linux/list.h>
 #include <linux/threads.h>
 #include <linux/ipipe_percpu.h>
 #include <asm/ptrace.h>
=20
-#define ipipe_processor_id()   raw_smp_processor_id()
-
-#define prepare_arch_switch(next)		\
-do {						\
-	ipipe_schedule_notify(current, next);	\
-	local_irq_disable_hw();			\
-} while(0)
-
-#define task_hijacked(p)						\
-	({ int x =3D !ipipe_root_domain_p; \
-	__clear_bit(IPIPE_SYNC_FLAG, &ipipe_root_cpudom_var(status));	\
-	local_irq_enable_hw(); x; })
-
-struct ipipe_domain;
-
-struct ipipe_sysinfo {
-
-	int ncpus;		/* Number of CPUs on board */
-	u64 cpufreq;		/* CPU frequency (in Hz) */
-
-	/* Arch-dependent block */
-
-	struct {
-		unsigned tmirq;	/* Timer tick IRQ */
-		u64 tmfreq;	/* Timer frequency */
-	} archdep;
-};
-
 #define ipipe_read_tsc(t)  __asm__ __volatile__("rdtsc" : "=3DA" (t))
 #define ipipe_cpu_freq() ({ unsigned long long __freq =3D cpu_has_tsc?(1=
000LL * cpu_khz):CLOCK_TICK_RATE; __freq; })
=20
@@ -79,29 +47,8 @@ struct ipipe_sysinfo {
=20
 /* Private interface -- Internal use only */
=20
-#define __ipipe_check_platform()	do { } while(0)
-#define __ipipe_init_platform()		do { } while(0)
-#define __ipipe_enable_irq(irq)		irq_desc[irq].chip->enable(irq)
-#define __ipipe_disable_irq(irq)	irq_desc[irq].chip->disable(irq)
-
-#ifdef CONFIG_SMP
-void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd);
-#else
-#define __ipipe_hook_critical_ipi(ipd) do { } while(0)
-#endif
-
-#define __ipipe_disable_irqdesc(ipd, irq)	do { } while(0)
-
-void __ipipe_enable_irqdesc(struct ipipe_domain *ipd, unsigned irq);
-
-void __ipipe_enable_pipeline(void);
-
 int __ipipe_handle_irq(struct pt_regs regs);
=20
-void __ipipe_do_critical_sync(unsigned irq, void *cookie);
-
-extern int __ipipe_tick_irq;
-
 static inline unsigned long __ipipe_ffnz(unsigned long ul)
 {
       __asm__("bsrl %1, %0":"=3Dr"(ul)
@@ -109,22 +56,6 @@ static inline unsigned long __ipipe_ffnz
 	return ul;
 }
=20
-#ifdef CONFIG_X86_LOCAL_APIC
-#define ipipe_update_tick_evtdev(evtdev)				\
-	do {								\
-		if (strcmp((evtdev)->name, "lapic") =3D=3D 0)		\
-			__ipipe_tick_irq =3D				\
-				ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR); \
-		else							\
-			__ipipe_tick_irq =3D TIMER_IRQ;			\
-	} while (0)
-#else
-#define ipipe_update_tick_evtdev(evtdev)				\
-	__ipipe_tick_irq =3D TIMER_IRQ
-#endif
-
-DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
-
 static inline void __ipipe_call_root_xirq_handler(unsigned irq,
 						  void (*handler)(unsigned, void *))
 {
@@ -210,20 +141,4 @@ do {									\
 	local_irq_disable_nohead(ipd);					\
 } while(0)
=20
-#endif /* __ASSEMBLY__ */
-
-#define __ipipe_syscall_watched_p(p, sc)	\
-	(((p)->flags & PF_EVNOTIFY) || (unsigned long)sc >=3D NR_syscalls)
-
-int __ipipe_check_lapic(void);
-
-int __ipipe_check_tickdev(const char *devname);
-
-#else /* !CONFIG_IPIPE */
-
-#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
-#define task_hijacked(p)			0
-
-#endif /* CONFIG_IPIPE */
-
 #endif	/* !__X86_IPIPE_32_H */
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/ipipe_64.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/ipipe_64.h
@@ -22,10 +22,6 @@
 #ifndef __X86_IPIPE_64_H
 #define __X86_IPIPE_64_H
=20
-#ifdef CONFIG_IPIPE
-
-#ifndef __ASSEMBLY__
-
 #include <asm/ptrace.h>
 #include <asm/irq.h>
 #include <linux/cpumask.h>
@@ -36,38 +32,6 @@
 #include <linux/thread_info.h>
 #endif
=20
-/*
- * The logical processor id is read from the PDA, so this is always
- * safe, regardless of the underlying stack.
- */
-#define ipipe_processor_id()	raw_smp_processor_id()
-
-#define prepare_arch_switch(next)		\
-do {						\
-	ipipe_schedule_notify(current, next);	\
-	local_irq_disable_hw();			\
-} while(0)
-
-#define task_hijacked(p)						\
-	({ int x =3D !ipipe_root_domain_p; \
-	__clear_bit(IPIPE_SYNC_FLAG, &ipipe_root_cpudom_var(status));	\
-	local_irq_enable_hw(); x; })
-
-struct ipipe_domain;
-
-struct ipipe_sysinfo {
-
-	int ncpus;		/* Number of CPUs on board */
-	u64 cpufreq;		/* CPU frequency (in Hz) */
-
-	/* Arch-dependent block */
-
-	struct {
-		unsigned tmirq;	/* Timer tick IRQ */
-		u64 tmfreq;	/* Timer frequency */
-	} archdep;
-};
-
 #define ipipe_read_tsc(t)  do {		\
 	unsigned int __a,__d;			\
 	asm volatile("rdtsc" : "=3Da" (__a), "=3Dd" (__d)); \
@@ -81,34 +45,10 @@ extern unsigned cpu_khz;
=20
 /* Private interface -- Internal use only */
=20
-#define __ipipe_check_platform()	do { } while(0)
-#define __ipipe_init_platform()		do { } while(0)
-#define __ipipe_enable_irq(irq)		irq_desc[irq].chip->enable(irq)
-#define __ipipe_disable_irq(irq)	irq_desc[irq].chip->disable(irq)
-
-#ifdef CONFIG_SMP
-void __ipipe_hook_critical_ipi(struct ipipe_domain *ipd);
-#else
-#define __ipipe_hook_critical_ipi(ipd)		do { } while(0)
-#endif
-
-#define __ipipe_disable_irqdesc(ipd, irq)	do { } while(0)
-
-void __ipipe_enable_irqdesc(struct ipipe_domain *ipd,
-			    unsigned irq);
-
-void __ipipe_enable_pipeline(void);
-
 int __ipipe_handle_irq(struct pt_regs *regs);
=20
-void __ipipe_do_critical_sync(unsigned irq, void *cookie);
-
 void __ipipe_serial_debug(const char *fmt, ...);
=20
-extern int __ipipe_tick_irq;
-
-DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
-
 unsigned __ipipe_get_irq_vector(int irq);
=20
 static inline unsigned long __ipipe_ffnz(unsigned long ul)
@@ -118,15 +58,6 @@ static inline unsigned long __ipipe_ffnz
       return ul;
 }
=20
-#define ipipe_update_tick_evtdev(evtdev)				\
-	do {								\
-		if (strcmp((evtdev)->name, "lapic") =3D=3D 0)		\
-			__ipipe_tick_irq =3D				\
-				ipipe_apic_vector_irq(LOCAL_TIMER_VECTOR); \
-		else							\
-			__ipipe_tick_irq =3D TIMER_IRQ;			\
-	} while (0)
-
 struct irq_desc;
=20
 void __ipipe_ack_edge_irq(unsigned irq, struct irq_desc *desc);
@@ -227,20 +158,4 @@ static inline void __ipipe_call_root_vir
 		local_irq_disable_nohead(ipd);				\
 	} while(0)
=20
-#endif /* __ASSEMBLY__ */
-
-#define __ipipe_syscall_watched_p(p, sc)	\
-	(((p)->flags & PF_EVNOTIFY) || (unsigned long)sc >=3D __NR_syscalls)
-
-int __ipipe_check_lapic(void);
-
-int __ipipe_check_tickdev(const char *devname);
-
-#else /* !CONFIG_IPIPE */
-
-#define ipipe_update_tick_evtdev(evtdev)	do { } while (0)
-#define task_hijacked(p)			0
-
-#endif /* CONFIG_IPIPE */
-
 #endif	/* !__X86_IPIPE_64_H */
Index: linux-2.6.24-rc6-xeno_64/include/asm-x86/unistd_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/include/asm-x86/unistd_64.h
+++ linux-2.6.24-rc6-xeno_64/include/asm-x86/unistd_64.h
@@ -636,7 +636,7 @@ __SYSCALL(__NR_eventfd, sys_eventfd)
 #define __NR_fallocate				285
 __SYSCALL(__NR_fallocate, sys_fallocate)
=20
-#define __NR_syscalls		286
+#define NR_syscalls		286
=20
 #ifndef __NO_STUBS
 #define __ARCH_WANT_OLD_READDIR
Index: linux-2.6.24-rc6-xeno_64/arch/x86/kernel/entry_64.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.24-rc6-xeno_64.orig/arch/x86/kernel/entry_64.S
+++ linux-2.6.24-rc6-xeno_64/arch/x86/kernel/entry_64.S
@@ -1161,15 +1161,15 @@ ENTRY(kernel_execve)
 ENDPROC(kernel_execve)
=20
 KPROBE_ENTRY(page_fault)
-	errorentry do_page_fault ex_page_fault
+	errorentry do_page_fault ex_do_page_fault
 KPROBE_END(page_fault)
=20
 ENTRY(coprocessor_error)
-	zeroentry do_coprocessor_error ex_coprocessor_error
+	zeroentry do_coprocessor_error ex_do_coprocessor_error
 END(coprocessor_error)
=20
 ENTRY(simd_coprocessor_error)
-	zeroentry do_simd_coprocessor_error ex_simd_coprocessor_error
+	zeroentry do_simd_coprocessor_error ex_do_simd_coprocessor_error
 END(simd_coprocessor_error)
=20
 ENTRY(device_not_available)
@@ -1181,7 +1181,7 @@ KPROBE_ENTRY(debug)
  	INTR_FRAME
 	pushq $0
 	CFI_ADJUST_CFA_OFFSET 8	=09
-	paranoidentry do_debug, DEBUG_STACK, 1, ex_debug
+	paranoidentry do_debug, DEBUG_STACK, 1, ex_do_debug
 	paranoidexit
 KPROBE_END(debug)
=20
@@ -1203,25 +1203,25 @@ KPROBE_ENTRY(int3)
  	INTR_FRAME
  	pushq $0
  	CFI_ADJUST_CFA_OFFSET 8
- 	paranoidentry do_int3, DEBUG_STACK, 1, ex_int3
+ 	paranoidentry do_int3, DEBUG_STACK, 1, ex_do_int3
  	jmp paranoid_exit1
  	CFI_ENDPROC
 KPROBE_END(int3)
=20
 ENTRY(overflow)
-	zeroentry do_overflow ex_overflow
+	zeroentry do_overflow ex_do_overflow
 END(overflow)
=20
 ENTRY(bounds)
-	zeroentry do_bounds ex_bounds
+	zeroentry do_bounds ex_do_bounds
 END(bounds)
=20
 ENTRY(invalid_op)
-	zeroentry do_invalid_op ex_invalid_op
+	zeroentry do_invalid_op ex_do_invalid_op
 END(invalid_op)
=20
 ENTRY(coprocessor_segment_overrun)
-	zeroentry do_coprocessor_segment_overrun ex_coprocessor_segment_overrun=

+	zeroentry do_coprocessor_segment_overrun ex_do_coprocessor_segment_over=
run
 END(coprocessor_segment_overrun)
=20
 ENTRY(reserved)
@@ -1237,11 +1237,11 @@ ENTRY(double_fault)
 END(double_fault)
=20
 ENTRY(invalid_TSS)
-	errorentry do_invalid_TSS ex_invalid_TSS
+	errorentry do_invalid_TSS ex_do_invalid_TSS
 END(invalid_TSS)
=20
 ENTRY(segment_not_present)
-	errorentry do_segment_not_present ex_segment_not_present
+	errorentry do_segment_not_present ex_do_segment_not_present
 END(segment_not_present)
=20
 	/* runs on exception stack */
@@ -1253,19 +1253,19 @@ ENTRY(stack_segment)
 END(stack_segment)
=20
 KPROBE_ENTRY(general_protection)
-	errorentry do_general_protection ex_general_protection
+	errorentry do_general_protection ex_do_general_protection
 KPROBE_END(general_protection)
=20
 ENTRY(alignment_check)
-	errorentry do_alignment_check ex_alignment_check
+	errorentry do_alignment_check ex_do_alignment_check
 END(alignment_check)
=20
 ENTRY(divide_error)
-	zeroentry do_divide_error ex_divide_error
+	zeroentry do_divide_error ex_do_divide_error
 END(divide_error)
=20
 ENTRY(spurious_interrupt_bug)
-	zeroentry do_spurious_interrupt_bug ex_spurious_interrupt_bug
+	zeroentry do_spurious_interrupt_bug ex_do_spurious_interrupt_bug
 END(spurious_interrupt_bug)
=20
 #ifdef CONFIG_X86_MCE

--------------000603030006000605040201--

--------------enigD8B5A7430BC8761D3F18CF9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHdtSYniDOoMHTA+kRAr7cAJ0Sa9+U9uzjE74GskJovh2eIwOYJwCdHC2c
JhkMsgQt5nheIHLOkmPX6YU=
=Gx/W
-----END PGP SIGNATURE-----

--------------enigD8B5A7430BC8761D3F18CF9E--

