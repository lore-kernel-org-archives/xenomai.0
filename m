From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.10037.181558.14996@domain.hid>
Date: Thu, 24 Apr 2008 08:22:45 +0200
In-Reply-To: <18448.9967.355128.570111@domain.hid>
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
	<18448.9967.355128.570111@domain.hid>
Subject: [Xenomai-core] [3/9] Define more atomic operations in user-space
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


This patch implements the _read, _set, and _cmpxchg operations on atomic_long_t
and atomic_ptr_t in user-space in include/asm-generic/atomic.h which should be
included at the end of include/asm-*/atomic.h after the definition of the same
operations for the atomic_t type and atomic64_t type on 64 bits platforms.

These operations are the basic operations used by user-space mutexes. Maybe we
should add the xnarch_ prefix ?

---
 Makefile.am |    2 -
 atomic.h    |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

Index: include/asm-generic/atomic.h
===================================================================
--- include/asm-generic/atomic.h	(revision 0)
+++ include/asm-generic/atomic.h	(revision 0)
@@ -0,0 +1,68 @@
+#ifndef ATOMIC_H
+#define ATOMIC_H
+
+#ifndef __KERNEL__
+#include <bits/wordsize.h>
+#if __WORDSIZE == 64
+typedef atomic64_t atomic_long_t;
+
+static inline long atomic_long_read(atomic_long_t *l)
+{
+        atomic64_t *v = (atomic64_t *)l;
+
+        return (long)atomic64_read(v);
+}
+
+static inline void atomic_long_set(atomic_long_t *l, long i)
+{
+        atomic64_t *v = (atomic64_t *)l;
+
+        atomic64_set(v, i);
+}
+
+#define atomic_long_cmpxchg(l, old, new) \
+        (atomic64_cmpxchg((atomic64_t *)(l), (old), (new)))
+
+#else /* __WORDSIZE == 32 */
+typedef atomic_t atomic_long_t;
+
+static inline long atomic_long_read(atomic_long_t *l)
+{
+        atomic_t *v = (atomic_t *)l;
+
+        return (long)atomic_read(v);
+}
+
+static inline void atomic_long_set(atomic_long_t *l, long i)
+{
+        atomic_t *v = (atomic_t *)l;
+
+        atomic_set(v, i);
+}
+
+#define atomic_long_cmpxchg(l, old, new) \
+        (atomic_cmpxchg((atomic_t *)(l), (old), (new)))
+#endif /* __WORDSIZE == 32 */
+#endif /* __KERNEL__ */
+
+typedef atomic_long_t atomic_ptr_t;
+
+static inline void *atomic_ptr_read(atomic_ptr_t *l)
+{
+        atomic_long_t *v = (atomic_long_t *)l;
+
+        return (void *)atomic_long_read(v);
+}
+
+static inline void atomic_ptr_set(atomic_ptr_t *l, void *i)
+{
+        atomic_long_t *v = (atomic_long_t *)l;
+
+        atomic_long_set(v, (long)i);
+}
+
+#define atomic_ptr_cmpxchg(l, old, new) \
+        (void *)(atomic_long_cmpxchg((atomic_long_t *)(l), \
+                                     (long)(old), (long)(new)))
+
+#endif /* ATOMIC_H */
Index: include/asm-generic/Makefile.am
===================================================================
--- include/asm-generic/Makefile.am	(revision 3718)
+++ include/asm-generic/Makefile.am	(working copy)
@@ -1,5 +1,5 @@
 includesubdir = $(includedir)/asm-generic
 
-includesub_HEADERS = arith.h features.h hal.h syscall.h system.h wrappers.h
+includesub_HEADERS = arith.h features.h hal.h syscall.h system.h wrappers.h atomic.h
 
 SUBDIRS = bits

-- 


					    Gilles.

