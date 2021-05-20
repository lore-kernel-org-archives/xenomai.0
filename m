From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 09/25] cobalt/x86: dovetail: add architecture bits
Date: Thu, 20 May 2021 23:44:19 +0200
Message-Id: <2492e0a1505087e0dca4967474676774d7bd45cc.1621547075.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1621547075.git.jan.kiszka@siemens.com>
References: <cover.1621547075.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
[Jan: style fixes, dropped/linked shared files]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/x86/dovetail/Makefile      |  5 ++
 kernel/cobalt/arch/x86/dovetail/c1e.c         |  1 +
 .../include/asm/xenomai/calibration.h         | 37 ++++++++
 .../x86/dovetail/include/asm/xenomai/fptest.h | 70 +++++++++++++++
 .../dovetail/include/asm/xenomai/machine.h    | 34 +++++++
 .../dovetail/include/asm/xenomai/syscall.h    | 90 +++++++++++++++++++
 .../x86/dovetail/include/asm/xenomai/thread.h | 38 ++++++++
 kernel/cobalt/arch/x86/dovetail/machine.c     | 70 +++++++++++++++
 kernel/cobalt/arch/x86/dovetail/smi.c         |  1 +
 kernel/cobalt/arch/x86/ipipe/smi.c            |  4 +-
 10 files changed, 348 insertions(+), 2 deletions(-)
 create mode 100644 kernel/cobalt/arch/x86/dovetail/Makefile
 create mode 120000 kernel/cobalt/arch/x86/dovetail/c1e.c
 create mode 100644 kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h
 create mode 100644 kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
 create mode 100644 kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/machine.h
 create mode 100644 kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h
 create mode 100644 kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
 create mode 100644 kernel/cobalt/arch/x86/dovetail/machine.c
 create mode 120000 kernel/cobalt/arch/x86/dovetail/smi.c

diff --git a/kernel/cobalt/arch/x86/dovetail/Makefile b/kernel/cobalt/arch/x86/dovetail/Makefile
new file mode 100644
index 0000000000..93929b6455
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/Makefile
@@ -0,0 +1,5 @@
+
+obj-$(CONFIG_XENOMAI) += xenomai.o
+xenomai-y := machine.o smi.o c1e.o
+
+ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/x86/dovetail/c1e.c b/kernel/cobalt/arch/x86/dovetail/c1e.c
new file mode 120000
index 0000000000..5dc924ec6c
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/c1e.c
@@ -0,0 +1 @@
+../ipipe/c1e.c
\ No newline at end of file
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h
new file mode 100644
index 0000000000..29d2924477
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2001,2002,2003,2004,2005 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+#ifndef _COBALT_X86_ASM_CALIBRATION_H
+#define _COBALT_X86_ASM_CALIBRATION_H
+
+static inline void xnarch_get_latencies(struct xnclock_gravity *p)
+{
+	unsigned long sched_latency;
+
+#if CONFIG_XENO_OPT_TIMING_SCHEDLAT != 0
+	sched_latency = CONFIG_XENO_OPT_TIMING_SCHEDLAT;
+#else /* !CONFIG_XENO_OPT_TIMING_SCHEDLAT */
+	sched_latency = num_online_cpus() > 1 ? 3350 : 2000;
+#endif /* !CONFIG_XENO_OPT_TIMING_SCHEDLAT */
+
+	p->user = sched_latency;
+	p->kernel = CONFIG_XENO_OPT_TIMING_KSCHEDLAT;
+	p->irq = CONFIG_XENO_OPT_TIMING_IRQLAT;
+}
+
+#endif /* !_COBALT_X86_ASM_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
new file mode 100644
index 0000000000..83a6413d5f
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+#ifndef _COBALT_X86_ASM_FPTEST_H
+#define _COBALT_X86_ASM_FPTEST_H
+
+#include <linux/errno.h>
+#include <asm/processor.h>
+#include <asm/xenomai/wrappers.h>
+#include <asm/xenomai/uapi/fptest.h>
+
+/*
+ * We do NOT support out-of-band FPU operations in kernel space for a
+ * reason: this is a mess. Out-of-band FPU is just fine and makes a
+ * lot of sense for many real-time applications, but you have to do
+ * that from userland.
+ */
+static inline int fp_kernel_supported(void)
+{
+	return 0;
+}
+
+static inline int fp_linux_begin(void)
+{
+	kernel_fpu_begin();
+	/*
+	 * We need a clean context for testing the sanity of the FPU
+	 * register stack across switches in fp_regs_check()
+	 * (fildl->fistpl), which kernel_fpu_begin() does not
+	 * guarantee us. Force this manually.
+	 */
+	asm volatile("fninit");
+
+	return true;
+}
+
+static inline void fp_linux_end(void)
+{
+	kernel_fpu_end();
+}
+
+static inline int fp_detect(void)
+{
+	int features = 0;
+
+	if (boot_cpu_has(X86_FEATURE_XMM2))
+		features |= __COBALT_HAVE_SSE2;
+
+	if (boot_cpu_has(X86_FEATURE_AVX))
+		features |= __COBALT_HAVE_AVX;
+
+	return features;
+}
+
+#endif /* _COBALT_X86_ASM_FPTEST_H */
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/machine.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/machine.h
new file mode 100644
index 0000000000..56b1c4861f
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/machine.h
@@ -0,0 +1,34 @@
+/**
+ * Copyright (C) 2007-2012 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+#ifndef _COBALT_X86_ASM_MACHINE_H
+#define _COBALT_X86_ASM_MACHINE_H
+
+#include <linux/compiler.h>
+
+static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
+{
+	__asm__("bsfq %1, %0":"=r" (ul) : "rm" (ul));
+
+	return ul;
+}
+
+/* Read this last to enable default settings. */
+#include <asm-generic/xenomai/machine.h>
+
+#endif /* !_COBALT_X86_ASM_MACHINE_H */
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h
new file mode 100644
index 0000000000..c64196b6a1
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2001-2014 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+#ifndef _COBALT_X86_ASM_SYSCALL_H
+#define _COBALT_X86_ASM_SYSCALL_H
+
+#include <linux/errno.h>
+#include <asm/ptrace.h>
+#include <asm-generic/xenomai/syscall.h>
+
+/*
+ * Cobalt and Linux syscall numbers can be fetched from ORIG_AX,
+ * masking out the __COBALT_SYSCALL_BIT marker.
+ */
+#define __xn_reg_sys(regs)    ((regs)->orig_ax)
+#define __xn_reg_rval(regs)   ((regs)->ax)
+#define __xn_reg_arg1(regs)   ((regs)->di)
+#define __xn_reg_arg2(regs)   ((regs)->si)
+#define __xn_reg_arg3(regs)   ((regs)->dx)
+#define __xn_reg_arg4(regs)   ((regs)->r10)
+#define __xn_reg_arg5(regs)   ((regs)->r8)
+#define __xn_reg_pc(regs)     ((regs)->ip)
+#define __xn_reg_sp(regs)     ((regs)->sp)
+
+#define __xn_syscall_p(regs)  (__xn_reg_sys(regs) & __COBALT_SYSCALL_BIT)
+#ifdef CONFIG_XENO_ARCH_SYS3264
+#define __xn_syscall(regs)    __COBALT_CALL32_SYSNR(__xn_reg_sys(regs)	\
+				    & ~__COBALT_SYSCALL_BIT)
+#else
+#define __xn_syscall(regs)    (__xn_reg_sys(regs) & ~__COBALT_SYSCALL_BIT)
+#endif
+
+#ifdef CONFIG_IA32_EMULATION
+#define __xn_nr_root_syscalls						\
+	({								\
+		struct thread_info *__ti = current_thread_info();	\
+		__ti->status & TS_COMPAT ? IA32_NR_syscalls : NR_syscalls; \
+	})
+#else
+#define __xn_nr_root_syscalls	NR_syscalls
+#endif
+/*
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
+ */
+#define __xn_rootcall_p(__regs, __code)			\
+	({						\
+		*(__code) = __xn_reg_sys(__regs);	\
+		*(__code) < __xn_nr_root_syscalls;	\
+	})
+
+static inline void __xn_error_return(struct pt_regs *regs, int v)
+{
+	__xn_reg_rval(regs) = v;
+}
+
+static inline void __xn_status_return(struct pt_regs *regs, long v)
+{
+	__xn_reg_rval(regs) = v;
+}
+
+static inline int __xn_interrupted_p(struct pt_regs *regs)
+{
+	return __xn_reg_rval(regs) == -EINTR;
+}
+
+static inline
+int xnarch_local_syscall(unsigned long a1, unsigned long a2,
+			 unsigned long a3, unsigned long a4,
+			 unsigned long a5)
+{
+	return -ENOSYS;
+}
+
+#endif /* !_COBALT_X86_ASM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
new file mode 100644
index 0000000000..73ecd945cd
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2001-2013 Philippe Gerum <rpm@xenomai.org>.
+ * Copyright (C) 2004-2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+#ifndef _COBALT_X86_ASM_THREAD_H
+#define _COBALT_X86_ASM_THREAD_H
+
+#include <linux/dovetail.h>
+#include <asm-generic/xenomai/thread.h>
+#include <asm/traps.h>
+
+struct xnarchtcb {
+	struct xntcb core;
+	struct dovetail_altsched_context altsched;
+};
+
+#define xnarch_fault_pc(__regs)		((__regs)->ip)
+#define xnarch_fault_pf_p(__nr)		((__nr) == X86_TRAP_PF)
+#define xnarch_fault_bp_p(__nr)		((current->ptrace & PT_PTRACED) &&	\
+					 ((__nr) == X86_TRAP_DB || (__nr) == X86_TRAP_BP))
+#define xnarch_fault_notify(__nr)	(!xnarch_fault_bp_p(__nr))
+
+#endif /* !_COBALT_X86_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/x86/dovetail/machine.c b/kernel/cobalt/arch/x86/dovetail/machine.c
new file mode 100644
index 0000000000..562de40dcb
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/machine.c
@@ -0,0 +1,70 @@
+/**
+ *   Copyright (C) 2007-2012 Philippe Gerum.
+ *
+ *   Xenomai is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License as
+ *   published by the Free Software Foundation, Inc., 675 Mass Ave,
+ *   Cambridge MA 02139, USA; either version 2 of the License, or (at
+ *   your option) any later version.
+ *
+ *   Xenomai is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *   General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ *   02111-1307, USA.
+ */
+
+#include <asm/xenomai/machine.h>
+#include <asm/xenomai/smi.h>
+#include <asm/xenomai/c1e.h>
+
+static int mach_x86_init(void)
+{
+	mach_x86_c1e_disable();
+	mach_x86_smi_init();
+	mach_x86_smi_disable();
+
+	return 0;
+}
+
+static void mach_x86_cleanup(void)
+{
+	mach_x86_smi_restore();
+}
+
+static const char *const fault_labels[] = {
+    [0] = "Divide error",
+    [1] = "Debug",
+    [2] = "",   /* NMI is not pipelined. */
+    [3] = "Int3",
+    [4] = "Overflow",
+    [5] = "Bounds",
+    [6] = "Invalid opcode",
+    [7] = "FPU not available",
+    [8] = "Double fault",
+    [9] = "FPU segment overrun",
+    [10] = "Invalid TSS",
+    [11] = "Segment not present",
+    [12] = "Stack segment",
+    [13] = "General protection",
+    [14] = "Page fault",
+    [15] = "Spurious interrupt",
+    [16] = "FPU error",
+    [17] = "Alignment check",
+    [18] = "Machine check",
+    [19] = "SIMD error",
+    [20] = NULL,
+};
+
+struct cobalt_machine cobalt_machine = {
+	.name = "x86",
+	.init = mach_x86_init,
+	.late_init = NULL,
+	.cleanup = mach_x86_cleanup,
+	.prefault = NULL,
+	.fault_labels = fault_labels,
+};
diff --git a/kernel/cobalt/arch/x86/dovetail/smi.c b/kernel/cobalt/arch/x86/dovetail/smi.c
new file mode 120000
index 0000000000..8d197210f4
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/smi.c
@@ -0,0 +1 @@
+../ipipe/smi.c
\ No newline at end of file
diff --git a/kernel/cobalt/arch/x86/ipipe/smi.c b/kernel/cobalt/arch/x86/ipipe/smi.c
index 7f7c9fd135..f28af9a3b5 100644
--- a/kernel/cobalt/arch/x86/ipipe/smi.c
+++ b/kernel/cobalt/arch/x86/ipipe/smi.c
@@ -109,7 +109,7 @@ static const char *smi_state_labels[] = {
 	"detect",
 	"enabled",
 };
-	
+
 static void setup_smi_state(void)
 {
 	static char warn_bad_state[] =
@@ -147,7 +147,7 @@ void mach_x86_smi_init(void)
 	 * Just register the used ports.
 	 */
 	dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (dev == NULL || dev->bus->number || 
+	if (dev == NULL || dev->bus->number ||
 	    dev->devfn != DEVFN || dev->vendor != PCI_VENDOR_ID_INTEL) {
 		pci_dev_put(dev);
 		return;
-- 
2.26.2


