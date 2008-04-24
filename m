From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.10157.853132.856441@domain.hid>
Date: Thu, 24 Apr 2008 08:24:45 +0200
In-Reply-To: <18448.10037.181558.14996@domain.hid>
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
	<18448.9967.355128.570111@domain.hid>
	<18448.10037.181558.14996@domain.hid>
Subject: [Xenomai-core] [4/9] Define ARM atomic operations in user-space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


This patch implements the _read, _set, and _cmpxchg operations on the atomic_t
type in user-space for ARM, using ldrex/strex on ARM v6, and the Linux kernel
helper kuser_cmpxchg on ARM pre-v6 (so, without syscalls) without SMP. Only the
SMP case for pre-v6 ARMs still use syscalls, but this case should not be so
frequent anyway.

A new macro XNARCH_HAVE_US_ATOMIC_CMPXCHG is defined both in kernel-space and
user-space, so that the kernel-space can rely on the user-space having
atomic_cmpxchg defined.

The plan is to implement these atomic operations for other platforms, defining
the XNARCH_HAVE_US_ATOMIC_CMPXCHG macro when this is done. When all platforms
define XNARCH_HAVE_US_ATOMIC_CMPXCGH, we will be able to remove all the
#ifdefs.

A question arise about memory barriers. I assumed that atomic_cmpxchg implied a
barrier, but I am not to sure about that. If that is not the case, we will have
to implement barriers in user-space as well, and call the in the apropriate
places in mutexes implementation.

---
 atomic.h |  169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 166 insertions(+), 3 deletions(-)

Index: include/asm-arm/atomic.h
===================================================================
--- include/asm-arm/atomic.h	(revision 3718)
+++ include/asm-arm/atomic.h	(working copy)
@@ -23,7 +23,6 @@
 #ifndef _XENO_ASM_ARM_ATOMIC_H
 #define _XENO_ASM_ARM_ATOMIC_H
 
-
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
@@ -35,6 +34,8 @@
 #define xnarch_memory_barrier()  	smp_mb()
 
 #if __LINUX_ARM_ARCH__ >= 6
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+
 static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
 {
     unsigned long tmp, tmp2;
@@ -58,6 +59,11 @@ static inline void atomic_set_mask(unsig
     *addr |= mask;
     local_irq_restore_hw(flags);
 }
+
+#ifndef CONFIG_SMP
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+#endif /* CONFIG_SMP */
+
 #endif /* ARM_ARCH_6 */
 
 #define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
@@ -75,9 +81,14 @@ typedef atomic_t atomic_counter_t;
 
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
+#include <nucleus/compiler.h>
 
 typedef struct { volatile int counter; } atomic_counter_t;
 
+typedef atomic_counter_t atomic_t;
+
+#define atomic_read(v)	((v)->counter)
+
 /*
  * This function doesn't exist, so you'll get a linker error
  * if something tries to do an invalid xchg().
@@ -129,6 +140,40 @@ __xchg(volatile void *ptr, unsigned long
  * Atomic operations lifted from linux/include/asm-arm/atomic.h 
  */
 #if CONFIG_XENO_ARM_ARCH >= 6
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+
+static __inline__ void atomic_set(atomic_t *v, int i)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__("@ atomic_set\n"
+"1:	ldrex	%0, [%1]\n"
+"	strex	%0, %2, [%1]\n"
+"	teq	%0, #0\n"
+"	bne	1b"
+	: "=&r" (tmp)
+	: "r" (&v->counter), "r" (i)
+	: "cc");
+}
+
+static __inline__ int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+{
+	unsigned long oldval, res;
+
+	do {
+		__asm__ __volatile__("@ atomic_cmpxchg\n"
+		"ldrex	%1, [%2]\n"
+		"mov	%0, #0\n"
+		"teq	%1, %3\n"
+		"strexeq %0, %4, [%2]\n"
+		    : "=&r" (res), "=&r" (oldval)
+		    : "r" (&ptr->counter), "Ir" (old), "r" (new)
+		    : "cc");
+	} while (res);
+
+	return oldval;
+}
+
 static __inline__ int atomic_add_return(int i, atomic_counter_t *v)
 {
     unsigned long tmp;
@@ -194,7 +239,7 @@ static __inline__ void atomic_clear_mask
     : "r" (addr), "Ir" (mask)
     : "cc");
 }
-#else /* ARM_ARCH_6 */
+#elif CONFIG_SMP
 static __inline__ int atomic_add_return(int i, atomic_counter_t *v)
 {
     int ret;
@@ -224,7 +269,122 @@ static inline void atomic_clear_mask(uns
     XENOMAI_SYSCALL3(__xn_sys_arch,
                      XENOMAI_SYSARCH_ATOMIC_CLEAR_MASK, mask, addr);
 }
-#endif /* ARM_ARCH_6 */
+#else /* ARM_ARCH <= 5 && !CONFIG_SMP */
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+
+static __inline__ void atomic_set(atomic_counter_t *ptr, int val)
+{
+	ptr->counter = val;
+}
+
+static __inline__ int atomic_cmpxchg(atomic_counter_t *ptr, int old, int new)
+{
+        register int asm_old asm("r0") = old;
+        register int asm_new asm("r1") = new;
+        register int *asm_ptr asm("r2") = (int *) &ptr->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	do {
+		asm volatile ( \
+			"mov %1, #0xffff0fff\n\t"	\
+			"mov lr, pc\n\t"		 \
+			"add pc, %1, #(0xffff0fc0 - 0xffff0fff)\n\t"	\
+			: "+r"(asm_old), "=&r"(asm_tmp), "=r"(asm_lr)	\
+			: "r"(asm_new), "r"(asm_ptr) \
+			: "ip", "cc", "memory");
+		if (likely(!asm_old))
+			return old;
+	} while ((asm_old = *asm_ptr) == old);
+        return asm_old;
+}
+
+static __inline__ int atomic_add_return(int i, atomic_counter_t *v)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ atomic_add\n\t" \
+		"ldr	%0, [%4]\n\t" \
+		"mov	%1, #0xffff0fff\n\t" \
+		"add	lr, pc, #4\n\t" \
+		"add	%3, %0, %5\n\t"\
+		"add	pc, %1, #(0xffff0fc0 - 0xffff0fff)\n\t" \
+		"bcc	1b" \
+		: "=&r" (asm_old), "=&r"(asm_tmp), "=r"(asm_lr), "=r"(asm_new) \
+		: "r" (asm_ptr), "rIL"(i) \
+		: "ip", "cc", "memory");
+	return asm_new;
+}
+
+static __inline__ int atomic_sub_return(int i, atomic_counter_t *v)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ atomic_sub\n\t" \
+		"ldr	%0, [%4]\n\t" \
+		"mov	%1, #0xffff0fff\n\t" \
+		"add	lr, pc, #4\n\t" \
+		"sub	%3, %0, %5\n\t"\
+		"add	pc, %1, #(0xffff0fc0 - 0xffff0fff)\n\t" \
+		"bcc	1b" \
+		: "=&r" (asm_old), "=&r"(asm_tmp), "=r"(asm_lr), "=r"(asm_new) \
+		: "r" (asm_ptr), "rIL"(i) \
+		: "ip", "cc", "memory");
+	return asm_new;
+}
+
+static __inline__ void atomic_set_mask(long mask, atomic_counter_t *v)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ atomic_set_mask\n\t" \
+		"ldr	%0, [%4]\n\t" \
+		"mov	%1, #0xffff0fff\n\t" \
+		"add	lr, pc, #4\n\t" \
+		"orr	%3, %0, %5\n\t"\
+		"add	pc, %1, #(0xffff0fc0 - 0xffff0fff)\n\t" \
+		"bcc	1b" \
+		: "=&r" (asm_old), "=&r"(asm_tmp), "=r"(asm_lr), "=r"(asm_new) \
+		: "r" (asm_ptr), "rIL"(mask) \
+		: "ip", "cc", "memory");
+}
+
+static __inline__ void atomic_clear_mask(long mask, atomic_counter_t *v)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ atomic_clear_mask\n\t" \
+		"ldr	%0, [%4]\n\t" \
+		"mov	%1, #0xffff0fff\n\t" \
+		"add	lr, pc, #4\n\t" \
+		"bic	%3, %0, %5\n\t" \
+		"add	pc, %1, #(0xffff0fc0 - 0xffff0fff)\n\t" \
+		"bcc	1b" \
+		: "=&r" (asm_old), "=&r"(asm_tmp), "=r"(asm_lr), "=r"(asm_new) \
+		: "r" (asm_ptr), "rIL"(mask) \
+		: "ip", "cc", "memory");
+}
+#endif /* ARM_ARCH <= 5 && !CONFIG_SMP */
 
 #define xnarch_memory_barrier()                 __asm__ __volatile__("": : :"memory")
 
@@ -241,6 +401,9 @@ static inline void atomic_clear_mask(uns
 
 typedef unsigned long atomic_flags_t;
 
+/* Add support for atomic_long_t and atomic_ptr_t */
+#include <asm-generic/xenomai/atomic.h>
+
 #endif /* !_XENO_ASM_ARM_ATOMIC_H */
 
 // vim: ts=4 et sw=4 sts=4

-- 


					    Gilles.

