From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18459.38644.699369.801548@domain.hid>
Date: Sat, 3 May 2008 00:34:28 +0200
In-Reply-To: <18459.38558.684426.240775@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
	<18459.38558.684426.240775@domain.hid>
Subject: [Xenomai-core] [Patch 4/7] Define ARM atomic operations in
	user-space
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


The include/asm-arm/atomic.h header now defines the xnarch_memory_barrier in
addition to user-space atomic operations. The pxa3xx deserves a special
treatment since it uses the ARMv6 memory barrier operation whereas being an
ARMv5 for other operations, hence a special --enable-arm-mach=pxa3xx option in
configure.in.

---
 configure.in             |   13 ++
 include/asm-arm/atomic.h |  238 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 222 insertions(+), 29 deletions(-)

Index: configure.in
===================================================================
--- configure.in	(revision 3738)
+++ configure.in	(working copy)
@@ -166,6 +166,7 @@ if test $XENO_TARGET_ARCH = arm ; then
   CONFIX_XENO_ARM_EABI=
 
   unset CONFIG_XENO_ARM_SA1100
+  unset CONFIG_XENO_CPU_XSC3
   unset tsc_type
   unset CONFIG_XENO_ARM_HW_DIRECT_TSC
 
@@ -173,7 +174,7 @@ if test $XENO_TARGET_ARCH = arm ; then
   AC_ARG_ENABLE(arm-mach,
 	AS_HELP_STRING([--enable-arm-mach], [Select for which machine we are
 compiling. Valid machines are at91rm9200, at91sam926x, imx, imx21, integrator, 
-ixp4xx, pxa, s3c2410, sa1100.]),
+ixp4xx, pxa, pxa3xx, s3c2410, sa1100.]),
 	[case "$enableval" in
 	at91rm9200)   	arch=4
 	        	tsc_type=__XN_TSC_TYPE_FREERUNNING;;
@@ -193,6 +194,9 @@ ixp4xx, pxa, s3c2410, sa1100.]),
 	ixp4xx|pxa) 	arch=5
 	      		tsc_type=__XN_TSC_TYPE_FREERUNNING;;
 
+	pxa3xx)	        arch=xscale3
+			tsc_type=__XN_TSC_TYPE_FREERUNNING;;
+
 	s3c2410) 	arch=4
 			tsc_type=__XN_TSC_TYPE_DECREMENTER;;
 
@@ -218,6 +222,9 @@ ixp4xx, pxa, s3c2410, sa1100.]),
 		esac
 		CONFIG_XENO_ARM_ARCH="$enableval"
     	])
+  elif test $arch = xscale3; then
+	CONFIG_XENO_ARM_ARCH=5
+	CONFIG_XENO_CPU_XSC3=y
   else
 	CONFIG_XENO_ARM_ARCH=$arch
   fi
@@ -226,6 +233,9 @@ ixp4xx, pxa, s3c2410, sa1100.]),
   AC_MSG_CHECKING(for ARM SA1100 architecture)
   AC_MSG_RESULT(${CONFIG_XENO_ARM_SA1100:-no})
 
+  AC_MSG_CHECKING(for ARM Xscale3 architecture)
+  AC_MSG_RESULT(${CONFIG_XENO_CPU_XSC3:-no})
+
   AC_MSG_CHECKING(for TSC emulation in user-space.)
   if test $tsc_type; then
 	AC_ARG_ENABLE(arm-tsc,
@@ -527,6 +537,7 @@ test x$CONFIG_X86_TSC = xy && AC_DEFINE(
 test -n "$CONFIG_XENO_ARM_ARCH" && AC_DEFINE_UNQUOTED(CONFIG_XENO_ARM_ARCH,$CONFIG_XENO_ARM_ARCH,[config])
 
 test x$CONFIG_XENO_ARM_SA1100 = xy && AC_DEFINE(CONFIG_XENO_ARM_SA1100,1,[config])
+test x$CONFIG_XENO_CPU_XSC3 = xy && AC_DEFINE(CONFIG_XENO_CPU_XSC3,1,[config])
 test $CONFIG_XENO_ARM_HW_DIRECT_TSC && AC_DEFINE_UNQUOTED(CONFIG_XENO_ARM_HW_DIRECT_TSC,$CONFIG_XENO_ARM_HW_DIRECT_TSC,[config])
 test x$CONFIG_XENO_ARM_EABI = xy && AC_DEFINE(CONFIG_XENO_ARM_EABI,1,[config])
 
Index: include/asm-arm/atomic.h
===================================================================
--- include/asm-arm/atomic.h	(revision 3738)
+++ include/asm-arm/atomic.h	(working copy)
@@ -23,7 +23,6 @@
 #ifndef _XENO_ASM_ARM_ATOMIC_H
 #define _XENO_ASM_ARM_ATOMIC_H
 
-
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
@@ -31,11 +30,17 @@
 #include <asm/system.h>
 #include <asm/xenomai/features.h>
 
+typedef atomic_t atomic_counter_t;
+typedef atomic_t xnarch_atomic_t;
+
 #define xnarch_atomic_xchg(ptr,v)       xchg(ptr,v)
 #define xnarch_memory_barrier()  	smp_mb()
 
 #if __LINUX_ARM_ARCH__ >= 6
-static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+
+static inline void
+xnarch_atomic_set_mask(unsigned long *addr, unsigned long mask)
 {
     unsigned long tmp, tmp2;
 
@@ -50,7 +55,8 @@ static inline void atomic_set_mask(unsig
     : "cc");
 }
 #else /* ARM_ARCH_6 */
-static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
+static inline void
+xnarch_atomic_set_mask(unsigned long *addr, unsigned long mask)
 {
     unsigned long flags;
 
@@ -58,25 +64,32 @@ static inline void atomic_set_mask(unsig
     *addr |= mask;
     local_irq_restore_hw(flags);
 }
+
+#ifndef CONFIG_SMP
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+#endif /* CONFIG_SMP */
+
 #endif /* ARM_ARCH_6 */
 
-#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
+#define xnarch_atomic_set(pcounter,i)          atomic_set((pcounter),i)
 #define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
 #define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
 #define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
+#define xnarch_atomic_clear_mask(addr, mask)   atomic_clear_mask((mask), (addr))
+#define xnarch_atomic_cmpxchg(pcounter, old, new) \
+	atomic_cmpxchg((pcounter), (old), (new))
 #define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
 #define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
-
-typedef atomic_t atomic_counter_t;
 
 #else /* !__KERNEL__ */
 
 #include <asm/xenomai/features.h>
 #include <asm/xenomai/syscall.h>
+#include <nucleus/compiler.h>
+
+typedef struct { volatile int counter; } xnarch_atomic_t;
 
-typedef struct { volatile int counter; } atomic_counter_t;
+#define xnarch_atomic_get(v)	((v)->counter)
 
 /*
  * This function doesn't exist, so you'll get a linker error
@@ -129,12 +142,47 @@ __xchg(volatile void *ptr, unsigned long
  * Atomic operations lifted from linux/include/asm-arm/atomic.h 
  */
 #if CONFIG_XENO_ARM_ARCH >= 6
-static __inline__ int atomic_add_return(int i, atomic_counter_t *v)
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+
+static __inline__ void xnarch_atomic_set(xnarch_atomic_t *v, int i)
+{
+	unsigned long tmp;
+
+	__asm__ __volatile__("@ xnarch_atomic_set\n"
+"1:	ldrex	%0, [%1]\n"
+"	strex	%0, %2, [%1]\n"
+"	teq	%0, #0\n"
+"	bne	1b"
+	: "=&r" (tmp)
+	: "r" (&v->counter), "r" (i)
+	: "cc");
+}
+
+static __inline__ int
+xnarch_atomic_cmpxchg(xnarch_atomic_t *ptr, int old, int new)
+{
+	unsigned long oldval, res;
+
+	do {
+		__asm__ __volatile__("@ xnarch_atomic_cmpxchg\n"
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
+static __inline__ int xnarch_atomic_add_return(int i, xnarch_atomic_t *v)
 {
     unsigned long tmp;
     int result;
 
-    __asm__ __volatile__("@ atomic_add_return\n"
+    __asm__ __volatile__("@ xnarch_atomic_add_return\n"
 "1: ldrex   %0, [%2]\n"
 "   add     %0, %0, %3\n"
 "   strex   %1, %0, [%2]\n"
@@ -147,12 +195,12 @@ static __inline__ int atomic_add_return(
     return result;
 }
 
-static __inline__ int atomic_sub_return(int i, atomic_counter_t *v)
+static __inline__ int xnarch_atomic_sub_return(int i, xnarch_atomic_t *v)
 {
     unsigned long tmp;
     int result;
 
-    __asm__ __volatile__("@ atomic_sub_return\n"
+    __asm__ __volatile__("@ xnarch_atomic_sub_return\n"
 "1: ldrex   %0, [%2]\n"
 "   sub     %0, %0, %3\n"
 "   strex   %1, %0, [%2]\n"
@@ -165,11 +213,12 @@ static __inline__ int atomic_sub_return(
     return result;
 }
 
-static __inline__ void atomic_set_mask(unsigned long mask, unsigned long *addr)
+static __inline__ void
+xnarch_atomic_set_mask(unsigned long *addr, unsigned long mask)
 {
     unsigned long tmp, tmp2;
 
-    __asm__ __volatile__("@ atomic_set_mask\n"
+    __asm__ __volatile__("@ xnarch_atomic_set_mask\n"
 "1: ldrex   %0, [%2]\n"
 "   orr     %0, %0, %3\n"
 "   strex   %1, %0, [%2]\n"
@@ -180,11 +229,12 @@ static __inline__ void atomic_set_mask(u
     : "cc");
 }
 
-static __inline__ void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+static __inline__ void
+xnarch_atomic_clear_mask(unsigned long *addr, unsigned long mask)
 {
     unsigned long tmp, tmp2;
 
-    __asm__ __volatile__("@ atomic_clear_mask\n"
+    __asm__ __volatile__("@ xnarch_atomic_clear_mask\n"
 "1: ldrex   %0, [%2]\n"
 "   bic     %0, %0, %3\n"
 "   strex   %1, %0, [%2]\n"
@@ -194,8 +244,9 @@ static __inline__ void atomic_clear_mask
     : "r" (addr), "Ir" (mask)
     : "cc");
 }
-#else /* ARM_ARCH_6 */
-static __inline__ int atomic_add_return(int i, atomic_counter_t *v)
+
+#elif CONFIG_SMP
+static __inline__ int xnarch_atomic_add_return(int i, xnarch_atomic_t *v)
 {
     int ret;
 
@@ -204,7 +255,7 @@ static __inline__ int atomic_add_return(
     return ret;
 }
 
-static __inline__ int atomic_sub_return(int i, atomic_counter_t *v)
+static __inline__ int xnarch_atomic_sub_return(int i, xnarch_atomic_t *v)
 {
     int ret;
 
@@ -213,25 +264,153 @@ static __inline__ int atomic_sub_return(
     return ret;
 }
 
-static inline void atomic_set_mask(unsigned long mask, unsigned long *addr)
+static inline void
+xnarch_atomic_set_mask(unsigned long *addr, unsigned long mask)
 {
     XENOMAI_SYSCALL3(__xn_sys_arch,
                      XENOMAI_SYSARCH_ATOMIC_SET_MASK, mask, addr);
 }
 
-static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+static inline void
+xnarch_atomic_clear_mask(unsigned long *addr, unsigned long mask)
 {
     XENOMAI_SYSCALL3(__xn_sys_arch,
                      XENOMAI_SYSARCH_ATOMIC_CLEAR_MASK, mask, addr);
 }
-#endif /* ARM_ARCH_6 */
+#else /* ARM_ARCH <= 5 && !CONFIG_SMP */
+#define XNARCH_HAVE_US_ATOMIC_CMPXCHG
+
+static __inline__ void xnarch_atomic_set(xnarch_atomic_t *ptr, int val)
+{
+	ptr->counter = val;
+}
 
-#define xnarch_memory_barrier()                 __asm__ __volatile__("": : :"memory")
+static __inline__ int
+xnarch_atomic_cmpxchg(xnarch_atomic_t *ptr, int old, int new)
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
+static __inline__ int xnarch_atomic_add_return(int i, xnarch_atomic_t *v)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ xnarch_atomic_add\n\t" \
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
+static __inline__ int xnarch_atomic_sub_return(int i, xnarch_atomic_t *v)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ xnarch_atomic_sub\n\t" \
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
+static __inline__ void xnarch_atomic_set_mask(xnarch_atomic_t *v, long mask)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ xnarch_atomic_set_mask\n\t" \
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
+static __inline__ void xnarch_atomic_clear_mask(xnarch_atomic_t *v, long mask)
+{
+	register int asm_old asm("r0");
+	register int asm_new asm("r1");
+	register int *asm_ptr asm("r2") = (int *) &v->counter;
+        register int asm_lr asm("lr");
+	register int asm_tmp asm("r3");
+
+	asm volatile ( \
+		"1: @ xnarch_atomic_clear_mask\n\t" \
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
+
+
+#endif /* ARM_ARCH <= 5 && !CONFIG_SMP */
+
+#if CONFIG_XENO_ARM_ARCH >= 7
+#define xnarch_memory_barrier() \
+	__asm__ __volatile__ ("dmb" : : : "memory")
+#elif defined(CONFIG_XENO_CPU_XSC3) || CONFIG_XENO_ARM_ARCH == 6
+#define xnarch_memory_barrier() \
+	__asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
+                              : : "r" (0) : "memory")
+#else /* CONFIG_XENO_ARM_ARCH <= 5 */
+#define xnarch_memory_barrier() \
+	__asm__ __volatile__ ("": : :"memory")
+#endif /* CONFIG_XENO_ARM_ARCH <= 5 */
 
-#define xnarch_atomic_inc(pcounter)             (void) atomic_add_return(1, pcounter)
-#define xnarch_atomic_dec_and_test(pcounter)    (atomic_sub_return(1, pcounter) == 0)
-#define xnarch_atomic_set_mask(pflags,mask)     atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)   atomic_clear_mask(mask,pflags)
+#define xnarch_atomic_inc(pcounter)             (void) xnarch_atomic_add_return(1, pcounter)
+#define xnarch_atomic_dec_and_test(pcounter)    (xnarch_atomic_sub_return(1, pcounter) == 0)
 
 #define cpu_relax()                             xnarch_memory_barrier()
 #define xnarch_read_memory_barrier()		xnarch_memory_barrier()
@@ -241,6 +420,9 @@ static inline void atomic_clear_mask(uns
 
 typedef unsigned long atomic_flags_t;
 
+/* Add support for xnarch_atomic_intptr_t */
+#include <asm-generic/xenomai/atomic.h>
+
 #endif /* !_XENO_ASM_ARM_ATOMIC_H */
 
 // vim: ts=4 et sw=4 sts=4


-- 


					    Gilles.

