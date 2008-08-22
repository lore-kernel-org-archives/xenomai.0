Message-ID: <48AEE39A.2070801@domain.hid>
Date: Fri, 22 Aug 2008 18:04:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/2] Add x86_64 fastsem support
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
Cc: xenomai-core <xenomai@xenomai.org>

As the subject says. Passed your unit_mutex test, nothing else tried
yet, weekend is calling.

---
 configure.in                |    1 +
 include/asm-x86/atomic_64.h |   31 +++++++++++++++++++++++++++++--
 ksrc/arch/x86/Kconfig       |    2 +-
 3 files changed, 31 insertions(+), 3 deletions(-)

Index: b/configure.in
===================================================================
--- a/configure.in
+++ b/configure.in
@@ -103,6 +103,7 @@ case "$host" in
 	XENO_TARGET_ARCH=x86
         XENO_LINUX_ARCH=x86_64
 	XENO_LINUX_INSTALL_TARGET=install
+	CONFIG_XENO_FASTSEM=y
         ;;
  *) echo ""
    echo "*******************************************"
Index: b/include/asm-x86/atomic_64.h
===================================================================
--- a/include/asm-x86/atomic_64.h
+++ b/include/asm-x86/atomic_64.h
@@ -21,6 +21,10 @@
 #define _XENO_ASM_X86_ATOMIC_64_H
 #define _XENO_ASM_X86_ATOMIC_H
 
+#include <asm/xenomai/features.h>
+
+typedef unsigned long atomic_flags_t;
+
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
@@ -50,10 +54,20 @@ typedef atomic64_t xnarch_atomic_t;
 
 #else /* !__KERNEL__ */
 
-#include <asm/xenomai/features.h>
+#ifdef CONFIG_SMP
+#define LOCK_PREFIX "lock ; "
+#else
+#define LOCK_PREFIX ""
+#endif
+
+typedef struct { unsigned long counter; } xnarch_atomic_t;
 
 #define __xeno_xg(x) ((volatile long *)(x))
 
+#define xnarch_atomic_get(v)		((v)->counter)
+
+#define xnarch_atomic_set(v,i)		(((v)->counter) = (i))
+
 static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
 						unsigned long x)
 {
@@ -64,12 +78,25 @@ static inline unsigned long xnarch_atomi
 	return x;
 }
 
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
 #define xnarch_memory_barrier()		asm volatile("mfence":::"memory")
 #define xnarch_read_memory_barrier()	asm volatile("lfence":::"memory")
 #define xnarch_write_memory_barrier()	xnarch_memory_barrier()
 
 #endif /* __KERNEL__ */
 
-typedef unsigned long atomic_flags_t;
+#include <asm-generic/xenomai/atomic.h>
 
 #endif /* !_XENO_ASM_X86_ATOMIC_64_H */
Index: b/ksrc/arch/x86/Kconfig
===================================================================
--- a/ksrc/arch/x86/Kconfig
+++ b/ksrc/arch/x86/Kconfig
@@ -4,7 +4,7 @@ config XENO_GENERIC_STACKPOOL
 
 config XENO_FASTSEM
 	bool
-	default y if X86_32
+	default y
 
 source "kernel/xenomai/nucleus/Kconfig"
 

