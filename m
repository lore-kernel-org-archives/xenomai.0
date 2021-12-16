Subject: [PATCH 5/5] cobalt: Fold dovetail directory in arch-specific sections
References: <cover.1639669704.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <70c6c9d7-32b5-4a23-260b-dc9736462d13@siemens.com>
Date: Thu, 16 Dec 2021 16:52:03 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1639669704.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

There is no other pipeline variant anymore.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/arm/{dovetail => }/Makefile            | 0
 .../arm/{dovetail => }/include/asm/xenomai/calibration.h  | 6 +++---
 .../arm/{dovetail => }/include/asm/xenomai/features.h     | 6 +++---
 .../arch/arm/{dovetail => }/include/asm/xenomai/fptest.h  | 6 +++---
 .../arch/arm/{dovetail => }/include/asm/xenomai/machine.h | 6 +++---
 .../arch/arm/{dovetail => }/include/asm/xenomai/syscall.h | 6 +++---
 .../arm/{dovetail => }/include/asm/xenomai/syscall32.h    | 0
 .../arch/arm/{dovetail => }/include/asm/xenomai/thread.h  | 8 ++++----
 kernel/cobalt/arch/arm/{dovetail => }/machine.c           | 0
 kernel/cobalt/arch/arm64/{dovetail => }/Makefile          | 0
 .../{dovetail => }/include/asm/xenomai/calibration.h      | 6 +++---
 .../arm64/{dovetail => }/include/asm/xenomai/features.h   | 6 +++---
 .../arm64/{dovetail => }/include/asm/xenomai/fptest.h     | 6 +++---
 .../arm64/{dovetail => }/include/asm/xenomai/machine.h    | 6 +++---
 .../arm64/{dovetail => }/include/asm/xenomai/syscall.h    | 6 +++---
 .../arm64/{dovetail => }/include/asm/xenomai/syscall32.h  | 6 +++---
 .../arm64/{dovetail => }/include/asm/xenomai/thread.h     | 8 ++++----
 kernel/cobalt/arch/arm64/{dovetail => }/machine.c         | 0
 kernel/cobalt/arch/x86/{dovetail => }/Makefile            | 0
 kernel/cobalt/arch/x86/{dovetail => }/c1e.c               | 0
 .../x86/{dovetail => }/include/asm/xenomai/calibration.h  | 0
 .../arch/x86/{dovetail => }/include/asm/xenomai/fptest.h  | 0
 .../arch/x86/{dovetail => }/include/asm/xenomai/machine.h | 0
 .../arch/x86/{dovetail => }/include/asm/xenomai/syscall.h | 0
 .../arch/x86/{dovetail => }/include/asm/xenomai/thread.h  | 2 +-
 kernel/cobalt/arch/x86/{dovetail => }/machine.c           | 0
 kernel/cobalt/arch/x86/{dovetail => }/smi.c               | 0
 .../include/asm-generic/xenomai/{dovetail => }/thread.h   | 6 +++---
 scripts/prepare-kernel.sh                                 | 4 ++--
 29 files changed, 47 insertions(+), 47 deletions(-)
 rename kernel/cobalt/arch/arm/{dovetail => }/Makefile (100%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/calibration.h (90%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/features.h (88%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/fptest.h (91%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/machine.h (92%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/syscall.h (96%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/syscall32.h (100%)
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/thread.h (86%)
 rename kernel/cobalt/arch/arm/{dovetail => }/machine.c (100%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/Makefile (100%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/calibration.h (79%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/features.h (64%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/fptest.h (79%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/machine.h (82%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/syscall.h (92%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/syscall32.h (52%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/thread.h (75%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/machine.c (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/Makefile (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/c1e.c (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/calibration.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/fptest.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/machine.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/syscall.h (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/include/asm/xenomai/thread.h (96%)
 rename kernel/cobalt/arch/x86/{dovetail => }/machine.c (100%)
 rename kernel/cobalt/arch/x86/{dovetail => }/smi.c (100%)
 rename kernel/cobalt/include/asm-generic/xenomai/{dovetail => }/thread.h (78%)

diff --git a/kernel/cobalt/arch/arm/dovetail/Makefile b/kernel/cobalt/arch/arm/Makefile
similarity index 100%
rename from kernel/cobalt/arch/arm/dovetail/Makefile
rename to kernel/cobalt/arch/arm/Makefile
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm/include/asm/xenomai/calibration.h
similarity index 90%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/calibration.h
index 3cf58259b1..be4267ca35 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/calibration.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/calibration.h
@@ -19,8 +19,8 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#ifndef _COBALT_ARM_DOVETAIL_CALIBRATION_H
-#define _COBALT_ARM_DOVETAIL_CALIBRATION_H
+#ifndef _COBALT_ARM_CALIBRATION_H
+#define _COBALT_ARM_CALIBRATION_H
 
 static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 {
@@ -37,4 +37,4 @@ static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
 }
 
-#endif /* !_COBALT_ARM_DOVETAIL_CALIBRATION_H */
+#endif /* !_COBALT_ARM_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm/include/asm/xenomai/features.h
similarity index 88%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/features.h
index 9c0af20e74..4ed607b625 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/features.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/features.h
@@ -19,12 +19,12 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#ifndef _COBALT_ARM_DOVETAIL_FEATURES_H
-#define _COBALT_ARM_DOVETAIL_FEATURES_H
+#ifndef _COBALT_ARM_FEATURES_H
+#define _COBALT_ARM_FEATURES_H
 
 struct cobalt_featinfo;
 static inline void collect_arch_features(struct cobalt_featinfo *p) { }
 
 #include <asm/xenomai/uapi/features.h>
 
-#endif /* !_COBALT_ARM_DOVETAIL_FEATURES_H */
+#endif /* !_COBALT_ARM_FEATURES_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
similarity index 91%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
index ad7814cced..ca1752206f 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/fptest.h
@@ -16,8 +16,8 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#ifndef _COBALT_ARM_DOVETAIL_FPTEST_H
-#define _COBALT_ARM_DOVETAIL_FPTEST_H
+#ifndef _COBALT_ARM_FPTEST_H
+#define _COBALT_ARM_FPTEST_H
 
 #include <linux/errno.h>
 #include <asm/hwcap.h>
@@ -49,4 +49,4 @@ static inline int fp_detect(void)
 	return have_vfp ? __COBALT_HAVE_VFP : 0;
 }
 
-#endif /* _COBALT_ARM_DOVETAIL_FPTEST_H */
+#endif /* _COBALT_ARM_FPTEST_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm/include/asm/xenomai/machine.h
similarity index 92%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/machine.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/machine.h
index a694a7891b..56564c7f03 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/machine.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/machine.h
@@ -20,8 +20,8 @@
  *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  *   02111-1307, USA.
  */
-#ifndef _COBALT_ARM_DOVETAIL_MACHINE_H
-#define _COBALT_ARM_DOVETAIL_MACHINE_H
+#ifndef _COBALT_ARM_MACHINE_H
+#define _COBALT_ARM_MACHINE_H
 
 #include <linux/version.h>
 #include <asm/byteorder.h>
@@ -69,4 +69,4 @@ static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
 
 #include <asm-generic/xenomai/machine.h>
 
-#endif /* !_COBALT_ARM_DOVETAIL_MACHINE_H */
+#endif /* !_COBALT_ARM_MACHINE_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
similarity index 96%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index d41b257681..2490e7fe81 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -19,8 +19,8 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#ifndef _COBALT_ARM_DOVETAIL_SYSCALL_H
-#define _COBALT_ARM_DOVETAIL_SYSCALL_H
+#ifndef _COBALT_ARM_SYSCALL_H
+#define _COBALT_ARM_SYSCALL_H
 
 #include <linux/errno.h>
 #include <linux/uaccess.h>
@@ -98,4 +98,4 @@ static inline void pipeline_get_syscall_args(struct task_struct *task,
 	args[4] = regs->ARM_r5;
 }
 
-#endif /* !_COBALT_ARM_DOVETAIL_SYSCALL_H */
+#endif /* !_COBALT_ARM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h
similarity index 100%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall32.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/syscall32.h
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
similarity index 86%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
index 792a3d26c1..d9eed665f9 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/thread.h
@@ -16,10 +16,10 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
  * 02111-1307, USA.
  */
-#ifndef _COBALT_ARM_DOVETAIL_THREAD_H
-#define _COBALT_ARM_DOVETAIL_THREAD_H
+#ifndef _COBALT_ARM_THREAD_H
+#define _COBALT_ARM_THREAD_H
 
-#include <asm-generic/xenomai/dovetail/thread.h>
+#include <asm-generic/xenomai/thread.h>
 #include <asm/traps.h>
 
 #define xnarch_fault_pc(__regs)	((__regs)->ARM_pc - (thumb_mode(__regs) ? 2 : 4))
@@ -29,4 +29,4 @@
 						(__nr) == ARM_TRAP_UNDEFINSTR))
 #define xnarch_fault_notify(__nr) (!xnarch_fault_bp_p(__nr))
 
-#endif /* !_COBALT_ARM_DOVETAIL_THREAD_H */
+#endif /* !_COBALT_ARM_THREAD_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/machine.c b/kernel/cobalt/arch/arm/machine.c
similarity index 100%
rename from kernel/cobalt/arch/arm/dovetail/machine.c
rename to kernel/cobalt/arch/arm/machine.c
diff --git a/kernel/cobalt/arch/arm64/dovetail/Makefile b/kernel/cobalt/arch/arm64/Makefile
similarity index 100%
rename from kernel/cobalt/arch/arm64/dovetail/Makefile
rename to kernel/cobalt/arch/arm64/Makefile
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/calibration.h
similarity index 79%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/calibration.h
index cd9496b66c..461198c6f0 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/calibration.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/calibration.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2015 Philippe Gerum  <rpm@xenomai.org>
  */
 
-#ifndef _COBALT_ARM64_DOVETAIL_CALIBRATION_H
-#define _COBALT_ARM64_DOVETAIL_CALIBRATION_H
+#ifndef _COBALT_ARM64_CALIBRATION_H
+#define _COBALT_ARM64_CALIBRATION_H
 
 static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 {
@@ -22,4 +22,4 @@ static inline void xnarch_get_latencies(struct xnclock_gravity *p)
 	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
 }
 
-#endif /* !_COBALT_ARM64_DOVETAIL_CALIBRATION_H */
+#endif /* !_COBALT_ARM64_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/features.h
similarity index 64%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/features.h
index d5a438bab1..796fc5d825 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/features.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/features.h
@@ -4,12 +4,12 @@
  * Copyright (C) 2015 Philippe Gerum  <rpm@xenomai.org>
  */
 
-#ifndef _COBALT_ARM64_DOVETAIL_FEATURES_H
-#define _COBALT_ARM64_DOVETAIL_FEATURES_H
+#ifndef _COBALT_ARM64_FEATURES_H
+#define _COBALT_ARM64_FEATURES_H
 
 struct cobalt_featinfo;
 static inline void collect_arch_features(struct cobalt_featinfo *p) { }
 
 #include <asm/xenomai/uapi/features.h>
 
-#endif /* !_COBALT_ARM64_DOVETAIL_FEATURES_H */
+#endif /* !_COBALT_ARM64_FEATURES_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
similarity index 79%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
index 5f3630ddae..bc9dc342e2 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/fptest.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
  */
 
-#ifndef _COBALT_ARM64_DOVETAIL_FPTEST_H
-#define _COBALT_ARM64_DOVETAIL_FPTEST_H
+#ifndef _COBALT_ARM64_FPTEST_H
+#define _COBALT_ARM64_FPTEST_H
 
 #include <linux/errno.h>
 #include <asm/xenomai/uapi/fptest.h>
@@ -32,4 +32,4 @@ static inline int fp_detect(void)
 	return have_fp ? __COBALT_HAVE_FPU : 0;
 }
 
-#endif /* !_COBALT_ARM64_DOVETAIL_FPTEST_H */
+#endif /* !_COBALT_ARM64_FPTEST_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
similarity index 82%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
index e71a5b7e35..c9b515cddb 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/machine.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/machine.h
@@ -4,8 +4,8 @@
  * Copyright (C) 2015 Dmitriy Cherkasov <dmitriy@mperpetuo.com>
  */
 
-#ifndef _COBALT_ARM64_DOVETAIL_MACHINE_H
-#define _COBALT_ARM64_DOVETAIL_MACHINE_H
+#ifndef _COBALT_ARM64_MACHINE_H
+#define _COBALT_ARM64_MACHINE_H
 
 #include <linux/version.h>
 #include <asm/byteorder.h>
@@ -30,4 +30,4 @@ static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
 
 #include <asm-generic/xenomai/machine.h>
 
-#endif /* !_COBALT_ARM64_DOVETAIL_MACHINE_H */
+#endif /* !_COBALT_ARM64_MACHINE_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
similarity index 92%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
index 96871e2473..0f1d1eaf8d 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall.h
@@ -5,8 +5,8 @@
  * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
  */
 
-#ifndef _COBALT_ARM64_DOVETAIL_SYSCALL_H
-#define _COBALT_ARM64_DOVETAIL_SYSCALL_H
+#ifndef _COBALT_ARM64_SYSCALL_H
+#define _COBALT_ARM64_SYSCALL_H
 
 #include <linux/errno.h>
 #include <linux/uaccess.h>
@@ -60,4 +60,4 @@ int xnarch_local_syscall(unsigned long a1, unsigned long a2,
 	return -ENOSYS;
 }
 
-#endif /* !_COBALT_ARM64_DOVETAIL_SYSCALL_H */
+#endif /* !_COBALT_ARM64_SYSCALL_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
similarity index 52%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
index cd0f392459..13aa8a7610 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/syscall32.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/syscall32.h
@@ -4,9 +4,9 @@
  * Copyright (C) 2014 Philippe Gerum  <rpm@xenomai.org>
  */
 
-#ifndef _COBALT_ARM64_DOVETAIL_SYSCALL32_H
-#define _COBALT_ARM64_DOVETAIL_SYSCALL32_H
+#ifndef _COBALT_ARM64_SYSCALL32_H
+#define _COBALT_ARM64_SYSCALL32_H
 
 #include <asm-generic/xenomai/syscall32.h>
 
-#endif /* !_COBALT_ARM64_DOVETAIL_SYSCALL32_H */
+#endif /* !_COBALT_ARM64_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h
similarity index 75%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h
index 5b60ff34a2..467304b1f6 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/thread.h
@@ -5,10 +5,10 @@
  * Copyright (C) 2021 Philippe Gerum  <rpm@xenomai.org>
  */
 
-#ifndef _COBALT_ARM64_DOVETAIL_THREAD_H
-#define _COBALT_ARM64_DOVETAIL_THREAD_H
+#ifndef _COBALT_ARM64_THREAD_H
+#define _COBALT_ARM64_THREAD_H
 
-#include <asm-generic/xenomai/dovetail/thread.h>
+#include <asm-generic/xenomai/thread.h>
 #include <asm/dovetail.h>
 
 #define xnarch_fault_pc(__regs)	((unsigned long)((__regs)->pc - 4)) /* XXX ? */
@@ -19,4 +19,4 @@
 
 #define xnarch_fault_notify(__nr) (!xnarch_fault_bp_p(__nr))
 
-#endif /* !_COBALT_ARM64_DOVETAIL_THREAD_H */
+#endif /* !_COBALT_ARM64_THREAD_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/machine.c b/kernel/cobalt/arch/arm64/machine.c
similarity index 100%
rename from kernel/cobalt/arch/arm64/dovetail/machine.c
rename to kernel/cobalt/arch/arm64/machine.c
diff --git a/kernel/cobalt/arch/x86/dovetail/Makefile b/kernel/cobalt/arch/x86/Makefile
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/Makefile
rename to kernel/cobalt/arch/x86/Makefile
diff --git a/kernel/cobalt/arch/x86/dovetail/c1e.c b/kernel/cobalt/arch/x86/c1e.c
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/c1e.c
rename to kernel/cobalt/arch/x86/c1e.c
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/x86/include/asm/xenomai/calibration.h
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/calibration.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/calibration.h
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/fptest.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/fptest.h
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/machine.h b/kernel/cobalt/arch/x86/include/asm/xenomai/machine.h
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/machine.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/machine.h
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
similarity index 96%
rename from kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
rename to kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
index 6eb71e2a80..745c32467e 100644
--- a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/thread.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/thread.h
@@ -20,7 +20,7 @@
 #ifndef _COBALT_X86_ASM_THREAD_H
 #define _COBALT_X86_ASM_THREAD_H
 
-#include <asm-generic/xenomai/dovetail/thread.h>
+#include <asm-generic/xenomai/thread.h>
 #include <asm/traps.h>
 
 #define xnarch_fault_pc(__regs)		((__regs)->ip)
diff --git a/kernel/cobalt/arch/x86/dovetail/machine.c b/kernel/cobalt/arch/x86/machine.c
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/machine.c
rename to kernel/cobalt/arch/x86/machine.c
diff --git a/kernel/cobalt/arch/x86/dovetail/smi.c b/kernel/cobalt/arch/x86/smi.c
similarity index 100%
rename from kernel/cobalt/arch/x86/dovetail/smi.c
rename to kernel/cobalt/arch/x86/smi.c
diff --git a/kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h b/kernel/cobalt/include/asm-generic/xenomai/thread.h
similarity index 78%
rename from kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h
rename to kernel/cobalt/include/asm-generic/xenomai/thread.h
index 8939e45f30..3881917bd9 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/dovetail/thread.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/thread.h
@@ -6,8 +6,8 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-#ifndef _COBALT_ASM_GENERIC_DOVETAIL_THREAD_H
-#define _COBALT_ASM_GENERIC_DOVETAIL_THREAD_H
+#ifndef _COBALT_ASM_GENERIC_THREAD_H
+#define _COBALT_ASM_GENERIC_THREAD_H
 
 #include <linux/dovetail.h>
 
@@ -21,4 +21,4 @@ struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
 	return tcb->altsched.task;
 }
 
-#endif /* !_COBALT_ASM_GENERIC_DOVETAIL_THREAD_H */
+#endif /* !_COBALT_ASM_GENERIC_THREAD_H */
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 9a78f0ec4d..c9aeeb4fad 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -377,9 +377,9 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
 
     if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
-	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/arch/\$(SRCARCH)/xenomai/dovetail/include -I\$(srctree)/include/xenomai"
+	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
 	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
-	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/dovetail/"
+	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
 	echo $p | patch_append arch/$linux_arch/Makefile
     fi
 
-- 
2.31.1


