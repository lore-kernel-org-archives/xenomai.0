Message-ID: <44B62AE7.8080503@domain.hid>
Date: Thu, 13 Jul 2006 13:13:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig05404E555FD4E8BEB6512726"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
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
--------------enig05404E555FD4E8BEB6512726
Content-Type: multipart/mixed; boundary="------------000602020703030407030704"

This is a multi-part message in MIME format.
--------------000602020703030407030704
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

some may recall the "micro-optimisation" thread I once started. Here is
now a simple approach to deal with the yet suboptimal mux-code
calculation in user-space. Code saving:

Before:
   text    data     bss     dec     hex filename
  18004     476       8   18488    4838 native/.libs/libnative.so
  27445     696       4   28145    6df1 posix/.libs/libpthread_rt.so

After:
   text    data     bss     dec     hex filename
  17172     476       8   17656    44f8 native/.libs/libnative.so
  26805     696       4   27505    6b71 posix/.libs/libpthread_rt.so

Of course, this also results in a few ops less being executed on each
Xenomai syscall invocation (not many cycles, though).

Tested without problems on x86 so far.

Jan

--------------000602020703030407030704
Content-Type: text/plain;
 name="optimise-muxcode-calculation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="optimise-muxcode-calculation.patch"

---
 include/asm-arm/syscall.h      |   25 +++++++++++++------------
 include/asm-blackfin/syscall.h |    4 +++-
 include/asm-i386/syscall.h     |    3 ++-
 include/asm-ia64/syscall.h     |   23 ++++++++++++-----------
 include/asm-powerpc/syscall.h  |    3 ++-
 ksrc/nucleus/shadow.c          |    3 ++-
 6 files changed, 34 insertions(+), 27 deletions(-)

Index: xenomai/include/asm-arm/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-arm/syscall.h
+++ xenomai/include/asm-arm/syscall.h
@@ -26,6 +26,7 @@
 #include <asm-generic/xenomai/syscall.h>
=20
 #define __xn_mux_code(id,op)    ((op << 24)|((id << 16) & 0xff0000)|(__x=
n_sys_mux & 0xffff))
+#define __xn_mux_code_shft(shifted_id,op) ((op << 24)|shifted_id|(__xn_s=
ys_mux & 0xffff))
=20
 #define XENO_ARM_SYSCALL        0x009F0042	/* carefully chosen... */
=20
@@ -131,19 +132,19 @@ static inline int __xn_interrupted_p(str
 #define __sys1(x)	__sys2(x)
=20
 #define XENOMAI_DO_SYSCALL(nr, id, op, args...)			\
-  ({								                    \
-        unsigned long __res;					        \
+  ({								\
+        unsigned long __res;					\
 	register unsigned long __res_r0 __asm__ ("r0");		\
-   	ASM_INDECL_##nr;					                \
-								                        \
-	LOADARGS_##nr(__xn_mux_code(id,op), args);		    \
-	__asm__ __volatile__ (					            \
-"       swi " __sys1(XENO_ARM_SYSCALL)			        \
-		: "=3Dr" (__res_r0)				                \
-		: ASM_INPUT_##nr				                \
-		: "memory");					                \
-   	__res =3D __res_r0;					                \
-   	(int) __res;						                \
+   	ASM_INDECL_##nr;					\
+								\
+	LOADARGS_##nr(__xn_mux_code_shft(id,op), args);		\
+	__asm__ __volatile__ (					\
+"       swi " __sys1(XENO_ARM_SYSCALL)				\
+		: "=3Dr" (__res_r0)				\
+		: ASM_INPUT_##nr				\
+		: "memory");					\
+   	__res =3D __res_r0;					\
+   	(int) __res;						\
   })
=20
 #define XENOMAI_SYSCALL0(op)                XENOMAI_DO_SYSCALL(0,0,op)
Index: xenomai/include/asm-blackfin/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-blackfin/syscall.h
+++ xenomai/include/asm-blackfin/syscall.h
@@ -27,6 +27,7 @@
    (i.e. negative syscall number in orig_p0 meaning "non-syscall
    entry"). */
 #define __xn_mux_code(id,op)   ((id << 24)|((op << 16) & 0xff0000)|(__xn=
_sys_mux & 0xffff))
+#define __xn_mux_code_fast(shifted_id,op) ((op << 24)|shifted_id|(__xn_s=
ys_mux & 0xffff))
=20
 /* Local syscalls -- the braindamage thing about this arch is the
    absence of atomic ops usable from user-space; so we export what
@@ -213,7 +214,8 @@ static inline int __xn_interrupted_p(str
   __res;								\
 })
=20
-#define XENOMAI_DO_SYSCALL(nr, id, op, args...)	__emit_syscall##nr(__xn_=
mux_code(id,op), ##args)
+#define XENOMAI_DO_SYSCALL(nr, id, op, args...) \
+    __emit_syscall##nr(__xn_mux_code_shft(id,op), ##args)
=20
 #define XENOMAI_SYSCALL0(op)                XENOMAI_DO_SYSCALL(0,0,op)
 #define XENOMAI_SYSCALL1(op,a1)             XENOMAI_DO_SYSCALL(1,0,op,a1=
)
Index: xenomai/include/asm-i386/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-i386/syscall.h
+++ xenomai/include/asm-i386/syscall.h
@@ -23,6 +23,7 @@
 #include <asm-generic/xenomai/syscall.h>
=20
 #define __xn_mux_code(id,op)  ((op << 24)|((id << 16) & 0xff0000)|(__xn_=
sys_mux & 0x7fff))
+#define __xn_mux_code_shft(shifted_id,op) ((op << 24)|shifted_id|(__xn_s=
ys_mux & 0x7fff))
=20
 #ifdef __KERNEL__
=20
@@ -167,7 +168,7 @@ asm (".L__X'%ebx =3D 1\n\t"
=20
 #define XENOMAI_SKIN_MUX(nr, id, op, args...) \
   ({								      \
-    int muxcode =3D __xn_mux_code(id,op);                               =
\
+    int muxcode =3D __xn_mux_code_shft(id,op);			      \
     unsigned resultvar;						      \
     asm volatile (						      \
     LOADARGS_##nr						      \
Index: xenomai/include/asm-ia64/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-ia64/syscall.h
+++ xenomai/include/asm-ia64/syscall.h
@@ -24,6 +24,7 @@
 #include <asm-generic/xenomai/syscall.h>
=20
 #define __xn_mux_code(id,op)        ((op << 24)|(((id << 16) & 0xff0000U=
L)|(__xn_sys_mux & 0xffffUL)))
+#define __xn_mux_code_shft(shifted_id,op) ((op << 24)|shifted_id|(__xn_s=
ys_mux & 0xffffUL))
=20
 #ifdef __KERNEL__
=20
@@ -151,17 +152,17 @@ static inline int __xn_interrupted_p(str
   /* Branch registers.  */						\
   "b6", "b7"
=20
-#define XENOMAI_SKIN_MUX(nr, id, op, args...)                   \
-  ({                                                            \
-    register long _r15 asm ("r15") =3D (__xn_mux_code(id,op));    \
-    register long _retval asm ("r8");                           \
-    register long err asm ("r10");                              \
-    LOAD_ARGS_##nr (args);                                      \
-    __asm __volatile ("break %3;;\n\t"                          \
-                      : "=3Dr" (_retval), "=3Dr" (_r15), "=3Dr" (err) \
-                      : "i" (__BREAK_SYSCALL), "1" (_r15)       \
-			ASM_ARGS_##nr                           \
-                      : "memory" ASM_CLOBBERS_##nr);            \
+#define XENOMAI_SKIN_MUX(nr, id, op, args...)				\
+  ({									\
+    register long _r15 asm ("r15") =3D (__xn_mux_code_shft(id,op));	\
+    register long _retval asm ("r8");					\
+    register long err asm ("r10");					\
+    LOAD_ARGS_##nr (args);						\
+    __asm __volatile ("break %3;;\n\t"					\
+		      : "=3Dr" (_retval), "=3Dr" (_r15), "=3Dr" (err)		\
+		      : "i" (__BREAK_SYSCALL), "1" (_r15)		\
+			ASM_ARGS_##nr					\
+		      : "memory" ASM_CLOBBERS_##nr);			\
     err < 0 ? -_retval : _retval; })
=20
 #define XENOMAI_SYS_MUX(nr, op, args...) XENOMAI_SKIN_MUX(nr, 0, op , ##=
args)
Index: xenomai/include/asm-powerpc/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-powerpc/syscall.h
+++ xenomai/include/asm-powerpc/syscall.h
@@ -26,6 +26,7 @@
 #include <asm-generic/xenomai/syscall.h>
=20
 #define __xn_mux_code(id,op)        ((op << 24)|((id << 16) & 0xff0000)|=
(__xn_sys_mux & 0xffff))
+#define __xn_mux_code_shft(shifted_id,op) ((op << 24)|shifted_id|(__xn_s=
ys_mux & 0xffff))
=20
 #ifdef __KERNEL__
=20
@@ -132,7 +133,7 @@ static inline int __xn_interrupted_p(str
 	register unsigned long __sc_6  __asm__ ("r6");		\
 	register unsigned long __sc_7  __asm__ ("r7");		\
 								\
-	LOADARGS_##nr(__xn_mux_code(id,op), args);		\
+	LOADARGS_##nr(__xn_mux_code_shft(id,op), args);		\
 	__asm__ __volatile__					\
 		("sc           \n\t"				\
 		 "mfcr %0      "				\
Index: xenomai/ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -1187,7 +1187,8 @@ static int xnshadow_sys_bind(struct task
 		return err;
 	}
=20
-	return muxid;
+	/* return pre-shifted muxid - saves some cycles in user-space */
+	return __xn_mux_code(muxid,0);
 }
=20
 static int xnshadow_sys_info(struct task_struct *curr, struct pt_regs *r=
egs)


--------------000602020703030407030704--

--------------enig05404E555FD4E8BEB6512726
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEtirnniDOoMHTA+kRAs3dAJ40B6ZTC4gFKidkpvUGuD+fttX41wCfRRo2
yGNaw/fADP3f8I4kjmqHAZM=
=RBv7
-----END PGP SIGNATURE-----

--------------enig05404E555FD4E8BEB6512726--

