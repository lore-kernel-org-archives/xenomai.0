From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 08/17] cobalt/arm: dovetail: add architecture bits
Date: Fri, 11 Jun 2021 20:05:34 +0200
Message-Id: <0b2563bb99e65305f60787be2177e1543fd4a6a9.1623434743.git.jan.kiszka@siemens.com>
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

The license notice for arch/arm/dovetail/machine.c is fixed in order
to match the remaining code, which is [1] for the prefaulting handler,
and myself for the rest.

[1] from Xenomai v2.5-rc1:

commit 8421cc62502db56b90d2912ea5f6049536177204
Author: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date:   Sat Nov 15 23:45:24 2008 +0000

    Fault heaps memory on ARM

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
[Jan: style fix]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/arm/Kconfig                |  4 +
 kernel/cobalt/arch/arm/dovetail/Makefile      |  5 +
 .../include/asm/xenomai/calibration.h         | 39 ++++++++
 .../dovetail/include/asm/xenomai/features.h   | 30 ++++++
 .../arm/dovetail/include/asm/xenomai/fptest.h | 52 ++++++++++
 .../dovetail/include/asm/xenomai/machine.h    | 72 ++++++++++++++
 .../dovetail/include/asm/xenomai/syscall.h    | 94 +++++++++++++++++++
 .../dovetail/include/asm/xenomai/syscall32.h  | 24 +++++
 .../arm/dovetail/include/asm/xenomai/thread.h | 32 +++++++
 .../dovetail/include/asm/xenomai/wrappers.h   | 27 ++++++
 kernel/cobalt/arch/arm/dovetail/machine.c     | 44 +++++++++
 11 files changed, 423 insertions(+)
 create mode 100644 kernel/cobalt/arch/arm/dovetail/Makefile
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/machine.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall32.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h
 create mode 100644 kernel/cobalt/arch/arm/dovetail/machine.c

diff --git a/kernel/cobalt/arch/arm/Kconfig b/kernel/cobalt/arch/arm/Kconfig
index d81ff4c59..b0cbdc3b7 100644
--- a/kernel/cobalt/arch/arm/Kconfig
+++ b/kernel/cobalt/arch/arm/Kconfig
@@ -10,3 +10,7 @@ config XENO_ARCH_SYS3264
 config XENO_ARCH_OUTOFLINE_XNLOCK
        bool
        default y
+
+config XENO_ARCH_IPIPE_COMPAT
+       def_bool DOVETAIL
+       select IPIPE_COMPAT
diff --git a/kernel/cobalt/arch/arm/dovetail/Makefile b/kernel/cobalt/arch/arm/dovetail/Makefile
new file mode 100644
index 000000000..13cbf84a9
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/Makefile
@@ -0,0 +1,5 @@
+
+obj-$(CONFIG_XENOMAI) += xenomai.o
+xenomai-y := machine.o
+
+ccflags-y := -I$(srctree)/arch/arm/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
new file mode 100644
index 000000000..c4724372d
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2001-2021 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * ARM port
+ *   Copyright (C) 2005 Stelian Pop
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
+#ifndef _COBALT_ARM_DOVETAIL_CALIBRATION_H
+#define _COBALT_ARM_DOVETAIL_CALIBRATION_H
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
+#endif /* !_COBALT_ARM_DOVETAIL_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h
new file mode 100644
index 000000000..9c0af20e7
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * ARM port
+ *   Copyright (C) 2005 Stelian Pop
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
+#ifndef _COBALT_ARM_DOVETAIL_FEATURES_H
+#define _COBALT_ARM_DOVETAIL_FEATURES_H
+
+struct cobalt_featinfo;
+static inline void collect_arch_features(struct cobalt_featinfo *p) { }
+
+#include <asm/xenomai/uapi/features.h>
+
+#endif /* !_COBALT_ARM_DOVETAIL_FEATURES_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
new file mode 100644
index 000000000..ad7814cce
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
@@ -0,0 +1,52 @@
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
+#ifndef _COBALT_ARM_DOVETAIL_FPTEST_H
+#define _COBALT_ARM_DOVETAIL_FPTEST_H
+
+#include <linux/errno.h>
+#include <asm/hwcap.h>
+
+#ifdef CONFIG_VFP
+#define have_vfp (elf_hwcap & HWCAP_VFP)
+#else /* !CONFIG_VFP */
+#define have_vfp 0
+#endif /* !CONFIG_VFP */
+
+#include <asm/xenomai/uapi/fptest.h>
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
+	return have_vfp ? __COBALT_HAVE_VFP : 0;
+}
+
+#endif /* _COBALT_ARM_DOVETAIL_FPTEST_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/machine.h
new file mode 100644
index 000000000..a694a7891
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/machine.h
@@ -0,0 +1,72 @@
+/**
+ *   Copyright &copy; 2002-2004 Philippe Gerum.
+ *
+ *   ARM port
+ *     Copyright (C) 2005 Stelian Pop
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
+ *   along with Xenomai; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ *   02111-1307, USA.
+ */
+#ifndef _COBALT_ARM_DOVETAIL_MACHINE_H
+#define _COBALT_ARM_DOVETAIL_MACHINE_H
+
+#include <linux/version.h>
+#include <asm/byteorder.h>
+#include <asm/cacheflush.h>
+
+#define xnarch_cache_aliasing() cache_is_vivt()
+
+#if __LINUX_ARM_ARCH__ < 5
+static inline __attribute_const__ unsigned long ffnz(unsigned long x)
+{
+	int r = 0;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+#else
+static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
+{
+	int __r;
+	__asm__("clz\t%0, %1" : "=r" (__r) : "r"(ul & (-ul)) : "cc");
+	return 31 - __r;
+}
+#endif
+
+#include <asm-generic/xenomai/machine.h>
+
+#endif /* !_COBALT_ARM_DOVETAIL_MACHINE_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
new file mode 100644
index 000000000..eb4ec1bbe
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * ARM port
+ *   Copyright (C) 2005 Stelian Pop
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
+#ifndef _COBALT_ARM_DOVETAIL_SYSCALL_H
+#define _COBALT_ARM_DOVETAIL_SYSCALL_H
+
+#include <linux/errno.h>
+#include <linux/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/ptrace.h>
+#include <asm-generic/xenomai/syscall.h>
+
+/*
+ * Cobalt syscall numbers can be fetched from ARM_ORIG_r0 with ARM_r7
+ * containing the Xenomai syscall marker, Linux syscalls directly from
+ * ARM_r7. Since we have to work with Dovetail whilst remaining binary
+ * compatible with applications built for the I-pipe, we retain the
+ * old syscall signature based on receiving XENO_ARM_SYSCALL in
+ * ARM_r7, possibly ORed with __COBALT_SYSCALL_BIT by Dovetail
+ * (IPIPE_COMPAT mode).
+ *
+ * FIXME: We also have __COBALT_SYSCALL_BIT (equal to
+ * __OOB_SYSCALL_BIT) present in the actual syscall number in r0,
+ * which is pretty much useless. Oh, well...  When support for the
+ * I-pipe is dropped, we may switch back to the regular convention
+ * Dovetail abides by, with the actual syscall number into r7 ORed
+ * with __OOB_SYSCALL_BIT, freeing r0 for passing a call argument.
+ */
+#define __xn_reg_sys(__regs)	((__regs)->ARM_ORIG_r0)
+#define __xn_syscall_p(__regs)	(((__regs)->ARM_r7 & ~__COBALT_SYSCALL_BIT) == XENO_ARM_SYSCALL)
+#define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
+
+/*
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
+ */
+#define __xn_rootcall_p(__regs, __code)					\
+	({								\
+		*(__code) = (__regs)->ARM_r7;				\
+		*(__code) < NR_syscalls || *(__code) >= __ARM_NR_BASE;	\
+	})
+
+#define __xn_reg_rval(__regs)	((__regs)->ARM_r0)
+#define __xn_reg_arg1(__regs)	((__regs)->ARM_r1)
+#define __xn_reg_arg2(__regs)	((__regs)->ARM_r2)
+#define __xn_reg_arg3(__regs)	((__regs)->ARM_r3)
+#define __xn_reg_arg4(__regs)	((__regs)->ARM_r4)
+#define __xn_reg_arg5(__regs)	((__regs)->ARM_r5)
+#define __xn_reg_pc(__regs)	((__regs)->ARM_ip)
+#define __xn_reg_sp(__regs)	((__regs)->ARM_sp)
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
+#endif /* !_COBALT_ARM_DOVETAIL_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall32.h
new file mode 100644
index 000000000..95c5a1168
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall32.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2014 Philippe Gerum <rpm@xenomai.org>.
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
+#ifndef _COBALT_ARM_ASM_SYSCALL32_H
+#define _COBALT_ARM_ASM_SYSCALL32_H
+
+#include <asm-generic/xenomai/syscall32.h>
+
+#endif /* !_COBALT_ARM_ASM_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h
new file mode 100644
index 000000000..792a3d26c
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2005 Stelian Pop
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
+#ifndef _COBALT_ARM_DOVETAIL_THREAD_H
+#define _COBALT_ARM_DOVETAIL_THREAD_H
+
+#include <asm-generic/xenomai/dovetail/thread.h>
+#include <asm/traps.h>
+
+#define xnarch_fault_pc(__regs)	((__regs)->ARM_pc - (thumb_mode(__regs) ? 2 : 4))
+#define xnarch_fault_pf_p(__nr)	((__nr) == ARM_TRAP_ACCESS)
+#define xnarch_fault_bp_p(__nr)	((current->ptrace & PT_PTRACED) &&	\
+					((__nr) == ARM_TRAP_BREAK ||	\
+						(__nr) == ARM_TRAP_UNDEFINSTR))
+#define xnarch_fault_notify(__nr) (!xnarch_fault_bp_p(__nr))
+
+#endif /* !_COBALT_ARM_DOVETAIL_THREAD_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h
new file mode 100644
index 000000000..fe598966c
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
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
+#ifndef _COBALT_ARM_ASM_WRAPPERS_H
+#define _COBALT_ARM_ASM_WRAPPERS_H
+
+#include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
+
+#define __put_user_inatomic __put_user
+#define __get_user_inatomic __get_user
+
+#endif /* _COBALT_ARM_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/machine.c b/kernel/cobalt/arch/arm/dovetail/machine.c
new file mode 100644
index 000000000..bc32f177c
--- /dev/null
+++ b/kernel/cobalt/arch/arm/dovetail/machine.c
@@ -0,0 +1,44 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2008 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+ * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#include <linux/mm.h>
+#include <asm/xenomai/machine.h>
+
+static void mach_arm_prefault(struct vm_area_struct *vma)
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
+	[ARM_TRAP_ACCESS] = "Data or instruction access",
+	[ARM_TRAP_SECTION] = "Section fault",
+	[ARM_TRAP_DABT] = "Generic data abort",
+	[ARM_TRAP_PABT] = "Prefetch abort",
+	[ARM_TRAP_BREAK] = "Instruction breakpoint",
+	[ARM_TRAP_FPU] = "Floating point exception",
+	[ARM_TRAP_VFP] = "VFP Floating point exception",
+	[ARM_TRAP_UNDEFINSTR] = "Undefined instruction",
+	[ARM_TRAP_ALIGNMENT] = "Unaligned access exception",
+	[31] = NULL
+};
+
+struct cobalt_machine cobalt_machine = {
+	.name = "arm",
+	.init = NULL,
+	.late_init = NULL,
+	.cleanup = NULL,
+	.prefault = mach_arm_prefault,
+	.fault_labels = fault_labels,
+};
-- 
2.26.2


