From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 2/5] cobalt: Drop support for I-pipe based kernels
Date: Thu, 16 Dec 2021 16:48:22 +0100
Message-ID: <e5828320637f1e959e6c60f71d5e8cb1f0d7cd8b.1639669704.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1639669704.git.jan.kiszka@siemens.com>
References: <cover.1639669704.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This means Dovetail-only, 5.10+.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/asciidoc/README.INSTALL.adoc              |   31 +-
 include/cobalt/kernel/ipipe/pipeline/clock.h  |   45 -
 .../kernel/ipipe/pipeline/inband_work.h       |   32 -
 include/cobalt/kernel/ipipe/pipeline/irq.h    |   14 -
 .../cobalt/kernel/ipipe/pipeline/kevents.h    |   36 -
 include/cobalt/kernel/ipipe/pipeline/lock.h   |   21 -
 .../cobalt/kernel/ipipe/pipeline/machine.h    |   55 -
 .../cobalt/kernel/ipipe/pipeline/pipeline.h   |   96 --
 include/cobalt/kernel/ipipe/pipeline/sched.h  |   58 -
 include/cobalt/kernel/ipipe/pipeline/sirq.h   |   59 -
 include/cobalt/kernel/ipipe/pipeline/thread.h |   27 -
 include/cobalt/kernel/ipipe/pipeline/tick.h   |   18 -
 include/cobalt/kernel/ipipe/pipeline/trace.h  |  116 --
 .../kernel/ipipe/pipeline/vdso_fallback.h     |   16 -
 .../cobalt/kernel/ipipe/pipeline/wrappers.h   |   25 -
 kernel/cobalt/arch/arm/ipipe/Makefile         |    5 -
 kernel/cobalt/arch/arm/ipipe/README           |    3 -
 .../ipipe/include/asm/xenomai/calibration.h   |   63 -
 .../arm/ipipe/include/asm/xenomai/features.h  |   30 -
 .../arm/ipipe/include/asm/xenomai/fptest.h    |   52 -
 .../arm/ipipe/include/asm/xenomai/machine.h   |   85 --
 .../arm/ipipe/include/asm/xenomai/syscall.h   |   91 --
 .../arm/ipipe/include/asm/xenomai/syscall32.h |   24 -
 .../arm/ipipe/include/asm/xenomai/thread.h    |  119 --
 .../arm/ipipe/include/asm/xenomai/wrappers.h  |   27 -
 kernel/cobalt/arch/arm/ipipe/machine.c        |   63 -
 kernel/cobalt/arch/arm/ipipe/switch.S         |  219 ---
 kernel/cobalt/arch/arm/ipipe/syscall.c        |   53 -
 kernel/cobalt/arch/arm/ipipe/thread.c         |  343 -----
 kernel/cobalt/arch/arm64/ipipe/Makefile       |    5 -
 kernel/cobalt/arch/arm64/ipipe/README         |    3 -
 .../ipipe/include/asm/xenomai/calibration.h   |   37 -
 .../ipipe/include/asm/xenomai/features.h      |   30 -
 .../arm64/ipipe/include/asm/xenomai/fptest.h  |   47 -
 .../arm64/ipipe/include/asm/xenomai/machine.h |   68 -
 .../arm64/ipipe/include/asm/xenomai/syscall.h |   77 --
 .../ipipe/include/asm/xenomai/syscall32.h     |   24 -
 .../arm64/ipipe/include/asm/xenomai/thread.h  |   97 --
 .../ipipe/include/asm/xenomai/wrappers.h      |   27 -
 kernel/cobalt/arch/arm64/ipipe/machine.c      |   66 -
 kernel/cobalt/arch/arm64/ipipe/syscall.c      |   53 -
 kernel/cobalt/arch/arm64/ipipe/thread.c       |  156 ---
 kernel/cobalt/arch/x86/dovetail/c1e.c         |   73 +-
 kernel/cobalt/arch/x86/dovetail/smi.c         |  169 ++-
 kernel/cobalt/arch/x86/ipipe/Makefile         |    5 -
 kernel/cobalt/arch/x86/ipipe/README           |    3 -
 kernel/cobalt/arch/x86/ipipe/c1e.c            |   72 -
 .../ipipe/include/asm/xenomai/calibration.h   |   71 -
 .../x86/ipipe/include/asm/xenomai/fptest.h    |   83 --
 .../x86/ipipe/include/asm/xenomai/machine.h   |   35 -
 .../x86/ipipe/include/asm/xenomai/syscall.h   |   81 --
 .../x86/ipipe/include/asm/xenomai/thread.h    |  101 --
 kernel/cobalt/arch/x86/ipipe/machine.c        |   78 --
 kernel/cobalt/arch/x86/ipipe/smi.c            |  168 ---
 kernel/cobalt/arch/x86/ipipe/thread.c         |  526 -------
 .../asm-generic/xenomai/ipipe/thread.h        |   39 -
 kernel/cobalt/include/ipipe/thread_info.h     |   38 -
 kernel/cobalt/ipipe/Makefile                  |    5 -
 kernel/cobalt/ipipe/clock.c                   |  158 ---
 kernel/cobalt/ipipe/init.c                    |   81 --
 kernel/cobalt/ipipe/intr.c                    | 1230 -----------------
 kernel/cobalt/ipipe/kevents.c                 |  541 --------
 kernel/cobalt/ipipe/sched.c                   |  198 ---
 kernel/cobalt/ipipe/syscall.c                 |   29 -
 kernel/cobalt/ipipe/tick.c                    |  286 ----
 scripts/prepare-kernel.sh                     |   39 +-
 scripts/xeno-config-cobalt.in                 |    3 -
 67 files changed, 260 insertions(+), 6368 deletions(-)
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/clock.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/inband_work.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/irq.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/kevents.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/lock.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/machine.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/pipeline.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/sched.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/sirq.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/thread.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/tick.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/trace.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h
 delete mode 100644 include/cobalt/kernel/ipipe/pipeline/wrappers.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/README
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/calibration.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/features.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/machine.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall32.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/wrappers.h
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/switch.S
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/syscall.c
 delete mode 100644 kernel/cobalt/arch/arm/ipipe/thread.c
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/README
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/calibration.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/features.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall32.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/wrappers.h
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/syscall.c
 delete mode 100644 kernel/cobalt/arch/arm64/ipipe/thread.c
 mode change 120000 => 100644 kernel/cobalt/arch/x86/dovetail/c1e.c
 mode change 120000 => 100644 kernel/cobalt/arch/x86/dovetail/smi.c
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/README
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/c1e.c
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/smi.c
 delete mode 100644 kernel/cobalt/arch/x86/ipipe/thread.c
 delete mode 100644 kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h
 delete mode 100644 kernel/cobalt/include/ipipe/thread_info.h
 delete mode 100644 kernel/cobalt/ipipe/Makefile
 delete mode 100644 kernel/cobalt/ipipe/clock.c
 delete mode 100644 kernel/cobalt/ipipe/init.c
 delete mode 100644 kernel/cobalt/ipipe/intr.c
 delete mode 100644 kernel/cobalt/ipipe/kevents.c
 delete mode 100644 kernel/cobalt/ipipe/sched.c
 delete mode 100644 kernel/cobalt/ipipe/syscall.c
 delete mode 100644 kernel/cobalt/ipipe/tick.c

diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index c22f563712..c0f4c12e99 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -61,17 +61,17 @@ as follows:
 
 ------------------------------------------------------------------------------
 $ scripts/prepare-kernel.sh [--linux=<linux-srctree>]
-[--ipipe=<ipipe-patch>] [--arch=<target-arch>]
+[--dovetail=<dovetail-patch>] [--arch=<target-arch>]
 ------------------------------------------------------------------------------
 
 `--linux`:: specifies the path of the target kernel source tree. Such
     kernel tree may be already configured or not, indifferently. This
     path defaults to $PWD.
 
-`--ipipe`:: specifies the path of the interrupt pipeline (aka I-pipe)
+`--dovetil`:: specifies the path of the interrupt pipeline (aka Dovetail)
     patch to apply against the kernel tree. Suitable patches are
-    available from the project's link:/downloads/ipipe/[download
-    area].  This parameter can be omitted if the I-pipe has already
+    available from the project's link:/downloads/dovetail/[download
+    area].  This parameter can be omitted if the Dovetail has already
     been patched in, or the script shall suggest an appropriate
     one. The script will detect whether the interrupt pipeline code is
     already present into the kernel tree, and skip this operation if
@@ -82,12 +82,12 @@ $ scripts/prepare-kernel.sh [--linux=<linux-srctree>]
     default.
 
 For instance, the following command would prepare the Linux tree
-located at `/home/me/linux-3.10-ipipe` in order to patch the Xenomai
+located at `/home/me/linux-dovetail` in order to patch the Xenomai
 support in:
 
 ------------------------------------------------------------------------------
 $ cd xenomai-3
-$ scripts/prepare-kernel.sh --linux=/home/me/linux-3.10
+$ scripts/prepare-kernel.sh --linux=/home/me/linux-dovetail
 ------------------------------------------------------------------------------
 
 Note: The script will infer the location of the Xenomai kernel code
@@ -182,7 +182,7 @@ typically run:
 ------------------------------------------------------------------------------
 $ cd $linux_tree
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86 \
-  --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+  --dovetail=patch-X.Y.Z-dovetail.patch
 $ make [ARCH=i386] xconfig/gconfig/menuconfig
 ------------------------------------------------------------------------------
 ...configure the kernel (see also the recommended settings
@@ -200,7 +200,7 @@ typical steps would be as follows:
 ------------------------------------------------------------------------------
 $ cd $linux_tree
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=i386 \
-  --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+  --dovetail=patch-X.Y.Z-dovetail.patch
 $ make xconfig/gconfig/menuconfig
 ------------------------------------------------------------------------------
 ...configure the kernel (see also the recommended settings
@@ -216,7 +216,7 @@ Similarly, for a 64bit platform, you would use:
 ------------------------------------------------------------------------------
 $ cd $linux_tree
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86_64 \
-  --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+  --dovetail=patch-X.Y.Z-dovetail.patch
 $ make xconfig/gconfig/menuconfig
 ------------------------------------------------------------------------------
 ...configure the kernel (see also the recommended settings
@@ -243,7 +243,7 @@ will look like:
 ------------------------------------------------------------------------------
 $ cd $linux_tree
 $ $xenomai_root/scripts/prepare-kernel.sh --arch=arm \
-  --ipipe=ipipe-core-X.Y.Z-x86-NN.patch
+  --dovetail=patch-X.Y.Z-dovetail.patch
 $ mkdir -p $build_root/linux
 $ make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root/linux \
   csb637_defconfig
@@ -300,13 +300,11 @@ although this is not mandatory if building with `--disable-tls`.
 _Cobalt_-specific requirements
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-- The kernel version must be 3.10 or better.
+- The kernel version must be 5.10 or better.
 
-- An interrupt pipeline (I-pipe) patch must be available for your
+- An interrupt pipeline (Dovetail) patch must be available for your
   target kernel. You can find the official patches issued by the
-  Xenomai project link:/downloads/ipipe/[there].
-  Only patches from the *ipipe-core* series are appropriate, legacy
-  patches from the *adeos-ipipe* series are not.
+  Xenomai project link:/downloads/dovetail/[there].
 
 - A timestamp counter (TSC) is required from running on a x86_32
   hardware. Unlike with Xenomai 2.x, TSC-emulation using a PIT
@@ -774,8 +772,7 @@ messages like these:
 
 ------------------------------------------------------------------------------
 $ dmesg | grep -i xenomai
-I-pipe: head domain Xenomai registered.
-[Xenomai] Cobalt vX.Y.Z enabled
+[Xenomai] Cobalt vX.Y.Z
 ------------------------------------------------------------------------------
 
 
diff --git a/include/cobalt/kernel/ipipe/pipeline/clock.h b/include/cobalt/kernel/ipipe/pipeline/clock.h
deleted file mode 100644
index a06d1aaae0..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/clock.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_CLOCK_H
-#define _COBALT_KERNEL_IPIPE_CLOCK_H
-
-#include <linux/ipipe_tickdev.h>
-#include <cobalt/uapi/kernel/types.h>
-
-struct timespec64;
-
-static inline u64 pipeline_read_cycle_counter(void)
-{
-	u64 t;
-	ipipe_read_tsc(t);
-	return t;
-}
-
-xnticks_t pipeline_read_wallclock(void);
-
-int pipeline_set_wallclock(xnticks_t epoch_ns);
-
-static inline void pipeline_set_timer_shot(unsigned long cycles)
-{
-	ipipe_timer_set(cycles);
-}
-
-static inline const char *pipeline_timer_name(void)
-{
-	return ipipe_timer_name();
-}
-
-static inline const char *pipeline_clock_name(void)
-{
-	return ipipe_clock_name();
-}
-
-int pipeline_get_host_time(struct timespec64 *tp);
-
-void pipeline_update_clock_freq(unsigned long long freq);
-
-void pipeline_init_clock(void);
-
-#endif /* !_COBALT_KERNEL_IPIPE_CLOCK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/inband_work.h b/include/cobalt/kernel/ipipe/pipeline/inband_work.h
deleted file mode 100644
index 12ef07b00a..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/inband_work.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_INBAND_WORK_H
-#define _COBALT_KERNEL_IPIPE_INBAND_WORK_H
-
-#include <linux/ipipe.h>
-
-/*
- * This field must be named inband_work and appear first in the
- * container work struct.
- */
-struct pipeline_inband_work {
-	struct ipipe_work_header work;
-};
-
-#define PIPELINE_INBAND_WORK_INITIALIZER(__work, __handler)		\
-	{								\
-		.work = {						\
-			.size = sizeof(__work),				\
-			.handler = (void (*)(struct ipipe_work_header *)) \
-			__handler,					\
-		},							\
-	}
-
-#define pipeline_post_inband_work(__work)	\
-	ipipe_post_work_root(__work, inband_work.work)
-
-#endif /* !_COBALT_KERNEL_IPIPE_INBAND_WORK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/irq.h b/include/cobalt/kernel/ipipe/pipeline/irq.h
deleted file mode 100644
index a2db772d37..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/irq.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_IRQ_H
-#define _COBALT_KERNEL_IPIPE_IRQ_H
-
-void xnintr_init_proc(void);
-
-void xnintr_cleanup_proc(void);
-
-int xnintr_mount(void);
-
-#endif /* !_COBALT_KERNEL_IPIPE_IRQ_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/kevents.h b/include/cobalt/kernel/ipipe/pipeline/kevents.h
deleted file mode 100644
index f3f0c2f95e..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/kevents.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_KEVENTS_H
-#define _COBALT_KERNEL_IPIPE_KEVENTS_H
-
-#define KEVENT_PROPAGATE   0
-#define KEVENT_STOP        1
-
-struct cobalt_process;
-struct cobalt_thread;
-
-static inline
-int pipeline_attach_process(struct cobalt_process *process)
-{
-	return 0;
-}
-
-static inline
-void pipeline_detach_process(struct cobalt_process *process)
-{ }
-
-int pipeline_prepare_current(void);
-
-void pipeline_attach_current(struct xnthread *thread);
-
-int pipeline_trap_kevents(void);
-
-void pipeline_enable_kevents(void);
-
-void pipeline_cleanup_process(void);
-
-#endif /* !_COBALT_KERNEL_IPIPE_KEVENTS_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/lock.h b/include/cobalt/kernel/ipipe/pipeline/lock.h
deleted file mode 100644
index f33b041c72..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/lock.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_LOCK_H
-#define _COBALT_KERNEL_IPIPE_LOCK_H
-
-#include <pipeline/pipeline.h>
-
-typedef ipipe_spinlock_t pipeline_spinlock_t;
-
-#define PIPELINE_SPIN_LOCK_UNLOCKED(__name)  IPIPE_SPIN_LOCK_UNLOCKED
-
-#ifdef CONFIG_XENO_OPT_DEBUG_LOCKING
-/* Disable UP-over-SMP kernel optimization in debug mode. */
-#define __locking_active__  1
-#else
-#define __locking_active__  ipipe_smp_p
-#endif
-
-#endif /* !_COBALT_KERNEL_IPIPE_LOCK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/machine.h b/include/cobalt/kernel/ipipe/pipeline/machine.h
deleted file mode 100644
index 062722a023..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/machine.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_MACHINE_H
-#define _COBALT_KERNEL_IPIPE_MACHINE_H
-
-#include <linux/ipipe.h>
-#include <linux/percpu.h>
-
-#ifdef CONFIG_IPIPE_TRACE
-#define boot_lat_trace_notice "[LTRACE]"
-#else
-#define boot_lat_trace_notice ""
-#endif
-
-struct vm_area_struct;
-
-struct cobalt_machine {
-	const char *name;
-	int (*init)(void);
-	int (*late_init)(void);
-	void (*cleanup)(void);
-	void (*prefault)(struct vm_area_struct *vma);
-	const char *const *fault_labels;
-};
-
-extern struct cobalt_machine cobalt_machine;
-
-struct cobalt_machine_cpudata {
-	unsigned int faults[IPIPE_NR_FAULTS];
-};
-
-DECLARE_PER_CPU(struct cobalt_machine_cpudata, cobalt_machine_cpudata);
-
-struct cobalt_pipeline {
-	struct ipipe_domain domain;
-	unsigned long clock_freq;
-	unsigned int escalate_virq;
-#ifdef CONFIG_SMP
-	cpumask_t supported_cpus;
-#endif
-};
-
-int pipeline_init(void);
-
-int pipeline_late_init(void);
-
-void pipeline_cleanup(void);
-
-extern struct cobalt_pipeline cobalt_pipeline;
-
-#endif /* !_COBALT_KERNEL_IPIPE_MACHINE_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
deleted file mode 100644
index ac9c92b1b0..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_PIPELINE_H
-#define _COBALT_KERNEL_IPIPE_PIPELINE_H
-
-#ifdef CONFIG_IPIPE_LEGACY
-#error "CONFIG_IPIPE_LEGACY must be switched off"
-#endif
-
-#include <pipeline/machine.h>
-#include <asm/xenomai/features.h>
-#include <asm/xenomai/syscall.h>
-
-#define xnsched_primary_domain  cobalt_pipeline.domain
-
-#define PIPELINE_NR_IRQS  IPIPE_NR_IRQS
-
-typedef unsigned long spl_t;
-
-#define splhigh(x)  ((x) = ipipe_test_and_stall_head() & 1)
-#ifdef CONFIG_SMP
-#define splexit(x)  ipipe_restore_head(x & 1)
-#else /* !CONFIG_SMP */
-#define splexit(x)  ipipe_restore_head(x)
-#endif /* !CONFIG_SMP */
-#define splmax()    ipipe_stall_head()
-#define splnone()   ipipe_unstall_head()
-#define spltest()   ipipe_test_head()
-
-#define is_secondary_domain()	ipipe_root_p
-#define is_primary_domain()	(!ipipe_root_p)
-
-#ifdef CONFIG_SMP
-
-static inline int pipeline_request_resched_ipi(void (*handler)(void))
-{
-	return ipipe_request_irq(&cobalt_pipeline.domain,
-				IPIPE_RESCHEDULE_IPI,
-				(ipipe_irq_handler_t)handler,
-				NULL, NULL);
-}
-
-static inline void pipeline_free_resched_ipi(void)
-{
-	ipipe_free_irq(&cobalt_pipeline.domain,
-		IPIPE_RESCHEDULE_IPI);
-}
-
-static inline void pipeline_send_resched_ipi(const struct cpumask *dest)
-{
-	ipipe_send_ipi(IPIPE_RESCHEDULE_IPI, *dest);
-}
-
-static inline void pipeline_send_timer_ipi(const struct cpumask *dest)
-{
-	ipipe_send_ipi(IPIPE_HRTIMER_IPI, *dest);
-}
-
-#else  /* !CONFIG_SMP */
-
-static inline int pipeline_request_resched_ipi(void (*handler)(void))
-{
-	return 0;
-}
-
-
-static inline void pipeline_free_resched_ipi(void)
-{
-}
-
-#endif	/* CONFIG_SMP */
-
-static inline void pipeline_prepare_panic(void)
-{
-	ipipe_prepare_panic();
-}
-
-static inline void pipeline_collect_features(struct cobalt_featinfo *f)
-{
-	f->clock_freq = cobalt_pipeline.clock_freq;
-}
-
-static inline void pipeline_get_syscall_args(struct task_struct *task,
-					     struct pt_regs *regs,
-					     unsigned long *args)
-{
-	*args++ = __xn_reg_arg1(regs);
-	*args++ = __xn_reg_arg2(regs);
-	*args++ = __xn_reg_arg3(regs);
-	*args++ = __xn_reg_arg4(regs);
-	*args   = __xn_reg_arg5(regs);
-}
-
-#endif /* !_COBALT_KERNEL_IPIPE_PIPELINE_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/sched.h b/include/cobalt/kernel/ipipe/pipeline/sched.h
deleted file mode 100644
index 9d7bf886b6..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/sched.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_SCHED_H
-#define _COBALT_KERNEL_IPIPE_SCHED_H
-
-#include <cobalt/kernel/lock.h>
-
-struct xnthread;
-struct xnsched;
-struct task_struct;
-
-void pipeline_init_shadow_tcb(struct xnthread *thread);
-
-void pipeline_init_root_tcb(struct xnthread *thread);
-
-int pipeline_schedule(struct xnsched *sched);
-
-void pipeline_prep_switch_oob(struct xnthread *root);
-
-bool pipeline_switch_to(struct xnthread *prev,
-			struct xnthread *next,
-			bool leaving_inband);
-
-int pipeline_leave_inband(void);
-
-int pipeline_leave_oob_prepare(void);
-
-static inline void pipeline_leave_oob_unlock(void)
-{
-	/*
-	 * Introduce an opportunity for interrupt delivery right
-	 * before switching context, which shortens the
-	 * uninterruptible code path.
-	 *
-	 * We have to shut irqs off before __xnsched_run() is called
-	 * next though: if an interrupt could preempt us right after
-	 * xnarch_escalate() is passed but before the nklock is
-	 * grabbed, we would enter the critical section in
-	 * ___xnsched_run() from the root domain, which would defeat
-	 * the purpose of escalating the request.
-	 */
-	xnlock_clear_irqon(&nklock);
-	splmax();
-}
-
-void pipeline_leave_oob_finish(void);
-
-void pipeline_finalize_thread(struct xnthread *thread);
-
-void pipeline_raise_mayday(struct task_struct *tsk);
-
-void pipeline_clear_mayday(void);
-
-#endif /* !_COBALT_KERNEL_IPIPE_SCHED_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/sirq.h b/include/cobalt/kernel/ipipe/pipeline/sirq.h
deleted file mode 100644
index 1a167768cb..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/sirq.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_SIRQ_H
-#define _COBALT_KERNEL_IPIPE_SIRQ_H
-
-#include <linux/ipipe.h>
-#include <pipeline/machine.h>
-
-/*
- * Wrappers to create "synthetic IRQs" the I-pipe way (used to be
- * called "virtual IRQs" there). Those interrupt channels can only be
- * triggered by software; they have per-CPU semantics. We use them to
- * schedule handlers to be run on the in-band execution stage, meaning
- * "secondary mode" in the Cobalt jargon.
- */
-
-static inline
-int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
-{
-	int sirq, ret;
-
-	sirq = ipipe_alloc_virq();
-	if (sirq == 0)
-		return -EAGAIN;
-
-	/*
-	 * ipipe_irq_handler_t is close enough to the signature of a
-	 * regular IRQ handler: use the latter in the generic code
-	 * shared with Dovetail.  The extraneous return code will be
-	 * ignored by the I-pipe core.
-	 */
-	ret = ipipe_request_irq(ipipe_root_domain, sirq,
-				(ipipe_irq_handler_t)handler,
-				NULL, NULL);
-	if (ret) {
-		ipipe_free_virq(sirq);
-		return ret;
-	}
-
-	return sirq;
-}
-
-static inline
-void pipeline_delete_inband_sirq(int sirq)
-{
-	ipipe_free_irq(ipipe_root_domain, sirq);
-	ipipe_free_virq(sirq);
-}
-
-static inline void pipeline_post_sirq(int sirq)
-{
-	ipipe_post_irq_root(sirq);
-}
-
-#endif /* !_COBALT_KERNEL_IPIPE_SIRQ_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/thread.h b/include/cobalt/kernel/ipipe/pipeline/thread.h
deleted file mode 100644
index 30a88537b3..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/thread.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_THREAD_H
-#define _COBALT_KERNEL_IPIPE_THREAD_H
-
-#include <linux/ipipe.h>
-#include <linux/sched.h>
-
-struct xnthread;
-
-#define cobalt_threadinfo ipipe_threadinfo
-
-static inline struct cobalt_threadinfo *pipeline_current(void)
-{
-	return ipipe_current_threadinfo();
-}
-
-static inline struct xnthread *pipeline_thread_from_task(struct task_struct *p)
-{
-	return ipipe_task_threadinfo(p)->thread;
-}
-
-#endif /* !_COBALT_KERNEL_IPIPE_THREAD_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/tick.h b/include/cobalt/kernel/ipipe/pipeline/tick.h
deleted file mode 100644
index 41347f7b18..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/tick.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- */
-
-#ifndef _COBALT_KERNEL_IPIPE_TICK_H
-#define _COBALT_KERNEL_IPIPE_TICK_H
-
-int pipeline_install_tick_proxy(void);
-
-void pipeline_uninstall_tick_proxy(void);
-
-struct xnsched;
-static inline bool pipeline_must_force_program_tick(struct xnsched *sched)
-{
-	return false;
-}
-
-#endif /* !_COBALT_KERNEL_IPIPE_TICK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/trace.h b/include/cobalt/kernel/ipipe/pipeline/trace.h
deleted file mode 100644
index a28b83a48e..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/trace.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * Copyright (C) 2006 Jan Kiszka <jan.kiszka@web.de>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_KERNEL_IPIPE_TRACE_H
-#define _COBALT_KERNEL_IPIPE_TRACE_H
-
-#include <linux/types.h>
-#include <linux/kconfig.h>
-#include <linux/ipipe_trace.h>
-#include <cobalt/uapi/kernel/trace.h>
-
-static inline int xntrace_max_begin(unsigned long v)
-{
-	ipipe_trace_begin(v);
-	return 0;
-}
-
-static inline int xntrace_max_end(unsigned long v)
-{
-	ipipe_trace_end(v);
-	return 0;
-}
-
-static inline int xntrace_max_reset(void)
-{
-	ipipe_trace_max_reset();
-	return 0;
-}
-
-static inline int xntrace_user_start(void)
-{
-	return ipipe_trace_frozen_reset();
-}
-
-static inline int xntrace_user_stop(unsigned long v)
-{
-	ipipe_trace_freeze(v);
-	return 0;
-}
-
-static inline int xntrace_user_freeze(unsigned long v, int once)
-{
-	int ret = 0;
-
-	if (!once)
-		ret = ipipe_trace_frozen_reset();
-
-	ipipe_trace_freeze(v);
-
-	return ret;
-}
-
-static inline void xntrace_latpeak_freeze(int delay)
-{
-	xntrace_user_freeze(delay, 0);
-}
-
-static inline int xntrace_special(unsigned char id, unsigned long v)
-{
-	ipipe_trace_special(id, v);
-	return 0;
-}
-
-static inline int xntrace_special_u64(unsigned char id,
-				      unsigned long long v)
-{
-	ipipe_trace_special(id, (unsigned long)(v >> 32));
-	ipipe_trace_special(id, (unsigned long)(v & 0xFFFFFFFF));
-	return 0;
-}
-
-static inline int xntrace_pid(pid_t pid, short prio)
-{
-	ipipe_trace_pid(pid, prio);
-	return 0;
-}
-
-static inline int xntrace_tick(unsigned long delay_ticks)
-{
-	ipipe_trace_event(0, delay_ticks);
-	return 0;
-}
-
-static inline int xntrace_panic_freeze(void)
-{
-	ipipe_trace_panic_freeze();
-	return 0;
-}
-
-static inline int xntrace_panic_dump(void)
-{
-	ipipe_trace_panic_dump();
-	return 0;
-}
-
-static inline bool xntrace_enabled(void)
-{
-	return IS_ENABLED(CONFIG_IPIPE_TRACE);
-}
-
-#endif /* !_COBALT_KERNEL_IPIPE_TRACE_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h b/include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h
deleted file mode 100644
index f9ea3886ba..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/vdso_fallback.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (c) Siemens AG, 2021
- */
-
-#ifndef _COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H
-#define _COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H
-
-static __always_inline bool 
-pipeline_handle_vdso_fallback(int nr, struct pt_regs *regs)
-{
-	return false;
-}
-
-#endif /* !_COBALT_KERNEL_PIPELINE_VDSO_FALLBACK_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/wrappers.h b/include/cobalt/kernel/ipipe/pipeline/wrappers.h
deleted file mode 100644
index dcf021e83d..0000000000
--- a/include/cobalt/kernel/ipipe/pipeline/wrappers.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- */
-#ifndef _COBALT_KERNEL_IPIPE_WRAPPERS_H
-#define _COBALT_KERNEL_IPIPE_WRAPPERS_H
-
-#include <linux/ipipe.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
-#define cobalt_set_task_state(tsk, state_value)	\
-	set_task_state(tsk, state_value)
-#else
-/*
- * The co-kernel can still set the current task state safely if it
- * runs on the head stage.
- */
-#define cobalt_set_task_state(tsk, state_value)	\
-	smp_store_mb((tsk)->state, (state_value))
-#endif
-
-#ifndef ipipe_root_nr_syscalls
-#define ipipe_root_nr_syscalls(ti)	NR_syscalls
-#endif
-
-#endif /* !_COBALT_KERNEL_IPIPE_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/Makefile b/kernel/cobalt/arch/arm/ipipe/Makefile
deleted file mode 100644
index c482fb3376..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(CONFIG_XENOMAI) += xenomai.o
-
-xenomai-$(CONFIG_IPIPE) := machine.o thread.o switch.o syscall.o
-
-ccflags-y := -I$(srctree)/arch/arm/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/arm/ipipe/README b/kernel/cobalt/arch/arm/ipipe/README
deleted file mode 100644
index 80f954aef6..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/README
+++ /dev/null
@@ -1,3 +0,0 @@
-Get the interrupt pipeline code for the target kernel from
-http://xenomai.org/downloads/ipipe/, or
-git://git.xenomai.org/ipipe.git
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/calibration.h
deleted file mode 100644
index d227caee56..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/calibration.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004,2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_CALIBRATION_H
-#define _COBALT_ARM_ASM_CALIBRATION_H
-
-unsigned int omap_rev(void);
-#define cpu_is_omap44xx() ((omap_rev() & 0xff) == 0x44)
-
-static inline void xnarch_get_latencies(struct xnclock_gravity *p)
-{
-	unsigned int ulat;
-#if CONFIG_XENO_OPT_TIMING_SCHEDLAT != 0
-	ulat = CONFIG_XENO_OPT_TIMING_SCHEDLAT;
-#elif defined(CONFIG_ARCH_AT91RM9200)
-	ulat = 8500;
-#elif defined(CONFIG_ARCH_AT91SAM9263)
-	ulat = 11000;
-#elif defined(CONFIG_SOC_IMX6Q)
-	ulat = 6000;
-#elif defined(CONFIG_ARCH_MX51)
-	ulat = 5000;
-#elif defined(CONFIG_ARCH_MX53)
-	ulat = 5000;
-#elif defined(CONFIG_ARCH_MX6)
-	ulat = 2000;
-#elif defined(CONFIG_SOC_IMX7)
-	ulat = 2000;
-#elif defined(CONFIG_SOC_LS1021A)
-	ulat = 2800;
-#elif defined(CONFIG_ARCH_OMAP)
-	ulat = cpu_is_omap44xx() ? 2500 : 5000;
-#elif defined(CONFIG_ARCH_STI)
-	ulat = 6000;
-#elif defined(CONFIG_ARCH_SOCFPGA)
-	ulat = 4500;
-#else
-	ulat = 9500;	/* XXX sane? */
-#endif
-	p->user = xnclock_ns_to_ticks(&nkclock, ulat);
-	p->kernel = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
-	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
-}
-
-#endif /* !_COBALT_ARM_ASM_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/features.h
deleted file mode 100644
index d485286a4e..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/features.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_FEATURES_H
-#define _COBALT_ARM_ASM_FEATURES_H
-
-struct cobalt_featinfo;
-static inline void collect_arch_features(struct cobalt_featinfo *p) { }
-
-#include <asm/xenomai/uapi/features.h>
-
-#endif /* !_COBALT_ARM_ASM_FEATURES_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
deleted file mode 100644
index b8c627bed1..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/fptest.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_FPTEST_H
-#define _COBALT_ARM_ASM_FPTEST_H
-
-#include <linux/errno.h>
-#include <asm/hwcap.h>
-
-#ifdef CONFIG_VFP
-#define have_vfp (ELF_HWCAP & HWCAP_VFP)
-#else /* !CONFIG_VFP */
-#define have_vfp 0
-#endif /* !CONFIG_VFP */
-
-#include <asm/xenomai/uapi/fptest.h>
-
-static inline int fp_kernel_supported(void)
-{
-	return 1;
-}
-
-static inline int fp_linux_begin(void)
-{
-	return -ENOSYS;
-}
-
-static inline void fp_linux_end(void)
-{
-}
-
-static inline int fp_detect(void)
-{
-	return have_vfp ? __COBALT_HAVE_VFP : 0;
-}
-
-#endif /* _COBALT_ARM_ASM_FPTEST_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/machine.h
deleted file mode 100644
index d6e965f9fb..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/machine.h
+++ /dev/null
@@ -1,85 +0,0 @@
-/**
- *   Copyright &copy; 2002-2004 Philippe Gerum.
- *
- *   ARM port
- *     Copyright (C) 2005 Stelian Pop
- *
- *   Xenomai is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License as
- *   published by the Free Software Foundation, Inc., 675 Mass Ave,
- *   Cambridge MA 02139, USA; either version 2 of the License, or (at
- *   your option) any later version.
- *
- *   Xenomai is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *   General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with Xenomai; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- *   02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_MACHINE_H
-#define _COBALT_ARM_ASM_MACHINE_H
-
-#include <linux/version.h>
-#include <asm/byteorder.h>
-
-#define XNARCH_HOST_TICK_IRQ __ipipe_hrtimer_irq
-
-#include <asm/barrier.h>
-#include <asm/compiler.h>
-#include <asm/cmpxchg.h>
-#include <asm/switch_to.h>
-#include <asm/system_info.h>
-#include <asm/system_misc.h>
-#include <asm/timex.h>
-#include <asm/processor.h>
-#include <asm/ipipe.h>
-#include <asm/mach/irq.h>
-#include <asm/cacheflush.h>
-
-#define xnarch_cache_aliasing() cache_is_vivt()
-
-#if __LINUX_ARM_ARCH__ < 5
-static inline __attribute_const__ unsigned long ffnz(unsigned long x)
-{
-	int r = 0;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
-#else
-static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
-{
-	int __r;
-	__asm__("clz\t%0, %1" : "=r" (__r) : "r"(ul & (-ul)) : "cc");
-	return 31 - __r;
-}
-#endif
-
-#include <asm-generic/xenomai/machine.h>
-
-#endif /* !_COBALT_ARM_ASM_MACHINE_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall.h
deleted file mode 100644
index 362f0ebd8e..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_SYSCALL_H
-#define _COBALT_ARM_ASM_SYSCALL_H
-
-#include <linux/errno.h>
-#include <linux/uaccess.h>
-#include <asm/unistd.h>
-#include <asm/ptrace.h>
-#include <asm-generic/xenomai/syscall.h>
-
-#ifndef __ARM_NR_ipipe
-/* Legacy pipelines do not define this. */
-#define __ARM_NR_ipipe	(__NR_SYSCALL_BASE + XENO_ARM_SYSCALL)
-#endif
-
-/*
- * Cobalt syscall numbers can be fetched from ARM_ORIG_r0 with ARM_r7
- * containing the Xenomai syscall marker, Linux syscalls directly from
- * ARM_r7 (may require the OABI tweak).
- */
-#define __xn_reg_sys(__regs)	((__regs)->ARM_ORIG_r0)
-/* In OABI_COMPAT mode, handle both OABI and EABI userspace syscalls */
-#ifdef CONFIG_OABI_COMPAT
-#define __xn_syscall_p(__regs)	(((__regs)->ARM_r7 == __NR_OABI_SYSCALL_BASE + XENO_ARM_SYSCALL) || \
-				 ((__regs)->ARM_r7 == __ARM_NR_ipipe))
-#define __xn_abi_decode(__regs) ((__regs)->ARM_r7 - __NR_OABI_SYSCALL_BASE)
-#else /* !CONFIG_OABI_COMPAT */
-#define __xn_syscall_p(__regs)	((__regs)->ARM_r7 == __ARM_NR_ipipe)
-#define __xn_abi_decode(__regs) ((__regs)->ARM_r7)
-#endif /* !CONFIG_OABI_COMPAT */
-#define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
-
-/*
- * Root syscall number with predicate (valid only if
- * !__xn_syscall_p(__regs)).
- */
-#define __xn_rootcall_p(__regs, __code)					\
-	({								\
-		*(__code) = __xn_abi_decode(__regs);			\
-		*(__code) < NR_syscalls || *(__code) >= __ARM_NR_BASE;	\
-	})
-	
-#define __xn_reg_rval(__regs)	((__regs)->ARM_r0)
-#define __xn_reg_arg1(__regs)	((__regs)->ARM_r1)
-#define __xn_reg_arg2(__regs)	((__regs)->ARM_r2)
-#define __xn_reg_arg3(__regs)	((__regs)->ARM_r3)
-#define __xn_reg_arg4(__regs)	((__regs)->ARM_r4)
-#define __xn_reg_arg5(__regs)	((__regs)->ARM_r5)
-#define __xn_reg_pc(__regs)	((__regs)->ARM_ip)
-#define __xn_reg_sp(__regs)	((__regs)->ARM_sp)
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, long v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) == -EINTR;
-}
-
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			 unsigned long a3, unsigned long a4,
-			 unsigned long a5);
-
-#endif /* !_COBALT_ARM_ASM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall32.h
deleted file mode 100644
index 95c5a11685..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/syscall32.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2014 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_SYSCALL32_H
-#define _COBALT_ARM_ASM_SYSCALL32_H
-
-#include <asm-generic/xenomai/syscall32.h>
-
-#endif /* !_COBALT_ARM_ASM_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
deleted file mode 100644
index 93346fd2ed..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/thread.h
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
- * Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_THREAD_H
-#define _COBALT_ARM_ASM_THREAD_H
-
-#include <asm-generic/xenomai/ipipe/thread.h>
-
-#ifdef CONFIG_XENO_ARCH_FPU
-#ifdef CONFIG_VFP
-#include <asm/vfp.h>
-#endif /* CONFIG_VFP */
-#endif /* !CONFIG_XENO_ARCH_FPU */
-
-struct xnarchtcb {
-	struct xntcb core;
-#ifdef CONFIG_XENO_ARCH_FPU
-#ifdef CONFIG_VFP
-	union vfp_state *fpup;
-#define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
-#else
-#define xnarch_fpu_ptr(tcb)     NULL
-#endif
-#endif
-};
-
-#define xnarch_fault_regs(d)	((d)->regs)
-#define xnarch_fault_trap(d)	((d)->exception)
-#define xnarch_fault_code(d)	(0)
-#define xnarch_fault_pc(d)	((d)->regs->ARM_pc - (thumb_mode((d)->regs) ? 2 : 4)) /* XXX ? */
-
-#define xnarch_fault_pf_p(d)	((d)->exception == IPIPE_TRAP_ACCESS)
-#define xnarch_fault_bp_p(d)	((current->ptrace & PT_PTRACED) &&	\
-				 ((d)->exception == IPIPE_TRAP_BREAK ||	\
-				  (d)->exception == IPIPE_TRAP_UNDEFINSTR))
-
-#define xnarch_fault_notify(d) (!xnarch_fault_bp_p(d))
-
-static inline
-struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
-{
-	return tcb->core.host_task;
-}
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
-
-static inline void xnarch_enter_root(struct xnthread *root) { }
-
-static inline int xnarch_escalate(void)
-{
-	if (ipipe_root_p) {
-		ipipe_raise_irq(cobalt_pipeline.escalate_virq);
-		return 1;
-	}
-
-	return 0;
-}
-
-#if defined(CONFIG_XENO_ARCH_FPU) && defined(CONFIG_VFP)
-
-void xnarch_init_root_tcb(struct xnthread *thread);
-
-void xnarch_init_shadow_tcb(struct xnthread *thread);
-
-int xnarch_fault_fpu_p(struct ipipe_trap_data *d);
-
-void xnarch_leave_root(struct xnthread *root);
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread);
-
-int xnarch_handle_fpu_fault(struct xnthread *from, 
-			struct xnthread *to, struct ipipe_trap_data *d);
-
-#else /* !CONFIG_XENO_ARCH_FPU || !CONFIG_VFP */
-
-static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
-static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
-
-/*
- * Userland may raise FPU faults with FPU-enabled kernels, regardless
- * of whether real-time threads actually use FPU, so we simply ignore
- * these faults.
- */
-static inline int xnarch_fault_fpu_p(struct ipipe_trap_data *d)
-{
-	return 0;
-}
-
-static inline void xnarch_leave_root(struct xnthread *root) { }
-
-static inline void xnarch_switch_fpu(struct xnthread *f, struct xnthread *t) { }
-
-static inline int xnarch_handle_fpu_fault(struct xnthread *from, 
-					struct xnthread *to, struct ipipe_trap_data *d)
-{
-	return 0;
-}
-#endif /*  !CONFIG_XENO_ARCH_FPU || !CONFIG_VFP */
-
-static inline void xnarch_enable_kfpu(void) { }
-
-static inline void xnarch_disable_kfpu(void) { }
-
-#endif /* !_COBALT_ARM_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/wrappers.h
deleted file mode 100644
index fe598966cd..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/include/asm/xenomai/wrappers.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM_ASM_WRAPPERS_H
-#define _COBALT_ARM_ASM_WRAPPERS_H
-
-#include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
-
-#define __put_user_inatomic __put_user
-#define __get_user_inatomic __get_user
-
-#endif /* _COBALT_ARM_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/arm/ipipe/machine.c b/kernel/cobalt/arch/arm/ipipe/machine.c
deleted file mode 100644
index 0fd48cae1c..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/machine.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/**
- *   Copyright (C) 2005 Stelian Pop
- *
- *   Xenomai is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License as
- *   published by the Free Software Foundation, Inc., 675 Mass Ave,
- *   Cambridge MA 02139, USA; either version 2 of the License, or (at
- *   your option) any later version.
- *
- *   Xenomai is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *   General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- *   02111-1307, USA.
- */
-
-#include <linux/mm.h>
-#include <asm/xenomai/machine.h>
-
-static void mach_arm_prefault(struct vm_area_struct *vma)
-{
-	unsigned long addr;
-	unsigned int flags;
-
-	if ((vma->vm_flags & VM_MAYREAD)) {
-		flags = (vma->vm_flags & VM_MAYWRITE) ? FAULT_FLAG_WRITE : 0;
-		for (addr = vma->vm_start;
-		     addr != vma->vm_end; addr += PAGE_SIZE)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-			handle_mm_fault(vma->vm_mm, vma, addr, flags);
-#else
-			handle_mm_fault(vma, addr, flags);
-#endif
-	}
-}
-
-static const char *const fault_labels[] = {
-	[IPIPE_TRAP_ACCESS] = "Data or instruction access",
-	[IPIPE_TRAP_SECTION] = "Section fault",
-	[IPIPE_TRAP_DABT] = "Generic data abort",
-	[IPIPE_TRAP_UNKNOWN] = "Unknown exception",
-	[IPIPE_TRAP_BREAK] = "Instruction breakpoint",
-	[IPIPE_TRAP_FPU] = "Floating point exception",
-	[IPIPE_TRAP_VFP] = "VFP Floating point exception",
-	[IPIPE_TRAP_UNDEFINSTR] = "Undefined instruction",
-#ifdef IPIPE_TRAP_ALIGNMENT
-	[IPIPE_TRAP_ALIGNMENT] = "Unaligned access exception",
-#endif /* IPIPE_TRAP_ALIGNMENT */
-	[IPIPE_NR_FAULTS] = NULL
-};
-
-struct cobalt_machine cobalt_machine = {
-	.name = "arm",
-	.init = NULL,
-	.late_init = NULL,
-	.cleanup = NULL,
-	.prefault = mach_arm_prefault,
-	.fault_labels = fault_labels,
-};
diff --git a/kernel/cobalt/arch/arm/ipipe/switch.S b/kernel/cobalt/arch/arm/ipipe/switch.S
deleted file mode 100644
index 9fc847ab0d..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/switch.S
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- * Copyright (C) 2005 Stelian Pop.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
- * USA; either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#include <linux/linkage.h>
-#include <linux/version.h>
-#include <asm/assembler.h>
-#include <asm/asm-offsets.h>
-#include <asm/tls.h>
-#ifdef CONFIG_VFP
-#include <asm/vfpmacros.h>
-#endif
-
-	.macro fpu_switch tmp
-#ifdef CONFIG_VFP
-#if __LINUX_ARM_ARCH__ <= 6
-#ifdef CONFIG_JUMP_LABEL
-9998:	nop
-	.pushsection __jump_table, "aw"
-	.word	9998b, 9999f, __xeno_vfp_key
-	.popsection
-#else
-	ldr	\tmp, =elf_hwcap
-	ldr	\tmp, [\tmp]
-	tst	\tmp, #HWCAP_VFP
-	beq	9999f
-#endif
-#endif
-	@ Always disable VFP so we can lazily save/restore the old
-	@ state. This occurs in the context of the previous thread.
-	VFPFMRX \tmp, FPEXC
-	bic     \tmp, \tmp, #FPEXC_EN
-	VFPFMXR FPEXC, \tmp
-#if __LINUX_ARM_ARCH__ <= 6
-9999:
-#endif
-#endif
-	.endm
-
-	.text
-
-#if defined(CONFIG_VFP) && defined(CONFIG_XENO_ARCH_FPU)
-/* Copied from vfp_save_state in arch/arm/vfp/vfphw.S
- * r0 = pointer to union vfp_state, r1 = fpexc
- */
-ENTRY(__asm_vfp_save)
-	VFPFSTMIA	r0, r2		@ save the working registers
-	VFPFMRX		r2, FPSCR	@ current status
-	tst		r1, #FPEXC_EX	@ is there additional state to save?
-	beq		1f
-	VFPFMRX		r3, FPINST	@ FPINST (only if FPEXC.EX is set)
-	tst		r1, #FPEXC_FP2V	@ is there an FPINST2 to read?
-	beq		1f
-	VFPFMRX		r12, FPINST2	@ FPINST2 if needed (and present)
-1:
-	stmia		r0, {r1, r2, r3, r12}	@ save FPEXC, FPSCR, FPINST, FPINST2
-	mov		pc, lr
-ENDPROC(__asm_vfp_save)
-
-/* Copied from no_old_VFP_process in arch/arm/vfp/vfphw.S
- * r0 = pointer to union vfp_state
- * r1 = current cpu
- */
-ENTRY(__asm_vfp_load)
-#ifdef CONFIG_SMP
-	str		r1, [r0, #VFP_CPU]
-#endif
-	VFPFLDMIA	r0, r2		@ reload the working registers while
-					@ FPEXC is in a safe state
-	ldmia		r0, {r1, r2, r3, r12}	@ load FPEXC, FPSCR, FPINST, FPINST2
-	tst		r1, #FPEXC_EX	@ is there additional state to restore?
-	beq		1f
-	VFPFMXR		FPINST, r3	@ restore FPINST (only if FPEXC.EX is set)
-	tst		r1, #FPEXC_FP2V	@ is there an FPINST2 to write?
-	beq		1f
-	VFPFMXR		FPINST2, r12	@ FPINST2 if needed (and present)
-1:
-	VFPFMXR		FPSCR, r2	@ restore status
-	mov		pc, lr
-ENDPROC(__asm_vfp_load)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
-	.macro load_tls base, tp, tpuser
-	ldr     \tp, [\base, #TI_TP_VALUE]
-	.endm
-
-	.macro switch_tls base, tp, tpuser, tmp1, tmp2
-	set_tls \tp, \tmp1, \tmp2
-	.endm
-#else
-	.macro load_tls base, tp, tpuser
-	ldr	\tp, [\base, #TI_TP_VALUE]
-	ldr	\tpuser, [\base, #TI_TP_VALUE + 4]
-	.endm
-#endif
-
-/*
- * Switch context routine.
- *
- * Registers according to the ARM procedure call standard:
- *   Reg    Description
- *   r0-r3  argument/scratch registers
- *   r4-r9  variable register
- *   r10=sl stack limit/variable register
- *   r11=fp frame pointer/variable register
- *   r12=ip intra-procedure-call scratch register
- *   r13=sp stack pointer (auto preserved)
- *   r14=lr link register
- *   r15=pc program counter (auto preserved)
- *
- * Copied from __switch_to, arch/arm/kernel/entry-armv.S.
- * Right now it is identical, but who knows what the
- * future reserves us...
- *
- * XXX: All the following config options are NOT tested:
- *      CONFIG_IWMMXT
- *
- *  Calling args:
- * r0 = previous thread_info, r1 = next thread_info
- *
- * FIXME: this is ugly, at some point we should stop duplicating
- * what __switch_to() does, dropping specific fpu management from
- * Cobalt in the same move; this will have to wait until Dovetail
- * is substituted to the I-pipe though, since the former already
- * provides the support we need for this. --rpm
- */
-ENTRY(__asm_thread_switch)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
-	add     ip, r0, #TI_CPU_SAVE
- ARM(	stmia	ip!, {r4 - sl, fp, sp, lr} )	@ Store most regs on stack
- THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
- THUMB(	str	sp, [ip], #4		   )
- THUMB(	str	lr, [ip], #4		   )
-	load_tls r1, r4, r5
-#ifdef CONFIG_CPU_USE_DOMAINS
-	ldr     r6, [r1, #TI_CPU_DOMAIN]
-#endif
-	switch_tls r0, r4, r5, r3, r7
-#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	ldr	r7, [r1, #TI_TASK]
-	ldr	r8, =__stack_chk_guard
-	ldr	r7, [r7, #TSK_STACK_CANARY]
-#endif
-#ifdef CONFIG_CPU_USE_DOMAINS
-	mcr     p15, 0, r6, c3, c0, 0           @ Set domain register
-#endif
-	fpu_switch r4
-#if defined(CONFIG_CC_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	str	r7, [r8]
-#endif
- ARM(	add	r4, r1, #TI_CPU_SAVE	   )
- ARM(	ldmia	r4, {r4 - sl, fp, sp, pc}  )	@ Load all regs saved previously
- THUMB(	add	ip, r1, #TI_CPU_SAVE	   )
- THUMB(	ldmia	ip!, {r4 - sl, fp}	   )	@ Load all regs saved previously
- THUMB(	ldr	sp, [ip], #4		   )
- THUMB(	ldr	pc, [ip]		   )
-ENDPROC(__asm_thread_switch)
-
-#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 0) */
-
-#include <asm/unwind.h>
-
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)
-	add	ip, r0, #TI_CPU_SAVE
- ARM(	stmia	ip!, {r4 - sl, fp, sp, lr} )	@ Store most regs on stack
- THUMB(	stmia	ip!, {r4 - sl, fp}	   )	@ Store most regs on stack
- THUMB(	str	sp, [ip], #4		   )
- THUMB(	str	lr, [ip], #4		   )
-	ldr	r4, [r1, #TI_TP_VALUE]
-	ldr	r5, [r1, #TI_TP_VALUE + 4]
-#ifdef CONFIG_CPU_USE_DOMAINS
-	mrc	p15, 0, r6, c3, c0, 0		@ Get domain register
-	str	r6, [r0, #TI_CPU_DOMAIN]	@ Save old domain register
-	ldr	r6, [r1, #TI_CPU_DOMAIN]
-#endif
-	switch_tls r0, r4, r5, r3, r7
-#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	ldr	r7, [r1, #TI_TASK]
-	ldr	r8, =__stack_chk_guard
-	.if (TSK_STACK_CANARY > IMM12_MASK)
-	add	r7, r7, #TSK_STACK_CANARY & ~IMM12_MASK
-	.endif
-	ldr	r7, [r7, #TSK_STACK_CANARY & IMM12_MASK]
-#endif
-#ifdef CONFIG_CPU_USE_DOMAINS
-	mcr	p15, 0, r6, c3, c0, 0		@ Set domain register
-#endif
-	mov	r5, r0
-	fpu_switch r4
-	add	r4, r1, #TI_CPU_SAVE
-#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
-	str	r7, [r8]
-#endif
- THUMB(	mov	ip, r4			   )
-	mov	r0, r5
- ARM(	ldmia	r4, {r4 - sl, fp, sp, pc}  )	@ Load all regs saved previously
- THUMB(	ldmia	ip!, {r4 - sl, fp}	   )	@ Load all regs saved previously
- THUMB(	ldr	sp, [ip], #4		   )
- THUMB(	ldr	pc, [ip]		   )
- UNWIND(.fnend		)
-
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 0) */
diff --git a/kernel/cobalt/arch/arm/ipipe/syscall.c b/kernel/cobalt/arch/arm/ipipe/syscall.c
deleted file mode 100644
index ee78243c52..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/syscall.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright (C) 2005 Stelian Pop
- * Copyright (C) 2010 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/ipipe.h>
-#include <asm/xenomai/syscall.h>
-#include <asm/xenomai/uapi/tsc.h>
-
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			 unsigned long a3, unsigned long a4,
-			 unsigned long a5)
-{
-	struct ipipe_sysinfo ipipe_info;
-	struct __ipipe_tscinfo *p = &ipipe_info.arch.tsc;
-	struct __xn_tscinfo info;
-	int ret;
-
-	if (a1 != XENOMAI_SYSARCH_TSCINFO)
-		return -EINVAL;
-
-	ret = ipipe_get_sysinfo(&ipipe_info);
-	if (ret)
-		return ret;
-
-	switch (p->type) {
-	case IPIPE_TSC_TYPE_DECREMENTER:
-		info.counter = p->u.dec.counter;
-		break;
-	case IPIPE_TSC_TYPE_NONE:
-		return -ENOSYS;
-	default:
-		info.counter = p->u.fr.counter;
-		break;
-	}
-
-	return cobalt_copy_to_user((void *)a2, &info, sizeof(info));
-}
diff --git a/kernel/cobalt/arch/arm/ipipe/thread.c b/kernel/cobalt/arch/arm/ipipe/thread.c
deleted file mode 100644
index c68b5e3f41..0000000000
--- a/kernel/cobalt/arch/arm/ipipe/thread.c
+++ /dev/null
@@ -1,343 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/sched.h>
-#include <linux/ipipe.h>
-#include <linux/mm.h>
-#include <linux/jump_label.h>
-#include <asm/mmu_context.h>
-#include <cobalt/kernel/thread.h>
-
-struct static_key __xeno_vfp_key = STATIC_KEY_INIT_TRUE;
-
-asmlinkage void __asm_thread_switch(struct thread_info *out,
-				    struct thread_info *in);
-
-asmlinkage void __asm_thread_trampoline(void);
-
-#if defined(CONFIG_XENO_ARCH_FPU) && defined(CONFIG_VFP)
-
-static unsigned int vfp_checked;
-static DEFINE_MUTEX(vfp_check_lock);
-
-asmlinkage void __asm_vfp_save(union vfp_state *vfp, unsigned int fpexc);
-
-asmlinkage void __asm_vfp_load(union vfp_state *vfp, unsigned int cpu);
-
-#define do_vfp_fmrx(_vfp_)						\
-	({								\
-		u32 __v;						\
-		asm volatile("mrc p10, 7, %0, " __stringify(_vfp_)	\
-			     ", cr0, 0 @ fmrx %0, " #_vfp_:		\
-			     "=r" (__v));				\
-		__v;							\
-	})
-
-#define do_vfp_fmxr(_vfp_,_var_)				\
-	asm volatile("mcr p10, 7, %0, " __stringify(_vfp_)	\
-		     ", cr0, 0 @ fmxr " #_vfp_ ", %0":		\
-		     /* */ : "r" (_var_))
-
-extern union vfp_state *vfp_current_hw_state[NR_CPUS];
-
-static inline union vfp_state *get_fpu_owner(void)
-{
-	union vfp_state *vfp_owner;
-	unsigned int cpu;
-#ifdef CONFIG_SMP
-	unsigned int fpexc;
-#endif
-
-#if __LINUX_ARM_ARCH__ <= 6
-	if (!static_key_true(&__xeno_vfp_key))
-		return NULL;
-#endif
-
-#ifdef CONFIG_SMP
-	fpexc = do_vfp_fmrx(FPEXC);
-	if (!(fpexc & FPEXC_EN))
-		return NULL;
-#endif
-
-	cpu = raw_smp_processor_id();
-	vfp_owner = vfp_current_hw_state[cpu];
-	if (!vfp_owner)
-		return NULL;
-
-#ifdef CONFIG_SMP
-	if (vfp_owner->hard.cpu != cpu)
-		return NULL;
-#endif /* SMP */
-
-	return vfp_owner;
-}
-
-#define do_disable_vfp(fpexc)					\
-	do_vfp_fmxr(FPEXC, fpexc & ~FPEXC_EN)
-
-#define XNARCH_VFP_ANY_EXC						\
-	(FPEXC_EX|FPEXC_DEX|FPEXC_FP2V|FPEXC_VV|FPEXC_TRAP_MASK)
-
-#define do_enable_vfp()							\
-	({								\
-		unsigned _fpexc = do_vfp_fmrx(FPEXC) | FPEXC_EN;	\
-		do_vfp_fmxr(FPEXC, _fpexc & ~XNARCH_VFP_ANY_EXC);	\
-		_fpexc;							\
-	})
-
-int xnarch_fault_fpu_p(struct ipipe_trap_data *d)
-{
-	/* This function does the same thing to decode the faulting instruct as
-	   "call_fpe" in arch/arm/entry-armv.S */
-	static unsigned copro_to_exc[16] = {
-		IPIPE_TRAP_UNDEFINSTR,
-		/* FPE */
-		IPIPE_TRAP_FPU, IPIPE_TRAP_FPU,
-		IPIPE_TRAP_UNDEFINSTR,
-#ifdef CONFIG_CRUNCH
-		IPIPE_TRAP_FPU, IPIPE_TRAP_FPU, IPIPE_TRAP_FPU,
-#else /* !CONFIG_CRUNCH */
-		IPIPE_TRAP_UNDEFINSTR, IPIPE_TRAP_UNDEFINSTR, IPIPE_TRAP_UNDEFINSTR,
-#endif /* !CONFIG_CRUNCH */
-		IPIPE_TRAP_UNDEFINSTR, IPIPE_TRAP_UNDEFINSTR, IPIPE_TRAP_UNDEFINSTR,
-#ifdef CONFIG_VFP
-		IPIPE_TRAP_VFP, IPIPE_TRAP_VFP,
-#else /* !CONFIG_VFP */
-		IPIPE_TRAP_UNDEFINSTR, IPIPE_TRAP_UNDEFINSTR,
-#endif /* !CONFIG_VFP */
-		IPIPE_TRAP_UNDEFINSTR, IPIPE_TRAP_UNDEFINSTR,
-		IPIPE_TRAP_UNDEFINSTR, IPIPE_TRAP_UNDEFINSTR,
-	};
-	unsigned instr, exc, cp;
-	char *pc;
-
-	if (d->exception == IPIPE_TRAP_FPU)
-		return 1;
-
-	if (d->exception == IPIPE_TRAP_VFP)
-		goto trap_vfp;
-
-	if (d->exception != IPIPE_TRAP_UNDEFINSTR)
-		return 0;
-
-	pc = (char *) xnarch_fault_pc(d);
-	if (unlikely(thumb_mode(d->regs))) {
-		unsigned short thumbh, thumbl;
-
-#if defined(CONFIG_ARM_THUMB) && __LINUX_ARM_ARCH__ >= 6 && defined(CONFIG_CPU_V7)
-#if __LINUX_ARM_ARCH__ < 7
-		if (cpu_architecture() < CPU_ARCH_ARMv7)
-#else
-		if (0)
-#endif /* arch < 7 */
-#endif /* thumb && arch >= 6 && cpu_v7 */
-			return 0;
-
-		thumbh = *(unsigned short *) pc;
-		thumbl = *((unsigned short *) pc + 1);
-
-		if ((thumbh & 0x0000f800) < 0x0000e800)
-			return 0;
-		instr = (thumbh << 16) | thumbl;
-
-#ifdef CONFIG_NEON
-		if ((instr & 0xef000000) == 0xef000000
-		    || (instr & 0xff100000) == 0xf9000000)
-			goto trap_vfp;
-#endif
-	} else {
-		instr = *(unsigned *) pc;
-
-#ifdef CONFIG_NEON
-		if ((instr & 0xfe000000) == 0xf2000000
-		    || (instr & 0xff100000) == 0xf4000000)
-			goto trap_vfp;
-#endif
-	}
-
-	if ((instr & 0x0c000000) != 0x0c000000)
-		return 0;
-
-	cp = (instr & 0x00000f00) >> 8;
-#ifdef CONFIG_IWMMXT
-	/* We need something equivalent to _TIF_USING_IWMMXT for Xenomai kernel
-	   threads */
-	if (cp <= 1) {
-		d->exception = IPIPE_TRAP_FPU;
-		return 1;
-	}
-#endif
-
-	exc = copro_to_exc[cp];
-	if (exc == IPIPE_TRAP_VFP) {
-	  trap_vfp:
-		/* If an exception is pending, the VFP fault is not really an
-		   "FPU unavailable" fault, so we return undefinstr in that
-		   case, the nucleus will let linux handle the fault. */
-		exc = do_vfp_fmrx(FPEXC);
-		if (exc & (FPEXC_EX|FPEXC_DEX)
-		    || ((exc & FPEXC_EN) && do_vfp_fmrx(FPSCR) & FPSCR_IXE))
-			exc = IPIPE_TRAP_UNDEFINSTR;
-		else
-			exc = IPIPE_TRAP_VFP;
-	}
-
-	d->exception = exc;
-	return exc != IPIPE_TRAP_UNDEFINSTR;
-}
-
-void xnarch_leave_root(struct xnthread *root)
-{
-	struct xnarchtcb *rootcb = xnthread_archtcb(root);
-	rootcb->fpup = get_fpu_owner();
-}
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
-{
-	union vfp_state *const from_fpup = from ? from->tcb.fpup : NULL;
-	unsigned cpu = raw_smp_processor_id();
-
-	if (xnthread_test_state(to, XNROOT) == 0) {
-		union vfp_state *const to_fpup = to->tcb.fpup;
-		unsigned fpexc = do_enable_vfp();
-
-		if (from_fpup == to_fpup)
-			return;
-
-		if (from_fpup)
-			__asm_vfp_save(from_fpup, fpexc);
-
-		__asm_vfp_load(to_fpup, cpu);
-       } else {
-		/*
-		 * We are restoring the Linux current thread. The FPU
-		 * can be disabled, so that a fault will occur if the
-		 * newly switched thread uses the FPU, to allow the
-		 * kernel handler to pick the correct FPU context, and
-		 * save in the same move the last used RT context.
-		 */
-		vfp_current_hw_state[cpu] = from_fpup;
-#ifdef CONFIG_SMP
-		/*
-		 * On SMP, since returning to FPU disabled mode means
-		 * that we have to save fpu, avoid doing it if
-		 * current FPU context belongs to the task we are
-		 * switching to.
-		 */
-		if (from_fpup) {
-			union vfp_state *const current_task_fpup =
-				&to->tcb.core.tip->vfpstate;
-			const unsigned fpdis = do_vfp_fmrx(FPEXC);
-			const unsigned fpen = fpdis | FPEXC_EN;
-
-			do_vfp_fmxr(FPEXC, fpen & ~XNARCH_VFP_ANY_EXC);
-			if (from_fpup == current_task_fpup)
-				return;
-
-			__asm_vfp_save(from_fpup, fpen);
-			do_vfp_fmxr(FPEXC, fpdis);
-		}
-#endif
-	}
-}
-
-int xnarch_handle_fpu_fault(struct xnthread *from,
-			struct xnthread *to, struct ipipe_trap_data *d)
-{
-	if (xnthread_test_state(to, XNFPU))
-		/* FPU is already enabled, probably an exception */
-               return 0;
-
-#if __LINUX_ARM_ARCH__ <= 6
-	if (!static_key_true(&__xeno_vfp_key))
-		/* VFP instruction emitted, on a cpu without VFP, this
-		   is an error */
-		return 0;
-#endif
-
-	xnlock_get(&nklock);
-	xnthread_set_state(to, XNFPU);
-	xnlock_put(&nklock);
-
-	xnarch_switch_fpu(from, to);
-
-	/* Retry faulting instruction */
-	d->regs->ARM_pc = xnarch_fault_pc(d);
-	return 1;
-}
-
-void xnarch_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-
-	tcb->fpup = &task_thread_info(tcb->core.host_task)->vfpstate;
-
-	if (vfp_checked == 0) {
-		mutex_lock(&vfp_check_lock);
-		if (vfp_checked == 0) {
-			if ((elf_hwcap & HWCAP_VFP) == 0)
-				static_key_slow_dec(&__xeno_vfp_key);
-			vfp_checked = 1;
-		}
-		mutex_unlock(&vfp_check_lock);
-	}
-
-	/* XNFPU is set upon first FPU fault */
-	xnthread_clear_state(thread, XNFPU);
-}
-
-void xnarch_init_root_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = &thread->tcb;
-	tcb->fpup = NULL;
-}
-
-#endif /* CONFIG_XENO_ARCH_FPU && CONFIG_VFP*/
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
-{
-	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
-	struct mm_struct *prev_mm, *next_mm;
-	struct task_struct *next;
-
-	next = in_tcb->core.host_task;
-	prev_mm = out_tcb->core.active_mm;
-
-	next_mm = in_tcb->core.mm;
-	if (next_mm == NULL) {
-		in_tcb->core.active_mm = prev_mm;
-		enter_lazy_tlb(prev_mm, next);
-	} else {
-		ipipe_switch_mm_head(prev_mm, next_mm, next);
-		/*
-		 * We might be switching back to the root thread,
-		 * which we preempted earlier, shortly after "current"
-		 * dropped its mm context in the do_exit() path
-		 * (next->mm == NULL). In that particular case, the
-		 * kernel expects a lazy TLB state for leaving the mm.
-		 */
-		if (next->mm == NULL)
-			enter_lazy_tlb(prev_mm, next);
-	}
-
-	__asm_thread_switch(out_tcb->core.tip, in_tcb->core.tip);
-}
diff --git a/kernel/cobalt/arch/arm64/ipipe/Makefile b/kernel/cobalt/arch/arm64/ipipe/Makefile
deleted file mode 100644
index cf12a18014..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-$(CONFIG_XENOMAI) += xenomai.o
-
-xenomai-y := machine.o thread.o syscall.o
-
-ccflags-y := -I$(srctree)/arch/arm64/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/arm64/ipipe/README b/kernel/cobalt/arch/arm64/ipipe/README
deleted file mode 100644
index 80f954aef6..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/README
+++ /dev/null
@@ -1,3 +0,0 @@
-Get the interrupt pipeline code for the target kernel from
-http://xenomai.org/downloads/ipipe/, or
-git://git.xenomai.org/ipipe.git
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/calibration.h
deleted file mode 100644
index e85521e139..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/calibration.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * Copyright (C) 2015 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_CALIBRATION_H
-#define _COBALT_ARM64_ASM_CALIBRATION_H
-
-static inline void xnarch_get_latencies(struct xnclock_gravity *p)
-{
-	unsigned int ulat;
-#if CONFIG_XENO_OPT_TIMING_SCHEDLAT != 0
-	ulat = CONFIG_XENO_OPT_TIMING_SCHEDLAT;
-#elif defined(CONFIG_ARCH_HISI)
-	ulat = 4000;
-#else
-	ulat = 4000;
-#endif
-	p->user = xnclock_ns_to_ticks(&nkclock, ulat);
-	p->kernel = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
-	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
-}
-
-#endif /* !_COBALT_ARM64_ASM_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/features.h
deleted file mode 100644
index 112408fe29..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/features.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2015 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_FEATURES_H
-#define _COBALT_ARM64_ASM_FEATURES_H
-
-struct cobalt_featinfo;
-static inline void collect_arch_features(struct cobalt_featinfo *p) { }
-
-#include <asm/xenomai/uapi/features.h>
-
-#endif /* !_COBALT_ARM64_ASM_FEATURES_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
deleted file mode 100644
index 291c9e5f01..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/fptest.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_FPTEST_H
-#define _COBALT_ARM64_ASM_FPTEST_H
-
-#include <linux/errno.h>
-#include <asm/xenomai/uapi/fptest.h>
-#include <asm/hwcap.h>
-
-#define have_fp (ELF_HWCAP & HWCAP_FP)
-
-static inline int fp_kernel_supported(void)
-{
-	return 0;
-}
-
-static inline int fp_linux_begin(void)
-{
-	return -ENOSYS;
-}
-
-static inline void fp_linux_end(void)
-{
-}
-
-static inline int fp_detect(void)
-{
-	return have_fp ? __COBALT_HAVE_FPU : 0;
-}
-
-#endif /* _COBALT_ARM64_ASM_FPTEST_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
deleted file mode 100644
index c91c8f58ef..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/machine.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/**
- *   Copyright &copy; 2002-2004 Philippe Gerum.
- *
- *   ARM port
- *     Copyright (C) 2005 Stelian Pop
- *
- *   ARM64 port
- *     Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
- *
- *   Xenomai is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License as
- *   published by the Free Software Foundation, Inc., 675 Mass Ave,
- *   Cambridge MA 02139, USA; either version 2 of the License, or (at
- *   your option) any later version.
- *
- *   Xenomai is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *   General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with Xenomai; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- *   02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_MACHINE_H
-#define _COBALT_ARM64_ASM_MACHINE_H
-
-#include <linux/version.h>
-#include <asm/byteorder.h>
-
-#define XNARCH_HOST_TICK_IRQ __ipipe_hrtimer_irq
-
-#include <asm/barrier.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
-#include <asm/compiler.h>
-#endif
-
-#include <asm/cmpxchg.h>
-#include <asm/switch_to.h>
-#include <asm/system_misc.h>
-#include <asm/timex.h>
-#include <asm/processor.h>
-#include <asm/ipipe.h>
-#include <asm/cacheflush.h>
-#include <cobalt/kernel/assert.h>
-
-/* D-side always behaves as PIPT on AArch64 (see arch/arm64/include/asm/cachetype.h) */
-#define xnarch_cache_aliasing() 0
-
-static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
-{
-	int __r;
-
-	/* zero input is not valid */
-	XENO_WARN_ON(COBALT, ul == 0);
-
-	__asm__ ("rbit\t%0, %1\n"
-	         "clz\t%0, %0\n"
-	        : "=r" (__r) : "r"(ul) : "cc");
-
-	return __r;
-}
-
-#include <asm-generic/xenomai/machine.h>
-
-#endif /* !_COBALT_ARM64_ASM_MACHINE_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall.h
deleted file mode 100644
index 6b8b71d3b1..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_SYSCALL_H
-#define _COBALT_ARM64_ASM_SYSCALL_H
-
-#include <linux/errno.h>
-#include <linux/uaccess.h>
-#include <asm/unistd.h>
-#include <asm/ptrace.h>
-#include <asm-generic/xenomai/syscall.h>
-
-/*
- * Cobalt and Linux syscall numbers can be fetched from syscallno,
- * masking out the __COBALT_SYSCALL_BIT marker.
- */
-#define __xn_reg_sys(__regs)	((unsigned long)(__regs)->syscallno)
-#define __xn_syscall_p(regs)	((__xn_reg_sys(regs) & __COBALT_SYSCALL_BIT) != 0)
-#define __xn_syscall(__regs)	((unsigned long)(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT))
-
-#define __xn_reg_rval(__regs)	((__regs)->regs[0])
-#define __xn_reg_arg1(__regs)	((__regs)->regs[0])
-#define __xn_reg_arg2(__regs)	((__regs)->regs[1])
-#define __xn_reg_arg3(__regs)	((__regs)->regs[2])
-#define __xn_reg_arg4(__regs)	((__regs)->regs[3])
-#define __xn_reg_arg5(__regs)	((__regs)->regs[4])
-#define __xn_reg_pc(__regs)	((__regs)->pc)
-#define __xn_reg_sp(__regs)	((__regs)->sp)
-
-/*
- * Root syscall number with predicate (valid only if
- * !__xn_syscall_p(__regs)).
- */
-#define __xn_rootcall_p(__regs, __code)			\
-	({						\
-		*(__code) = __xn_syscall(__regs);	\
-		*(__code) < NR_syscalls;		\
-	})
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, long v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) == -EINTR;
-}
-
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			 unsigned long a3, unsigned long a4,
-			 unsigned long a5);
-
-#endif /* !_COBALT_ARM64_ASM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall32.h
deleted file mode 100644
index a66ddd6807..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/syscall32.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2014 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_SYSCALL32_H
-#define _COBALT_ARM64_ASM_SYSCALL32_H
-
-#include <asm-generic/xenomai/syscall32.h>
-
-#endif /* !_COBALT_ARM64_ASM_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
deleted file mode 100644
index 7899a49e64..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/thread.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- * Copyright (C) 2005 Stelian Pop
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_THREAD_H
-#define _COBALT_ARM64_ASM_THREAD_H
-
-#include <linux/version.h>
-#include <asm-generic/xenomai/ipipe/thread.h>
-
-#if defined(CONFIG_XENO_ARCH_FPU) && LINUX_VERSION_CODE < KERNEL_VERSION(4,9,0)
-#define ARM64_XENO_OLD_SWITCH
-#endif
-
-struct xnarchtcb {
-	struct xntcb core;
-#ifdef ARM64_XENO_OLD_SWITCH
-	struct fpsimd_state xnfpsimd_state;
-	struct fpsimd_state *fpup;
-#define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
-#endif
-};
-
-#define xnarch_fault_regs(d)	((d)->regs)
-#define xnarch_fault_trap(d)	((d)->exception)
-#define xnarch_fault_code(d)	(0)
-#define xnarch_fault_pc(d)	((unsigned long)((d)->regs->pc - 4)) /* XXX ? */
-
-#define xnarch_fault_pf_p(d)	((d)->exception == IPIPE_TRAP_ACCESS)
-#define xnarch_fault_bp_p(d)	((current->ptrace & PT_PTRACED) &&	\
-				 ((d)->exception == IPIPE_TRAP_BREAK ||	\
-				  (d)->exception == IPIPE_TRAP_UNDEFINSTR))
-
-#define xnarch_fault_notify(d) (!xnarch_fault_bp_p(d))
-
-static inline
-struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
-{
-	return tcb->core.host_task;
-}
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
-
-static inline void xnarch_enter_root(struct xnthread *root) { }
-
-int xnarch_escalate(void);
-
-#ifdef ARM64_XENO_OLD_SWITCH
-
-void xnarch_init_root_tcb(struct xnthread *thread);
-
-void xnarch_init_shadow_tcb(struct xnthread *thread);
-
-void xnarch_leave_root(struct xnthread *root);
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread);
-
-#else /* !ARM64_XENO_OLD_SWITCH */
-
-static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
-static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
-static inline void xnarch_leave_root(struct xnthread *root) { }
-static inline void xnarch_switch_fpu(struct xnthread *f, struct xnthread *t) { }
-
-#endif /*  !ARM64_XENO_OLD_SWITCH */
-
-static inline int xnarch_fault_fpu_p(struct ipipe_trap_data *d)
-{
-	return xnarch_fault_trap(d) == IPIPE_TRAP_FPU_ACC;
-}
-
-static inline int
-xnarch_handle_fpu_fault(struct xnthread *from,
-			struct xnthread *to, struct ipipe_trap_data *d)
-{
-	return 0;
-}
-
-static inline void xnarch_enable_kfpu(void) { }
-
-static inline void xnarch_disable_kfpu(void) { }
-
-#endif /* !_COBALT_ARM64_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/wrappers.h
deleted file mode 100644
index 5a5754fd65..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/include/asm/xenomai/wrappers.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ARM64_ASM_WRAPPERS_H
-#define _COBALT_ARM64_ASM_WRAPPERS_H
-
-#include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
-
-#define __put_user_inatomic __put_user
-#define __get_user_inatomic __get_user
-
-#endif /* _COBALT_ARM64_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/arm64/ipipe/machine.c b/kernel/cobalt/arch/arm64/ipipe/machine.c
deleted file mode 100644
index 521b734da2..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/machine.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/**
- *   Copyright (C) 2005 Stelian Pop
- *
- *   ARM64 port
- *     Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
- *
- *   Xenomai is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License as
- *   published by the Free Software Foundation, Inc., 675 Mass Ave,
- *   Cambridge MA 02139, USA; either version 2 of the License, or (at
- *   your option) any later version.
- *
- *   Xenomai is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *   General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- *   02111-1307, USA.
- */
-
-#include <linux/mm.h>
-#include <asm/xenomai/machine.h>
-
-static void mach_arm_prefault(struct vm_area_struct *vma)
-{
-	unsigned long addr;
-	unsigned int flags;
-
-	if ((vma->vm_flags & VM_MAYREAD)) {
-		flags = (vma->vm_flags & VM_MAYWRITE) ? FAULT_FLAG_WRITE : 0;
-		for (addr = vma->vm_start;
-		     addr != vma->vm_end; addr += PAGE_SIZE)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-			handle_mm_fault(vma->vm_mm, vma, addr, flags);
-#else
-			handle_mm_fault(vma, addr, flags);
-#endif
-	}
-}
-
-static const char *const fault_labels[] = {
-	[IPIPE_TRAP_ACCESS] = "Data or instruction access",
-	[IPIPE_TRAP_SECTION] = "Section fault",
-	[IPIPE_TRAP_DABT] = "Generic data abort",
-	[IPIPE_TRAP_UNKNOWN] = "Unknown exception",
-	[IPIPE_TRAP_BREAK] = "Instruction breakpoint",
-	[IPIPE_TRAP_FPU_ACC] = "Floating point access",
-	[IPIPE_TRAP_FPU_EXC] = "Floating point exception",
-	[IPIPE_TRAP_UNDEFINSTR] = "Undefined instruction",
-#ifdef IPIPE_TRAP_ALIGNMENT
-	[IPIPE_TRAP_ALIGNMENT] = "Unaligned access exception",
-#endif /* IPIPE_TRAP_ALIGNMENT */
-	[IPIPE_NR_FAULTS] = NULL
-};
-
-struct cobalt_machine cobalt_machine = {
-	.name = "arm",
-	.init = NULL,
-	.late_init = NULL,
-	.cleanup = NULL,
-	.prefault = mach_arm_prefault,
-	.fault_labels = fault_labels,
-};
diff --git a/kernel/cobalt/arch/arm64/ipipe/syscall.c b/kernel/cobalt/arch/arm64/ipipe/syscall.c
deleted file mode 100644
index ee78243c52..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/syscall.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * Copyright (C) 2005 Stelian Pop
- * Copyright (C) 2010 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/ipipe.h>
-#include <asm/xenomai/syscall.h>
-#include <asm/xenomai/uapi/tsc.h>
-
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			 unsigned long a3, unsigned long a4,
-			 unsigned long a5)
-{
-	struct ipipe_sysinfo ipipe_info;
-	struct __ipipe_tscinfo *p = &ipipe_info.arch.tsc;
-	struct __xn_tscinfo info;
-	int ret;
-
-	if (a1 != XENOMAI_SYSARCH_TSCINFO)
-		return -EINVAL;
-
-	ret = ipipe_get_sysinfo(&ipipe_info);
-	if (ret)
-		return ret;
-
-	switch (p->type) {
-	case IPIPE_TSC_TYPE_DECREMENTER:
-		info.counter = p->u.dec.counter;
-		break;
-	case IPIPE_TSC_TYPE_NONE:
-		return -ENOSYS;
-	default:
-		info.counter = p->u.fr.counter;
-		break;
-	}
-
-	return cobalt_copy_to_user((void *)a2, &info, sizeof(info));
-}
diff --git a/kernel/cobalt/arch/arm64/ipipe/thread.c b/kernel/cobalt/arch/arm64/ipipe/thread.c
deleted file mode 100644
index 1068f80cc7..0000000000
--- a/kernel/cobalt/arch/arm64/ipipe/thread.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * ARM port
- *   Copyright (C) 2005 Stelian Pop
- * 
- * ARM64 port
- *   Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
- *   Copyright (C) 2015 Gilles Chanteperdrix <gch@xenomai.org>
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/sched.h>
-#include <linux/ipipe.h>
-#include <linux/mm.h>
-#include <linux/jump_label.h>
-#include <asm/mmu_context.h>
-#include <cobalt/kernel/thread.h>
-#include <asm/fpsimd.h>
-#include <asm/processor.h>
-#include <asm/hw_breakpoint.h>
-
-#ifdef ARM64_XENO_OLD_SWITCH
-
-#include <asm/fpsimd.h>
-
-#define FPSIMD_EN (0x3 << 20)
-
-static inline unsigned long get_cpacr(void)
-{
-	unsigned long result;
-	__asm__ ("mrs %0, cpacr_el1": "=r"(result));
-	return result;
-}
-
-static inline void set_cpacr(long val)
-{
-	__asm__ __volatile__ (
-		"msr cpacr_el1, %0\n\t"
-		"isb"
-		: /* */ : "r"(val));
-}
-
-static inline void enable_fpsimd(void)
-{
-	set_cpacr(get_cpacr() | FPSIMD_EN);
-}
-
-static inline struct fpsimd_state *get_fpu_owner(struct xnarchtcb *rootcb)
-{
-	struct task_struct *curr = rootcb->core.host_task;
-
-	if (test_ti_thread_flag(task_thread_info(curr), TIF_FOREIGN_FPSTATE))
-		/* Foreign fpu state, use auxiliary backup area */
-		return &rootcb->xnfpsimd_state;
-
-	return &curr->thread.fpsimd_state;
-}
-
-void xnarch_leave_root(struct xnthread *root)
-{
-	struct xnarchtcb *rootcb = xnthread_archtcb(root);
-	rootcb->fpup = get_fpu_owner(rootcb);
-}
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
-{
-	struct fpsimd_state *const from_fpup = from ? from->tcb.fpup : NULL;
-	struct fpsimd_state *const to_fpup = to->tcb.fpup;
-
-	enable_fpsimd();
-
-	if (from_fpup == to_fpup)
-		return;
-
-	fpsimd_save_state(from_fpup);
-
-	fpsimd_load_state(to_fpup);
-	to_fpup->cpu = raw_smp_processor_id();
-}
-
-void xnarch_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	tcb->fpup = &tcb->core.host_task->thread.fpsimd_state;
-}
-
-void xnarch_init_root_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = &thread->tcb;
-	tcb->fpup = NULL;
-}
-
-#endif /* ARM64_XENO_OLD_SWITCH */
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
-{
-	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
-	struct task_struct *prev, *next, *last;
-	struct mm_struct *prev_mm, *next_mm;
-
-	next = in_tcb->core.host_task;
-	prev = out_tcb->core.host_task;
-	prev_mm = out_tcb->core.active_mm;
-
-	next_mm = in_tcb->core.mm;
-	if (next_mm == NULL) {
-		in_tcb->core.active_mm = prev_mm;
-		enter_lazy_tlb(prev_mm, next);
-	} else {
-		ipipe_switch_mm_head(prev_mm, next_mm, next);
-		/*
-		 * We might be switching back to the root thread,
-		 * which we preempted earlier, shortly after "current"
-		 * dropped its mm context in the do_exit() path
-		 * (next->mm == NULL). In that particular case, the
-		 * kernel expects a lazy TLB state for leaving the mm.
-		 */
-		if (next->mm == NULL)
-			enter_lazy_tlb(prev_mm, next);
-	}
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,9,0)
-	ipipe_switch_to(prev, next);
-	(void)last;
-#else
-	switch_to(prev, next, last);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0)
-	fpsimd_restore_current_state();
-#endif
-#endif
-}
-
-int xnarch_escalate(void)
-{
-	if (ipipe_root_p) {
-		ipipe_raise_irq(cobalt_pipeline.escalate_virq);
-		return 1;
-	}
-
-	return 0;
-}
diff --git a/kernel/cobalt/arch/x86/dovetail/c1e.c b/kernel/cobalt/arch/x86/dovetail/c1e.c
deleted file mode 120000
index 5dc924ec6c..0000000000
--- a/kernel/cobalt/arch/x86/dovetail/c1e.c
+++ /dev/null
@@ -1 +0,0 @@
-../ipipe/c1e.c
\ No newline at end of file
diff --git a/kernel/cobalt/arch/x86/dovetail/c1e.c b/kernel/cobalt/arch/x86/dovetail/c1e.c
new file mode 100644
index 0000000000..9bd4e92a6f
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/c1e.c
@@ -0,0 +1,72 @@
+/*
+ * Disable Intel automatic promotion to C1E mode.
+ * Lifted from drivers/idle/intel_idle.c
+ * Copyright (c) 2013, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+#include <linux/smp.h>
+#include <asm/processor.h>
+#include <asm/cpu_device_id.h>
+#include <asm/msr.h>
+
+#define ICPU(model) \
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, 1UL }
+
+static const struct x86_cpu_id c1e_ids[] = {
+	ICPU(0x1a),
+	ICPU(0x1e),
+	ICPU(0x1f),
+	ICPU(0x25),
+	ICPU(0x2c),
+	ICPU(0x2e),
+	ICPU(0x2f),
+	ICPU(0x2a),
+	ICPU(0x2d),
+	ICPU(0x3a),
+	ICPU(0x3e),
+	ICPU(0x3c),
+	ICPU(0x3f),
+	ICPU(0x45),
+	ICPU(0x46),
+	ICPU(0x4D),
+	{}
+};
+
+#undef ICPU
+
+static void c1e_promotion_disable(void *dummy)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	msr_bits &= ~0x2;
+	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
+}
+
+void mach_x86_c1e_disable(void)
+{
+	const struct x86_cpu_id *id;
+
+	id = x86_match_cpu(c1e_ids);
+	if (id) {
+		printk("[Xenomai] disabling automatic C1E state promotion on Intel processor\n");
+		/*
+		 * cpu uses C1E, disable this feature (copied from
+		 * intel_idle driver)
+		 */
+		on_each_cpu(c1e_promotion_disable, NULL, 1);
+	}
+}
diff --git a/kernel/cobalt/arch/x86/dovetail/smi.c b/kernel/cobalt/arch/x86/dovetail/smi.c
deleted file mode 120000
index 8d197210f4..0000000000
--- a/kernel/cobalt/arch/x86/dovetail/smi.c
+++ /dev/null
@@ -1 +0,0 @@
-../ipipe/smi.c
\ No newline at end of file
diff --git a/kernel/cobalt/arch/x86/dovetail/smi.c b/kernel/cobalt/arch/x86/dovetail/smi.c
new file mode 100644
index 0000000000..f28af9a3b5
--- /dev/null
+++ b/kernel/cobalt/arch/x86/dovetail/smi.c
@@ -0,0 +1,168 @@
+/**
+ *   SMI workaround for x86.
+ *
+ *   Cut/Pasted from Vitor Angelo "smi" module.
+ *   Adapted by Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/ctype.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/reboot.h>
+#include <cobalt/kernel/assert.h>
+#include <asm-generic/xenomai/pci_ids.h>
+#include <asm/xenomai/machine.h>
+
+#define DEVFN		0xf8	/* device 31, function 0 */
+
+#define PMBASE_B0	0x40
+#define PMBASE_B1	0x41
+
+#define SMI_CTRL_ADDR	0x30
+
+static int smi_state;
+static char smi_state_arg[16] = "detect";
+module_param_string(smi, smi_state_arg, sizeof(smi_state_arg), 0444);
+
+static unsigned int smi_masked_bits = 1; /* Global disable bit */
+module_param_named(smi_mask, smi_masked_bits, int, 0400);
+
+static unsigned int smi_saved_bits;
+static unsigned short smi_en_addr;
+
+#define mask_bits(v, p) outl(inl(p)&~(v),(p))
+#define set_bits(v, p)  outl(inl(p)|(v), (p))
+
+static int smi_reboot(struct notifier_block *nb, ulong event, void *buf);
+
+static struct notifier_block smi_notifier = {
+	.notifier_call = smi_reboot
+};
+
+static int smi_reboot(struct notifier_block *nb, ulong event, void *buf)
+{
+	if (((event == SYS_RESTART) || (event == SYS_HALT) ||
+	     (event == SYS_POWER_OFF)) && smi_en_addr)
+		set_bits(smi_saved_bits, smi_en_addr);
+
+	return NOTIFY_DONE;
+}
+
+void mach_x86_smi_disable(void)
+{
+	if (smi_en_addr == 0)
+		return;
+
+	smi_saved_bits = inl(smi_en_addr) & smi_masked_bits;
+	mask_bits(smi_masked_bits, smi_en_addr);
+
+	if (inl(smi_en_addr) & smi_masked_bits)
+		printk(XENO_WARNING "SMI workaround failed!\n");
+	else
+		printk(XENO_INFO "SMI workaround enabled\n");
+
+	register_reboot_notifier(&smi_notifier);
+}
+
+void mach_x86_smi_restore(void)
+{
+	if (smi_en_addr == 0)
+		return;
+
+	printk(XENO_INFO "SMI configuration restored\n");
+
+	set_bits(smi_saved_bits, smi_en_addr);
+
+	unregister_reboot_notifier(&smi_notifier);
+}
+
+static unsigned short get_smi_en_addr(struct pci_dev *dev)
+{
+	u_int8_t byte0, byte1;
+
+	pci_read_config_byte(dev, PMBASE_B0, &byte0);
+	pci_read_config_byte(dev, PMBASE_B1, &byte1);
+	return SMI_CTRL_ADDR + (((byte1 << 1) | (byte0 >> 7)) << 7);	// bits 7-15
+}
+
+
+static const char *smi_state_labels[] = {
+	"disabled",
+	"detect",
+	"enabled",
+};
+
+static void setup_smi_state(void)
+{
+	static char warn_bad_state[] =
+		XENO_WARNING "invalid SMI state '%s'\n";
+	char *p;
+	int n;
+
+	/* Backward compat with legacy state specifiers. */
+	n = simple_strtol(smi_state_arg, &p, 10);
+	if (*p == '\0') {
+		smi_state = n;
+		return;
+	}
+
+	for (n = 0; n < ARRAY_SIZE(smi_state_labels); n++)
+		if (strcmp(smi_state_labels[n], smi_state_arg) == 0) {
+			smi_state = n - 1;
+			return;
+		}
+
+	printk(warn_bad_state, smi_state_arg);
+}
+
+void mach_x86_smi_init(void)
+{
+	struct pci_dev *dev = NULL;
+
+	setup_smi_state();
+
+	if (smi_state < 0)
+		return;
+
+	/*
+	 * Do not use pci_register_driver, pci_enable_device, ...
+	 * Just register the used ports.
+	 */
+	dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+	if (dev == NULL || dev->bus->number ||
+	    dev->devfn != DEVFN || dev->vendor != PCI_VENDOR_ID_INTEL) {
+		pci_dev_put(dev);
+		return;
+	}
+
+	if (smi_state == 0) {
+		printk(XENO_WARNING "SMI-enabled chipset found, but SMI workaround disabled\n"
+		       "          (see xenomai.smi parameter). You might encounter\n"
+		       "          high latencies!\n");
+		pci_dev_put(dev);
+		return;
+	}
+
+	printk(XENO_INFO "SMI-enabled chipset found\n");
+	smi_en_addr = get_smi_en_addr(dev);
+
+	pci_dev_put(dev);
+}
diff --git a/kernel/cobalt/arch/x86/ipipe/Makefile b/kernel/cobalt/arch/x86/ipipe/Makefile
deleted file mode 100644
index 1ef407c353..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-
-obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o thread.o smi.o c1e.o
-
-ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/x86/ipipe/README b/kernel/cobalt/arch/x86/ipipe/README
deleted file mode 100644
index 80f954aef6..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/README
+++ /dev/null
@@ -1,3 +0,0 @@
-Get the interrupt pipeline code for the target kernel from
-http://xenomai.org/downloads/ipipe/, or
-git://git.xenomai.org/ipipe.git
diff --git a/kernel/cobalt/arch/x86/ipipe/c1e.c b/kernel/cobalt/arch/x86/ipipe/c1e.c
deleted file mode 100644
index 9bd4e92a6f..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/c1e.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Disable Intel automatic promotion to C1E mode.
- * Lifted from drivers/idle/intel_idle.c
- * Copyright (c) 2013, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-#include <linux/smp.h>
-#include <asm/processor.h>
-#include <asm/cpu_device_id.h>
-#include <asm/msr.h>
-
-#define ICPU(model) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, 1UL }
-
-static const struct x86_cpu_id c1e_ids[] = {
-	ICPU(0x1a),
-	ICPU(0x1e),
-	ICPU(0x1f),
-	ICPU(0x25),
-	ICPU(0x2c),
-	ICPU(0x2e),
-	ICPU(0x2f),
-	ICPU(0x2a),
-	ICPU(0x2d),
-	ICPU(0x3a),
-	ICPU(0x3e),
-	ICPU(0x3c),
-	ICPU(0x3f),
-	ICPU(0x45),
-	ICPU(0x46),
-	ICPU(0x4D),
-	{}
-};
-
-#undef ICPU
-
-static void c1e_promotion_disable(void *dummy)
-{
-	unsigned long long msr_bits;
-
-	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
-	msr_bits &= ~0x2;
-	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
-}
-
-void mach_x86_c1e_disable(void)
-{
-	const struct x86_cpu_id *id;
-
-	id = x86_match_cpu(c1e_ids);
-	if (id) {
-		printk("[Xenomai] disabling automatic C1E state promotion on Intel processor\n");
-		/*
-		 * cpu uses C1E, disable this feature (copied from
-		 * intel_idle driver)
-		 */
-		on_each_cpu(c1e_promotion_disable, NULL, 1);
-	}
-}
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
deleted file mode 100644
index eaecc48d43..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/calibration.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004,2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_X86_ASM_CALIBRATION_H
-#define _COBALT_X86_ASM_CALIBRATION_H
-
-#include <asm/processor.h>
-
-static inline unsigned long __get_bogomips(void)
-{
-	return this_cpu_read(cpu_info.loops_per_jiffy)/(500000/HZ);
-}
-
-static inline void xnarch_get_latencies(struct xnclock_gravity *p)
-{
-	unsigned long sched_latency;
-
-#if CONFIG_XENO_OPT_TIMING_SCHEDLAT != 0
-	sched_latency = CONFIG_XENO_OPT_TIMING_SCHEDLAT;
-#else /* !CONFIG_XENO_OPT_TIMING_SCHEDLAT */
-
-	if (strcmp(ipipe_timer_name(), "lapic") == 0) {
-#ifdef CONFIG_SMP
-		if (num_online_cpus() > 1)
-			sched_latency = 3350;
-		else
-			sched_latency = 2000;
-#else /* !SMP */
-		sched_latency = 1000;
-#endif /* !SMP */
-	} else if (strcmp(ipipe_timer_name(), "pit")) { /* HPET */
-#ifdef CONFIG_SMP
-		if (num_online_cpus() > 1)
-			sched_latency = 3350;
-		else
-			sched_latency = 1500;
-#else /* !SMP */
-		sched_latency = 1000;
-#endif /* !SMP */
-	} else {
-		sched_latency = (__get_bogomips() < 250 ? 17000 :
-				 __get_bogomips() < 2500 ? 4200 :
-				 3500);
-#ifdef CONFIG_SMP
-		sched_latency += 1000;
-#endif /* CONFIG_SMP */
-	}
-#endif /* !CONFIG_XENO_OPT_TIMING_SCHEDLAT */
-
-	p->user = xnclock_ns_to_ticks(&nkclock, sched_latency);
-	p->kernel = xnclock_ns_to_ticks(&nkclock,
-					CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
-	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
-}
-
-#endif /* !_COBALT_X86_ASM_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
deleted file mode 100644
index f0ecd00e9c..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/fptest.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_X86_ASM_FPTEST_H
-#define _COBALT_X86_ASM_FPTEST_H
-
-#include <linux/errno.h>
-#include <asm/processor.h>
-#include <asm/xenomai/wrappers.h>
-#include <asm/xenomai/uapi/fptest.h>
-
-static inline int fp_kernel_supported(void)
-{
-	return 1;
-}
-
-static inline int fp_linux_begin(void)
-{
-#if defined(CONFIG_X86_USE_3DNOW) \
-	|| defined(CONFIG_MD_RAID456) || defined(CONFIG_MD_RAID456_MODULE)
-	/* Ther kernel uses x86 FPU, we can not also use it in our tests. */
-	static int once = 0;
-	if (!once) {
-		once = 1;
-		printk("%s:%d: Warning: Linux is compiled to use FPU in "
-		       "kernel-space.\nFor this reason, switchtest can not "
-		       "test using FPU in Linux kernel-space.\n",
-		       __FILE__, __LINE__);
-	}
-	return -EBUSY;
-#endif /* 3DNow or RAID 456 */
-	kernel_fpu_begin();
-	/* kernel_fpu_begin() does no re-initialize the fpu context, but
-	   fp_regs_set() implicitely expects an initialized fpu context, so
-	   initialize it here. */
-	__asm__ __volatile__("fninit");
-	return 0;
-}
-
-static inline void fp_linux_end(void)
-{
-	kernel_fpu_end();
-}
-
-static inline int fp_detect(void)
-{
-	int features = 0;
-
-#ifndef cpu_has_xmm2
-#ifdef cpu_has_sse2
-#define cpu_has_xmm2 cpu_has_sse2
-#else
-#define cpu_has_xmm2 0
-#endif
-#endif
-	if (cpu_has_xmm2)
-		features |= __COBALT_HAVE_SSE2;
-
-#ifndef cpu_has_avx
-#define cpu_has_avx 0
-#endif
-	if (cpu_has_avx)
-		features |= __COBALT_HAVE_AVX;
-
-	return features;
-}
-
-#endif /* _COBALT_X86_ASM_FPTEST_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
deleted file mode 100644
index 750eb1ec50..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/machine.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/**
- * Copyright (C) 2007-2012 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_X86_ASM_MACHINE_H
-#define _COBALT_X86_ASM_MACHINE_H
-
-#include <linux/compiler.h>
-
-static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
-{
-	__asm__("bsfq %1, %0":"=r" (ul) : "rm" (ul));
-	return ul;
-}
-
-#define XNARCH_HOST_TICK_IRQ	__ipipe_hrtimer_irq
-
-/* Read this last to enable default settings. */
-#include <asm-generic/xenomai/machine.h>
-
-#endif /* !_COBALT_X86_ASM_MACHINE_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
deleted file mode 100644
index f889f5fc73..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * Copyright (C) 2001-2014 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_X86_ASM_SYSCALL_H
-#define _COBALT_X86_ASM_SYSCALL_H
-
-#include <linux/errno.h>
-#include <asm/ptrace.h>
-#include <asm-generic/xenomai/syscall.h>
-
-/*
- * Cobalt and Linux syscall numbers can be fetched from ORIG_AX,
- * masking out the __COBALT_SYSCALL_BIT marker.
- */
-#define __xn_reg_sys(regs)    ((regs)->orig_ax)
-#define __xn_reg_rval(regs)   ((regs)->ax)
-#define __xn_reg_arg1(regs)   ((regs)->di)
-#define __xn_reg_arg2(regs)   ((regs)->si)
-#define __xn_reg_arg3(regs)   ((regs)->dx)
-#define __xn_reg_arg4(regs)   ((regs)->r10)
-#define __xn_reg_arg5(regs)   ((regs)->r8)
-#define __xn_reg_pc(regs)     ((regs)->ip)
-#define __xn_reg_sp(regs)     ((regs)->sp)
-
-#define __xn_syscall_p(regs)  (__xn_reg_sys(regs) & __COBALT_SYSCALL_BIT)
-#ifdef CONFIG_XENO_ARCH_SYS3264
-#define __xn_syscall(regs)    __COBALT_CALL32_SYSNR(__xn_reg_sys(regs)	\
-				    & ~__COBALT_SYSCALL_BIT)
-#else
-#define __xn_syscall(regs)    (__xn_reg_sys(regs) & ~__COBALT_SYSCALL_BIT)
-#endif
-
-/*
- * Root syscall number with predicate (valid only if
- * !__xn_syscall_p(__regs)).
- */
-#define __xn_rootcall_p(__regs, __code)			\
-	({						\
-		*(__code) = __xn_reg_sys(__regs);	\
-		*(__code) < ipipe_root_nr_syscalls(current_thread_info()); \
-	})
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, long v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) == -EINTR;
-}
-
-static inline
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			 unsigned long a3, unsigned long a4,
-			 unsigned long a5)
-{
-	return -ENOSYS;
-}
-
-#endif /* !_COBALT_X86_ASM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
deleted file mode 100644
index a1a79bbc03..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/thread.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * Copyright (C) 2001-2013 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) 2004-2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_X86_ASM_THREAD_H
-#define _COBALT_X86_ASM_THREAD_H
-
-#include <asm-generic/xenomai/ipipe/thread.h>
-#include <asm/xenomai/wrappers.h>
-#include <asm/traps.h>
-
-#ifndef IPIPE_X86_FPU_EAGER
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
-typedef union thread_xstate x86_fpustate;
-#define x86_fpustate_ptr(t) ((t)->fpu.state)
-#else
-typedef union fpregs_state x86_fpustate;
-#define x86_fpustate_ptr(t) ((t)->fpu.active_state)
-#endif
-#endif
-
-struct xnarchtcb {
-	struct xntcb core;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-	unsigned long sp;
-	unsigned long *spp;
-	unsigned long ip;
-	unsigned long *ipp;
-#endif  
-#ifdef IPIPE_X86_FPU_EAGER
-	struct fpu *kfpu;
-#else
-	x86_fpustate *fpup;
-	unsigned int root_used_math: 1;
-	x86_fpustate *kfpu_state;
-#endif
-	unsigned int root_kfpu: 1;
-};
-
-#define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
-
-#define xnarch_fault_regs(d)	((d)->regs)
-#define xnarch_fault_trap(d)	((d)->exception)
-#define xnarch_fault_code(d)	((d)->regs->orig_ax)
-#define xnarch_fault_pc(d)	((d)->regs->ip)
-#define xnarch_fault_fpu_p(d)	((d)->exception == X86_TRAP_NM)
-#define xnarch_fault_pf_p(d)	((d)->exception == X86_TRAP_PF)
-#define xnarch_fault_bp_p(d)	((current->ptrace & PT_PTRACED) &&	\
-				 ((d)->exception == X86_TRAP_DB || (d)->exception == X86_TRAP_BP))
-#define xnarch_fault_notify(d)	(!xnarch_fault_bp_p(d))
-
-static inline
-struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
-{
-	return tcb->core.host_task;
-}
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to);
-
-int xnarch_handle_fpu_fault(struct xnthread *from, 
-			struct xnthread *to, struct ipipe_trap_data *d);
-
-void xnarch_leave_root(struct xnthread *root);
-
-void xnarch_init_root_tcb(struct xnthread *thread);
-
-void xnarch_init_shadow_tcb(struct xnthread *thread);
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
-
-static inline void xnarch_enter_root(struct xnthread *root) { }
-
-static inline int xnarch_escalate(void)
-{
-	if (ipipe_root_p) {
-		ipipe_raise_irq(cobalt_pipeline.escalate_virq);
-		return 1;
-	}
-
-	return 0;
-}
-
-int mach_x86_thread_init(void);
-void mach_x86_thread_cleanup(void);
-
-#endif /* !_COBALT_X86_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/machine.c b/kernel/cobalt/arch/x86/ipipe/machine.c
deleted file mode 100644
index d51a91f975..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/machine.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/**
- *   Copyright (C) 2007-2012 Philippe Gerum.
- *
- *   Xenomai is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License as
- *   published by the Free Software Foundation, Inc., 675 Mass Ave,
- *   Cambridge MA 02139, USA; either version 2 of the License, or (at
- *   your option) any later version.
- *
- *   Xenomai is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *   General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- *   02111-1307, USA.
- */
-#include <asm/xenomai/machine.h>
-#include <asm/xenomai/thread.h>
-#include <asm/xenomai/syscall.h>
-#include <asm/xenomai/smi.h>
-#include <asm/xenomai/c1e.h>
-
-static int mach_x86_init(void)
-{
-	int ret;
-
-	ret = mach_x86_thread_init();
-	if (ret)
-		return ret;
-
-	mach_x86_c1e_disable();
-	mach_x86_smi_init();
-	mach_x86_smi_disable();
-
-	return 0;
-}
-
-static void mach_x86_cleanup(void)
-{
-	mach_x86_smi_restore();
-	mach_x86_thread_cleanup();
-}
-
-static const char *const fault_labels[] = {
-    [0] = "Divide error",
-    [1] = "Debug",
-    [2] = "",   /* NMI is not pipelined. */
-    [3] = "Int3",
-    [4] = "Overflow",
-    [5] = "Bounds",
-    [6] = "Invalid opcode",
-    [7] = "FPU not available",
-    [8] = "Double fault",
-    [9] = "FPU segment overrun",
-    [10] = "Invalid TSS",
-    [11] = "Segment not present",
-    [12] = "Stack segment",
-    [13] = "General protection",
-    [14] = "Page fault",
-    [15] = "Spurious interrupt",
-    [16] = "FPU error",
-    [17] = "Alignment check",
-    [18] = "Machine check",
-    [19] = "SIMD error",
-    [20] = NULL,
-};
-
-struct cobalt_machine cobalt_machine = {
-	.name = "x86",
-	.init = mach_x86_init,
-	.late_init = NULL,
-	.cleanup = mach_x86_cleanup,
-	.prefault = NULL,
-	.fault_labels = fault_labels,
-};
diff --git a/kernel/cobalt/arch/x86/ipipe/smi.c b/kernel/cobalt/arch/x86/ipipe/smi.c
deleted file mode 100644
index f28af9a3b5..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/smi.c
+++ /dev/null
@@ -1,168 +0,0 @@
-/**
- *   SMI workaround for x86.
- *
- *   Cut/Pasted from Vitor Angelo "smi" module.
- *   Adapted by Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
- *   USA; either version 2 of the License, or (at your option) any later
- *   version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/version.h>
-#include <linux/ctype.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-#include <linux/reboot.h>
-#include <cobalt/kernel/assert.h>
-#include <asm-generic/xenomai/pci_ids.h>
-#include <asm/xenomai/machine.h>
-
-#define DEVFN		0xf8	/* device 31, function 0 */
-
-#define PMBASE_B0	0x40
-#define PMBASE_B1	0x41
-
-#define SMI_CTRL_ADDR	0x30
-
-static int smi_state;
-static char smi_state_arg[16] = "detect";
-module_param_string(smi, smi_state_arg, sizeof(smi_state_arg), 0444);
-
-static unsigned int smi_masked_bits = 1; /* Global disable bit */
-module_param_named(smi_mask, smi_masked_bits, int, 0400);
-
-static unsigned int smi_saved_bits;
-static unsigned short smi_en_addr;
-
-#define mask_bits(v, p) outl(inl(p)&~(v),(p))
-#define set_bits(v, p)  outl(inl(p)|(v), (p))
-
-static int smi_reboot(struct notifier_block *nb, ulong event, void *buf);
-
-static struct notifier_block smi_notifier = {
-	.notifier_call = smi_reboot
-};
-
-static int smi_reboot(struct notifier_block *nb, ulong event, void *buf)
-{
-	if (((event == SYS_RESTART) || (event == SYS_HALT) ||
-	     (event == SYS_POWER_OFF)) && smi_en_addr)
-		set_bits(smi_saved_bits, smi_en_addr);
-
-	return NOTIFY_DONE;
-}
-
-void mach_x86_smi_disable(void)
-{
-	if (smi_en_addr == 0)
-		return;
-
-	smi_saved_bits = inl(smi_en_addr) & smi_masked_bits;
-	mask_bits(smi_masked_bits, smi_en_addr);
-
-	if (inl(smi_en_addr) & smi_masked_bits)
-		printk(XENO_WARNING "SMI workaround failed!\n");
-	else
-		printk(XENO_INFO "SMI workaround enabled\n");
-
-	register_reboot_notifier(&smi_notifier);
-}
-
-void mach_x86_smi_restore(void)
-{
-	if (smi_en_addr == 0)
-		return;
-
-	printk(XENO_INFO "SMI configuration restored\n");
-
-	set_bits(smi_saved_bits, smi_en_addr);
-
-	unregister_reboot_notifier(&smi_notifier);
-}
-
-static unsigned short get_smi_en_addr(struct pci_dev *dev)
-{
-	u_int8_t byte0, byte1;
-
-	pci_read_config_byte(dev, PMBASE_B0, &byte0);
-	pci_read_config_byte(dev, PMBASE_B1, &byte1);
-	return SMI_CTRL_ADDR + (((byte1 << 1) | (byte0 >> 7)) << 7);	// bits 7-15
-}
-
-
-static const char *smi_state_labels[] = {
-	"disabled",
-	"detect",
-	"enabled",
-};
-
-static void setup_smi_state(void)
-{
-	static char warn_bad_state[] =
-		XENO_WARNING "invalid SMI state '%s'\n";
-	char *p;
-	int n;
-
-	/* Backward compat with legacy state specifiers. */
-	n = simple_strtol(smi_state_arg, &p, 10);
-	if (*p == '\0') {
-		smi_state = n;
-		return;
-	}
-
-	for (n = 0; n < ARRAY_SIZE(smi_state_labels); n++)
-		if (strcmp(smi_state_labels[n], smi_state_arg) == 0) {
-			smi_state = n - 1;
-			return;
-		}
-
-	printk(warn_bad_state, smi_state_arg);
-}
-
-void mach_x86_smi_init(void)
-{
-	struct pci_dev *dev = NULL;
-
-	setup_smi_state();
-
-	if (smi_state < 0)
-		return;
-
-	/*
-	 * Do not use pci_register_driver, pci_enable_device, ...
-	 * Just register the used ports.
-	 */
-	dev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (dev == NULL || dev->bus->number ||
-	    dev->devfn != DEVFN || dev->vendor != PCI_VENDOR_ID_INTEL) {
-		pci_dev_put(dev);
-		return;
-	}
-
-	if (smi_state == 0) {
-		printk(XENO_WARNING "SMI-enabled chipset found, but SMI workaround disabled\n"
-		       "          (see xenomai.smi parameter). You might encounter\n"
-		       "          high latencies!\n");
-		pci_dev_put(dev);
-		return;
-	}
-
-	printk(XENO_INFO "SMI-enabled chipset found\n");
-	smi_en_addr = get_smi_en_addr(dev);
-
-	pci_dev_put(dev);
-}
diff --git a/kernel/cobalt/arch/x86/ipipe/thread.c b/kernel/cobalt/arch/x86/ipipe/thread.c
deleted file mode 100644
index dd97a5d32c..0000000000
--- a/kernel/cobalt/arch/x86/ipipe/thread.c
+++ /dev/null
@@ -1,526 +0,0 @@
-/*
- * Copyright (C) 2001-2013 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) 2004-2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/sched.h>
-#include <linux/ipipe.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-#include <cobalt/kernel/thread.h>
-#include <asm/mmu_context.h>
-#include <asm/processor.h>
-
-static struct kmem_cache *xstate_cache;
-
-#ifdef IPIPE_X86_FPU_EAGER
-#define fpu_kernel_xstate_size sizeof(struct fpu)
-#else
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
-#define fpu_kernel_xstate_size xstate_size
-#endif
-#endif /* IPIPE_X86_FPU_EAGER */
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
-#define cpu_has_xmm boot_cpu_has(X86_FEATURE_XMM)
-#define cpu_has_fxsr boot_cpu_has(X86_FEATURE_FXSR)
-#define cpu_has_xsave boot_cpu_has(X86_FEATURE_XSAVE)
-#endif
-
-#ifndef IPIPE_X86_FPU_EAGER
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
-#include <asm/i387.h>
-#include <asm/fpu-internal.h>
-#define x86_fpregs_active(t)		__thread_has_fpu(t)
-#define x86_fpregs_deactivate(t)	__thread_clear_has_fpu(t)
-#define x86_fpregs_activate(t)		__thread_set_has_fpu(t)
-#define x86_xstate_alignment		__alignof__(union thread_xstate)
-#else
-#include <asm/fpu/internal.h>
-
-static inline int x86_fpregs_active(struct task_struct *t)
-{
-	return t->thread.fpu.fpregs_active;
-}
-
-static inline void x86_fpregs_deactivate(struct task_struct *t)
-{
-	if (x86_fpregs_active(t))
-		__fpregs_deactivate(&t->thread.fpu);
-}
-
-static inline void x86_fpregs_activate(struct task_struct *t)
-{
-	if (!x86_fpregs_active(t))
-		__fpregs_activate(&t->thread.fpu);
-}
-
-#define x86_xstate_alignment		__alignof__(union fpregs_state)
-
-#endif
-#else /* IPIPE_X86_FPU_EAGER */
-#define x86_xstate_alignment		__alignof__(union fpregs_state)
-#endif /* ! IPIPE_X86_FPU_EAGER */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-/*
- * This is obsolete context switch code uselessly duplicating
- * mainline's.
- */
-#define __SWITCH_CLOBBER_LIST  , "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
-
-#ifdef CONFIG_CC_STACKPROTECTOR
-
-#define __CANARY_OUTPUT							\
-	, [gs_canary] "=m" (irq_stack_union.stack_canary)
-
-#define __CANARY_INPUT							\
-	, [task_canary] "i" (offsetof(struct task_struct, stack_canary)) \
-	, [current_task] "m" (current_task)
-
-#define __CANARY_SWITCH							\
-  	"movq "__percpu_arg([current_task])",%%rsi\n\t"			\
-	"movq %P[task_canary](%%rsi),%%r8\n\t"				\
-	"movq %%r8,"__percpu_arg([gs_canary])"\n\t"
-
-#else /* !CONFIG_CC_STACKPROTECTOR */
-
-#define __CANARY_OUTPUT
-#define __CANARY_INPUT
-#define __CANARY_SWITCH
-
-#endif /* !CONFIG_CC_STACKPROTECTOR */
-
-#define do_switch_threads(prev, next, p_rsp, n_rsp, p_rip, n_rip)	\
-	({								\
-		long __rdi, __rsi, __rax, __rbx, __rcx, __rdx;		\
-									\
-		__asm__ __volatile__("pushfq\n\t"			\
-			     "pushq	%%rbp\n\t"			\
-			     "movq	%%rsi, %%rbp\n\t"		\
-			     "movq	%%rsp, (%%rdx)\n\t"		\
-			     "movq	$1f, (%%rax)\n\t"		\
-			     "movq	(%%rcx), %%rsp\n\t"		\
-			     "pushq	(%%rbx)\n\t"			\
-			     "jmp	__switch_to\n\t"		\
-			     "1:\n\t"					\
-			     __CANARY_SWITCH				\
-			     "movq	%%rbp, %%rsi\n\t"		\
-			     "popq	%%rbp\n\t"			\
-			     "popfq\n\t"				\
-			     : "=S" (__rsi), "=D" (__rdi), "=a"	(__rax), \
-			       "=b" (__rbx), "=c" (__rcx), "=d" (__rdx)	\
-			       __CANARY_OUTPUT				\
-			     : "0" (next), "1" (prev), "5" (p_rsp), "4" (n_rsp), \
-			       "2" (p_rip), "3" (n_rip)			\
-			       __CANARY_INPUT				\
-			     : "memory", "cc" __SWITCH_CLOBBER_LIST);	\
-	})
-
-#else /* LINUX_VERSION_CODE >= 4.8 */
-
-#include <asm/switch_to.h>
-
-#endif /* LINUX_VERSION_CODE >= 4.8 */
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
-{
-	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
-	struct task_struct *prev, *next, *last;
-	struct mm_struct *prev_mm, *next_mm;
-
-	prev = out_tcb->core.host_task;
-#ifndef IPIPE_X86_FPU_EAGER
-	if (x86_fpregs_active(prev))
-		/*
-		 * __switch_to will try and use __unlazy_fpu, so we
-		 * need to clear the ts bit.
-		 */
-		clts();
-#endif /* ! IPIPE_X86_FPU_EAGER */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-	if (!xnthread_test_state(out, XNROOT | XNUSER) &&
-	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		/*
-		 * This compensates that switch_fpu_prepare ignores kernel
-		 * threads.
-		 */
-		struct fpu *prev_fpu = &prev->thread.fpu;
-
-		if (!copy_fpregs_to_fpstate(prev_fpu))
-			prev_fpu->last_cpu = -1;
-		else
-			prev_fpu->last_cpu = raw_smp_processor_id();
-	}
-#endif
-
-	next = in_tcb->core.host_task;
-#ifndef IPIPE_X86_FPU_EAGER
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
-	next->thread.fpu.counter = 0;
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
-	next->thread.fpu_counter = 0;
-#else
-	next->fpu_counter = 0;
-#endif
-#endif /* ! IPIPE_X86_FPU_EAGER */
-	prev_mm = out_tcb->core.active_mm;
-	next_mm = in_tcb->core.mm;
-	if (next_mm == NULL) {
-		in_tcb->core.active_mm = prev_mm;
-		enter_lazy_tlb(prev_mm, next);
-	} else {
-		ipipe_switch_mm_head(prev_mm, next_mm, next);
-		/*
-		 * We might be switching back to the root thread,
-		 * which we preempted earlier, shortly after "current"
-		 * dropped its mm context in the do_exit() path
-		 * (next->mm == NULL). In that particular case, the
-		 * kernel expects a lazy TLB state for leaving the mm.
-		 */
-		if (next->mm == NULL)
-			enter_lazy_tlb(prev_mm, next);
-	}
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-	do_switch_threads(prev, next,
-			  out_tcb->spp, in_tcb->spp,
-			  out_tcb->ipp, in_tcb->ipp);
-	(void)last;
-#else /* LINUX_VERSION_CODE >= 4.8 */
-	switch_to(prev, next, last);
-#endif /* LINUX_VERSION_CODE >= 4.8 */
-
-#ifndef IPIPE_X86_FPU_EAGER
-	stts();
-#endif /* ! IPIPE_X86_FPU_EAGER */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-	/* 
-	 * Refresh 'in', we switch the stacks. However, there might be no
-	 * current thread at this point.
-	 */
-	in = xnthread_current();
-	if (in && !xnthread_test_state(in, XNROOT) &&
-	    test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		/*
-		 * This is open-coded switch_fpu_return but without a test for
-		 * PF_KTHREAD, i.e including kernel threads.
-		 */
-		struct fpu *fpu = &current->thread.fpu;
-		int cpu = raw_smp_processor_id();
-
-		if (!fpregs_state_valid(fpu, cpu)) {
-			copy_kernel_to_fpregs(&fpu->state);
-			fpregs_activate(fpu);
-			fpu->last_cpu = cpu;
-		}
-		clear_thread_flag(TIF_NEED_FPU_LOAD);
-	}
-#endif
-}
-
-#ifndef IPIPE_X86_FPU_EAGER
-
-#define XSAVE_PREFIX	"0x48,"
-#define XSAVE_SUFFIX	"q"
-
-static inline void __do_save_fpu_state(x86_fpustate *fpup)
-{
-#ifdef cpu_has_xsave
-	if (cpu_has_xsave) {
-#ifdef CONFIG_AS_AVX
-		__asm__ __volatile__("xsave" XSAVE_SUFFIX " %0"
-			     : "=m" (fpup->xsave) : "a" (-1), "d" (-1)
-			     : "memory");
-#else /* !CONFIG_AS_AVX */
-		__asm __volatile__(".byte " XSAVE_PREFIX "0x0f,0xae,0x27"
-			     : : "D" (&fpup->xsave), "m" (fpup->xsave),
-			         "a" (-1), "d" (-1)
-			     : "memory");
-#endif /* !CONFIG_AS_AVX */
-		return;
-	}
-#endif /* cpu_has_xsave */
-#ifdef CONFIG_AS_FXSAVEQ
-	__asm __volatile__("fxsaveq %0" : "=m" (fpup->fxsave));
-#else /* !CONFIG_AS_FXSAVEQ */
-	__asm__ __volatile__("rex64/fxsave (%[fx])"
-		     : "=m" (fpup->fxsave)
-		     : [fx] "R" (&fpup->fxsave));
-#endif /* !CONFIG_AS_FXSAVEQ */
-}
-
-static inline void __do_restore_fpu_state(x86_fpustate *fpup)
-{
-#ifdef cpu_has_xsave
-	if (cpu_has_xsave) {
-#ifdef CONFIG_AS_AVX
-		__asm__ __volatile__("xrstor" XSAVE_SUFFIX " %0"
-			     : : "m" (fpup->xsave), "a" (-1), "d" (-1)
-			     : "memory");
-#else /* !CONFIG_AS_AVX */
-		__asm__ __volatile__(".byte " XSAVE_PREFIX "0x0f,0xae,0x2f"
-			     : : "D" (&fpup->xsave), "m" (fpup->xsave),
-			         "a" (-1), "d" (-1)
-			     : "memory");
-#endif /* !CONFIG_AS_AVX */
-		return;
-	}
-#endif /* cpu_has_xsave */
-#ifdef CONFIG_AS_FXSAVEQ
-	__asm__ __volatile__("fxrstorq %0" : : "m" (fpup->fxsave));
-#else /* !CONFIG_AS_FXSAVEQ */
-	__asm__ __volatile__("rex64/fxrstor (%0)"
-		     : : "R" (&fpup->fxsave), "m" (fpup->fxsave));
-#endif /* !CONFIG_AS_FXSAVEQ */
-}
-
-int xnarch_handle_fpu_fault(struct xnthread *from, 
-			struct xnthread *to, struct ipipe_trap_data *d)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(to);
-	struct task_struct *p = tcb->core.host_task;
-
-	if (x86_fpregs_active(p))
-		return 0;
-
-	if (!(p->flags & PF_USED_MATH)) {
-		/*
-		 * The faulting task is a shadow using the FPU for the first
-		 * time, initialize the FPU context and tell linux about it.
-		 */
-		__asm__ __volatile__("clts; fninit");
-
-		if (cpu_has_xmm) {
-			unsigned long __mxcsr = 0x1f80UL & 0xffbfUL;
-			__asm__ __volatile__("ldmxcsr %0"::"m"(__mxcsr));
-		}
-		p->flags |= PF_USED_MATH;
-	} else {
-		/*
-		 * The faulting task already used FPU in secondary
-		 * mode.
-		 */
-		clts();
-		__do_restore_fpu_state(tcb->fpup);
-	}
-		
-	x86_fpregs_activate(p);
-
-	xnlock_get(&nklock);
-	xnthread_set_state(to, XNFPU);
-	xnlock_put(&nklock);
-
-	return 1;
-}
-#else /* IPIPE_X86_FPU_EAGER */
-
-int xnarch_handle_fpu_fault(struct xnthread *from,
-			struct xnthread *to, struct ipipe_trap_data *d)
-{
-	/* in eager mode there are no such faults */
-	BUG_ON(1);
-}
-#endif /* ! IPIPE_X86_FPU_EAGER */
-
-#define current_task_used_kfpu() kernel_fpu_disabled()
-
-#define tcb_used_kfpu(t) ((t)->root_kfpu)
-
-#ifndef IPIPE_X86_FPU_EAGER
-void xnarch_leave_root(struct xnthread *root)
-{
-	struct xnarchtcb *const rootcb = xnthread_archtcb(root);
-	struct task_struct *const p = current;
-	x86_fpustate *const current_task_fpup = x86_fpustate_ptr(&p->thread);
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-	rootcb->spp = &p->thread.sp;
-	rootcb->ipp = &p->thread.rip;
-#endif
-	if (!current_task_used_kfpu()) {
-		rootcb->root_kfpu = 0;
-		rootcb->fpup = x86_fpregs_active(p) ? current_task_fpup : NULL;
-		return;
-	}
-
-	/*
-	 * We need to save the kernel FPU context before preempting,
-	 * store it in our root control block.
-	 */
-	rootcb->root_kfpu = 1;
-	rootcb->fpup = current_task_fpup;
-	rootcb->root_used_math = !!(p->flags & PF_USED_MATH);
-	x86_fpustate_ptr(&p->thread) = rootcb->kfpu_state;
-	x86_fpregs_activate(p);
-	p->flags |= PF_USED_MATH;
-	kernel_fpu_enable();
-}
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
-{
-	x86_fpustate *const prev_fpup = from ? from->tcb.fpup : NULL;
-	struct xnarchtcb *const tcb = xnthread_archtcb(to);
-	struct task_struct *const p = tcb->core.host_task;
-	x86_fpustate *const next_task_fpup = x86_fpustate_ptr(&p->thread);
-
-	/* Restore lazy mode only if root fpu owner is not current. */
-	if (xnthread_test_state(to, XNROOT) &&
-	    prev_fpup != next_task_fpup &&
-	    !tcb_used_kfpu(tcb))
-		return;
-
-	clts();
-	/*
-	 * The only case where we can skip restoring the FPU is:
-	 * - the fpu context of the next task is the current fpu
-	 * context;
-	 * - root thread has not used fpu in kernel-space;
-	 * - cpu has fxsr (because if it does not, last context switch
-	 * reinitialized fpu)
-	 */
-	if (prev_fpup != next_task_fpup || !cpu_has_fxsr)
-		__do_restore_fpu_state(next_task_fpup);
-
-	if (!tcb_used_kfpu(tcb)) {
-		x86_fpregs_activate(p);
-		return;
-	}
-	kernel_fpu_disable();
-
-	x86_fpustate_ptr(&p->thread) = to->tcb.fpup;
-	if (!tcb->root_used_math) {
-		x86_fpregs_deactivate(p);
-		p->flags &= ~PF_USED_MATH;
-	}
-}
-#else /* IPIPE_X86_FPU_EAGER */
-void xnarch_leave_root(struct xnthread *root)
-{
-	struct xnarchtcb *const rootcb = xnthread_archtcb(root);
-
-	rootcb->root_kfpu = current_task_used_kfpu();
-
-	if (!tcb_used_kfpu(rootcb))
-		return;
-
-	/* save fpregs from in-kernel use */
-	copy_fpregs_to_fpstate(rootcb->kfpu);
-	kernel_fpu_enable();
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
-	/* restore current's fpregs */
-	__cpu_invalidate_fpregs_state();
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-	switch_fpu_finish(&current->thread.fpu);
-#else
-	switch_fpu_finish(&current->thread.fpu, raw_smp_processor_id());
-#endif
-#else
-	/* mark current thread as not owning the FPU anymore */
-	if (fpregs_active())
-		fpregs_deactivate(&current->thread.fpu);
-#endif
-}
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
-{
-	struct xnarchtcb *const to_tcb = xnthread_archtcb(to);
-
-	if (!tcb_used_kfpu(to_tcb))
-		return;
-
-	copy_kernel_to_fpregs(&to_tcb->kfpu->state);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-	/* redo the invalidation done by kernel_fpu_begin */
-	__cpu_invalidate_fpregs_state();
-#endif
-	kernel_fpu_disable();
-}
-#endif /* ! IPIPE_X86_FPU_EAGER */
-
-void xnarch_init_root_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-	tcb->sp = 0;
-	tcb->spp = &tcb->sp;
-	tcb->ipp = &tcb->ip;
-#endif	
-#ifndef IPIPE_X86_FPU_EAGER
-	tcb->fpup = NULL;
-	tcb->kfpu_state = kmem_cache_zalloc(xstate_cache, GFP_KERNEL);
-#else /* IPIPE_X86_FPU_EAGER */
-	tcb->kfpu = kmem_cache_zalloc(xstate_cache, GFP_KERNEL);
-#endif /* ! IPIPE_X86_FPU_EAGER */
-	tcb->root_kfpu = 0;
-}
-
-void xnarch_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct task_struct *p = tcb->core.host_task;
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,8,0)
-	tcb->sp = 0;
-	tcb->spp = &p->thread.sp;
-	tcb->ipp = &p->thread.rip; /* <!> raw naming intended. */
-#endif
-#ifndef IPIPE_X86_FPU_EAGER
-	tcb->fpup = x86_fpustate_ptr(&p->thread);
-	tcb->kfpu_state = NULL;
-#else /* IPIPE_X86_FPU_EAGER */
-	tcb->kfpu = NULL;
-#endif /* ! IPIPE_X86_FPU_EAGER */
-	tcb->root_kfpu = 0;
-
-#ifndef IPIPE_X86_FPU_EAGER
-	/* XNFPU is set upon first FPU fault */
-	xnthread_clear_state(thread, XNFPU);
-#else /* IPIPE_X86_FPU_EAGER */
-	/* XNFPU is always set */
-	xnthread_set_state(thread, XNFPU);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
-	fpu__activate_fpstate_read(&p->thread.fpu);
-#else
-	fpu__initialize(&p->thread.fpu);
-#endif
-#endif /* ! IPIPE_X86_FPU_EAGER */
-}
-
-int mach_x86_thread_init(void)
-{
-	xstate_cache = kmem_cache_create("cobalt_x86_xstate",
-					 fpu_kernel_xstate_size,
-					 x86_xstate_alignment,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,14,0)
-					 SLAB_NOTRACK,
-#else
-					 0,
-#endif
-					 NULL);
-	if (xstate_cache == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void mach_x86_thread_cleanup(void)
-{
-	kmem_cache_destroy(xstate_cache);
-}
diff --git a/kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h b/kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h
deleted file mode 100644
index fcd7275d9e..0000000000
--- a/kernel/cobalt/include/asm-generic/xenomai/ipipe/thread.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (C) 2013 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_ASM_GENERIC_IPIPE_THREAD_H
-#define _COBALT_ASM_GENERIC_IPIPE_THREAD_H
-
-#include <asm/ptrace.h>
-#include <asm/processor.h>
-
-struct task_struct;
-
-struct xntcb {
-	struct task_struct *host_task;
-	struct thread_struct *tsp;
-	struct mm_struct *mm;
-	struct mm_struct *active_mm;
-	struct thread_struct ts;
-	struct thread_info *tip;
-#ifdef CONFIG_XENO_ARCH_FPU
-	struct task_struct *user_fpu_owner;
-#endif
-};
-
-#endif /* !_COBALT_ASM_GENERIC_IPIPE_THREAD_H */
diff --git a/kernel/cobalt/include/ipipe/thread_info.h b/kernel/cobalt/include/ipipe/thread_info.h
deleted file mode 100644
index 3fc467a313..0000000000
--- a/kernel/cobalt/include/ipipe/thread_info.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/**
- * Copyright (C) 2012 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
- * USA; either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-#ifndef _COBALT_IPIPE_THREAD_INFO_H
-#define _COBALT_IPIPE_THREAD_INFO_H
-
-struct xnthread;
-struct cobalt_process;
-
-struct ipipe_threadinfo {
-	/* Core thread backlink. */
-	struct xnthread *thread;
-	/* User process backlink. NULL for core threads. */
-	struct cobalt_process *process;
-};
-
-static inline void __ipipe_init_threadinfo(struct ipipe_threadinfo *p)
-{
-	p->thread = NULL;
-	p->process = NULL;
-}
-
-#endif /* !_COBALT_IPIPE_THREAD_INFO_H */
diff --git a/kernel/cobalt/ipipe/Makefile b/kernel/cobalt/ipipe/Makefile
deleted file mode 100644
index f2b877d450..0000000000
--- a/kernel/cobalt/ipipe/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-ccflags-y += -I$(srctree)/kernel
-
-obj-y +=	pipeline.o
-
-pipeline-y :=	init.o intr.o kevents.o tick.o syscall.o sched.o clock.o
diff --git a/kernel/cobalt/ipipe/clock.c b/kernel/cobalt/ipipe/clock.c
deleted file mode 100644
index 1c04eed944..0000000000
--- a/kernel/cobalt/ipipe/clock.c
+++ /dev/null
@@ -1,158 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Written by Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- */
-
-#include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/vdso.h>
-#include <cobalt/kernel/arith.h>
-#include <cobalt/kernel/timer.h>
-#include <xenomai/posix/clock.h>
-#include <pipeline/machine.h>
-
-static unsigned long long clockfreq;
-
-#ifdef XNARCH_HAVE_LLMULSHFT
-
-static unsigned int tsc_scale, tsc_shift;
-
-#ifdef XNARCH_HAVE_NODIV_LLIMD
-
-static struct xnarch_u32frac tsc_frac;
-
-long long xnclock_core_ns_to_ticks(long long ns)
-{
-	return xnarch_nodiv_llimd(ns, tsc_frac.frac, tsc_frac.integ);
-}
-
-#else /* !XNARCH_HAVE_NODIV_LLIMD */
-
-long long xnclock_core_ns_to_ticks(long long ns)
-{
-	return xnarch_llimd(ns, 1 << tsc_shift, tsc_scale);
-}
-
-#endif /* !XNARCH_HAVE_NODIV_LLIMD */
-
-xnsticks_t xnclock_core_ticks_to_ns(xnsticks_t ticks)
-{
-	return xnarch_llmulshft(ticks, tsc_scale, tsc_shift);
-}
-
-xnsticks_t xnclock_core_ticks_to_ns_rounded(xnsticks_t ticks)
-{
-	unsigned int shift = tsc_shift - 1;
-	return (xnarch_llmulshft(ticks, tsc_scale, shift) + 1) / 2;
-}
-
-#else  /* !XNARCH_HAVE_LLMULSHFT */
-
-xnsticks_t xnclock_core_ticks_to_ns(xnsticks_t ticks)
-{
-	return xnarch_llimd(ticks, 1000000000, clockfreq);
-}
-
-xnsticks_t xnclock_core_ticks_to_ns_rounded(xnsticks_t ticks)
-{
-	return (xnarch_llimd(ticks, 1000000000, clockfreq/2) + 1) / 2;
-}
-
-xnsticks_t xnclock_core_ns_to_ticks(xnsticks_t ns)
-{
-	return xnarch_llimd(ns, clockfreq, 1000000000);
-}
-
-#endif /* !XNARCH_HAVE_LLMULSHFT */
-
-EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns);
-EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns_rounded);
-EXPORT_SYMBOL_GPL(xnclock_core_ns_to_ticks);
-
-int pipeline_get_host_time(struct timespec64 *tp)
-{
-#ifdef CONFIG_IPIPE_HAVE_HOSTRT
-	struct xnvdso_hostrt_data *hostrt_data;
-	u64 now, base, mask, cycle_delta;
-	__u32 mult, shift;
-	unsigned long rem;
-	urwstate_t tmp;
-	__u64 nsec;
-
-	hostrt_data = get_hostrt_data();
-	BUG_ON(!hostrt_data);
-
-	if (unlikely(!hostrt_data->live))
-		return -1;
-
-	/*
-	 * Note: Disabling HW interrupts around writes to hostrt_data
-	 * ensures that a reader (on the Xenomai side) cannot
-	 * interrupt a writer (on the Linux kernel side) on the same
-	 * CPU.  The urw block is required when a reader is
-	 * interleaved by a writer on a different CPU. This follows
-	 * the approach from userland, where taking the spinlock is
-	 * not possible.
-	 */
-	unsynced_read_block(&tmp, &hostrt_data->lock) {
-		now = xnclock_read_raw(&nkclock);
-		base = hostrt_data->cycle_last;
-		mask = hostrt_data->mask;
-		mult = hostrt_data->mult;
-		shift = hostrt_data->shift;
-		tp->tv_sec = hostrt_data->wall_sec;
-		nsec = hostrt_data->wall_nsec;
-	}
-
-	/*
-	 * At this point, we have a consistent copy of the fundamental
-	 * data structure - calculate the interval between the current
-	 * and base time stamp cycles, and convert the difference
-	 * to nanoseconds.
-	 */
-	cycle_delta = (now - base) & mask;
-	nsec += (cycle_delta * mult) >> shift;
-
-	/* Convert to the desired sec, usec representation */
-	tp->tv_sec += xnclock_divrem_billion(nsec, &rem);
-	tp->tv_nsec = rem;
-
-	return 0;
-#else
-	return -EINVAL;
-#endif
-}
-
-xnticks_t pipeline_read_wallclock(void)
-{
-	return xnclock_read_monotonic(&nkclock) + xnclock_get_offset(&nkclock);
-}
-EXPORT_SYMBOL_GPL(pipeline_read_wallclock);
-
-int pipeline_set_wallclock(xnticks_t epoch_ns)
-{
-	xnclock_set_wallclock(epoch_ns);
-
-	return 0;
-}
-
-void pipeline_update_clock_freq(unsigned long long freq)
-{
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-	clockfreq = freq;
-#ifdef XNARCH_HAVE_LLMULSHFT
-	xnarch_init_llmulshft(1000000000, freq, &tsc_scale, &tsc_shift);
-#ifdef XNARCH_HAVE_NODIV_LLIMD
-	xnarch_init_u32frac(&tsc_frac, 1 << tsc_shift, tsc_scale);
-#endif
-#endif
-	cobalt_pipeline.clock_freq = freq;
-	xnlock_put_irqrestore(&nklock, s);
-}
-
-void pipeline_init_clock(void)
-{
-	pipeline_update_clock_freq(cobalt_pipeline.clock_freq);
-}
diff --git a/kernel/cobalt/ipipe/init.c b/kernel/cobalt/ipipe/init.c
deleted file mode 100644
index c199f00def..0000000000
--- a/kernel/cobalt/ipipe/init.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2019 Philippe Gerum  <rpm@xenomai.org>
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <pipeline/machine.h>
-#include <linux/ipipe_tickdev.h>
-#include <cobalt/kernel/sched.h>
-#include <cobalt/kernel/clock.h>
-
-int __init pipeline_init(void)
-{
-	struct ipipe_sysinfo sysinfo;
-	int ret, virq;
-
-	ret = ipipe_select_timers(&xnsched_realtime_cpus);
-	if (ret < 0)
-		return ret;
-
-	ipipe_get_sysinfo(&sysinfo);
-
-	cobalt_pipeline.clock_freq = sysinfo.sys_hrclock_freq;
-
-	if (cobalt_machine.init) {
-		ret = cobalt_machine.init();
-		if (ret)
-			return ret;
-	}
-
-	ipipe_register_head(&xnsched_primary_domain, "Xenomai");
-
-	virq = ipipe_alloc_virq();
-	if (virq == 0)
-		goto fail_escalate;
-
-	cobalt_pipeline.escalate_virq = virq;
-
-	ipipe_request_irq(&xnsched_primary_domain,
-			  cobalt_pipeline.escalate_virq,
-			  (ipipe_irq_handler_t)__xnsched_run_handler,
-			  NULL, NULL);
-
-	ret = xnclock_init();
-	if (ret)
-		goto fail_clock;
-
-	return 0;
-
-fail_clock:
-	ipipe_free_irq(&xnsched_primary_domain,
-		       cobalt_pipeline.escalate_virq);
-	ipipe_free_virq(cobalt_pipeline.escalate_virq);
-fail_escalate:
-	ipipe_unregister_head(&xnsched_primary_domain);
-
-	if (cobalt_machine.cleanup)
-		cobalt_machine.cleanup();
-
-	return ret;
-}
-
-int __init pipeline_late_init(void)
-{
-	if (cobalt_machine.late_init)
-		return cobalt_machine.late_init();
-
-	return 0;
-}
-
-__init void pipeline_cleanup(void)
-{
-	ipipe_unregister_head(&xnsched_primary_domain);
-	ipipe_free_irq(&xnsched_primary_domain,
-		       cobalt_pipeline.escalate_virq);
-	ipipe_free_virq(cobalt_pipeline.escalate_virq);
-	ipipe_timers_release();
-	xnclock_cleanup();
-}
diff --git a/kernel/cobalt/ipipe/intr.c b/kernel/cobalt/ipipe/intr.c
deleted file mode 100644
index 378c7f07d5..0000000000
--- a/kernel/cobalt/ipipe/intr.c
+++ /dev/null
@@ -1,1230 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) 2005,2006 Dmitry Adamushko <dmitry.adamushko@gmail.com>.
- * Copyright (C) 2007 Jan Kiszka <jan.kiszka@web.de>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
-*/
-#include <linux/mutex.h>
-#include <linux/ipipe.h>
-#include <linux/ipipe_tickdev.h>
-#include <cobalt/kernel/sched.h>
-#include <cobalt/kernel/intr.h>
-#include <cobalt/kernel/stat.h>
-#include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/assert.h>
-#include <trace/events/cobalt-core.h>
-
-/**
- * @ingroup cobalt_core
- * @defgroup cobalt_core_irq Interrupt management
- * @{
- */
-#define XNINTR_MAX_UNHANDLED	1000
-
-static DEFINE_MUTEX(intrlock);
-
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-struct xnintr nktimer;	     /* Only for statistics */
-static int xnintr_count = 1; /* Number of attached xnintr objects + nktimer */
-static int xnintr_list_rev;  /* Modification counter of xnintr list */
-
-/* Both functions update xnintr_list_rev at the very end.
- * This guarantees that module.c::stat_seq_open() won't get
- * an up-to-date xnintr_list_rev and old xnintr_count. */
-
-static inline void stat_counter_inc(void)
-{
-	xnintr_count++;
-	smp_mb();
-	xnintr_list_rev++;
-}
-
-static inline void stat_counter_dec(void)
-{
-	xnintr_count--;
-	smp_mb();
-	xnintr_list_rev++;
-}
-
-static inline void sync_stat_references(struct xnintr *intr)
-{
-	struct xnirqstat *statp;
-	struct xnsched *sched;
-	int cpu;
-
-	for_each_realtime_cpu(cpu) {
-		sched = xnsched_struct(cpu);
-		statp = per_cpu_ptr(intr->stats, cpu);
-		/* Synchronize on all dangling references to go away. */
-		while (sched->current_account == &statp->account)
-			cpu_relax();
-	}
-}
-
-static void clear_irqstats(struct xnintr *intr)
-{
-	struct xnirqstat *p;
-	int cpu;
-
-	for_each_realtime_cpu(cpu) {
-		p = per_cpu_ptr(intr->stats, cpu);
-		memset(p, 0, sizeof(*p));
-	}
-}
-
-static inline void alloc_irqstats(struct xnintr *intr)
-{
-	intr->stats = alloc_percpu(struct xnirqstat);
-	clear_irqstats(intr);
-}
-
-static inline void free_irqstats(struct xnintr *intr)
-{
-	free_percpu(intr->stats);
-}
-
-static inline void query_irqstats(struct xnintr *intr, int cpu,
-				  struct xnintr_iterator *iterator)
-{
-	struct xnirqstat *statp;
-	xnticks_t last_switch;
-
-	statp = per_cpu_ptr(intr->stats, cpu);
-	iterator->hits = xnstat_counter_get(&statp->hits);
-	last_switch = xnsched_struct(cpu)->last_account_switch;
-	iterator->exectime_period = statp->account.total;
-	iterator->account_period = last_switch - statp->account.start;
-	statp->sum.total += iterator->exectime_period;
-	iterator->exectime_total = statp->sum.total;
-	statp->account.total = 0;
-	statp->account.start = last_switch;
-}
-
-static void inc_irqstats(struct xnintr *intr, struct xnsched *sched, xnticks_t start)
-{
-	struct xnirqstat *statp;
-
-	statp = raw_cpu_ptr(intr->stats);
-	xnstat_counter_inc(&statp->hits);
-	xnstat_exectime_lazy_switch(sched, &statp->account, start);
-}
-
-static inline void switch_to_irqstats(struct xnintr *intr,
-				      struct xnsched *sched)
-{
-	struct xnirqstat *statp;
-
-	statp = raw_cpu_ptr(intr->stats);
-	xnstat_exectime_switch(sched, &statp->account);
-}
-
-static inline void switch_from_irqstats(struct xnsched *sched,
-					xnstat_exectime_t *prev)
-{
-	xnstat_exectime_switch(sched, prev);
-}
-
-static inline xnstat_exectime_t *switch_core_irqstats(struct xnsched *sched)
-{
-	struct xnirqstat *statp;
-	xnstat_exectime_t *prev;
-
-	statp = raw_cpu_ptr(nktimer.stats);
-	prev = xnstat_exectime_switch(sched, &statp->account);
-	xnstat_counter_inc(&statp->hits);
-
-	return prev;
-}
-
-#else  /* !CONFIG_XENO_OPT_STATS_IRQS */
-
-static inline void stat_counter_inc(void) {}
-
-static inline void stat_counter_dec(void) {}
-
-static inline void sync_stat_references(struct xnintr *intr) {}
-
-static inline void alloc_irqstats(struct xnintr *intr) {}
-
-static inline void free_irqstats(struct xnintr *intr) {}
-
-static inline void clear_irqstats(struct xnintr *intr) {}
-
-static inline void query_irqstats(struct xnintr *intr, int cpu,
-				  struct xnintr_iterator *iterator) {}
-
-static inline void inc_irqstats(struct xnintr *intr, struct xnsched *sched, xnticks_t start) {}
-
-static inline void switch_to_irqstats(struct xnintr *intr,
-				      struct xnsched *sched) {}
-
-static inline void switch_from_irqstats(struct xnsched *sched,
-					xnstat_exectime_t *prev) {}
-
-static inline xnstat_exectime_t *switch_core_irqstats(struct xnsched *sched)
-{
-	return NULL;
-}
-
-#endif /* !CONFIG_XENO_OPT_STATS_IRQS */
-
-static void xnintr_irq_handler(unsigned int irq, void *cookie);
-
-void xnintr_host_tick(struct xnsched *sched) /* Interrupts off. */
-{
-	sched->lflags &= ~XNHTICK;
-#ifdef XNARCH_HOST_TICK_IRQ
-	ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
-#endif
-}
-
-/*
- * Low-level core clock irq handler. This one forwards ticks from the
- * Xenomai platform timer to nkclock exclusively.
- */
-void xnintr_core_clock_handler(void)
-{
-	struct xnsched *sched = xnsched_current();
-	int cpu  __maybe_unused = xnsched_cpu(sched);
-	xnstat_exectime_t *prev;
-
-	if (!xnsched_supported_cpu(cpu)) {
-#ifdef XNARCH_HOST_TICK_IRQ
-		ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
-#endif
-		return;
-	}
-
-	prev = switch_core_irqstats(sched);
-
-	trace_cobalt_clock_entry(per_cpu(ipipe_percpu.hrtimer_irq, cpu));
-
-	++sched->inesting;
-	sched->lflags |= XNINIRQ;
-
-	xnlock_get(&nklock);
-	xnclock_tick(&nkclock);
-	xnlock_put(&nklock);
-
-	trace_cobalt_clock_exit(per_cpu(ipipe_percpu.hrtimer_irq, cpu));
-	switch_from_irqstats(sched, prev);
-
-	if (--sched->inesting == 0) {
-		sched->lflags &= ~XNINIRQ;
-		xnsched_run();
-		sched = xnsched_current();
-	}
-	/*
-	 * If the core clock interrupt preempted a real-time thread,
-	 * any transition to the root thread has already triggered a
-	 * host tick propagation from xnsched_run(), so at this point,
-	 * we only need to propagate the host tick in case the
-	 * interrupt preempted the root thread.
-	 */
-	if ((sched->lflags & XNHTICK) &&
-	    xnthread_test_state(sched->curr, XNROOT))
-		xnintr_host_tick(sched);
-}
-
-struct irqdisable_work {
-	struct ipipe_work_header work; /* Must be first. */
-	int irq;
-};
-
-static void lostage_irqdisable_line(struct ipipe_work_header *work)
-{
-	struct irqdisable_work *rq;
-
-	rq = container_of(work, struct irqdisable_work, work);
-	ipipe_disable_irq(rq->irq);
-}
-
-static void disable_irq_line(int irq)
-{
-	struct irqdisable_work diswork = {
-		.work = {
-			.size = sizeof(diswork),
-			.handler = lostage_irqdisable_line,
-		},
-		.irq = irq,
-	};
-
-	ipipe_post_work_root(&diswork, work);
-}
-
-/* Optional support for shared interrupts. */
-
-#ifdef CONFIG_XENO_OPT_SHIRQ
-
-struct xnintr_vector {
-	DECLARE_XNLOCK(lock);
-	struct xnintr *handlers;
-	int unhandled;
-} ____cacheline_aligned_in_smp;
-
-static struct xnintr_vector vectors[IPIPE_NR_IRQS];
-
-static inline struct xnintr *xnintr_vec_first(unsigned int irq)
-{
-	return vectors[irq].handlers;
-}
-
-static inline struct xnintr *xnintr_vec_next(struct xnintr *prev)
-{
-	return prev->next;
-}
-
-static void disable_shared_irq_line(struct xnintr_vector *vec)
-{
-	int irq = vec - vectors;
-	struct xnintr *intr;
-
-	xnlock_get(&vec->lock);
-	intr = vec->handlers;
-	while (intr) {
-		set_bit(XN_IRQSTAT_DISABLED, &intr->status);
-		intr = intr->next;
-	}
-	xnlock_put(&vec->lock);
-	disable_irq_line(irq);
-}
-
-/*
- * Low-level interrupt handler dispatching the user-defined ISRs for
- * shared interrupts -- Called with interrupts off.
- */
-static void xnintr_vec_handler(unsigned int irq, void *cookie)
-{
-	struct xnsched *sched = xnsched_current();
-	struct xnintr_vector *vec = vectors + irq;
-	xnstat_exectime_t *prev;
-	struct xnintr *intr;
-	xnticks_t start;
-	int s = 0, ret;
-
-	prev  = xnstat_exectime_get_current(sched);
-	start = xnstat_exectime_now();
-	trace_cobalt_irq_entry(irq);
-
-	++sched->inesting;
-	sched->lflags |= XNINIRQ;
-
-	xnlock_get(&vec->lock);
-	intr = vec->handlers;
-	if (unlikely(test_bit(XN_IRQSTAT_DISABLED, &intr->status))) {
-		/* irqdisable_work is on its way, ignore. */
-		xnlock_put(&vec->lock);
-		goto out;
-	}
-
-	while (intr) {
-		/*
-		 * NOTE: We assume that no CPU migration can occur
-		 * while running the interrupt service routine.
-		 */
-		ret = intr->isr(intr);
-		XENO_WARN_ON_ONCE(USER, (ret & XN_IRQ_STATMASK) == 0);
-		s |= ret;
-		if (ret & XN_IRQ_HANDLED) {
-			inc_irqstats(intr, sched, start);
-			start = xnstat_exectime_now();
-		}
-		intr = intr->next;
-	}
-
-	xnlock_put(&vec->lock);
-
-	if (unlikely(!(s & XN_IRQ_HANDLED))) {
-		if (++vec->unhandled == XNINTR_MAX_UNHANDLED) {
-			printk(XENO_ERR "%s: IRQ%d not handled. Disabling IRQ line\n",
-			       __FUNCTION__, irq);
-			s |= XN_IRQ_DISABLE;
-		}
-	} else
-		vec->unhandled = 0;
-
-	if (s & XN_IRQ_PROPAGATE)
-		ipipe_post_irq_root(irq);
-	else if (s & XN_IRQ_DISABLE)
-		disable_shared_irq_line(vec);
-	else
-		ipipe_end_irq(irq);
-out:
-	switch_from_irqstats(sched, prev);
-
-	trace_cobalt_irq_exit(irq);
-
-	if (--sched->inesting == 0) {
-		sched->lflags &= ~XNINIRQ;
-		xnsched_run();
-	}
-}
-
-/*
- * Low-level interrupt handler dispatching the user-defined ISRs for
- * shared edge-triggered interrupts -- Called with interrupts off.
- */
-static void xnintr_edge_vec_handler(unsigned int irq, void *cookie)
-{
-	const int MAX_EDGEIRQ_COUNTER = 128;
-	struct xnsched *sched = xnsched_current();
-	struct xnintr_vector *vec = vectors + irq;
-	struct xnintr *intr, *end = NULL;
-	int s = 0, counter = 0, ret;
-	xnstat_exectime_t *prev;
-	xnticks_t start;
-
-	prev  = xnstat_exectime_get_current(sched);
-	start = xnstat_exectime_now();
-	trace_cobalt_irq_entry(irq);
-
-	++sched->inesting;
-	sched->lflags |= XNINIRQ;
-
-	xnlock_get(&vec->lock);
-	intr = vec->handlers;
-	if (unlikely(test_bit(XN_IRQSTAT_DISABLED, &intr->status))) {
-		/* irqdisable_work is on its way, ignore. */
-		xnlock_put(&vec->lock);
-		goto out;
-	}
-
-	while (intr != end) {
-		switch_to_irqstats(intr, sched);
-		/*
-		 * NOTE: We assume that no CPU migration will occur
-		 * while running the interrupt service routine.
-		 */
-		ret = intr->isr(intr);
-		XENO_WARN_ON_ONCE(USER, (ret & XN_IRQ_STATMASK) == 0);
-		s |= ret;
-
-		if (ret & XN_IRQ_HANDLED) {
-			end = NULL;
-			inc_irqstats(intr, sched, start);
-			start = xnstat_exectime_now();
-		} else if (end == NULL)
-			end = intr;
-
-		if (counter++ > MAX_EDGEIRQ_COUNTER)
-			break;
-
-		intr = intr->next;
-		if (intr  == NULL)
-			intr = vec->handlers;
-	}
-
-	xnlock_put(&vec->lock);
-
-	if (counter > MAX_EDGEIRQ_COUNTER)
-		printk(XENO_ERR "%s: failed to get the IRQ%d line free\n",
-		       __FUNCTION__, irq);
-
-	if (unlikely(!(s & XN_IRQ_HANDLED))) {
-		if (++vec->unhandled == XNINTR_MAX_UNHANDLED) {
-			printk(XENO_ERR "%s: IRQ%d not handled. Disabling IRQ line\n",
-			       __FUNCTION__, irq);
-			s |= XN_IRQ_DISABLE;
-		}
-	} else
-		vec->unhandled = 0;
-
-	if (s & XN_IRQ_PROPAGATE)
-		ipipe_post_irq_root(irq);
-	else if (s & XN_IRQ_DISABLE)
-		disable_shared_irq_line(vec);
-	else
-		ipipe_end_irq(irq);
-out:
-	switch_from_irqstats(sched, prev);
-
-	trace_cobalt_irq_exit(irq);
-
-	if (--sched->inesting == 0) {
-		sched->lflags &= ~XNINIRQ;
-		xnsched_run();
-	}
-}
-
-static inline bool cobalt_owns_irq(int irq)
-{
-	ipipe_irq_handler_t h;
-
-	h = __ipipe_irq_handler(&xnsched_primary_domain, irq);
-
-	return h == xnintr_vec_handler ||
-		h == xnintr_edge_vec_handler ||
-		h == xnintr_irq_handler;
-}
-
-static inline int xnintr_irq_attach(struct xnintr *intr)
-{
-	struct xnintr_vector *vec = vectors + intr->irq;
-	struct xnintr *prev, **p = &vec->handlers;
-	int ret;
-
-	prev = *p;
-	if (prev) {
-		/* Check on whether the shared mode is allowed. */
-		if ((prev->flags & intr->flags & XN_IRQTYPE_SHARED) == 0 ||
-		    (prev->iack != intr->iack)
-		    || ((prev->flags & XN_IRQTYPE_EDGE) !=
-			(intr->flags & XN_IRQTYPE_EDGE)))
-			return -EBUSY;
-
-		/*
-		 * Get a position at the end of the list to insert the
-		 * new element.
-		 */
-		while (prev) {
-			p = &prev->next;
-			prev = *p;
-		}
-	} else {
-		/* Initialize the corresponding interrupt channel */
-		void (*handler) (unsigned, void *) = xnintr_irq_handler;
-
-		if (intr->flags & XN_IRQTYPE_SHARED) {
-			if (intr->flags & XN_IRQTYPE_EDGE)
-				handler = xnintr_edge_vec_handler;
-			else
-				handler = xnintr_vec_handler;
-
-		}
-		vec->unhandled = 0;
-
-		ret = ipipe_request_irq(&xnsched_primary_domain,
-					intr->irq, handler, intr,
-					(ipipe_irq_ackfn_t)intr->iack);
-		if (ret)
-			return ret;
-	}
-
-	intr->next = NULL;
-	/*
-	 * Add the given interrupt object. No need to synchronise with
-	 * the IRQ handler, we are only extending the chain.
-	 */
-	*p = intr;
-
-	return 0;
-}
-
-static inline void xnintr_irq_detach(struct xnintr *intr)
-{
-	struct xnintr_vector *vec = vectors + intr->irq;
-	struct xnintr *e, **p = &vec->handlers;
-
-	while ((e = *p) != NULL) {
-		if (e == intr) {
-			/* Remove the given interrupt object from the list. */
-			xnlock_get(&vec->lock);
-			*p = e->next;
-			xnlock_put(&vec->lock);
-
-			sync_stat_references(intr);
-
-			/* Release the IRQ line if this was the last user */
-			if (vec->handlers == NULL)
-				ipipe_free_irq(&xnsched_primary_domain, intr->irq);
-
-			return;
-		}
-		p = &e->next;
-	}
-
-	printk(XENO_ERR "attempted to detach an unregistered interrupt descriptor\n");
-}
-
-#else /* !CONFIG_XENO_OPT_SHIRQ */
-
-struct xnintr_vector {
-#if defined(CONFIG_SMP) || defined(CONFIG_XENO_OPT_DEBUG_LOCKING)
-	DECLARE_XNLOCK(lock);
-#endif /* CONFIG_SMP || XENO_DEBUG(LOCKING) */
-} ____cacheline_aligned_in_smp;
-
-static struct xnintr_vector vectors[IPIPE_NR_IRQS];
-
-static inline bool cobalt_owns_irq(int irq)
-{
-	ipipe_irq_handler_t h;
-
-	h = __ipipe_irq_handler(&xnsched_primary_domain, irq);
-
-	return h == xnintr_irq_handler;
-}
-
-static inline struct xnintr *xnintr_vec_first(unsigned int irq)
-{
-	return cobalt_owns_irq(irq) ?
-		__ipipe_irq_cookie(&xnsched_primary_domain, irq) : NULL;
-}
-
-static inline struct xnintr *xnintr_vec_next(struct xnintr *prev)
-{
-	return NULL;
-}
-
-static inline int xnintr_irq_attach(struct xnintr *intr)
-{
-	return ipipe_request_irq(&xnsched_primary_domain,
-				 intr->irq, xnintr_irq_handler, intr,
-				 (ipipe_irq_ackfn_t)intr->iack);
-}
-
-static inline void xnintr_irq_detach(struct xnintr *intr)
-{
-	int irq = intr->irq;
-
-	xnlock_get(&vectors[irq].lock);
-	ipipe_free_irq(&xnsched_primary_domain, irq);
-	xnlock_put(&vectors[irq].lock);
-
-	sync_stat_references(intr);
-}
-
-#endif /* !CONFIG_XENO_OPT_SHIRQ */
-
-/*
- * Low-level interrupt handler dispatching non-shared ISRs -- Called
- * with interrupts off.
- */
-static void xnintr_irq_handler(unsigned int irq, void *cookie)
-{
-	struct xnintr_vector __maybe_unused *vec = vectors + irq;
-	struct xnsched *sched = xnsched_current();
-	xnstat_exectime_t *prev;
-	struct xnintr *intr;
-	xnticks_t start;
-	int s = 0;
-
-	prev  = xnstat_exectime_get_current(sched);
-	start = xnstat_exectime_now();
-	trace_cobalt_irq_entry(irq);
-
-	++sched->inesting;
-	sched->lflags |= XNINIRQ;
-
-	xnlock_get(&vec->lock);
-
-#ifdef CONFIG_SMP
-	/*
-	 * In SMP case, we have to reload the cookie under the per-IRQ
-	 * lock to avoid racing with xnintr_detach.  However, we
-	 * assume that no CPU migration will occur while running the
-	 * interrupt service routine, so the scheduler pointer will
-	 * remain valid throughout this function.
-	 */
-	intr = __ipipe_irq_cookie(&xnsched_primary_domain, irq);
-	if (unlikely(intr == NULL))
-		goto done;
-#else
-	intr = cookie;
-#endif
-	if (unlikely(test_bit(XN_IRQSTAT_DISABLED, &intr->status))) {
-		/* irqdisable_work is on its way, ignore. */
-		xnlock_put(&vec->lock);
-		goto out;
-	}
-
-	s = intr->isr(intr);
-	XENO_WARN_ON_ONCE(USER, (s & XN_IRQ_STATMASK) == 0);
-	if (unlikely(!(s & XN_IRQ_HANDLED))) {
-		if (++intr->unhandled == XNINTR_MAX_UNHANDLED) {
-			printk(XENO_ERR "%s: IRQ%d not handled. Disabling IRQ line\n",
-			       __FUNCTION__, irq);
-			s |= XN_IRQ_DISABLE;
-		}
-	} else {
-		inc_irqstats(intr, sched, start);
-		intr->unhandled = 0;
-	}
-
-	if (s & XN_IRQ_DISABLE)
-		set_bit(XN_IRQSTAT_DISABLED, &intr->status);
-#ifdef CONFIG_SMP
-done:
-#endif
-	xnlock_put(&vec->lock);
-
-	if (s & XN_IRQ_DISABLE)
-		disable_irq_line(irq);
-	else if (s & XN_IRQ_PROPAGATE)
-		ipipe_post_irq_root(irq);
-	else
-		ipipe_end_irq(irq);
-out:
-	switch_from_irqstats(sched, prev);
-
-	trace_cobalt_irq_exit(irq);
-
-	if (--sched->inesting == 0) {
-		sched->lflags &= ~XNINIRQ;
-		xnsched_run();
-	}
-}
-
-int __init xnintr_mount(void)
-{
-	int i;
-	for (i = 0; i < IPIPE_NR_IRQS; ++i)
-		xnlock_init(&vectors[i].lock);
-	return 0;
-}
-
-/**
- * @fn int xnintr_init(struct xnintr *intr,const char *name,unsigned int irq,xnisr_t isr,xniack_t iack,int flags)
- * @brief Initialize an interrupt descriptor.
- *
- * When an interrupt occurs on the given @a irq line, the interrupt
- * service routine @a isr is fired in order to deal with the hardware
- * event. The interrupt handler may call any non-blocking service from
- * the Cobalt core.
- *
- * Upon receipt of an IRQ, the interrupt handler @a isr is immediately
- * called on behalf of the interrupted stack context, the rescheduling
- * procedure is locked, and the interrupt line is masked in the system
- * interrupt controller chip.  Upon return, the status of the
- * interrupt handler is checked for the following bits:
- *
- * - XN_IRQ_HANDLED indicates that the interrupt request was
- * successfully handled.
- *
- * - XN_IRQ_NONE indicates the opposite to XN_IRQ_HANDLED, meaning
- * that no interrupt source could be identified for the ongoing
- * request by the handler.
- *
- * In addition, one of the following bits may be present in the
- * status:
- *
- * - XN_IRQ_DISABLE tells the Cobalt core to disable the interrupt
- * line before returning from the interrupt context.
- *
- * - XN_IRQ_PROPAGATE propagates the IRQ event down the interrupt
- * pipeline to Linux. Using this flag is strongly discouraged, unless
- * you fully understand the implications of such propagation.
- *
- * @warning The handler should not use these bits if it shares the
- * interrupt line with other handlers in the real-time domain. When
- * any of these bits is detected, the interrupt line is left masked.
- *
- * A count of interrupt receipts is tracked into the interrupt
- * descriptor, and reset to zero each time such descriptor is
- * attached. Since this count could wrap around, it should be used as
- * an indication of interrupt activity only.
- *
- * @param intr The address of a descriptor the Cobalt core will use to
- * store the interrupt-specific data.
- *
- * @param name An ASCII string standing for the symbolic name of the
- * interrupt or NULL.
- *
- * @param irq The IRQ line number associated with the interrupt
- * descriptor. This value is architecture-dependent. An interrupt
- * descriptor must be attached to the system by a call to
- * xnintr_attach() before @a irq events can be received.
- *
- * @param isr The address of an interrupt handler, which is passed the
- * address of the interrupt descriptor receiving the IRQ.
- *
- * @param iack The address of an optional interrupt acknowledge
- * routine, aimed at replacing the default one. Only very specific
- * situations actually require to override the default setting for
- * this parameter, like having to acknowledge non-standard PIC
- * hardware. @a iack should return a non-zero value to indicate that
- * the interrupt has been properly acknowledged. If @a iack is NULL,
- * the default routine will be used instead.
- *
- * @param flags A set of creation flags affecting the operation. The
- * valid flags are:
- *
- * - XN_IRQTYPE_SHARED enables IRQ-sharing with other interrupt
- * objects.
- *
- * - XN_IRQTYPE_EDGE is an additional flag need to be set together
- * with XN_IRQTYPE_SHARED to enable IRQ-sharing of edge-triggered
- * interrupts.
- *
- * @return 0 is returned on success. Otherwise, -EINVAL is returned if
- * @a irq is not a valid interrupt number.
- *
- * @coretags{secondary-only}
- */
-int xnintr_init(struct xnintr *intr, const char *name,
-		unsigned int irq, xnisr_t isr, xniack_t iack,
-		int flags)
-{
-	secondary_mode_only();
-
-	if (irq >= IPIPE_NR_IRQS)
-		return -EINVAL;
-
-	intr->irq = irq;
-	intr->isr = isr;
-	intr->iack = iack;
-	intr->cookie = NULL;
-	intr->name = name ? : "<unknown>";
-	intr->flags = flags;
-	intr->status = _XN_IRQSTAT_DISABLED;
-	intr->unhandled = 0;
-	raw_spin_lock_init(&intr->lock);
-#ifdef CONFIG_XENO_OPT_SHIRQ
-	intr->next = NULL;
-#endif
-	alloc_irqstats(intr);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(xnintr_init);
-
-/**
- * @fn void xnintr_destroy(struct xnintr *intr)
- * @brief Destroy an interrupt descriptor.
- *
- * Destroys an interrupt descriptor previously initialized by
- * xnintr_init(). The descriptor is automatically detached by a call
- * to xnintr_detach(). No more IRQs will be received through this
- * descriptor after this service has returned.
- *
- * @param intr The address of the interrupt descriptor to destroy.
- *
- * @coretags{secondary-only}
- */
-void xnintr_destroy(struct xnintr *intr)
-{
-	secondary_mode_only();
-	xnintr_detach(intr);
-	free_irqstats(intr);
-}
-EXPORT_SYMBOL_GPL(xnintr_destroy);
-
-/**
- * @fn int xnintr_attach(struct xnintr *intr, void *cookie)
- * @brief Attach an interrupt descriptor.
- *
- * Attach an interrupt descriptor previously initialized by
- * xnintr_init(). This operation registers the descriptor at the
- * interrupt pipeline, but does not enable the interrupt line yet. A
- * call to xnintr_enable() is required to start receiving IRQs from
- * the interrupt line associated to the descriptor.
- *
- * @param intr The address of the interrupt descriptor to attach.
- *
- * @param cookie A user-defined opaque value which is stored into the
- * descriptor for further retrieval by the interrupt handler.
- *
- * @param cpumask Initial CPU affinity of the interrupt. If NULL, affinity is
- * set to all real-time CPUs.
- *
- * @return 0 is returned on success. Otherwise:
- *
- * - -EINVAL is returned if an error occurred while attaching the
- * descriptor.
- *
- * - -EBUSY is returned if the descriptor was already attached.
- *
- * @note The caller <b>must not</b> hold nklock when invoking this service,
- * this would cause deadlocks.
- *
- * @coretags{secondary-only}
- *
- * @note Attaching an interrupt descriptor resets the tracked number
- * of IRQ receipts to zero.
- */
-int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
-{
-#ifdef CONFIG_SMP
-	cpumask_t tmp_mask, *effective_mask;
-#endif
-	int ret;
-
-	secondary_mode_only();
-	trace_cobalt_irq_attach(intr->irq);
-
-	intr->cookie = cookie;
-	clear_irqstats(intr);
-
-#ifdef CONFIG_SMP
-	if (!cpumask) {
-		effective_mask = &xnsched_realtime_cpus;
-	} else {
-		effective_mask = &tmp_mask;
-		cpumask_and(effective_mask, &xnsched_realtime_cpus, cpumask);
-		if (cpumask_empty(effective_mask))
-			return -EINVAL;
-	}
-	ret = ipipe_set_irq_affinity(intr->irq, *effective_mask);
-	if (ret)
-		return ret;
-#endif /* CONFIG_SMP */
-
-	raw_spin_lock(&intr->lock);
-
-	if (test_and_set_bit(XN_IRQSTAT_ATTACHED, &intr->status)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	ret = xnintr_irq_attach(intr);
-	if (ret) {
-		clear_bit(XN_IRQSTAT_ATTACHED, &intr->status);
-		goto out;
-	}
-
-	stat_counter_inc();
-out:
-	raw_spin_unlock(&intr->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xnintr_attach);
-
-/**
- * @fn int xnintr_detach(struct xnintr *intr)
- * @brief Detach an interrupt descriptor.
- *
- * This call unregisters an interrupt descriptor previously attached
- * by xnintr_attach() from the interrupt pipeline. Once detached, the
- * associated interrupt line is disabled, but the descriptor remains
- * valid. The descriptor can be attached anew by a call to
- * xnintr_attach().
- *
- * @param intr The address of the interrupt descriptor to detach.
- *
- * @note The caller <b>must not</b> hold nklock when invoking this
- * service, this would cause deadlocks.
- *
- * @coretags{secondary-only}
- */
-void xnintr_detach(struct xnintr *intr)
-{
-	secondary_mode_only();
-	trace_cobalt_irq_detach(intr->irq);
-
-	raw_spin_lock(&intr->lock);
-
-	if (test_and_clear_bit(XN_IRQSTAT_ATTACHED, &intr->status)) {
-		xnintr_irq_detach(intr);
-		stat_counter_dec();
-	}
-
-	raw_spin_unlock(&intr->lock);
-}
-EXPORT_SYMBOL_GPL(xnintr_detach);
-
-/**
- * @fn void xnintr_enable(struct xnintr *intr)
- * @brief Enable an interrupt line.
- *
- * Enables the interrupt line associated with an interrupt descriptor.
- *
- * @param intr The address of the interrupt descriptor.
- *
- * @coretags{secondary-only}
- */
-void xnintr_enable(struct xnintr *intr)
-{
-	unsigned long flags;
-
-	secondary_mode_only();
-	trace_cobalt_irq_enable(intr->irq);
-
-	raw_spin_lock_irqsave(&intr->lock, flags);
-
-	/*
-	 * If disabled on entry, there is no way we could race with
-	 * disable_irq_line().
-	 */
-	if (test_and_clear_bit(XN_IRQSTAT_DISABLED, &intr->status))
-		ipipe_enable_irq(intr->irq);
-
-	raw_spin_unlock_irqrestore(&intr->lock, flags);
-}
-EXPORT_SYMBOL_GPL(xnintr_enable);
-
-/**
- * @fn void xnintr_disable(struct xnintr *intr)
- * @brief Disable an interrupt line.
- *
- * Disables the interrupt line associated with an interrupt
- * descriptor.
- *
- * @param intr The address of the interrupt descriptor.
- *
- * @coretags{secondary-only}
- */
-void xnintr_disable(struct xnintr *intr)
-{
-	unsigned long flags;
-
-	secondary_mode_only();
-	trace_cobalt_irq_disable(intr->irq);
-
-	/* We only need a virtual masking. */
-	raw_spin_lock_irqsave(&intr->lock, flags);
-
-	/*
-	 * Racing with disable_irq_line() is innocuous, the pipeline
-	 * would serialize calls to ipipe_disable_irq() across CPUs,
-	 * and the descriptor status would still properly match the
-	 * line status in the end.
-	 */
-	if (!test_and_set_bit(XN_IRQSTAT_DISABLED, &intr->status))
-		ipipe_disable_irq(intr->irq);
-
-	raw_spin_unlock_irqrestore(&intr->lock, flags);
-}
-EXPORT_SYMBOL_GPL(xnintr_disable);
-
-/**
- * @fn void xnintr_affinity(struct xnintr *intr, cpumask_t cpumask)
- * @brief Set processor affinity of interrupt.
- *
- * Restricts the IRQ line associated with the interrupt descriptor @a
- * intr to be received only on processors which bits are set in @a
- * cpumask.
- *
- * @param intr The address of the interrupt descriptor.
- *
- * @param cpumask The new processor affinity.
- *
- * @note Depending on architectures, setting more than one bit in @a
- * cpumask could be meaningless.
- *
- * @coretags{secondary-only}
- */
-int xnintr_affinity(struct xnintr *intr, const cpumask_t *cpumask)
-{
-#ifdef CONFIG_SMP
-	cpumask_t effective_mask;
-
-	secondary_mode_only();
-
-	cpumask_and(&effective_mask, &xnsched_realtime_cpus, cpumask);
-	if (cpumask_empty(&effective_mask))
-		return -EINVAL;
-
-	return ipipe_set_irq_affinity(intr->irq, effective_mask);
-#else
-	secondary_mode_only();
-	return 0;
-#endif
-}
-EXPORT_SYMBOL_GPL(xnintr_affinity);
-
-static inline int xnintr_is_timer_irq(int irq)
-{
-	int cpu;
-
-	for_each_realtime_cpu(cpu)
-		if (irq == per_cpu(ipipe_percpu.hrtimer_irq, cpu))
-			return 1;
-
-	return 0;
-}
-
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-
-int xnintr_get_query_lock(void)
-{
-	return mutex_lock_interruptible(&intrlock) ? -ERESTARTSYS : 0;
-}
-
-void xnintr_put_query_lock(void)
-{
-	mutex_unlock(&intrlock);
-}
-
-int xnintr_query_init(struct xnintr_iterator *iterator)
-{
-	iterator->prev = NULL;
-
-	/* The order is important here: first xnintr_list_rev then
-	 * xnintr_count.  On the other hand, xnintr_attach/detach()
-	 * update xnintr_count first and then xnintr_list_rev.  This
-	 * should guarantee that we can't get an up-to-date
-	 * xnintr_list_rev and old xnintr_count here. The other way
-	 * around is not a problem as xnintr_query() will notice this
-	 * fact later.  Should xnintr_list_rev change later,
-	 * xnintr_query() will trigger an appropriate error below.
-	 */
-	iterator->list_rev = xnintr_list_rev;
-	smp_mb();
-
-	return xnintr_count;
-}
-
-int xnintr_query_next(int irq, struct xnintr_iterator *iterator,
-		      char *name_buf)
-{
-	int cpu, nr_cpus = num_present_cpus();
-	struct xnintr *intr;
-
-	if (iterator->list_rev != xnintr_list_rev)
-		return -EAGAIN;
-
-	intr = iterator->prev;
-	if (intr == NULL) {
-		if (xnintr_is_timer_irq(irq))
-			intr = &nktimer;
-		else
-			intr = xnintr_vec_first(irq);
-		if (intr == NULL)
-			return -ENODEV;
-		iterator->prev = intr;
-		iterator->cpu = -1;
-	}
-
-	for (;;) {
-		for (cpu = iterator->cpu + 1; cpu < nr_cpus; ++cpu) {
-			if (cpu_online(cpu)) {
-				ksformat(name_buf, XNOBJECT_NAME_LEN, "IRQ%d: %s",
-					irq, intr->name);
-				query_irqstats(intr, cpu, iterator);
-				iterator->cpu = cpu;
-				return 0;
-			}
-		}
-
-		iterator->prev = xnintr_vec_next(intr);
-		if (iterator->prev == NULL)
-			return -ENODEV;
-
-		iterator->cpu = -1;
-	}
-}
-
-#endif /* CONFIG_XENO_OPT_STATS_IRQS */
-
-#ifdef CONFIG_XENO_OPT_VFILE
-
-#include <cobalt/kernel/vfile.h>
-
-static inline int format_irq_proc(unsigned int irq,
-				  struct xnvfile_regular_iterator *it)
-{
-	struct xnintr *intr;
-	struct irq_desc *d;
-	int cpu;
-
-	for_each_realtime_cpu(cpu)
-		if (xnintr_is_timer_irq(irq)) {
-			xnvfile_printf(it, "         [timer/%d]", cpu);
-			return 0;
-		}
-
-#ifdef CONFIG_SMP
-	/*
-	 * IPI numbers on ARM are not compile time constants, so do
-	 * not use switch/case here.
-	 */
-	if (irq == IPIPE_HRTIMER_IPI) {
-		xnvfile_puts(it, "         [timer-ipi]");
-		return 0;
-	}
-	if (irq == IPIPE_RESCHEDULE_IPI) {
-		xnvfile_puts(it, "         [reschedule]");
-		return 0;
-	}
-	if (irq == IPIPE_CRITICAL_IPI) {
-		xnvfile_puts(it, "         [sync]");
-		return 0;
-	}
-#endif /* CONFIG_SMP */
-	if (ipipe_virtual_irq_p(irq)) {
-		xnvfile_puts(it, "         [virtual]");
-		return 0;
-	}
-
-	mutex_lock(&intrlock);
-
-	if (!cobalt_owns_irq(irq)) {
-		xnvfile_puts(it, "         ");
-		d = irq_to_desc(irq);
-		xnvfile_puts(it, d && d->name ? d->name : "-");
-	} else {
-		intr = xnintr_vec_first(irq);
-		if (intr) {
-			xnvfile_puts(it, "        ");
-
-			do {
-				xnvfile_putc(it, ' ');
-				xnvfile_puts(it, intr->name);
-				intr = xnintr_vec_next(intr);
-			} while (intr);
-		}
-	}
-
-	mutex_unlock(&intrlock);
-
-	return 0;
-}
-
-static int irq_vfile_show(struct xnvfile_regular_iterator *it,
-			  void *data)
-{
-	int cpu, irq;
-
-	/* FIXME: We assume the entire output fits in a single page. */
-
-	xnvfile_puts(it, "  IRQ ");
-
-	for_each_realtime_cpu(cpu)
-		xnvfile_printf(it, "        CPU%d", cpu);
-
-	for (irq = 0; irq < IPIPE_NR_IRQS; irq++) {
-		if (__ipipe_irq_handler(&xnsched_primary_domain, irq) == NULL)
-			continue;
-
-		xnvfile_printf(it, "\n%5d:", irq);
-
-		for_each_realtime_cpu(cpu) {
-			xnvfile_printf(it, "%12lu",
-				       __ipipe_cpudata_irq_hits(&xnsched_primary_domain, cpu,
-								irq));
-		}
-
-		format_irq_proc(irq, it);
-	}
-
-	xnvfile_putc(it, '\n');
-
-	return 0;
-}
-
-static struct xnvfile_regular_ops irq_vfile_ops = {
-	.show = irq_vfile_show,
-};
-
-static struct xnvfile_regular irq_vfile = {
-	.ops = &irq_vfile_ops,
-};
-
-void xnintr_init_proc(void)
-{
-	xnvfile_init_regular("irq", &irq_vfile, &cobalt_vfroot);
-}
-
-void xnintr_cleanup_proc(void)
-{
-	xnvfile_destroy_regular(&irq_vfile);
-}
-
-#endif /* CONFIG_XENO_OPT_VFILE */
-
-/** @} */
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
deleted file mode 100644
index 43cc192ab5..0000000000
--- a/kernel/cobalt/ipipe/kevents.c
+++ /dev/null
@@ -1,541 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2001-2014 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) 2001-2014 The Xenomai project <http://www.xenomai.org>
- * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
- *
- * SMP support Copyright (C) 2004 The HYADES project <http://www.hyades-itea.org>
- * RTAI/fusion Copyright (C) 2004 The RTAI project <http://www.rtai.org>
- */
-
-#include <linux/ipipe.h>
-#include <linux/ipipe_tickdev.h>
-#include <linux/ptrace.h>
-#include <linux/kallsyms.h>
-#include <pipeline/kevents.h>
-#include <cobalt/kernel/sched.h>
-#include <cobalt/kernel/thread.h>
-#include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/vdso.h>
-#include <rtdm/driver.h>
-#include <trace/events/cobalt-core.h>
-#include "../posix/process.h"
-#include "../posix/thread.h"
-#include "../posix/memory.h"
-
-static inline int handle_exception(struct ipipe_trap_data *d)
-{
-	struct xnthread *thread;
-	struct xnsched *sched;
-
-	sched = xnsched_current();
-	thread = sched->curr;
-
-	trace_cobalt_thread_fault(xnarch_fault_pc(d),
-				  xnarch_fault_trap(d));
-
-	if (xnthread_test_state(thread, XNROOT))
-		return 0;
-
-	if (xnarch_fault_fpu_p(d)) {
-#ifdef CONFIG_XENO_ARCH_FPU
-		spl_t s;
-
-		/* FPU exception received in primary mode. */
-		splhigh(s);
-		if (xnarch_handle_fpu_fault(sched->fpuholder, thread, d)) {
-			sched->fpuholder = thread;
-			splexit(s);
-			return 1;
-		}
-		splexit(s);
-#endif /* CONFIG_XENO_ARCH_FPU */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 16, 0)
-		printk("invalid use of FPU in Xenomai context at %pS\n",
-		       (void *)xnarch_fault_pc(d));
-#else
-		print_symbol("invalid use of FPU in Xenomai context at %s\n",
-			     xnarch_fault_pc(d));
-#endif
-	}
-
-	if (xnarch_fault_bp_p(d) && user_mode(d->regs)) {
-		spl_t s;
-
-		XENO_WARN_ON(CORE, xnthread_test_state(thread, XNRELAX));
-		xnlock_get_irqsave(&nklock, s);
-		xnthread_set_info(thread, XNCONTHI);
-		ipipe_enable_user_intret_notifier();
-		cobalt_stop_debugged_process(thread);
-		xnlock_put_irqrestore(&nklock, s);
-		xnsched_run();
-	}
-
-	/*
-	 * If we experienced a trap on behalf of a shadow thread
-	 * running in primary mode, move it to the Linux domain,
-	 * leaving the kernel process the exception.
-	 */
-#if defined(CONFIG_XENO_OPT_DEBUG_COBALT) || defined(CONFIG_XENO_OPT_DEBUG_USER)
-	if (!user_mode(d->regs)) {
-		xntrace_panic_freeze();
-		printk(XENO_WARNING
-		       "switching %s to secondary mode after exception #%u in "
-		       "kernel-space at 0x%lx (pid %d)\n", thread->name,
-		       xnarch_fault_trap(d),
-		       xnarch_fault_pc(d),
-		       xnthread_host_pid(thread));
-		xntrace_panic_dump();
-	} else if (xnarch_fault_notify(d)) /* Don't report debug traps */
-		printk(XENO_WARNING
-		       "switching %s to secondary mode after exception #%u from "
-		       "user-space at 0x%lx (pid %d)\n", thread->name,
-		       xnarch_fault_trap(d),
-		       xnarch_fault_pc(d),
-		       xnthread_host_pid(thread));
-#endif
-
-	if (xnarch_fault_pf_p(d))
-		/*
-		 * The page fault counter is not SMP-safe, but it's a
-		 * simple indicator that something went wrong wrt
-		 * memory locking anyway.
-		 */
-		xnstat_counter_inc(&thread->stat.pf);
-
-	xnthread_relax(xnarch_fault_notify(d), SIGDEBUG_MIGRATE_FAULT);
-
-	return 0;
-}
-
-static int handle_mayday_event(struct pt_regs *regs)
-{
-	XENO_BUG_ON(COBALT, !xnthread_test_state(xnthread_current(), XNUSER));
-
-	xnthread_relax(0, 0);
-
-	return KEVENT_PROPAGATE;
-}
-
-int ipipe_trap_hook(struct ipipe_trap_data *data)
-{
-	if (data->exception == IPIPE_TRAP_MAYDAY)
-		return handle_mayday_event(data->regs);
-
-	/*
-	 * No migration is possible on behalf of the head domain, so
-	 * the following access is safe.
-	 */
-	raw_cpu_ptr(&cobalt_machine_cpudata)->faults[data->exception]++;
-
-	if (handle_exception(data))
-		return KEVENT_STOP;
-
-	/*
-	 * CAUTION: access faults must be propagated downstream
-	 * whichever domain caused them, so that we don't spuriously
-	 * raise a fatal error when some Linux fixup code is available
-	 * to recover from the fault.
-	 */
-	return KEVENT_PROPAGATE;
-}
-
-/*
- * Legacy idle hook, unconditionally allow entering the idle state.
- */
-bool ipipe_enter_idle_hook(void)
-{
-	return true;
-}
-
-static inline int handle_setaffinity_event(struct ipipe_cpu_migration_data *d)
-{
-	return cobalt_handle_setaffinity_event(d->task);
-}
-
-static inline int handle_taskexit_event(struct task_struct *p)
-{
-	return cobalt_handle_taskexit_event(p);
-}
-
-void ipipe_migration_hook(struct task_struct *p) /* hw IRQs off */
-{
-	struct xnthread *thread = xnthread_from_task(p);
-
-	xnlock_get(&nklock);
-
-	/*
-	 * We fire the handler before the thread is migrated, so that
-	 * thread->sched does not change between paired invocations of
-	 * relax_thread/harden_thread handlers.
-	 */
-	xnthread_run_handler_stack(thread, harden_thread);
-
-	cobalt_adjust_affinity(p);
-
-	xnthread_resume(thread, XNRELAX);
-
-	/*
-	 * In case we migrated independently of the user return notifier, clear
-	 * XNCONTHI here and also disable the notifier - we are already done.
-	 */
-	if (unlikely(xnthread_test_info(thread, XNCONTHI))) {
-		xnthread_clear_info(thread, XNCONTHI);
-		ipipe_disable_user_intret_notifier();
-	}
-
-	/* Unregister as debugged thread in case we postponed this. */
-	if (unlikely(xnthread_test_state(thread, XNSSTEP)))
-		cobalt_unregister_debugged_thread(thread);
-
-	xnlock_put(&nklock);
-
-	xnsched_run();
-}
-
-#ifdef CONFIG_IPIPE_HAVE_HOSTRT
-
-static IPIPE_DEFINE_SPINLOCK(__hostrtlock);
-
-static int handle_hostrt_event(struct ipipe_hostrt_data *hostrt)
-{
-	unsigned long flags;
-	urwstate_t tmp;
-
-	/*
-	 * The locking strategy is twofold:
-	 * - The spinlock protects against concurrent updates from within the
-	 *   Linux kernel and against preemption by Xenomai
-	 * - The unsynced R/W block is for lockless read-only access.
-	 */
-	raw_spin_lock_irqsave(&__hostrtlock, flags);
-
-	unsynced_write_block(&tmp, &nkvdso->hostrt_data.lock) {
-		nkvdso->hostrt_data.live = 1;
-		nkvdso->hostrt_data.cycle_last = hostrt->cycle_last;
-		nkvdso->hostrt_data.mask = hostrt->mask;
-		nkvdso->hostrt_data.mult = hostrt->mult;
-		nkvdso->hostrt_data.shift = hostrt->shift;
-		nkvdso->hostrt_data.wall_sec = hostrt->wall_time_sec;
-		nkvdso->hostrt_data.wall_nsec = hostrt->wall_time_nsec;
-		nkvdso->hostrt_data.wtom_sec = hostrt->wall_to_monotonic.tv_sec;
-		nkvdso->hostrt_data.wtom_nsec = hostrt->wall_to_monotonic.tv_nsec;
-	}
-
-	raw_spin_unlock_irqrestore(&__hostrtlock, flags);
-
-	return KEVENT_PROPAGATE;
-}
-
-static inline void init_hostrt(void)
-{
-	unsynced_rw_init(&nkvdso->hostrt_data.lock);
-	nkvdso->hostrt_data.live = 0;
-}
-
-#else /* !CONFIG_IPIPE_HAVE_HOSTRT */
-
-struct ipipe_hostrt_data;
-
-static inline int handle_hostrt_event(struct ipipe_hostrt_data *hostrt)
-{
-	return KEVENT_PROPAGATE;
-}
-
-static inline void init_hostrt(void) { }
-
-#endif /* !CONFIG_IPIPE_HAVE_HOSTRT */
-
-static int handle_schedule_event(struct task_struct *next_task)
-{
-	struct task_struct *prev_task;
-	struct xnthread *next;
-	sigset_t pending;
-	spl_t s;
-
-	cobalt_signal_yield();
-
-	prev_task = current;
-	next = xnthread_from_task(next_task);
-	if (next == NULL)
-		goto out;
-
-	xnlock_get_irqsave(&nklock, s);
-
-	/*
-	 * Track tasks leaving the ptraced state.  Check both SIGSTOP
-	 * (NPTL) and SIGINT (LinuxThreads) to detect ptrace
-	 * continuation.
-	 */
-	if (xnthread_test_state(next, XNSSTEP)) {
-		if (signal_pending(next_task)) {
-			/*
-			 * Do not grab the sighand lock here: it's
-			 * useless, and we already own the runqueue
-			 * lock, so this would expose us to deadlock
-			 * situations on SMP.
-			 */
-			sigorsets(&pending,
-				  &next_task->pending.signal,
-				  &next_task->signal->shared_pending.signal);
-			if (sigismember(&pending, SIGSTOP) ||
-			    sigismember(&pending, SIGINT))
-				goto no_ptrace;
-		}
-
-		/*
-		 * Do not unregister before the thread migrated.
-		 * cobalt_unregister_debugged_thread will then be called by our
-		 * ipipe_migration_hook.
-		 */
-		if (!xnthread_test_info(next, XNCONTHI))
-			cobalt_unregister_debugged_thread(next);
-
-		xnthread_set_localinfo(next, XNHICCUP);
-	}
-
-no_ptrace:
-	xnlock_put_irqrestore(&nklock, s);
-
-	/*
-	 * Do basic sanity checks on the incoming thread state.
-	 * NOTE: we allow ptraced threads to run shortly in order to
-	 * properly recover from a stopped state.
-	 */
-	if (!XENO_WARN(COBALT, !xnthread_test_state(next, XNRELAX),
-		       "hardened thread %s[%d] running in Linux domain?! "
-		       "(status=0x%x, sig=%d, prev=%s[%d])",
-		       next->name, task_pid_nr(next_task),
-		       xnthread_get_state(next),
-		       signal_pending(next_task),
-		       prev_task->comm, task_pid_nr(prev_task)))
-		XENO_WARN(COBALT,
-			  !(next_task->ptrace & PT_PTRACED) &&
-			   !xnthread_test_state(next, XNDORMANT)
-			  && xnthread_test_state(next, XNPEND),
-			  "blocked thread %s[%d] rescheduled?! "
-			  "(status=0x%x, sig=%d, prev=%s[%d])",
-			  next->name, task_pid_nr(next_task),
-			  xnthread_get_state(next),
-			  signal_pending(next_task), prev_task->comm,
-			  task_pid_nr(prev_task));
-out:
-	return KEVENT_PROPAGATE;
-}
-
-static int handle_sigwake_event(struct task_struct *p)
-{
-	struct xnthread *thread;
-	sigset_t pending;
-	spl_t s;
-
-	thread = xnthread_from_task(p);
-	if (thread == NULL)
-		return KEVENT_PROPAGATE;
-
-	xnlock_get_irqsave(&nklock, s);
-
-	/*
-	 * CAUTION: __TASK_TRACED is not set in p->state yet. This
-	 * state bit will be set right after we return, when the task
-	 * is woken up.
-	 */
-	if ((p->ptrace & PT_PTRACED) && !xnthread_test_state(thread, XNSSTEP)) {
-		/* We already own the siglock. */
-		sigorsets(&pending,
-			  &p->pending.signal,
-			  &p->signal->shared_pending.signal);
-
-		if (sigismember(&pending, SIGTRAP) ||
-		    sigismember(&pending, SIGSTOP)
-		    || sigismember(&pending, SIGINT))
-			cobalt_register_debugged_thread(thread);
-	}
-
-	if (xnthread_test_state(thread, XNRELAX))
-		goto out;
-
-	/*
-	 * If kicking a shadow thread in primary mode, make sure Linux
-	 * won't schedule in its mate under our feet as a result of
-	 * running signal_wake_up(). The Xenomai scheduler must remain
-	 * in control for now, until we explicitly relax the shadow
-	 * thread to allow for processing the pending signals. Make
-	 * sure we keep the additional state flags unmodified so that
-	 * we don't break any undergoing ptrace.
-	 */
-	if (p->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE))
-		cobalt_set_task_state(p, p->state | TASK_NOWAKEUP);
-
-	/*
-	 * Allow a thread stopped for debugging to resume briefly in order to
-	 * migrate to secondary mode. xnthread_relax will reapply XNDBGSTOP.
-	 */
-	if (xnthread_test_state(thread, XNDBGSTOP))
-		xnthread_resume(thread, XNDBGSTOP);
-
-	__xnthread_kick(thread);
-out:
-	xnsched_run();
-
-	xnlock_put_irqrestore(&nklock, s);
-
-	return KEVENT_PROPAGATE;
-}
-
-static inline int handle_cleanup_event(struct mm_struct *mm)
-{
-	return cobalt_handle_cleanup_event(mm);
-}
-
-void pipeline_cleanup_process(void)
-{
-	ipipe_disable_notifier(current);
-}
-
-static inline int handle_clockfreq_event(unsigned int *p)
-{
-	unsigned int newfreq = *p;
-
-	pipeline_update_clock_freq(newfreq);
-
-	return KEVENT_PROPAGATE;
-}
-
-static inline int handle_user_return(struct task_struct *task)
-{
-	ipipe_disable_user_intret_notifier();
-	return cobalt_handle_user_return(task);
-}
-
-int handle_ptrace_resume(struct ipipe_ptrace_resume_data *resume)
-{
-	struct xnthread *thread;
-	spl_t s;
-
-	thread = xnthread_from_task(resume->task);
-	if (thread == NULL)
-		return KEVENT_PROPAGATE;
-
-	if (resume->request == PTRACE_SINGLESTEP &&
-	    xnthread_test_state(thread, XNSSTEP)) {
-		xnlock_get_irqsave(&nklock, s);
-
-		xnthread_resume(thread, XNDBGSTOP);
-		cobalt_unregister_debugged_thread(thread);
-
-		xnlock_put_irqrestore(&nklock, s);
-	}
-
-	return KEVENT_PROPAGATE;
-}
-
-int ipipe_kevent_hook(int kevent, void *data)
-{
-	int ret;
-
-	switch (kevent) {
-	case IPIPE_KEVT_SCHEDULE:
-		ret = handle_schedule_event(data);
-		break;
-	case IPIPE_KEVT_SIGWAKE:
-		ret = handle_sigwake_event(data);
-		break;
-	case IPIPE_KEVT_EXIT:
-		ret = handle_taskexit_event(data);
-		break;
-	case IPIPE_KEVT_CLEANUP:
-		ret = handle_cleanup_event(data);
-		break;
-	case IPIPE_KEVT_SETAFFINITY:
-		ret = handle_setaffinity_event(data);
-		break;
-#ifdef CONFIG_IPIPE_HAVE_HOSTRT
-	case IPIPE_KEVT_HOSTRT:
-		ret = handle_hostrt_event(data);
-		break;
-#endif
-	case IPIPE_KEVT_CLOCKFREQ:
-		ret = handle_clockfreq_event(data);
-		break;
-	case IPIPE_KEVT_USERINTRET:
-		ret = handle_user_return(data);
-		break;
-	case IPIPE_KEVT_PTRESUME:
-		ret = handle_ptrace_resume(data);
-		break;
-	default:
-		ret = KEVENT_PROPAGATE;
-	}
-
-	return ret;
-}
-
-#ifdef CONFIG_MMU
-
-int pipeline_prepare_current(void)
-{
-	struct task_struct *p = current;
-	kernel_siginfo_t si;
-
-	if ((p->mm->def_flags & VM_LOCKED) == 0) {
-		memset(&si, 0, sizeof(si));
-		si.si_signo = SIGDEBUG;
-		si.si_code = SI_QUEUE;
-		si.si_int = SIGDEBUG_NOMLOCK | sigdebug_marker;
-		send_sig_info(SIGDEBUG, &si, p);
-		return 0;
-	}
-
-	return __ipipe_disable_ondemand_mappings(p);
-}
-
-static inline int get_mayday_prot(void)
-{
-	return PROT_READ|PROT_EXEC;
-}
-
-#else /* !CONFIG_MMU */
-
-int pipeline_prepare_current(void)
-{
-	return 0;
-}
-
-static inline int get_mayday_prot(void)
-{
-	/*
-	 * Until we stop backing /dev/mem with the mayday page, we
-	 * can't ask for PROT_EXEC since the former does not define
-	 * mmap capabilities, and default ones won't allow an
-	 * executable mapping with MAP_SHARED. In the NOMMU case, this
-	 * is (currently) not an issue.
-	 */
-	return PROT_READ;
-}
-
-#endif /* !CONFIG_MMU */
-
-void pipeline_attach_current(struct xnthread *thread)
-{
-	struct cobalt_threadinfo *p;
-
-	p = pipeline_current();
-	p->thread = thread;
-	p->process = cobalt_search_process(current->mm);
-}
-
-int pipeline_trap_kevents(void)
-{
-	init_hostrt();
-	ipipe_set_hooks(ipipe_root_domain, IPIPE_SYSCALL|IPIPE_KEVENT);
-	ipipe_set_hooks(&xnsched_primary_domain, IPIPE_SYSCALL|IPIPE_TRAP);
-
-	return 0;
-}
-
-void pipeline_enable_kevents(void)
-{
-	ipipe_enable_notifier(current);
-}
diff --git a/kernel/cobalt/ipipe/sched.c b/kernel/cobalt/ipipe/sched.c
deleted file mode 100644
index 3104e50156..0000000000
--- a/kernel/cobalt/ipipe/sched.c
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2001-2020 Philippe Gerum <rpm@xenomai.org>.
- */
-
-#include <cobalt/kernel/thread.h>
-#include <cobalt/kernel/sched.h>
-#include <cobalt/kernel/assert.h>
-#include <pipeline/sched.h>
-#include <trace/events/cobalt-core.h>
-
-int pipeline_schedule(struct xnsched *sched)
-{
-	int ret = 0;
-
-	XENO_WARN_ON_ONCE(COBALT,
-		!hard_irqs_disabled() && is_secondary_domain());
-
-	if (!xnarch_escalate())
-		ret = ___xnsched_run(sched);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pipeline_schedule);
-
-void pipeline_prep_switch_oob(struct xnthread *root)
-{
-	struct xnarchtcb *rootcb = xnthread_archtcb(root);
-	struct task_struct *p = current;
-
-	ipipe_notify_root_preemption();
-	/* Remember the preempted Linux task pointer. */
-	rootcb->core.host_task = p;
-	rootcb->core.tsp = &p->thread;
-	rootcb->core.mm = rootcb->core.active_mm = ipipe_get_active_mm();
-	rootcb->core.tip = task_thread_info(p);
-	xnarch_leave_root(root);
-}
-
-#ifdef CONFIG_XENO_ARCH_FPU
-
-static void switch_fpu(void)
-{
-	struct xnsched *sched = xnsched_current();
-	struct xnthread *curr = sched->curr;
-
-	if (!xnthread_test_state(curr, XNFPU))
-		return;
-
-	xnarch_switch_fpu(sched->fpuholder, curr);
-	sched->fpuholder = curr;
-}
-
-static void giveup_fpu(struct xnthread *thread)
-{
-	struct xnsched *sched = thread->sched;
-
-	if (thread == sched->fpuholder)
-		sched->fpuholder = NULL;
-}
-
-#else
-
-static inline void giveup_fpu(struct xnthread *thread)
-{ }
-
-#endif /* !CONFIG_XENO_ARCH_FPU */
-
-bool pipeline_switch_to(struct xnthread *prev, struct xnthread *next,
-			bool leaving_inband)
-{
-	xnarch_switch_to(prev, next);
-
-	/*
-	 * Test whether we transitioned from primary mode to secondary
-	 * over a shadow thread, caused by a call to xnthread_relax().
-	 * In such a case, we are running over the regular schedule()
-	 * tail code, so we have to tell the caller to skip the Cobalt
-	 * tail code.
-	 */
-	if (!leaving_inband && is_secondary_domain()) {
-		__ipipe_complete_domain_migration();
-		XENO_BUG_ON(COBALT, xnthread_current() == NULL);
-		/*
-		 * Interrupts must be disabled here (has to be done on
-		 * entry of the Linux [__]switch_to function), but it
-		 * is what callers expect, specifically the reschedule
-		 * of an IRQ handler that hit before we call
-		 * xnsched_run in xnthread_suspend() when relaxing a
-		 * thread.
-		 */
-		XENO_BUG_ON(COBALT, !hard_irqs_disabled());
-		return true;
-	}
-
-	switch_fpu();
-
-	return false;
-}
-
-void pipeline_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct task_struct *p = current;
-
-	/*
-	 * If the current task is a kthread, the pipeline will take
-	 * the necessary steps to make the FPU usable in such
-	 * context. The kernel already took care of this issue for
-	 * userland tasks (e.g. setting up a clean backup area).
-	 */
-	__ipipe_share_current(0);
-
-	tcb->core.host_task = p;
-	tcb->core.tsp = &p->thread;
-	tcb->core.mm = p->mm;
-	tcb->core.active_mm = p->mm;
-	tcb->core.tip = task_thread_info(p);
-#ifdef CONFIG_XENO_ARCH_FPU
-	tcb->core.user_fpu_owner = p;
-#endif /* CONFIG_XENO_ARCH_FPU */
-	xnarch_init_shadow_tcb(thread);
-
-	trace_cobalt_shadow_map(thread);
-}
-
-void pipeline_init_root_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct task_struct *p = current;
-
-	tcb->core.host_task = p;
-	tcb->core.tsp = &tcb->core.ts;
-	tcb->core.mm = p->mm;
-	tcb->core.tip = NULL;
-	xnarch_init_root_tcb(thread);
-}
-
-int pipeline_leave_inband(void)
-{
-	int ret;
-
-	ret = __ipipe_migrate_head();
-	if (ret)
-		return ret;
-
-	switch_fpu();
-
-	return 0;
-}
-
-int pipeline_leave_oob_prepare(void)
-{
-	struct xnthread *curr = xnthread_current();
-	struct task_struct *p = current;
-	int suspmask = XNRELAX;
-
-	set_current_state(p->state & ~TASK_NOWAKEUP);
-
-	/*
-	 * If current is being debugged, record that it should migrate
-	 * back in case it resumes in userspace. If it resumes in
-	 * kernel space, i.e.  over a restarting syscall, the
-	 * associated hardening will both clear XNCONTHI and disable
-	 * the user return notifier again.
-	 */
-	if (xnthread_test_state(curr, XNSSTEP)) {
-		xnthread_set_info(curr, XNCONTHI);
-		ipipe_enable_user_intret_notifier();
-		suspmask |= XNDBGSTOP;
-	}
-	/*
-	 * Return the suspension bits the caller should pass to
-	 * xnthread_suspend().
-	 */
-	return suspmask;
-}
-
-void pipeline_leave_oob_finish(void)
-{
-	__ipipe_reenter_root();
-}
-
-void pipeline_finalize_thread(struct xnthread *thread)
-{
-	giveup_fpu(thread);
-}
-
-void pipeline_raise_mayday(struct task_struct *tsk)
-{
-	ipipe_raise_mayday(tsk);
-}
-
-void pipeline_clear_mayday(void) /* May solely affect current. */
-{
-	ipipe_clear_thread_flag(TIP_MAYDAY);
-}
diff --git a/kernel/cobalt/ipipe/syscall.c b/kernel/cobalt/ipipe/syscall.c
deleted file mode 100644
index 867a81ec24..0000000000
--- a/kernel/cobalt/ipipe/syscall.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>
- * Copyright (C) 2005 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
- */
-
-#include <pipeline/pipeline.h>
-#include <pipeline/kevents.h>
-#include <cobalt/kernel/assert.h>
-#include <xenomai/posix/syscall.h>
-
-int ipipe_syscall_hook(struct ipipe_domain *ipd, struct pt_regs *regs)
-{
-	if (unlikely(is_secondary_domain()))
-		return handle_root_syscall(regs);
-
-	return handle_head_syscall(ipd != &xnsched_primary_domain, regs);
-}
-
-int ipipe_fastcall_hook(struct pt_regs *regs)
-{
-	int ret;
-
-	ret = handle_head_syscall(false, regs);
-	XENO_BUG_ON(COBALT, ret == KEVENT_PROPAGATE);
-
-	return ret;
-}
diff --git a/kernel/cobalt/ipipe/tick.c b/kernel/cobalt/ipipe/tick.c
deleted file mode 100644
index db6e37cfe3..0000000000
--- a/kernel/cobalt/ipipe/tick.c
+++ /dev/null
@@ -1,286 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2001,2002,2003,2007,2012 Philippe Gerum <rpm@xenomai.org>.
- * Copyright (C) 2004 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
- */
-#include <linux/ipipe.h>
-#include <linux/ipipe_tickdev.h>
-#include <linux/sched.h>
-#include <cobalt/kernel/sched.h>
-#include <cobalt/kernel/timer.h>
-#include <cobalt/kernel/intr.h>
-#include <cobalt/kernel/clock.h>
-#include <cobalt/kernel/arith.h>
-
-extern struct xnintr nktimer;
-
-/**
- * @internal
- * @fn static int program_htick_shot(unsigned long delay, struct clock_event_device *cdev)
- *
- * @brief Program next host tick as a Xenomai timer event.
- *
- * Program the next shot for the host tick on the current CPU.
- * Emulation is done using a nucleus timer attached to the master
- * timebase.
- *
- * @param delay The time delta from the current date to the next tick,
- * expressed as a count of nanoseconds.
- *
- * @param cdev An pointer to the clock device which notifies us.
- *
- * @coretags{unrestricted}
- */
-static int program_htick_shot(unsigned long delay,
-			      struct clock_event_device *cdev)
-{
-	struct xnsched *sched;
-	int ret;
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-	sched = xnsched_current();
-	ret = xntimer_start(&sched->htimer, delay, XN_INFINITE, XN_RELATIVE);
-	xnlock_put_irqrestore(&nklock, s);
-
-	return ret ? -ETIME : 0;
-}
-
-/**
- * @internal
- * @fn void switch_htick_mode(enum clock_event_mode mode, struct clock_event_device *cdev)
- *
- * @brief Tick mode switch emulation callback.
- *
- * Changes the host tick mode for the tick device of the current CPU.
- *
- * @param mode The new mode to switch to. The possible values are:
- *
- * - CLOCK_EVT_MODE_ONESHOT, for a switch to oneshot mode.
- *
- * - CLOCK_EVT_MODE_PERIODIC, for a switch to periodic mode. The current
- * implementation for the generic clockevent layer Linux exhibits
- * should never downgrade from a oneshot to a periodic tick mode, so
- * this mode should not be encountered. This said, the associated code
- * is provided, basically for illustration purposes.
- *
- * - CLOCK_EVT_MODE_SHUTDOWN, indicates the removal of the current
- * tick device. Normally, the nucleus only interposes on tick devices
- * which should never be shut down, so this mode should not be
- * encountered.
- *
- * @param cdev An opaque pointer to the clock device which notifies us.
- *
- * @coretags{unrestricted}
- *
- * @note GENERIC_CLOCKEVENTS is required from the host kernel.
- */
-static void switch_htick_mode(enum clock_event_mode mode,
-			      struct clock_event_device *cdev)
-{
-	struct xnsched *sched;
-	xnticks_t tickval;
-	spl_t s;
-
-	if (mode == CLOCK_EVT_MODE_ONESHOT)
-		return;
-
-	xnlock_get_irqsave(&nklock, s);
-
-	sched = xnsched_current();
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		tickval = 1000000000UL / HZ;
-		xntimer_start(&sched->htimer, tickval, tickval, XN_RELATIVE);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		xntimer_stop(&sched->htimer);
-		break;
-	default:
-		XENO_BUG(COBALT);
-	}
-
-	xnlock_put_irqrestore(&nklock, s);
-}
-
-static int grab_timer_on_cpu(int cpu)
-{
-	int tickval, ret;
-
-	ret = ipipe_timer_start(xnintr_core_clock_handler,
-				switch_htick_mode, program_htick_shot, cpu);
-	switch (ret) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		/*
-		 * Oneshot tick emulation callback won't be used, ask
-		 * the caller to start an internal timer for emulating
-		 * a periodic tick.
-		 */
-		tickval = 1000000000UL / HZ;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* oneshot tick emulation */
-		tickval = 1;
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-		/* we don't need to emulate the tick at all. */
-		tickval = 0;
-		break;
-
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		return -ENODEV;
-
-	default:
-		return ret;
-	}
-
-	return tickval;
-}
-
-/**
- * @fn int pipeline_install_tick_proxy(void)
- * @brief Grab the hardware timer on all real-time CPUs.
- *
- * pipeline_install_tick_proxy() grabs and tunes the hardware timer for all
- * real-time CPUs.
- *
- * Host tick emulation is performed for sharing the clock chip between
- * Linux and Xenomai.
- *
- * @return a positive value is returned on success, representing the
- * duration of a Linux periodic tick expressed as a count of
- * nanoseconds; zero should be returned when the Linux kernel does not
- * undergo periodic timing on the given CPU (e.g. oneshot
- * mode). Otherwise:
- *
- * - -EBUSY is returned if the hardware timer has already been
- * grabbed.  xntimer_release_hardware() must be issued before
- * pipeline_install_tick_proxy() is called again.
- *
- * - -ENODEV is returned if the hardware timer cannot be used.  This
- * situation may occur after the kernel disabled the timer due to
- * invalid calibration results; in such a case, such hardware is
- * unusable for any timing duties.
- *
- * @coretags{secondary-only}
- */
-
-int pipeline_install_tick_proxy(void)
-{
-	struct xnsched *sched;
-	int ret, cpu, _cpu;
-	spl_t s;
-
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-	/*
-	 * Only for statistical purpose, the timer interrupt is
-	 * attached by pipeline_install_tick_proxy().
-	 */
-	xnintr_init(&nktimer, "[timer]",
-		    per_cpu(ipipe_percpu.hrtimer_irq, 0), NULL, NULL, 0);
-#endif /* CONFIG_XENO_OPT_STATS_IRQS */
-
-#ifdef CONFIG_SMP
-	ret = ipipe_request_irq(&cobalt_pipeline.domain,
-				IPIPE_HRTIMER_IPI,
-				(ipipe_irq_handler_t)xnintr_core_clock_handler,
-				NULL, NULL);
-	if (ret)
-		return ret;
-#endif
-
-	for_each_realtime_cpu(cpu) {
-		ret = grab_timer_on_cpu(cpu);
-		if (ret < 0)
-			goto fail;
-
-		xnlock_get_irqsave(&nklock, s);
-
-		/*
-		 * If the current tick device for the target CPU is
-		 * periodic, we won't be called back for host tick
-		 * emulation. Therefore, we need to start a periodic
-		 * nucleus timer which will emulate the ticking for
-		 * that CPU, since we are going to hijack the hw clock
-		 * chip for managing our own system timer.
-		 *
-		 * CAUTION:
-		 *
-		 * - nucleus timers may be started only _after_ the hw
-		 * timer has been set up for the target CPU through a
-		 * call to pipeline_install_tick_proxy().
-		 *
-		 * - we don't compensate for the elapsed portion of
-		 * the current host tick, since we cannot get this
-		 * information easily for all CPUs except the current
-		 * one, and also because of the declining relevance of
-		 * the jiffies clocksource anyway.
-		 *
-		 * - we must not hold the nklock across calls to
-		 * pipeline_install_tick_proxy().
-		 */
-
-		sched = xnsched_struct(cpu);
-		/* Set up timer with host tick period if valid. */
-		if (ret > 1)
-			xntimer_start(&sched->htimer, ret, ret, XN_RELATIVE);
-		else if (ret == 1)
-			xntimer_start(&sched->htimer, 0, 0, XN_RELATIVE);
-
-		xnlock_put_irqrestore(&nklock, s);
-	}
-
-	return 0;
-fail:
-	for_each_realtime_cpu(_cpu) {
-		if (_cpu == cpu)
-			break;
-		xnlock_get_irqsave(&nklock, s);
-		sched = xnsched_struct(cpu);
-		xntimer_stop(&sched->htimer);
-		xnlock_put_irqrestore(&nklock, s);
-		ipipe_timer_stop(_cpu);
-	}
-
-#ifdef CONFIG_SMP
-	ipipe_free_irq(&cobalt_pipeline.domain,
-		       IPIPE_HRTIMER_IPI);
-#endif
-
-	return ret;
-}
-
-/**
- * @fn void pipeline_uninstall_tick_proxy(void)
- * @brief Release hardware timers.
- *
- * Releases hardware timers previously grabbed by a call to
- * pipeline_install_tick_proxy().
- *
- * @coretags{secondary-only}
- */
-void pipeline_uninstall_tick_proxy(void)
-{
-	int cpu;
-
-	/*
-	 * We must not hold the nklock while stopping the hardware
-	 * timer, since this could cause deadlock situations to arise
-	 * on SMP systems.
-	 */
-	for_each_realtime_cpu(cpu)
-		ipipe_timer_stop(cpu);
-
-#ifdef CONFIG_SMP
-	ipipe_free_irq(&cobalt_pipeline.domain,
-		       IPIPE_HRTIMER_IPI);
-#endif
-
-#ifdef CONFIG_XENO_OPT_STATS_IRQS
-	xnintr_destroy(&nktimer);
-#endif /* CONFIG_XENO_OPT_STATS_IRQS */
-}
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 11aa72fc41..ca869f19a4 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -147,7 +147,7 @@ generate_patch() {
 }
 
 
-usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>]|[--ipipe=<ipipe-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
+usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
 me=`basename $0`
 
 while test $# -gt 0; do
@@ -156,26 +156,11 @@ while test $# -gt 0; do
 	linux_tree=`echo $1|sed -e 's,^--linux=\\(.*\\)$,\\1,g'`
 	linux_tree=`eval "echo $linux_tree"`
 	;;
-    --adeos=*)
-	pipeline_patch=`echo $1|sed -e 's,^--adeos=\\(.*\\)$,\\1,g'`
-	pipeline_patch=`eval "echo $pipeline_patch"`
-	probe_header=include/linux/ipipe.h
-	arch_probe_header=include/asm/ipipe.h
-	pipeline_type=ipipe
-	;;
-    --ipipe=*)
-	pipeline_patch=`echo $1|sed -e 's,^--ipipe=\\(.*\\)$,\\1,g'`
-	pipeline_patch=`eval "echo $pipeline_patch"`
-	probe_header=include/linux/ipipe.h
-	arch_probe_header=include/asm/ipipe.h
-	pipeline_type=ipipe
-	;;
     --dovetail=*)
 	pipeline_patch=`echo $1|sed -e 's,^--dovetail=\\(.*\\)$,\\1,g'`
 	pipeline_patch=`eval "echo $pipeline_patch"`
 	probe_header=include/linux/dovetail.h
 	arch_probe_header=include/asm/dovetail.h
-	pipeline_type=dovetail
 	;;
     --arch=*)
 	linux_arch=`echo $1|sed -e 's,^--arch=\\(.*\\)$,\\1,g'`
@@ -315,18 +300,6 @@ eval linux_`grep '^VERSION =' $linux_tree/Makefile | sed -e 's, ,,g'`
 
 linux_version="$linux_VERSION.$linux_PATCHLEVEL.$linux_SUBLEVEL"
 
-if test x$pipeline_type = x; then
-    if test -r $linux_tree/include/linux/ipipe.h; then
-	probe_header=include/linux/ipipe.h
-	arch_probe_header=include/asm/ipipe.h
-	pipeline_type=ipipe
-    elif test -r $linux_tree/include/linux/dovetail.h; then
-	probe_header=include/linux/dovetail.h
-	arch_probe_header=include/asm/dovetail.h
-	pipeline_type=dovetail
-    fi
-fi
-
 if test x$verbose = x1; then
 echo "Preparing kernel $linux_version$linux_EXTRAVERSION in $linux_tree..."
 fi
@@ -404,9 +377,9 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
 
     if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
-	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/arch/\$(SRCARCH)/xenomai/$pipeline_type/include -I\$(srctree)/include/xenomai"
+	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/arch/\$(SRCARCH)/xenomai/dovetail/include -I\$(srctree)/include/xenomai"
 	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
-	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/$pipeline_type/"
+	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/dovetail/"
 	echo $p | patch_append arch/$linux_arch/Makefile
     fi
 
@@ -432,7 +405,7 @@ esac
 patch_kernelversion_specific="n"
 patch_architecture_specific="y"
 patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
-patch_link n n kernel/cobalt/include/$pipeline_type arch/$linux_arch/include/$pipeline_type
+patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/dovetail
 patch_architecture_specific="n"
 patch_link n m kernel/cobalt kernel/xenomai
 patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
@@ -442,11 +415,11 @@ patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xen
 patch_link r n kernel/cobalt/include/linux/xenomai include/linux/xenomai
 patch_link n m kernel/cobalt/posix kernel/xenomai/posix
 patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
-patch_link n m kernel/cobalt/$pipeline_type kernel/xenomai/pipeline
+patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
 patch_link r m kernel/drivers drivers/xenomai
 patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
 patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
-patch_link r n include/cobalt/kernel/$pipeline_type/pipeline include/xenomai/pipeline
+patch_link r n include/cobalt/kernel/dovetail/pipeline include/xenomai/pipeline
 patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
 patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
 patch_link n version.h include/xenomai include/xenomai
diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index 9f60e90bb3..a093779b96 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -75,9 +75,6 @@ dump_info ()
     echo "Xenomai version: ${version}"
     uname -a 2>/dev/null || echo "Cannot determine system information (uname?)"
     echo "Kernel parameters: `cat /proc/cmdline`"
-    if test -r /proc/ipipe/version; then
-	echo "I-pipe release #`cat /proc/ipipe/version` detected"
-    fi
     if test -r /proc/xenomai/version; then
 	echo "Cobalt core `cat /proc/xenomai/version` detected"
     else
-- 
2.31.1


