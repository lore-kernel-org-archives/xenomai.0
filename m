From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 15/17] cobalt/arm64: dovetail: add architecture bits
Date: Fri, 11 Jun 2021 20:05:41 +0200
Message-Id: <e6a26e85fe80e7a8fdb40081d69be97013ae05d1.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
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

At this chance, fix stale and missing copyright notices. Specifically,
Dmitriy Cherkasov <dmitriy@mperpetuo.com> is the original author of
the Xenomai/arm64 port, based on the ARM implementation; add credit
where it is due.

In the same move, introduce SPDX tags as replacement for GPL
boilerplate for the altered files.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/arm64/dovetail/Makefile    |  5 ++
 .../include/asm/xenomai/calibration.h         | 24 +++++++
 .../dovetail/include/asm/xenomai/features.h   | 15 ++++
 .../dovetail/include/asm/xenomai/fptest.h     | 35 ++++++++++
 .../dovetail/include/asm/xenomai/machine.h    | 33 +++++++++
 .../dovetail/include/asm/xenomai/syscall.h    | 68 +++++++++++++++++++
 .../dovetail/include/asm/xenomai/syscall32.h  | 12 ++++
 .../dovetail/include/asm/xenomai/thread.h     | 22 ++++++
 .../dovetail/include/asm/xenomai/wrappers.h   | 15 ++++
 kernel/cobalt/arch/arm64/dovetail/machine.c   | 41 +++++++++++
 .../arm64/ipipe/include/asm/xenomai/machine.h |  3 +
 kernel/cobalt/arch/arm64/ipipe/machine.c      |  3 +
 12 files changed, 276 insertions(+)
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/Makefile
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h
 create mode 100644 kernel/cobalt/arch/arm64/dovetail/machine.c

diff --git a/kernel/cobalt/arch/arm64/dovetail/Makefile b/kernel/cobalt/arch/arm64/dovetail/Makefile
new file mode 100644
index 000000000..6c872fdb2
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_XENOMAI) += xenomai.o
+
+xenomai-y := machine.o
+
+ccflags-y := -I$(srctree)/arch/arm64/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
new file mode 100644
index 000000000..05cb6f3a5
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
@@ -0,0 +1,24 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2015 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_ARM64_DOVETAIL_CALIBRATION_H
+#define _COBALT_ARM64_DOVETAIL_CALIBRATION_H
+
+static inline void xnarch_get_latencies(struct xnclock_gravity *p)
+{
+	unsigned int sched_latency;
+
+#if CONFIG_XENO_OPT_TIMING_SCHEDLAT != 0
+	sched_latency = CONFIG_XENO_OPT_TIMING_SCHEDLAT;
+#else
+	sched_latency = 5000;
+#endif
+	p->user = sched_latency;
+	p->kernel = CONFIG_XENO_OPT_TIMING_KSCHEDLAT;
+	p->irq = CONFIG_XENO_OPT_TIMING_IRQLAT;
+}
+
+#endif /* !_COBALT_ARM64_DOVETAIL_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h
new file mode 100644
index 000000000..d5a438bab
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h
@@ -0,0 +1,15 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2015 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_ARM64_DOVETAIL_FEATURES_H
+#define _COBALT_ARM64_DOVETAIL_FEATURES_H
+
+struct cobalt_featinfo;
+static inline void collect_arch_features(struct cobalt_featinfo *p) { }
+
+#include <asm/xenomai/uapi/features.h>
+
+#endif /* !_COBALT_ARM64_DOVETAIL_FEATURES_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
new file mode 100644
index 000000000..5f3630dda
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
@@ -0,0 +1,35 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+ */
+
+#ifndef _COBALT_ARM64_DOVETAIL_FPTEST_H
+#define _COBALT_ARM64_DOVETAIL_FPTEST_H
+
+#include <linux/errno.h>
+#include <asm/xenomai/uapi/fptest.h>
+#include <asm/hwcap.h>
+
+#define have_fp (ELF_HWCAP & HWCAP_FP)
+
+static inline int fp_kernel_supported(void)
+{
+	return 0;
+}
+
+static inline int fp_linux_begin(void)
+{
+	return -ENOSYS;
+}
+
+static inline void fp_linux_end(void)
+{
+}
+
+static inline int fp_detect(void)
+{
+	return have_fp ? __COBALT_HAVE_FPU : 0;
+}
+
+#endif /* !_COBALT_ARM64_DOVETAIL_FPTEST_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h
new file mode 100644
index 000000000..e71a5b7e3
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
+ */
+
+#ifndef _COBALT_ARM64_DOVETAIL_MACHINE_H
+#define _COBALT_ARM64_DOVETAIL_MACHINE_H
+
+#include <linux/version.h>
+#include <asm/byteorder.h>
+#include <cobalt/kernel/assert.h>
+
+/* D-side always behaves as PIPT on AArch64 (see arch/arm64/include/asm/cachetype.h) */
+#define xnarch_cache_aliasing() 0
+
+static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
+{
+	int __r;
+
+	/* zero input is not valid */
+	XENO_WARN_ON(COBALT, ul == 0);
+
+	__asm__ ("rbit\t%0, %1\n"
+	         "clz\t%0, %0\n"
+	        : "=r" (__r) : "r"(ul) : "cc");
+
+	return __r;
+}
+
+#include <asm-generic/xenomai/machine.h>
+
+#endif /* !_COBALT_ARM64_DOVETAIL_MACHINE_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h
new file mode 100644
index 000000000..33b4a710f
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h
@@ -0,0 +1,68 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
+ * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_ARM64_DOVETAIL_SYSCALL_H
+#define _COBALT_ARM64_DOVETAIL_SYSCALL_H
+
+#include <linux/errno.h>
+#include <linux/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ptrace.h>
+#include <asm-generic/xenomai/syscall.h>
+
+/*
+ * Cobalt and Linux syscall numbers can be fetched from syscallno,
+ * masking out the __COBALT_SYSCALL_BIT marker.
+ */
+#define __xn_reg_sys(__regs)	((unsigned long)(__regs)->syscallno)
+#define __xn_syscall_p(regs)	((__xn_reg_sys(regs) & __COBALT_SYSCALL_BIT) != 0)
+#define __xn_syscall(__regs)	((unsigned long)(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT))
+
+#define __xn_reg_rval(__regs)	((__regs)->regs[0])
+#define __xn_reg_arg1(__regs)	((__regs)->regs[0])
+#define __xn_reg_arg2(__regs)	((__regs)->regs[1])
+#define __xn_reg_arg3(__regs)	((__regs)->regs[2])
+#define __xn_reg_arg4(__regs)	((__regs)->regs[3])
+#define __xn_reg_arg5(__regs)	((__regs)->regs[4])
+#define __xn_reg_pc(__regs)	((__regs)->pc)
+#define __xn_reg_sp(__regs)	((__regs)->sp)
+
+/*
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
+ */
+#define __xn_rootcall_p(__regs, __code)			\
+	({						\
+		*(__code) = __xn_syscall(__regs);	\
+		*(__code) < NR_syscalls;		\
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
+			unsigned long a3, unsigned long a4,
+			unsigned long a5)
+{
+	/* We need none of these with Dovetail. */
+	return -ENOSYS;
+}
+
+#endif /* !_COBALT_ARM64_DOVETAIL_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h
new file mode 100644
index 000000000..cd0f39245
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2014 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_ARM64_DOVETAIL_SYSCALL32_H
+#define _COBALT_ARM64_DOVETAIL_SYSCALL32_H
+
+#include <asm-generic/xenomai/syscall32.h>
+
+#endif /* !_COBALT_ARM64_DOVETAIL_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h
new file mode 100644
index 000000000..5b60ff34a
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h
@@ -0,0 +1,22 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
+ * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_ARM64_DOVETAIL_THREAD_H
+#define _COBALT_ARM64_DOVETAIL_THREAD_H
+
+#include <asm-generic/xenomai/dovetail/thread.h>
+#include <asm/dovetail.h>
+
+#define xnarch_fault_pc(__regs)	((unsigned long)((__regs)->pc - 4)) /* XXX ? */
+
+#define xnarch_fault_pf_p(__nr)	((__nr) == ARM64_TRAP_ACCESS)
+#define xnarch_fault_bp_p(__nr)	((current->ptrace & PT_PTRACED) &&	\
+				 ((__nr) == ARM64_TRAP_DEBUG || (__nr) == ARM64_TRAP_UNDI))
+
+#define xnarch_fault_notify(__nr) (!xnarch_fault_bp_p(__nr))
+
+#endif /* !_COBALT_ARM64_DOVETAIL_THREAD_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h
new file mode 100644
index 000000000..7a1122fd3
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h
@@ -0,0 +1,15 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2005 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#ifndef _COBALT_ARM64_ASM_WRAPPERS_H
+#define _COBALT_ARM64_ASM_WRAPPERS_H
+
+#include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
+
+#define __put_user_inatomic __put_user
+#define __get_user_inatomic __get_user
+
+#endif /* _COBALT_ARM64_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/machine.c b/kernel/cobalt/arch/arm64/dovetail/machine.c
new file mode 100644
index 000000000..e03d7b9fd
--- /dev/null
+++ b/kernel/cobalt/arch/arm64/dovetail/machine.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2008 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+// Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
+
+#include <linux/mm.h>
+#include <asm/xenomai/machine.h>
+
+static void mach_arm64_prefault(struct vm_area_struct *vma)
+{
+	unsigned long addr;
+	unsigned int flags;
+
+	if ((vma->vm_flags & VM_MAYREAD)) {
+		flags = (vma->vm_flags & VM_MAYWRITE) ? FAULT_FLAG_WRITE : 0;
+		for (addr = vma->vm_start;
+		     addr != vma->vm_end; addr += PAGE_SIZE)
+			handle_mm_fault(vma, addr, flags, NULL);
+	}
+}
+
+static const char *const fault_labels[] = {
+	[ARM64_TRAP_ACCESS] = "Data or instruction abort",
+	[ARM64_TRAP_ALIGN] = "SP/PC alignment abort",
+	[ARM64_TRAP_SEA] = "Synchronous external abort",
+	[ARM64_TRAP_DEBUG] = "Debug trap",
+	[ARM64_TRAP_UNDI] = "Undefined instruction",
+	[ARM64_TRAP_UNDSE] = "Undefined synchronous exception",
+	[ARM64_TRAP_FPE] = "FPSIMD exception",
+	[ARM64_TRAP_SVE] = "SVE access trap",
+	[ARM64_TRAP_BTI] = "Branch target identification trap",
+	[31] = NULL
+};
+
+struct cobalt_machine cobalt_machine = {
+	.name = "arm64",
+	.init = NULL,
+	.late_init = NULL,
+	.cleanup = NULL,
+	.prefault = mach_arm64_prefault,
+	.fault_labels = fault_labels,
+};
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
index 17be10339..c91c8f58e 100644
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
+++ b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
@@ -4,6 +4,9 @@
  *   ARM port
  *     Copyright (C) 2005 Stelian Pop
  *
+ *   ARM64 port
+ *     Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
+ *
  *   Xenomai is free software; you can redistribute it and/or
  *   modify it under the terms of the GNU General Public License as
  *   published by the Free Software Foundation, Inc., 675 Mass Ave,
diff --git a/kernel/cobalt/arch/arm64/ipipe/machine.c b/kernel/cobalt/arch/arm64/ipipe/machine.c
index a215e4caa..521b734da 100644
--- a/kernel/cobalt/arch/arm64/ipipe/machine.c
+++ b/kernel/cobalt/arch/arm64/ipipe/machine.c
@@ -1,6 +1,9 @@
 /**
  *   Copyright (C) 2005 Stelian Pop
  *
+ *   ARM64 port
+ *     Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
+ *
  *   Xenomai is free software; you can redistribute it and/or
  *   modify it under the terms of the GNU General Public License as
  *   published by the Free Software Foundation, Inc., 675 Mass Ave,
-- 
2.26.2


