Message-ID: <44BA5177.4050000@domain.hid>
Date: Sun, 16 Jul 2006 16:47:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
References: <44B62AE7.8080503@domain.hid>	<1152930271.5027.69.camel@domain.hid>	<44B8A1E9.7080004@domain.hid>	<44B8D412.1080002@domain.hid>
	<17593.4142.482000.586615@domain.hid>
	<44BA0A33.6060606@domain.hid>
In-Reply-To: <44BA0A33.6060606@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0D62007D66BAE86EC107239A"
Sender: jan.kiszka@domain.hid
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D62007D66BAE86EC107239A
Content-Type: multipart/mixed; boundary="------------030201090600010804010509"

This is a multi-part message in MIME format.
--------------030201090600010804010509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> Based on this conversion is the optimisation patch -v4. There was
> another quirk hidden in libpthread_rt which binds to RTDM "manually".
> That's now also covered by the patch.

Grr, missing run-quilt-refresh-before-post.

Jan

--------------030201090600010804010509
Content-Type: text/x-patch;
 name="optimise-muxcode-calculation-v4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="optimise-muxcode-calculation-v4.patch"

---
 include/asm-arm/syscall.h      |   29 +++++++++++++++--------------
 include/asm-blackfin/syscall.h |    6 ++++--
 include/asm-i386/syscall.h     |    7 ++++---
 include/asm-ia64/syscall.h     |   25 +++++++++++++------------
 include/asm-powerpc/syscall.h  |    7 ++++---
 include/nucleus/bind.h         |    2 +-
 src/skins/posix/init.c         |    2 +-
 7 files changed, 42 insertions(+), 36 deletions(-)

Index: xenomai/include/asm-arm/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-arm/syscall.h
+++ xenomai/include/asm-arm/syscall.h
@@ -25,7 +25,8 @@
=20
 #include <asm-generic/xenomai/syscall.h>
=20
-#define __xn_mux_code(id,op)    ((op << 24)|((id << 16) & 0xff0000)|(__x=
n_sys_mux & 0xffff))
+#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0xffff))
+#define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000)
=20
 #define XENO_ARM_SYSCALL        0x009F0042	/* carefully chosen... */
=20
@@ -130,20 +131,20 @@ static inline int __xn_interrupted_p(str
 #define __sys2(x)	#x
 #define __sys1(x)	__sys2(x)
=20
-#define XENOMAI_DO_SYSCALL(nr, id, op, args...)			\
-  ({								                    \
-        unsigned long __res;					        \
+#define XENOMAI_DO_SYSCALL(nr, shifted_id, op, args...)		\
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
+	LOADARGS_##nr(__xn_mux_code(shifted_id,op), args);	\
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
@@ -26,7 +26,8 @@
    marker. Note: watch out for the p0 sign convention used by Linux
    (i.e. negative syscall number in orig_p0 meaning "non-syscall
    entry"). */
-#define __xn_mux_code(id,op)   ((id << 24)|((op << 16) & 0xff0000)|(__xn=
_sys_mux & 0xffff))
+#define __xn_mux_code(shifted_id,op) (shifted_id|((op << 16) & 0xff0000)=
|(__xn_sys_mux & 0xffff))
+#define __xn_mux_shifted_id(id) (id << 24)
=20
 /* Local syscalls -- the braindamage thing about this arch is the
    absence of atomic ops usable from user-space; so we export what
@@ -213,7 +214,8 @@ static inline int __xn_interrupted_p(str
   __res;								\
 })
=20
-#define XENOMAI_DO_SYSCALL(nr, id, op, args...)	__emit_syscall##nr(__xn_=
mux_code(id,op), ##args)
+#define XENOMAI_DO_SYSCALL(nr, shifted_id, op, args...) \
+    __emit_syscall##nr(__xn_mux_code(shifted_id,op), ##args)
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
@@ -22,7 +22,8 @@
=20
 #include <asm-generic/xenomai/syscall.h>
=20
-#define __xn_mux_code(id,op)  ((op << 24)|((id << 16) & 0xff0000)|(__xn_=
sys_mux & 0x7fff))
+#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0x7fff))
+#define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000)
=20
 #ifdef __KERNEL__
=20
@@ -165,9 +166,9 @@ asm (".L__X'%ebx =3D 1\n\t"
     : "i" (__xn_mux_code(0,op)) ASMFMT_##nr(args) : "memory", "cc");  \
     (int) resultvar; })
=20
-#define XENOMAI_SKIN_MUX(nr, id, op, args...) \
+#define XENOMAI_SKIN_MUX(nr, shifted_id, op, args...) \
   ({								      \
-    int muxcode =3D __xn_mux_code(id,op);                               =
\
+    int muxcode =3D __xn_mux_code(shifted_id,op);			      \
     unsigned resultvar;						      \
     asm volatile (						      \
     LOADARGS_##nr						      \
Index: xenomai/include/asm-ia64/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-ia64/syscall.h
+++ xenomai/include/asm-ia64/syscall.h
@@ -23,7 +23,8 @@
=20
 #include <asm-generic/xenomai/syscall.h>
=20
-#define __xn_mux_code(id,op)        ((op << 24)|(((id << 16) & 0xff0000U=
L)|(__xn_sys_mux & 0xffffUL)))
+#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0xffffUL))
+#define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000UL)
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
+#define XENOMAI_SKIN_MUX(nr, shifted_id, op, args...)			\
+  ({									\
+    register long _r15 asm ("r15") =3D (__xn_mux_code(shifted_id,op));	\=

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
@@ -25,7 +25,8 @@
=20
 #include <asm-generic/xenomai/syscall.h>
=20
-#define __xn_mux_code(id,op)        ((op << 24)|((id << 16) & 0xff0000)|=
(__xn_sys_mux & 0xffff))
+#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0xffff))
+#define __xn_mux_shifted_id(id) ((id << 16) & 0xff0000)
=20
 #ifdef __KERNEL__
=20
@@ -123,7 +124,7 @@ static inline int __xn_interrupted_p(str
 #define ASM_INPUT_4 ASM_INPUT_3, "4" (__sc_6)
 #define ASM_INPUT_5 ASM_INPUT_4, "5" (__sc_7)
=20
-#define XENOMAI_DO_SYSCALL(nr, id, op, args...)			\
+#define XENOMAI_DO_SYSCALL(nr, shifted_id, op, args...)		\
   ({								\
 	register unsigned long __sc_0  __asm__ ("r0");		\
 	register unsigned long __sc_3  __asm__ ("r3");		\
@@ -132,7 +133,7 @@ static inline int __xn_interrupted_p(str
 	register unsigned long __sc_6  __asm__ ("r6");		\
 	register unsigned long __sc_7  __asm__ ("r7");		\
 								\
-	LOADARGS_##nr(__xn_mux_code(id,op), args);		\
+	LOADARGS_##nr(__xn_mux_code(shifted_id,op), args);	\
 	__asm__ __volatile__					\
 		("sc           \n\t"				\
 		 "mfcr %0      "				\
Index: xenomai/include/nucleus/bind.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/bind.h
+++ xenomai/include/nucleus/bind.h
@@ -101,7 +101,7 @@ xeno_user_skin_init(unsigned skin_magic,
     }
 #endif /* !XNSKIN_NO_MLOCK_ALERT */
=20
-    return muxid;
+    return __xn_mux_shifted_id(muxid);
 }
=20
 #endif /* _XENO_NUCLEUS_BIND_H */
Index: xenomai/src/skins/posix/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/init.c
+++ xenomai/src/skins/posix/init.c
@@ -45,7 +45,7 @@ void __init_posix_interface(void)
 	muxid =3D XENOMAI_SYSBIND(RTDM_SKIN_MAGIC,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, NULL);
 	if (muxid > 0) {
-		__rtdm_muxid =3D muxid;
+		__rtdm_muxid =3D __xn_mux_shifted_id(muxid);
 		__rtdm_fd_start =3D FD_SETSIZE - XENOMAI_SKINCALL0(__rtdm_muxid,
 								 __rtdm_fdcount);
 	}

--------------030201090600010804010509--

--------------enig0D62007D66BAE86EC107239A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEulF3niDOoMHTA+kRAm4XAJ9JewD2J58J37K8nBzZdMt2C100ZQCfeC3I
I0HBVbaaQZaJUMa/GCSMzN0=
=Tt0u
-----END PGP SIGNATURE-----

--------------enig0D62007D66BAE86EC107239A--

