From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/5] cobalt: Drop wrappings for kernels < 5.10
Date: Thu, 16 Dec 2021 16:48:24 +0100
Message-ID: <0537ba93cdb3bdab8a95a6343f09bc1cd5fd0774.1639669704.git.jan.kiszka@siemens.com>
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

This massively reduces our wrappings and also allows to consolidate
related headers and modules. linux/xenomai/wrappers.h, rtdm/wrappers.c
and pipeline/wrappers.h are removed completely. mmiowb(),
cobalt_gpiochip_dev, cobalt_get_restart_block, read_file_from_kernel no
longer vary and are folded into the callers. access_rok and access_wok
are simply replaced by access_ok.

We keep DEFINE_PROC_OPS as it simplifies the usage.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../kernel/dovetail/pipeline/wrappers.h       |   9 -
 include/cobalt/kernel/rtdm/driver.h           |   4 +-
 .../include/asm/xenomai/wrappers.h            |   3 -
 .../include/asm/xenomai/wrappers.h            |   3 -
 .../arch/x86/include/asm/xenomai/wrappers.h   |  40 ----
 kernel/cobalt/debug.c                         |   1 +
 .../include/asm-generic/xenomai/syscall.h     |  14 +-
 .../include/asm-generic/xenomai/wrappers.h    | 186 +-----------------
 .../cobalt/include/linux/xenomai/wrappers.h   |  44 -----
 kernel/cobalt/pipe.c                          |   5 +-
 kernel/cobalt/posix/clock.c                   |   4 +-
 kernel/cobalt/posix/compat.c                  |  24 +--
 kernel/cobalt/posix/io.c                      |  10 +-
 kernel/cobalt/posix/mqueue.c                  |   4 +-
 kernel/cobalt/posix/process.c                 |   3 +-
 kernel/cobalt/posix/signal.c                  |   2 +-
 kernel/cobalt/posix/syscall32.c               |   2 +-
 kernel/cobalt/posix/timerfd.c                 |   2 +-
 kernel/cobalt/rtdm/Makefile                   |   3 +-
 kernel/cobalt/rtdm/wrappers.c                 | 106 ----------
 kernel/cobalt/thread.c                        |   1 +
 .../analogy/national_instruments/mio_common.c |   2 -
 .../analogy/national_instruments/mite.c       |   3 -
 .../analogy/national_instruments/ni_660x.c    |   2 -
 .../analogy/national_instruments/tio_common.c |   1 -
 kernel/drivers/gpio/gpio-core.c               |   2 +-
 kernel/drivers/ipc/rtipc.c                    |   2 +-
 kernel/drivers/net/addons/proxy.c             |   3 -
 kernel/drivers/net/drivers/e1000e/netdev.c    |  27 ---
 .../drivers/experimental/e1000/e1000_main.c   |   3 -
 .../net/drivers/experimental/e1000/kcompat.h  |   8 -
 .../drivers/net/drivers/freescale/fec_main.c  |  21 --
 kernel/drivers/net/drivers/igb/igb_main.c     |  31 ---
 kernel/drivers/net/drivers/r8169.c            |   4 -
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  |   6 +-
 kernel/drivers/net/stack/rtdev.c              |   4 -
 scripts/prepare-kernel.sh                     |   1 -
 37 files changed, 43 insertions(+), 547 deletions(-)
 delete mode 100644 include/cobalt/kernel/dovetail/pipeline/wrappers.h
 rename kernel/cobalt/arch/arm/{dovetail => }/include/asm/xenomai/wrappers.h (92%)
 rename kernel/cobalt/arch/arm64/{dovetail => }/include/asm/xenomai/wrappers.h (78%)
 delete mode 100644 kernel/cobalt/include/linux/xenomai/wrappers.h
 delete mode 100644 kernel/cobalt/rtdm/wrappers.c

diff --git a/include/cobalt/kernel/dovetail/pipeline/wrappers.h b/include/cobalt/kernel/dovetail/pipeline/wrappers.h
deleted file mode 100644
index 133aacac3f..0000000000
--- a/include/cobalt/kernel/dovetail/pipeline/wrappers.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0
- */
-#ifndef _COBALT_KERNEL_DOVETAIL_WRAPPERS_H
-#define _COBALT_KERNEL_DOVETAIL_WRAPPERS_H
-
-/* No wrapper needed so far. */
-
-#endif /* !_COBALT_KERNEL_DOVETAIL_WRAPPERS_H */
diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 2a68c3e920..930da34ed1 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1272,13 +1272,13 @@ int rtdm_munmap(void *ptr, size_t len);
 static inline int rtdm_read_user_ok(struct rtdm_fd *fd,
 				    const void __user *ptr, size_t size)
 {
-	return access_rok(ptr, size);
+	return access_ok(ptr, size);
 }
 
 static inline int rtdm_rw_user_ok(struct rtdm_fd *fd,
 				  const void __user *ptr, size_t size)
 {
-	return access_wok(ptr, size);
+	return access_ok(ptr, size);
 }
 
 static inline int rtdm_copy_from_user(struct rtdm_fd *fd,
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm/include/asm/xenomai/wrappers.h
similarity index 92%
rename from kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h
rename to kernel/cobalt/arch/arm/include/asm/xenomai/wrappers.h
index fe598966cd..baab5a3b5a 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/wrappers.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/wrappers.h
@@ -21,7 +21,4 @@
 
 #include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
 
-#define __put_user_inatomic __put_user
-#define __get_user_inatomic __get_user
-
 #endif /* _COBALT_ARM_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/arm64/include/asm/xenomai/wrappers.h
similarity index 78%
rename from kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h
rename to kernel/cobalt/arch/arm64/include/asm/xenomai/wrappers.h
index 7a1122fd30..61fcfaf592 100644
--- a/kernel/cobalt/arch/arm64/dovetail/include/asm/xenomai/wrappers.h
+++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/wrappers.h
@@ -9,7 +9,4 @@
 
 #include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
 
-#define __put_user_inatomic __put_user
-#define __get_user_inatomic __get_user
-
 #endif /* _COBALT_ARM64_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
index a4cc368a56..c9263cbc08 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/wrappers.h
@@ -21,44 +21,4 @@
 
 #include <asm-generic/xenomai/wrappers.h> /* Read the generic portion. */
 
-#define __get_user_inatomic __get_user
-#define __put_user_inatomic __put_user
-
-#if LINUX_VERSION_CODE > KERNEL_VERSION(4,9,108) && \
-    LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
-#define IPIPE_X86_FPU_EAGER
-#endif
-#if LINUX_VERSION_CODE > KERNEL_VERSION(4,4,137) && \
-    LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
-#define IPIPE_X86_FPU_EAGER
-#endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
-#define IPIPE_X86_FPU_EAGER
-#endif
-
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
-#include <asm/i387.h>
-#include <asm/fpu-internal.h>
-#else
-#include <asm/fpu/internal.h>
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)
-
-static inline void kernel_fpu_disable(void)
-{
-	__thread_clear_has_fpu(current);
-}
-
-static inline void kernel_fpu_enable(void)
-{
-}
-
-static inline bool kernel_fpu_disabled(void)
-{
-	return __thread_has_fpu(current) == 0 && (read_cr0() & X86_CR0_TS) == 0;
-}
-#endif /* linux < 4.1.0 */
-
 #endif /* _COBALT_X86_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index a6e2cc42d3..e8458855a6 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/signal.h>
 #include <linux/vmalloc.h>
+#include <linux/sched/mm.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/clock.h>
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 117bb3ff8a..70b3e68f97 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -28,14 +28,6 @@
 #include <cobalt/uapi/asm-generic/syscall.h>
 #include <cobalt/uapi/kernel/types.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 0, 0)
-#define access_rok(addr, size)	access_ok((addr), (size))
-#define access_wok(addr, size)	access_ok((addr), (size))
-#else
-#define access_rok(addr, size)	access_ok(VERIFY_READ, (addr), (size))
-#define access_wok(addr, size)	access_ok(VERIFY_WRITE, (addr), (size))
-#endif
-
 #define __xn_copy_from_user(dstP, srcP, n)	raw_copy_from_user(dstP, srcP, n)
 #define __xn_copy_to_user(dstP, srcP, n)	raw_copy_to_user(dstP, srcP, n)
 #define __xn_put_user(src, dstP)		__put_user(src, dstP)
@@ -47,7 +39,7 @@ static inline int cobalt_copy_from_user(void *dst, const void __user *src,
 {
 	size_t remaining = size;
 
-	if (likely(access_rok(src, size)))
+	if (likely(access_ok(src, size)))
 		remaining = __xn_copy_from_user(dst, src, size);
 
 	if (unlikely(remaining > 0)) {
@@ -60,7 +52,7 @@ static inline int cobalt_copy_from_user(void *dst, const void __user *src,
 static inline int cobalt_copy_to_user(void __user *dst, const void *src,
 				      size_t size)
 {
-	if (unlikely(!access_wok(dst, size) ||
+	if (unlikely(!access_ok(dst, size) ||
 	    __xn_copy_to_user(dst, src, size)))
 		return -EFAULT;
 	return 0;
@@ -69,7 +61,7 @@ static inline int cobalt_copy_to_user(void __user *dst, const void *src,
 static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
 					   size_t count)
 {
-	if (unlikely(!access_rok(src, 1)))
+	if (unlikely(!access_ok(src, 1)))
 		return -EFAULT;
 
 	return __xn_strncpy_from_user(dst, src, count);
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 414469c3a5..ff9f2c37cc 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -18,7 +18,7 @@
  */
 #ifndef _COBALT_ASM_GENERIC_WRAPPERS_H
 
-#include <linux/xenomai/wrappers.h>
+#include <linux/version.h>
 
 #define COBALT_BACKPORT(__sym) __cobalt_backport_ ##__sym
 
@@ -34,159 +34,6 @@
  *   symbol, so that obsolete wrappers can be spotted.
  */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
-#define raw_copy_to_user(__to, __from, __n)	__copy_to_user_inatomic(__to, __from, __n)
-#define raw_copy_from_user(__to, __from, __n)	__copy_from_user_inatomic(__to, __from, __n)
-#define raw_put_user(__from, __to)		__put_user_inatomic(__from, __to)
-#define raw_get_user(__to, __from)		__get_user_inatomic(__to, __from)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
-#define in_ia32_syscall() (current_thread_info()->status & TS_COMPAT)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
-#define cobalt_gpiochip_dev(__gc)	((__gc)->dev)
-#else
-#define cobalt_gpiochip_dev(__gc)	((__gc)->parent)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)
-#define cobalt_get_restart_block(p)	(&task_thread_info(p)->restart_block)
-#else
-#define cobalt_get_restart_block(p)	(&(p)->restart_block)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
-#define user_msghdr msghdr
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
-#include <linux/netdevice.h>
-
-#undef alloc_netdev
-#define alloc_netdev(sizeof_priv, name, name_assign_type, setup) \
-	alloc_netdev_mqs(sizeof_priv, name, setup, 1, 1)
- 
-#include <linux/trace_seq.h>
-
-static inline unsigned char *
-trace_seq_buffer_ptr(struct trace_seq *s)
-{
-	return s->buffer + s->len;
-}
-
-#endif /* < 3.17 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
-#define smp_mb__before_atomic()  smp_mb()
-#define smp_mb__after_atomic()   smp_mb()
-#endif /* < 3.16 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
-#define raw_cpu_ptr(v)	__this_cpu_ptr(v)
-#endif /* < 3.15 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
-#include <linux/pci.h>
-
-#ifdef CONFIG_PCI
-#define pci_enable_msix_range COBALT_BACKPORT(pci_enable_msix_range)
-#ifdef CONFIG_PCI_MSI
-int pci_enable_msix_range(struct pci_dev *dev,
-			  struct msix_entry *entries,
-			  int minvec, int maxvec);
-#else /* !CONFIG_PCI_MSI */
-static inline
-int pci_enable_msix_range(struct pci_dev *dev,
-			  struct msix_entry *entries,
-			  int minvec, int maxvec)
-{
-	return -ENOSYS;
-}
-#endif /* !CONFIG_PCI_MSI */
-#endif /* CONFIG_PCI */
-#endif /* < 3.14 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
-#include <linux/dma-mapping.h>
-#include <linux/hwmon.h>
-
-#define dma_set_mask_and_coherent COBALT_BACKPORT(dma_set_mask_and_coherent)
-static inline
-int dma_set_mask_and_coherent(struct device *dev, u64 mask)
-{
-	int rc = dma_set_mask(dev, mask);
-	if (rc == 0)
-		dma_set_coherent_mask(dev, mask);
-	return rc;
-}
-
-#ifdef CONFIG_HWMON
-#define hwmon_device_register_with_groups \
-	COBALT_BACKPORT(hwmon_device_register_with_groups)
-struct device *
-hwmon_device_register_with_groups(struct device *dev, const char *name,
-				void *drvdata,
-				const struct attribute_group **groups);
-
-#define devm_hwmon_device_register_with_groups \
-	COBALT_BACKPORT(devm_hwmon_device_register_with_groups)
-struct device *
-devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
-				void *drvdata,
-				const struct attribute_group **groups);
-#endif /* !CONFIG_HWMON */
-
-#define reinit_completion(__x)	INIT_COMPLETION(*(__x))
-
-#endif /* < 3.13 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
-#define DEVICE_ATTR_RW(_name)	__ATTR_RW(_name)
-#define DEVICE_ATTR_RO(_name)	__ATTR_RO(_name)
-#define DEVICE_ATTR_WO(_name)	__ATTR_WO(_name)
-#endif /* < 3.11 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
-#error "Xenomai/cobalt requires Linux kernel 3.10 or above"
-#endif /* < 3.10 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,0,0)
-#define __kernel_timex		timex
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,1,0)
-#define old_timex32		compat_timex
-#define SO_RCVTIMEO_OLD		SO_RCVTIMEO
-#define SO_SNDTIMEO_OLD		SO_SNDTIMEO
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
-#define mmiowb()		do { } while (0)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
-#define __kernel_old_timeval	timeval
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
-#define mmap_read_lock(__mm)	down_read(&mm->mmap_sem)
-#define mmap_read_unlock(__mm)	up_read(&mm->mmap_sem)
-#define mmap_write_lock(__mm)	down_write(&mm->mmap_sem)
-#define mmap_write_unlock(__mm)	up_write(&mm->mmap_sem)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,6,0)
-#define DEFINE_PROC_OPS(__name, __open, __release, __read, __write) \
-	struct file_operations __name = {			    \
-		.open = (__open),				    \
-		.release = (__release),				    \
-		.read = (__read),				    \
-		.write = (__write),				    \
-		.llseek = seq_lseek,				    \
-}
-#else
 #define DEFINE_PROC_OPS(__name, __open, __release, __read, __write)	\
 	struct proc_ops __name = {					\
 		.proc_open = (__open),					\
@@ -195,37 +42,6 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 		.proc_write = (__write),				\
 		.proc_lseek = seq_lseek,				\
 }
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,7,0)
-#define pci_aer_clear_nonfatal_status	pci_cleanup_aer_uncorrect_error_status
-#define old_timespec32    compat_timespec
-#define old_itimerspec32  compat_itimerspec
-#define old_timeval32     compat_timeval
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,9,0)
-#define read_file_from_kernel(__file, __buf, __buf_size, __file_size, __id) \
-	({								\
-		loff_t ___file_size;					\
-		int __ret;						\
-		__ret = kernel_read_file(__file, __buf, &___file_size,	\
-				__buf_size, __id);			\
-		(*__file_size) = ___file_size;				\
-		__ret;							\
-	})
-#else
-#define read_file_from_kernel(__file, __buf, __buf_size, __file_size, __id) \
-	kernel_read_file(__file, 0, __buf, __buf_size, __file_size, __id)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
-#if __has_attribute(__fallthrough__)
-# define fallthrough			__attribute__((__fallthrough__))
-#else
-# define fallthrough			do {} while (0)  /* fallthrough */
-#endif
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,11,0)
 #define IRQ_WORK_INIT(_func) (struct irq_work) {	\
diff --git a/kernel/cobalt/include/linux/xenomai/wrappers.h b/kernel/cobalt/include/linux/xenomai/wrappers.h
deleted file mode 100644
index 349123c4f8..0000000000
--- a/kernel/cobalt/include/linux/xenomai/wrappers.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright (C) 2017 Philippe Gerum <rpm@xenomai.org>.
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
-#ifndef _COBALT_LINUX_WRAPPERS_H
-#define _COBALT_LINUX_WRAPPERS_H
-
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 20, 0)
-#include <linux/signal.h>
-typedef siginfo_t kernel_siginfo_t;
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
-#include <linux/sched.h>
-#include <linux/sched/rt.h>
-#else
-#include <linux/sched.h>
-#include <linux/sched/signal.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/mm.h>
-#include <linux/sched/debug.h>
-#include <linux/sched/task_stack.h>
-#include <uapi/linux/sched/types.h>
-#endif
-
-#include <pipeline/wrappers.h>
-
-#endif /* !_COBALT_LINUX_WRAPPERS_H */
diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
index 17aca5df64..33181101a0 100644
--- a/kernel/cobalt/pipe.c
+++ b/kernel/cobalt/pipe.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/uaccess.h>
+#include <linux/compat.h>
 #include <asm/io.h>
 #include <asm/xenomai/syscall.h>
 #include <cobalt/kernel/sched.h>
@@ -798,7 +799,7 @@ static ssize_t xnpipe_read(struct file *file,
 	ssize_t ret;
 	spl_t s;
 
-	if (!access_wok(buf, count))
+	if (!access_ok(buf, count))
 		return -EFAULT;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -906,7 +907,7 @@ static ssize_t xnpipe_write(struct file *file,
 	if (count == 0)
 		return 0;
 
-	if (!access_rok(buf, count))
+	if (!access_ok(buf, count))
 		return -EFAULT;
 
 	xnlock_get_irqsave(&nklock, s);
diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 71d14db526..16cc8b20a6 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -323,7 +323,7 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 	if (xnthread_test_localinfo(cur, XNSYSRST)) {
 		xnthread_clear_localinfo(cur, XNSYSRST);
 
-		restart = cobalt_get_restart_block(current);
+		restart = &current->restart_block;
 
 		if (restart->fn != cobalt_restart_syscall_placeholder) {
 			if (rmt) {
@@ -346,7 +346,7 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
 
 	if (xnthread_test_info(cur, XNBREAK)) {
 		if (signal_pending(current)) {
-			restart = cobalt_get_restart_block(current);
+			restart = &current->restart_block;
 			restart->nanosleep.expires =
 				(flags & TIMER_ABSTIME) ? timeout :
 				    xntimer_get_timeout_stopped(&cur->rtimer);
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index 2ec46084c5..c7fc4fc331 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -27,7 +27,7 @@ int sys32_get_timespec(struct timespec64 *ts,
 {
 	struct old_timespec32 cts;
 
-	if (u_cts == NULL || !access_rok(u_cts, sizeof(*u_cts)))
+	if (u_cts == NULL || !access_ok(u_cts, sizeof(*u_cts)))
 		return -EFAULT;
 
 	if (__xn_get_user(cts.tv_sec, &u_cts->tv_sec) ||
@@ -46,7 +46,7 @@ int sys32_put_timespec(struct old_timespec32 __user *u_cts,
 {
 	struct old_timespec32 cts;
 
-	if (u_cts == NULL || !access_wok(u_cts, sizeof(*u_cts)))
+	if (u_cts == NULL || !access_ok(u_cts, sizeof(*u_cts)))
 		return -EFAULT;
 
 	cts.tv_sec = ts->tv_sec;
@@ -82,7 +82,7 @@ int sys32_get_timeval(struct __kernel_old_timeval *tv,
 		      const struct old_timeval32 __user *ctv)
 {
 	return (ctv == NULL ||
-		!access_rok(ctv, sizeof(*ctv)) ||
+		!access_ok(ctv, sizeof(*ctv)) ||
 		__xn_get_user(tv->tv_sec, &ctv->tv_sec) ||
 		__xn_get_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
 }
@@ -92,7 +92,7 @@ int sys32_put_timeval(struct old_timeval32 __user *ctv,
 		      const struct __kernel_old_timeval *tv)
 {
 	return (ctv == NULL ||
-		!access_wok(ctv, sizeof(*ctv)) ||
+		!access_ok(ctv, sizeof(*ctv)) ||
 		__xn_put_user(tv->tv_sec, &ctv->tv_sec) ||
 		__xn_put_user(tv->tv_usec, &ctv->tv_usec)) ? -EFAULT : 0;
 }
@@ -113,7 +113,7 @@ int sys32_get_timex(struct __kernel_timex *tx,
 	tx->time.tv_sec = time.tv_sec;
 	tx->time.tv_usec = time.tv_usec;
 
-	if (!access_rok(ctx, sizeof(*ctx)) ||
+	if (!access_ok(ctx, sizeof(*ctx)) ||
 	    __xn_get_user(tx->modes, &ctx->modes) ||
 	    __xn_get_user(tx->offset, &ctx->offset) ||
 	    __xn_get_user(tx->freq, &ctx->freq) ||
@@ -151,7 +151,7 @@ int sys32_put_timex(struct old_timex32 __user *ctx,
 	if (ret)
 		return ret;
 
-	if (!access_wok(ctx, sizeof(*ctx)) ||
+	if (!access_ok(ctx, sizeof(*ctx)) ||
 	    __xn_put_user(tx->modes, &ctx->modes) ||
 	    __xn_put_user(tx->offset, &ctx->offset) ||
 	    __xn_put_user(tx->freq, &ctx->freq) ||
@@ -181,7 +181,7 @@ int sys32_get_fdset(fd_set *fds, const compat_fd_set __user *cfds,
 {
 	int rdpos, wrpos, rdlim = cfdsize / sizeof(compat_ulong_t);
 
-	if (cfds == NULL || !access_rok(cfds, cfdsize))
+	if (cfds == NULL || !access_ok(cfds, cfdsize))
 		return -EFAULT;
 
 	for (rdpos = 0, wrpos = 0; rdpos < rdlim; rdpos++, wrpos++)
@@ -196,7 +196,7 @@ int sys32_put_fdset(compat_fd_set __user *cfds, const fd_set *fds,
 {
 	int rdpos, wrpos, wrlim = fdsize / sizeof(long);
 
-	if (cfds == NULL || !access_wok(cfds, wrlim * sizeof(compat_ulong_t)))
+	if (cfds == NULL || !access_ok(cfds, wrlim * sizeof(compat_ulong_t)))
 		return -EFAULT;
 
 	for (rdpos = 0, wrpos = 0; wrpos < wrlim; rdpos++, wrpos++)
@@ -440,7 +440,7 @@ int sys32_get_msghdr(struct user_msghdr *msg,
 	compat_uptr_t tmp1, tmp2, tmp3;
 
 	if (u_cmsg == NULL ||
-	    !access_rok(u_cmsg, sizeof(*u_cmsg)) ||
+	    !access_ok(u_cmsg, sizeof(*u_cmsg)) ||
 	    __xn_get_user(tmp1, &u_cmsg->msg_name) ||
 	    __xn_get_user(msg->msg_namelen, &u_cmsg->msg_namelen) ||
 	    __xn_get_user(tmp2, &u_cmsg->msg_iov) ||
@@ -465,7 +465,7 @@ int sys32_get_mmsghdr(struct mmsghdr *mmsg,
 		      const struct compat_mmsghdr __user *u_cmmsg)
 {
 	if (u_cmmsg == NULL ||
-	    !access_rok(u_cmmsg, sizeof(*u_cmmsg)) ||
+	    !access_ok(u_cmmsg, sizeof(*u_cmmsg)) ||
 	    __xn_get_user(mmsg->msg_len, &u_cmmsg->msg_len))
 		return -EFAULT;
 
@@ -477,7 +477,7 @@ int sys32_put_msghdr(struct compat_msghdr __user *u_cmsg,
 		     const struct user_msghdr *msg)
 {
 	if (u_cmsg == NULL ||
-	    !access_wok(u_cmsg, sizeof(*u_cmsg)) ||
+	    !access_ok(u_cmsg, sizeof(*u_cmsg)) ||
 	    __xn_put_user(ptr_to_compat(msg->msg_name), &u_cmsg->msg_name) ||
 	    __xn_put_user(msg->msg_namelen, &u_cmsg->msg_namelen) ||
 	    __xn_put_user(ptr_to_compat(msg->msg_iov), &u_cmsg->msg_iov) ||
@@ -495,7 +495,7 @@ int sys32_put_mmsghdr(struct compat_mmsghdr __user *u_cmmsg,
 		     const struct mmsghdr *mmsg)
 {
 	if (u_cmmsg == NULL ||
-	    !access_wok(u_cmmsg, sizeof(*u_cmmsg)) ||
+	    !access_ok(u_cmmsg, sizeof(*u_cmmsg)) ||
 	    __xn_put_user(mmsg->msg_len, &u_cmmsg->msg_len))
 		return -EFAULT;
 
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index b95dfbce9d..45ec09fae7 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -247,7 +247,7 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 		if (xnthread_test_localinfo(curr, XNSYSRST)) {
 			xnthread_clear_localinfo(curr, XNSYSRST);
 
-			restart = cobalt_get_restart_block(current);
+			restart = &current->restart_block;
 			timeout = restart->nanosleep.expires;
 
 			if (restart->fn != cobalt_restart_syscall_placeholder) {
@@ -262,7 +262,7 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 			} else
 #endif
 			{
-				if (!access_wok(u_tv, sizeof(tv))
+				if (!access_ok(u_tv, sizeof(tv))
 				    || cobalt_copy_from_user(&tv, u_tv,
 							     sizeof(tv)))
 					return -EFAULT;
@@ -291,8 +291,8 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 			} else
 #endif
 			{
-				if (!access_wok((void __user *) ufd_sets[i],
-						sizeof(fd_set))
+				if (!access_ok((void __user *) ufd_sets[i],
+					       sizeof(fd_set))
 				    || cobalt_copy_from_user(in_fds[i],
 							     (void __user *)ufd_sets[i],
 							     fds_size))
@@ -335,7 +335,7 @@ int __cobalt_select(int nfds, void __user *u_rfds, void __user *u_wfds,
 	if (err == -EINTR && signal_pending(current)) {
 		xnthread_set_localinfo(curr, XNSYSRST);
 
-		restart = cobalt_get_restart_block(current);
+		restart = &current->restart_block;
 		restart->fn = cobalt_restart_syscall_placeholder;
 		restart->nanosleep.expires = timeout;
 
diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index d93c0bdf6d..d0a6d4e31f 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -948,7 +948,7 @@ int __cobalt_mq_timedsend(mqd_t uqd, const void __user *u_buf, size_t len,
 		goto out;
 	}
 
-	if (len > 0 && !access_rok(u_buf, len)) {
+	if (len > 0 && !access_ok(u_buf, len)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -1012,7 +1012,7 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
 	if (IS_ERR(mqd))
 		return PTR_ERR(mqd);
 
-	if (*lenp > 0 && !access_wok(u_buf, *lenp)) {
+	if (*lenp > 0 && !access_ok(u_buf, *lenp)) {
 		ret = -EFAULT;
 		goto fail;
 	}
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 935007f821..1abc86f37b 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -34,6 +34,7 @@
 #include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
+#include <linux/sched/mm.h>
 #include <pipeline/kevents.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/heap.h>
@@ -605,7 +606,7 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	if (xnthread_current() || xnthread_test_state(thread, XNMAPPED))
 		return -EBUSY;
 
-	if (!access_wok(u_winoff, sizeof(*u_winoff)))
+	if (!access_ok(u_winoff, sizeof(*u_winoff)))
 		return -EFAULT;
 
 	ret = pipeline_prepare_current();
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 5f5cb85d19..ced534079b 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -259,7 +259,7 @@ static int signal_wait(sigset_t *set, xnticks_t timeout,
 	curr = cobalt_current_thread();
 	XENO_BUG_ON(COBALT, curr == NULL);
 
-	if (u_si && !access_wok(u_si, sizeof(*u_si)))
+	if (u_si && !access_ok(u_si, sizeof(*u_si)))
 		return -EFAULT;
 
 	xnlock_get_irqsave(&nklock, s);
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index b0b2785e09..2667896115 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -906,7 +906,7 @@ COBALT_SYSCALL32emu(mmap, lostage,
 	int ret;
 
 	if (u_crma == NULL ||
-	    !access_rok(u_crma, sizeof(*u_crma)) ||
+	    !access_ok(u_crma, sizeof(*u_crma)) ||
 	    __xn_get_user(rma.length, &u_crma->length) ||
 	    __xn_get_user(rma.offset, &u_crma->offset) ||
 	    __xn_get_user(rma.prot, &u_crma->prot) ||
diff --git a/kernel/cobalt/posix/timerfd.c b/kernel/cobalt/posix/timerfd.c
index 472c4cba0c..2fbe152a5e 100644
--- a/kernel/cobalt/posix/timerfd.c
+++ b/kernel/cobalt/posix/timerfd.c
@@ -54,7 +54,7 @@ static ssize_t timerfd_read(struct rtdm_fd *fd, void __user *buf, size_t size)
 		return -EINVAL;
 
 	u_ticks = buf;
-	if (!access_wok(u_ticks, sizeof(*u_ticks)))
+	if (!access_ok(u_ticks, sizeof(*u_ticks)))
 		return -EFAULT;
 
 	aligned = (((unsigned long)buf) & (sizeof(ticks) - 1)) == 0;
diff --git a/kernel/cobalt/rtdm/Makefile b/kernel/cobalt/rtdm/Makefile
index 4f5a6caa77..fb5774b949 100644
--- a/kernel/cobalt/rtdm/Makefile
+++ b/kernel/cobalt/rtdm/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_XENOMAI) += xenomai.o
 xenomai-y :=	core.o		\
 		device.o	\
 		drvlib.o	\
-		fd.o		\
-		wrappers.o
+		fd.o
 
 ccflags-y += -I$(srctree)/$(src)/.. -I$(srctree)/kernel
diff --git a/kernel/cobalt/rtdm/wrappers.c b/kernel/cobalt/rtdm/wrappers.c
deleted file mode 100644
index d35bb3b4a7..0000000000
--- a/kernel/cobalt/rtdm/wrappers.c
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * Copyright (c) 2013  Hauke Mehrtens <hauke@hauke-m.de>
- * Copyright (c) 2013  Hannes Frederic Sowa <hannes@stressinduktion.org>
- * Copyright (c) 2014  Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backport functionality introduced in Linux 3.13.
- *
- * Copyright (c) 2014  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 3.14.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/version.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/hwmon.h>
-#include <asm/xenomai/wrappers.h>
-
-/*
- * Same rules as kernel/cobalt/include/asm-generic/xenomai/wrappers.h
- * apply to reduce #ifdefery.
- */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
-#ifdef CONFIG_PCI_MSI
-int pci_enable_msix_range(struct pci_dev *dev,
-			struct msix_entry *entries,
-			int minvec, int maxvec)
-{
-	int nvec = maxvec;
-	int rc;
-
-	if (maxvec < minvec)
-		return -ERANGE;
-
-	do {
-		rc = pci_enable_msix(dev, entries, nvec);
-		if (rc < 0) {
-			return rc;
-		} else if (rc > 0) {
-			if (rc < minvec)
-				return -ENOSPC;
-			nvec = rc;
-		}
-	} while (rc);
-
-	return nvec;
-}
-EXPORT_SYMBOL(pci_enable_msix_range);
-#endif
-#endif /* < 3.14 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
-#ifdef CONFIG_HWMON
-struct device*
-hwmon_device_register_with_groups(struct device *dev, const char *name,
-				void *drvdata,
-				const struct attribute_group **groups)
-{
-	struct device *hwdev;
-
-	hwdev = hwmon_device_register(dev);
-	hwdev->groups = groups;
-	dev_set_drvdata(hwdev, drvdata);
-	return hwdev;
-}
-
-static void devm_hwmon_release(struct device *dev, void *res)
-{
-	struct device *hwdev = *(struct device **)res;
-
-	hwmon_device_unregister(hwdev);
-}
-
-struct device *
-devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
-				void *drvdata,
-				const struct attribute_group **groups)
-{
-	struct device **ptr, *hwdev;
-
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
-	ptr = devres_alloc(devm_hwmon_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	hwdev = hwmon_device_register_with_groups(dev, name, drvdata, groups);
-	if (IS_ERR(hwdev))
-		goto error;
-
-	*ptr = hwdev;
-	devres_add(dev, ptr);
-	return hwdev;
-
-error:
-	devres_free(ptr);
-	return hwdev;
-}
-EXPORT_SYMBOL_GPL(devm_hwmon_device_register_with_groups);
-#endif
-#endif /* < 3.13 */
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index debc5077b1..7adc7f7897 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -25,6 +25,7 @@
 #include <linux/signal.h>
 #include <linux/pid.h>
 #include <linux/sched.h>
+#include <uapi/linux/sched/types.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/timer.h>
 #include <cobalt/kernel/synch.h>
diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
index b071adcfc9..82b1da525c 100644
--- a/kernel/drivers/analogy/national_instruments/mio_common.c
+++ b/kernel/drivers/analogy/national_instruments/mio_common.c
@@ -256,7 +256,6 @@ static inline void ni_set_bitfield(struct a4l_device *dev,
 		break;
 	}
 
-	mmiowb();
 	rtdm_lock_put_irqrestore(&devpriv->soft_reg_copy_lock, flags);
 }
 
@@ -324,7 +323,6 @@ static inline void ni_set_cdo_dma_channel(struct a4l_device * dev, int mite_chan
 			 CDO_DMA_Select_Shift) & CDO_DMA_Select_Mask;
 	}
 	ni_writeb(devpriv->cdio_dma_select_reg, M_Offset_CDIO_DMA_Select);
-	mmiowb();
 	rtdm_lock_put_irqrestore(&devpriv->soft_reg_copy_lock, flags);
 }
 
diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
index be4b268c11..655cda91d3 100644
--- a/kernel/drivers/analogy/national_instruments/mite.c
+++ b/kernel/drivers/analogy/national_instruments/mite.c
@@ -340,7 +340,6 @@ void a4l_mite_release_channel(struct mite_channel *mite_chan)
 		mite_dma_reset(mite_chan);
 		mite->channel_allocated[mite_chan->channel] = 0;
 		mite_chan->ring = NULL;
-		mmiowb();
 	}
 	rtdm_lock_put_irqrestore(&mite->lock, flags);
 }
@@ -360,7 +359,6 @@ void a4l_mite_dma_arm(struct mite_channel *mite_chan)
 	rtdm_lock_get_irqsave(&mite->lock, flags);
 	mite_chan->done = 0;
 	writel(chor, mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
-	mmiowb();
 	rtdm_lock_put_irqrestore(&mite->lock, flags);
 }
 
@@ -621,7 +619,6 @@ u32 a4l_mite_get_status(struct mite_channel *mite_chan)
 		writel(CHOR_CLRDONE,
 		       mite->mite_io_addr + MITE_CHOR(mite_chan->channel));
 	}
-	mmiowb();
 	rtdm_lock_put_irqrestore(&mite->lock, flags);
 	return status;
 }
diff --git a/kernel/drivers/analogy/national_instruments/ni_660x.c b/kernel/drivers/analogy/national_instruments/ni_660x.c
index 40a4b2678d..eeac4b4028 100644
--- a/kernel/drivers/analogy/national_instruments/ni_660x.c
+++ b/kernel/drivers/analogy/national_instruments/ni_660x.c
@@ -858,7 +858,6 @@ void ni_660x_set_dma_channel(struct a4l_device *dev,
 			       dma_configuration_soft_copies
 			       [counter->chip_index] |
 			       dma_reset_bit(mite_channel), DMAConfigRegister);
-	mmiowb();
 	rtdm_lock_put_irqrestore(&private(dev)->soft_reg_copy_lock, flags);
 }
 
@@ -877,7 +876,6 @@ void ni_660x_unset_dma_channel(struct a4l_device *dev,
 			       private(dev)->
 			       dma_configuration_soft_copies
 			       [counter->chip_index], DMAConfigRegister);
-	mmiowb();
 	rtdm_lock_put_irqrestore(&private(dev)->soft_reg_copy_lock, flags);
 }
 
diff --git a/kernel/drivers/analogy/national_instruments/tio_common.c b/kernel/drivers/analogy/national_instruments/tio_common.c
index bcce728eb5..a066f1ad91 100644
--- a/kernel/drivers/analogy/national_instruments/tio_common.c
+++ b/kernel/drivers/analogy/national_instruments/tio_common.c
@@ -157,7 +157,6 @@ void ni_tio_set_bits_transient(struct ni_gpct *counter,
 	write_register(counter,
 		       counter_dev->regs[register_index] | transient_bit_values,
 		       register_index);
-	mmiowb();
 	rtdm_lock_put_irqrestore(&counter_dev->regs_lock, flags);
 }
 
diff --git a/kernel/drivers/gpio/gpio-core.c b/kernel/drivers/gpio/gpio-core.c
index f67a5bf0aa..a054328f3c 100644
--- a/kernel/drivers/gpio/gpio-core.c
+++ b/kernel/drivers/gpio/gpio-core.c
@@ -590,7 +590,7 @@ static int match_gpio_chip(struct gpio_chip *gc, void *data)
 	struct gpiochip_match_data *d = data;
 	struct gpiochip_holder *h;
 
-	if (cobalt_gpiochip_dev(gc) == d->parent) {
+	if (gc->parent == d->parent) {
 		h = kmalloc(sizeof(*h), GFP_KERNEL);
 		if (h) {
 			h->chip = gc;
diff --git a/kernel/drivers/ipc/rtipc.c b/kernel/drivers/ipc/rtipc.c
index abb76817a6..859bdab2f2 100644
--- a/kernel/drivers/ipc/rtipc.c
+++ b/kernel/drivers/ipc/rtipc.c
@@ -322,7 +322,7 @@ int rtipc_get_length(struct rtdm_fd *fd, size_t *lenp,
 			return -EINVAL;
 		csz = arg;
 		return csz == NULL ||
-			!access_rok(csz, sizeof(*csz)) ||
+			!access_ok(csz, sizeof(*csz)) ||
 			__xn_get_user(*lenp, csz) ? -EFAULT : 0;
 	}
 #endif
diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
index 0b3ec74fab..f70587678a 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -250,9 +250,6 @@ static inline void rtnetproxy_kernel_recv(struct rtskb *rtskb)
 	/* the rtskb stamp is useless (different clock), get new one */
 	__net_timestamp(skb);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 11, 0)
-	dev->last_rx = jiffies;
-#endif
 	dev->stats.rx_bytes += skb->len;
 	dev->stats.rx_packets++;
 
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 20073aa672..acb8dbdafa 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -53,10 +53,6 @@
 #include <linux/aer.h>
 #include <linux/prefetch.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
-#include <linux/pci-aspm.h>
-#endif
-
 #include "e1000.h"
 
 #define RT_E1000E_NUM_RXD	64
@@ -2883,15 +2879,9 @@ static void e1000e_update_phy_task(struct work_struct *work)
  * Need to wait a few seconds after link up to get diagnostic information from
  * the phy
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 static void e1000_update_phy_info(struct timer_list *t)
 {
 	struct e1000_adapter *adapter = from_timer(adapter, t, phy_info_timer);
-#else /* < 4.14 */
-static void e1000_update_phy_info(unsigned long data)
-{
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
-#endif /* < 4.14 */
 
 	if (test_bit(__E1000_DOWN, &adapter->state))
 		return;
@@ -3037,15 +3027,9 @@ static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
  * e1000_watchdog - Timer Call-back
  * @data: pointer to adapter cast into an unsigned long
  **/
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 static void e1000_watchdog(struct timer_list *t)
 {
 	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
-#else /* < 4.14 */
-static void e1000_watchdog(unsigned long data)
-{
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
-#endif /* < 4.14 */
 
 	/* Do the rest outside of interrupt context */
 	rtdm_schedule_nrt_work(&adapter->watchdog_task);
@@ -3357,7 +3341,6 @@ static void e1000_tx_queue(struct e1000_adapter *adapter,
 	 * we need this if more than one processor can write to our tail
 	 * at a time, it synchronizes IO on IA64/Altix systems
 	 */
-	mmiowb();
 }
 
 #define MINIMUM_DHCP_PACKET_SIZE 282
@@ -4095,18 +4078,8 @@ static int e1000_probe(struct pci_dev *pdev,
 
 	memcpy(netdev->dev_addr, adapter->hw.mac.addr, netdev->addr_len);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 	timer_setup(&adapter->watchdog_timer, e1000_watchdog, 0);
 	timer_setup(&adapter->phy_info_timer, e1000_update_phy_info, 0);
-#else /* < 4.14 */
-	init_timer(&adapter->watchdog_timer);
-	adapter->watchdog_timer.function = e1000_watchdog;
-	adapter->watchdog_timer.data = (unsigned long) adapter;
-
-	init_timer(&adapter->phy_info_timer);
-	adapter->phy_info_timer.function = e1000_update_phy_info;
-	adapter->phy_info_timer.data = (unsigned long) adapter;
-#endif /* < 4.14 */
 
 	INIT_WORK(&adapter->reset_task, e1000_reset_task);
 	INIT_WORK(&adapter->watchdog_task, e1000_watchdog_task);
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index 64b724c3cb..db16cff11a 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -3606,9 +3606,6 @@ static void e1000_tx_queue(struct e1000_adapter *adapter,
 	writel(i, adapter->hw.hw_addr + tx_ring->tdt);
 
     rtdm_lock_irqrestore(context);
-	/* we need this if more than one processor can write to our tail
-	 * at a time, it synchronizes IO on IA64/Altix systems */
-	mmiowb();
 }
 
 #define E1000_FIFO_HDR			0x10
diff --git a/kernel/drivers/net/drivers/experimental/e1000/kcompat.h b/kernel/drivers/net/drivers/experimental/e1000/kcompat.h
index 48906b7f06..fd15e8580a 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/kcompat.h
+++ b/kernel/drivers/net/drivers/experimental/e1000/kcompat.h
@@ -171,14 +171,6 @@
 #define PCI_CAP_ID_EXP 0x10
 #endif
 
-#ifndef mmiowb
-#ifdef CONFIG_IA64
-#define mmiowb() asm volatile ("mf.a" ::: "memory")
-#else
-#define mmiowb()
-#endif
-#endif
-
 #ifndef SET_NETDEV_DEV
 #define SET_NETDEV_DEV(net, pdev)
 #endif
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 864e4b5b80..38396a08e1 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -878,11 +878,7 @@ fec_stop(struct net_device *ndev)
 }
 
 static void
-#if LINUX_VERSION_CODE > KERNEL_VERSION(5,6,0)
 fec_timeout(struct net_device *ndev, unsigned int txqueue)
-#else
-fec_timeout(struct net_device *ndev)
-#endif
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
@@ -2318,10 +2314,8 @@ fec_enet_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 }
 
 static const struct ethtool_ops fec_enet_ethtool_ops = {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(5,7,0)
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
-#endif
 	.get_drvinfo		= fec_enet_get_drvinfo,
 	.get_regs_len		= fec_enet_get_regs_len,
 	.get_regs		= fec_enet_get_regs,
@@ -2358,11 +2352,7 @@ static int fec_enet_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 		return -ENODEV;
 
 	if (fep->bufdesc_ex) {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(5,9,0)
 		bool use_fec_hwts = !phy_has_hwtstamp(phydev);
-#else
-		bool use_fec_hwts = true;
-#endif
 		if (cmd == SIOCSHWTSTAMP) {
 			if (use_fec_hwts)
 				return fec_ptp_set(ndev, rq);
@@ -3265,9 +3255,7 @@ fec_probe(struct platform_device *pdev)
 {
 	struct fec_enet_private *fep;
 	struct fec_platform_data *pdata;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(5,5,0)
 	phy_interface_t interface;
-#endif
 	struct net_device *ndev;
 	int i, irq, ret = 0, eth_id;
 	const struct of_device_id *of_id;
@@ -3350,24 +3338,15 @@ fec_probe(struct platform_device *pdev)
 		phy_node = of_node_get(np);
 	}
 	fep->phy_node = phy_node;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(5,5,0)
 	ret = of_get_phy_mode(pdev->dev.of_node, &interface);
 	if (ret) {
-#else
-	ret = of_get_phy_mode(pdev->dev.of_node);
-	if (ret < 0) {
-#endif
 		pdata = dev_get_platdata(&pdev->dev);
 		if (pdata)
 			fep->phy_interface = pdata->phy;
 		else
 			fep->phy_interface = PHY_INTERFACE_MODE_MII;
 	} else {
-#if LINUX_VERSION_CODE > KERNEL_VERSION(5,5,0)
 		fep->phy_interface = interface;
-#else
-		fep->phy_interface = ret;
-#endif
 	}
 
 	fep->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index d47c0bb35c..d0f647c63e 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -202,13 +202,8 @@ static void igb_clean_all_rx_rings(struct igb_adapter *);
 static void igb_clean_tx_ring(struct igb_ring *);
 static void igb_clean_rx_ring(struct igb_ring *);
 static void igb_set_rx_mode(struct rtnet_device *);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 static void igb_update_phy_info(struct timer_list *);
 static void igb_watchdog(struct timer_list *);
-#else
-static void igb_update_phy_info(unsigned long);
-static void igb_watchdog(unsigned long);
-#endif
 static void igb_watchdog_task(struct work_struct *);
 static netdev_tx_t igb_xmit_frame(struct rtskb *skb, struct rtnet_device *);
 static struct net_device_stats *igb_get_stats(struct rtnet_device *);
@@ -2199,15 +2194,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		wr32(E1000_TXPBS, I210_TXPBSIZE_DEFAULT);
 	}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 	timer_setup(&adapter->watchdog_timer, igb_watchdog, 0);
 	timer_setup(&adapter->phy_info_timer, igb_update_phy_info, 0);
-#else /* < 4.14 */
-	setup_timer(&adapter->watchdog_timer, igb_watchdog,
-		    (unsigned long) adapter);
-	setup_timer(&adapter->phy_info_timer, igb_update_phy_info,
-		    (unsigned long) adapter);
-#endif /* < 4.14 */
 
 	INIT_WORK(&adapter->reset_task, igb_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
@@ -3520,15 +3508,9 @@ static void igb_check_wvbr(struct igb_adapter *adapter)
 /* Need to wait a few seconds after link up to get diagnostic information from
  * the phy
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 static void igb_update_phy_info(struct timer_list *t)
 {
 	struct igb_adapter *adapter = from_timer(adapter, t, phy_info_timer);
-#else /* < 4.14 */
-static void igb_update_phy_info(unsigned long data)
-{
-	struct igb_adapter *adapter = (struct igb_adapter *) data;
-#endif /* < 4.14 */
 	igb_get_phy_info(&adapter->hw);
 }
 
@@ -3616,15 +3598,9 @@ static void igb_check_lvmmc(struct igb_adapter *adapter)
  *  igb_watchdog - Timer Call-back
  *  @data: pointer to adapter cast into an unsigned long
  **/
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
 static void igb_watchdog(struct timer_list *t)
 {
 	struct igb_adapter *adapter = from_timer(adapter, t, watchdog_timer);
-#else /* < 4.14 */
-static void igb_watchdog(unsigned long data)
-{
-	struct igb_adapter *adapter = (struct igb_adapter *)data;
-#endif /* < 4.14 */
 	/* Do the rest outside of interrupt context */
 	schedule_work(&adapter->watchdog_task);
 }
@@ -4155,13 +4131,6 @@ static void igb_tx_map(struct igb_ring *tx_ring,
 	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	writel(i, tx_ring->tail);
-
-	/* we need this if more than one processor can write to our tail
-	 * at a time, it synchronizes IO on IA64/Altix systems
-	 */
-	mmiowb();
-
-	return;
 }
 
 netdev_tx_t igb_xmit_frame_ring(struct rtskb *skb,
diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index b49a15e305..e05e40cf9c 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -78,10 +78,6 @@ RTL8169_VERSION "2.2"	<2004/08/09>
 #include <linux/timer.h>
 #include <linux/init.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
-#include <linux/pci-aspm.h>
-#endif
-
 #include <rtnet_port.h>	/*** RTnet ***/
 
 #define RTL8169_VERSION "2.2-04"
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
index 158d7118f2..34427e74fc 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
@@ -214,9 +214,9 @@ static int load_cfg_file(struct rtcfg_file *cfgfile, struct rtcfg_cmd *cmd)
 		cfgfile->buffer = vmalloc(1);
 	} else {
 		cfgfile->buffer = NULL; /* Leave allocation to the kernel. */
-		ret = read_file_from_kernel(filp, &cfgfile->buffer,
-					i_size_read(file_inode(filp)),
-					&file_size, READING_UNKNOWN);
+		ret = kernel_read_file(filp, 0, &cfgfile->buffer,
+				       i_size_read(file_inode(filp)),
+				       &file_size, READING_UNKNOWN);
 		if (ret < 0) {
 			fput(filp);
 			return ret;
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 13e979088e..f639cf6403 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -51,10 +51,6 @@ DEFINE_MUTEX(rtnet_devices_nrt_lock);
 
 static int rtdev_locked_xmit(struct rtskb *skb, struct rtnet_device *rtdev);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
-#define atomic_fetch_add_unless __atomic_add_unless
-#endif
-
 int rtdev_reference(struct rtnet_device *rtdev)
 {
 	smp_mb__before_atomic();
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index ca869f19a4..9a78f0ec4d 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -412,7 +412,6 @@ patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
 patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
 patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
 patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xenomai
-patch_link r n kernel/cobalt/include/linux/xenomai include/linux/xenomai
 patch_link n m kernel/cobalt/posix kernel/xenomai/posix
 patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
 patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
-- 
2.31.1


