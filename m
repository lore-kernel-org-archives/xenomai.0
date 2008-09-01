Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48BBB22E.3070101@domain.hid>
Message-ID: <48BBABA1.1010608@domain.hid>
Date: Mon, 01 Sep 2008 10:45:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48BBA9E6.5070400@domain.hid>
In-Reply-To: <48BBA9E6.5070400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 3/9] Remove xnarch_atomic_intptr wrappers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

No more users, no more use cases in sight, let's get rid of it.

---
 include/asm-arm/atomic.h        |    3 ---
 include/asm-blackfin/atomic.h   |    2 --
 include/asm-generic/Makefile.am |    2 +-
 include/asm-generic/Makefile.in |    2 +-
 include/asm-generic/atomic.h    |   24 ------------------------
 include/asm-ia64/atomic.h       |    2 --
 include/asm-powerpc/atomic.h    |    2 --
 include/asm-x86/atomic.h        |    2 --
 8 files changed, 2 insertions(+), 37 deletions(-)

Index: b/include/asm-arm/atomic.h
===================================================================
--- a/include/asm-arm/atomic.h
+++ b/include/asm-arm/atomic.h
@@ -412,9 +412,6 @@ static __inline__ void xnarch_atomic_cle
 
 typedef unsigned long atomic_flags_t;
 
-/* Add support for xnarch_atomic_intptr_t */
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_ARM_ATOMIC_H */
 
 // vim: ts=4 et sw=4 sts=4
Index: b/include/asm-blackfin/atomic.h
===================================================================
--- a/include/asm-blackfin/atomic.h
+++ b/include/asm-blackfin/atomic.h
@@ -42,8 +42,6 @@
 typedef atomic_t atomic_counter_t;
 typedef atomic_t xnarch_atomic_t;
 
-#include <asm-generic/xenomai/atomic.h>
-
 #else /* !__KERNEL__ */
 
 #include <asm/xenomai/syscall.h>
Index: b/include/asm-generic/Makefile.am
===================================================================
--- a/include/asm-generic/Makefile.am
+++ b/include/asm-generic/Makefile.am
@@ -1,5 +1,5 @@
 includesubdir = $(includedir)/asm-generic
 
-includesub_HEADERS = arith.h atomic.h features.h hal.h syscall.h system.h wrappers.h
+includesub_HEADERS = arith.h features.h hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: b/include/asm-generic/Makefile.in
===================================================================
--- a/include/asm-generic/Makefile.in
+++ b/include/asm-generic/Makefile.in
@@ -226,7 +226,7 @@ target_vendor = @target_vendor@
 top_builddir = @top_builddir@
 top_srcdir = @top_srcdir@
 includesubdir = $(includedir)/asm-generic
-includesub_HEADERS = arith.h atomic.h features.h hal.h syscall.h system.h wrappers.h
+includesub_HEADERS = arith.h features.h hal.h syscall.h system.h wrappers.h
 SUBDIRS = bits
 all: all-recursive
 
Index: b/include/asm-generic/atomic.h
===================================================================
--- a/include/asm-generic/atomic.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#ifndef _XENO_ASM_GENERIC_ATOMIC_H
-#define _XENO_ASM_GENERIC_ATOMIC_H
-
-typedef xnarch_atomic_t xnarch_atomic_intptr_t;
-
-static inline void *xnarch_atomic_intptr_get(xnarch_atomic_intptr_t *l)
-{
-        xnarch_atomic_t *v = (xnarch_atomic_t *)l;
-
-        return (void *)xnarch_atomic_get(v);
-}
-
-static inline void xnarch_atomic_intptr_set(xnarch_atomic_intptr_t *l, void *i)
-{
-        xnarch_atomic_t *v = (xnarch_atomic_t *)l;
-
-        xnarch_atomic_set(v, (long)i);
-}
-
-#define xnarch_atomic_intptr_cmpxchg(l, old, newval) \
-        (void *)(xnarch_atomic_cmpxchg((xnarch_atomic_t *)(l), \
-				       (long)(old), (long)(newval)))
-
-#endif /* _XENO_ASM_GENERIC_ATOMIC_H */
Index: b/include/asm-ia64/atomic.h
===================================================================
--- a/include/asm-ia64/atomic.h
+++ b/include/asm-ia64/atomic.h
@@ -71,8 +71,6 @@ static inline void atomic_clear_mask(uns
 #define xnarch_atomic_cmpxchg(pcounter,old,new) \
 	cmpxchg((&(pcounter)->counter),(old),(new))
 
-#include <asm-generic/xenomai/atomic.h>
-
 #else /* !__KERNEL__ */
 
 #include <asm/xenomai/features.h>
Index: b/include/asm-powerpc/atomic.h
===================================================================
--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -262,6 +262,4 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *p
 
 typedef unsigned long atomic_flags_t;
 
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_POWERPC_ATOMIC_H */
Index: b/include/asm-x86/atomic.h
===================================================================
--- a/include/asm-x86/atomic.h
+++ b/include/asm-x86/atomic.h
@@ -136,6 +136,4 @@ xnarch_atomic_cmpxchg(xnarch_atomic_t *v
 
 #endif /* __KERNEL__ */
 
-#include <asm-generic/xenomai/atomic.h>
-
 #endif /* !_XENO_ASM_X86_ATOMIC_64_H */


