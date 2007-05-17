From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OTdkNzxgGf"
Content-Transfer-Encoding: 7bit
Message-ID: <17996.15540.824415.263562@domain.hid>
Date: Thu, 17 May 2007 13:29:56 +0200
Subject: [Xenomai-core] [PATCH] Use tsc for implementation of clock_gettime.
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


--OTdkNzxgGf
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi,

here comes, for review, a patch which reduces the overhead of
clock_gettime by directly reading the tsc in user-space for
architectures that support it.

-- 


					    Gilles Chanteperdrix.

--OTdkNzxgGf
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-clock_gettime-direct-tsc.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-ia64/Makefile.in
===================================================================
--- include/asm-ia64/Makefile.in	(revision 2454)
+++ include/asm-ia64/Makefile.in	(working copy)
@@ -230,7 +230,9 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 includesubdir = $(includedir)/asm-ia64
-includesub_HEADERS = atomic.h calibration.h features.h hal.h syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
+
 SUBDIRS = bits
 all: all-recursive
 
Index: include/asm-ia64/Makefile.am
===================================================================
--- include/asm-ia64/Makefile.am	(revision 2454)
+++ include/asm-ia64/Makefile.am	(working copy)
@@ -1,5 +1,6 @@
 includesubdir = $(includedir)/asm-ia64
 
-includesub_HEADERS = atomic.h calibration.h features.h hal.h syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-ia64/arith.h
===================================================================
--- include/asm-ia64/arith.h	(revision 0)
+++ include/asm-ia64/arith.h	(revision 0)
@@ -0,0 +1,6 @@
+#ifndef _XENO_ASM_IA64_ARITH_H
+#define _XENO_ASM_IA64_ARITH_H
+
+#include <asm-generic/xenomai/arith.h>
+
+#endif /* _XENO_ASM_IA64_ARITH_H */

Property changes on: include/asm-ia64/arith.h
___________________________________________________________________
Name: svn:executable
   + *

Index: include/asm-blackfin/Makefile.in
===================================================================
--- include/asm-blackfin/Makefile.in	(revision 2454)
+++ include/asm-blackfin/Makefile.in	(working copy)
@@ -230,8 +230,8 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 includesubdir = $(includedir)/asm-blackfin
-includesub_HEADERS = atomic.h calibration.h features.h hal.h \
-		syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
 all: all-recursive
Index: include/asm-blackfin/Makefile.am
===================================================================
--- include/asm-blackfin/Makefile.am	(revision 2454)
+++ include/asm-blackfin/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 includesubdir = $(includedir)/asm-blackfin
 
-includesub_HEADERS = atomic.h calibration.h features.h hal.h \
-		syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-blackfin/arith.h
===================================================================
--- include/asm-blackfin/arith.h	(revision 0)
+++ include/asm-blackfin/arith.h	(revision 0)
@@ -0,0 +1,6 @@
+#ifndef _XENO_ASM_BLACKFIN_ARITH_H
+#define _XENO_ASM_BLACKFIN_ARITH_H
+
+#include <asm-generic/xenomai/arith.h>
+
+#endif /* _XENO_ASM_BLACKFIN_ARITH_H */

Property changes on: include/asm-blackfin/arith.h
___________________________________________________________________
Name: svn:executable
   + *

Index: include/asm-generic/syscall.h
===================================================================
--- include/asm-generic/syscall.h	(revision 2454)
+++ include/asm-generic/syscall.h	(working copy)
@@ -55,7 +55,6 @@
 
     unsigned long long cpufreq;	/* CPU frequency */
     unsigned long tickval;	/* Tick duration (ns) */
-
 } xnsysinfo_t;
 
 #define SIGHARDEN  SIGWINCH
Index: include/asm-generic/bits/bind.h
===================================================================
--- include/asm-generic/bits/bind.h	(revision 2454)
+++ include/asm-generic/bits/bind.h	(working copy)
@@ -62,7 +62,7 @@
 	sa.sa_flags = 0;
 	sigaction(SIGXCPU, &sa, NULL);
 
-	return __xn_mux_shifted_id(muxid);
+	return muxid;
 }
 
 static inline int
@@ -105,7 +105,7 @@
 		exit(1);
 	}
 
-	return __xn_mux_shifted_id(muxid);
+	return muxid;
 }
 
 #endif /* _XENO_ASM_GENERIC_BITS_BIND_H */
Index: include/asm-generic/Makefile.in
===================================================================
--- include/asm-generic/Makefile.in	(revision 2454)
+++ include/asm-generic/Makefile.in	(working copy)
@@ -230,7 +230,7 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 includesubdir = $(includedir)/asm-generic
-includesub_HEADERS = features.h hal.h syscall.h system.h wrappers.h
+includesub_HEADERS = arith.h features.h hal.h syscall.h system.h wrappers.h
 SUBDIRS = bits
 all: all-recursive
 
Index: include/asm-generic/Makefile.am
===================================================================
--- include/asm-generic/Makefile.am	(revision 2454)
+++ include/asm-generic/Makefile.am	(working copy)
@@ -1,5 +1,5 @@
 includesubdir = $(includedir)/asm-generic
 
-includesub_HEADERS = features.h hal.h syscall.h system.h wrappers.h
+includesub_HEADERS = arith.h features.h hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-generic/hal.h
===================================================================
--- include/asm-generic/hal.h	(revision 2454)
+++ include/asm-generic/hal.h	(working copy)
@@ -37,8 +37,8 @@
 #include <linux/kallsyms.h>
 #include <linux/init.h>
 #include <asm/byteorder.h>
-#include <asm/div64.h>
 #include <asm/xenomai/wrappers.h>
+#include <asm/xenomai/arith.h>
 
 #define RTHAL_DOMAIN_ID		0x58454e4f
 
@@ -385,121 +385,6 @@
 
 #define rthal_printk	printk
 
-#ifdef __BIG_ENDIAN
-#define endianstruct struct { unsigned _h; unsigned _l; } _s
-#else /* __LITTLE_ENDIAN */
-#define endianstruct struct { unsigned _l; unsigned _h; } _s
-#endif
-
-#ifndef __rthal_u64tou32
-#define __rthal_u64tou32(ull, h, l) ({          \
-    union { unsigned long long _ull;            \
-    endianstruct;                               \
-    } _u;                                       \
-    _u._ull = (ull);                            \
-    (h) = _u._s._h;                             \
-    (l) = _u._s._l;                             \
-})
-#endif /* !__rthal_u64tou32 */
-
-#ifndef __rthal_u64fromu32
-#define __rthal_u64fromu32(h, l) ({             \
-    union { unsigned long long _ull;            \
-    endianstruct;                               \
-    } _u;                                       \
-    _u._s._h = (h);                             \
-    _u._s._l = (l);                             \
-    _u._ull;                                    \
-})
-#endif /* !__rthal_u64fromu32 */
-
-#ifndef rthal_ullmul
-static inline __attribute_const__ unsigned long long
-__rthal_generic_ullmul(const unsigned m0, const unsigned m1)
-{
-    return (unsigned long long) m0 * m1;
-}
-#define rthal_ullmul(m0,m1) __rthal_generic_ullmul((m0),(m1))
-#endif /* !rthal_ullmul */
-
-#ifndef rthal_ulldiv
-static inline unsigned long long __rthal_generic_ulldiv (unsigned long long ull,
-                                                         const unsigned uld,
-                                                         unsigned long *const rp)
-{
-    const unsigned r = do_div(ull, uld);
-
-    if (rp)
-        *rp = r;
-
-    return ull;
-}
-#define rthal_ulldiv(ull,uld,rp) __rthal_generic_ulldiv((ull),(uld),(rp))
-#endif /* !rthal_ulldiv */
-
-#ifndef rthal_uldivrem
-#define rthal_uldivrem(ull,ul,rp) ((unsigned) rthal_ulldiv((ull),(ul),(rp)))
-#endif /* !rthal_uldivrem */
-
-#ifndef rthal_imuldiv
-static inline __attribute_const__ int __rthal_generic_imuldiv (int i,
-                                                               int mult,
-                                                               int div)
-{
-    /* Returns (int)i = (unsigned long long)i*(unsigned)(mult)/(unsigned)div. */
-    const unsigned long long ull = rthal_ullmul(i, mult);
-    return rthal_uldivrem(ull, div, NULL);
-}
-#define rthal_imuldiv(i,m,d) __rthal_generic_imuldiv((i),(m),(d))
-#endif /* !rthal_imuldiv */
-
-#ifndef rthal_llimd
-/* Division of an unsigned 96 bits ((h << 32) + l) by an unsigned 32 bits. 
-   Building block for llimd. Without const qualifiers, gcc reload registers
-   after each call to uldivrem. */
-static inline unsigned long long
-__rthal_generic_div96by32 (const unsigned long long h,
-                           const unsigned l,
-                           const unsigned d,
-                           unsigned long *const rp)
-{
-    unsigned long rh;
-    const unsigned qh = rthal_uldivrem(h, d, &rh);
-    const unsigned long long t = __rthal_u64fromu32(rh, l);
-    const unsigned ql = rthal_uldivrem(t, d, rp);
-
-    return __rthal_u64fromu32(qh, ql);
-}
-
-static inline __attribute_const__
-unsigned long long __rthal_generic_ullimd (const unsigned long long op,
-                                           const unsigned m,
-                                           const unsigned d)
-{
-    unsigned oph, opl, tlh, tll;
-    unsigned long long th, tl;
-
-    __rthal_u64tou32(op, oph, opl);
-    tl = rthal_ullmul(opl, m);
-    __rthal_u64tou32(tl, tlh, tll);
-    th = rthal_ullmul(oph, m);
-    th += tlh;
-
-    return __rthal_generic_div96by32(th, tll, d, NULL);
-}
-
-static inline __attribute_const__ long long __rthal_generic_llimd (long long op,
-                                                                   unsigned m,
-                                                                   unsigned d)
-{
-
-    if(op < 0LL)
-        return -__rthal_generic_ullimd(-op, m, d);
-    return __rthal_generic_ullimd(op, m, d);
-}
-#define rthal_llimd(ll,m,d) __rthal_generic_llimd((ll),(m),(d))
-#endif /* !rthal_llimd */
-
 typedef ipipe_irq_handler_t rthal_irq_handler_t;
 typedef ipipe_irq_ackfn_t   rthal_irq_ackfn_t;
 
Index: include/asm-generic/system.h
===================================================================
--- include/asm-generic/system.h	(revision 2454)
+++ include/asm-generic/system.h	(working copy)
@@ -133,18 +133,6 @@
 #define xnarch_logerr(fmt,args...)   printk(KERN_ERR XNARCH_PROMPT fmt , ##args)
 #define xnarch_printf(fmt,args...)   printk(KERN_INFO XNARCH_PROMPT fmt , ##args)
 
-#define xnarch_ullmod(ull,uld,rem)   ({ xnarch_ulldiv(ull,uld,rem); (*rem); })
-#define xnarch_uldiv(ull, d)         rthal_uldivrem(ull, d, NULL)
-#define xnarch_ulmod(ull, d)         ({ u_long _rem;                    \
-                                        rthal_uldivrem(ull,d,&_rem); _rem; })
-
-#define xnarch_ullmul                rthal_ullmul
-#define xnarch_uldivrem              rthal_uldivrem
-#define xnarch_ulldiv                rthal_ulldiv
-#define xnarch_imuldiv               rthal_imuldiv
-#define xnarch_llimd                 rthal_llimd
-#define xnarch_get_cpu_tsc           rthal_rdtsc
-
 typedef cpumask_t xnarch_cpumask_t;
 
 #ifdef CONFIG_SMP
Index: include/asm-generic/arith.h
===================================================================
--- include/asm-generic/arith.h	(revision 0)
+++ include/asm-generic/arith.h	(revision 0)
@@ -0,0 +1,173 @@
+/**
+ *   @ingroup hal
+ *   @file
+ *
+ *   Generic arithmetic/conversion routines.
+ *   Copyright &copy; 2005 Stelian Pop.
+ *   Copyright &copy; 2005 Gilles Chanteperdrix.
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
+/**
+ * @addtogroup hal
+ *@{*/
+
+#ifndef _XENO_ASM_GENERIC_ARITH_H
+#define _XENO_ASM_GENERIC_ARITH_H
+
+#ifdef __KERNEL__
+#include <asm/div64.h>
+#else /* !__KERNEL__ */
+static inline unsigned __rthal_do_div(unsigned long long *a, unsigned d)
+{
+	unsigned r = *a % d;
+	*a /= d;
+	return r;
+}
+#define do_div(a, d) __rthal_do_div(&(a), (d))
+#endif /* !__KERNEL__ */
+
+#ifdef __BIG_ENDIAN
+#define endianstruct struct { unsigned _h; unsigned _l; } _s
+#else /* __LITTLE_ENDIAN */
+#define endianstruct struct { unsigned _l; unsigned _h; } _s
+#endif
+
+#ifndef __rthal_u64tou32
+#define __rthal_u64tou32(ull, h, l) ({          \
+    union { unsigned long long _ull;            \
+    endianstruct;                               \
+    } _u;                                       \
+    _u._ull = (ull);                            \
+    (h) = _u._s._h;                             \
+    (l) = _u._s._l;                             \
+})
+#endif /* !__rthal_u64tou32 */
+
+#ifndef __rthal_u64fromu32
+#define __rthal_u64fromu32(h, l) ({             \
+    union { unsigned long long _ull;            \
+    endianstruct;                               \
+    } _u;                                       \
+    _u._s._h = (h);                             \
+    _u._s._l = (l);                             \
+    _u._ull;                                    \
+})
+#endif /* !__rthal_u64fromu32 */
+
+#ifndef rthal_ullmul
+static inline __attribute_const__ unsigned long long
+__rthal_generic_ullmul(const unsigned m0, const unsigned m1)
+{
+    return (unsigned long long) m0 * m1;
+}
+#define rthal_ullmul(m0,m1) __rthal_generic_ullmul((m0),(m1))
+#endif /* !rthal_ullmul */
+
+#ifndef rthal_ulldiv
+static inline unsigned long long __rthal_generic_ulldiv (unsigned long long ull,
+                                                         const unsigned uld,
+                                                         unsigned long *const rp)
+{
+    const unsigned r = do_div(ull, uld);
+
+    if (rp)
+        *rp = r;
+
+    return ull;
+}
+#define rthal_ulldiv(ull,uld,rp) __rthal_generic_ulldiv((ull),(uld),(rp))
+#endif /* !rthal_ulldiv */
+
+#ifndef rthal_uldivrem
+#define rthal_uldivrem(ull,ul,rp) ((unsigned) rthal_ulldiv((ull),(ul),(rp)))
+#endif /* !rthal_uldivrem */
+
+#ifndef rthal_imuldiv
+static inline __attribute_const__ int __rthal_generic_imuldiv (int i,
+                                                               int mult,
+                                                               int div)
+{
+    /* Returns (int)i = (unsigned long long)i*(unsigned)(mult)/(unsigned)div. */
+    const unsigned long long ull = rthal_ullmul(i, mult);
+    return rthal_uldivrem(ull, div, NULL);
+}
+#define rthal_imuldiv(i,m,d) __rthal_generic_imuldiv((i),(m),(d))
+#endif /* !rthal_imuldiv */
+
+#ifndef rthal_llimd
+/* Division of an unsigned 96 bits ((h << 32) + l) by an unsigned 32 bits. 
+   Building block for llimd. Without const qualifiers, gcc reload registers
+   after each call to uldivrem. */
+static inline unsigned long long
+__rthal_generic_div96by32 (const unsigned long long h,
+                           const unsigned l,
+                           const unsigned d,
+                           unsigned long *const rp)
+{
+    unsigned long rh;
+    const unsigned qh = rthal_uldivrem(h, d, &rh);
+    const unsigned long long t = __rthal_u64fromu32(rh, l);
+    const unsigned ql = rthal_uldivrem(t, d, rp);
+
+    return __rthal_u64fromu32(qh, ql);
+}
+
+static inline __attribute_const__
+unsigned long long __rthal_generic_ullimd (const unsigned long long op,
+                                           const unsigned m,
+                                           const unsigned d)
+{
+    unsigned oph, opl, tlh, tll;
+    unsigned long long th, tl;
+
+    __rthal_u64tou32(op, oph, opl);
+    tl = rthal_ullmul(opl, m);
+    __rthal_u64tou32(tl, tlh, tll);
+    th = rthal_ullmul(oph, m);
+    th += tlh;
+
+    return __rthal_generic_div96by32(th, tll, d, NULL);
+}
+
+static inline __attribute_const__ long long __rthal_generic_llimd (long long op,
+                                                                   unsigned m,
+                                                                   unsigned d)
+{
+
+    if(op < 0LL)
+        return -__rthal_generic_ullimd(-op, m, d);
+    return __rthal_generic_ullimd(op, m, d);
+}
+#define rthal_llimd(ll,m,d) __rthal_generic_llimd((ll),(m),(d))
+#endif /* !rthal_llimd */
+
+#define xnarch_ullmod(ull,uld,rem)   ({ xnarch_ulldiv(ull,uld,rem); (*rem); })
+#define xnarch_uldiv(ull, d)         rthal_uldivrem(ull, d, NULL)
+#define xnarch_ulmod(ull, d)         ({ u_long _rem;                    \
+                                        rthal_uldivrem(ull,d,&_rem); _rem; })
+
+#define xnarch_ullmul                rthal_ullmul
+#define xnarch_uldivrem              rthal_uldivrem
+#define xnarch_ulldiv                rthal_ulldiv
+#define xnarch_imuldiv               rthal_imuldiv
+#define xnarch_llimd                 rthal_llimd
+#define xnarch_get_cpu_tsc           rthal_rdtsc
+
+/*@}*/
+
+#endif /* _XENO_ASM_GENERIC_ARITH_H */

Property changes on: include/asm-generic/arith.h
___________________________________________________________________
Name: svn:executable
   + *

Index: include/asm-powerpc/Makefile.in
===================================================================
--- include/asm-powerpc/Makefile.in	(revision 2454)
+++ include/asm-powerpc/Makefile.in	(working copy)
@@ -230,8 +230,8 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 includesubdir = $(includedir)/asm-powerpc
-includesub_HEADERS = atomic.h calibration.h features.h hal.h \
-		syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
 all: all-recursive
Index: include/asm-powerpc/Makefile.am
===================================================================
--- include/asm-powerpc/Makefile.am	(revision 2454)
+++ include/asm-powerpc/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 includesubdir = $(includedir)/asm-powerpc
 
-includesub_HEADERS = atomic.h calibration.h features.h hal.h \
-		syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-powerpc/arith.h
===================================================================
--- include/asm-powerpc/arith.h	(revision 0)
+++ include/asm-powerpc/arith.h	(revision 0)
@@ -0,0 +1,6 @@
+#ifndef _XENO_ASM_POWERPC_ARITH_H
+#define _XENO_ASM_POWERPC_ARITH_H
+
+#include <asm-generic/xenomai/arith.h>
+
+#endif /* _XENO_ASM_POWERPC_ARITH_H */

Property changes on: include/asm-powerpc/arith.h
___________________________________________________________________
Name: svn:executable
   + *

Index: include/asm-arm/Makefile.in
===================================================================
--- include/asm-arm/Makefile.in	(revision 2454)
+++ include/asm-arm/Makefile.in	(working copy)
@@ -230,8 +230,8 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 includesubdir = $(includedir)/asm-arm
-includesub_HEADERS = atomic.h calibration.h features.h hal.h \
-		syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
 all: all-recursive
Index: include/asm-arm/Makefile.am
===================================================================
--- include/asm-arm/Makefile.am	(revision 2454)
+++ include/asm-arm/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 includesubdir = $(includedir)/asm-arm
 
-includesub_HEADERS = atomic.h calibration.h features.h hal.h \
-		syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-arm/arith.h
===================================================================
--- include/asm-arm/arith.h	(revision 0)
+++ include/asm-arm/arith.h	(revision 0)
@@ -0,0 +1,6 @@
+#ifndef _XENO_ASM_ARM_ARITH_H
+#define _XENO_ASM_ARM_ARITH_H
+
+#include <asm-generic/xenomai/arith.h>
+
+#endif /* _XENO_ASM_ARM_ARITH_H */

Property changes on: include/asm-arm/arith.h
___________________________________________________________________
Name: svn:executable
   + *

Index: include/posix/syscall.h
===================================================================
--- include/posix/syscall.h	(revision 2454)
+++ include/posix/syscall.h	(working copy)
@@ -100,6 +100,11 @@
 #define __pse51_condattr_setpshared   74
 #define __pse51_thread_getschedparam  75
 
+typedef struct pse51_sysinfo {
+	unsigned period;
+	unsigned long long wallclock_offset;
+} pse51_sysinfo_t;
+
 #ifdef __KERNEL__
 
 #ifdef __cplusplus
Index: include/asm-i386/Makefile.in
===================================================================
--- include/asm-i386/Makefile.in	(revision 2454)
+++ include/asm-i386/Makefile.in	(working copy)
@@ -230,8 +230,8 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 includesubdir = $(includedir)/asm-i386
-includesub_HEADERS = atomic.h calibration.h features.h \
-		hal.h smi.h switch.h syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h smi.h switch.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
 all: all-recursive
Index: include/asm-i386/Makefile.am
===================================================================
--- include/asm-i386/Makefile.am	(revision 2454)
+++ include/asm-i386/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 includesubdir = $(includedir)/asm-i386
 
-includesub_HEADERS = atomic.h calibration.h features.h \
-		hal.h smi.h switch.h syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h smi.h switch.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-i386/hal.h
===================================================================
--- include/asm-i386/hal.h	(revision 2454)
+++ include/asm-i386/hal.h	(working copy)
@@ -39,71 +39,6 @@
 
 #include <asm/xenomai/wrappers.h>
 
-#define __rthal_u64tou32(ull, h, l) ({          \
-    unsigned long long _ull = (ull);            \
-    (l) = _ull & 0xffffffff;                    \
-    (h) = _ull >> 32;                           \
-})
-
-#define __rthal_u64fromu32(h, l) ({             \
-    unsigned long long _ull;                    \
-    asm ( "": "=A"(_ull) : "d"(h), "a"(l));     \
-    _ull;                                       \
-})
-
-/* const helper for rthal_uldivrem, so that the compiler will eliminate
-   multiple calls with same arguments, at no additionnal cost. */
-static inline __attribute_const__ unsigned long long
-__rthal_uldivrem(const unsigned long long ull, const unsigned long d)
-{
-    unsigned long long ret;
-    __asm__ ("divl %1" : "=A,A"(ret) : "r,?m"(d), "A,A"(ull));
-    /* Exception if quotient does not fit on unsigned long. */
-    return ret;
-}
-
-/* Fast long long division: when the quotient and remainder fit on 32 bits. */
-static inline unsigned long __rthal_i386_uldivrem(unsigned long long ull,
-                                                  const unsigned d,
-                                                  unsigned long *const rp)
-{
-    unsigned long q, r;
-    ull = __rthal_uldivrem(ull, d);
-    __asm__ ( "": "=d"(r), "=a"(q) : "A"(ull));
-    if(rp)
-        *rp = r;
-    return q;
-}
-#define rthal_uldivrem(ull, d, rp) __rthal_i386_uldivrem((ull),(d),(rp))
-
-/* Division of an unsigned 96 bits ((h << 32) + l) by an unsigned 32 bits.
-   Building block for ulldiv. */
-static inline unsigned long long __rthal_div96by32 (const unsigned long long h,
-                                                    const unsigned long l,
-                                                    const unsigned long d,
-                                                    unsigned long *const rp)
-{
-    u_long rh;
-    const u_long qh = rthal_uldivrem(h, d, &rh);
-    const unsigned long long t = __rthal_u64fromu32(rh, l);
-    const u_long ql = rthal_uldivrem(t, d, rp);
-
-    return __rthal_u64fromu32(qh, ql);
-}
-
-/* Slow long long division. Uses rthal_uldivrem, hence has the same property:
-   the compiler removes redundant calls. */
-static inline unsigned long long
-__rthal_i386_ulldiv (const unsigned long long ull,
-                     const unsigned d,
-                     unsigned long *const rp)
-{
-    unsigned long h, l;
-    __rthal_u64tou32(ull, h, l);
-    return __rthal_div96by32(h, l, d, rp);
-}
-#define rthal_ulldiv(ull,d,rp) __rthal_i386_ulldiv((ull),(d),(rp))
-
 #include <asm-generic/xenomai/hal.h>    /* Read the generic bits. */
 
 #ifndef CONFIG_X86_WP_WORKS_OK
Index: include/asm-i386/arith.h
===================================================================
--- include/asm-i386/arith.h	(revision 0)
+++ include/asm-i386/arith.h	(revision 0)
@@ -0,0 +1,107 @@
+/**
+ *   @ingroup hal
+ *   @file
+ *
+ *   Arithmetic/conversion routines for x86.
+ *
+ *   Original RTAI/x86 HAL services from: \n
+ *   Copyright &copy; 2000 Paolo Mantegazza, \n
+ *   Copyright &copy; 2000 Steve Papacharalambous, \n
+ *   Copyright &copy; 2000 Stuart Hughes, \n
+ *   and others.
+ *
+ *   RTAI/x86 rewrite over Adeos: \n
+ *   Copyright &copy; 2002,2003 Philippe Gerum.
+ *   Major refactoring for Xenomai: \n
+ *   Copyright &copy; 2004,2005 Philippe Gerum.
+ *   Arithmetic/conversion routines: \n
+ *   Copyright &copy; 2005 Gilles Chanteperdrix.
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
+#ifndef _XENO_ASM_I386_ARITH_H
+#define _XENO_ASM_I386_ARITH_H
+
+#define __rthal_u64tou32(ull, h, l) ({          \
+    unsigned long long _ull = (ull);            \
+    (l) = _ull & 0xffffffff;                    \
+    (h) = _ull >> 32;                           \
+})
+
+#define __rthal_u64fromu32(h, l) ({             \
+    unsigned long long _ull;                    \
+    asm ( "": "=A"(_ull) : "d"(h), "a"(l));     \
+    _ull;                                       \
+})
+
+/* const helper for rthal_uldivrem, so that the compiler will eliminate
+   multiple calls with same arguments, at no additionnal cost. */
+static inline __attribute_const__ unsigned long long
+__rthal_uldivrem(const unsigned long long ull, const unsigned long d)
+{
+    unsigned long long ret;
+    __asm__ ("divl %1" : "=A,A"(ret) : "r,?m"(d), "A,A"(ull));
+    /* Exception if quotient does not fit on unsigned long. */
+    return ret;
+}
+
+/* Fast long long division: when the quotient and remainder fit on 32 bits. */
+static inline unsigned long __rthal_i386_uldivrem(unsigned long long ull,
+                                                  const unsigned d,
+                                                  unsigned long *const rp)
+{
+    unsigned long q, r;
+    ull = __rthal_uldivrem(ull, d);
+    __asm__ ( "": "=d"(r), "=a"(q) : "A"(ull));
+    if(rp)
+        *rp = r;
+    return q;
+}
+#define rthal_uldivrem(ull, d, rp) __rthal_i386_uldivrem((ull),(d),(rp))
+
+/* Division of an unsigned 96 bits ((h << 32) + l) by an unsigned 32 bits.
+   Building block for ulldiv. */
+static inline unsigned long long __rthal_div96by32 (const unsigned long long h,
+                                                    const unsigned long l,
+                                                    const unsigned long d,
+                                                    unsigned long *const rp)
+{
+    u_long rh;
+    const u_long qh = rthal_uldivrem(h, d, &rh);
+    const unsigned long long t = __rthal_u64fromu32(rh, l);
+    const u_long ql = rthal_uldivrem(t, d, rp);
+
+    return __rthal_u64fromu32(qh, ql);
+}
+
+/* Slow long long division. Uses rthal_uldivrem, hence has the same property:
+   the compiler removes redundant calls. */
+static inline unsigned long long
+__rthal_i386_ulldiv (const unsigned long long ull,
+                     const unsigned d,
+                     unsigned long *const rp)
+{
+    unsigned long h, l;
+    __rthal_u64tou32(ull, h, l);
+    return __rthal_div96by32(h, l, d, rp);
+}
+#define rthal_ulldiv(ull,d,rp) __rthal_i386_ulldiv((ull),(d),(rp))
+
+#include <asm-generic/xenomai/arith.h>
+
+#endif /* _XENO_ASM_I386_ARITH_H */

Property changes on: include/asm-i386/arith.h
___________________________________________________________________
Name: svn:executable
   + *

Index: include/asm-x86_64/Makefile.in
===================================================================
--- include/asm-x86_64/Makefile.in	(revision 2454)
+++ include/asm-x86_64/Makefile.in	(working copy)
@@ -230,8 +230,8 @@
 target_os = @target_os@
 target_vendor = @target_vendor@
 includesubdir = $(includedir)/asm-x86_64
-includesub_HEADERS = atomic.h smi.h switch.h calibration.h features.h \
-		hal.h syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h smi.h switch.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
 all: all-recursive
Index: include/asm-x86_64/Makefile.am
===================================================================
--- include/asm-x86_64/Makefile.am	(revision 2454)
+++ include/asm-x86_64/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 includesubdir = $(includedir)/asm-x86_64
 
-includesub_HEADERS = atomic.h smi.h switch.h calibration.h features.h \
-		hal.h syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = arith.h atomic.h calibration.h features.h fptest.h \
+		hal.h smi.h switch.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-x86_64/arith.h
===================================================================
--- include/asm-x86_64/arith.h	(revision 0)
+++ include/asm-x86_64/arith.h	(revision 0)
@@ -0,0 +1,6 @@
+#ifndef _XENO_ASM_X86_64_ARITH_H
+#define _XENO_ASM_X86_64_ARITH_H
+
+#include <asm-generic/xenomai/arith.h>
+
+#endif /* _XENO_ASM_X86_64_ARITH_H */

Property changes on: include/asm-x86_64/arith.h
___________________________________________________________________
Name: svn:executable
   + *

Index: include/nucleus/shadow.h
===================================================================
--- include/nucleus/shadow.h	(revision 2454)
+++ include/nucleus/shadow.h	(working copy)
@@ -31,6 +31,7 @@
 /* Events sent to the interface callback */
 #define XNSHADOW_CLIENT_ATTACH  0
 #define XNSHADOW_CLIENT_DETACH  1
+#define XNSHADOW_CLIENT_INFO    2
 
 #ifdef __cplusplus
 extern "C" {
Index: src/skins/psos+/init.c
===================================================================
--- src/skins/psos+/init.c	(revision 2454)
+++ src/skins/psos+/init.c	(working copy)
@@ -27,6 +27,7 @@
 {
 	__psos_muxid =
 	    xeno_bind_skin(PSOS_SKIN_MAGIC, "psos", "xeno_psos");
+	__psos_muxid = __xn_mux_shifted_id(__psos_muxid);
 }
 
 void k_fatal(u_long err_code, u_long flags)
Index: src/skins/rtai/init.c
===================================================================
--- src/skins/rtai/init.c	(revision 2454)
+++ src/skins/rtai/init.c	(working copy)
@@ -30,4 +30,5 @@
 {
 	__rtai_muxid =
 	    xeno_bind_skin(RTAI_SKIN_MAGIC, "RTAI", "xeno_rtai");
+	__rtai_muxid = __xn_mux_shifted_id(__rtai_muxid);
 }
Index: src/skins/posix/init.c
===================================================================
--- src/skins/posix/init.c	(revision 2454)
+++ src/skins/posix/init.c	(working copy)
@@ -35,6 +35,7 @@
 static int fork_handler_registered;
 
 int __wrap_pthread_setschedparam(pthread_t, int, const struct sched_param *);
+void pse51_clock_init(int);
 
 static __attribute__ ((constructor))
 void __init_posix_interface(void)
@@ -42,9 +43,15 @@
 	struct sched_param parm;
 	int muxid, err;
 
-	__pse51_muxid =
+	muxid =
 	    xeno_bind_skin(PSE51_SKIN_MAGIC, "POSIX", "xeno_posix");
 
+#ifdef CONFIG_XENO_HW_DIRECT_TSC
+	pse51_clock_init(muxid);
+#endif /* CONFIG_XENO_HW_DIRECT_TSC */
+	
+	__pse51_muxid = __xn_mux_shifted_id(muxid);
+
 	muxid = XENOMAI_SYSBIND(RTDM_SKIN_MAGIC,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, NULL);
 	if (muxid > 0) {
Index: src/skins/posix/clock.c
===================================================================
--- src/skins/posix/clock.c	(revision 2454)
+++ src/skins/posix/clock.c	(working copy)
@@ -20,9 +20,25 @@
 #include <pthread.h>		/* For pthread_setcanceltype. */
 #include <posix/syscall.h>
 #include <time.h>
+#include <asm/xenomai/arith.h>
 
 extern int __pse51_muxid;
 
+#ifdef CONFIG_XENO_HW_DIRECT_TSC
+static xnsysinfo_t sysinfo;
+static pse51_sysinfo_t skininfo;
+
+void pse51_clock_init(int muxid)
+{
+	int err = -XENOMAI_SYSCALL3(__xn_sys_info, muxid, &sysinfo, &skininfo);
+	if (err) {
+		fprintf(stderr, "Xenomai Posix skin init: "
+			"sys_info: %s\n", strerror(err));
+		exit(EXIT_FAILURE);
+	}
+}
+#endif /* CONFIG_XENO_HW_DIRECT_TSC */
+
 int __wrap_clock_getres(clockid_t clock_id, struct timespec *tp)
 {
 	int err = -XENOMAI_SKINCALL2(__pse51_muxid,
@@ -39,11 +55,39 @@
 
 int __wrap_clock_gettime(clockid_t clock_id, struct timespec *tp)
 {
-	int err = -XENOMAI_SKINCALL2(__pse51_muxid,
-				     __pse51_clock_gettime,
-				     clock_id,
-				     tp);
+	int err;
+#ifdef CONFIG_XENO_HW_DIRECT_TSC
+	unsigned long long tsc, ns;
+	switch(clock_id) {
+	case CLOCK_MONOTONIC:
+		tsc = __xn_rdtsc();
+		ns = xnarch_llimd(tsc, 1000000000, sysinfo.cpufreq);
+		tp->tv_sec = ns / 1000000000;
+		tp->tv_nsec = ns % 1000000000;
+		return 0;
 
+	case CLOCK_REALTIME:
+		if (skininfo.period != 1)
+			break;
+
+		tsc = __xn_rdtsc();
+		ns = xnarch_llimd(tsc, 1000000000, sysinfo.cpufreq);
+		ns += skininfo.wallclock_offset;
+		tp->tv_sec = ns / 1000000000;
+		tp->tv_nsec = ns % 1000000000;
+		return 0;
+
+	default:
+		errno = EINVAL;
+		return -1;
+	}
+#endif /* CONFIG_XENO_HW_DIRECT_TSC */
+
+	err = -XENOMAI_SKINCALL2(__pse51_muxid,
+				 __pse51_clock_gettime,
+				 clock_id,
+				 tp);
+
 	if (!err)
 		return 0;
 
Index: src/skins/vrtx/init.c
===================================================================
--- src/skins/vrtx/init.c	(revision 2454)
+++ src/skins/vrtx/init.c	(working copy)
@@ -43,6 +43,7 @@
 
 	__vrtx_muxid =
 	    xeno_bind_skin(VRTX_SKIN_MAGIC, "vrtx", "xeno_vrtx");
+	__vrtx_muxid = __xn_mux_shifted_id(__vrtx_muxid);
 
 	/* Allocate a TSD key for indexing self task pointers. */
 
Index: src/skins/vxworks/init.c
===================================================================
--- src/skins/vxworks/init.c	(revision 2454)
+++ src/skins/vxworks/init.c	(working copy)
@@ -41,6 +41,7 @@
 {
 	__vxworks_muxid = xeno_bind_skin(VXWORKS_SKIN_MAGIC,
 					 "vxworks", "xeno_vxworks");
+	__vxworks_muxid = __xn_mux_shifted_id(__vxworks_muxid);
 
 	/* Allocate a TSD key for indexing self task pointers. */
 
Index: src/skins/native/init.c
===================================================================
--- src/skins/native/init.c	(revision 2454)
+++ src/skins/native/init.c	(working copy)
@@ -42,6 +42,7 @@
 {
 	__native_muxid =
 	    xeno_bind_skin(XENO_SKIN_MAGIC, "native", "xeno_native");
+	__native_muxid = __xn_mux_shifted_id(__native_muxid);
 
 	/* Allocate a TSD key for indexing self task pointers. */
 
Index: src/skins/rtdm/init.c
===================================================================
--- src/skins/rtdm/init.c	(revision 2454)
+++ src/skins/rtdm/init.c	(working copy)
@@ -34,4 +34,6 @@
 
 	__rtdm_muxid =
 		xeno_bind_skin_opt(RTDM_SKIN_MAGIC, "rtdm", "xeno_rtdm");
+	__rtdm_muxid = __xn_mux_shifted_id(__rtdm_muxid);
+
 }
Index: ksrc/skins/posix/syscall.c
===================================================================
--- ksrc/skins/posix/syscall.c	(revision 2454)
+++ ksrc/skins/posix/syscall.c	(working copy)
@@ -2843,6 +2843,7 @@
 
 static void *pse51_eventcb(int event, void *data)
 {
+	pse51_sysinfo_t si;
 	pse51_queues_t *q;
 	
 	switch(event) {
@@ -2890,8 +2891,18 @@
 		xnarch_sysfree(q, sizeof(*q));
 
 		return NULL;
+
+	case XNSHADOW_CLIENT_INFO:
+		if (!__xn_access_ok(current, VERIFY_WRITE, data, sizeof(si)))
+			return ERR_PTR(-EFAULT);
+
+		si.period = xntbase_get_tickval(pse51_tbase);
+		si.wallclock_offset = pse51_tbase->wallclock_offset;
+
+		__xn_copy_to_user(current, data, &si, sizeof(si));
+
+		return 0;
 	}
-	
 	return ERR_PTR(-EINVAL);
 }
 
Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 2454)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1557,10 +1557,14 @@
 
 static int xnshadow_sys_info(struct task_struct *curr, struct pt_regs *regs)
 {
-	/* UNUSED int muxid = __xn_reg_arg1(regs); */
+	int muxid = __xn_reg_arg1(regs);
 	u_long infarg = __xn_reg_arg2(regs);
 	xnsysinfo_t info;
+	void *err;
 
+	if (muxid < 0 || muxid >= XENOMAI_MUX_NR)
+		return -EINVAL;
+
 	if (!__xn_access_ok(curr, VERIFY_WRITE, infarg, sizeof(info)))
 		return -EFAULT;
 
@@ -1568,6 +1572,13 @@
 	info.tickval = xntbase_get_tickval(&nktbase);
 	__xn_copy_to_user(curr, (void *)infarg, &info, sizeof(info));
 
+	if (muxtable[muxid].systab && muxtable[muxid].eventcb) {
+		err = muxtable[muxid].eventcb(XNSHADOW_CLIENT_INFO,
+					      (void *) __xn_reg_arg3(regs));
+		if (IS_ERR(err))
+			return PTR_ERR(err);
+	}
+
 	return 0;
 }
 

--OTdkNzxgGf--

