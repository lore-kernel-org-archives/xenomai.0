Message-ID: <48AEE3AB.6070001@domain.hid>
Date: Fri, 22 Aug 2008 18:04:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 2/2] Unify asm-x86/atomic.h
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

...and also automatically fixes the missing LOCK prefix for
pthread_mutex_* services on x86_32 SMP.

---
 include/asm-x86/atomic.h    |   64 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/atomic_32.h |   31 ---------------------
 include/asm-x86/atomic_64.h |   33 ----------------------
 3 files changed, 64 insertions(+), 64 deletions(-)

Index: b/include/asm-x86/atomic.h
===================================================================
--- a/include/asm-x86/atomic.h
+++ b/include/asm-x86/atomic.h
@@ -1,5 +1,69 @@
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
+#define xnarch_atomic_set_mask(pflags,mask) \
+	atomic_set_mask((mask),(unsigned *)(pflags))
+#define xnarch_atomic_clear_mask(pflags,mask) \
+	atomic_clear_mask((mask),(unsigned *)(pflags))
+#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
+
+#define xnarch_memory_barrier()  smp_mb()
+
+#else /* !__KERNEL__ */
+
+#include <xeno_config.h>
+
+#ifdef CONFIG_SMP
+#define LOCK_PREFIX "lock ; "
+#else
+#define LOCK_PREFIX ""
+#endif
+
+typedef struct { unsigned long counter; } xnarch_atomic_t;
+
+#define xnarch_atomic_get(v)		((v)->counter)
+
+#define xnarch_atomic_set(v,i)		(((v)->counter) = (i))
+
+#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
+
+#endif /* __KERNEL__ */
+
 #ifdef __i386__
 #include "atomic_32.h"
 #else
 #include "atomic_64.h"
 #endif
+
+#include <asm-generic/xenomai/atomic.h>
+
+#endif /* !_XENO_ASM_X86_ATOMIC_64_H */
Index: b/include/asm-x86/atomic_32.h
===================================================================
--- a/include/asm-x86/atomic_32.h
+++ b/include/asm-x86/atomic_32.h
@@ -19,48 +19,23 @@
 
 #ifndef _XENO_ASM_X86_ATOMIC_32_H
 #define _XENO_ASM_X86_ATOMIC_32_H
-#define _XENO_ASM_X86_ATOMIC_H
 
 #ifdef __KERNEL__
 
-#include <linux/bitops.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
 #define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
 #define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
 #define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
 #define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
 #define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcounter)
 #define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcounter)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pflags)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pflags)
-#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
 #define xnarch_atomic_cmpxchg(pcounter,old,new) \
 	atomic_cmpxchg((pcounter),(old),(new))
 
-#define xnarch_memory_barrier()  smp_mb()
-
-typedef atomic_t atomic_counter_t;
-typedef atomic_t xnarch_atomic_t;
-
 #else /* !__KERNEL__ */
 
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
-#else
-#define LOCK_PREFIX ""
-#endif
-
-typedef struct { int counter; } xnarch_atomic_t;
-
 struct __xeno_xchg_dummy { unsigned long a[100]; };
 #define __xeno_xg(x) ((struct __xeno_xchg_dummy *)(x))
 
-#define xnarch_atomic_get(v)		((v)->counter)
-
-#define xnarch_atomic_set(v,i)		(((v)->counter) = (i))
-
 static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
 						unsigned long x)
 {
@@ -88,13 +63,7 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *v
 
 #define xnarch_read_memory_barrier() \
 	__asm__ __volatile__ (LOCK_PREFIX "addl $0,0(%%esp)": : :"memory")
-#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
 
 #endif /* !__KERNEL__ */
 
-typedef unsigned long atomic_flags_t;
-
-#include <asm/xenomai/features.h>
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_X86_ATOMIC_32_H */
Index: b/include/asm-x86/atomic_64.h
===================================================================
--- a/include/asm-x86/atomic_64.h
+++ b/include/asm-x86/atomic_64.h
@@ -19,55 +19,25 @@
 
 #ifndef _XENO_ASM_X86_ATOMIC_64_H
 #define _XENO_ASM_X86_ATOMIC_64_H
-#define _XENO_ASM_X86_ATOMIC_H
-
-#include <asm/xenomai/features.h>
-
-typedef unsigned long atomic_flags_t;
 
 #ifdef __KERNEL__
 
-#include <linux/bitops.h>
-#include <asm/atomic.h>
-#include <asm/system.h>
-
 #define xnarch_atomic_set(pcounter,i)          atomic64_set(pcounter,i)
 #define xnarch_atomic_get(pcounter)            atomic64_read(pcounter)
 #define xnarch_atomic_inc(pcounter)            atomic64_inc(pcounter)
 #define xnarch_atomic_dec(pcounter)            atomic64_dec(pcounter)
 #define xnarch_atomic_inc_and_test(pcounter)  atomic64_inc_and_test(pcounter)
 #define xnarch_atomic_dec_and_test(pcounter)  atomic64_dec_and_test(pcounter)
-#define xnarch_atomic_set_mask(pflags,mask) \
-	atomic_set_mask((mask),(unsigned *)(pflags))
-#define xnarch_atomic_clear_mask(pflags,mask) \
-	atomic_clear_mask((mask),(unsigned *)(pflags))
-#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,x)
 #define xnarch_atomic_cmpxchg(pcounter,old,new) \
 	atomic64_cmpxchg((pcounter),(old),(new))
 
-#define xnarch_memory_barrier()  smp_mb()
-
 typedef atomic64_t atomic_counter_t;
 typedef atomic64_t xnarch_atomic_t;
 
-#include <asm-generic/xenomai/atomic.h>
-
 #else /* !__KERNEL__ */
 
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
-#else
-#define LOCK_PREFIX ""
-#endif
-
-typedef struct { unsigned long counter; } xnarch_atomic_t;
-
 #define __xeno_xg(x) ((volatile long *)(x))
 
-#define xnarch_atomic_get(v)		((v)->counter)
-
-#define xnarch_atomic_set(v,i)		(((v)->counter) = (i))
-
 static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
 						unsigned long x)
 {
@@ -93,10 +63,7 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *v
 
 #define xnarch_memory_barrier()		asm volatile("mfence":::"memory")
 #define xnarch_read_memory_barrier()	asm volatile("lfence":::"memory")
-#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
 
 #endif /* __KERNEL__ */
 
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_X86_ATOMIC_64_H */

