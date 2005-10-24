Message-ID: <435CA08B.6030509@domain.hid>
Date: Mon, 24 Oct 2005 11:51:23 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050203000005090307050403"
Subject: [Xenomai-core] [PATCH: 1/3] powerpc merge (headers)
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

This is a multi-part message in MIME format.
--------------050203000005090307050403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Merge headers from ppc and ppc64 to powerpc.

-- Heikki Lindholm


--------------050203000005090307050403
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-powerpc-merge-051023-headers.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="xenomai-powerpc-merge-051023-headers.patch"

diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-powerpc/atomic.h xenomai-devel/include/nucleus/asm-powerpc/atomic.h
--- xenomai-orig/include/nucleus/asm-powerpc/atomic.h	1970-01-01 02:00:00.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-powerpc/atomic.h	2005-10-19 16:21:53.000000000 +0300
@@ -0,0 +1,383 @@
+/*
+ * Copyright (C) 2003,2004 Philippe Gerum <rpm@xenomai.org>.
+ * 
+ * 64-bit PowerPC adoption
+ *   copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
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
+
+#ifndef _XENO_ASM_POWERPC_ATOMIC_H
+#define _XENO_ASM_POWERPC_ATOMIC_H
+
+#ifdef CONFIG_PPC64
+static __inline__ void atomic_set_mask(unsigned long mask,
+				       unsigned long *ptr)
+{
+    __asm__ __volatile__ ("\n\
+1:	ldarx	5,0,%0 \n\
+	or	5,5,%1\n"
+"	stdcx.	5,0,%0 \n\
+	bne-	1b"
+	: /*no output*/
+	: "r" (ptr), "r" (mask)
+	: "r5", "cc", "memory");
+}
+
+static __inline__ void atomic_clear_mask(unsigned long mask,
+					 unsigned long *ptr)
+{
+    __asm__ __volatile__ ("\n\
+1:	ldarx	5,0,%0 \n\
+	andc	5,5,%1\n"
+"	stdcx.	5,0,%0 \n\
+	bne-	1b"
+	: /*no output*/
+	: "r" (ptr), "r" (mask)
+	: "r5", "cc", "memory");
+}
+#endif /* CONFIG_PPC64 */
+
+#include <asm/atomic.h>
+
+#ifdef __KERNEL__
+
+#include <linux/bitops.h>
+#include <asm/system.h>
+
+#define atomic_xchg(ptr,v)       xchg(ptr,v)
+#define atomic_cmpxchg(ptr,o,n)  cmpxchg(ptr,o,n)
+#define xnarch_memory_barrier()  smp_mb()
+
+ /* These are defined in arch/ppc/kernel/misc.S on 32-bit PowerPC */
+void atomic_set_mask(unsigned long mask, unsigned long *ptr);
+void atomic_clear_mask(unsigned long mask, unsigned long *ptr);
+
+#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
+#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
+#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
+#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
+#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
+#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
+#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
+#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
+
+#else /* !__KERNEL__ */
+
+#include <linux/config.h>
+
+#ifdef CONFIG_IBM405_ERR77
+#define PPC405_ERR77(ra,rb)	"dcbt " #ra "," #rb ";"
+#else
+#define PPC405_ERR77(ra,rb)
+#endif
+
+#ifdef CONFIG_SMP
+#define EIEIO_ON_SMP    "eieio\n"
+#define ISYNC_ON_SMP    "\n\tisync"
+#else
+#define EIEIO_ON_SMP
+#define ISYNC_ON_SMP
+#endif
+
+/*
+ * Atomic exchange
+ *
+ * Changes the memory location '*ptr' to be val and returns
+ * the previous value stored there.
+ *
+ * (lifted from linux/include/asm-powerpc/system.h)
+ */
+
+static __inline__ unsigned long 
+    __xchg_u32(volatile void *p, unsigned long val)
+{
+    unsigned long prev;
+    
+    __asm__ __volatile__(
+    EIEIO_ON_SMP
+"1: lwarx	%0,0,%2 \n"
+    PPC405_ERR77(0,%2)
+"   stwcx.	%3,0,%2 \n\
+    bne-	1b"
+    ISYNC_ON_SMP
+    : "=&r" (prev), "=m" (*(volatile unsigned int *)p)
+    : "r" (p), "r" (val), "m" (*(volatile unsigned int *)p)
+    : "cc", "memory");
+    
+    return prev;
+}
+
+#ifdef CONFIG_PPC64
+static __inline__ unsigned long
+    __xchg_u64(volatile void *p, unsigned long val)
+{
+    unsigned long prev;
+    
+    __asm__ __volatile__(
+    EIEIO_ON_SMP
+"1: ldarx	%0,0,%2 \n"
+    PPC405_ERR77(0,%2)
+"   stdcx.	%3,0,%2 \n\
+    bne-	1b"
+    ISYNC_ON_SMP
+    : "=&r" (prev), "=m" (*(volatile unsigned long *)p)
+    : "r" (p), "r" (val), "m" (*(volatile unsigned long *)p)
+    : "cc", "memory");
+
+    return prev;
+}
+#endif
+
+/*
+ * This function doesn't exist, so you'll get a linker error
+ * if something tries to do an invalid xchg().
+ */
+extern void __xnarch_xchg_called_with_bad_pointer(void);
+
+static __inline__ unsigned long
+    __xchg(volatile void *ptr, unsigned long x, unsigned int size)
+{
+    switch (size) {
+    case 4:
+	return __xchg_u32(ptr, x);
+#ifdef CONFIG_PPC64
+    case 8:
+	return __xchg_u64(ptr, x);
+#endif
+    }
+    __xnarch_xchg_called_with_bad_pointer();
+    return x;
+}
+
+#define atomic_xchg(ptr,x) \
+    ({                                                                         \
+	__typeof__(*(ptr)) _x_ = (x);                                          \
+	(__typeof__(*(ptr))) __xchg((ptr), (unsigned long)_x_, sizeof(*(ptr)));\
+    })
+
+/*
+ * Compare and exchange - if *p == old, set it to new,
+ * and return the old value of *p.
+ *
+ * (lifted from linux/include/asm-powerpc/system.h)
+ */
+static __inline__ unsigned long
+    __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long n)
+{
+    unsigned int prev;
+
+    __asm__ __volatile__ (
+    EIEIO_ON_SMP
+"1: lwarx	%0,0,%2		# __cmpxchg_u32\n\
+    cmpw	0,%0,%3\n\
+    bne-	2f\n"
+    PPC405_ERR77(0,%2)
+"   stwcx.	%4,0,%2\n\
+    bne-	1b"
+    ISYNC_ON_SMP
+    "\n\
+2:"
+    : "=&r" (prev), "=m" (*p)
+    : "r" (p), "r" (old), "r" (n), "m" (*p)
+    : "cc", "memory");
+
+    return prev;
+}
+
+#ifdef CONFIG_PPC64
+static __inline__ unsigned long
+    __cmpxchg_u64(volatile long *p, unsigned long old, unsigned long n)
+{
+    unsigned long prev;
+
+    __asm__ __volatile__ (
+    EIEIO_ON_SMP
+"1: ldarx	%0,0,%2		# __cmpxchg_u64\n\
+    cmpd	0,%0,%3\n\
+    bne-	2f\n\
+    stdcx.	%4,0,%2\n\
+    bne-	1b"
+    ISYNC_ON_SMP
+    "\n\
+2:"
+    : "=&r" (prev), "=m" (*p)
+    : "r" (p), "r" (old), "r" (n), "m" (*p)
+    : "cc", "memory");
+
+    return prev;
+}
+#endif
+
+/* This function doesn't exist, so you'll get a linker error
+ * if something tries to do an invalid cmpxchg(). */
+extern void __xnarch_cmpxchg_called_with_bad_pointer(void);
+
+static __inline__ unsigned long
+    __cmpxchg(volatile void *ptr, unsigned long old, unsigned long n,
+		unsigned int size)
+{
+    switch (size) {
+    case 4:
+	return __cmpxchg_u32(ptr, old, n);
+#ifdef CONFIG_PPC64
+    case 8:
+	return __cmpxchg_u64(ptr, old, n);
+#endif
+    }
+    __xnarch_cmpxchg_called_with_bad_pointer();
+    return old;
+}
+
+#define atomic_cmpxchg(ptr,o,n) \
+    ({									\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	\
+	(unsigned long)_n_, sizeof(*(ptr)));				\
+    })
+
+
+/*
+ * Atomic operations lifted from linux/include/asm-powerpc/atomic.h 
+ * (currently asm-ppc64/atomic.h exposes these)
+ */
+#ifndef CONFIG_PPC64
+static __inline__ void atomic_inc(atomic_t *v)
+{
+    int t;
+
+    __asm__ __volatile__(
+"1: lwarx	%0,0,%2		# atomic_inc\n\
+    addic	%0,%0,1\n"
+    PPC405_ERR77(0,%2)
+"   stwcx.	%0,0,%2 \n\
+    bne-	1b"
+    : "=&r" (t), "=m" (v->counter)
+    : "r" (&v->counter), "m" (v->counter)
+    : "cc");
+}
+
+static __inline__ int atomic_inc_return(atomic_t *v)
+{
+    int t;
+
+    __asm__ __volatile__(
+    EIEIO_ON_SMP
+"1: lwarx	%0,0,%1		# atomic_inc_return\n\
+    addic	%0,%0,1\n"
+    PPC405_ERR77(0,%1)
+"   stwcx.	%0,0,%1 \n\
+    bne-	1b"
+    ISYNC_ON_SMP
+    : "=&r" (t)
+    : "r" (&v->counter)
+    : "cc", "memory");
+
+    return t;
+}
+
+static __inline__ void atomic_dec(atomic_t *v)
+{
+    int t;
+
+    __asm__ __volatile__(
+"1: lwarx	%0,0,%2		# atomic_dec\n\
+    addic	%0,%0,-1\n"
+    PPC405_ERR77(0,%2)\
+"   stwcx.	%0,0,%2\n\
+    bne-	1b"
+    : "=&r" (t), "=m" (v->counter)
+    : "r" (&v->counter), "m" (v->counter)
+    : "cc");
+}
+
+static __inline__ int atomic_dec_return(atomic_t *v)
+{
+    int t;
+
+    __asm__ __volatile__(
+    EIEIO_ON_SMP
+"1: lwarx	%0,0,%1		# atomic_dec_return\n\
+    addic	%0,%0,-1\n"
+    PPC405_ERR77(0,%1)
+"   stwcx.	%0,0,%1\n\
+    bne-	1b"
+    ISYNC_ON_SMP
+    : "=&r" (t)
+    : "r" (&v->counter)
+    : "cc", "memory");
+
+    return t;
+}
+#endif /* CONFIG_PPC64 */
+
+/*
+ * Atomic mask operations from linux/arch/ppc/kernel/misc.S
+ * (for 64-bit PowerPC already defined above)
+ */
+#ifndef CONFIG_PPC64
+static __inline__ void atomic_set_mask(unsigned long mask,
+				       unsigned long *ptr)
+{
+    __asm__ __volatile__ ("\n\
+1:	lwarx	5,0,%0 \n\
+	or	5,5,%1\n"
+	PPC405_ERR77(0,%0) \
+"	stwcx.	5,0,%0 \n\
+	bne-	1b"
+	: /*no output*/
+	: "r" (ptr), "r" (mask)
+	: "r5", "cc", "memory");
+}
+
+static __inline__ void atomic_clear_mask(unsigned long mask,
+					 unsigned long *ptr)
+{
+    __asm__ __volatile__ ("\n\
+1:	lwarx	5,0,%0 \n\
+	andc	5,5,%1\n"
+	PPC405_ERR77(0,%0) \
+"	stwcx.	5,0,%0 \n\
+	bne-	1b"
+	: /*no output*/
+	: "r" (ptr), "r" (mask)
+	: "r5", "cc", "memory");
+}
+#endif /* CONFIG_PPC64 */
+
+#define xnarch_memory_barrier()  __asm__ __volatile__("": : :"memory")
+
+#define xnarch_atomic_set(pcounter,i)          (((pcounter)->counter) = (i))
+#define xnarch_atomic_get(pcounter)            ((pcounter)->counter)
+#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
+#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
+#define xnarch_atomic_inc_and_test(pcounter)   (atomic_inc_return(pcounter) == 0)
+#define xnarch_atomic_dec_and_test(pcounter)   (atomic_dec_return(pcounter) == 0)
+#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
+#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
+
+#define cpu_relax()  xnarch_memory_barrier()
+
+#endif /* __KERNEL__ */
+
+typedef atomic_t atomic_counter_t;
+typedef unsigned long atomic_flags_t;
+
+#define xnarch_atomic_xchg(ptr,x) atomic_xchg(ptr,x)
+#define xnarch_atomic_cmpxchg(ptr,o,n) atomic_cmpxchg(ptr,o,n)
+
+#endif /* !_XENO_ASM_POWERPC_ATOMIC_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-powerpc/calibration.h xenomai-devel/include/nucleus/asm-powerpc/calibration.h
--- xenomai-orig/include/nucleus/asm-powerpc/calibration.h	1970-01-01 02:00:00.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-powerpc/calibration.h	2005-10-18 20:27:12.000000000 +0300
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2001,2002,2003,2004,2005 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * 64-bit PowerPC adoption
+ *   copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
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
+
+#ifndef _XENO_ASM_POWERPC_CALIBRATION_H
+#define _XENO_ASM_POWERPC_CALIBRATION_H
+
+#include <xeno_config.h>
+#include <asm/delay.h>
+
+#define __bogomips (loops_per_jiffy/(500000/HZ))
+
+static inline unsigned long xnarch_get_sched_latency (void)
+
+{
+#if CONFIG_XENO_HW_SCHED_LATENCY != 0
+#define __sched_latency CONFIG_XENO_HW_SCHED_LATENCY
+#else
+
+#ifdef CONFIG_PPC64
+#define __sched_latency 1000
+#else
+#define __sched_latency 9500
+#endif
+	
+#endif /* CONFIG_XENO_HW_SCHED_LATENCY */
+
+    return __sched_latency;
+}
+
+#undef __sched_latency
+#undef __bogomips
+
+#endif /* !_XENO_ASM_POWERPC_CALIBRATION_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-powerpc/GNUmakefile.am xenomai-devel/include/nucleus/asm-powerpc/GNUmakefile.am
--- xenomai-orig/include/nucleus/asm-powerpc/GNUmakefile.am	1970-01-01 02:00:00.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-powerpc/GNUmakefile.am	2005-10-23 11:24:06.000000000 +0300
@@ -0,0 +1,17 @@
+includedir = $(prefix)/include/nucleus/asm-powerpc
+
+include_HEADERS = \
+		atomic.h \
+		calibration.h \
+		hal.h \
+		system.h \
+		syscall.h \
+		uart.h
+
+install-data-local:
+	$(mkinstalldirs) $(DESTDIR)$(includedir)
+	rm -f $(DESTDIR)$(includedir)/../asm
+	$(LN_S) asm-powerpc $(DESTDIR)$(includedir)/../asm
+
+uninstall-local:
+	$(RM) $(DESTDIR)$(includedir)/../asm
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-powerpc/hal.h xenomai-devel/include/nucleus/asm-powerpc/hal.h
--- xenomai-orig/include/nucleus/asm-powerpc/hal.h	1970-01-01 02:00:00.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-powerpc/hal.h	2005-10-19 16:23:26.000000000 +0300
@@ -0,0 +1,330 @@
+/**
+ *   @ingroup hal
+ *   @file
+ *
+ *   Real-Time Hardware Abstraction Layer for PowerPC.
+ *
+ *   Copyright &copy; 2002-2004 Philippe Gerum.
+ *
+ *   64-bit PowerPC adoption
+ *     copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
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
+
+#ifndef _XENO_ASM_POWERPC_HAL_H
+#define _XENO_ASM_POWERPC_HAL_H
+
+#include <nucleus/asm-generic/hal.h>	/* Read the generic bits. */
+#include <asm/div64.h>
+
+typedef unsigned long long rthal_time_t;
+
+#define __rthal_u64tou32(ull, h, l) ({                  \
+        union { unsigned long long _ull;                \
+            struct { u_long _h; u_long _l; } _s; } _u;  \
+        _u._ull = (ull);                                \
+        (h) = _u._s._h;                                 \
+        (l) = _u._s._l;                                 \
+        })
+
+#define __rthal_u64fromu32(h, l) ({                     \
+        union { unsigned long long _ull;                \
+            struct { u_long _h; u_long _l; } _s; } _u;  \
+        _u._s._h = (h);                                 \
+        _u._s._l = (l);                                 \
+        _u._ull;                                        \
+        })
+
+static inline unsigned long long rthal_ullmul(const unsigned long m0, 
+					      const unsigned long m1)
+{
+    return (unsigned long long) m0 * m1;
+}
+
+static inline unsigned long long rthal_ulldiv (unsigned long long ull,
+					       const unsigned long uld,
+					       unsigned long *const rp)
+{
+#if defined(__KERNEL__) && BITS_PER_LONG == 32
+    const unsigned long r = __div64_32(&ull, uld);
+#else /* !__KERNEL__ || BITS_PER_LONG == 64 */
+    const unsigned long r = ull % uld;
+    ull /= uld;
+#endif /* __KERNEL__ */
+
+    if (rp)
+	*rp = r;
+
+    return ull;
+}
+
+#define rthal_uldivrem(ull,ul,rp) ((u_long) rthal_ulldiv((ull),(ul),(rp)))
+
+static inline int rthal_imuldiv (int i, int mult, int div) {
+
+    /* Returns (int)i = (unsigned long long)i*(u_long)(mult)/(u_long)div. */
+    const unsigned long long ull = rthal_ullmul(i, mult);
+    return rthal_uldivrem(ull, div, NULL);
+}
+
+static inline __attribute_const__
+unsigned long long __rthal_ullimd (const unsigned long long op,
+                                   const unsigned long m,
+                                   const unsigned long d)
+{
+#ifdef CONFIG_PPC64
+    return (op*m)/d;
+#else /* !CONFIG_PPC64 */
+    u_long oph, opl, tlh, tll, qh, rh, ql;
+    unsigned long long th, tl;
+
+    __rthal_u64tou32(op, oph, opl);
+    tl = rthal_ullmul(opl, m);
+    __rthal_u64tou32(tl, tlh, tll);
+    th = rthal_ullmul(oph, m);
+    th += tlh;
+
+    qh = rthal_uldivrem(th, d, &rh);
+    th = __rthal_u64fromu32(rh, tll);
+    ql = rthal_uldivrem(th, d, NULL);
+    return __rthal_u64fromu32(qh, ql);
+#endif /* CONFIG_PPC64 */
+}
+
+static inline long long rthal_llimd (long long op,
+                                     unsigned long m,
+                                     unsigned long d)
+{
+
+    if(op < 0LL)
+        return -__rthal_ullimd(-op, m, d);
+    return __rthal_ullimd(op, m, d);
+}
+
+static inline __attribute_const__ unsigned long ffnz (unsigned long ul) {
+#ifdef CONFIG_PPC64
+    __asm__ ("cntlzd %0, %1" : "=r" (ul) : "r" (ul & (-ul)));
+    return 63 - ul;
+#else
+    __asm__ ("cntlzw %0, %1" : "=r" (ul) : "r" (ul & (-ul)));
+    return 31 - ul;
+#endif
+}
+
+#if defined(__KERNEL__) && !defined(__cplusplus)
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/timex.h>
+#include <nucleus/asm/atomic.h>
+#include <asm/processor.h>
+
+#ifdef CONFIG_ADEOS_CORE
+#define RTHAL_TIMER_IRQ   ADEOS_TIMER_VIRQ
+#else /* !CONFIG_ADEOS_CORE */
+#define RTHAL_TIMER_IRQ   IPIPE_TIMER_VIRQ
+#endif /* CONFIG_ADEOS_CORE */
+
+#define rthal_irq_descp(irq)	(&irq_desc[(irq)])
+
+static inline unsigned long long rthal_rdtsc (void) {
+    unsigned long long t;
+    rthal_read_tsc(t);
+    return t;
+}
+
+#if defined(CONFIG_ADEOS_CORE) && !defined(CONFIG_ADEOS_NOTHREADS)
+
+/* Since real-time interrupt handlers are called on behalf of the
+   Xenomai domain stack, we cannot infere the "current" Linux task
+   address using %esp. We must use the suspended Linux domain's stack
+   pointer instead. */
+
+static inline struct task_struct *rthal_root_host_task (int cpuid) {
+#ifdef CONFIG_PPC64
+    return ((struct thread_info *)(rthal_root_domain->esp[cpuid] & (~(16384UL-1UL))))->task;
+#else
+    return ((struct thread_info *)(rthal_root_domain->esp[cpuid] & (~8191UL)))->task;
+#endif
+}
+
+static inline struct task_struct *rthal_current_host_task (int cpuid)
+
+{
+    register unsigned long esp asm ("r1");
+
+#ifdef CONFIG_PPC64
+    if (esp >= rthal_domain.estackbase[cpuid] && 
+	    esp < rthal_domain.estackbase[cpuid] + 16384)
+	return rthal_root_host_task(cpuid);
+
+    return current;
+#else /* !CONFIG_PPC64 */
+    if (esp >= rthal_domain.estackbase[cpuid] &&
+	    esp < rthal_domain.estackbase[cpuid] + 8192)
+	return rthal_root_host_task(cpuid);
+
+    return current;
+#endif /* CONFIG_PPC64 */
+}
+
+#else /* !CONFIG_ADEOS_CORE || CONFIG_ADEOS_NOTHREADS */
+
+static inline struct task_struct *rthal_root_host_task (int cpuid) {
+    return current;
+}
+
+static inline struct task_struct *rthal_current_host_task (int cpuid) {
+    return current;
+}
+
+#endif /* CONFIG_ADEOS_CORE && !CONFIG_ADEOS_NOTHREADS */
+
+static inline void rthal_timer_program_shot (unsigned long delay)
+{
+    if(!delay) delay = 1;
+#ifdef CONFIG_40x
+    mtspr(SPRN_PIT,delay);
+#else /* !CONFIG_40x */
+    set_dec(delay);
+#endif /* CONFIG_40x */
+}
+
+    /* Private interface -- Internal use only */
+
+/* The following must be kept in sync w/ rthal_switch_context() in
+   switch.S */
+#ifdef CONFIG_PPC64
+#define RTHAL_SWITCH_FRAME_SIZE  224
+#else
+#define RTHAL_SWITCH_FRAME_SIZE  108
+#endif
+
+void rthal_switch_context(unsigned long *out_kspp,
+			  unsigned long *in_kspp);
+
+#ifdef CONFIG_XENO_HW_FPU
+
+typedef struct rthal_fpenv {
+    
+    /* This layout must follow exactely the definition of the FPU
+       backup area in a PPC thread struct available from
+       <asm-ppc/processor.h>. Specifically, fpr[] an fpscr words must
+       be contiguous in memory (see arch/ppc/hal/fpu.S). */
+
+    double fpr[32];
+#ifndef CONFIG_PPC64
+    unsigned long fpscr_pad;	/* <= Hi-word of the FPR used to */
+#endif
+    unsigned long fpscr;	/* retrieve the FPSCR. */
+
+} rthal_fpenv_t;
+
+void rthal_init_fpu(rthal_fpenv_t *fpuenv);
+
+void rthal_save_fpu(rthal_fpenv_t *fpuenv);
+
+void rthal_restore_fpu(rthal_fpenv_t *fpuenv);
+
+#ifndef CONFIG_SMP
+#define rthal_get_fpu_owner(cur) last_task_used_math
+#else /* CONFIG_SMP */
+#define rthal_get_fpu_owner(cur) ({                             \
+    struct task_struct * _cur = (cur);                          \
+    ((_cur->thread.regs && (_cur->thread.regs->msr & MSR_FP))   \
+     ? _cur : NULL);                                            \
+})
+#endif /* CONFIG_SMP */
+
+#ifdef CONFIG_PPC64
+#define rthal_disable_fpu() ({                          \
+    register unsigned long _msr;                        \
+    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
+    __asm__ __volatile__ ( "mtmsrd %0"                  \
+                           : /* no output */            \
+                           : "r"(_msr & ~(MSR_FP))      \
+                           : "memory" );                \
+})
+
+#define rthal_enable_fpu() ({                           \
+    register unsigned long _msr;                        \
+    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
+    __asm__ __volatile__ ( "mtmsrd %0"                  \
+                           : /* no output */            \
+                           : "r"(_msr | MSR_FP)         \
+                           : "memory" );                \
+})
+#else /* !CONFIG_PPC64 */
+#define rthal_disable_fpu() ({                          \
+    register unsigned long _msr;                        \
+    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
+    __asm__ __volatile__ ( "mtmsr %0"                   \
+                           : /* no output */            \
+                           : "r"(_msr & ~(MSR_FP))      \
+                           : "memory" );                \
+})
+
+#define rthal_enable_fpu() ({                           \
+    register unsigned long _msr;                        \
+    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
+    __asm__ __volatile__ ( "mtmsr %0"                   \
+                           : /* no output */            \
+                           : "r"(_msr | MSR_FP)         \
+                           : "memory" );                \
+})
+#endif /* CONFIG_PPC64 */
+
+#endif /* CONFIG_XENO_HW_FPU */
+
+static const char *const rthal_fault_labels[] = {
+#ifdef CONFIG_PPC64
+    [0] = "Data or instruction access",
+    [1] = "Alignment",
+    [2] =  "AltiVec unavailable",
+    [3] =  "Program check exception",
+    [4] =  "Machine check exception",
+    [5] =  "Unknown",
+    [6] =  "Instruction breakpoint",
+    [7] =  "Single-step exception",
+    [8] =  "Non-recoverable exception",
+    [9] =  "AltiVec assist",
+    [10] = "System reset exception",
+    [11] = "Kernel FP unavailable",
+    [12] = "Performance monitor",
+    [13] = NULL
+#else /* !CONFIG_PPC64 */
+    [0] = "Data or instruction access",
+    [1] = "Alignment",
+    [2] = "Altivec unavailable",
+    [3] = "Program check exception",
+    [4] = "Machine check exception",
+    [5] = "Unknown",
+    [6] = "Instruction breakpoint",
+    [7] = "Run mode exception",
+    [8] = "Single-step exception",
+    [9] = "Non-recoverable exception",
+    [10] = "Software emulation",
+    [11] = "Debug",
+    [12] = "SPE",
+    [13] = "Altivec assist",
+    [14] = NULL
+#endif /* CONFIG_PPC64 */
+};
+
+#endif /* __KERNEL__ && !__cplusplus */
+
+#endif /* !_XENO_ASM_POWERPC_HAL_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-powerpc/syscall.h xenomai-devel/include/nucleus/asm-powerpc/syscall.h
--- xenomai-orig/include/nucleus/asm-powerpc/syscall.h	1970-01-01 02:00:00.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-powerpc/syscall.h	2005-10-19 16:23:44.000000000 +0300
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * 64-bit PowerPC adoption
+ *   copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm  
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
+
+#ifndef _XENO_ASM_POWERPC_SYSCALL_H
+#define _XENO_ASM_POWERPC_SYSCALL_H
+
+#include <xeno_config.h>
+#include <asm/ptrace.h>
+#include <nucleus/asm-generic/syscall.h>
+
+/*
+ * Some of the following macros have been adapted from Linux's
+ * implementation of the syscall mechanism in <asm-ppc[64]/unistd.h>:
+ *
+ * The following code defines an inline syscall mechanism used by
+ * Xenomai's real-time interfaces to invoke the skin module
+ * services in kernel space.
+ */
+
+#define XENOMAI_DO_SYSCALL(nr, id, op, args...)			\
+  ({								\
+	register unsigned long __sc_0  __asm__ ("r0");		\
+	register unsigned long __sc_3  __asm__ ("r3");		\
+	register unsigned long __sc_4  __asm__ ("r4");		\
+	register unsigned long __sc_5  __asm__ ("r5");		\
+	register unsigned long __sc_6  __asm__ ("r6");		\
+	register unsigned long __sc_7  __asm__ ("r7");		\
+								\
+	LOADARGS_##nr(__xn_mux_code(id,op), args);		\
+	__asm__ __volatile__					\
+		("sc           \n\t"				\
+		 "mfcr %0      "				\
+		: "=&r" (__sc_0),				\
+		  "=&r" (__sc_3),  "=&r" (__sc_4),		\
+		  "=&r" (__sc_5),  "=&r" (__sc_6),		\
+		  "=&r" (__sc_7)				\
+		: ASM_INPUT_##nr				\
+		: "cr0", "ctr", "memory",			\
+		  "r8", "r9", "r10","r11", "r12");		\
+	(int)((__sc_0 & (1 << 28)) ? -__sc_3 : __sc_3);		\
+  })
+
+#define LOADARGS_0(muxcode, dummy...)				\
+	__sc_0 = muxcode
+#define LOADARGS_1(muxcode, arg1)				\
+	LOADARGS_0(muxcode);					\
+	__sc_3 = (unsigned long) (arg1)
+#define LOADARGS_2(muxcode, arg1, arg2)				\
+	LOADARGS_1(muxcode, arg1);				\
+	__sc_4 = (unsigned long) (arg2)
+#define LOADARGS_3(muxcode, arg1, arg2, arg3)			\
+	LOADARGS_2(muxcode, arg1, arg2);			\
+	__sc_5 = (unsigned long) (arg3)
+#define LOADARGS_4(muxcode, arg1, arg2, arg3, arg4)		\
+	LOADARGS_3(muxcode, arg1, arg2, arg3);			\
+	__sc_6 = (unsigned long) (arg4)
+#define LOADARGS_5(muxcode, arg1, arg2, arg3, arg4, arg5)	\
+	LOADARGS_4(muxcode, arg1, arg2, arg3, arg4);		\
+	__sc_7 = (unsigned long) (arg5)
+
+#define ASM_INPUT_0 "0" (__sc_0)
+#define ASM_INPUT_1 ASM_INPUT_0, "1" (__sc_3)
+#define ASM_INPUT_2 ASM_INPUT_1, "2" (__sc_4)
+#define ASM_INPUT_3 ASM_INPUT_2, "3" (__sc_5)
+#define ASM_INPUT_4 ASM_INPUT_3, "4" (__sc_6)
+#define ASM_INPUT_5 ASM_INPUT_4, "5" (__sc_7)
+
+/* Register mapping for accessing syscall args. */
+
+#define __xn_reg_mux(regs)    ((regs)->gpr[0])
+#define __xn_reg_rval(regs)   ((regs)->gpr[3])
+#define __xn_reg_arg1(regs)   ((regs)->gpr[3])
+#define __xn_reg_arg2(regs)   ((regs)->gpr[4])
+#define __xn_reg_arg3(regs)   ((regs)->gpr[5])
+#define __xn_reg_arg4(regs)   ((regs)->gpr[6])
+#define __xn_reg_arg5(regs)   ((regs)->gpr[7])
+
+#define __xn_reg_mux_p(regs)        ((__xn_reg_mux(regs) & 0xffff) == __xn_sys_mux)
+#define __xn_mux_id(regs)           ((__xn_reg_mux(regs) >> 16) & 0xff)
+#define __xn_mux_op(regs)           ((__xn_reg_mux(regs) >> 24) & 0xff)
+#define __xn_mux_code(id,op)        ((op << 24)|((id << 16) & 0xff0000)|(__xn_sys_mux & 0xffff))
+
+#define XENOMAI_SYSCALL0(op)                XENOMAI_DO_SYSCALL(0,0,op)
+#define XENOMAI_SYSCALL1(op,a1)             XENOMAI_DO_SYSCALL(1,0,op,a1)
+#define XENOMAI_SYSCALL2(op,a1,a2)          XENOMAI_DO_SYSCALL(2,0,op,a1,a2)
+#define XENOMAI_SYSCALL3(op,a1,a2,a3)       XENOMAI_DO_SYSCALL(3,0,op,a1,a2,a3)
+#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)    XENOMAI_DO_SYSCALL(4,0,op,a1,a2,a3,a4)
+#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,0,op,a1,a2,a3,a4,a5)
+
+#define XENOMAI_SKINCALL0(id,op)                XENOMAI_DO_SYSCALL(0,id,op)
+#define XENOMAI_SKINCALL1(id,op,a1)             XENOMAI_DO_SYSCALL(1,id,op,a1)
+#define XENOMAI_SKINCALL2(id,op,a1,a2)          XENOMAI_DO_SYSCALL(2,id,op,a1,a2)
+#define XENOMAI_SKINCALL3(id,op,a1,a2,a3)       XENOMAI_DO_SYSCALL(3,id,op,a1,a2,a3)
+#define XENOMAI_SKINCALL4(id,op,a1,a2,a3,a4)    XENOMAI_DO_SYSCALL(4,id,op,a1,a2,a3,a4)
+#define XENOMAI_SKINCALL5(id,op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,id,op,a1,a2,a3,a4,a5)
+
+#ifdef __KERNEL__
+
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+
+/* Our own set of copy-to/from-user macros which must bypass
+   might_sleep() checks. The caller cannot fault and is expected to
+   have checked for bad range before using the copy macros, so we
+   should not have to care about the result. */
+#define __xn_copy_from_user(task,dstP,srcP,n)  \
+    ({ int err = __copy_from_user_inatomic(dstP,srcP,n); err; })
+#define __xn_copy_to_user(task,dstP,srcP,n)  \
+    ({ int err = __copy_to_user_inatomic(dstP,srcP,n); err; })
+#define __xn_put_user(task,src,dstP)           __put_user(src,dstP)
+#define __xn_get_user(task,dst,srcP)           __get_user(dst,srcP)
+#define __xn_strncpy_from_user(task,dstP,srcP,n)    __strncpy_from_user(dstP,srcP,n)
+
+#ifdef CONFIG_PPC64
+#define __xn_range_ok(task,addr,size) \
+		__access_ok(((__force unsigned long)(addr)),(size),(task->thread.fs))
+#else
+#define __xn_range_ok(task,addr,size) \
+        ((unsigned long)(addr) <= (task)->thread.fs.seg \
+	 && ((size) == 0 || (size) - 1 <= (task)->thread.fs.seg - (unsigned long)(addr)))
+#endif
+
+#define __xn_access_ok(task,type,addr,size)  __xn_range_ok((task),(addr),(size))
+
+/* Purposedly used inlines and not macros for the following routines
+   so that we don't risk spurious side-effects on the value arg. */
+
+static inline void __xn_success_return(struct pt_regs *regs, int v) {
+    __xn_reg_rval(regs) = v;
+}
+
+static inline void __xn_error_return(struct pt_regs *regs, int v) {
+    /* We currently never set the SO bit for marking errors, even if
+     * we always test it upon syscall return. */
+    __xn_reg_rval(regs) = v;
+}
+
+static inline void __xn_status_return(struct pt_regs *regs, int v) {
+    __xn_reg_rval(regs) = v;
+}
+
+static inline int __xn_interrupted_p(struct pt_regs *regs) {
+    return __xn_reg_rval(regs) == -EINTR;
+}
+
+#else /* !__KERNEL__ */
+
+#define CONFIG_XENO_HW_DIRECT_TSC 1
+
+static inline unsigned long long __xn_rdtsc (void)
+#if defined(__powerpc64__)
+{
+	    unsigned long long t;
+
+	        __asm__ __volatile__ ("mftb %0\n" : "=r" (t));
+		    return t;
+}
+#else /* !__powerpc64__ */
+{
+    union {
+	unsigned long long t;
+	unsigned long v[2];
+    } u;
+    unsigned long __tbu;
+
+    __asm__ __volatile__ ("1: mftbu %0\n"
+			  "mftb %1\n"
+			  "mftbu %2\n"
+			  "cmpw %2,%0\n"
+			  "bne- 1b\n"
+			  :"=r" (u.v[0]),
+			  "=r" (u.v[1]),
+			  "=r" (__tbu));
+    return u.t;
+}
+#endif /* __powerpc64__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* !_XENO_ASM_POWERPC_SYSCALL_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-powerpc/system.h xenomai-devel/include/nucleus/asm-powerpc/system.h
--- xenomai-orig/include/nucleus/asm-powerpc/system.h	1970-01-01 02:00:00.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-powerpc/system.h	2005-10-18 22:30:41.000000000 +0300
@@ -0,0 +1,688 @@
+/*
+ * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * 64-bit PowerPC adoption
+ *   copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
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
+
+#ifndef _XENO_ASM_POWERPC_SYSTEM_H
+#define _XENO_ASM_POWERPC_SYSTEM_H
+
+#include <nucleus/asm-generic/system.h>
+
+#ifdef __KERNEL__
+
+#include <linux/config.h>
+#include <linux/ptrace.h>
+
+#ifdef CONFIG_ADEOS_CORE
+#ifdef CONFIG_PPC64
+#if ADEOS_RELEASE_NUMBER < 0x02060201
+#error "Adeos 2.6r2c1/ppc64 or above is required to run this software; please upgrade."
+#error "See http://download.gna.org/adeos/patches/v2.6/ppc64/"
+#endif
+#else /* !CONFIG_PPC64 */
+#if ADEOS_RELEASE_NUMBER < 0x02060703
+#error "Adeos 2.6r7c3/ppc or above is required to run this software; please upgrade."
+#error "See http://download.gna.org/adeos/patches/v2.6/ppc/"
+#endif
+#endif /* CONFIG_PPC64 */
+#endif /* CONFIG_ADEOS_CORE */
+
+#define XNARCH_DEFAULT_TICK     1000000 /* ns, i.e. 1ms */
+#define XNARCH_HOST_TICK        (1000000000UL/HZ)
+
+#ifdef CONFIG_PPC64
+#define XNARCH_THREAD_STACKSZ   16384
+#else
+#define XNARCH_THREAD_STACKSZ   4096
+#endif
+
+#define xnarch_stack_size(tcb)  ((tcb)->stacksize)
+#define xnarch_user_task(tcb)   ((tcb)->user_task)
+#define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
+
+#define xnarch_alloc_stack xnmalloc
+#define xnarch_free_stack  xnfree
+
+struct xnthread;
+struct task_struct;
+
+typedef struct xnarchtcb {	/* Per-thread arch-dependent block */
+
+    /* Kernel mode side */
+
+#ifdef CONFIG_XENO_HW_FPU
+    /* We only care for basic FPU handling in kernel-space; Altivec
+       and SPE are not available to kernel-based nucleus threads. */
+    rthal_fpenv_t fpuenv  __attribute__ ((aligned (16)));
+    rthal_fpenv_t *fpup;	/* Pointer to the FPU backup area */
+    struct task_struct *user_fpu_owner;
+    /* Pointer the the FPU owner in userspace:
+       - NULL for RT K threads,
+       - last_task_used_math for Linux US threads (only current or NULL when MP)
+       - current for RT US threads.
+    */
+#define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
+#else /* !CONFIG_XENO_HW_FPU */
+#define xnarch_fpu_ptr(tcb)     NULL
+#endif /* CONFIG_XENO_HW_FPU */
+
+    unsigned stacksize;		/* Aligned size of stack (bytes) */
+    unsigned long *stackbase;	/* Stack space */
+    unsigned long ksp;		/* Saved KSP for kernel-based threads */
+    unsigned long *kspp;	/* Pointer to saved KSP (&ksp or &user->thread.ksp) */
+
+    /* User mode side */
+    struct task_struct *user_task;	/* Shadowed user-space task */
+    struct task_struct *active_task;	/* Active user-space task */
+
+    /* Init block */
+    struct xnthread *self;
+    int imask;
+    const char *name;
+    void (*entry)(void *cookie);
+    void *cookie;
+
+} xnarchtcb_t;
+
+typedef struct xnarch_fltinfo {
+
+    unsigned exception;
+    struct pt_regs *regs;
+
+} xnarch_fltinfo_t;
+
+#define xnarch_fault_trap(fi)   ((unsigned int)(fi)->regs->trap)
+#define xnarch_fault_code(fi)   ((fi)->regs->dar)
+#define xnarch_fault_pc(fi)     ((fi)->regs->nip)
+#define xnarch_fault_pc(fi)     ((fi)->regs->nip)
+/* FIXME: FPU faults ignored by the nanokernel on PPC. */
+#define xnarch_fault_fpu_p(fi)  (0)
+/* The following predicates are only usable over a regular Linux stack
+   context. */
+#ifdef CONFIG_ADEOS_CORE
+#define xnarch_fault_pf_p(fi)   ((fi)->exception == ADEOS_ACCESS_TRAP)
+#ifdef CONFIG_PPC64
+#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
+				 ((fi)->exception == ADEOS_IABR_TRAP || \
+				  (fi)->exception == ADEOS_SSTEP_TRAP || \
+				  (fi)->exception == ADEOS_PERFMON_TRAP))
+#else /* !CONFIG_PPC64 */
+#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
+				 ((fi)->exception == ADEOS_IABR_TRAP || \
+				  (fi)->exception == ADEOS_SSTEP_TRAP || \
+				  (fi)->exception == ADEOS_DEBUG_TRAP))
+#endif /* CONFIG_PPC64 */
+#else /* !CONFIG_ADEOS_CORE */
+#define xnarch_fault_pf_p(fi)   ((fi)->exception == IPIPE_TRAP_ACCESS)
+#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
+				 ((fi)->exception == IPIPE_TRAP_IABR || \
+				  (fi)->exception == IPIPE_TRAP_SSTEP || \
+				  (fi)->exception == IPIPE_TRAP_DEBUG))
+#endif /* CONFIG_ADEOS_CORE */
+
+#define xnarch_fault_notify(fi) (!xnarch_fault_bp_p(fi))
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+static inline void *xnarch_sysalloc (u_long bytes)
+
+{
+#if 0	/* FIXME: likely on-demand mapping bug here */
+    if (bytes >= 128*1024)
+	return vmalloc(bytes);
+#endif
+
+    return kmalloc(bytes,GFP_KERNEL);
+}
+
+static inline void xnarch_sysfree (void *chunk, u_long bytes)
+
+{
+#if 0	/* FIXME: likely on-demand mapping bug here */
+    if (bytes >= 128*1024)
+	vfree(chunk);
+    else
+#endif
+	kfree(chunk);
+}
+
+static inline void xnarch_relay_tick (void)
+
+{
+    rthal_irq_host_pend(RTHAL_TIMER_IRQ);
+}
+
+#ifdef XENO_POD_MODULE
+
+void xnpod_welcome_thread(struct xnthread *);
+
+void xnpod_delete_thread(struct xnthread *);
+
+static inline int xnarch_start_timer (unsigned long ns,
+				      void (*tickhandler)(void))
+{
+    return rthal_timer_request(tickhandler,ns);
+}
+
+static inline void xnarch_leave_root (xnarchtcb_t *rootcb)
+
+{
+    rthal_declare_cpuid;
+
+    rthal_load_cpuid();
+
+    /* rthal_cpu_realtime is only tested for the current processor,
+       and always inside a critical section. */
+    __set_bit(cpuid,&rthal_cpu_realtime);
+    /* Remember the preempted Linux task pointer. */
+    rootcb->user_task = rootcb->active_task = rthal_current_host_task(cpuid);
+#ifdef CONFIG_XENO_HW_FPU
+    rootcb->user_fpu_owner = rthal_get_fpu_owner(rootcb->user_task);
+    /* So that xnarch_save_fpu() will operate on the right FPU area. */
+    rootcb->fpup = (rootcb->user_fpu_owner
+                    ? (rthal_fpenv_t *)&rootcb->user_fpu_owner->thread.fpr[0]
+                    : NULL);
+#endif /* CONFIG_XENO_HW_FPU */
+}
+
+static inline void xnarch_enter_root (xnarchtcb_t *rootcb) {
+    __clear_bit(xnarch_current_cpu(),&rthal_cpu_realtime);
+}
+
+static inline void xnarch_switch_to (xnarchtcb_t *out_tcb,
+				     xnarchtcb_t *in_tcb)
+{
+    struct task_struct *prev = out_tcb->active_task;
+    struct task_struct *next = in_tcb->user_task;
+
+    in_tcb->active_task = next ?: prev;
+
+    if (next && next != prev) /* Switch to new user-space thread? */
+	{
+	struct mm_struct *mm = next->active_mm;
+
+	/* Switch the mm context.*/
+
+#ifdef CONFIG_PPC64
+#ifdef CONFIG_ALTIVEC
+	/* Don't rely on FTR fixups --
+	   they don't work properly in our context. */
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC) {
+	    asm volatile (
+		"dssall;\n"
+		: : );
+	}
+#endif /* CONFIG_ALTIVEC */
+#else /* !CONFIG_PPC64 */
+#ifdef CONFIG_ALTIVEC
+	/* Don't rely on FTR fixups --
+	   they don't work properly in our context. */
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC) {
+	    asm volatile (
+		"dssall;\n"
+#ifndef CONFIG_POWER4
+		"sync;\n"
+#endif
+		: : );
+	}
+#endif /* CONFIG_ALTIVEC */
+#endif /* CONFIG_PPC64 */
+	
+#ifdef CONFIG_PPC64
+	if (!cpu_isset(smp_processor_id(), mm->cpu_vm_mask)) {
+	    cpu_set(smp_processor_id(), mm->cpu_vm_mask);
+	}
+	
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB) {
+	    switch_slb(next, mm);
+	}
+	else {
+	    switch_stab(next, mm);
+	}
+	
+	flush_tlb_pending();
+#else /* !CONFIG_PPC64 */
+	next->thread.pgdir = mm->pgd;
+	get_mmu_context(mm);
+	set_context(mm->context,mm->pgd);
+
+	/* _switch expects a valid "current" (r2) for storing
+	 * ALTIVEC and SPE state. */
+	current = prev;
+#endif /* CONFIG_PPC64 */
+	_switch(&prev->thread, &next->thread);
+
+	barrier();
+	}
+    else
+        /* Kernel-to-kernel context switch. */
+        rthal_switch_context(out_tcb->kspp,in_tcb->kspp);
+}
+
+static inline void xnarch_finalize_and_switch (xnarchtcb_t *dead_tcb,
+					       xnarchtcb_t *next_tcb)
+{
+    xnarch_switch_to(dead_tcb,next_tcb);
+}
+
+static inline void xnarch_finalize_no_switch (xnarchtcb_t *dead_tcb)
+
+{
+    /* Empty */
+}
+
+static inline void xnarch_init_root_tcb (xnarchtcb_t *tcb,
+					 struct xnthread *thread,
+					 const char *name)
+{
+    tcb->user_task = current;
+    tcb->active_task = NULL;
+    tcb->ksp = 0;
+    tcb->kspp = &tcb->ksp;
+#ifdef CONFIG_XENO_HW_FPU
+    tcb->user_fpu_owner = NULL;
+    tcb->fpup = NULL;
+#endif /* CONFIG_XENO_HW_FPU */
+    tcb->entry = NULL;
+    tcb->cookie = NULL;
+    tcb->self = thread;
+    tcb->imask = 0;
+    tcb->name = name;
+}
+
+asmlinkage static void xnarch_thread_trampoline (xnarchtcb_t *tcb)
+
+{
+    rthal_local_irq_restore(!!tcb->imask);
+    xnpod_welcome_thread(tcb->self);
+    tcb->entry(tcb->cookie);
+    xnpod_delete_thread(tcb->self);
+}
+
+static inline void xnarch_init_thread (xnarchtcb_t *tcb,
+				       void (*entry)(void *),
+				       void *cookie,
+				       int imask,
+				       struct xnthread *thread,
+				       char *name)
+{
+    unsigned long *ksp, flags;
+
+    rthal_local_irq_flags_hw(flags);
+
+#ifdef CONFIG_PPC64
+    if (tcb->stackbase) {
+	*tcb->stackbase = 0;
+	
+	ksp = (unsigned long *)(((unsigned long)tcb->stackbase + tcb->stacksize - 16) & ~0xf);
+	*ksp = 0L; /* first stack frame back-chain */
+	ksp = ksp - STACK_FRAME_OVERHEAD; /* first stack frame (entry uses) */
+	*ksp = (unsigned long)ksp+STACK_FRAME_OVERHEAD; /* second back-chain */
+	ksp = ksp - RTHAL_SWITCH_FRAME_SIZE; /* domain context */
+	tcb->ksp = (unsigned long)ksp - STACK_FRAME_OVERHEAD;
+	*((unsigned long *)tcb->ksp) = (unsigned long)ksp + 224; /*back-chain*/
+	/* NOTE: these depend on rthal_switch_context ordering */
+	ksp[18] = (unsigned long)get_paca(); /* r13 needs to hold paca */
+	ksp[19] = (unsigned long)tcb; /* r3 */
+	ksp[20] = ((unsigned long *)&xnarch_thread_trampoline)[1]; /* r2 = TOC base */
+	ksp[25] = ((unsigned long *)&xnarch_thread_trampoline)[0]; /* lr = entry addr. */
+	ksp[26] = flags & ~(MSR_EE | MSR_FP); /* msr */
+    }
+    else {
+	printk("xnarch_init_thread: NULL stackbase!\n");
+    }
+#else /* !CONFIG_PPC64 */
+    *tcb->stackbase = 0;
+    ksp = (unsigned long *)((((unsigned long)tcb->stackbase + tcb->stacksize - 0x10) & ~0xf)
+			    - RTHAL_SWITCH_FRAME_SIZE);
+    tcb->ksp = (unsigned long)ksp - STACK_FRAME_OVERHEAD;
+    ksp[19] = (unsigned long)tcb; /* r3 */
+    ksp[25] = (unsigned long)&xnarch_thread_trampoline; /* lr */
+    ksp[26] = flags & ~(MSR_EE | MSR_FP); /* msr */
+#endif
+    
+    tcb->entry = entry;
+    tcb->cookie = cookie;
+    tcb->self = thread;
+    tcb->imask = imask;
+    tcb->name = name;
+}
+
+/* No lazy FPU init on PPC. */
+#define xnarch_fpu_init_p(task) (1)
+
+static inline void xnarch_enable_fpu (xnarchtcb_t *current_tcb)
+
+{
+#ifdef CONFIG_XENO_HW_FPU
+    if(!current_tcb->user_task)
+        rthal_enable_fpu();
+#endif /* CONFIG_XENO_HW_FPU */
+}
+
+static inline void xnarch_init_fpu (xnarchtcb_t *tcb)
+
+{
+#ifdef CONFIG_XENO_HW_FPU
+    /* Initialize the FPU for an emerging kernel-based RT thread. This
+       must be run on behalf of the emerging thread. */
+    memset(&tcb->fpuenv,0,sizeof(tcb->fpuenv));
+    rthal_init_fpu(&tcb->fpuenv);
+#endif /* CONFIG_XENO_HW_FPU */
+}
+
+static inline void xnarch_save_fpu (xnarchtcb_t *tcb)
+
+{
+#ifdef CONFIG_XENO_HW_FPU
+
+    if(tcb->fpup)
+        {
+        rthal_save_fpu(tcb->fpup);
+
+        if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
+            tcb->user_fpu_owner->thread.regs->msr &= ~MSR_FP;
+        }   
+
+#endif /* CONFIG_XENO_HW_FPU */
+}
+
+static inline void xnarch_restore_fpu (xnarchtcb_t *tcb)
+
+{
+#ifdef CONFIG_XENO_HW_FPU
+
+    if(tcb->fpup)
+        {
+        rthal_restore_fpu(tcb->fpup);
+
+        if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
+            tcb->user_fpu_owner->thread.regs->msr |= MSR_FP;
+        }   
+
+    /* FIXME: We restore FPU "as it was" when Xenomai preempted Linux,
+       whereas we could be much lazier. */
+    if(tcb->user_task)
+        rthal_disable_fpu();
+
+#endif /* CONFIG_XENO_HW_FPU */
+}
+
+#endif /* XENO_POD_MODULE */
+
+#ifdef XENO_THREAD_MODULE
+
+static inline void xnarch_init_tcb (xnarchtcb_t *tcb) {
+
+    tcb->user_task = NULL;
+    tcb->active_task = NULL;
+    tcb->kspp = &tcb->ksp;
+#ifdef CONFIG_XENO_HW_FPU
+    tcb->user_fpu_owner = NULL;
+    tcb->fpup = &tcb->fpuenv;
+#endif /* CONFIG_XENO_HW_FPU */
+    /* Must be followed by xnarch_init_thread(). */
+}
+
+#endif /* XENO_THREAD_MODULE */
+
+#ifdef XENO_SHADOW_MODULE
+
+static inline void xnarch_init_shadow_tcb (xnarchtcb_t *tcb,
+					   struct xnthread *thread,
+					   const char *name)
+{
+    struct task_struct *task = current;
+
+    tcb->user_task = task;
+    tcb->active_task = NULL;
+    tcb->ksp = 0;
+    tcb->kspp = &task->thread.ksp;
+#ifdef CONFIG_XENO_HW_FPU
+    tcb->user_fpu_owner = task;
+    tcb->fpup = (rthal_fpenv_t *)&task->thread.fpr[0];
+#endif /* CONFIG_XENO_HW_FPU */
+    tcb->entry = NULL;
+    tcb->cookie = NULL;
+    tcb->self = thread;
+    tcb->imask = 0;
+    tcb->name = name;
+}
+
+static inline void xnarch_grab_xirqs (void (*handler)(unsigned irq))
+
+{
+    unsigned irq;
+
+    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
+	rthal_virtualize_irq(rthal_current_domain,
+			     irq,
+			     handler,
+			     NULL,
+			     IPIPE_DYNAMIC_MASK);
+
+    /* On this arch, the decrementer trap is not an external IRQ but
+       it is instead mapped to a virtual IRQ, so we must grab it
+       individually. */
+
+    rthal_virtualize_irq(rthal_current_domain,
+			 RTHAL_TIMER_IRQ,
+			 handler,
+			 NULL,
+			 IPIPE_DYNAMIC_MASK);
+}
+
+static inline void xnarch_lock_xirqs (rthal_pipeline_stage_t *ipd, int cpuid)
+
+{
+    unsigned irq;
+
+    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
+	{
+	switch (irq)
+	    {
+#ifdef CONFIG_SMP
+	    case RTHAL_CRITICAL_IPI:
+
+		/* Never lock out this one. */
+		continue;
+#endif /* CONFIG_SMP */
+
+	    default:
+
+		rthal_lock_irq(ipd,cpuid,irq);
+	    }
+	}
+
+    rthal_lock_irq(ipd,cpuid,RTHAL_TIMER_IRQ);
+}
+
+static inline void xnarch_unlock_xirqs (rthal_pipeline_stage_t *ipd, int cpuid)
+
+{
+    unsigned irq;
+
+    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
+	{
+	switch (irq)
+	    {
+#ifdef CONFIG_SMP
+	    case RTHAL_CRITICAL_IPI:
+
+		continue;
+#endif /* CONFIG_SMP */
+
+	    default:
+
+		rthal_unlock_irq(ipd,irq);
+	    }
+	}
+
+    rthal_unlock_irq(ipd,RTHAL_TIMER_IRQ);
+}
+
+#endif /* XENO_SHADOW_MODULE */
+
+#ifdef XENO_TIMER_MODULE
+
+static inline void xnarch_program_timer_shot (unsigned long delay) {
+    /* Even though some architectures may use a 64 bits delay here, we
+       voluntarily limit to 32 bits, 4 billions ticks should be enough
+       for now. Would a timer needs more, an extra call to the tick
+       handler would simply occur after 4 billions ticks.  Since the
+       timebase value is used to express CPU ticks on the PowerPC
+       port, there is no need to rescale the delay value. */
+    rthal_timer_program_shot(delay);
+}
+
+static inline void xnarch_stop_timer (void) {
+    rthal_timer_release();
+}
+
+static inline int xnarch_send_timer_ipi (xnarch_cpumask_t mask)
+
+{
+#ifdef CONFIG_SMP
+    return -1;		/* FIXME */
+#else /* ! CONFIG_SMP */
+    return 0;
+#endif /* CONFIG_SMP */
+}
+
+#endif /* XENO_TIMER_MODULE */
+
+#ifdef XENO_MAIN_MODULE
+
+#include <linux/init.h>
+#include <nucleus/asm/calibration.h>
+
+extern u_long nkschedlat;
+
+extern u_long nktimerlat;
+
+int xnarch_escalation_virq;
+
+int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo);
+
+void xnpod_schedule_handler(void);
+
+static rthal_trap_handler_t xnarch_old_trap_handler;
+
+static int xnarch_trap_fault (unsigned event, unsigned domid, void *data)
+{
+    xnarch_fltinfo_t fltinfo;
+    fltinfo.exception = event;
+    fltinfo.regs = (struct pt_regs *)data;
+    return xnpod_trap_fault(&fltinfo);
+}
+
+unsigned long xnarch_calibrate_timer (void)
+
+{
+#if CONFIG_XENO_HW_TIMER_LATENCY != 0
+    return xnarch_ns_to_tsc(CONFIG_XENO_HW_TIMER_LATENCY) ?: 1;
+#else /* CONFIG_XENO_HW_TIMER_LATENCY unspecified. */
+    /* Compute the time needed to program the decrementer in aperiodic
+       mode. The return value is expressed in timebase ticks. */
+    return xnarch_ns_to_tsc(rthal_timer_calibrate()) ?: 1;
+#endif /* CONFIG_XENO_HW_TIMER_LATENCY != 0 */
+}
+
+int xnarch_calibrate_sched (void)
+
+{
+    nktimerlat = xnarch_calibrate_timer();
+
+    if (!nktimerlat)
+	return -ENODEV;
+
+    nkschedlat = xnarch_ns_to_tsc(xnarch_get_sched_latency());
+
+    return 0;
+}
+
+static inline int xnarch_init (void)
+
+{
+    int err;
+
+#ifdef CONFIG_SMP
+    /* The HAL layer also sets the same CPU affinity so that both
+       modules keep their execution sequence on SMP boxen. */
+    set_cpus_allowed(current,cpumask_of_cpu(0));
+#endif /* CONFIG_SMP */
+
+    err = xnarch_calibrate_sched();
+
+    if (err)
+	return err;
+
+    xnarch_escalation_virq = rthal_alloc_virq();
+
+    if (xnarch_escalation_virq == 0)
+	return -ENOSYS;
+
+    rthal_virtualize_irq(&rthal_domain,
+			 xnarch_escalation_virq,
+			 (void (*)(unsigned))&xnpod_schedule_handler,
+			 NULL,
+			 IPIPE_HANDLE_MASK);
+
+    xnarch_old_trap_handler = rthal_trap_catch(&xnarch_trap_fault);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+    err = xnshadow_mount();
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+
+    if (err)
+	{
+	rthal_trap_catch(xnarch_old_trap_handler);
+        rthal_free_virq(xnarch_escalation_virq);
+	}
+
+    return err;
+}
+
+static inline void xnarch_exit (void)
+
+{
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+    xnshadow_cleanup();
+#endif /* CONFIG_XENO_OPT_PERVASIVE */
+    rthal_trap_catch(xnarch_old_trap_handler);
+    rthal_free_virq(xnarch_escalation_virq);
+}
+
+#endif /* XENO_MAIN_MODULE */
+
+#ifdef __cplusplus
+}
+#endif
+
+#else /* !__KERNEL__ */
+
+#include <nucleus/system.h>
+#include <bits/local_lim.h>
+
+#endif /* __KERNEL__ */
+
+#endif /* !_XENO_ASM_POWERPC_SYSTEM_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-powerpc/uart.h xenomai-devel/include/nucleus/asm-powerpc/uart.h
--- xenomai-orig/include/nucleus/asm-powerpc/uart.h	1970-01-01 02:00:00.000000000 +0200
+++ xenomai-devel/include/nucleus/asm-powerpc/uart.h	2005-10-17 22:45:32.000000000 +0300
@@ -0,0 +1,35 @@
+/**
+ * @file
+ * This file is part of the Xenomai project.
+ *
+ * @note Copyright (C) 2004 Philippe Gerum <rpm@xenomai.org> 
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
+
+#ifndef _XENO_ASM_POWERPC_UART_H
+#define _XENO_ASM_POWERPC_UART_H
+
+#include <linux/config.h>
+
+#if defined(CONFIG_SANDPOINT)
+
+#define TTYS0  { 0xfe0003f8, 4 }
+#define TTYS1  { 0xfe0002f8, 3 }
+#else
+#error "UART configuration is undefined for this PowerPC platform"
+#endif
+
+#endif /* !_XENO_ASM_POWERPC_UART_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/atomic.h xenomai-devel/include/nucleus/asm-ppc/atomic.h
--- xenomai-orig/include/nucleus/asm-ppc/atomic.h	2005-10-11 10:30:01.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/atomic.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,228 +0,0 @@
-/*
- * Copyright (C) 2003,2004 Philippe Gerum <rpm@xenomai.org>.
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
-
-#ifndef _XENO_ASM_PPC_ATOMIC_H
-#define _XENO_ASM_PPC_ATOMIC_H
-
-#include <asm/atomic.h>
-
-#ifdef __KERNEL__
-
-#include <linux/bitops.h>
-#include <asm/system.h>
-
-#define atomic_xchg(ptr,v)       xchg(ptr,v)
-#define atomic_cmpxchg(ptr,o,n)  cmpxchg(ptr,o,n)
-#define xnarch_memory_barrier()  smp_mb()
-
-void atomic_set_mask(unsigned long mask, /* from arch/ppc/kernel/misc.S */
-		     unsigned long *ptr);
-
-#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
-#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
-#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
-#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
-#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
-#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
-
-#else /* !__KERNEL__ */
-
-#include <linux/config.h>
-
-#ifdef CONFIG_IBM405_ERR77
-#define PPC405_ERR77(ra,rb)	"dcbt " #ra "," #rb ";"
-#else
-#define PPC405_ERR77(ra,rb)
-#endif
-
-/*
- * Shamelessly lifted from <linux/asm-ppc/system.h>
- * and <linux/asm-ppc/atomic.h>
- */
-
-static inline unsigned long atomic_cmpxchg (volatile void *ptr,
-					    unsigned long o,
-					    unsigned long n)
-{
-    unsigned long prev;
-
-    __asm__ __volatile__ ("\n\
-1:	lwarx	%0,0,%2 \n\
-	cmpw	0,%0,%3 \n\
-	bne	2f \n"
-	PPC405_ERR77(0,%2) \
-"	stwcx.	%4,0,%2 \n\
-	bne-	1b\n"
-#ifdef CONFIG_SMP
-"	sync\n"
-#endif /* CONFIG_SMP */
-"2:"
-	: "=&r" (prev), "=m" (*(volatile unsigned long *)ptr)
-	: "r" (ptr), "r" (o), "r" (n), "m" (*(volatile unsigned long *)ptr)
-	: "cc", "memory");
-
-    return prev;
-}
-
-static inline unsigned long atomic_xchg (volatile void *ptr,
-					 unsigned long x)
-{
-    unsigned long prev;
-
-    __asm__ __volatile__ ("\n\
-1:	lwarx	%0,0,%2 \n"
-	PPC405_ERR77(0,%2) \
-"	stwcx.	%3,0,%2 \n\
-	bne-	1b"
-	: "=&r" (prev), "=m" (*(volatile unsigned long *)ptr)
-	: "r" (ptr), "r" (x), "m" (*(volatile unsigned long *)ptr)
-	: "cc", "memory");
-
-    return prev;
-}
-
-#ifdef CONFIG_SMP
-#define SMP_SYNC  "sync"
-#define SMP_ISYNC "\n\tisync"
-#else /* !CONFIG_SMP */
-#define SMP_SYNC  ""
-#define SMP_ISYNC
-#endif /* CONFIG_SMP */
-
-static __inline__ void atomic_inc(atomic_t *v)
-
-{
-    int t;
-
-    __asm__ __volatile__(
-"1:	lwarx	%0,0,%2\n\
-	addic	%0,%0,1\n"
-	PPC405_ERR77(0,%2)
-"	stwcx.	%0,0,%2 \n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_inc_return(atomic_t *v)
-
-{
-    int t;
-
-    __asm__ __volatile__(
-"1:	lwarx	%0,0,%1\n\
-	addic	%0,%0,1\n"
-	PPC405_ERR77(0,%1)
-"	stwcx.	%0,0,%1 \n\
-	bne-	1b"
-	SMP_ISYNC
-	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-    return t;
-}
-
-static __inline__ void atomic_dec(atomic_t *v)
-
-{
-    int t;
-
-    __asm__ __volatile__(
-"1:	lwarx	%0,0,%2\n\
-	addic	%0,%0,-1\n"
-	PPC405_ERR77(0,%2)\
-"	stwcx.	%0,0,%2\n\
-	bne-	1b"
-	: "=&r" (t), "=m" (v->counter)
-	: "r" (&v->counter), "m" (v->counter)
-	: "cc");
-}
-
-static __inline__ int atomic_dec_return(atomic_t *v)
-
-{
-    int t;
-
-    __asm__ __volatile__(
-"1:	lwarx	%0,0,%1\n\
-	addic	%0,%0,-1\n"
-	PPC405_ERR77(0,%1)
-"	stwcx.	%0,0,%1\n\
-	bne-	1b"
-	SMP_ISYNC
-	: "=&r" (t)
-	: "r" (&v->counter)
-	: "cc", "memory");
-
-    return t;
-}
-
-static __inline__ void atomic_set_mask(unsigned long mask,
-				       unsigned long *ptr)
-{
-    __asm__ __volatile__ ("\n\
-1:	lwarx	5,0,%0 \n\
-	or	5,5,%1\n"
-	PPC405_ERR77(0,%0) \
-"	stwcx.	5,0,%0 \n\
-	bne-	1b"
-	: /*no output*/
-	: "r" (ptr), "r" (mask)
-	: "r5", "cc", "memory");
-}
-
-static __inline__ void atomic_clear_mask(unsigned long mask,
-					 unsigned long *ptr)
-{
-    __asm__ __volatile__ ("\n\
-1:	lwarx	5,0,%0 \n\
-	andc	5,5,%1\n"
-	PPC405_ERR77(0,%0) \
-"	stwcx.	5,0,%0 \n\
-	bne-	1b"
-	: /*no output*/
-	: "r" (ptr), "r" (mask)
-	: "r5", "cc", "memory");
-}
-
-#define xnarch_memory_barrier()  __asm__ __volatile__("": : :"memory")
-
-#define xnarch_atomic_set(pcounter,i)          (((pcounter)->counter) = (i))
-#define xnarch_atomic_get(pcounter)            ((pcounter)->counter)
-#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
-#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
-#define xnarch_atomic_inc_and_test(pcounter)   (atomic_inc_return(pcounter) == 0)
-#define xnarch_atomic_dec_and_test(pcounter)   (atomic_dec_return(pcounter) == 0)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
-
-#define cpu_relax()  xnarch_memory_barrier()
-
-#endif /* __KERNEL__ */
-
-typedef atomic_t atomic_counter_t;
-typedef unsigned long atomic_flags_t;
-
-#define xnarch_atomic_xchg(ptr,x) atomic_xchg(ptr,x)
-
-#endif /* !_XENO_ASM_PPC_ATOMIC_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/calibration.h xenomai-devel/include/nucleus/asm-ppc/calibration.h
--- xenomai-orig/include/nucleus/asm-ppc/calibration.h	2005-10-17 11:02:39.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/calibration.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,45 +0,0 @@
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
-
-#ifndef _XENO_ASM_PPC_CALIBRATION_H
-#define _XENO_ASM_PPC_CALIBRATION_H
-
-#include <xeno_config.h>
-#include <asm/delay.h>
-
-#define __bogomips (loops_per_jiffy/(500000/HZ))
-
-static inline unsigned long xnarch_get_sched_latency (void)
-
-{
-#if CONFIG_XENO_HW_SCHED_LATENCY != 0
-#define __sched_latency CONFIG_XENO_HW_SCHED_LATENCY
-#else
-
-#define __sched_latency 9500
-
-#endif /* CONFIG_XENO_HW_SCHED_LATENCY */
-
-    return __sched_latency;
-}
-
-#undef __sched_latency
-#undef __bogomips
-
-#endif /* !_XENO_ASM_PPC_CALIBRATION_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/GNUmakefile.am xenomai-devel/include/nucleus/asm-ppc/GNUmakefile.am
--- xenomai-orig/include/nucleus/asm-ppc/GNUmakefile.am	2005-10-11 10:30:01.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/GNUmakefile.am	1970-01-01 02:00:00.000000000 +0200
@@ -1,17 +0,0 @@
-includedir = $(prefix)/include/nucleus/asm-ppc
-
-include_HEADERS = \
-		atomic.h \
-		calibration.h \
-		hal.h \
-		system.h \
-		syscall.h \
-		uart.h
-
-install-data-local:
-	$(mkinstalldirs) $(DESTDIR)$(includedir)
-	rm -f $(DESTDIR)$(includedir)/../asm
-	$(LN_S) asm-ppc $(DESTDIR)$(includedir)/../asm
-
-uninstall-local:
-	$(RM) $(DESTDIR)$(includedir)/../asm
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/GNUmakefile.in xenomai-devel/include/nucleus/asm-ppc/GNUmakefile.in
--- xenomai-orig/include/nucleus/asm-ppc/GNUmakefile.in	2005-10-23 10:59:55.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/GNUmakefile.in	1970-01-01 02:00:00.000000000 +0200
@@ -1,551 +0,0 @@
-# GNUmakefile.in generated by automake 1.9.5 from GNUmakefile.am.
-# @configure_input@
-
-# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
-# 2003, 2004, 2005  Free Software Foundation, Inc.
-# This Makefile.in is free software; the Free Software Foundation
-# gives unlimited permission to copy and/or distribute it,
-# with or without modifications, as long as this notice is preserved.
-
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
-# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
-# PARTICULAR PURPOSE.
-
-@domain.hid@
-
-srcdir = @srcdir@
-top_srcdir = @top_srcdir@
-VPATH = @srcdir@
-pkgdatadir = $(datadir)/@PACKAGE@
-pkglibdir = $(libdir)/@PACKAGE@
-pkgincludedir = $(includedir)/@PACKAGE@
-top_builddir = ../../..
-am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
-INSTALL = @INSTALL@
-install_sh_DATA = $(install_sh) -c -m 644
-install_sh_PROGRAM = $(install_sh) -c
-install_sh_SCRIPT = $(install_sh) -c
-INSTALL_HEADER = $(INSTALL_DATA)
-transform = $(program_transform_name)
-NORMAL_INSTALL = :
-PRE_INSTALL = :
-POST_INSTALL = :
-NORMAL_UNINSTALL = :
-PRE_UNINSTALL = :
-POST_UNINSTALL = :
-build_triplet = @build@
-host_triplet = @host@
-target_triplet = @target@
-subdir = include/nucleus/asm-ppc
-DIST_COMMON = $(include_HEADERS) $(srcdir)/GNUmakefile.am \
-	$(srcdir)/GNUmakefile.in
-ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
-am__aclocal_m4_deps =  \
-	$(top_srcdir)/config/autoconf/ac_prog_cc_for_build.m4 \
-	$(top_srcdir)/config/autoconf/docbook.m4 \
-	$(top_srcdir)/config/version $(top_srcdir)/configure.in
-am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
-	$(ACLOCAL_M4)
-mkinstalldirs = $(install_sh) -d
-CONFIG_HEADER = $(top_builddir)/include/xeno_config.h
-CONFIG_CLEAN_FILES =
-SOURCES =
-DIST_SOURCES =
-am__vpath_adj_setup = srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`;
-am__vpath_adj = case $$p in \
-    $(srcdir)/*) f=`echo "$$p" | sed "s|^$$srcdirstrip/||"`;; \
-    *) f=$$p;; \
-  esac;
-am__strip_dir = `echo $$p | sed -e 's|^.*/||'`;
-am__installdirs = "$(DESTDIR)$(includedir)"
-includeHEADERS_INSTALL = $(INSTALL_HEADER)
-HEADERS = $(include_HEADERS)
-ETAGS = etags
-CTAGS = ctags
-DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
-ACLOCAL = @ACLOCAL@
-AMDEP_FALSE = @AMDEP_FALSE@
-AMDEP_TRUE = @AMDEP_TRUE@
-AMTAR = @AMTAR@
-AR = @AR@
-AUTOCONF = @AUTOCONF@
-AUTOHEADER = @AUTOHEADER@
-AUTOMAKE = @AUTOMAKE@
-AWK = @AWK@
-BUILD_EXEEXT = @BUILD_EXEEXT@
-BUILD_OBJEXT = @BUILD_OBJEXT@
-CC = @CC@
-CCAS = @CCAS@
-CCASFLAGS = @CCASFLAGS@
-CCDEPMODE = @CCDEPMODE@
-CC_FOR_BUILD = @CC_FOR_BUILD@
-CFLAGS = @CFLAGS@
-CFLAGS_FOR_BUILD = @CFLAGS_FOR_BUILD@
-CONFIG_IA64_FALSE = @CONFIG_IA64_FALSE@
-CONFIG_IA64_TRUE = @CONFIG_IA64_TRUE@
-CONFIG_LTT_FALSE = @CONFIG_LTT_FALSE@
-CONFIG_LTT_TRUE = @CONFIG_LTT_TRUE@
-CONFIG_PPC64_FALSE = @CONFIG_PPC64_FALSE@
-CONFIG_PPC64_TRUE = @CONFIG_PPC64_TRUE@
-CONFIG_PPC_FALSE = @CONFIG_PPC_FALSE@
-CONFIG_PPC_TRUE = @CONFIG_PPC_TRUE@
-CONFIG_SMP_FALSE = @CONFIG_SMP_FALSE@
-CONFIG_SMP_TRUE = @CONFIG_SMP_TRUE@
-CONFIG_X86_FALSE = @CONFIG_X86_FALSE@
-CONFIG_X86_LOCAL_APIC_FALSE = @CONFIG_X86_LOCAL_APIC_FALSE@
-CONFIG_X86_LOCAL_APIC_TRUE = @CONFIG_X86_LOCAL_APIC_TRUE@
-CONFIG_X86_TRUE = @CONFIG_X86_TRUE@
-CONFIG_XENO_DOC_DOX_FALSE = @CONFIG_XENO_DOC_DOX_FALSE@
-CONFIG_XENO_DOC_DOX_TRUE = @CONFIG_XENO_DOC_DOX_TRUE@
-CONFIG_XENO_DRIVERS_16550A_FALSE = @CONFIG_XENO_DRIVERS_16550A_FALSE@
-CONFIG_XENO_DRIVERS_16550A_TRUE = @CONFIG_XENO_DRIVERS_16550A_TRUE@
-CONFIG_XENO_HW_FPU_FALSE = @CONFIG_XENO_HW_FPU_FALSE@
-CONFIG_XENO_HW_FPU_TRUE = @CONFIG_XENO_HW_FPU_TRUE@
-CONFIG_XENO_HW_NMI_DEBUG_LATENCY_FALSE = @CONFIG_XENO_HW_NMI_DEBUG_LATENCY_FALSE@
-CONFIG_XENO_HW_NMI_DEBUG_LATENCY_TRUE = @CONFIG_XENO_HW_NMI_DEBUG_LATENCY_TRUE@
-CONFIG_XENO_HW_SMI_DETECT_FALSE = @CONFIG_XENO_HW_SMI_DETECT_FALSE@
-CONFIG_XENO_HW_SMI_DETECT_TRUE = @CONFIG_XENO_HW_SMI_DETECT_TRUE@
-CONFIG_XENO_MAINT_FALSE = @CONFIG_XENO_MAINT_FALSE@
-CONFIG_XENO_MAINT_GCH_FALSE = @CONFIG_XENO_MAINT_GCH_FALSE@
-CONFIG_XENO_MAINT_GCH_TRUE = @CONFIG_XENO_MAINT_GCH_TRUE@
-CONFIG_XENO_MAINT_PGM_FALSE = @CONFIG_XENO_MAINT_PGM_FALSE@
-CONFIG_XENO_MAINT_PGM_TRUE = @CONFIG_XENO_MAINT_PGM_TRUE@
-CONFIG_XENO_MAINT_TRUE = @CONFIG_XENO_MAINT_TRUE@
-CONFIG_XENO_OLD_FASHIONED_BUILD_FALSE = @CONFIG_XENO_OLD_FASHIONED_BUILD_FALSE@
-CONFIG_XENO_OLD_FASHIONED_BUILD_TRUE = @CONFIG_XENO_OLD_FASHIONED_BUILD_TRUE@
-CONFIG_XENO_OPT_CONFIG_GZ_FALSE = @CONFIG_XENO_OPT_CONFIG_GZ_FALSE@
-CONFIG_XENO_OPT_CONFIG_GZ_TRUE = @CONFIG_XENO_OPT_CONFIG_GZ_TRUE@
-CONFIG_XENO_OPT_NATIVE_ALARM_FALSE = @CONFIG_XENO_OPT_NATIVE_ALARM_FALSE@
-CONFIG_XENO_OPT_NATIVE_ALARM_TRUE = @CONFIG_XENO_OPT_NATIVE_ALARM_TRUE@
-CONFIG_XENO_OPT_NATIVE_COND_FALSE = @CONFIG_XENO_OPT_NATIVE_COND_FALSE@
-CONFIG_XENO_OPT_NATIVE_COND_TRUE = @CONFIG_XENO_OPT_NATIVE_COND_TRUE@
-CONFIG_XENO_OPT_NATIVE_EVENT_FALSE = @CONFIG_XENO_OPT_NATIVE_EVENT_FALSE@
-CONFIG_XENO_OPT_NATIVE_EVENT_TRUE = @CONFIG_XENO_OPT_NATIVE_EVENT_TRUE@
-CONFIG_XENO_OPT_NATIVE_HEAP_FALSE = @CONFIG_XENO_OPT_NATIVE_HEAP_FALSE@
-CONFIG_XENO_OPT_NATIVE_HEAP_TRUE = @CONFIG_XENO_OPT_NATIVE_HEAP_TRUE@
-CONFIG_XENO_OPT_NATIVE_INTR_FALSE = @CONFIG_XENO_OPT_NATIVE_INTR_FALSE@
-CONFIG_XENO_OPT_NATIVE_INTR_TRUE = @CONFIG_XENO_OPT_NATIVE_INTR_TRUE@
-CONFIG_XENO_OPT_NATIVE_MUTEX_FALSE = @CONFIG_XENO_OPT_NATIVE_MUTEX_FALSE@
-CONFIG_XENO_OPT_NATIVE_MUTEX_TRUE = @CONFIG_XENO_OPT_NATIVE_MUTEX_TRUE@
-CONFIG_XENO_OPT_NATIVE_PIPE_FALSE = @CONFIG_XENO_OPT_NATIVE_PIPE_FALSE@
-CONFIG_XENO_OPT_NATIVE_PIPE_TRUE = @CONFIG_XENO_OPT_NATIVE_PIPE_TRUE@
-CONFIG_XENO_OPT_NATIVE_QUEUE_FALSE = @CONFIG_XENO_OPT_NATIVE_QUEUE_FALSE@
-CONFIG_XENO_OPT_NATIVE_QUEUE_TRUE = @CONFIG_XENO_OPT_NATIVE_QUEUE_TRUE@
-CONFIG_XENO_OPT_NATIVE_REGISTRY_FALSE = @CONFIG_XENO_OPT_NATIVE_REGISTRY_FALSE@
-CONFIG_XENO_OPT_NATIVE_REGISTRY_TRUE = @CONFIG_XENO_OPT_NATIVE_REGISTRY_TRUE@
-CONFIG_XENO_OPT_NATIVE_SEM_FALSE = @CONFIG_XENO_OPT_NATIVE_SEM_FALSE@
-CONFIG_XENO_OPT_NATIVE_SEM_TRUE = @CONFIG_XENO_OPT_NATIVE_SEM_TRUE@
-CONFIG_XENO_OPT_PERVASIVE_FALSE = @CONFIG_XENO_OPT_PERVASIVE_FALSE@
-CONFIG_XENO_OPT_PERVASIVE_TRUE = @CONFIG_XENO_OPT_PERVASIVE_TRUE@
-CONFIG_XENO_OPT_PIPE_FALSE = @CONFIG_XENO_OPT_PIPE_FALSE@
-CONFIG_XENO_OPT_PIPE_TRUE = @CONFIG_XENO_OPT_PIPE_TRUE@
-CONFIG_XENO_OPT_RTAI_FIFO_FALSE = @CONFIG_XENO_OPT_RTAI_FIFO_FALSE@
-CONFIG_XENO_OPT_RTAI_FIFO_TRUE = @CONFIG_XENO_OPT_RTAI_FIFO_TRUE@
-CONFIG_XENO_OPT_RTAI_SEM_FALSE = @CONFIG_XENO_OPT_RTAI_SEM_FALSE@
-CONFIG_XENO_OPT_RTAI_SEM_TRUE = @CONFIG_XENO_OPT_RTAI_SEM_TRUE@
-CONFIG_XENO_OPT_RTAI_SHM_FALSE = @CONFIG_XENO_OPT_RTAI_SHM_FALSE@
-CONFIG_XENO_OPT_RTAI_SHM_TRUE = @CONFIG_XENO_OPT_RTAI_SHM_TRUE@
-CONFIG_XENO_OPT_UDEV_FALSE = @CONFIG_XENO_OPT_UDEV_FALSE@
-CONFIG_XENO_OPT_UDEV_TRUE = @CONFIG_XENO_OPT_UDEV_TRUE@
-CONFIG_XENO_OPT_UVM_FALSE = @CONFIG_XENO_OPT_UVM_FALSE@
-CONFIG_XENO_OPT_UVM_TRUE = @CONFIG_XENO_OPT_UVM_TRUE@
-CONFIG_XENO_SKIN_NATIVE_FALSE = @CONFIG_XENO_SKIN_NATIVE_FALSE@
-CONFIG_XENO_SKIN_NATIVE_TRUE = @CONFIG_XENO_SKIN_NATIVE_TRUE@
-CONFIG_XENO_SKIN_POSIX_FALSE = @CONFIG_XENO_SKIN_POSIX_FALSE@
-CONFIG_XENO_SKIN_POSIX_TRUE = @CONFIG_XENO_SKIN_POSIX_TRUE@
-CONFIG_XENO_SKIN_PSOS_FALSE = @CONFIG_XENO_SKIN_PSOS_FALSE@
-CONFIG_XENO_SKIN_PSOS_TRUE = @CONFIG_XENO_SKIN_PSOS_TRUE@
-CONFIG_XENO_SKIN_RTAI_FALSE = @CONFIG_XENO_SKIN_RTAI_FALSE@
-CONFIG_XENO_SKIN_RTAI_TRUE = @CONFIG_XENO_SKIN_RTAI_TRUE@
-CONFIG_XENO_SKIN_RTDM_FALSE = @CONFIG_XENO_SKIN_RTDM_FALSE@
-CONFIG_XENO_SKIN_RTDM_TRUE = @CONFIG_XENO_SKIN_RTDM_TRUE@
-CONFIG_XENO_SKIN_UITRON_FALSE = @CONFIG_XENO_SKIN_UITRON_FALSE@
-CONFIG_XENO_SKIN_UITRON_TRUE = @CONFIG_XENO_SKIN_UITRON_TRUE@
-CONFIG_XENO_SKIN_VRTX_FALSE = @CONFIG_XENO_SKIN_VRTX_FALSE@
-CONFIG_XENO_SKIN_VRTX_TRUE = @CONFIG_XENO_SKIN_VRTX_TRUE@
-CONFIG_XENO_SKIN_VXWORKS_FALSE = @CONFIG_XENO_SKIN_VXWORKS_FALSE@
-CONFIG_XENO_SKIN_VXWORKS_TRUE = @CONFIG_XENO_SKIN_VXWORKS_TRUE@
-CPP = @CPP@
-CPPFLAGS = @CPPFLAGS@
-CPPFLAGS_FOR_BUILD = @CPPFLAGS_FOR_BUILD@
-CPP_FOR_BUILD = @CPP_FOR_BUILD@
-CROSS_COMPILE = @CROSS_COMPILE@
-CXX = @CXX@
-CXXCPP = @CXXCPP@
-CXXDEPMODE = @CXXDEPMODE@
-CXXFLAGS = @CXXFLAGS@
-CYGPATH_W = @CYGPATH_W@
-DBX_ABS_SRCDIR_FALSE = @DBX_ABS_SRCDIR_FALSE@
-DBX_ABS_SRCDIR_TRUE = @DBX_ABS_SRCDIR_TRUE@
-DBX_DOC_FALSE = @DBX_DOC_FALSE@
-DBX_DOC_ROOT = @DBX_DOC_ROOT@
-DBX_DOC_TRUE = @DBX_DOC_TRUE@
-DBX_FOP = @DBX_FOP@
-DBX_GEN_DOC_ROOT = @DBX_GEN_DOC_ROOT@
-DBX_LINT = @DBX_LINT@
-DBX_MAYBE_NONET = @DBX_MAYBE_NONET@
-DBX_ROOT = @DBX_ROOT@
-DBX_XSLTPROC = @DBX_XSLTPROC@
-DBX_XSL_ROOT = @DBX_XSL_ROOT@
-DEFS = @DEFS@
-DEPDIR = @DEPDIR@
-DOXYGEN = @DOXYGEN@
-DOXYGEN_HAVE_DOT = @DOXYGEN_HAVE_DOT@
-DOXYGEN_SHOW_INCLUDE_FILES = @DOXYGEN_SHOW_INCLUDE_FILES@
-ECHO = @ECHO@
-ECHO_C = @ECHO_C@
-ECHO_N = @ECHO_N@
-ECHO_T = @ECHO_T@
-EGREP = @EGREP@
-EXEEXT = @EXEEXT@
-F77 = @F77@
-FFLAGS = @FFLAGS@
-INSTALL_DATA = @INSTALL_DATA@
-INSTALL_PROGRAM = @INSTALL_PROGRAM@
-INSTALL_SCRIPT = @INSTALL_SCRIPT@
-INSTALL_STRIP_PROGRAM = @INSTALL_STRIP_PROGRAM@
-LATEX_BATCHMODE = @LATEX_BATCHMODE@
-LATEX_MODE = @LATEX_MODE@
-LDFLAGS = @LDFLAGS@
-LEX = @LEX@
-LEXLIB = @LEXLIB@
-LEX_OUTPUT_ROOT = @LEX_OUTPUT_ROOT@
-LIBOBJS = @LIBOBJS@
-LIBS = @LIBS@
-LIBTOOL = @LIBTOOL@
-LN_S = @LN_S@
-LTLIBOBJS = @LTLIBOBJS@
-MAINT = @MAINT@
-MAINTAINER_MODE_FALSE = @MAINTAINER_MODE_FALSE@
-MAINTAINER_MODE_TRUE = @MAINTAINER_MODE_TRUE@
-MAKEINFO = @MAKEINFO@
-OBJEXT = @OBJEXT@
-PACKAGE = @PACKAGE@
-PACKAGE_BUGREPORT = @PACKAGE_BUGREPORT@
-PACKAGE_NAME = @PACKAGE_NAME@
-PACKAGE_STRING = @PACKAGE_STRING@
-PACKAGE_TARNAME = @PACKAGE_TARNAME@
-PACKAGE_VERSION = @PACKAGE_VERSION@
-PATH_SEPARATOR = @PATH_SEPARATOR@
-RANLIB = @RANLIB@
-SET_MAKE = @SET_MAKE@
-SHELL = @SHELL@
-STRIP = @STRIP@
-VERSION = @VERSION@
-XENO_BUILD_STRING = @XENO_BUILD_STRING@
-XENO_FP_CFLAGS = @XENO_FP_CFLAGS@
-XENO_HOST_STRING = @XENO_HOST_STRING@
-XENO_KBUILD_CLEAN = @XENO_KBUILD_CLEAN@
-XENO_KBUILD_CMD = @XENO_KBUILD_CMD@
-XENO_KBUILD_DISTCLEAN = @XENO_KBUILD_DISTCLEAN@
-XENO_KBUILD_ENV = @XENO_KBUILD_ENV@
-XENO_KMOD_APP_CFLAGS = @XENO_KMOD_APP_CFLAGS@
-XENO_KMOD_CFLAGS = @XENO_KMOD_CFLAGS@
-XENO_LINUX_DIR = @XENO_LINUX_DIR@
-XENO_LINUX_VERSION = @XENO_LINUX_VERSION@
-XENO_MAYBE_DOCDIR = @XENO_MAYBE_DOCDIR@
-XENO_MAYBE_SIMDIR = @XENO_MAYBE_SIMDIR@
-XENO_MODULE_DIR = @XENO_MODULE_DIR@
-XENO_MODULE_EXT = @XENO_MODULE_EXT@
-XENO_PIPE_NRDEV = @XENO_PIPE_NRDEV@
-XENO_SYMBOL_DIR = @XENO_SYMBOL_DIR@
-XENO_TARGET_ARCH = @XENO_TARGET_ARCH@
-XENO_TARGET_SUBARCH = @XENO_TARGET_SUBARCH@
-XENO_USER_APP_CFLAGS = @XENO_USER_APP_CFLAGS@
-XENO_USER_CFLAGS = @XENO_USER_CFLAGS@
-ac_ct_AR = @ac_ct_AR@
-ac_ct_CC = @ac_ct_CC@
-ac_ct_CC_FOR_BUILD = @ac_ct_CC_FOR_BUILD@
-ac_ct_CXX = @ac_ct_CXX@
-ac_ct_F77 = @ac_ct_F77@
-ac_ct_RANLIB = @ac_ct_RANLIB@
-ac_ct_STRIP = @ac_ct_STRIP@
-am__fastdepCC_FALSE = @am__fastdepCC_FALSE@
-am__fastdepCC_TRUE = @am__fastdepCC_TRUE@
-am__fastdepCXX_FALSE = @am__fastdepCXX_FALSE@
-am__fastdepCXX_TRUE = @am__fastdepCXX_TRUE@
-am__include = @am__include@
-am__leading_dot = @am__leading_dot@
-am__quote = @am__quote@
-am__tar = @am__tar@
-am__untar = @am__untar@
-bindir = @bindir@
-build = @build@
-build_alias = @build_alias@
-build_cpu = @build_cpu@
-build_os = @build_os@
-build_vendor = @build_vendor@
-datadir = @datadir@
-exec_prefix = @exec_prefix@
-host = @host@
-host_alias = @host_alias@
-host_cpu = @host_cpu@
-host_os = @host_os@
-host_vendor = @host_vendor@
-includedir = $(prefix)/include/nucleus/asm-ppc
-infodir = @infodir@
-install_sh = @install_sh@
-libdir = @libdir@
-libexecdir = @libexecdir@
-localstatedir = @localstatedir@
-mandir = @mandir@
-mkdir_p = @mkdir_p@
-oldincludedir = @oldincludedir@
-prefix = @prefix@
-program_transform_name = @program_transform_name@
-sbindir = @sbindir@
-sharedstatedir = @sharedstatedir@
-subdirs = @subdirs@
-sysconfdir = @sysconfdir@
-target = @target@
-target_alias = @target_alias@
-target_cpu = @target_cpu@
-target_os = @target_os@
-target_vendor = @target_vendor@
-include_HEADERS = \
-		atomic.h \
-		calibration.h \
-		hal.h \
-		system.h \
-		syscall.h \
-		uart.h
-
-all: all-am
-
-.SUFFIXES:
-$(srcdir)/GNUmakefile.in: @MAINTAINER_MODE_TRUE@ $(srcdir)/GNUmakefile.am  $(am__configure_deps)
-	@for dep in $?; do \
-	  case '$(am__configure_deps)' in \
-	    *$$dep*) \
-	      cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh \
-		&& exit 0; \
-	      exit 1;; \
-	  esac; \
-	done; \
-	echo ' cd $(top_srcdir) && $(AUTOMAKE) --foreign  include/nucleus/asm-ppc/GNUmakefile'; \
-	cd $(top_srcdir) && \
-	  $(AUTOMAKE) --foreign  include/nucleus/asm-ppc/GNUmakefile
-.PRECIOUS: GNUmakefile
-GNUmakefile: $(srcdir)/GNUmakefile.in $(top_builddir)/config.status
-	@case '$?' in \
-	  *config.status*) \
-	    cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh;; \
-	  *) \
-	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__depfiles_maybe)'; \
-	    cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__depfiles_maybe);; \
-	esac;
-
-$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
-	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
-
-$(top_srcdir)/configure: @MAINTAINER_MODE_TRUE@ $(am__configure_deps)
-	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
-$(ACLOCAL_M4): @MAINTAINER_MODE_TRUE@ $(am__aclocal_m4_deps)
-	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
-
-mostlyclean-libtool:
-	-rm -f *.lo
-
-clean-libtool:
-	-rm -rf .libs _libs
-
-distclean-libtool:
-	-rm -f libtool
-uninstall-info-am:
-install-includeHEADERS: $(include_HEADERS)
-	@$(NORMAL_INSTALL)
-	test -z "$(includedir)" || $(mkdir_p) "$(DESTDIR)$(includedir)"
-	@list='$(include_HEADERS)'; for p in $$list; do \
-	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
-	  f=$(am__strip_dir) \
-	  echo " $(includeHEADERS_INSTALL) '$$d$$p' '$(DESTDIR)$(includedir)/$$f'"; \
-	  $(includeHEADERS_INSTALL) "$$d$$p" "$(DESTDIR)$(includedir)/$$f"; \
-	done
-
-uninstall-includeHEADERS:
-	@$(NORMAL_UNINSTALL)
-	@list='$(include_HEADERS)'; for p in $$list; do \
-	  f=$(am__strip_dir) \
-	  echo " rm -f '$(DESTDIR)$(includedir)/$$f'"; \
-	  rm -f "$(DESTDIR)$(includedir)/$$f"; \
-	done
-
-ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
-	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
-	unique=`for i in $$list; do \
-	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
-	  done | \
-	  $(AWK) '    { files[$$0] = 1; } \
-	       END { for (i in files) print i; }'`; \
-	mkid -fID $$unique
-tags: TAGS
-
-TAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
-		$(TAGS_FILES) $(LISP)
-	tags=; \
-	here=`pwd`; \
-	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
-	unique=`for i in $$list; do \
-	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
-	  done | \
-	  $(AWK) '    { files[$$0] = 1; } \
-	       END { for (i in files) print i; }'`; \
-	if test -z "$(ETAGS_ARGS)$$tags$$unique"; then :; else \
-	  test -n "$$unique" || unique=$$empty_fix; \
-	  $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
-	    $$tags $$unique; \
-	fi
-ctags: CTAGS
-CTAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
-		$(TAGS_FILES) $(LISP)
-	tags=; \
-	here=`pwd`; \
-	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
-	unique=`for i in $$list; do \
-	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
-	  done | \
-	  $(AWK) '    { files[$$0] = 1; } \
-	       END { for (i in files) print i; }'`; \
-	test -z "$(CTAGS_ARGS)$$tags$$unique" \
-	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
-	     $$tags $$unique
-
-GTAGS:
-	here=`$(am__cd) $(top_builddir) && pwd` \
-	  && cd $(top_srcdir) \
-	  && gtags -i $(GTAGS_ARGS) $$here
-
-distclean-tags:
-	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
-
-distdir: $(DISTFILES)
-	@srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`; \
-	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's|.|.|g'`; \
-	list='$(DISTFILES)'; for file in $$list; do \
-	  case $$file in \
-	    $(srcdir)/*) file=`echo "$$file" | sed "s|^$$srcdirstrip/||"`;; \
-	    $(top_srcdir)/*) file=`echo "$$file" | sed "s|^$$topsrcdirstrip/|$(top_builddir)/|"`;; \
-	  esac; \
-	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
-	  dir=`echo "$$file" | sed -e 's,/[^/]*$$,,'`; \
-	  if test "$$dir" != "$$file" && test "$$dir" != "."; then \
-	    dir="/$$dir"; \
-	    $(mkdir_p) "$(distdir)$$dir"; \
-	  else \
-	    dir=''; \
-	  fi; \
-	  if test -d $$d/$$file; then \
-	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
-	      cp -pR $(srcdir)/$$file $(distdir)$$dir || exit 1; \
-	    fi; \
-	    cp -pR $$d/$$file $(distdir)$$dir || exit 1; \
-	  else \
-	    test -f $(distdir)/$$file \
-	    || cp -p $$d/$$file $(distdir)/$$file \
-	    || exit 1; \
-	  fi; \
-	done
-check-am: all-am
-check: check-am
-all-am: GNUmakefile $(HEADERS)
-installdirs:
-	for dir in "$(DESTDIR)$(includedir)"; do \
-	  test -z "$$dir" || $(mkdir_p) "$$dir"; \
-	done
-install: install-am
-install-exec: install-exec-am
-install-data: install-data-am
-uninstall: uninstall-am
-
-install-am: all-am
-	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am
-
-installcheck: installcheck-am
-install-strip:
-	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
-	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
-	  `test -z '$(STRIP)' || \
-	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
-mostlyclean-generic:
-
-clean-generic:
-
-distclean-generic:
-	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
-
-maintainer-clean-generic:
-	@echo "This command is intended for maintainers to use"
-	@echo "it deletes files that may require special tools to rebuild."
-clean: clean-am
-
-clean-am: clean-generic clean-libtool mostlyclean-am
-
-distclean: distclean-am
-	-rm -f GNUmakefile
-distclean-am: clean-am distclean-generic distclean-libtool \
-	distclean-tags
-
-dvi: dvi-am
-
-dvi-am:
-
-html: html-am
-
-info: info-am
-
-info-am:
-
-install-data-am: install-data-local install-includeHEADERS
-
-install-exec-am:
-
-install-info: install-info-am
-
-install-man:
-
-installcheck-am:
-
-maintainer-clean: maintainer-clean-am
-	-rm -f GNUmakefile
-maintainer-clean-am: distclean-am maintainer-clean-generic
-
-mostlyclean: mostlyclean-am
-
-mostlyclean-am: mostlyclean-generic mostlyclean-libtool
-
-pdf: pdf-am
-
-pdf-am:
-
-ps: ps-am
-
-ps-am:
-
-uninstall-am: uninstall-includeHEADERS uninstall-info-am \
-	uninstall-local
-
-.PHONY: CTAGS GTAGS all all-am check check-am clean clean-generic \
-	clean-libtool ctags distclean distclean-generic \
-	distclean-libtool distclean-tags distdir dvi dvi-am html \
-	html-am info info-am install install-am install-data \
-	install-data-am install-data-local install-exec \
-	install-exec-am install-includeHEADERS install-info \
-	install-info-am install-man install-strip installcheck \
-	installcheck-am installdirs maintainer-clean \
-	maintainer-clean-generic mostlyclean mostlyclean-generic \
-	mostlyclean-libtool pdf pdf-am ps ps-am tags uninstall \
-	uninstall-am uninstall-includeHEADERS uninstall-info-am \
-	uninstall-local
-
-
-install-data-local:
-	$(mkinstalldirs) $(DESTDIR)$(includedir)
-	rm -f $(DESTDIR)$(includedir)/../asm
-	$(LN_S) asm-ppc $(DESTDIR)$(includedir)/../asm
-
-uninstall-local:
-	$(RM) $(DESTDIR)$(includedir)/../asm
-# Tell versions [3.59,3.63) of GNU make to not export all variables.
-# Otherwise a system limit (for SysV at least) may be exceeded.
-.NOEXPORT:
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/hal.h xenomai-devel/include/nucleus/asm-ppc/hal.h
--- xenomai-orig/include/nucleus/asm-ppc/hal.h	2005-10-11 10:30:01.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/hal.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,263 +0,0 @@
-/**
- *   @ingroup hal
- *   @file
- *
- *   Real-Time Hardware Abstraction Layer for PowerPC.
- *
- *   Copyright &copy; 2002-2004 Philippe Gerum.
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
-
-#ifndef _XENO_ASM_PPC_HAL_H
-#define _XENO_ASM_PPC_HAL_H
-
-#include <nucleus/asm-generic/hal.h>	/* Read the generic bits. */
-#include <asm/div64.h>
-
-typedef unsigned long long rthal_time_t;
-
-#define __rthal_u64tou32(ull, h, l) ({                  \
-        union { unsigned long long _ull;                \
-            struct { u_long _h; u_long _l; } _s; } _u;  \
-        _u._ull = (ull);                                \
-        (h) = _u._s._h;                                 \
-        (l) = _u._s._l;                                 \
-        })
-
-#define __rthal_u64fromu32(h, l) ({                     \
-        union { unsigned long long _ull;                \
-            struct { u_long _h; u_long _l; } _s; } _u;  \
-        _u._s._h = (h);                                 \
-        _u._s._l = (l);                                 \
-        _u._ull;                                        \
-        })
-
-static inline unsigned long long rthal_ullmul(const unsigned long m0, 
-					      const unsigned long m1)
-{
-    return (unsigned long long) m0 * m1;
-}
-
-static inline unsigned long long rthal_ulldiv (unsigned long long ull,
-					       const unsigned long uld,
-					       unsigned long *const rp)
-{
-#if defined(__KERNEL__) && BITS_PER_LONG == 32
-    const unsigned long r = __div64_32(&ull, uld);
-#else /* !__KERNEL__ || BITS_PER_LONG == 64 */
-    const unsigned long r = ull % uld;
-    ull /= uld;
-#endif /* __KERNEL__ */
-
-    if (rp)
-	*rp = r;
-
-    return ull;
-}
-
-#define rthal_uldivrem(ull,ul,rp) ((u_long) rthal_ulldiv((ull),(ul),(rp)))
-
-static inline int rthal_imuldiv (int i, int mult, int div) {
-
-    /* Returns (int)i = (unsigned long long)i*(u_long)(mult)/(u_long)div. */
-    const unsigned long long ull = rthal_ullmul(i, mult);
-    return rthal_uldivrem(ull, div, NULL);
-}
-
-static inline __attribute_const__
-unsigned long long __rthal_ullimd (const unsigned long long op,
-                                   const unsigned long m,
-                                   const unsigned long d)
-{
-    u_long oph, opl, tlh, tll, qh, rh, ql;
-    unsigned long long th, tl;
-
-    __rthal_u64tou32(op, oph, opl);
-    tl = rthal_ullmul(opl, m);
-    __rthal_u64tou32(tl, tlh, tll);
-    th = rthal_ullmul(oph, m);
-    th += tlh;
-
-    qh = rthal_uldivrem(th, d, &rh);
-    th = __rthal_u64fromu32(rh, tll);
-    ql = rthal_uldivrem(th, d, NULL);
-    return __rthal_u64fromu32(qh, ql);
-}
-
-static inline long long rthal_llimd (long long op,
-                                     unsigned long m,
-                                     unsigned long d)
-{
-
-    if(op < 0LL)
-        return -__rthal_ullimd(-op, m, d);
-    return __rthal_ullimd(op, m, d);
-}
-
-static inline __attribute_const__ unsigned long ffnz (unsigned long ul) {
-
-    __asm__ ("cntlzw %0, %1" : "=r" (ul) : "r" (ul & (-ul)));
-    return 31 - ul;
-}
-
-#if defined(__KERNEL__) && !defined(__cplusplus)
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/timex.h>
-#include <nucleus/asm/atomic.h>
-#include <asm/processor.h>
-
-#ifdef CONFIG_ADEOS_CORE
-#define RTHAL_TIMER_IRQ   ADEOS_TIMER_VIRQ
-#else /* !CONFIG_ADEOS_CORE */
-#define RTHAL_TIMER_IRQ   IPIPE_TIMER_VIRQ
-#endif /* CONFIG_ADEOS_CORE */
-
-#define rthal_irq_descp(irq)  (irq_desc + irq)
-
-static inline unsigned long long rthal_rdtsc (void) {
-    unsigned long long t;
-    rthal_read_tsc(t);
-    return t;
-}
-
-#if defined(CONFIG_ADEOS_CORE) && !defined(CONFIG_ADEOS_NOTHREADS)
-
-/* Since real-time interrupt handlers are called on behalf of the
-   Xenomai domain stack, we cannot infere the "current" Linux task
-   address using %esp. We must use the suspended Linux domain's stack
-   pointer instead. */
-
-static inline struct task_struct *rthal_root_host_task (int cpuid) {
-    return ((struct thread_info *)(rthal_root_domain->esp[cpuid] & (~8191UL)))->task;
-}
-
-static inline struct task_struct *rthal_current_host_task (int cpuid)
-
-{
-    register unsigned long esp asm ("r1");
-    
-    if (esp >= rthal_domain.estackbase[cpuid] && esp < rthal_domain.estackbase[cpuid] + 8192)
-	return rthal_root_host_task(cpuid);
-
-    return current;
-}
-
-#else /* !CONFIG_ADEOS_CORE || CONFIG_ADEOS_NOTHREADS */
-
-static inline struct task_struct *rthal_root_host_task (int cpuid) {
-    return current;
-}
-
-static inline struct task_struct *rthal_current_host_task (int cpuid) {
-    return current;
-}
-
-#endif /* CONFIG_ADEOS_CORE && !CONFIG_ADEOS_NOTHREADS */
-
-static inline void rthal_timer_program_shot (unsigned long delay)
-{
-    if(!delay) delay = 1;
-#ifdef CONFIG_40x
-    mtspr(SPRN_PIT,delay);
-#else /* !CONFIG_40x */
-    set_dec(delay);
-#endif /* CONFIG_40x */
-}
-
-    /* Private interface -- Internal use only */
-
-/* The following must be kept in sync w/ rthal_switch_context() in
-   switch.S */
-#define RTHAL_SWITCH_FRAME_SIZE  108
-
-void rthal_switch_context(unsigned long *out_kspp,
-			  unsigned long *in_kspp);
-
-#ifdef CONFIG_XENO_HW_FPU
-
-typedef struct rthal_fpenv {
-    
-    /* This layout must follow exactely the definition of the FPU
-       backup area in a PPC thread struct available from
-       <asm-ppc/processor.h>. Specifically, fpr[] an fpscr words must
-       be contiguous in memory (see arch/ppc/hal/fpu.S). */
-
-    double fpr[32];
-    unsigned long fpscr_pad;	/* <= Hi-word of the FPR used to */
-    unsigned long fpscr;	/* retrieve the FPSCR. */
-
-} rthal_fpenv_t;
-
-void rthal_init_fpu(rthal_fpenv_t *fpuenv);
-
-void rthal_save_fpu(rthal_fpenv_t *fpuenv);
-
-void rthal_restore_fpu(rthal_fpenv_t *fpuenv);
-
-#ifndef CONFIG_SMP
-#define rthal_get_fpu_owner(cur) last_task_used_math
-#else /* CONFIG_SMP */
-#define rthal_get_fpu_owner(cur) ({                             \
-    struct task_struct * _cur = (cur);                          \
-    ((_cur->thread.regs && (_cur->thread.regs->msr & MSR_FP))   \
-     ? _cur : NULL);                                            \
-})
-#endif /* CONFIG_SMP */
-    
-#define rthal_disable_fpu() ({                          \
-    register long _msr;                                 \
-    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
-    __asm__ __volatile__ ( "mtmsr %0"                   \
-                           : /* no output */            \
-                           : "r"(_msr & ~(MSR_FP))      \
-                           : "memory" );                \
-})
-
-#define rthal_enable_fpu() ({                           \
-    register long _msr;                                 \
-    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
-    __asm__ __volatile__ ( "mtmsr %0"                   \
-                           : /* no output */            \
-                           : "r"(_msr | MSR_FP)         \
-                           : "memory" );                \
-})
-
-#endif /* CONFIG_XENO_HW_FPU */
-
-static const char *const rthal_fault_labels[] = {
-    [0] = "Data or instruction access",
-    [1] = "Alignment",
-    [2] = "Altivec unavailable",
-    [3] = "Program check exception",
-    [4] = "Machine check exception",
-    [5] = "Unknown",
-    [6] = "Instruction breakpoint",
-    [7] = "Run mode exception",
-    [8] = "Single-step exception",
-    [9] = "Non-recoverable exception",
-    [10] = "Software emulation",
-    [11] = "Debug",
-    [12] = "SPE",
-    [13] = "Altivec assist",
-    [14] = NULL
-};
-
-#endif /* __KERNEL__ && !__cplusplus */
-
-#endif /* !_XENO_ASM_PPC_HAL_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/syscall.h xenomai-devel/include/nucleus/asm-ppc/syscall.h
--- xenomai-orig/include/nucleus/asm-ppc/syscall.h	2005-10-11 10:30:01.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/syscall.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,183 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
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
-
-#ifndef _XENO_ASM_PPC_SYSCALL_H
-#define _XENO_ASM_PPC_SYSCALL_H
-
-#include <xeno_config.h>
-#include <asm/ptrace.h>
-#include <nucleus/asm-generic/syscall.h>
-
-/*
- * Some of the following macros have been adapted from Linux's
- * implementation of the syscall mechanism in <asm-ppc/unistd.h>:
- *
- * The following code defines an inline syscall mechanism used by
- * Xenomai's real-time interfaces to invoke the skin module
- * services in kernel space.
- */
-
-#define XENOMAI_DO_SYSCALL(nr, id, op, args...)			\
-  ({								\
-	register unsigned long __sc_0  __asm__ ("r0");		\
-	register unsigned long __sc_3  __asm__ ("r3");		\
-	register unsigned long __sc_4  __asm__ ("r4");		\
-	register unsigned long __sc_5  __asm__ ("r5");		\
-	register unsigned long __sc_6  __asm__ ("r6");		\
-	register unsigned long __sc_7  __asm__ ("r7");		\
-								\
-	LOADARGS_##nr(__xn_mux_code(id,op), args);		\
-	__asm__ __volatile__					\
-		("sc           \n\t"				\
-		 "mfcr %0      "				\
-		: "=&r" (__sc_0),				\
-		  "=&r" (__sc_3),  "=&r" (__sc_4),		\
-		  "=&r" (__sc_5),  "=&r" (__sc_6),		\
-		  "=&r" (__sc_7)				\
-		: ASM_INPUT_##nr				\
-		: "cr0", "ctr", "memory",			\
-		  "r8", "r9", "r10","r11", "r12");		\
-	(int)((__sc_0 & (1 << 28)) ? -__sc_3 : __sc_3);		\
-  })
-
-#define LOADARGS_0(muxcode, dummy...)				\
-	__sc_0 = muxcode
-#define LOADARGS_1(muxcode, arg1)				\
-	LOADARGS_0(muxcode);					\
-	__sc_3 = (unsigned long) (arg1)
-#define LOADARGS_2(muxcode, arg1, arg2)				\
-	LOADARGS_1(muxcode, arg1);				\
-	__sc_4 = (unsigned long) (arg2)
-#define LOADARGS_3(muxcode, arg1, arg2, arg3)			\
-	LOADARGS_2(muxcode, arg1, arg2);			\
-	__sc_5 = (unsigned long) (arg3)
-#define LOADARGS_4(muxcode, arg1, arg2, arg3, arg4)		\
-	LOADARGS_3(muxcode, arg1, arg2, arg3);			\
-	__sc_6 = (unsigned long) (arg4)
-#define LOADARGS_5(muxcode, arg1, arg2, arg3, arg4, arg5)	\
-	LOADARGS_4(muxcode, arg1, arg2, arg3, arg4);		\
-	__sc_7 = (unsigned long) (arg5)
-
-#define ASM_INPUT_0 "0" (__sc_0)
-#define ASM_INPUT_1 ASM_INPUT_0, "1" (__sc_3)
-#define ASM_INPUT_2 ASM_INPUT_1, "2" (__sc_4)
-#define ASM_INPUT_3 ASM_INPUT_2, "3" (__sc_5)
-#define ASM_INPUT_4 ASM_INPUT_3, "4" (__sc_6)
-#define ASM_INPUT_5 ASM_INPUT_4, "5" (__sc_7)
-
-/* Register mapping for accessing syscall args. */
-
-#define __xn_reg_mux(regs)    ((regs)->gpr[0])
-#define __xn_reg_rval(regs)   ((regs)->gpr[3])
-#define __xn_reg_arg1(regs)   ((regs)->gpr[3])
-#define __xn_reg_arg2(regs)   ((regs)->gpr[4])
-#define __xn_reg_arg3(regs)   ((regs)->gpr[5])
-#define __xn_reg_arg4(regs)   ((regs)->gpr[6])
-#define __xn_reg_arg5(regs)   ((regs)->gpr[7])
-
-#define __xn_reg_mux_p(regs)        ((__xn_reg_mux(regs) & 0xffff) == __xn_sys_mux)
-#define __xn_mux_id(regs)           ((__xn_reg_mux(regs) >> 16) & 0xff)
-#define __xn_mux_op(regs)           ((__xn_reg_mux(regs) >> 24) & 0xff)
-#define __xn_mux_code(id,op)        ((op << 24)|((id << 16) & 0xff0000)|(__xn_sys_mux & 0xffff))
-
-#define XENOMAI_SYSCALL0(op)                XENOMAI_DO_SYSCALL(0,0,op)
-#define XENOMAI_SYSCALL1(op,a1)             XENOMAI_DO_SYSCALL(1,0,op,a1)
-#define XENOMAI_SYSCALL2(op,a1,a2)          XENOMAI_DO_SYSCALL(2,0,op,a1,a2)
-#define XENOMAI_SYSCALL3(op,a1,a2,a3)       XENOMAI_DO_SYSCALL(3,0,op,a1,a2,a3)
-#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)    XENOMAI_DO_SYSCALL(4,0,op,a1,a2,a3,a4)
-#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,0,op,a1,a2,a3,a4,a5)
-
-#define XENOMAI_SKINCALL0(id,op)                XENOMAI_DO_SYSCALL(0,id,op)
-#define XENOMAI_SKINCALL1(id,op,a1)             XENOMAI_DO_SYSCALL(1,id,op,a1)
-#define XENOMAI_SKINCALL2(id,op,a1,a2)          XENOMAI_DO_SYSCALL(2,id,op,a1,a2)
-#define XENOMAI_SKINCALL3(id,op,a1,a2,a3)       XENOMAI_DO_SYSCALL(3,id,op,a1,a2,a3)
-#define XENOMAI_SKINCALL4(id,op,a1,a2,a3,a4)    XENOMAI_DO_SYSCALL(4,id,op,a1,a2,a3,a4)
-#define XENOMAI_SKINCALL5(id,op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,id,op,a1,a2,a3,a4,a5)
-
-#ifdef __KERNEL__
-
-#include <linux/errno.h>
-#include <asm/uaccess.h>
-
-/* Our own set of copy-to/from-user macros which must bypass
-   might_sleep() checks. The caller cannot fault and is expected to
-   have checked for bad range before using the copy macros, so we
-   should not have to care about the result. */
-#define __xn_copy_from_user(task,dstP,srcP,n)  \
-    ({ int err = __copy_from_user_inatomic(dstP,srcP,n); err; })
-#define __xn_copy_to_user(task,dstP,srcP,n)  \
-    ({ int err = __copy_to_user_inatomic(dstP,srcP,n); err; })
-#define __xn_put_user(task,src,dstP)           __put_user(src,dstP)
-#define __xn_get_user(task,dst,srcP)           __get_user(dst,srcP)
-#define __xn_strncpy_from_user(task,dstP,srcP,n)    __strncpy_from_user(dstP,srcP,n)
-
-#define __xn_range_ok(task,addr,size) \
-        ((unsigned long)(addr) <= (task)->thread.fs.seg \
-	 && ((size) == 0 || (size) - 1 <= (task)->thread.fs.seg - (unsigned long)(addr)))
-
-#define __xn_access_ok(task,type,addr,size)  __xn_range_ok((task),(addr),(size))
-
-/* Purposedly used inlines and not macros for the following routines
-   so that we don't risk spurious side-effects on the value arg. */
-
-static inline void __xn_success_return(struct pt_regs *regs, int v) {
-    __xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_error_return(struct pt_regs *regs, int v) {
-    /* We currently never set the SO bit for marking errors, even if
-     * we always test it upon syscall return. */
-    __xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, int v) {
-    __xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs) {
-    return __xn_reg_rval(regs) == -EINTR;
-}
-
-#else /* !__KERNEL__ */
-
-#define CONFIG_XENO_HW_DIRECT_TSC 1
-
-static inline unsigned long long __xn_rdtsc (void)
-
-{
-    union {
-	unsigned long long t;
-	unsigned long v[2];
-    } u;
-    unsigned long __tbu;
-
-    __asm__ __volatile__ ("1: mftbu %0\n"
-			  "mftb %1\n"
-			  "mftbu %2\n"
-			  "cmpw %2,%0\n"
-			  "bne- 1b\n"
-			  :"=r" (u.v[0]),
-			  "=r" (u.v[1]),
-			  "=r" (__tbu));
-    return u.t;
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* !_XENO_ASM_PPC_SYSCALL_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/system.h xenomai-devel/include/nucleus/asm-ppc/system.h
--- xenomai-orig/include/nucleus/asm-ppc/system.h	2005-10-11 10:30:01.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/system.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,617 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
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
-#ifndef _XENO_ASM_PPC_SYSTEM_H
-#define _XENO_ASM_PPC_SYSTEM_H
-
-#include <nucleus/asm-generic/system.h>
-
-#ifdef __KERNEL__
-
-#include <linux/config.h>
-#include <linux/ptrace.h>
-
-#ifdef CONFIG_ADEOS_CORE
-#if ADEOS_RELEASE_NUMBER < 0x02060703
-#error "Adeos 2.6r7c3/ppc or above is required to run this software; please upgrade."
-#error "See http://download.gna.org/adeos/patches/v2.6/ppc/"
-#endif
-#endif /* CONFIG_ADEOS_CORE */
-
-#define XNARCH_DEFAULT_TICK     1000000 /* ns, i.e. 1ms */
-#define XNARCH_HOST_TICK        (1000000000UL/HZ)
-
-#define XNARCH_THREAD_STACKSZ   4096
-
-#define xnarch_stack_size(tcb)  ((tcb)->stacksize)
-#define xnarch_user_task(tcb)   ((tcb)->user_task)
-#define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
-
-#define xnarch_alloc_stack xnmalloc
-#define xnarch_free_stack  xnfree
-
-struct xnthread;
-struct task_struct;
-
-typedef struct xnarchtcb {	/* Per-thread arch-dependent block */
-
-    /* Kernel mode side */
-
-#ifdef CONFIG_XENO_HW_FPU
-    /* We only care for basic FPU handling in kernel-space; Altivec
-       and SPE are not available to kernel-based nucleus threads. */
-    rthal_fpenv_t fpuenv  __attribute__ ((aligned (16)));
-    rthal_fpenv_t *fpup;	/* Pointer to the FPU backup area */
-    struct task_struct *user_fpu_owner;
-    /* Pointer the the FPU owner in userspace:
-       - NULL for RT K threads,
-       - last_task_used_math for Linux US threads (only current or NULL when MP)
-       - current for RT US threads.
-    */
-#define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
-#else /* !CONFIG_XENO_HW_FPU */
-#define xnarch_fpu_ptr(tcb)     NULL
-#endif /* CONFIG_XENO_HW_FPU */
-
-    unsigned stacksize;		/* Aligned size of stack (bytes) */
-    unsigned long *stackbase;	/* Stack space */
-    unsigned long ksp;		/* Saved KSP for kernel-based threads */
-    unsigned long *kspp;	/* Pointer to saved KSP (&ksp or &user->thread.ksp) */
-
-    /* User mode side */
-    struct task_struct *user_task;	/* Shadowed user-space task */
-    struct task_struct *active_task;	/* Active user-space task */
-
-    /* Init block */
-    struct xnthread *self;
-    int imask;
-    const char *name;
-    void (*entry)(void *cookie);
-    void *cookie;
-
-} xnarchtcb_t;
-
-typedef struct xnarch_fltinfo {
-
-    unsigned exception;
-    struct pt_regs *regs;
-
-} xnarch_fltinfo_t;
-
-#define xnarch_fault_trap(fi)   ((unsigned int)(fi)->regs->trap)
-#define xnarch_fault_code(fi)   ((fi)->regs->dar)
-#define xnarch_fault_pc(fi)     ((fi)->regs->nip)
-#define xnarch_fault_pc(fi)     ((fi)->regs->nip)
-/* FIXME: FPU faults ignored by the nanokernel on PPC. */
-#define xnarch_fault_fpu_p(fi)  (0)
-/* The following predicates are only usable over a regular Linux stack
-   context. */
-#ifdef CONFIG_ADEOS_CORE
-#define xnarch_fault_pf_p(fi)   ((fi)->exception == ADEOS_ACCESS_TRAP)
-#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
-				 ((fi)->exception == ADEOS_IABR_TRAP || \
-				  (fi)->exception == ADEOS_SSTEP_TRAP || \
-				  (fi)->exception == ADEOS_DEBUG_TRAP))
-#else /* !CONFIG_ADEOS_CORE */
-#define xnarch_fault_pf_p(fi)   ((fi)->exception == IPIPE_TRAP_ACCESS)
-#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
-				 ((fi)->exception == IPIPE_TRAP_IABR || \
-				  (fi)->exception == IPIPE_TRAP_SSTEP || \
-				  (fi)->exception == IPIPE_TRAP_DEBUG))
-#endif /* CONFIG_ADEOS_CORE */
-
-#define xnarch_fault_notify(fi) (!xnarch_fault_bp_p(fi))
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-static inline void *xnarch_sysalloc (u_long bytes)
-
-{
-#if 0	/* FIXME: likely on-demand mapping bug here */
-    if (bytes >= 128*1024)
-	return vmalloc(bytes);
-#endif
-
-    return kmalloc(bytes,GFP_KERNEL);
-}
-
-static inline void xnarch_sysfree (void *chunk, u_long bytes)
-
-{
-#if 0	/* FIXME: likely on-demand mapping bug here */
-    if (bytes >= 128*1024)
-	vfree(chunk);
-    else
-#endif
-	kfree(chunk);
-}
-
-static inline void xnarch_relay_tick (void)
-
-{
-    rthal_irq_host_pend(RTHAL_TIMER_IRQ);
-}
-
-#ifdef XENO_POD_MODULE
-
-void xnpod_welcome_thread(struct xnthread *);
-
-void xnpod_delete_thread(struct xnthread *);
-
-static inline int xnarch_start_timer (unsigned long ns,
-				      void (*tickhandler)(void))
-{
-    return rthal_timer_request(tickhandler,ns);
-}
-
-static inline void xnarch_leave_root (xnarchtcb_t *rootcb)
-
-{
-    rthal_declare_cpuid;
-
-    rthal_load_cpuid();
-
-    /* rthal_cpu_realtime is only tested for the current processor,
-       and always inside a critical section. */
-    __set_bit(cpuid,&rthal_cpu_realtime);
-    /* Remember the preempted Linux task pointer. */
-    rootcb->user_task = rootcb->active_task = rthal_current_host_task(cpuid);
-#ifdef CONFIG_XENO_HW_FPU
-    rootcb->user_fpu_owner = rthal_get_fpu_owner(rootcb->user_task);
-    /* So that xnarch_save_fpu() will operate on the right FPU area. */
-    rootcb->fpup = (rootcb->user_fpu_owner
-                    ? (rthal_fpenv_t *)&rootcb->user_fpu_owner->thread.fpr[0]
-                    : NULL);
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_enter_root (xnarchtcb_t *rootcb) {
-    __clear_bit(xnarch_current_cpu(),&rthal_cpu_realtime);
-}
-
-static inline void xnarch_switch_to (xnarchtcb_t *out_tcb,
-				     xnarchtcb_t *in_tcb)
-{
-    struct task_struct *prev = out_tcb->active_task;
-    struct task_struct *next = in_tcb->user_task;
-
-    in_tcb->active_task = next ?: prev;
-
-    if (next && next != prev) /* Switch to new user-space thread? */
-	{
-	struct mm_struct *mm = next->active_mm;
-
-	/* Switch the mm context.*/
-
-#ifdef CONFIG_ALTIVEC
-	/* Don't rely on FTR fixups --
-	   they don't work properly in our context. */
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC) {
-	    asm volatile (
-		"dssall;\n"
-#ifndef CONFIG_POWER4
-		"sync;\n"
-#endif
-		: : );
-	}
-#endif /* CONFIG_ALTIVEC */
-
-	next->thread.pgdir = mm->pgd;
-	get_mmu_context(mm);
-	set_context(mm->context,mm->pgd);
-
-	/* _switch expects a valid "current" (r2) for storing
-	 * ALTIVEC and SPE state. */
-	current = prev;
-        _switch(&prev->thread, &next->thread);
-
-	barrier();
-	}
-    else
-        /* Kernel-to-kernel context switch. */
-        rthal_switch_context(out_tcb->kspp,in_tcb->kspp);
-}
-
-static inline void xnarch_finalize_and_switch (xnarchtcb_t *dead_tcb,
-					       xnarchtcb_t *next_tcb)
-{
-    xnarch_switch_to(dead_tcb,next_tcb);
-}
-
-static inline void xnarch_finalize_no_switch (xnarchtcb_t *dead_tcb)
-
-{
-    /* Empty */
-}
-
-static inline void xnarch_init_root_tcb (xnarchtcb_t *tcb,
-					 struct xnthread *thread,
-					 const char *name)
-{
-    tcb->user_task = current;
-    tcb->active_task = NULL;
-    tcb->ksp = 0;
-    tcb->kspp = &tcb->ksp;
-#ifdef CONFIG_XENO_HW_FPU
-    tcb->user_fpu_owner = NULL;
-    tcb->fpup = NULL;
-#endif /* CONFIG_XENO_HW_FPU */
-    tcb->entry = NULL;
-    tcb->cookie = NULL;
-    tcb->self = thread;
-    tcb->imask = 0;
-    tcb->name = name;
-}
-
-asmlinkage static void xnarch_thread_trampoline (xnarchtcb_t *tcb)
-
-{
-    rthal_local_irq_restore(!!tcb->imask);
-    xnpod_welcome_thread(tcb->self);
-    tcb->entry(tcb->cookie);
-    xnpod_delete_thread(tcb->self);
-}
-
-static inline void xnarch_init_thread (xnarchtcb_t *tcb,
-				       void (*entry)(void *),
-				       void *cookie,
-				       int imask,
-				       struct xnthread *thread,
-				       char *name)
-{
-    unsigned long *ksp, flags;
-
-    rthal_local_irq_flags_hw(flags);
-
-    *tcb->stackbase = 0;
-    ksp = (unsigned long *)((((unsigned long)tcb->stackbase + tcb->stacksize - 0x10) & ~0xf)
-			    - RTHAL_SWITCH_FRAME_SIZE);
-    tcb->ksp = (unsigned long)ksp - STACK_FRAME_OVERHEAD;
-    ksp[19] = (unsigned long)tcb; /* r3 */
-    ksp[25] = (unsigned long)&xnarch_thread_trampoline; /* lr */
-    ksp[26] = flags & ~(MSR_EE | MSR_FP); /* msr */
-
-    tcb->entry = entry;
-    tcb->cookie = cookie;
-    tcb->self = thread;
-    tcb->imask = imask;
-    tcb->name = name;
-}
-
-/* No lazy FPU init on PPC. */
-#define xnarch_fpu_init_p(task) (1)
-
-static inline void xnarch_enable_fpu (xnarchtcb_t *current_tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-    if(!current_tcb->user_task)
-        rthal_enable_fpu();
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_init_fpu (xnarchtcb_t *tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-    /* Initialize the FPU for an emerging kernel-based RT thread. This
-       must be run on behalf of the emerging thread. */
-    memset(&tcb->fpuenv,0,sizeof(tcb->fpuenv));
-    rthal_init_fpu(&tcb->fpuenv);
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_save_fpu (xnarchtcb_t *tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-
-    if(tcb->fpup)
-        {
-        rthal_save_fpu(tcb->fpup);
-
-        if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
-            tcb->user_fpu_owner->thread.regs->msr &= ~MSR_FP;
-        }   
-
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_restore_fpu (xnarchtcb_t *tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-
-    if(tcb->fpup)
-        {
-        rthal_restore_fpu(tcb->fpup);
-
-        if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
-            tcb->user_fpu_owner->thread.regs->msr |= MSR_FP;
-        }   
-
-    /* FIXME: We restore FPU "as it was" when Xenomai preempted Linux,
-       whereas we could be much lazier. */
-    if(tcb->user_task)
-        rthal_disable_fpu();
-
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-#endif /* XENO_POD_MODULE */
-
-#ifdef XENO_THREAD_MODULE
-
-static inline void xnarch_init_tcb (xnarchtcb_t *tcb) {
-
-    tcb->user_task = NULL;
-    tcb->active_task = NULL;
-    tcb->kspp = &tcb->ksp;
-#ifdef CONFIG_XENO_HW_FPU
-    tcb->user_fpu_owner = NULL;
-    tcb->fpup = &tcb->fpuenv;
-#endif /* CONFIG_XENO_HW_FPU */
-    /* Must be followed by xnarch_init_thread(). */
-}
-
-#endif /* XENO_THREAD_MODULE */
-
-#ifdef XENO_SHADOW_MODULE
-
-static inline void xnarch_init_shadow_tcb (xnarchtcb_t *tcb,
-					   struct xnthread *thread,
-					   const char *name)
-{
-    struct task_struct *task = current;
-
-    tcb->user_task = task;
-    tcb->active_task = NULL;
-    tcb->ksp = 0;
-    tcb->kspp = &task->thread.ksp;
-#ifdef CONFIG_XENO_HW_FPU
-    tcb->user_fpu_owner = task;
-    tcb->fpup = (rthal_fpenv_t *)&task->thread.fpr[0];
-#endif /* CONFIG_XENO_HW_FPU */
-    tcb->entry = NULL;
-    tcb->cookie = NULL;
-    tcb->self = thread;
-    tcb->imask = 0;
-    tcb->name = name;
-}
-
-static inline void xnarch_grab_xirqs (void (*handler)(unsigned irq))
-
-{
-    unsigned irq;
-
-    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
-	rthal_virtualize_irq(rthal_current_domain,
-			     irq,
-			     handler,
-			     NULL,
-			     IPIPE_DYNAMIC_MASK);
-
-    /* On this arch, the decrementer trap is not an external IRQ but
-       it is instead mapped to a virtual IRQ, so we must grab it
-       individually. */
-
-    rthal_virtualize_irq(rthal_current_domain,
-			 RTHAL_TIMER_IRQ,
-			 handler,
-			 NULL,
-			 IPIPE_DYNAMIC_MASK);
-}
-
-static inline void xnarch_lock_xirqs (rthal_pipeline_stage_t *ipd, int cpuid)
-
-{
-    unsigned irq;
-
-    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
-	{
-	switch (irq)
-	    {
-#ifdef CONFIG_SMP
-	    case RTHAL_CRITICAL_IPI:
-
-		/* Never lock out this one. */
-		continue;
-#endif /* CONFIG_SMP */
-
-	    default:
-
-		rthal_lock_irq(ipd,cpuid,irq);
-	    }
-	}
-
-    rthal_lock_irq(ipd,cpuid,RTHAL_TIMER_IRQ);
-}
-
-static inline void xnarch_unlock_xirqs (rthal_pipeline_stage_t *ipd, int cpuid)
-
-{
-    unsigned irq;
-
-    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
-	{
-	switch (irq)
-	    {
-#ifdef CONFIG_SMP
-	    case RTHAL_CRITICAL_IPI:
-
-		continue;
-#endif /* CONFIG_SMP */
-
-	    default:
-
-		rthal_unlock_irq(ipd,irq);
-	    }
-	}
-
-    rthal_unlock_irq(ipd,RTHAL_TIMER_IRQ);
-}
-
-#endif /* XENO_SHADOW_MODULE */
-
-#ifdef XENO_TIMER_MODULE
-
-static inline void xnarch_program_timer_shot (unsigned long delay) {
-    /* Even though some architectures may use a 64 bits delay here, we
-       voluntarily limit to 32 bits, 4 billions ticks should be enough
-       for now. Would a timer needs more, an extra call to the tick
-       handler would simply occur after 4 billions ticks.  Since the
-       timebase value is used to express CPU ticks on the PowerPC
-       port, there is no need to rescale the delay value. */
-    rthal_timer_program_shot(delay);
-}
-
-static inline void xnarch_stop_timer (void) {
-    rthal_timer_release();
-}
-
-static inline int xnarch_send_timer_ipi (xnarch_cpumask_t mask)
-
-{
-#ifdef CONFIG_SMP
-    return -1;		/* FIXME */
-#else /* ! CONFIG_SMP */
-    return 0;
-#endif /* CONFIG_SMP */
-}
-
-#endif /* XENO_TIMER_MODULE */
-
-#ifdef XENO_MAIN_MODULE
-
-#include <linux/init.h>
-#include <nucleus/asm/calibration.h>
-
-extern u_long nkschedlat;
-
-extern u_long nktimerlat;
-
-int xnarch_escalation_virq;
-
-int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo);
-
-void xnpod_schedule_handler(void);
-
-static rthal_trap_handler_t xnarch_old_trap_handler;
-
-static int xnarch_trap_fault (unsigned event, unsigned domid, void *data)
-{
-    xnarch_fltinfo_t fltinfo;
-    fltinfo.exception = event;
-    fltinfo.regs = (struct pt_regs *)data;
-    return xnpod_trap_fault(&fltinfo);
-}
-
-unsigned long xnarch_calibrate_timer (void)
-
-{
-#if CONFIG_XENO_HW_TIMER_LATENCY != 0
-    return xnarch_ns_to_tsc(CONFIG_XENO_HW_TIMER_LATENCY) ?: 1;
-#else /* CONFIG_XENO_HW_TIMER_LATENCY unspecified. */
-    /* Compute the time needed to program the decrementer in aperiodic
-       mode. The return value is expressed in timebase ticks. */
-    return xnarch_ns_to_tsc(rthal_timer_calibrate()) ?: 1;
-#endif /* CONFIG_XENO_HW_TIMER_LATENCY != 0 */
-}
-
-int xnarch_calibrate_sched (void)
-
-{
-    nktimerlat = xnarch_calibrate_timer();
-
-    if (!nktimerlat)
-	return -ENODEV;
-
-    nkschedlat = xnarch_ns_to_tsc(xnarch_get_sched_latency());
-
-    return 0;
-}
-
-static inline int xnarch_init (void)
-
-{
-    int err;
-
-#ifdef CONFIG_SMP
-    /* The HAL layer also sets the same CPU affinity so that both
-       modules keep their execution sequence on SMP boxen. */
-    set_cpus_allowed(current,cpumask_of_cpu(0));
-#endif /* CONFIG_SMP */
-
-    err = xnarch_calibrate_sched();
-
-    if (err)
-	return err;
-
-    xnarch_escalation_virq = rthal_alloc_virq();
-
-    if (xnarch_escalation_virq == 0)
-	return -ENOSYS;
-
-    rthal_virtualize_irq(&rthal_domain,
-			 xnarch_escalation_virq,
-			 (void (*)(unsigned))&xnpod_schedule_handler,
-			 NULL,
-			 IPIPE_HANDLE_MASK);
-
-    xnarch_old_trap_handler = rthal_trap_catch(&xnarch_trap_fault);
-
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-    err = xnshadow_mount();
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
-
-    if (err)
-	{
-	rthal_trap_catch(xnarch_old_trap_handler);
-        rthal_free_virq(xnarch_escalation_virq);
-	}
-
-    return err;
-}
-
-static inline void xnarch_exit (void)
-
-{
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-    xnshadow_cleanup();
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
-    rthal_trap_catch(xnarch_old_trap_handler);
-    rthal_free_virq(xnarch_escalation_virq);
-}
-
-#endif /* XENO_MAIN_MODULE */
-
-#ifdef __cplusplus
-}
-#endif
-
-#else /* !__KERNEL__ */
-
-#include <nucleus/system.h>
-#include <bits/local_lim.h>
-
-#endif /* __KERNEL__ */
-
-#endif /* !_XENO_ASM_PPC_SYSTEM_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc/uart.h xenomai-devel/include/nucleus/asm-ppc/uart.h
--- xenomai-orig/include/nucleus/asm-ppc/uart.h	2005-10-11 10:30:01.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc/uart.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,35 +0,0 @@
-/**
- * @file
- * This file is part of the Xenomai project.
- *
- * @note Copyright (C) 2004 Philippe Gerum <rpm@xenomai.org> 
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
-
-#ifndef _XENO_ASM_PPC_UART_H
-#define _XENO_ASM_PPC_UART_H
-
-#include <linux/config.h>
-
-#if defined(CONFIG_SANDPOINT)
-
-#define TTYS0  { 0xfe0003f8, 4 }
-#define TTYS1  { 0xfe0002f8, 3 }
-#else
-#error "UART configuration is undefined for this PowerPC platform"
-#endif
-
-#endif /* !_XENO_ASM_PPC_UART_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc64/atomic.h xenomai-devel/include/nucleus/asm-ppc64/atomic.h
--- xenomai-orig/include/nucleus/asm-ppc64/atomic.h	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/atomic.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,158 +0,0 @@
-/*
- * Xenomai 64-bit PowerPC adoption
- * Copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
- * based on previous work:
- *     
- * Copyright (C) 2003,2004 Philippe Gerum <rpm@xenomai.org>.
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
-
-#ifndef _XENO_ASM_PPC64_ATOMIC_H
-#define _XENO_ASM_PPC64_ATOMIC_H
-
-#include <asm/atomic.h>
-
-static __inline__ void atomic_set_mask(unsigned long mask,
-				       unsigned long *ptr)
-{
-    __asm__ __volatile__ ("\n\
-1:	ldarx	5,0,%0 \n\
-	or	5,5,%1\n"
-"	stdcx.	5,0,%0 \n\
-	bne-	1b"
-	: /*no output*/
-	: "r" (ptr), "r" (mask)
-	: "r5", "cc", "memory");
-}
-
-static __inline__ void atomic_clear_mask(unsigned long mask,
-					 unsigned long *ptr)
-{
-    __asm__ __volatile__ ("\n\
-1:	ldarx	5,0,%0 \n\
-	andc	5,5,%1\n"
-"	stdcx.	5,0,%0 \n\
-	bne-	1b"
-	: /*no output*/
-	: "r" (ptr), "r" (mask)
-	: "r5", "cc", "memory");
-}
-
-#ifdef __KERNEL__
-
-#include <linux/bitops.h>
-#include <asm/system.h>
-
-#define atomic_xchg(ptr,v)       xchg(ptr,v)
-#define atomic_cmpxchg(ptr,o,n)  cmpxchg(ptr,o,n)
-#define xnarch_memory_barrier()  smp_mb()
-
-void atomic_set_mask(unsigned long mask, /* from arch/ppc/kernel/misc.S */
-		     unsigned long *ptr);
-
-#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
-#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
-#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
-#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
-#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
-#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
-
-#else /* !__KERNEL__ */
-
-#include <linux/config.h>
-
-/* from asm-ppc64/memory.h */
-/*
- * Arguably the bitops and *xchg operations don't imply any memory barrier
- * or SMP ordering, but in fact a lot of drivers expect them to imply
- * both, since they do on x86 cpus.
- */
-#ifdef CONFIG_SMP
-#define EIEIO_ON_SMP	"eieio\n"
-#define ISYNC_ON_SMP	"\n\tisync"
-#else
-#define EIEIO_ON_SMP
-#define ISYNC_ON_SMP
-#endif
-
-/*
- * from <linux/asm-ppc64/system.h> and <linux/asm-ppc64/atomic.h>
- */
-
-static __inline__ unsigned long
-atomic_cmpxchg(volatile unsigned long *p, unsigned long old, unsigned long new)
-{
-	unsigned long prev;
-
-	__asm__ __volatile__ (
-	EIEIO_ON_SMP
-"1:	ldarx	%0,0,%2		# __cmpxchg_u64\n\
-	cmpd	0,%0,%3\n\
-	bne-	2f\n\
-	stdcx.	%4,0,%2\n\
-	bne-	1b"
-	ISYNC_ON_SMP
-	"\n\
-2:"
-	: "=&r" (prev), "=m" (*p)
-	: "r" (p), "r" (old), "r" (new), "m" (*p)
-	: "cc", "memory");
-
-	return prev;
-}
-
-static __inline__ unsigned long
-atomic_xchg(volatile unsigned long *m, unsigned long val)
-{
-	unsigned long dummy;
-
-	__asm__ __volatile__(
-	EIEIO_ON_SMP
-"1:	ldarx %0,0,%3		# __xchg_u64\n\
-	stdcx. %2,0,%3\n\
-2:	bne- 1b"
-	ISYNC_ON_SMP
-	: "=&r" (dummy), "=m" (*m)
-	: "r" (val), "r" (m)
-	: "cc", "memory");
-
-	return (dummy);
-}
-
-#define xnarch_memory_barrier() __asm__ __volatile__ ("sync" : : : "memory")
-
-#define xnarch_atomic_set(pcounter,i)          (((pcounter)->counter) = (i))
-#define xnarch_atomic_get(pcounter)            ((pcounter)->counter)
-#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
-#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
-#define xnarch_atomic_inc_and_test(pcounter)   (atomic_inc_return(pcounter) == 0)
-#define xnarch_atomic_dec_and_test(pcounter)   (atomic_dec_return(pcounter) == 0)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
-
-#define cpu_relax()  xnarch_memory_barrier()
-
-#endif /* __KERNEL__ */
-
-typedef atomic_t atomic_counter_t;
-typedef unsigned long atomic_flags_t;
-
-#define xnarch_atomic_xchg(ptr,x) atomic_xchg(ptr,x)
-
-#endif /* !_XENO_ASM_PPC64_ATOMIC_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc64/calibration.h xenomai-devel/include/nucleus/asm-ppc64/calibration.h
--- xenomai-orig/include/nucleus/asm-ppc64/calibration.h	2005-10-17 11:02:39.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/calibration.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,45 +0,0 @@
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
-
-#ifndef _XENO_ASM_PPC_CALIBRATION_H
-#define _XENO_ASM_PPC_CALIBRATION_H
-
-#include <xeno_config.h>
-#include <asm/delay.h>
-
-#define __bogomips (loops_per_jiffy/(500000/HZ))
-
-static inline unsigned long xnarch_get_sched_latency (void)
-
-{
-#if CONFIG_XENO_HW_SCHED_LATENCY != 0
-#define __sched_latency CONFIG_XENO_HW_SCHED_LATENCY
-#else
-
-#define __sched_latency 1000
-
-#endif /* CONFIG_XENO_HW_SCHED_LATENCY */
-
-    return __sched_latency;
-}
-
-#undef __sched_latency
-#undef __bogomips
-
-#endif /* !_XENO_ASM_PPC_CALIBRATION_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc64/GNUmakefile.am xenomai-devel/include/nucleus/asm-ppc64/GNUmakefile.am
--- xenomai-orig/include/nucleus/asm-ppc64/GNUmakefile.am	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/GNUmakefile.am	1970-01-01 02:00:00.000000000 +0200
@@ -1,16 +0,0 @@
-includedir = $(prefix)/include/nucleus/asm-ppc64
-
-include_HEADERS = \
-		atomic.h \
-		calibration.h \
-		hal.h \
-		system.h \
-		syscall.h
-
-install-data-local:
-	$(mkinstalldirs) $(DESTDIR)$(includedir)
-	rm -f $(DESTDIR)$(includedir)/../asm
-	$(LN_S) asm-ppc64 $(DESTDIR)$(includedir)/../asm
-
-uninstall-local:
-	$(RM) $(DESTDIR)$(includedir)/../asm
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc64/GNUmakefile.in xenomai-devel/include/nucleus/asm-ppc64/GNUmakefile.in
--- xenomai-orig/include/nucleus/asm-ppc64/GNUmakefile.in	2005-10-23 10:59:55.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/GNUmakefile.in	1970-01-01 02:00:00.000000000 +0200
@@ -1,550 +0,0 @@
-# GNUmakefile.in generated by automake 1.9.5 from GNUmakefile.am.
-# @configure_input@
-
-# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
-# 2003, 2004, 2005  Free Software Foundation, Inc.
-# This Makefile.in is free software; the Free Software Foundation
-# gives unlimited permission to copy and/or distribute it,
-# with or without modifications, as long as this notice is preserved.
-
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
-# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
-# PARTICULAR PURPOSE.
-
-@domain.hid@
-
-srcdir = @srcdir@
-top_srcdir = @top_srcdir@
-VPATH = @srcdir@
-pkgdatadir = $(datadir)/@PACKAGE@
-pkglibdir = $(libdir)/@PACKAGE@
-pkgincludedir = $(includedir)/@PACKAGE@
-top_builddir = ../../..
-am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
-INSTALL = @INSTALL@
-install_sh_DATA = $(install_sh) -c -m 644
-install_sh_PROGRAM = $(install_sh) -c
-install_sh_SCRIPT = $(install_sh) -c
-INSTALL_HEADER = $(INSTALL_DATA)
-transform = $(program_transform_name)
-NORMAL_INSTALL = :
-PRE_INSTALL = :
-POST_INSTALL = :
-NORMAL_UNINSTALL = :
-PRE_UNINSTALL = :
-POST_UNINSTALL = :
-build_triplet = @build@
-host_triplet = @host@
-target_triplet = @target@
-subdir = include/nucleus/asm-ppc64
-DIST_COMMON = $(include_HEADERS) $(srcdir)/GNUmakefile.am \
-	$(srcdir)/GNUmakefile.in
-ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
-am__aclocal_m4_deps =  \
-	$(top_srcdir)/config/autoconf/ac_prog_cc_for_build.m4 \
-	$(top_srcdir)/config/autoconf/docbook.m4 \
-	$(top_srcdir)/config/version $(top_srcdir)/configure.in
-am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
-	$(ACLOCAL_M4)
-mkinstalldirs = $(install_sh) -d
-CONFIG_HEADER = $(top_builddir)/include/xeno_config.h
-CONFIG_CLEAN_FILES =
-SOURCES =
-DIST_SOURCES =
-am__vpath_adj_setup = srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`;
-am__vpath_adj = case $$p in \
-    $(srcdir)/*) f=`echo "$$p" | sed "s|^$$srcdirstrip/||"`;; \
-    *) f=$$p;; \
-  esac;
-am__strip_dir = `echo $$p | sed -e 's|^.*/||'`;
-am__installdirs = "$(DESTDIR)$(includedir)"
-includeHEADERS_INSTALL = $(INSTALL_HEADER)
-HEADERS = $(include_HEADERS)
-ETAGS = etags
-CTAGS = ctags
-DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
-ACLOCAL = @ACLOCAL@
-AMDEP_FALSE = @AMDEP_FALSE@
-AMDEP_TRUE = @AMDEP_TRUE@
-AMTAR = @AMTAR@
-AR = @AR@
-AUTOCONF = @AUTOCONF@
-AUTOHEADER = @AUTOHEADER@
-AUTOMAKE = @AUTOMAKE@
-AWK = @AWK@
-BUILD_EXEEXT = @BUILD_EXEEXT@
-BUILD_OBJEXT = @BUILD_OBJEXT@
-CC = @CC@
-CCAS = @CCAS@
-CCASFLAGS = @CCASFLAGS@
-CCDEPMODE = @CCDEPMODE@
-CC_FOR_BUILD = @CC_FOR_BUILD@
-CFLAGS = @CFLAGS@
-CFLAGS_FOR_BUILD = @CFLAGS_FOR_BUILD@
-CONFIG_IA64_FALSE = @CONFIG_IA64_FALSE@
-CONFIG_IA64_TRUE = @CONFIG_IA64_TRUE@
-CONFIG_LTT_FALSE = @CONFIG_LTT_FALSE@
-CONFIG_LTT_TRUE = @CONFIG_LTT_TRUE@
-CONFIG_PPC64_FALSE = @CONFIG_PPC64_FALSE@
-CONFIG_PPC64_TRUE = @CONFIG_PPC64_TRUE@
-CONFIG_PPC_FALSE = @CONFIG_PPC_FALSE@
-CONFIG_PPC_TRUE = @CONFIG_PPC_TRUE@
-CONFIG_SMP_FALSE = @CONFIG_SMP_FALSE@
-CONFIG_SMP_TRUE = @CONFIG_SMP_TRUE@
-CONFIG_X86_FALSE = @CONFIG_X86_FALSE@
-CONFIG_X86_LOCAL_APIC_FALSE = @CONFIG_X86_LOCAL_APIC_FALSE@
-CONFIG_X86_LOCAL_APIC_TRUE = @CONFIG_X86_LOCAL_APIC_TRUE@
-CONFIG_X86_TRUE = @CONFIG_X86_TRUE@
-CONFIG_XENO_DOC_DOX_FALSE = @CONFIG_XENO_DOC_DOX_FALSE@
-CONFIG_XENO_DOC_DOX_TRUE = @CONFIG_XENO_DOC_DOX_TRUE@
-CONFIG_XENO_DRIVERS_16550A_FALSE = @CONFIG_XENO_DRIVERS_16550A_FALSE@
-CONFIG_XENO_DRIVERS_16550A_TRUE = @CONFIG_XENO_DRIVERS_16550A_TRUE@
-CONFIG_XENO_HW_FPU_FALSE = @CONFIG_XENO_HW_FPU_FALSE@
-CONFIG_XENO_HW_FPU_TRUE = @CONFIG_XENO_HW_FPU_TRUE@
-CONFIG_XENO_HW_NMI_DEBUG_LATENCY_FALSE = @CONFIG_XENO_HW_NMI_DEBUG_LATENCY_FALSE@
-CONFIG_XENO_HW_NMI_DEBUG_LATENCY_TRUE = @CONFIG_XENO_HW_NMI_DEBUG_LATENCY_TRUE@
-CONFIG_XENO_HW_SMI_DETECT_FALSE = @CONFIG_XENO_HW_SMI_DETECT_FALSE@
-CONFIG_XENO_HW_SMI_DETECT_TRUE = @CONFIG_XENO_HW_SMI_DETECT_TRUE@
-CONFIG_XENO_MAINT_FALSE = @CONFIG_XENO_MAINT_FALSE@
-CONFIG_XENO_MAINT_GCH_FALSE = @CONFIG_XENO_MAINT_GCH_FALSE@
-CONFIG_XENO_MAINT_GCH_TRUE = @CONFIG_XENO_MAINT_GCH_TRUE@
-CONFIG_XENO_MAINT_PGM_FALSE = @CONFIG_XENO_MAINT_PGM_FALSE@
-CONFIG_XENO_MAINT_PGM_TRUE = @CONFIG_XENO_MAINT_PGM_TRUE@
-CONFIG_XENO_MAINT_TRUE = @CONFIG_XENO_MAINT_TRUE@
-CONFIG_XENO_OLD_FASHIONED_BUILD_FALSE = @CONFIG_XENO_OLD_FASHIONED_BUILD_FALSE@
-CONFIG_XENO_OLD_FASHIONED_BUILD_TRUE = @CONFIG_XENO_OLD_FASHIONED_BUILD_TRUE@
-CONFIG_XENO_OPT_CONFIG_GZ_FALSE = @CONFIG_XENO_OPT_CONFIG_GZ_FALSE@
-CONFIG_XENO_OPT_CONFIG_GZ_TRUE = @CONFIG_XENO_OPT_CONFIG_GZ_TRUE@
-CONFIG_XENO_OPT_NATIVE_ALARM_FALSE = @CONFIG_XENO_OPT_NATIVE_ALARM_FALSE@
-CONFIG_XENO_OPT_NATIVE_ALARM_TRUE = @CONFIG_XENO_OPT_NATIVE_ALARM_TRUE@
-CONFIG_XENO_OPT_NATIVE_COND_FALSE = @CONFIG_XENO_OPT_NATIVE_COND_FALSE@
-CONFIG_XENO_OPT_NATIVE_COND_TRUE = @CONFIG_XENO_OPT_NATIVE_COND_TRUE@
-CONFIG_XENO_OPT_NATIVE_EVENT_FALSE = @CONFIG_XENO_OPT_NATIVE_EVENT_FALSE@
-CONFIG_XENO_OPT_NATIVE_EVENT_TRUE = @CONFIG_XENO_OPT_NATIVE_EVENT_TRUE@
-CONFIG_XENO_OPT_NATIVE_HEAP_FALSE = @CONFIG_XENO_OPT_NATIVE_HEAP_FALSE@
-CONFIG_XENO_OPT_NATIVE_HEAP_TRUE = @CONFIG_XENO_OPT_NATIVE_HEAP_TRUE@
-CONFIG_XENO_OPT_NATIVE_INTR_FALSE = @CONFIG_XENO_OPT_NATIVE_INTR_FALSE@
-CONFIG_XENO_OPT_NATIVE_INTR_TRUE = @CONFIG_XENO_OPT_NATIVE_INTR_TRUE@
-CONFIG_XENO_OPT_NATIVE_MUTEX_FALSE = @CONFIG_XENO_OPT_NATIVE_MUTEX_FALSE@
-CONFIG_XENO_OPT_NATIVE_MUTEX_TRUE = @CONFIG_XENO_OPT_NATIVE_MUTEX_TRUE@
-CONFIG_XENO_OPT_NATIVE_PIPE_FALSE = @CONFIG_XENO_OPT_NATIVE_PIPE_FALSE@
-CONFIG_XENO_OPT_NATIVE_PIPE_TRUE = @CONFIG_XENO_OPT_NATIVE_PIPE_TRUE@
-CONFIG_XENO_OPT_NATIVE_QUEUE_FALSE = @CONFIG_XENO_OPT_NATIVE_QUEUE_FALSE@
-CONFIG_XENO_OPT_NATIVE_QUEUE_TRUE = @CONFIG_XENO_OPT_NATIVE_QUEUE_TRUE@
-CONFIG_XENO_OPT_NATIVE_REGISTRY_FALSE = @CONFIG_XENO_OPT_NATIVE_REGISTRY_FALSE@
-CONFIG_XENO_OPT_NATIVE_REGISTRY_TRUE = @CONFIG_XENO_OPT_NATIVE_REGISTRY_TRUE@
-CONFIG_XENO_OPT_NATIVE_SEM_FALSE = @CONFIG_XENO_OPT_NATIVE_SEM_FALSE@
-CONFIG_XENO_OPT_NATIVE_SEM_TRUE = @CONFIG_XENO_OPT_NATIVE_SEM_TRUE@
-CONFIG_XENO_OPT_PERVASIVE_FALSE = @CONFIG_XENO_OPT_PERVASIVE_FALSE@
-CONFIG_XENO_OPT_PERVASIVE_TRUE = @CONFIG_XENO_OPT_PERVASIVE_TRUE@
-CONFIG_XENO_OPT_PIPE_FALSE = @CONFIG_XENO_OPT_PIPE_FALSE@
-CONFIG_XENO_OPT_PIPE_TRUE = @CONFIG_XENO_OPT_PIPE_TRUE@
-CONFIG_XENO_OPT_RTAI_FIFO_FALSE = @CONFIG_XENO_OPT_RTAI_FIFO_FALSE@
-CONFIG_XENO_OPT_RTAI_FIFO_TRUE = @CONFIG_XENO_OPT_RTAI_FIFO_TRUE@
-CONFIG_XENO_OPT_RTAI_SEM_FALSE = @CONFIG_XENO_OPT_RTAI_SEM_FALSE@
-CONFIG_XENO_OPT_RTAI_SEM_TRUE = @CONFIG_XENO_OPT_RTAI_SEM_TRUE@
-CONFIG_XENO_OPT_RTAI_SHM_FALSE = @CONFIG_XENO_OPT_RTAI_SHM_FALSE@
-CONFIG_XENO_OPT_RTAI_SHM_TRUE = @CONFIG_XENO_OPT_RTAI_SHM_TRUE@
-CONFIG_XENO_OPT_UDEV_FALSE = @CONFIG_XENO_OPT_UDEV_FALSE@
-CONFIG_XENO_OPT_UDEV_TRUE = @CONFIG_XENO_OPT_UDEV_TRUE@
-CONFIG_XENO_OPT_UVM_FALSE = @CONFIG_XENO_OPT_UVM_FALSE@
-CONFIG_XENO_OPT_UVM_TRUE = @CONFIG_XENO_OPT_UVM_TRUE@
-CONFIG_XENO_SKIN_NATIVE_FALSE = @CONFIG_XENO_SKIN_NATIVE_FALSE@
-CONFIG_XENO_SKIN_NATIVE_TRUE = @CONFIG_XENO_SKIN_NATIVE_TRUE@
-CONFIG_XENO_SKIN_POSIX_FALSE = @CONFIG_XENO_SKIN_POSIX_FALSE@
-CONFIG_XENO_SKIN_POSIX_TRUE = @CONFIG_XENO_SKIN_POSIX_TRUE@
-CONFIG_XENO_SKIN_PSOS_FALSE = @CONFIG_XENO_SKIN_PSOS_FALSE@
-CONFIG_XENO_SKIN_PSOS_TRUE = @CONFIG_XENO_SKIN_PSOS_TRUE@
-CONFIG_XENO_SKIN_RTAI_FALSE = @CONFIG_XENO_SKIN_RTAI_FALSE@
-CONFIG_XENO_SKIN_RTAI_TRUE = @CONFIG_XENO_SKIN_RTAI_TRUE@
-CONFIG_XENO_SKIN_RTDM_FALSE = @CONFIG_XENO_SKIN_RTDM_FALSE@
-CONFIG_XENO_SKIN_RTDM_TRUE = @CONFIG_XENO_SKIN_RTDM_TRUE@
-CONFIG_XENO_SKIN_UITRON_FALSE = @CONFIG_XENO_SKIN_UITRON_FALSE@
-CONFIG_XENO_SKIN_UITRON_TRUE = @CONFIG_XENO_SKIN_UITRON_TRUE@
-CONFIG_XENO_SKIN_VRTX_FALSE = @CONFIG_XENO_SKIN_VRTX_FALSE@
-CONFIG_XENO_SKIN_VRTX_TRUE = @CONFIG_XENO_SKIN_VRTX_TRUE@
-CONFIG_XENO_SKIN_VXWORKS_FALSE = @CONFIG_XENO_SKIN_VXWORKS_FALSE@
-CONFIG_XENO_SKIN_VXWORKS_TRUE = @CONFIG_XENO_SKIN_VXWORKS_TRUE@
-CPP = @CPP@
-CPPFLAGS = @CPPFLAGS@
-CPPFLAGS_FOR_BUILD = @CPPFLAGS_FOR_BUILD@
-CPP_FOR_BUILD = @CPP_FOR_BUILD@
-CROSS_COMPILE = @CROSS_COMPILE@
-CXX = @CXX@
-CXXCPP = @CXXCPP@
-CXXDEPMODE = @CXXDEPMODE@
-CXXFLAGS = @CXXFLAGS@
-CYGPATH_W = @CYGPATH_W@
-DBX_ABS_SRCDIR_FALSE = @DBX_ABS_SRCDIR_FALSE@
-DBX_ABS_SRCDIR_TRUE = @DBX_ABS_SRCDIR_TRUE@
-DBX_DOC_FALSE = @DBX_DOC_FALSE@
-DBX_DOC_ROOT = @DBX_DOC_ROOT@
-DBX_DOC_TRUE = @DBX_DOC_TRUE@
-DBX_FOP = @DBX_FOP@
-DBX_GEN_DOC_ROOT = @DBX_GEN_DOC_ROOT@
-DBX_LINT = @DBX_LINT@
-DBX_MAYBE_NONET = @DBX_MAYBE_NONET@
-DBX_ROOT = @DBX_ROOT@
-DBX_XSLTPROC = @DBX_XSLTPROC@
-DBX_XSL_ROOT = @DBX_XSL_ROOT@
-DEFS = @DEFS@
-DEPDIR = @DEPDIR@
-DOXYGEN = @DOXYGEN@
-DOXYGEN_HAVE_DOT = @DOXYGEN_HAVE_DOT@
-DOXYGEN_SHOW_INCLUDE_FILES = @DOXYGEN_SHOW_INCLUDE_FILES@
-ECHO = @ECHO@
-ECHO_C = @ECHO_C@
-ECHO_N = @ECHO_N@
-ECHO_T = @ECHO_T@
-EGREP = @EGREP@
-EXEEXT = @EXEEXT@
-F77 = @F77@
-FFLAGS = @FFLAGS@
-INSTALL_DATA = @INSTALL_DATA@
-INSTALL_PROGRAM = @INSTALL_PROGRAM@
-INSTALL_SCRIPT = @INSTALL_SCRIPT@
-INSTALL_STRIP_PROGRAM = @INSTALL_STRIP_PROGRAM@
-LATEX_BATCHMODE = @LATEX_BATCHMODE@
-LATEX_MODE = @LATEX_MODE@
-LDFLAGS = @LDFLAGS@
-LEX = @LEX@
-LEXLIB = @LEXLIB@
-LEX_OUTPUT_ROOT = @LEX_OUTPUT_ROOT@
-LIBOBJS = @LIBOBJS@
-LIBS = @LIBS@
-LIBTOOL = @LIBTOOL@
-LN_S = @LN_S@
-LTLIBOBJS = @LTLIBOBJS@
-MAINT = @MAINT@
-MAINTAINER_MODE_FALSE = @MAINTAINER_MODE_FALSE@
-MAINTAINER_MODE_TRUE = @MAINTAINER_MODE_TRUE@
-MAKEINFO = @MAKEINFO@
-OBJEXT = @OBJEXT@
-PACKAGE = @PACKAGE@
-PACKAGE_BUGREPORT = @PACKAGE_BUGREPORT@
-PACKAGE_NAME = @PACKAGE_NAME@
-PACKAGE_STRING = @PACKAGE_STRING@
-PACKAGE_TARNAME = @PACKAGE_TARNAME@
-PACKAGE_VERSION = @PACKAGE_VERSION@
-PATH_SEPARATOR = @PATH_SEPARATOR@
-RANLIB = @RANLIB@
-SET_MAKE = @SET_MAKE@
-SHELL = @SHELL@
-STRIP = @STRIP@
-VERSION = @VERSION@
-XENO_BUILD_STRING = @XENO_BUILD_STRING@
-XENO_FP_CFLAGS = @XENO_FP_CFLAGS@
-XENO_HOST_STRING = @XENO_HOST_STRING@
-XENO_KBUILD_CLEAN = @XENO_KBUILD_CLEAN@
-XENO_KBUILD_CMD = @XENO_KBUILD_CMD@
-XENO_KBUILD_DISTCLEAN = @XENO_KBUILD_DISTCLEAN@
-XENO_KBUILD_ENV = @XENO_KBUILD_ENV@
-XENO_KMOD_APP_CFLAGS = @XENO_KMOD_APP_CFLAGS@
-XENO_KMOD_CFLAGS = @XENO_KMOD_CFLAGS@
-XENO_LINUX_DIR = @XENO_LINUX_DIR@
-XENO_LINUX_VERSION = @XENO_LINUX_VERSION@
-XENO_MAYBE_DOCDIR = @XENO_MAYBE_DOCDIR@
-XENO_MAYBE_SIMDIR = @XENO_MAYBE_SIMDIR@
-XENO_MODULE_DIR = @XENO_MODULE_DIR@
-XENO_MODULE_EXT = @XENO_MODULE_EXT@
-XENO_PIPE_NRDEV = @XENO_PIPE_NRDEV@
-XENO_SYMBOL_DIR = @XENO_SYMBOL_DIR@
-XENO_TARGET_ARCH = @XENO_TARGET_ARCH@
-XENO_TARGET_SUBARCH = @XENO_TARGET_SUBARCH@
-XENO_USER_APP_CFLAGS = @XENO_USER_APP_CFLAGS@
-XENO_USER_CFLAGS = @XENO_USER_CFLAGS@
-ac_ct_AR = @ac_ct_AR@
-ac_ct_CC = @ac_ct_CC@
-ac_ct_CC_FOR_BUILD = @ac_ct_CC_FOR_BUILD@
-ac_ct_CXX = @ac_ct_CXX@
-ac_ct_F77 = @ac_ct_F77@
-ac_ct_RANLIB = @ac_ct_RANLIB@
-ac_ct_STRIP = @ac_ct_STRIP@
-am__fastdepCC_FALSE = @am__fastdepCC_FALSE@
-am__fastdepCC_TRUE = @am__fastdepCC_TRUE@
-am__fastdepCXX_FALSE = @am__fastdepCXX_FALSE@
-am__fastdepCXX_TRUE = @am__fastdepCXX_TRUE@
-am__include = @am__include@
-am__leading_dot = @am__leading_dot@
-am__quote = @am__quote@
-am__tar = @am__tar@
-am__untar = @am__untar@
-bindir = @bindir@
-build = @build@
-build_alias = @build_alias@
-build_cpu = @build_cpu@
-build_os = @build_os@
-build_vendor = @build_vendor@
-datadir = @datadir@
-exec_prefix = @exec_prefix@
-host = @host@
-host_alias = @host_alias@
-host_cpu = @host_cpu@
-host_os = @host_os@
-host_vendor = @host_vendor@
-includedir = $(prefix)/include/nucleus/asm-ppc64
-infodir = @infodir@
-install_sh = @install_sh@
-libdir = @libdir@
-libexecdir = @libexecdir@
-localstatedir = @localstatedir@
-mandir = @mandir@
-mkdir_p = @mkdir_p@
-oldincludedir = @oldincludedir@
-prefix = @prefix@
-program_transform_name = @program_transform_name@
-sbindir = @sbindir@
-sharedstatedir = @sharedstatedir@
-subdirs = @subdirs@
-sysconfdir = @sysconfdir@
-target = @target@
-target_alias = @target_alias@
-target_cpu = @target_cpu@
-target_os = @target_os@
-target_vendor = @target_vendor@
-include_HEADERS = \
-		atomic.h \
-		calibration.h \
-		hal.h \
-		system.h \
-		syscall.h
-
-all: all-am
-
-.SUFFIXES:
-$(srcdir)/GNUmakefile.in: @MAINTAINER_MODE_TRUE@ $(srcdir)/GNUmakefile.am  $(am__configure_deps)
-	@for dep in $?; do \
-	  case '$(am__configure_deps)' in \
-	    *$$dep*) \
-	      cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh \
-		&& exit 0; \
-	      exit 1;; \
-	  esac; \
-	done; \
-	echo ' cd $(top_srcdir) && $(AUTOMAKE) --foreign  include/nucleus/asm-ppc64/GNUmakefile'; \
-	cd $(top_srcdir) && \
-	  $(AUTOMAKE) --foreign  include/nucleus/asm-ppc64/GNUmakefile
-.PRECIOUS: GNUmakefile
-GNUmakefile: $(srcdir)/GNUmakefile.in $(top_builddir)/config.status
-	@case '$?' in \
-	  *config.status*) \
-	    cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh;; \
-	  *) \
-	    echo ' cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__depfiles_maybe)'; \
-	    cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@ $(am__depfiles_maybe);; \
-	esac;
-
-$(top_builddir)/config.status: $(top_srcdir)/configure $(CONFIG_STATUS_DEPENDENCIES)
-	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
-
-$(top_srcdir)/configure: @MAINTAINER_MODE_TRUE@ $(am__configure_deps)
-	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
-$(ACLOCAL_M4): @MAINTAINER_MODE_TRUE@ $(am__aclocal_m4_deps)
-	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
-
-mostlyclean-libtool:
-	-rm -f *.lo
-
-clean-libtool:
-	-rm -rf .libs _libs
-
-distclean-libtool:
-	-rm -f libtool
-uninstall-info-am:
-install-includeHEADERS: $(include_HEADERS)
-	@$(NORMAL_INSTALL)
-	test -z "$(includedir)" || $(mkdir_p) "$(DESTDIR)$(includedir)"
-	@list='$(include_HEADERS)'; for p in $$list; do \
-	  if test -f "$$p"; then d=; else d="$(srcdir)/"; fi; \
-	  f=$(am__strip_dir) \
-	  echo " $(includeHEADERS_INSTALL) '$$d$$p' '$(DESTDIR)$(includedir)/$$f'"; \
-	  $(includeHEADERS_INSTALL) "$$d$$p" "$(DESTDIR)$(includedir)/$$f"; \
-	done
-
-uninstall-includeHEADERS:
-	@$(NORMAL_UNINSTALL)
-	@list='$(include_HEADERS)'; for p in $$list; do \
-	  f=$(am__strip_dir) \
-	  echo " rm -f '$(DESTDIR)$(includedir)/$$f'"; \
-	  rm -f "$(DESTDIR)$(includedir)/$$f"; \
-	done
-
-ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
-	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
-	unique=`for i in $$list; do \
-	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
-	  done | \
-	  $(AWK) '    { files[$$0] = 1; } \
-	       END { for (i in files) print i; }'`; \
-	mkid -fID $$unique
-tags: TAGS
-
-TAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
-		$(TAGS_FILES) $(LISP)
-	tags=; \
-	here=`pwd`; \
-	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
-	unique=`for i in $$list; do \
-	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
-	  done | \
-	  $(AWK) '    { files[$$0] = 1; } \
-	       END { for (i in files) print i; }'`; \
-	if test -z "$(ETAGS_ARGS)$$tags$$unique"; then :; else \
-	  test -n "$$unique" || unique=$$empty_fix; \
-	  $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
-	    $$tags $$unique; \
-	fi
-ctags: CTAGS
-CTAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
-		$(TAGS_FILES) $(LISP)
-	tags=; \
-	here=`pwd`; \
-	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
-	unique=`for i in $$list; do \
-	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
-	  done | \
-	  $(AWK) '    { files[$$0] = 1; } \
-	       END { for (i in files) print i; }'`; \
-	test -z "$(CTAGS_ARGS)$$tags$$unique" \
-	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
-	     $$tags $$unique
-
-GTAGS:
-	here=`$(am__cd) $(top_builddir) && pwd` \
-	  && cd $(top_srcdir) \
-	  && gtags -i $(GTAGS_ARGS) $$here
-
-distclean-tags:
-	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
-
-distdir: $(DISTFILES)
-	@srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`; \
-	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's|.|.|g'`; \
-	list='$(DISTFILES)'; for file in $$list; do \
-	  case $$file in \
-	    $(srcdir)/*) file=`echo "$$file" | sed "s|^$$srcdirstrip/||"`;; \
-	    $(top_srcdir)/*) file=`echo "$$file" | sed "s|^$$topsrcdirstrip/|$(top_builddir)/|"`;; \
-	  esac; \
-	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
-	  dir=`echo "$$file" | sed -e 's,/[^/]*$$,,'`; \
-	  if test "$$dir" != "$$file" && test "$$dir" != "."; then \
-	    dir="/$$dir"; \
-	    $(mkdir_p) "$(distdir)$$dir"; \
-	  else \
-	    dir=''; \
-	  fi; \
-	  if test -d $$d/$$file; then \
-	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
-	      cp -pR $(srcdir)/$$file $(distdir)$$dir || exit 1; \
-	    fi; \
-	    cp -pR $$d/$$file $(distdir)$$dir || exit 1; \
-	  else \
-	    test -f $(distdir)/$$file \
-	    || cp -p $$d/$$file $(distdir)/$$file \
-	    || exit 1; \
-	  fi; \
-	done
-check-am: all-am
-check: check-am
-all-am: GNUmakefile $(HEADERS)
-installdirs:
-	for dir in "$(DESTDIR)$(includedir)"; do \
-	  test -z "$$dir" || $(mkdir_p) "$$dir"; \
-	done
-install: install-am
-install-exec: install-exec-am
-install-data: install-data-am
-uninstall: uninstall-am
-
-install-am: all-am
-	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am
-
-installcheck: installcheck-am
-install-strip:
-	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
-	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
-	  `test -z '$(STRIP)' || \
-	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
-mostlyclean-generic:
-
-clean-generic:
-
-distclean-generic:
-	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
-
-maintainer-clean-generic:
-	@echo "This command is intended for maintainers to use"
-	@echo "it deletes files that may require special tools to rebuild."
-clean: clean-am
-
-clean-am: clean-generic clean-libtool mostlyclean-am
-
-distclean: distclean-am
-	-rm -f GNUmakefile
-distclean-am: clean-am distclean-generic distclean-libtool \
-	distclean-tags
-
-dvi: dvi-am
-
-dvi-am:
-
-html: html-am
-
-info: info-am
-
-info-am:
-
-install-data-am: install-data-local install-includeHEADERS
-
-install-exec-am:
-
-install-info: install-info-am
-
-install-man:
-
-installcheck-am:
-
-maintainer-clean: maintainer-clean-am
-	-rm -f GNUmakefile
-maintainer-clean-am: distclean-am maintainer-clean-generic
-
-mostlyclean: mostlyclean-am
-
-mostlyclean-am: mostlyclean-generic mostlyclean-libtool
-
-pdf: pdf-am
-
-pdf-am:
-
-ps: ps-am
-
-ps-am:
-
-uninstall-am: uninstall-includeHEADERS uninstall-info-am \
-	uninstall-local
-
-.PHONY: CTAGS GTAGS all all-am check check-am clean clean-generic \
-	clean-libtool ctags distclean distclean-generic \
-	distclean-libtool distclean-tags distdir dvi dvi-am html \
-	html-am info info-am install install-am install-data \
-	install-data-am install-data-local install-exec \
-	install-exec-am install-includeHEADERS install-info \
-	install-info-am install-man install-strip installcheck \
-	installcheck-am installdirs maintainer-clean \
-	maintainer-clean-generic mostlyclean mostlyclean-generic \
-	mostlyclean-libtool pdf pdf-am ps ps-am tags uninstall \
-	uninstall-am uninstall-includeHEADERS uninstall-info-am \
-	uninstall-local
-
-
-install-data-local:
-	$(mkinstalldirs) $(DESTDIR)$(includedir)
-	rm -f $(DESTDIR)$(includedir)/../asm
-	$(LN_S) asm-ppc64 $(DESTDIR)$(includedir)/../asm
-
-uninstall-local:
-	$(RM) $(DESTDIR)$(includedir)/../asm
-# Tell versions [3.59,3.63) of GNU make to not export all variables.
-# Otherwise a system limit (for SysV at least) may be exceeded.
-.NOEXPORT:
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc64/hal.h xenomai-devel/include/nucleus/asm-ppc64/hal.h
--- xenomai-orig/include/nucleus/asm-ppc64/hal.h	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/hal.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,230 +0,0 @@
-/**
- *   @ingroup hal
- *   @file
- *
- *   Real-Time Hardware Abstraction Layer for 64-bit PowerPC.
- *
- *   Xenomai 64-bit PowerPC adoption
- *   Copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
- *   based on previous work:
- *      
- *   Copyright &copy; 2002-2004 Philippe Gerum.
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
-
-/**
- * @addtogroup hal
- *@{*/
-
-#ifndef _XENO_ASM_PPC64_HAL_H
-#define _XENO_ASM_PPC64_HAL_H
-
-#include <nucleus/asm-generic/hal.h>	/* Read the generic bits. */
-#include <asm/div64.h>
-
-typedef unsigned long rthal_time_t;
-
-static inline unsigned long long rthal_ullmul(const unsigned long m0, 
-					      const unsigned long m1)
-{
-    return (unsigned long long) m0 * m1;
-}
-
-static inline unsigned long long rthal_ulldiv (unsigned long long ull,
-					       const unsigned long uld,
-					       unsigned long *const rp)
-{
-    const unsigned long r = ull % uld;
-    ull /= uld;
-
-    if (rp)
-	*rp = r;
-
-    return ull;
-}
-
-#define rthal_uldivrem(ull,ul,rp) ((u_long) rthal_ulldiv((ull),(ul),(rp)))
-
-static inline int rthal_imuldiv (int i, int mult, int div) {
-
-    /* Returns (int)i = (unsigned long long)i*(u_long)(mult)/(u_long)div. */
-    const unsigned long long ull = rthal_ullmul(i, mult);
-    return rthal_uldivrem(ull, div, NULL);
-}
-
-static inline __attribute_const__
-unsigned long long __rthal_ullimd (const unsigned long long op,
-                                   const unsigned long m,
-                                   const unsigned long d)
-{
-	return (op*m)/d;
-}
-
-static inline long long rthal_llimd (long long op,
-                                     unsigned long m,
-                                     unsigned long d)
-{
-
-    if(op < 0LL)
-        return -__rthal_ullimd(-op, m, d);
-    return __rthal_ullimd(op, m, d);
-}
-
-static inline  __attribute_const__ unsigned long ffnz (unsigned long ul) {
-
-    __asm__ ("cntlzd %0, %1" : "=r" (ul) : "r" (ul & (-ul)));
-    return 63 - ul;
-}
-
-#if defined(__KERNEL__) && !defined(__cplusplus)
-#include <asm/system.h>
-#include <asm/time.h>
-#include <asm/timex.h>
-#include <nucleus/asm/atomic.h>
-#include <asm/processor.h>
-
-#define RTHAL_TIMER_IRQ   ADEOS_TIMER_VIRQ
-
-#define rthal_irq_descp(irq)	(&irq_desc[(irq)])
-
-static inline unsigned long long rthal_rdtsc (void) {
-    unsigned long long t;
-    rthal_read_tsc(t);
-    return t;
-}
-
-#if defined(CONFIG_ADEOS_CORE) && !defined(CONFIG_ADEOS_NOTHREADS)
-
-/* Since real-time interrupt handlers are called on behalf of the
-   Xenomai domain stack, we cannot infere the "current" Linux task
-   address using %esp. We must use the suspended Linux domain's stack
-   pointer instead. */
-
-static inline struct task_struct *rthal_root_host_task (int cpuid) {
-    return ((struct thread_info *)(rthal_root_domain->esp[cpuid] & (~(16384-1)UL)))->task;
-}
-
-static inline struct task_struct *rthal_current_host_task (int cpuid)
-
-{
-    register unsigned long esp asm ("r1");
-    
-    if (esp >= rthal_domain.estackbase[cpuid] && esp < rthal_domain.estackbase[cpuid] + 16384)
-	return rthal_root_host_task(cpuid);
-
-    return current;
-}
-
-#else /* !CONFIG_ADEOS_CORE || CONFIG_ADEOS_NOTHREADS */
-
-static inline struct task_struct *rthal_root_host_task (int cpuid) {
-    return current;
-}
-
-static inline struct task_struct *rthal_current_host_task (int cpuid) {
-    return current;
-}
-
-#endif /* CONFIG_ADEOS_CORE && !CONFIG_ADEOS_NOTHREADS */
-
-static inline void rthal_timer_program_shot (unsigned long delay)
-{
-    if(!delay) delay = 1;
-    set_dec(delay);
-}
-
-    /* Private interface -- Internal use only */
-
-/* The following must be kept in sync w/ rthal_switch_context() in
-   switch.S */
-#define RTHAL_SWITCH_FRAME_SIZE  224
-
-void rthal_switch_context(unsigned long *out_kspp,
-			  unsigned long *in_kspp);
-
-#ifdef CONFIG_XENO_HW_FPU
-
-typedef struct rthal_fpenv {
-    
-    /* This layout must follow exactely the definition of the FPU
-       backup area in a PPC thread struct available from
-       <asm-ppc/processor.h>. Specifically, fpr[] an fpscr words must
-       be contiguous in memory (see arch/ppc/hal/fpu.S). */
-
-    double fpr[32];
-    unsigned long fpscr;       /* mffs uses 64-bit (pad in hi/fpscr in lo) */
-} rthal_fpenv_t;
-
-void rthal_init_fpu(rthal_fpenv_t *fpuenv);
-
-void rthal_save_fpu(rthal_fpenv_t *fpuenv);
-
-void rthal_restore_fpu(rthal_fpenv_t *fpuenv);
-
-#ifndef CONFIG_SMP
-#define rthal_get_fpu_owner(cur) last_task_used_math
-#else /* CONFIG_SMP */
-#define rthal_get_fpu_owner(cur) ({                             \
-    struct task_struct * _cur = (cur);                          \
-    ((_cur->thread.regs && (_cur->thread.regs->msr & MSR_FP))   \
-     ? _cur : NULL);                                            \
-})
-#endif /* CONFIG_SMP */
-    
-#define rthal_disable_fpu() ({                          \
-    register unsigned long _msr;                                 \
-    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
-    __asm__ __volatile__ ( "mtmsrd %0"                   \
-                           : /* no output */            \
-                           : "r"(_msr & ~(MSR_FP))      \
-                           : "memory" );                \
-})
-
-#define rthal_enable_fpu() ({                           \
-    register unsigned long _msr;                                 \
-    __asm__ __volatile__ ( "mfmsr %0" : "=r"(_msr) );   \
-    __asm__ __volatile__ ( "mtmsrd %0"                   \
-                           : /* no output */            \
-                           : "r"(_msr | MSR_FP)         \
-                           : "memory" );                \
-})
-
-#endif /* CONFIG_XENO_HW_FPU */
-
-static const char *const rthal_fault_labels[] = {
-    [0] =  "Data or instruction access",
-    [1] =  "Alignment",
-    [2] =  "AltiVec unavailable",
-    [3] =  "Program check exception",
-    [4] =  "Machine check exception",
-    [5] =  "Unknown",
-    [6] =  "Instruction breakpoint",
-    [7] =  "Single-step exception",
-    [8] =  "Non-recoverable exception",
-    [9] =  "AltiVec assist",
-    [10] = "System reset exception",
-    [11] = "Kernel FP unavailable",
-    [12] = "Performance monitor",
-    [13] = NULL
-};
-
-#endif /* __KERNEL__ && !__cplusplus */
-
-/*@}*/
-
-#endif /* !_XENO_ASM_PPC64_HAL_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc64/syscall.h xenomai-devel/include/nucleus/asm-ppc64/syscall.h
--- xenomai-orig/include/nucleus/asm-ppc64/syscall.h	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/syscall.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,175 +0,0 @@
-/*
- * Xenomai 64-bit PowerPC adoption
- * Copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
- * based on previous work:
- *     
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
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
-
-#ifndef _XENO_ASM_PPC64_SYSCALL_H
-#define _XENO_ASM_PPC64_SYSCALL_H
-
-#include <xeno_config.h>
-#include <asm/ptrace.h>
-#include <nucleus/asm-generic/syscall.h>
-
-/*
- * Some of the following macros have been adapted from Linux's
- * implementation of the syscall mechanism in <asm-ppc64/unistd.h>:
- *
- * The following code defines an inline syscall mechanism used by
- * Xenomai's real-time interfaces to invoke the skin module
- * services in kernel space.
- */
-
-#define XENOMAI_DO_SYSCALL(nr, id, op, args...)			\
-  ({								\
-	register unsigned long __sc_0  __asm__ ("r0");		\
-	register unsigned long __sc_3  __asm__ ("r3");		\
-	register unsigned long __sc_4  __asm__ ("r4");		\
-	register unsigned long __sc_5  __asm__ ("r5");		\
-	register unsigned long __sc_6  __asm__ ("r6");		\
-	register unsigned long __sc_7  __asm__ ("r7");		\
-								\
-	LOADARGS_##nr(__xn_mux_code(id,op), args);		\
-	__asm__ __volatile__					\
-		("sc           \n\t"				\
-		 "mfcr %0      "				\
-		: "=&r" (__sc_0),				\
-		  "=&r" (__sc_3),  "=&r" (__sc_4),		\
-		  "=&r" (__sc_5),  "=&r" (__sc_6),		\
-		  "=&r" (__sc_7)				\
-		: ASM_INPUT_##nr				\
-		: "cr0", "ctr", "memory",			\
-		  "r8", "r9", "r10","r11", "r12");		\
-	(int)((__sc_0 & (1 << 28)) ? -__sc_3 : __sc_3);		\
-  })
-
-#define LOADARGS_0(muxcode, dummy...)				\
-	__sc_0 = muxcode
-#define LOADARGS_1(muxcode, arg1)				\
-	LOADARGS_0(muxcode);					\
-	__sc_3 = (unsigned long) (arg1)
-#define LOADARGS_2(muxcode, arg1, arg2)				\
-	LOADARGS_1(muxcode, arg1);				\
-	__sc_4 = (unsigned long) (arg2)
-#define LOADARGS_3(muxcode, arg1, arg2, arg3)			\
-	LOADARGS_2(muxcode, arg1, arg2);			\
-	__sc_5 = (unsigned long) (arg3)
-#define LOADARGS_4(muxcode, arg1, arg2, arg3, arg4)		\
-	LOADARGS_3(muxcode, arg1, arg2, arg3);			\
-	__sc_6 = (unsigned long) (arg4)
-#define LOADARGS_5(muxcode, arg1, arg2, arg3, arg4, arg5)	\
-	LOADARGS_4(muxcode, arg1, arg2, arg3, arg4);		\
-	__sc_7 = (unsigned long) (arg5)
-
-#define ASM_INPUT_0 "0" (__sc_0)
-#define ASM_INPUT_1 ASM_INPUT_0, "1" (__sc_3)
-#define ASM_INPUT_2 ASM_INPUT_1, "2" (__sc_4)
-#define ASM_INPUT_3 ASM_INPUT_2, "3" (__sc_5)
-#define ASM_INPUT_4 ASM_INPUT_3, "4" (__sc_6)
-#define ASM_INPUT_5 ASM_INPUT_4, "5" (__sc_7)
-
-/* Register mapping for accessing syscall args. */
-
-#define __xn_reg_mux(regs)    ((regs)->gpr[0])
-#define __xn_reg_rval(regs)   ((regs)->gpr[3])
-#define __xn_reg_arg1(regs)   ((regs)->gpr[3])
-#define __xn_reg_arg2(regs)   ((regs)->gpr[4])
-#define __xn_reg_arg3(regs)   ((regs)->gpr[5])
-#define __xn_reg_arg4(regs)   ((regs)->gpr[6])
-#define __xn_reg_arg5(regs)   ((regs)->gpr[7])
-
-#define __xn_reg_mux_p(regs)        ((__xn_reg_mux(regs) & 0xffff) == __xn_sys_mux)
-#define __xn_mux_id(regs)           ((__xn_reg_mux(regs) >> 16) & 0xff)
-#define __xn_mux_op(regs)           ((__xn_reg_mux(regs) >> 24) & 0xff)
-#define __xn_mux_code(id,op)        ((op << 24)|((id << 16) & 0xff0000)|(__xn_sys_mux & 0xffff))
-
-#define XENOMAI_SYSCALL0(op)                XENOMAI_DO_SYSCALL(0,0,op)
-#define XENOMAI_SYSCALL1(op,a1)             XENOMAI_DO_SYSCALL(1,0,op,a1)
-#define XENOMAI_SYSCALL2(op,a1,a2)          XENOMAI_DO_SYSCALL(2,0,op,a1,a2)
-#define XENOMAI_SYSCALL3(op,a1,a2,a3)       XENOMAI_DO_SYSCALL(3,0,op,a1,a2,a3)
-#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)    XENOMAI_DO_SYSCALL(4,0,op,a1,a2,a3,a4)
-#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,0,op,a1,a2,a3,a4,a5)
-
-#define XENOMAI_SKINCALL0(id,op)                XENOMAI_DO_SYSCALL(0,id,op)
-#define XENOMAI_SKINCALL1(id,op,a1)             XENOMAI_DO_SYSCALL(1,id,op,a1)
-#define XENOMAI_SKINCALL2(id,op,a1,a2)          XENOMAI_DO_SYSCALL(2,id,op,a1,a2)
-#define XENOMAI_SKINCALL3(id,op,a1,a2,a3)       XENOMAI_DO_SYSCALL(3,id,op,a1,a2,a3)
-#define XENOMAI_SKINCALL4(id,op,a1,a2,a3,a4)    XENOMAI_DO_SYSCALL(4,id,op,a1,a2,a3,a4)
-#define XENOMAI_SKINCALL5(id,op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,id,op,a1,a2,a3,a4,a5)
-
-#ifdef __KERNEL__
-
-#include <linux/errno.h>
-#include <asm/uaccess.h>
-
-/* Our own set of copy-to/from-user macros which must bypass
-   might_sleep() checks. The caller cannot fault and is expected to
-   have checked for bad range before using the copy macros, so we
-   should not have to care about the result. */
-#define __xn_copy_from_user(task,dstP,srcP,n)  \
-    ({ int err = __copy_from_user_inatomic(dstP,srcP,n); err; })
-#define __xn_copy_to_user(task,dstP,srcP,n)  \
-    ({ int err = __copy_to_user_inatomic(dstP,srcP,n); err; })
-#define __xn_put_user(task,src,dstP)           __put_user(src,dstP)
-#define __xn_get_user(task,dst,srcP)           __get_user(dst,srcP)
-#define __xn_strncpy_from_user(task,dstP,srcP,n)    __strncpy_from_user(dstP,srcP,n)
-
-#define __xn_range_ok(task,addr,size) \
-	__access_ok(((__force unsigned long)(addr)),(size),(task->thread.fs))
-
-#define __xn_access_ok(task,type,addr,size)  __xn_range_ok(task,addr,size)
-
-/* Purposedly used inlines and not macros for the following routines
-   so that we don't risk spurious side-effects on the value arg. */
-
-static inline void __xn_success_return(struct pt_regs *regs, int v) {
-    __xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_error_return(struct pt_regs *regs, int v) {
-    /* We currently never set the SO bit for marking errors, even if
-     * we always test it upon syscall return. */
-    __xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, int v) {
-    __xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs) {
-    return __xn_reg_rval(regs) == -EINTR;
-}
-
-#else /* !__KERNEL__ */
-
-#define CONFIG_XENO_HW_DIRECT_TSC 1
-
-static inline unsigned long long __xn_rdtsc (void)
-
-{
-    unsigned long long t;
-
-    __asm__ __volatile__ ("mftb %0\n" : "=r" (t));
-    return t;
-}
-
-#endif /* __KERNEL__ */
-
-#endif /* !_XENO_ASM_PPC_SYSCALL_H */
diff -Nru --exclude=.svn xenomai-orig/include/nucleus/asm-ppc64/system.h xenomai-devel/include/nucleus/asm-ppc64/system.h
--- xenomai-orig/include/nucleus/asm-ppc64/system.h	2005-10-11 10:30:03.000000000 +0300
+++ xenomai-devel/include/nucleus/asm-ppc64/system.h	1970-01-01 02:00:00.000000000 +0200
@@ -1,628 +0,0 @@
-/*
- * Xenomai 64-bit PowerPC adoption
- * Copyright (C) 2005 Taneli V������h������kangas and Heikki Lindholm
- * based on previous work:
- *     
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
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
-#ifndef _XENO_ASM_PPC64_SYSTEM_H
-#define _XENO_ASM_PPC64_SYSTEM_H
-
-#include <nucleus/asm-generic/system.h>
-
-#ifdef __KERNEL__
-
-#include <linux/config.h>
-#include <linux/ptrace.h>
-
-#if ADEOS_RELEASE_NUMBER < 0x02060201
-#error "Adeos 2.6r2c1/ppc64 or above is required to run this software; please upgrade."
-#error "See http://download.gna.org/adeos/patches/v2.6/ppc64/"
-#endif
-
-#define XNARCH_DEFAULT_TICK     1000000 /* ns, i.e. 1ms */
-#define XNARCH_HOST_TICK        (1000000000UL/HZ)
-
-#define XNARCH_THREAD_STACKSZ   16384
-
-#define xnarch_stack_size(tcb)  ((tcb)->stacksize)
-#define xnarch_user_task(tcb)   ((tcb)->user_task)
-#define xnarch_user_pid(tcb)    ((tcb)->user_task->pid)
-
-#define xnarch_alloc_stack xnmalloc
-#define xnarch_free_stack  xnfree
-
-struct xnthread;
-struct task_struct;
-
-typedef struct xnarchtcb {	/* Per-thread arch-dependent block */
-
-    /* Kernel mode side */
-
-#ifdef CONFIG_XENO_HW_FPU
-    /* We only care for basic FPU handling in kernel-space; Altivec
-       and SPE are not available to kernel-based nucleus threads. */
-    rthal_fpenv_t fpuenv  __attribute__ ((aligned (16)));
-    rthal_fpenv_t *fpup;	/* Pointer to the FPU backup area */
-    struct task_struct *user_fpu_owner;
-    /* Pointer the the FPU owner in userspace:
-       - NULL for RT K threads,
-       - last_task_used_math for Linux US threads (only current or NULL when MP)
-       - current for RT US threads.
-    */
-#define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
-#else /* !CONFIG_XENO_HW_FPU */
-#define xnarch_fpu_ptr(tcb)     NULL
-#endif /* CONFIG_XENO_HW_FPU */
-
-    unsigned stacksize;		/* Aligned size of stack (bytes) */
-    unsigned long *stackbase;	/* Stack space */
-    unsigned long ksp;		/* Saved KSP for kernel-based threads */
-    unsigned long *kspp;	/* Pointer to saved KSP (&ksp or &user->thread.ksp) */
-
-    /* User mode side */
-    struct task_struct *user_task;	/* Shadowed user-space task */
-    struct task_struct *active_task;	/* Active user-space task */
-
-    /* Init block */
-    struct xnthread *self;
-    int imask;
-    const char *name;
-    void (*entry)(void *cookie);
-    void *cookie;
-
-} xnarchtcb_t;
-
-typedef struct xnarch_fltinfo {
-
-    unsigned exception;
-    struct pt_regs *regs;
-
-} xnarch_fltinfo_t;
-
-#define xnarch_fault_trap(fi)   ((unsigned int)(fi)->regs->trap)
-#define xnarch_fault_code(fi)   ((fi)->regs->dar)
-#define xnarch_fault_pc(fi)     ((fi)->regs->nip)
-#define xnarch_fault_pc(fi)     ((fi)->regs->nip)
-/* FIXME: FPU faults ignored by the nanokernel on PPC. */
-#define xnarch_fault_fpu_p(fi)  (0)
-
-/* The following predicates are only usable over a regular Linux stack
- *    context. */
-#define xnarch_fault_pf_p(fi)   ((fi)->exception == ADEOS_ACCESS_TRAP)
-#define xnarch_fault_bp_p(fi)   ((current->ptrace & PT_PTRACED) && \
-				((fi)->exception == ADEOS_IABR_TRAP || \
-				(fi)->exception == ADEOS_SSTEP_TRAP || \
-				(fi)->exception == ADEOS_PERFMON_TRAP))
-
-#define xnarch_fault_notify(fi) (!xnarch_fault_bp_p(fi))
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-static inline void *xnarch_sysalloc (u_long bytes)
-
-{
-#if 0	/* FIXME: likely on-demand mapping bug here */
-    if (bytes >= 128*1024)
-	return vmalloc(bytes);
-#endif
-
-    return kmalloc(bytes,GFP_KERNEL);
-}
-
-static inline void xnarch_sysfree (void *chunk, u_long bytes)
-
-{
-#if 0	/* FIXME: likely on-demand mapping bug here */
-    if (bytes >= 128*1024)
-	vfree(chunk);
-    else
-#endif
-	kfree(chunk);
-}
-
-static inline void xnarch_relay_tick (void)
-
-{
-    rthal_irq_host_pend(RTHAL_TIMER_IRQ);
-}
-
-#ifdef XENO_POD_MODULE
-
-void xnpod_welcome_thread(struct xnthread *);
-
-void xnpod_delete_thread(struct xnthread *);
-
-static inline int xnarch_start_timer (unsigned long ns,
-				      void (*tickhandler)(void))
-{
-    return rthal_timer_request(tickhandler,ns);
-}
-
-static inline void xnarch_leave_root (xnarchtcb_t *rootcb)
-
-{
-    rthal_declare_cpuid;
-
-    rthal_load_cpuid();
-
-    /* rthal_cpu_realtime is only tested for the current processor,
-       and always inside a critical section. */
-    __set_bit(cpuid,&rthal_cpu_realtime);
-    /* Remember the preempted Linux task pointer. */
-    rootcb->user_task = rootcb->active_task = rthal_current_host_task(cpuid);
-#ifdef CONFIG_XENO_HW_FPU
-    rootcb->user_fpu_owner = rthal_get_fpu_owner(rootcb->user_task);
-    /* So that xnarch_save_fpu() will operate on the right FPU area. */
-    rootcb->fpup = (rootcb->user_fpu_owner
-                    ? (rthal_fpenv_t *)&rootcb->user_fpu_owner->thread.fpr[0]
-                    : NULL);
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_enter_root (xnarchtcb_t *rootcb) {
-    __clear_bit(xnarch_current_cpu(),&rthal_cpu_realtime);
-}
-
-static inline void xnarch_switch_to (xnarchtcb_t *out_tcb,
-				     xnarchtcb_t *in_tcb)
-{
-    struct task_struct *prev = out_tcb->active_task;
-    struct task_struct *next = in_tcb->user_task;
-
-    in_tcb->active_task = next ?: prev;
-
-    if (next && next != prev) /* Switch to new user-space thread? */
-	{
-	struct mm_struct *mm = next->active_mm;
-
-	/* Switch the mm context.*/
-
-#ifdef CONFIG_ALTIVEC
-	/* Don't rely on FTR fixups --
-	   they don't work properly in our context. */
-	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC) {
-	    asm volatile (
-		"dssall;\n"
-		: : );
-	}
-#endif /* CONFIG_ALTIVEC */
-
-	if (!cpu_isset(smp_processor_id(), mm->cpu_vm_mask)) {
-		cpu_set(smp_processor_id(), mm->cpu_vm_mask);
-	}
-	
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB) {
-		switch_slb(next, mm);
-	}
-	else {
-		switch_stab(next, mm);
-	}
-	
-	flush_tlb_pending();
-	
-        _switch(&prev->thread, &next->thread);
-
-	barrier();
-	}
-    else
-        /* Kernel-to-kernel context switch. */
-        rthal_switch_context(out_tcb->kspp,in_tcb->kspp);
-}
-
-static inline void xnarch_finalize_and_switch (xnarchtcb_t *dead_tcb,
-					       xnarchtcb_t *next_tcb)
-{
-    xnarch_switch_to(dead_tcb,next_tcb);
-}
-
-static inline void xnarch_finalize_no_switch (xnarchtcb_t *dead_tcb)
-
-{
-    /* Empty */
-}
-
-static inline void xnarch_init_root_tcb (xnarchtcb_t *tcb,
-					 struct xnthread *thread,
-					 const char *name)
-{
-    tcb->user_task = current;
-    tcb->active_task = NULL;
-    tcb->ksp = 0;
-    tcb->kspp = &tcb->ksp;
-#ifdef CONFIG_XENO_HW_FPU
-    tcb->user_fpu_owner = NULL;
-    tcb->fpup = NULL;
-#endif /* CONFIG_XENO_HW_FPU */
-    tcb->entry = NULL;
-    tcb->cookie = NULL;
-    tcb->self = thread;
-    tcb->imask = 0;
-    tcb->name = name;
-}
-
-asmlinkage static void xnarch_thread_trampoline (xnarchtcb_t *tcb)
-
-{
-    rthal_local_irq_restore(!!tcb->imask);
-    xnpod_welcome_thread(tcb->self);
-    tcb->entry(tcb->cookie);
-    xnpod_delete_thread(tcb->self);
-}
-
-static inline void xnarch_init_thread (xnarchtcb_t *tcb,
-				       void (*entry)(void *),
-				       void *cookie,
-				       int imask,
-				       struct xnthread *thread,
-				       char *name)
-{
-    unsigned long *ksp, flags;
-
-    rthal_local_irq_flags_hw(flags);
-
-    if (tcb->stackbase) {
-        *tcb->stackbase = 0;
-	
-	ksp = (unsigned long *)(((unsigned long)tcb->stackbase + tcb->stacksize - 16) & ~0xf);
-	*ksp = 0L; /* first stack frame back-chain */
-	ksp = ksp - STACK_FRAME_OVERHEAD; /* first stack frame (entry uses) */
-	*ksp = (unsigned long)ksp+STACK_FRAME_OVERHEAD; /* second back-chain */
-	ksp = ksp - RTHAL_SWITCH_FRAME_SIZE; /* domain context */
-	tcb->ksp = (unsigned long)ksp - STACK_FRAME_OVERHEAD;
-	*((unsigned long *)tcb->ksp) = (unsigned long)ksp + 224; /*back-chain*/
-	/* NOTE: these depend on rthal_switch_context ordering */
-	ksp[18] = (unsigned long)get_paca(); /* r13 needs to hold paca */
-	ksp[19] = (unsigned long)tcb; /* r3 */
-	ksp[20] = ((unsigned long *)&xnarch_thread_trampoline)[1]; /* r2 = TOC base */
-	ksp[25] = ((unsigned long *)&xnarch_thread_trampoline)[0]; /* lr = entry addr. */
-	ksp[26] = flags & ~(MSR_EE | MSR_FP); /* msr */
-    }
-    else {
-        printk("xnarch_init_thread: NULL stackbase!\n");
-    }
-
-    tcb->entry = entry;
-    tcb->cookie = cookie;
-    tcb->self = thread;
-    tcb->imask = imask;
-    tcb->name = name;
-}
-
-/* No lazy FPU init on PPC. */
-#define xnarch_fpu_init_p(task) (1)
-
-static inline void xnarch_enable_fpu (xnarchtcb_t *current_tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-    if(!current_tcb->user_task)
-        rthal_enable_fpu();
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_init_fpu (xnarchtcb_t *tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-    /* Initialize the FPU for an emerging kernel-based RT thread. This
-       must be run on behalf of the emerging thread. */
-    memset(&tcb->fpuenv,0,sizeof(tcb->fpuenv));
-    rthal_init_fpu(&tcb->fpuenv);
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_save_fpu (xnarchtcb_t *tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-
-    if(tcb->fpup)
-        {
-        rthal_save_fpu(tcb->fpup);
-
-        if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
-            tcb->user_fpu_owner->thread.regs->msr &= ~MSR_FP;
-        }   
-
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-static inline void xnarch_restore_fpu (xnarchtcb_t *tcb)
-
-{
-#ifdef CONFIG_XENO_HW_FPU
-
-    if(tcb->fpup)
-        {
-        rthal_restore_fpu(tcb->fpup);
-
-        if(tcb->user_fpu_owner && tcb->user_fpu_owner->thread.regs)
-            tcb->user_fpu_owner->thread.regs->msr |= MSR_FP;
-        }   
-
-    /* FIXME: We restore FPU "as it was" when Xenomai preempted Linux,
-       whereas we could be much lazier. */
-    if(tcb->user_task)
-        rthal_disable_fpu();
-
-#endif /* CONFIG_XENO_HW_FPU */
-}
-
-#endif /* XENO_POD_MODULE */
-
-#ifdef XENO_THREAD_MODULE
-
-static inline void xnarch_init_tcb (xnarchtcb_t *tcb) {
-
-    tcb->user_task = NULL;
-    tcb->active_task = NULL;
-    tcb->kspp = &tcb->ksp;
-#ifdef CONFIG_XENO_HW_FPU
-    tcb->user_fpu_owner = NULL;
-    tcb->fpup = &tcb->fpuenv;
-#endif /* CONFIG_XENO_HW_FPU */
-    /* Must be followed by xnarch_init_thread(). */
-}
-
-#endif /* XENO_THREAD_MODULE */
-
-#ifdef XENO_SHADOW_MODULE
-
-static inline void xnarch_init_shadow_tcb (xnarchtcb_t *tcb,
-					   struct xnthread *thread,
-					   const char *name)
-{
-    struct task_struct *task = current;
-
-    tcb->user_task = task;
-    tcb->active_task = NULL;
-    tcb->ksp = 0;
-    tcb->kspp = &task->thread.ksp;
-#ifdef CONFIG_XENO_HW_FPU
-    tcb->user_fpu_owner = task;
-    tcb->fpup = (rthal_fpenv_t *)&task->thread.fpr[0];
-#endif /* CONFIG_XENO_HW_FPU */
-    tcb->entry = NULL;
-    tcb->cookie = NULL;
-    tcb->self = thread;
-    tcb->imask = 0;
-    tcb->name = name;
-}
-
-static inline void xnarch_grab_xirqs (void (*handler)(unsigned irq))
-
-{
-    unsigned irq;
-
-    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
-	rthal_virtualize_irq(rthal_current_domain,
-			     irq,
-			     handler,
-			     NULL,
-			     IPIPE_DYNAMIC_MASK);
-
-    /* On this arch, the decrementer trap is not an external IRQ but
-       it is instead mapped to a virtual IRQ, so we must grab it
-       individually. */
-
-    rthal_virtualize_irq(rthal_current_domain,
-			 RTHAL_TIMER_IRQ,
-			 handler,
-			 NULL,
-			 IPIPE_DYNAMIC_MASK);
-}
-
-static inline void xnarch_lock_xirqs (rthal_pipeline_stage_t *ipd, int cpuid)
-
-{
-    unsigned irq;
-
-    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
-	{
-	switch (irq)
-	    {
-#ifdef CONFIG_SMP
-	    case RTHAL_CRITICAL_IPI:
-
-		/* Never lock out this one. */
-		continue;
-#endif /* CONFIG_SMP */
-
-	    default:
-
-		rthal_lock_irq(ipd,cpuid,irq);
-	    }
-	}
-
-    rthal_lock_irq(ipd,cpuid,RTHAL_TIMER_IRQ);
-}
-
-static inline void xnarch_unlock_xirqs (rthal_pipeline_stage_t *ipd, int cpuid)
-
-{
-    unsigned irq;
-
-    for (irq = 0; irq < IPIPE_NR_XIRQS; irq++)
-	{
-	switch (irq)
-	    {
-#ifdef CONFIG_SMP
-	    case RTHAL_CRITICAL_IPI:
-
-		continue;
-#endif /* CONFIG_SMP */
-
-	    default:
-
-		rthal_unlock_irq(ipd,irq);
-	    }
-	}
-
-    rthal_unlock_irq(ipd,RTHAL_TIMER_IRQ);
-}
-
-#endif /* XENO_SHADOW_MODULE */
-
-#ifdef XENO_TIMER_MODULE
-
-static inline void xnarch_program_timer_shot (unsigned long delay) {
-    /* Even though some architectures may use a 64 bits delay here, we
-       voluntarily limit to 32 bits, 4 billions ticks should be enough
-       for now. Would a timer needs more, an extra call to the tick
-       handler would simply occur after 4 billions ticks.  Since the
-       timebase value is used to express CPU ticks on the PowerPC
-       port, there is no need to rescale the delay value. */
-    rthal_timer_program_shot(delay);
-}
-
-static inline void xnarch_stop_timer (void) {
-    rthal_timer_release();
-}
-
-static inline int xnarch_send_timer_ipi (xnarch_cpumask_t mask)
-
-{
-#ifdef CONFIG_SMP
-    return -1;		/* FIXME */
-#else /* ! CONFIG_SMP */
-    return 0;
-#endif /* CONFIG_SMP */
-}
-
-#endif /* XENO_TIMER_MODULE */
-
-#ifdef XENO_MAIN_MODULE
-
-#include <linux/init.h>
-#include <nucleus/asm/calibration.h>
-
-extern u_long nkschedlat;
-
-extern u_long nktimerlat;
-
-int xnarch_escalation_virq;
-
-int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo);
-
-void xnpod_schedule_handler(void);
-
-static rthal_trap_handler_t xnarch_old_trap_handler;
-
-static int xnarch_trap_fault (unsigned event, unsigned domid, void *data)
-{
-    xnarch_fltinfo_t fltinfo;
-    fltinfo.exception = event;
-    fltinfo.regs = (struct pt_regs *)data;
-    return xnpod_trap_fault(&fltinfo);
-}
-
-unsigned long xnarch_calibrate_timer (void)
-
-{
-#if CONFIG_XENO_HW_TIMER_LATENCY != 0
-    return xnarch_ns_to_tsc(CONFIG_XENO_HW_TIMER_LATENCY) ?: 1;
-#else /* CONFIG_XENO_HW_TIMER_LATENCY unspecified. */
-    /* Compute the time needed to program the decrementer in aperiodic
-       mode. The return value is expressed in timebase ticks. */
-    return xnarch_ns_to_tsc(rthal_timer_calibrate()) ?: 1;
-#endif /* CONFIG_XENO_HW_TIMER_LATENCY != 0 */
-}
-
-int xnarch_calibrate_sched (void)
-
-{
-    nktimerlat = xnarch_calibrate_timer();
-
-    if (!nktimerlat)
-	return -ENODEV;
-
-    nkschedlat = xnarch_ns_to_tsc(xnarch_get_sched_latency());
-
-    return 0;
-}
-
-static inline int xnarch_init (void)
-
-{
-    int err;
-
-#ifdef CONFIG_SMP
-    /* The HAL layer also sets the same CPU affinity so that both
-       modules keep their execution sequence on SMP boxen. */
-    set_cpus_allowed(current,cpumask_of_cpu(0));
-#endif /* CONFIG_SMP */
-
-    err = xnarch_calibrate_sched();
-
-    if (err)
-	return err;
-
-    xnarch_escalation_virq = rthal_alloc_virq();
-
-    if (xnarch_escalation_virq == 0)
-	return -ENOSYS;
-
-    rthal_virtualize_irq(&rthal_domain,
-			 xnarch_escalation_virq,
-			 (void (*)(unsigned))&xnpod_schedule_handler,
-			 NULL,
-			 IPIPE_HANDLE_MASK);
-
-    xnarch_old_trap_handler = rthal_trap_catch(&xnarch_trap_fault);
-
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-    err = xnshadow_mount();
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
-
-    if (err)
-	{
-	rthal_trap_catch(xnarch_old_trap_handler);
-        rthal_free_virq(xnarch_escalation_virq);
-	}
-
-    return err;
-}
-
-static inline void xnarch_exit (void)
-
-{
-#ifdef CONFIG_XENO_OPT_PERVASIVE
-    xnshadow_cleanup();
-#endif /* CONFIG_XENO_OPT_PERVASIVE */
-    rthal_trap_catch(xnarch_old_trap_handler);
-    rthal_free_virq(xnarch_escalation_virq);
-}
-
-#endif /* XENO_MAIN_MODULE */
-
-#ifdef __cplusplus
-}
-#endif
-
-#else /* !__KERNEL__ */
-
-#include <nucleus/system.h>
-#include <bits/local_lim.h>
-
-#endif /* __KERNEL__ */
-
-#endif /* !_XENO_ASM_PPC64_SYSTEM_H */

--------------050203000005090307050403--

