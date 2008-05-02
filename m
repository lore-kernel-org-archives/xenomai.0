From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18459.38558.684426.240775@domain.hid>
Date: Sat, 3 May 2008 00:33:02 +0200
In-Reply-To: <18459.38500.720338.652195@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
	<18459.38500.720338.652195@domain.hid>
Subject: [Xenomai-core] [Patch 3/7] Define more atomic operations in
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


This patch now only implement the _get, _set and _cmpxchg operations for the new
xnarch_atomic_intptr_t type. Since xnarch_atomic_t is now a long type, the
atomic_long_t is no longer needed.

---
 Makefile.am |    2 +-
 atomic.h    |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

Index: include/asm-generic/atomic.h
===================================================================
--- include/asm-generic/atomic.h	(revision 0)
+++ include/asm-generic/atomic.h	(revision 0)
@@ -0,0 +1,24 @@
+#ifndef _XENO_ASM_GENERIC_ATOMIC_H
+#define _XENO_ASM_GENERIC_ATOMIC_H
+
+typedef xnarch_atomic_t xnarch_atomic_intptr_t;
+
+static inline void *xnarch_atomic_intptr_get(xnarch_atomic_intptr_t *l)
+{
+        xnarch_atomic_t *v = (xnarch_atomic_t *)l;
+
+        return (void *)xnarch_atomic_get(v);
+}
+
+static inline void xnarch_atomic_intptr_set(xnarch_atomic_intptr_t *l, void *i)
+{
+        xnarch_atomic_t *v = (xnarch_atomic_t *)l;
+
+        xnarch_atomic_set(v, (long)i);
+}
+
+#define xnarch_atomic_intptr_cmpxchg(l, old, new) \
+        (void *)(xnarch_atomic_cmpxchg((xnarch_atomic_t *)(l), \
+				       (long)(old), (long)(new)))
+
+#endif /* _XENO_ASM_GENERIC_ATOMIC_H */
Index: include/asm-generic/Makefile.am
===================================================================
--- include/asm-generic/Makefile.am	(revision 3738)
+++ include/asm-generic/Makefile.am	(working copy)
@@ -1,5 +1,5 @@
 includesubdir = $(includedir)/asm-generic
 
-includesub_HEADERS = arith.h features.h hal.h syscall.h system.h wrappers.h
+includesub_HEADERS = arith.h atomic.h features.h hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits

-- 


					    Gilles.

