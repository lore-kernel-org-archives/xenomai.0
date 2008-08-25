Message-ID: <48B265A4.5040003@domain.hid>
Date: Mon, 25 Aug 2008 09:56:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AEE3AB.6070001@domain.hid>
	<48AEE945.8000503@domain.hid>	<48AFCD61.8040203@domain.hid>
	<48AFE515.70003@domain.hid> <48AFEA3B.4070702@domain.hid>
In-Reply-To: <48AFEA3B.4070702@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 2/2] Unify asm-x86/atomic.h
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> ...and also automatically fixes the missing LOCK prefix for
>>>>> pthread_mutex_* services on x86_32 SMP.
>>>> This looks to me as a half-way unification. Can we not totally get rid
>>>> of atomic_32.h and atomic_64.h ? I mean since we are using unsigned long
>>>> as atomic_t on both platforms, there should not be much difference
>>>> (except maybe the inline asm).
>>>>
>>> I could merge all atomic_32/64.h hunks into atomic.h if that this
>>> preferred, but I cannot help getting rid of the atomic_t vs. atomic64_t
>>> differences, thus the sub-arch specific part cannot be reduced as far as
>>> I see it ATM.
>> We could use atomic_long_t on the two arches.
> 
> OK, but then it becomes wrapping business (2.4...) - on the long term a
> vanishing issue, granted. Will look into this.

Here we go, an atomic_long_t based unification patch. Cannot test 2.4
kernel built, unfortunately, but the rest is fine (note: requires
bootstrap run).

Jan

---
 include/asm-generic/wrappers.h |   82 ++++++++++++++++++-----
 include/asm-x86/Makefile.am    |    2 
 include/asm-x86/atomic.h       |  142 ++++++++++++++++++++++++++++++++++++++++-
 include/asm-x86/atomic_32.h    |  101 -----------------------------
 include/asm-x86/atomic_64.h    |  102 -----------------------------
 5 files changed, 203 insertions(+), 226 deletions(-)

Index: b/include/asm-x86/atomic.h
===================================================================
--- a/include/asm-x86/atomic.h
+++ b/include/asm-x86/atomic.h
@@ -1,5 +1,141 @@
-#ifdef __i386__
-#include "atomic_32.h"
+/*
+ * Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>.
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
+#ifndef _XENO_ASM_X86_ATOMIC_H
+#define _XENO_ASM_X86_ATOMIC_H
+
+#include <asm/xenomai/features.h>
+
+typedef unsigned long atomic_flags_t;
+
+#ifdef __KERNEL__
+
+#include <linux/bitops.h>
+#include <asm/atomic.h>
+#include <asm/system.h>
+
+#define xnarch_atomic_set(pcounter,i)	atomic_long_set(pcounter,i)
+#define xnarch_atomic_get(pcounter)	atomic_long_read(pcounter)
+#define xnarch_atomic_inc(pcounter)	atomic_long_inc(pcounter)
+#define xnarch_atomic_dec(pcounter)	atomic_long_dec(pcounter)
+#define xnarch_atomic_inc_and_test(pcounter) \
+	atomic_long_inc_and_test(pcounter)
+#define xnarch_atomic_dec_and_test(pcounter) \
+	atomic_long_dec_and_test(pcounter)
+#define xnarch_atomic_cmpxchg(pcounter,old,new) \
+	atomic_long_cmpxchg((pcounter),(old),(new))
+
+typedef atomic_long_t atomic_counter_t;
+typedef atomic_long_t xnarch_atomic_t;
+
+#define xnarch_atomic_set_mask(pflags,mask) \
+	atomic_set_mask((mask),(unsigned *)(pflags))
+#define xnarch_atomic_clear_mask(pflags,mask) \
+	atomic_clear_mask((mask),(unsigned *)(pflags))
+#define xnarch_atomic_xchg(ptr,x)	xchg(ptr,x)
+
+#define xnarch_memory_barrier()		smp_mb()
+
+#else /* !__KERNEL__ */
+
+#include <xeno_config.h>
+
+#ifdef CONFIG_SMP
+#define LOCK_PREFIX "lock ; "
 #else
-#include "atomic_64.h"
+#define LOCK_PREFIX ""
 #endif
+
+typedef struct { unsigned long counter; } xnarch_atomic_t;
+
+#define xnarch_atomic_get(v)		((v)->counter)
+
+#define xnarch_atomic_set(v,i)		(((v)->counter) = (i))
+
+#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
+
+#ifdef __i386__
+
+struct __xeno_xchg_dummy { unsigned long a[100]; };
+#define __xeno_xg(x) ((struct __xeno_xchg_dummy *)(x))
+
+static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
+						unsigned long x)
+{
+	__asm__ __volatile__("xchgl %0,%1"
+			     :"=r" (x)
+			     :"m" (*__xeno_xg(ptr)), "0" (x)
+			     :"memory");
+	return x;
+}
+
+static inline unsigned long
+xnarch_atomic_cmpxchg(xnarch_atomic_t *v, unsigned long old, unsigned long newval)
+{
+	volatile void *ptr = &v->counter;
+	unsigned long prev;
+
+	__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
+			     : "=a"(prev)
+			     : "r"(newval), "m"(*__xeno_xg(ptr)), "0"(old)
+			     : "memory");
+	return prev;
+}
+
+#define xnarch_memory_barrier()		__asm__ __volatile__("": : :"memory")
+#define xnarch_read_memory_barrier() \
+	__asm__ __volatile__ (LOCK_PREFIX "addl $0,0(%%esp)": : :"memory")
+
+#else /* x86_64 */
+
+#define __xeno_xg(x) ((volatile long *)(x))
+
+static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
+						unsigned long x)
+{
+	__asm__ __volatile__("xchgq %0,%1"
+			     :"=r" (x)
+			     :"m" (*__xeno_xg(ptr)), "0" (x)
+			     :"memory");
+	return x;
+}
+
+static inline unsigned long
+xnarch_atomic_cmpxchg(xnarch_atomic_t *v, unsigned long old, unsigned long newval)
+{
+	volatile void *ptr = &v->counter;
+	unsigned long prev;
+
+	__asm__ __volatile__(LOCK_PREFIX "cmpxchgq %1,%2"
+			     : "=a"(prev)
+			     : "r"(newval), "m"(*__xeno_xg(ptr)), "0"(old)
+			     : "memory");
+	return prev;
+}
+
+#define xnarch_memory_barrier()		asm volatile("mfence":::"memory")
+#define xnarch_read_memory_barrier()	asm volatile("lfence":::"memory")
+
+#endif /* x86_64 */
+
+#endif /* __KERNEL__ */
+
+#include <asm-generic/xenomai/atomic.h>
+
+#endif /* !_XENO_ASM_X86_ATOMIC_64_H */
Index: b/include/asm-x86/atomic_64.h
===================================================================
--- a/include/asm-x86/atomic_64.h
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * Copyright (C) 2007 Philippe Gerum <rpm@xenomai.org>.
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
-#ifndef _XENO_ASM_X86_ATOMIC_64_H
-#define _XENO_ASM_X86_ATOMIC_64_H
-#define _XENO_ASM_X86_ATOMIC_H
-
-#include <asm/xenomai/features.h>
-
-typedef unsigned long atomic_flags_t;
-
-#ifdef __KERNEL__
-
-#include <linux/bitops.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-#define xnarch_atomic_set(pcounter,i)          atomic64_set(pcounter,i)
-#define xnarch_atomic_get(pcounter)            atomic64_read(pcounter)
-#define xnarch_atomic_inc(pcounter)            atomic64_inc(pcounter)
-#define xnarch_atomic_dec(pcounter)            atomic64_dec(pcounter)
-#define xnarch_atomic_inc_and_test(pcounter)  atomic64_inc_and_test(pcounter)
-#define xnarch_atomic_dec_and_test(pcounter)  atomic64_dec_and_test(pcounter)
-#define xnarch_atomic_set_mask(pflags,mask) \
-	atomic_set_mask((mask),(unsigned *)(pflags))
-#define xnarch_atomic_clear_mask(pflags,mask) \
-	atomic_clear_mask((mask),(unsigned *)(pflags))
-#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
-#define xnarch_atomic_cmpxchg(pcounter,old,new) \
-	atomic64_cmpxchg((pcounter),(old),(new))
-
-#define xnarch_memory_barrier()  smp_mb()
-
-typedef atomic64_t atomic_counter_t;
-typedef atomic64_t xnarch_atomic_t;
-
-#include <asm-generic/xenomai/atomic.h>
-
-#else /* !__KERNEL__ */
-
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
-#else
-#define LOCK_PREFIX ""
-#endif
-
-typedef struct { unsigned long counter; } xnarch_atomic_t;
-
-#define __xeno_xg(x) ((volatile long *)(x))
-
-#define xnarch_atomic_get(v)		((v)->counter)
-
-#define xnarch_atomic_set(v,i)		(((v)->counter) = (i))
-
-static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
-						unsigned long x)
-{
-	__asm__ __volatile__("xchgq %0,%1"
-			     :"=r" (x)
-			     :"m" (*__xeno_xg(ptr)), "0" (x)
-			     :"memory");
-	return x;
-}
-
-static inline unsigned long
-xnarch_atomic_cmpxchg(xnarch_atomic_t *v, unsigned long old, unsigned long newval)
-{
-	volatile void *ptr = &v->counter;
-	unsigned long prev;
-
-	__asm__ __volatile__(LOCK_PREFIX "cmpxchgq %1,%2"
-			     : "=a"(prev)
-			     : "r"(newval), "m"(*__xeno_xg(ptr)), "0"(old)
-			     : "memory");
-	return prev;
-}
-
-#define xnarch_memory_barrier()		asm volatile("mfence":::"memory")
-#define xnarch_read_memory_barrier()	asm volatile("lfence":::"memory")
-#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
-
-#endif /* __KERNEL__ */
-
-#include <asm-generic/xenomai/atomic.h>
-
-#endif /* !_XENO_ASM_X86_ATOMIC_64_H */
Index: b/include/asm-generic/wrappers.h
===================================================================
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 #include <asm/io.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 
 #include <linux/wrapper.h>
 #include <linux/wait.h>
@@ -38,6 +38,11 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>	/* Use the backport. */
+#include <asm/atomic.h>
+
+#if BITS_PER_LONG != 32
+#error Upgrade to kernel 2.6!
+#endif
 
 /* Compiler */
 #ifndef __attribute_const__
@@ -276,7 +281,63 @@ void show_stack(struct task_struct *task
 #define __GFP_BITS_SHIFT 20
 #define pgprot_noncached(p) (p)
 
-#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) */
+typedef atomic_t atomic_long_t;
+
+static inline long atomic_long_read(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	return (long)atomic_read(v);
+}
+
+static inline void atomic_long_set(atomic_long_t *l, long i)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_set(v, i);
+}
+
+static inline void atomic_long_inc(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_inc(v);
+}
+
+static inline void atomic_long_dec(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	atomic_dec(v);
+}
+
+static inline int atomic_long_dec_and_test(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	return atomic_dec_and_test(v);
+}
+
+static inline int atomic_long_inc_and_test(atomic_long_t *l)
+{
+	atomic_t *v = (atomic_t *)l;
+
+	return atomic_inc_and_test(v);
+}
+
+#define atomic_long_cmpxchg(l, old, new) \
+	(atomic_cmpxchg((atomic_t *)(l), (old), (new)))
+
+static inline unsigned long hweight_long(unsigned long w)
+{
+	return hweight32(w);
+}
+
+#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
+unsigned long find_next_bit(const unsigned long *addr,
+                            unsigned long size, unsigned long offset);
+
+#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0) */
 
 #define compat_module_param_array(name, type, count, perm) \
 	module_param_array(name, type, NULL, perm)
@@ -393,7 +454,7 @@ unsigned long __va_to_kva(unsigned long
 #define DECLARE_WORK_FUNC(f)		void f(struct work_struct *work)
 #endif /* >= 2.6.20 */
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 #define IRQF_SHARED			SA_SHIRQ
@@ -415,19 +476,4 @@ unsigned long __va_to_kva(unsigned long
 #define KMALLOC_MAX_SIZE 131072
 #endif /* !KMALLOC_MAX_SIZE */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
-static inline unsigned long hweight_long(unsigned long w)
-{
-#if BITS_PER_LONG == 64
-	return hweight64(w);
-#else /* 32 bits */
-	return hweight32(w);
-#endif /* 32 bits */
-}
-
-#define find_first_bit(addr, size) find_next_bit((addr), (size), 0)
-unsigned long find_next_bit(const unsigned long *addr,
-                            unsigned long size, unsigned long offset);
-#endif /* linux version < 2.6.0 */
-
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
Index: b/include/asm-x86/Makefile.am
===================================================================
--- a/include/asm-x86/Makefile.am
+++ b/include/asm-x86/Makefile.am
@@ -4,8 +4,6 @@ includesub_HEADERS =	\
 	arith_32.h	\
 	arith_64.h	\
 	arith.h	\
-	atomic_32.h	\
-	atomic_64.h	\
 	atomic.h	\
 	calibration.h	\
 	features_32.h	\
Index: b/include/asm-x86/atomic_32.h
===================================================================
--- a/include/asm-x86/atomic_32.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * Copyright (C) 2003 Philippe Gerum <rpm@xenomai.org>.
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
-#ifndef _XENO_ASM_X86_ATOMIC_32_H
-#define _XENO_ASM_X86_ATOMIC_32_H
-#define _XENO_ASM_X86_ATOMIC_H
-
-#include <asm/xenomai/features.h>
-
-#ifdef __KERNEL__
-
-#include <linux/bitops.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
-#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
-#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
-#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
-#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
-#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
-#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
-#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
-#define xnarch_atomic_cmpxchg(pcounter,old,new) \
-	atomic_cmpxchg((pcounter),(old),(new))
-
-#define xnarch_memory_barrier()  smp_mb()
-
-typedef atomic_t atomic_counter_t;
-typedef atomic_t xnarch_atomic_t;
-
-#else /* !__KERNEL__ */
-
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
-#else
-#define LOCK_PREFIX ""
-#endif
-
-typedef struct { int counter; } xnarch_atomic_t;
-
-struct __xeno_xchg_dummy { unsigned long a[100]; };
-#define __xeno_xg(x) ((struct __xeno_xchg_dummy *)(x))
-
-#define xnarch_atomic_get(v)		((v)->counter)
-
-#define xnarch_atomic_set(v,i)		(((v)->counter) = (i))
-
-static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
-						unsigned long x)
-{
-	__asm__ __volatile__("xchgl %0,%1"
-			     :"=r" (x)
-			     :"m" (*__xeno_xg(ptr)), "0" (x)
-			     :"memory");
-	return x;
-}
-
-static inline unsigned long
-xnarch_atomic_cmpxchg(xnarch_atomic_t *v, unsigned long old, unsigned long newval)
-{
-	volatile void *ptr = &v->counter;
-	unsigned long prev;
-
-	__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
-			     : "=a"(prev)
-			     : "r"(newval), "m"(*__xeno_xg(ptr)), "0"(old)
-			     : "memory");
-	return prev;
-}
-
-#define xnarch_memory_barrier()  __asm__ __volatile__("": : :"memory")
-
-#define xnarch_read_memory_barrier() \
-	__asm__ __volatile__ (LOCK_PREFIX "addl $0,0(%%esp)": : :"memory")
-#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
-
-#endif /* !__KERNEL__ */
-
-typedef unsigned long atomic_flags_t;
-
-#include <asm-generic/xenomai/atomic.h>
-
-#endif /* !_XENO_ASM_X86_ATOMIC_32_H */


