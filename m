From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hv1b3MzRlo"
Content-Transfer-Encoding: 7bit
Message-ID: <17351.50625.229758.938503@domain.hid>
Date: Fri, 13 Jan 2006 16:22:41 +0100
Subject: [Xenomai-core] [patch] factoring arithmetic routines.
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


--hv1b3MzRlo
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi,

For your review, here is an attempt to factor arithmetic routines in
asm-generic/hal.h.

I am not sure the way I did it is the best one.
Maybe defining some HAVE_ARCH symbols, would have been better.
Maybe moving the definitions in asm-generic/system.h would have been
better than the #defines before #include for side effects.
I am not to pleased with the double definition of div96by32 either.

Please feel free to comment, insult, etc...

-- 


					    Gilles Chanteperdrix.

--hv1b3MzRlo
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-arith.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-arm/hal.h
===================================================================
--- include/asm-arm/hal.h	(revision 453)
+++ include/asm-arm/hal.h	(working copy)
@@ -29,12 +29,6 @@
 #ifndef _XENO_ASM_ARM_HAL_H
 #define _XENO_ASM_ARM_HAL_H
 
-#include <asm-generic/xenomai/hal.h>	/* Read the generic bits. */
-#include <asm/div64.h>
-#include <asm/byteorder.h>
-
-typedef unsigned long long rthal_time_t;
-
 #ifdef __BIG_ENDIAN
 #define endianstruct struct { u_long _h; u_long _l; } _s
 #else /* __LITTLE_ENDIAN */
@@ -50,72 +44,12 @@
     (l) = _u._s._l;                             \
 })
 
-#define __rthal_u64fromu32(h, l) ({             \
-    union { unsigned long long _ull;            \
-    endianstruct;                               \
-    } _u;                                       \
-    _u._s._h = (h);                             \
-    _u._s._l = (l);                             \
-    _u._ull;                                    \
-})
+#include <asm-generic/xenomai/hal.h>	/* Read the generic bits. */
+#include <asm/div64.h>
+#include <asm/byteorder.h>
 
-static inline unsigned long long rthal_ullmul(const unsigned long m0,
-                                              const unsigned long m1)
-{
-    return (unsigned long long) m0 * m1;
-}
+typedef unsigned long long rthal_time_t;
 
-static inline unsigned long long rthal_ulldiv (unsigned long long ull,
-                                               const unsigned long uld,
-                                               unsigned long *const rp)
-{
-    unsigned long r = do_div(ull, uld);
-
-    if (rp)
-    	*rp = r;
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
 #if __LINUX_ARM_ARCH__ < 5
 static inline __attribute_const__ unsigned long ffnz (unsigned long x) {
 	int r = 0;
Index: include/asm-generic/hal.h
===================================================================
--- include/asm-generic/hal.h	(revision 453)
+++ include/asm-generic/hal.h	(working copy)
@@ -38,6 +38,8 @@
 #include <linux/interrupt.h>
 #include <linux/kallsyms.h>
 #include <linux/init.h>
+#include <asm/byteorder.h>
+#include <asm/div64.h>
 #include <asm/xenomai/wrappers.h>
 
 #define RTHAL_DOMAIN_ID		0x58454e4f
@@ -278,6 +280,124 @@
 
 #define rthal_printk	printk
 
+#ifdef __BIG_ENDIAN
+#define endianstruct struct { u_long _h; u_long _l; } _s
+#else /* __LITTLE_ENDIAN */
+#define endianstruct struct { u_long _l; u_long _h; } _s
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
+    const unsigned long r = do_div(ull, uld);
+
+    if (rp)
+        *rp = r;
+
+    return ull;
+}
+#define rthal_ulldiv(ull,uld,rp) __rthal_generic_ulldiv((ull),(uld),(rp))
+#endif /* !rthal_ulldiv */
+
+/* Another implementation of ulldiv, used to be defined on x86. */
+#define rthal_u64div32c(ull,uld,rp) rthal_ulldiv((ull),(uld),(rp))
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
+                           const unsigned long l,
+                           const unsigned long d,
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
 typedef ipipe_irq_handler_t rthal_irq_handler_t;
 typedef ipipe_irq_ackfn_t   rthal_irq_ackfn_t;
 
Index: include/asm-i386/hal.h
===================================================================
--- include/asm-i386/hal.h	(revision 453)
+++ include/asm-i386/hal.h	(working copy)
@@ -37,14 +37,6 @@
 #ifndef _XENO_ASM_I386_HAL_H
 #define _XENO_ASM_I386_HAL_H
 
-#include <asm-generic/xenomai/hal.h>    /* Read the generic bits. */
-
-#ifndef CONFIG_X86_WP_WORKS_OK
-#error "Xenomai has to rely on the WP bit, CONFIG_M486 or better required"
-#endif /* CONFIG_X86_WP_WORKS_OK */
-
-typedef unsigned long long rthal_time_t;
-
 #define __rthal_u64tou32(ull, h, l) ({          \
     unsigned long long _ull = (ull);            \
     (l) = _ull & 0xffffffff;                    \
@@ -57,13 +49,6 @@
     _ull;                                       \
 })
 
-/* Fast longs multiplication. */
-static inline __attribute_const__ unsigned long long
-rthal_ullmul(unsigned long m1, unsigned long m2) {
-    /* Gcc (at least for versions 2.95 and higher) optimises correctly here. */
-    return (unsigned long long) m1 * m2;
-}
-
 /* const helper for rthal_uldivrem, so that the compiler will eliminate
    multiple calls with same arguments, at no additionnal cost. */
 static inline __attribute_const__ unsigned long long
@@ -75,23 +60,12 @@
     return ret;
 }
 
-static inline __attribute_const__ int rthal_imuldiv (const int i,
-                                                     const int mult,
-                                                     const int div) {
 
-    /* Returns (unsigned)i =
-               (unsigned long long)i*(unsigned)(mult)/(unsigned)div. */
-    const unsigned long ui = (const unsigned long) i;
-    const unsigned long um = (const unsigned long) mult;
-    return __rthal_uldivrem((const unsigned long long) ui * um, div);
-}
+/* Fast long long division: when the quotient and remainder fit on 32 bits. */
+static inline unsigned long __rthal_i386_uldivrem(unsigned long long ull,
+                                                  const unsigned d,
+                                                  unsigned long *const rp) {
 
-/* Fast long long division: when the quotient and remainder fit on 32 bits.
-   Recent compilers remove redundant calls to this function. */
-static inline unsigned long rthal_uldivrem(unsigned long long ull,
-                                           const unsigned long d,
-                                           unsigned long *const rp) {
-
     unsigned long q, r;
     ull = __rthal_uldivrem(ull, d);
     __asm__ ( "": "=d"(r), "=a"(q) : "A"(ull));
@@ -99,10 +73,10 @@
         *rp = r;
     return q;
 }
+#define rthal_uldivrem(ull, d, rp) __rthal_i386_uldivrem((ull),(d),(rp))
 
-
 /* Division of an unsigned 96 bits ((h << 32) + l) by an unsigned 32 bits.
-   Common building block for ulldiv and llimd. */
+   Building block for ulldiv. */
 static inline unsigned long long __rthal_div96by32 (const unsigned long long h,
                                                     const unsigned long l,
                                                     const unsigned long d,
@@ -116,53 +90,27 @@
     return __rthal_u64fromu32(qh, ql);
 }
 
-
 /* Slow long long division. Uses rthal_uldivrem, hence has the same property:
    the compiler removes redundant calls. */
-static inline unsigned long long rthal_ulldiv (const unsigned long long ull,
-                                               const unsigned long d,
-                                               unsigned long *const rp) {
+static inline unsigned long long
+__rthal_i386_ulldiv (const unsigned long long ull,
+                     const unsigned d,
+                     unsigned long *const rp) {
 
     unsigned long h, l;
     __rthal_u64tou32(ull, h, l);
     return __rthal_div96by32(h, l, d, rp);
 }
+#define rthal_ulldiv(ull,d,rp) __rthal_i386_ulldiv((ull),(d),(rp))
 
-/* Replaced the helper with rthal_ulldiv. */
-#define rthal_u64div32c rthal_ulldiv
+#include <asm-generic/xenomai/hal.h>    /* Read the generic bits. */
 
-static inline __attribute_const__
-unsigned long long __rthal_ullimd (const unsigned long long op,
-                                   const unsigned long m,
-                                   const unsigned long d) {
+#ifndef CONFIG_X86_WP_WORKS_OK
+#error "Xenomai has to rely on the WP bit, CONFIG_M486 or better required"
+#endif /* CONFIG_X86_WP_WORKS_OK */
 
-    unsigned long long th, tl;
-    u_long oph, opl, tlh, tll;
+typedef unsigned long long rthal_time_t;
 
-    __rthal_u64tou32(op, oph, opl);
-    tl = (unsigned long long) opl * m;
-    __rthal_u64tou32(tl, tlh, tll);
-    th = (unsigned long long) oph * m;
-    /* op * m == ((th + tlh) << 32) + tll */
-
-    __asm__ (  "addl %1, %%eax\n\t"
-               "adcl $0, %%edx"
-               : "=A,A"(th)
-               : "r,?m"(tlh), "A,A"(th) );
-    /* op * m == (th << 32) + tll */
-
-    return __rthal_div96by32(th, tll, d, NULL);
-}
-
-static inline __attribute_const__ long long rthal_llimd (const long long op,
-                                                         const unsigned long m,
-                                                         const unsigned long d) {
-
-    if(op < 0LL)
-        return -__rthal_ullimd(-op, m, d);
-    return __rthal_ullimd(op, m, d);
-}
-
 static inline __attribute_const__ unsigned long ffnz (unsigned long ul) {
     /* Derived from bitops.h's ffs() */
     __asm__("bsfl %1, %0"
Index: include/asm-ia64/hal.h
===================================================================
--- include/asm-ia64/hal.h	(revision 453)
+++ include/asm-ia64/hal.h	(working copy)
@@ -31,76 +31,6 @@
 
 typedef unsigned long long rthal_time_t;
 
-#define __rthal_u64tou32(ull, h, l) ({          \
-    unsigned long long _ull = (ull);            \
-    (l) = _ull & 0xffffffff;                    \
-    (h) = _ull >> 32;                           \
-})
-
-#define __rthal_u64fromu32(h, l) ({             \
-    (((unsigned long long) (h)) << 32) + (l);   \
-})
-
-static inline unsigned long long rthal_ullmul(const unsigned m0, 
-                                              const unsigned m1)
-{
-    return (unsigned long long) m0 * m1;
-}
-
-static inline unsigned long long rthal_ulldiv (unsigned long long ull,
-                                               const unsigned uld,
-                                               unsigned long *const rp)
-{
-    const unsigned long long result = ull / uld;
-
-    if (rp)
-        *rp = ull % uld;
-
-    return result;
-}
-
-#define rthal_uldivrem(ull,ul,rp) ((u_long) rthal_ulldiv((ull),(ul),(rp)))
-
-static inline __attribute_const__ int rthal_imuldiv (const int i,
-                                                     const int mult,
-                                                     const int div) {
-
-    /* Returns (int)i = (unsigned long long)i*(u_long)(mult)/(u_long)div. */
-    const unsigned long long ull = rthal_ullmul(i, mult);
-    return rthal_uldivrem(ull, div, NULL);
-}
-
-static inline __attribute_const__
-unsigned long long __rthal_ullimd (const unsigned long long op,
-                                   const unsigned m,
-                                   const unsigned d)
-{
-    unsigned oph, opl, tlh, tll, qh, ql;
-    unsigned long long th, tl;
-    unsigned long rh;
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
-                                     unsigned m,
-                                     unsigned d)
-{
-
-    if(op < 0LL)
-        return -__rthal_ullimd(-op, m, d);
-    return __rthal_ullimd(op, m, d);
-}
-
 static inline __attribute_const__ unsigned long ffnz (unsigned long ul)
 {
     unsigned long r;
Index: include/asm-powerpc/hal.h
===================================================================
--- include/asm-powerpc/hal.h	(revision 453)
+++ include/asm-powerpc/hal.h	(working copy)
@@ -30,89 +30,9 @@
 #define _XENO_ASM_POWERPC_HAL_H
 
 #include <asm-generic/xenomai/hal.h>	/* Read the generic bits. */
-#include <asm/div64.h>
 
 typedef unsigned long long rthal_time_t;
 
-#define __rthal_u64tou32(ull, h, l) ({                          \
-        union { unsigned long long _ull;                        \
-            struct { unsigned _h; unsigned _l; } _s; } _u;      \
-        _u._ull = (ull);                                        \
-        (h) = _u._s._h;                                         \
-        (l) = _u._s._l;                                         \
-        })
-
-#define __rthal_u64fromu32(h, l) ({                             \
-        union { unsigned long long _ull;                        \
-            struct { unsigned _h; unsigned _l; } _s; } _u;      \
-        _u._s._h = (h);                                         \
-        _u._s._l = (l);                                         \
-        _u._ull;                                                \
-        })
-
-static inline unsigned long long rthal_ullmul(const unsigned m0, 
-					      const unsigned m1)
-{
-    return (unsigned long long) m0 * m1;
-}
-
-static inline unsigned long long rthal_ulldiv (unsigned long long ull,
-					       const unsigned uld,
-					       unsigned long *const rp)
-{
-#if BITS_PER_LONG == 32
-    const unsigned long r = __div64_32(&ull, uld);
-#else /* BITS_PER_LONG == 64 */
-    const unsigned long r = ull % uld;
-    ull /= uld;
-#endif
-
-    if (rp)
-	*rp = r;
-
-    return ull;
-}
-
-#define rthal_uldivrem(ull,ul,rp) ((u_long) rthal_ulldiv((ull),(ul),(rp)))
-
-static inline __attribute_const__ int rthal_imuldiv (int i, int mult, int div) {
-
-    /* Returns (int)i = (unsigned long long)i*(u_long)(mult)/(u_long)div. */
-    const unsigned long long ull = rthal_ullmul(i, mult);
-    return rthal_uldivrem(ull, div, NULL);
-}
-
-static inline __attribute_const__
-unsigned long long __rthal_ullimd (const unsigned long long op,
-                                   const unsigned m,
-                                   const unsigned d)
-{
-    unsigned oph, opl, tlh, tll, qh, ql;
-    unsigned long long th, tl;
-    unsigned long rh;
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
-                                     unsigned m,
-                                     unsigned d)
-{
-
-    if(op < 0LL)
-        return -__rthal_ullimd(-op, m, d);
-    return __rthal_ullimd(op, m, d);
-}
-
 static inline __attribute_const__ unsigned long ffnz (unsigned long ul) {
 #ifdef CONFIG_PPC64
     __asm__ ("cntlzd %0, %1" : "=r" (ul) : "r" (ul & (-ul)));

--hv1b3MzRlo--

