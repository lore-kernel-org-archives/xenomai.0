Message-ID: <44B8D412.1080002@domain.hid>
Date: Sat, 15 Jul 2006 13:40:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
References: <44B62AE7.8080503@domain.hid> <1152930271.5027.69.camel@domain.hid>
	<44B8A1E9.7080004@domain.hid>
In-Reply-To: <44B8A1E9.7080004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEC5B769BBED2893C8B96FEDD"
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
To: rpm@xenomai.org, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEC5B769BBED2893C8B96FEDD
Content-Type: multipart/mixed; boundary="------------090106030905020402050608"

This is a multi-part message in MIME format.
--------------090106030905020402050608
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> Ok, I will rework this patch.
>=20

And here is -v2 (for post 2.2 trunk). It keeps the ABI but changes the
API wrt __xeno_mux_code. As this change gets widely caught by
xeno_user_skin_init, the modifications are limited.

At this chance I also converted the rtdm library to the generic
initialisation code. I tweaked nucleus/bind.h a bit so that one can
control via XENO_DISABLE_MLOCKALL_DETECTION if the related code gets
built into the lib. This appeared to be reasonable to me because librtdm
doesn't create its own RT threads, thus the check should be better left
to those skins who do so. Anyone any better idea, or is this acceptable?
If a separate patch is preferred, I will break out this change.

Tested of x86, other archs need review and/or testing.

Jan

--------------090106030905020402050608
Content-Type: text/plain;
 name="optimise-muxcode-calculation-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="optimise-muxcode-calculation-v2.patch"

---
 include/asm-arm/syscall.h      |   29 ++++++++++++------------
 include/asm-blackfin/syscall.h |    6 +++--
 include/asm-i386/syscall.h     |    7 +++--
 include/asm-ia64/syscall.h     |   25 ++++++++++----------
 include/asm-powerpc/syscall.h  |    7 +++--
 include/nucleus/bind.h         |   19 ++++++++++-----
 src/skins/rtdm/init.c          |   49 +++-------------------------------=
-------
 7 files changed, 56 insertions(+), 86 deletions(-)

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
+#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0xffff))
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
@@ -9,6 +9,7 @@
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
=20
+#ifndef XENO_DISABLE_MLOCKALL_DETECTION
 __attribute__((weak)) int xeno_sigxcpu_no_mlock =3D 1;
=20
 static void  xeno_handle_mlock_alert (int sig)
@@ -34,11 +35,11 @@ static void  xeno_handle_mlock_alert (in
 	pthread_kill(pthread_self(),SIGXCPU);
 	}
 }
+#endif /* !XENO_DISABLE_MLOCKALL_DETECTION */
=20
 static inline int
 xeno_user_skin_init(unsigned skin_magic, const char *skin, const char *m=
odule)
 {
-    struct sigaction sa;
     xnfeatinfo_t finfo;
     int muxid;
=20
@@ -80,15 +81,19 @@ xeno_user_skin_init(unsigned skin_magic,
         exit(1);
         }
=20
+#ifndef XENO_DISABLE_MLOCKALL_DETECTION
     /* Install a SIGXCPU handler to intercept alerts about unlocked
        process memory. */
+    {
+        struct sigaction sa;
+        sa.sa_handler =3D &xeno_handle_mlock_alert;
+        sigemptyset(&sa.sa_mask);
+        sa.sa_flags =3D 0;
+        sigaction(SIGXCPU,&sa,NULL);
+    }
+#endif /* !XENO_DISABLE_MLOCKALL_DETECTION */
=20
-    sa.sa_handler =3D &xeno_handle_mlock_alert;
-    sigemptyset(&sa.sa_mask);
-    sa.sa_flags =3D 0;
-    sigaction(SIGXCPU,&sa,NULL);
-
-    return muxid;
+    return __xn_mux_shifted_id(muxid);
 }
=20
 #endif /* _XENO_NUCLEUS_BIND_H */
Index: xenomai/src/skins/rtdm/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/rtdm/init.c
+++ xenomai/src/skins/rtdm/init.c
@@ -20,6 +20,9 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+
+#define XENO_DISABLE_MLOCKALL_DETECTION
+#include <nucleus/bind.h>
 #include <rtdm/syscall.h>
=20
 int __rtdm_muxid =3D -1;
@@ -27,49 +30,5 @@ int __rtdm_muxid =3D -1;
 static __attribute__((constructor)) void __init_rtdm_interface(void)
=20
 {
-    xnfeatinfo_t finfo;
-    int muxid;
-
-#ifdef xeno_arch_features_check
-    xeno_arch_features_check();
-#endif /* xeno_arch_features_check */
-
-    muxid =3D XENOMAI_SYSBIND(RTDM_SKIN_MAGIC,
-			    XENOMAI_FEAT_DEP,
-			    XENOMAI_ABI_REV,
-			    &finfo);
-    switch (muxid)
-	{
-	case -EINVAL:
-
-	    fprintf(stderr,"Xenomai: incompatible feature set\n");
-	    fprintf(stderr,"(required=3D\"%s\", present=3D\"%s\", missing=3D\"%=
s\").\n",
-		    finfo.feat_man_s,finfo.feat_all_s,finfo.feat_mis_s);
-	    exit(1);
-
-	case -ENOEXEC:
-
-	    fprintf(stderr,"Xenomai: incompatible ABI revision level\n");
-	    fprintf(stderr,"(needed=3D%lu, current=3D%lu).\n",
-		    XENOMAI_ABI_REV,finfo.abirev);
-	    exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-	    /* we ignore this and fail later when the user tries to open
-	       a device or socket. */
-	    break;
-
-	default:
-
-	    if (muxid < 0)
-		{
-		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
-		exit(1);
-		}
-
-	    __rtdm_muxid =3D muxid;
-	    break;
-	}
+    __rtdm_muxid =3D xeno_user_skin_init(RTDM_SKIN_MAGIC, "rtdm", "xeno_=
rtdm");
 }


--------------090106030905020402050608--

--------------enigEC5B769BBED2893C8B96FEDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEuNQXniDOoMHTA+kRAnb+AJ4oIZDHZkurEmFUTA+WKfJaJxP99wCdFCvR
1vBwNM7e4n1Yv1gUK7ozwB0=
=7U0X
-----END PGP SIGNATURE-----

--------------enigEC5B769BBED2893C8B96FEDD--

