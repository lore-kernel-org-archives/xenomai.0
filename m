Message-ID: <45487FF1.5090402@domain.hid>
Date: Wed, 01 Nov 2006 12:07:29 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090000080903020003010809"
Subject: [Xenomai-core] [PATCH] removing atomic_xchg from
	incluce/asm-poerpc/atomic.h
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

This is a multi-part message in MIME format.
--------------090000080903020003010809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch fixes:

2006-11-01  Wolfgang Grandegger  <wg@domain.hid>
        * include/asm-powerpc/atomic.h: remove atomic_xch because it's
        used in the kernel since 2.6.18 with different arguments (pointer
        of type atomic_t).

Wolfgang.

--------------090000080903020003010809
Content-Type: text/x-patch;
 name="xenomai-powerpc-atomic-xchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-powerpc-atomic-xchg.patch"

Index: include/asm-powerpc/atomic.h
===================================================================
--- include/asm-powerpc/atomic.h	(revision 1785)
+++ include/asm-powerpc/atomic.h	(working copy)
@@ -30,9 +30,7 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15) 
-#define atomic_xchg(ptr,v)       xchg(ptr,v)
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15) */ 
+#define xnarch_atomic_xchg(ptr,v)  xchg(ptr,v)
 #define xnarch_memory_barrier()  smp_mb()
 
 #ifdef CONFIG_PPC64
@@ -159,7 +157,7 @@
     return x;
 }
 
-#define atomic_xchg(ptr,x) \
+#define xnarch_atomic_xchg(ptr,x) \
     ({                                                                         \
 	__typeof__(*(ptr)) _x_ = (x);                                          \
 	(__typeof__(*(ptr))) __xchg((ptr), (unsigned long)_x_, sizeof(*(ptr)));\
@@ -171,8 +169,6 @@
 
 #endif /* __KERNEL__ */
 
-#define xnarch_atomic_xchg(ptr,v)   atomic_xchg(ptr,v)
-
 typedef unsigned long atomic_flags_t;
 
 #endif /* !_XENO_ASM_POWERPC_ATOMIC_H */
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1785)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2006-11-01  Wolfgang Grandegger  <wg@domain.hid>
+	* include/asm-powerpc/atomic.h: remove atomic_xch because it's
+	used in the kernel since 2.6.18 with different arguments (pointer
+	of type atomic_t).
+
 2006-10-31  Philippe Gerum  <rpm@xenomai.org>
 
 	* include/asm-i386/wrappers.h: Add accessors to the IRQ descriptor

--------------090000080903020003010809--

