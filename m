Message-ID: <43666F8E.4030902@domain.hid>
Date: Mon, 31 Oct 2005 20:25:02 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFFEC86CC2F161EFBF6FEEF2E"
Subject: [Xenomai-core] [RFC] overcome kernel headers in userspace
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFFEC86CC2F161EFBF6FEEF2E
Content-Type: multipart/mixed; boundary="------------080106040602090906080104"

This is a multi-part message in MIME format.
--------------080106040602090906080104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I started some first proof-of-concept to get rid of all kernel header
inclusions in user space. Here is a patch which so far only addresses
asm-inclusion and the i386 architecture. It may have side effects, I
didn't tested it (except compilation).

Anyway, I hope to hear some comments if this direction makes sense. And
I'm looking for suggestions how to distribute correct LDFLAGS. I hacked
XENO_ARCH_FLAGS into the makefiles, but I think this is only correct for
the internal libtool-based linking (which seems to invoke ld via gcc).
Where to get the input for "xeno-config --xeno-ldflags" from?

Jan

--------------080106040602090906080104
Content-Type: text/plain;
 name="no_kernel_headers.hack"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="no_kernel_headers.hack"

Index: include/nucleus/asm-generic/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/asm-generic/syscall.h	(Revision 87)
+++ include/nucleus/asm-generic/syscall.h	(Arbeitskopie)
@@ -51,6 +51,7 @@ typedef struct xninquiry {
 #ifdef __KERNEL__
=20
 #include <linux/types.h>
+#include <asm/ptrace.h>
=20
 struct task_struct;
=20
Index: include/nucleus/asm-i386/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/asm-i386/syscall.h	(Revision 87)
+++ include/nucleus/asm-i386/syscall.h	(Arbeitskopie)
@@ -21,7 +21,6 @@
 #define _XENO_ASM_I386_SYSCALL_H
=20
 #include <xeno_config.h>
-#include <asm/ptrace.h>
 #include <nucleus/asm-generic/syscall.h>
=20
 #ifndef __KERNEL__
Index: include/nucleus/asm-i386/atomic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/asm-i386/atomic.h	(Revision 87)
+++ include/nucleus/asm-i386/atomic.h	(Arbeitskopie)
@@ -20,16 +20,27 @@
 #ifndef _XENO_ASM_I386_ATOMIC_H
 #define _XENO_ASM_I386_ATOMIC_H
=20
-#include <linux/bitops.h>
+typedef unsigned long atomic_flags_t;
=20
 #ifdef __KERNEL__
=20
 #include <asm/atomic.h>
 #include <asm/system.h>
+#include <linux/bitops.h>
=20
-#define atomic_xchg(ptr,v)       xchg(ptr,v)
-#define atomic_cmpxchg(ptr,o,n)  cmpxchg(ptr,o,n)
-#define xnarch_memory_barrier()  smp_mb()
+typedef atomic_t atomic_counter_t;
+
+#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
+#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
+#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
+#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
+#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcoun=
ter)
+#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcoun=
ter)
+#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pfla=
gs)
+#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pf=
lags)
+#define xnarch_atomic_xchg(ptr,x)              xchg(ptr,v)
+#define xnarch_atomic_cmpxchg(ptr,o,n)         cmpxchg(ptr,o,n)
+#define xnarch_memory_barrier()                smp_mb()
=20
 #else /* !__KERNEL__ */
=20
@@ -41,28 +52,80 @@
 #define unlikely(x)	__builtin_expect(!!(x), 0)
 #endif /* !likely */
=20
-#include <asm/atomic.h>
+typedef struct { volatile int counter; } atomic_counter_t;
=20
 struct __xeno_xchg_dummy { unsigned long a[100]; };
 #define __xeno_xg(x) ((struct __xeno_xchg_dummy *)(x))
=20
-static inline unsigned long atomic_xchg (volatile void *ptr,
-					 unsigned long x)
+#define LOCK "lock ; "
+
+#define xnarch_atomic_set(v,i)                 (((v)->counter) =3D (i))
+
+#define xnarch_atomic_get(v)                   ((v)->counter)
+
+static __inline__ void xnarch_atomic_inc(atomic_counter_t *v)
+{
+	__asm__ __volatile__(
+		LOCK "incl %0"
+		:"=3Dm" (v->counter)
+		:"m" (v->counter));
+}
+
+static __inline__ void xnarch_atomic_dec(atomic_counter_t *v)
+{
+	__asm__ __volatile__(
+		LOCK "decl %0"
+		:"=3Dm" (v->counter)
+		:"m" (v->counter));
+}
+
+static __inline__ int xnarch_atomic_inc_and_test(atomic_counter_t *v)
 {
-    __asm__ __volatile__(LOCK_PREFIX "xchgl %0,%1"
+	unsigned char c;
+
+	__asm__ __volatile__(
+		LOCK "incl %0; sete %1"
+		:"=3Dm" (v->counter), "=3Dqm" (c)
+		:"m" (v->counter) : "memory");
+	return c !=3D 0;
+}
+
+static __inline__ int xnarch_atomic_dec_and_test(atomic_counter_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		LOCK "decl %0; sete %1"
+		:"=3Dm" (v->counter), "=3Dqm" (c)
+		:"m" (v->counter) : "memory");
+	return c !=3D 0;
+}
+
+#define xnarch_atomic_set_mask(addr,mask) \
+__asm__ __volatile__(LOCK "orl %0,%1" \
+: : "r" (mask),"m" (*(addr)) : "memory")
+
+#define xnarch_atomic_clear_mask(addr,mask) \
+__asm__ __volatile__(LOCK "andl %0,%1" \
+: : "r" (~(mask)),"m" (*addr) : "memory")
+
+static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
+						unsigned long x)
+{
+    __asm__ __volatile__(LOCK "xchgl %0,%1"
 			 :"=3Dr" (x)
 			 :"m" (*__xeno_xg(ptr)), "0" (x)
 			 :"memory");
     return x;
 }
=20
-static inline unsigned long atomic_cmpxchg (volatile void *ptr,
-					    unsigned long o,
-					    unsigned long n)
+static inline unsigned long xnarch_atomic_cmpxchg (volatile void *ptr,
+						   unsigned long o,
+						   unsigned long n)
 {
     unsigned long prev;
=20
-    __asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
+    __asm__ __volatile__(LOCK "cmpxchgl %1,%2"
 			 : "=3Da"(prev)
 			 : "q"(n), "m" (*__xeno_xg(ptr)), "0" (o)
 			 : "memory");
@@ -77,18 +140,4 @@ static inline unsigned long atomic_cmpxc
=20
 #endif /* __KERNEL__ */
=20
-typedef atomic_t atomic_counter_t;
-typedef unsigned long atomic_flags_t;
-
-#define xnarch_atomic_set(pcounter,i)          atomic_set(pcounter,i)
-#define xnarch_atomic_get(pcounter)            atomic_read(pcounter)
-#define xnarch_atomic_inc(pcounter)            atomic_inc(pcounter)
-#define xnarch_atomic_dec(pcounter)            atomic_dec(pcounter)
-#define xnarch_atomic_inc_and_test(pcounter)   atomic_inc_and_test(pcoun=
ter)
-#define xnarch_atomic_dec_and_test(pcounter)   atomic_dec_and_test(pcoun=
ter)
-#define xnarch_atomic_set_mask(pflags,mask)    atomic_set_mask(mask,pfla=
gs)
-#define xnarch_atomic_clear_mask(pflags,mask)  atomic_clear_mask(mask,pf=
lags)
-
-#define xnarch_atomic_xchg(ptr,x) atomic_xchg(ptr,x)
-
 #endif /* !_XENO_ASM_I386_ATOMIC_H */
Index: include/nucleus/asm-i386/calibration.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/asm-i386/calibration.h	(Revision 87)
+++ include/nucleus/asm-i386/calibration.h	(Arbeitskopie)
@@ -21,6 +21,9 @@
 #define _XENO_ASM_I386_CALIBRATION_H
=20
 #include <xeno_config.h>
+#ifndef __KERNEL__
+# warning Including kernel header from user space!
+#endif
 #include <asm/processor.h>
=20
 #define __bogomips (current_cpu_data.loops_per_jiffy/(500000/HZ))
Index: configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- configure.in	(Revision 87)
+++ configure.in	(Arbeitskopie)
@@ -1352,12 +1352,7 @@ AC_MSG_RESULT([done])
 AC_MSG_CHECKING([for target architecture])
=20
=20
-XENO_USER_CFLAGS=3D"-I$XENO_LINUX_SRCDIR/include -D_GNU_SOURCE -D_REENTR=
ANT -D__XENO__"
-if test x"$XENO_LINUX_DIR" !=3D x"$XENO_LINUX_SRCDIR"; then
-  XENO_USER_CFLAGS=3D"-I$XENO_LINUX_DIR/include2 $XENO_USER_CFLAGS"
-  XENO_USER_CFLAGS=3D"-I$XENO_LINUX_DIR/include $XENO_USER_CFLAGS"
-fi
-XENO_USER_CFLAGS=3D"$XENO_USER_CFLAGS $XENO_ARCH_FLAGS"
+XENO_USER_CFLAGS=3D"-D_GNU_SOURCE -D_REENTRANT -D__XENO__  $XENO_ARCH_FL=
AGS"
=20
 case $XENO_TARGET_ARCH in
  i386)
@@ -1442,6 +1437,7 @@ AC_SUBST(XENO_KMOD_CFLAGS)
 AC_SUBST(XENO_USER_CFLAGS)
 AC_SUBST(XENO_KMOD_APP_CFLAGS)
 AC_SUBST(XENO_USER_APP_CFLAGS)
+AC_SUBST(XENO_ARCH_FLAGS)
 AC_SUBST(XENO_FP_CFLAGS)
 AC_SUBST(XENO_LINUX_DIR)
 AC_SUBST(XENO_LINUX_VERSION)
Index: skins/posix/lib/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/posix/lib/GNUmakefile.am	(Revision 87)
+++ skins/posix/lib/GNUmakefile.am	(Arbeitskopie)
@@ -2,7 +2,9 @@ includedir =3D $(prefix)/include/posix
=20
 lib_LTLIBRARIES =3D libpthread_rt.la
=20
-libpthread_rt_la_LDFLAGS =3D -module -version-info 0:0:0
+libpthread_rt_la_LDFLAGS =3D \
+	-module -version-info 0:0:0 \
+	@XENO_ARCH_FLAGS@
=20
 libpthread_rt_la_SOURCES =3D \
 	init.c \
Index: skins/native/lib/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/native/lib/GNUmakefile.am	(Revision 87)
+++ skins/native/lib/GNUmakefile.am	(Arbeitskopie)
@@ -1,6 +1,8 @@
 lib_LTLIBRARIES =3D libnative.la
=20
-libnative_la_LDFLAGS =3D -module -version-info 0:0:0
+libnative_la_LDFLAGS =3D \
+	-module -version-info 0:0:0 \
+	@XENO_ARCH_FLAGS@
=20
 libnative_la_SOURCES =3D \
 	init.c \
Index: skins/rtdm/lib/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/rtdm/lib/GNUmakefile.am	(Revision 87)
+++ skins/rtdm/lib/GNUmakefile.am	(Arbeitskopie)
@@ -1,6 +1,8 @@
 lib_LTLIBRARIES =3D librtdm.la
=20
-librtdm_la_LDFLAGS =3D -module -version-info 0:0:0
+librtdm_la_LDFLAGS =3D \
+	-module -version-info 0:0:0 \
+	@XENO_ARCH_FLAGS@
=20
 librtdm_la_SOURCES =3D \
 	core.c \
Index: skins/rtdm/rtserial.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/rtdm/rtserial.h	(Revision 87)
+++ skins/rtdm/rtserial.h	(Arbeitskopie)
@@ -77,7 +77,12 @@
 #ifndef _RTSERIAL_H
 #define _RTSERIAL_H
=20
-#include <asm/types.h>
+#ifdef __KERNEL__
+# include <asm/types.h>
+#else
+# include <sys/types.h>
+#endif
+
 #include <rtdm/rtdm.h>
=20
 /*!
@@ -270,13 +275,13 @@ typedef struct rtser_config {
                                  *   @ref RTSER_xxx_HAND */
     int     fifo_depth;         /**< reception FIFO interrupt threshold,=
 see
                                  *   @ref RTSER_FIFO_xxx */
-    __s64   rx_timeout;         /**< reception timeout in ns, see
+    int64_t rx_timeout;         /**< reception timeout in ns, see
                                  *   @ref RTSER_TIMEOUT_xxx for special
                                  *   values */
-    __s64   tx_timeout;         /**< transmission timeout in ns, see
+    int64_t tx_timeout;         /**< transmission timeout in ns, see
                                  *   @ref RTSER_TIMEOUT_xxx for special
                                  *   values */
-    __s64   event_timeout;      /**< event timeout in ns, see
+    int64_t event_timeout;      /**< event timeout in ns, see
                                  *   @ref RTSER_TIMEOUT_xxx for special
                                  *   values */
     int     timestamp_history;  /**< enable timestamp history, see
@@ -303,9 +308,9 @@ typedef struct rtser_event {
     int     events;             /**< signalled events, see
                                  *   @ref RTSER_EVENT_xxx */
     int     rx_pending;         /**< number of pending input characters =
*/
-    __u64   last_timestamp;     /**< last interrupt timestamp (absolute =
time
+    uint64_t last_timestamp;    /**< last interrupt timestamp (absolute =
time
                                  *   in ns) */
-    __u64   rxpend_timestamp;   /**< reception timestamp (absolute time =
in ns)
+    uint64_t rxpend_timestamp;  /**< reception timestamp (absolute time =
in ns)
                                  *   of oldest character in input queue =
*/
 } rtser_event_t;
=20
Index: skins/uvm/lib/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- skins/uvm/lib/GNUmakefile.am	(Revision 87)
+++ skins/uvm/lib/GNUmakefile.am	(Arbeitskopie)
@@ -1,6 +1,8 @@
 lib_LTLIBRARIES =3D libuvm.la
=20
-libuvm_la_LDFLAGS =3D -module -version-info 0:0:0
+libuvm_la_LDFLAGS =3D \
+	-module -version-info 0:0:0 \
+	@XENO_ARCH_FLAGS@
=20
 libuvm_la_SOURCES =3D \
 	init.c \
Index: testsuite/latency/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- testsuite/latency/GNUmakefile.am	(Revision 87)
+++ testsuite/latency/GNUmakefile.am	(Arbeitskopie)
@@ -10,6 +10,8 @@ latency_CPPFLAGS =3D \
 	-I$(top_srcdir)/skins \
 	-I../../include
=20
+latency_LDFLAGS =3D @XENO_ARCH_FLAGS@
+
 latency_LDADD =3D \
 	../../skins/native/lib/libnative.la \
 	-lpthread -lm
Index: testsuite/switch/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- testsuite/switch/GNUmakefile.am	(Revision 87)
+++ testsuite/switch/GNUmakefile.am	(Arbeitskopie)
@@ -10,6 +10,8 @@ switch_CPPFLAGS =3D \
 	-I$(top_srcdir)/skins \
 	-I../../include
=20
+switch_LDFLAGS =3D @XENO_ARCH_FLAGS@
+
 switch_LDADD =3D \
 	../../skins/native/lib/libnative.la \
 	-lpthread
Index: testsuite/cruncher/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- testsuite/cruncher/GNUmakefile.am	(Revision 87)
+++ testsuite/cruncher/GNUmakefile.am	(Arbeitskopie)
@@ -17,7 +17,7 @@ cruncher_CFLAGS =3D \
 	@XENO_USER_CFLAGS@ \
 	-funroll-loops
=20
-cruncher_LDFLAGS =3D $(posix_wrappers)
+cruncher_LDFLAGS =3D $(posix_wrappers) @XENO_ARCH_FLAGS@
=20
 cruncher_LDADD =3D \
 	../../skins/posix/lib/libpthread_rt.la \
Index: testsuite/klatency/GNUmakefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- testsuite/klatency/GNUmakefile.am	(Revision 87)
+++ testsuite/klatency/GNUmakefile.am	(Arbeitskopie)
@@ -28,6 +28,8 @@ latency_CPPFLAGS =3D \
 	-I$(top_srcdir)/skins \
 	-I../../include
=20
+latency_LDFLAGS =3D @XENO_ARCH_FLAGS@
+
 latency_LDADD =3D \
 	-lpthread -lm
=20

--------------080106040602090906080104--

--------------enigFFEC86CC2F161EFBF6FEEF2E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDZm+OncNeS9Q0k+IRAos/AKC26Qy2iYWzX9zBaSHgHu0ezuqV7ACg3Vzz
85lILTOWF5qOLkJ6m7V8uFs=
=OS8k
-----END PGP SIGNATURE-----

--------------enigFFEC86CC2F161EFBF6FEEF2E--

