Message-ID: <44BA0A33.6060606@domain.hid>
Date: Sun, 16 Jul 2006 11:43:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] optimise syscall mux-code calculation
References: <44B62AE7.8080503@domain.hid>	<1152930271.5027.69.camel@domain.hid>	<44B8A1E9.7080004@domain.hid>	<44B8D412.1080002@domain.hid>
	<17593.4142.482000.586615@domain.hid>
In-Reply-To: <17593.4142.482000.586615@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A90020EAD73C850049665F8"
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
--------------enig4A90020EAD73C850049665F8
Content-Type: multipart/mixed; boundary="------------090104080209030004070400"

This is a multi-part message in MIME format.
--------------090104080209030004070400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Jan Kiszka wrote:
>  > > ...
>  > > Ok, I will rework this patch.
>  > >=20
>  >=20
>  > And here is -v2 (for post 2.2 trunk). It keeps the ABI but changes t=
he
>  > API wrt __xeno_mux_code. As this change gets widely caught by
>  > xeno_user_skin_init, the modifications are limited.
>  >=20
>  > At this chance I also converted the rtdm library to the generic
>  > initialisation code. I tweaked nucleus/bind.h a bit so that one can
>  > control via XENO_DISABLE_MLOCKALL_DETECTION if the related code gets=

>  > built into the lib. This appeared to be reasonable to me because lib=
rtdm
>  > doesn't create its own RT threads, thus the check should be better l=
eft
>  > to those skins who do so. Anyone any better idea, or is this accepta=
ble?
>  > If a separate patch is preferred, I will break out this change.
>=20
> Another reason why rtdm did not use the generic initialization code is
> that RTDM did not call exit upon failure to bind, and let a later call
> to open fail. I do not know if it was desirable, but it was a feature o=
f
> the previous implementation.
>=20

Damn right. So let's try this more systematically:

The first patch prepares the generic skin-init code for the usage by
rtdm/init.c. I'm not totally happy with the #ifndef tweak. I would
prefer to control the signal setup also via a flag, but I have no idea
how to avoid linking the unused xeno_handle_mlock_alert into librtdm.
Any ideas?

Based on this conversion is the optimisation patch -v4. There was
another quirk hidden in libpthread_rt which binds to RTDM "manually".
That's now also covered by the patch.

Jan

--------------090104080209030004070400
Content-Type: text/x-patch;
 name="generic-skin-init.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="generic-skin-init.patch"

---
 include/nucleus/bind.h   |   43 +++++++++++++++++++++++-------------
 src/skins/native/init.c  |    2 -
 src/skins/posix/init.c   |    2 -
 src/skins/rtai/init.c    |    2 -
 src/skins/rtdm/init.c    |   55 ++++++++--------------------------------=
-------
 src/skins/uvm/init.c     |    3 +-
 src/skins/vrtx/init.c    |    2 -
 src/skins/vxworks/init.c |    2 -
 8 files changed, 45 insertions(+), 66 deletions(-)

Index: xenomai/include/nucleus/bind.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/bind.h
+++ xenomai/include/nucleus/bind.h
@@ -9,6 +9,9 @@
 #include <pthread.h>
 #include <asm/xenomai/syscall.h>
=20
+#define XNSKIN_LAZY_BIND_FAIL	0x01 /* do not fail on missing skin */
+
+#ifndef XNSKIN_NO_MLOCK_ALERT
 __attribute__((weak)) int xeno_sigxcpu_no_mlock =3D 1;
=20
 static void  xeno_handle_mlock_alert (int sig)
@@ -34,18 +37,19 @@ static void  xeno_handle_mlock_alert (in
 	pthread_kill(pthread_self(),SIGXCPU);
 	}
 }
+#endif /* !XNSKIN_NO_MLOCK_ALERT */
=20
 static inline int
-xeno_user_skin_init(unsigned skin_magic, const char *skin, const char *m=
odule)
+xeno_user_skin_init(unsigned skin_magic, const char *skin, const char *m=
odule,
+		    int flags)
 {
-    struct sigaction sa;
     xnfeatinfo_t finfo;
-    int muxid;
+    int muxid =3D -1;
=20
 #ifdef xeno_arch_features_check
     xeno_arch_features_check();
 #endif /* xeno_arch_features_check */
-   =20
+
     muxid =3D XENOMAI_SYSBIND(skin_magic,
 			    XENOMAI_FEAT_DEP,
 			    XENOMAI_ABI_REV,
@@ -69,24 +73,33 @@ xeno_user_skin_init(unsigned skin_magic,
 	case -ENOSYS:
 	case -ESRCH:
=20
+	    if (flags & XNSKIN_LAZY_BIND_FAIL)
+		break; /* We are ordered to ignore the missing skin. */
+
 	    fprintf(stderr,"Xenomai: %s skin or CONFIG_XENO_OPT_PERVASIVE disab=
led.\n"
-                    "(modprobe %s?)\n", skin, module);
+		    "(modprobe %s?)\n", skin, module);
 	    exit(1);
-        }
-   =20
-    if (muxid < 0)
-        {
-        fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid)=
);
-        exit(1);
+
+	default:
+	    if (muxid < 0)
+		{
+		fprintf(stderr,"Xenomai: binding failed: %s.\n",strerror(-muxid));
+		exit(1);
+		}
         }
=20
+#ifndef XNSKIN_NO_MLOCK_ALERT
     /* Install a SIGXCPU handler to intercept alerts about unlocked
        process memory. */
+    {
+	struct sigaction sa;
=20
-    sa.sa_handler =3D &xeno_handle_mlock_alert;
-    sigemptyset(&sa.sa_mask);
-    sa.sa_flags =3D 0;
-    sigaction(SIGXCPU,&sa,NULL);
+	sa.sa_handler =3D &xeno_handle_mlock_alert;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags =3D 0;
+	sigaction(SIGXCPU,&sa,NULL);
+    }
+#endif /* !XNSKIN_NO_MLOCK_ALERT */
=20
     return muxid;
 }
Index: xenomai/src/skins/native/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/native/init.c
+++ xenomai/src/skins/native/init.c
@@ -39,7 +39,7 @@ static __attribute__ ((constructor))
 void __init_xeno_interface(void)
 {
 	__native_muxid =3D
-	    xeno_user_skin_init(XENO_SKIN_MAGIC, "native", "xeno_native");
+	    xeno_user_skin_init(XENO_SKIN_MAGIC, "native", "xeno_native", 0);
=20
 	/* Allocate a TSD key for indexing self task pointers. */
=20
Index: xenomai/src/skins/posix/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/posix/init.c
+++ xenomai/src/skins/posix/init.c
@@ -40,7 +40,7 @@ void __init_posix_interface(void)
 	int muxid, err;
=20
 	__pse51_muxid =3D
-	    xeno_user_skin_init(PSE51_SKIN_MAGIC, "POSIX", "xeno_posix");
+	    xeno_user_skin_init(PSE51_SKIN_MAGIC, "POSIX", "xeno_posix", 0);
=20
 	muxid =3D XENOMAI_SYSBIND(RTDM_SKIN_MAGIC,
 				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, NULL);
Index: xenomai/src/skins/rtai/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/rtai/init.c
+++ xenomai/src/skins/rtai/init.c
@@ -27,5 +27,5 @@ static __attribute__ ((constructor))
 void __init_rtai_interface(void)
 {
 	__rtai_muxid =3D
-	    xeno_user_skin_init(RTAI_SKIN_MAGIC, "RTAI", "xeno_rtai");
+	    xeno_user_skin_init(RTAI_SKIN_MAGIC, "RTAI", "xeno_rtai", 0);
 }
Index: xenomai/src/skins/rtdm/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/rtdm/init.c
+++ xenomai/src/skins/rtdm/init.c
@@ -20,6 +20,11 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+
+/* Checking for mlockall is only done by skins that create real-time
+   user-space threads, which we do not. */
+#define XNSKIN_NO_MLOCK_ALERT
+#include <nucleus/bind.h>
 #include <rtdm/syscall.h>
=20
 int __rtdm_muxid =3D -1;
@@ -27,49 +32,9 @@ int __rtdm_muxid =3D -1;
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
+	/* We ignore a missing skin and fail later when the user tries to open
+	   a device or socket. */
+	__rtdm_muxid =3D
+	    xeno_user_skin_init(RTDM_SKIN_MAGIC, "RTDM", "xeno_rtdm",
+				XNSKIN_LAZY_BIND_FAIL);
 }
Index: xenomai/src/skins/uvm/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/uvm/init.c
+++ xenomai/src/skins/uvm/init.c
@@ -29,7 +29,8 @@ xnsysinfo_t __uvm_info;
 static __attribute__ ((constructor))
 void __init_uvm_interface(void)
 {
-	__uvm_muxid =3D xeno_user_skin_init(UVM_SKIN_MAGIC, "UVM", "xeno_uvm");=

+	__uvm_muxid =3D
+	    xeno_user_skin_init(UVM_SKIN_MAGIC, "UVM", "xeno_uvm", 0);
=20
 	XENOMAI_SYSCALL2(__xn_sys_info, __uvm_muxid, &__uvm_info);
 }
Index: xenomai/src/skins/vrtx/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/vrtx/init.c
+++ xenomai/src/skins/vrtx/init.c
@@ -40,7 +40,7 @@ void __init_xeno_interface(void)
 	TCB *tcb;
=20
 	__vrtx_muxid =3D
-	    xeno_user_skin_init(VRTX_SKIN_MAGIC, "VRTX", "xeno_vrtx");
+	    xeno_user_skin_init(VRTX_SKIN_MAGIC, "VRTX", "xeno_vrtx", 0);
=20
 	/* Allocate a TSD key for indexing self task pointers. */
=20
Index: xenomai/src/skins/vxworks/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/skins/vxworks/init.c
+++ xenomai/src/skins/vxworks/init.c
@@ -38,7 +38,7 @@ static __attribute__ ((constructor))
 void __init_xeno_interface(void)
 {
 	__vxworks_muxid =3D xeno_user_skin_init(VXWORKS_SKIN_MAGIC,
-					      "VxWorks", "xeno_vxworks");
+					      "VxWorks", "xeno_vxworks", 0);
=20
 	/* Allocate a TSD key for indexing self task pointers. */
=20

--------------090104080209030004070400
Content-Type: text/x-patch;
 name="optimise-muxcode-calculation-v4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="optimise-muxcode-calculation-v4.patch"

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

--------------090104080209030004070400--

--------------enig4A90020EAD73C850049665F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEugozniDOoMHTA+kRAkbWAJ9FH0RO7cnzuVJA/Gq5pyinPWUhLgCcCKJj
3yNvvwWwFVJcL+i2hPqxVo8=
=0Rzh
-----END PGP SIGNATURE-----

--------------enig4A90020EAD73C850049665F8--

