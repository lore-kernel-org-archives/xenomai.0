Message-ID: <44E1DC94.1070908@domain.hid>
Date: Tue, 15 Aug 2006 16:39:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig887A3736C3EDAF9691003ED0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] refactor skin bind headers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig887A3736C3EDAF9691003ED0
Content-Type: multipart/mixed; boundary="------------070402080209090502070009"

This is a multi-part message in MIME format.
--------------070402080209090502070009
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As discussed in the buildbot thread, here comes a second try to refactor
the skin binding headers. Basically, nucleus/bind.h is split up and
moved to asm-generic/bits, skins are updated appropriately.

Builds fine here with both gcc-3.3 and gcc-4.1 over x86.

Jan

--------------070402080209090502070009
Content-Type: text/plain;
 name="refactor-skin-bind-headers.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="refactor-skin-bind-headers.patch"

Index: ChangeLog
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ChangeLog	(revision 1440)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2006-08-15  Jan Kiszka  <jan.kiszka@domain.hid>
+
+	* include/asm-generic/bits/{bind.h,mlock_alert.h},
+	include/<skin>/syscall.h, src/skins/<skin>/init.c: Split up
+	include/nucleus/bind.h and move the fragments to asm-generic/bits.
+
 2006-08-14  Jan Kiszka  <jan.kiszka@domain.hid>
=20
 	* ksrc/drivers/{serial,Kconfig,Config.in,Makefile},
Index: src/skins/rtai/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/rtai/init.c	(revision 1440)
+++ src/skins/rtai/init.c	(working copy)
@@ -20,6 +20,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <rtai/syscall.h>
+#include <asm-generic/bits/bind.h>
+#include <asm-generic/bits/mlock_alert.h>
=20
 int __rtai_muxid =3D -1;
=20
Index: src/skins/posix/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/init.c	(revision 1440)
+++ src/skins/posix/init.c	(working copy)
@@ -26,6 +26,8 @@
 #include <posix/posix.h>
 #include <posix/syscall.h>
 #include <rtdm/syscall.h>
+#include <asm-generic/bits/bind.h>
+#include <asm-generic/bits/mlock_alert.h>
=20
 int __pse51_muxid =3D -1;
 int __rtdm_muxid =3D -1;
Index: src/skins/vxworks/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/vxworks/init.c	(revision 1440)
+++ src/skins/vxworks/init.c	(working copy)
@@ -23,6 +23,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <vxworks/vxworks.h>
+#include <asm-generic/bits/bind.h>
+#include <asm-generic/bits/mlock_alert.h>
=20
 pthread_key_t __vxworks_tskey;
=20
Index: src/skins/vrtx/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/vrtx/init.c	(revision 1440)
+++ src/skins/vrtx/init.c	(working copy)
@@ -23,6 +23,8 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <vrtx/vrtx.h>
+#include <asm-generic/bits/bind.h>
+#include <asm-generic/bits/mlock_alert.h>
=20
 pthread_key_t __vrtx_tskey;
=20
Index: src/skins/native/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/init.c	(revision 1440)
+++ src/skins/native/init.c	(working copy)
@@ -24,6 +24,8 @@
 #include <pthread.h>
 #include <native/syscall.h>
 #include <native/task.h>
+#include <asm-generic/bits/bind.h>
+#include <asm-generic/bits/mlock_alert.h>
=20
 pthread_key_t __native_tskey;
=20
Index: src/skins/rtdm/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/rtdm/init.c	(revision 1440)
+++ src/skins/rtdm/init.c	(working copy)
@@ -21,6 +21,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <rtdm/syscall.h>
+#include <asm-generic/bits/bind.h>
=20
 int __rtdm_muxid =3D -1;
=20
Index: include/vxworks/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/vxworks/syscall.h	(revision 1440)
+++ include/vxworks/syscall.h	(working copy)
@@ -91,10 +91,6 @@ void wind_syscall_cleanup(void);
 }
 #endif
=20
-#elif !defined(__XENO_SIM__)
-
-#include <nucleus/bind.h>
-
 #endif /* __KERNEL__ */
=20
 #endif /* _XENO_VXWORKS_SYSCALL_H */
Index: include/native/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/native/syscall.h	(revision 1440)
+++ include/native/syscall.h	(working copy)
@@ -143,10 +143,6 @@ void __native_syscall_cleanup(void);
 }
 #endif
=20
-#elif !defined(__XENO_SIM__)
-
-#include <nucleus/bind.h>
-
 #endif /* __KERNEL__ */
=20
 #endif /* _NATIVE_SYSCALL_H */
Index: include/asm-generic/bits/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/bits/Makefile.in	(revision 1440)
+++ include/asm-generic/bits/Makefile.in	(working copy)
@@ -216,7 +216,13 @@ target_alias =3D @target_alias@
 target_cpu =3D @target_cpu@
 target_os =3D @target_os@
 target_vendor =3D @target_vendor@
-include_HEADERS =3D pod.h intr.h heap.h
+include_HEADERS =3D \
+	bind.h \
+	heap.h \
+	intr.h \
+	mlock_alert.h \
+	pod.h
+
 all: all-am
=20
 .SUFFIXES:
Index: include/asm-generic/bits/bind.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/bits/bind.h	(revision 1440)
+++ include/asm-generic/bits/bind.h	(working copy)
@@ -1,38 +1,14 @@
-#ifndef _XENO_NUCLEUS_BIND_H
-#define _XENO_NUCLEUS_BIND_H
+#ifndef _XENO_ASM_GENERIC_BITS_BIND_H
+#define _XENO_ASM_GENERIC_BITS_BIND_H
=20
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 #include <signal.h>
-#include <pthread.h>
 #include <asm/xenomai/syscall.h>
=20
-__attribute__ ((weak))
-int xeno_sigxcpu_no_mlock =3D 1;
-
-static void xeno_handle_mlock_alert(int sig)
-{
-	struct sigaction sa;
-
-	if (xeno_sigxcpu_no_mlock) {
-		fprintf(stderr,
-			"Xenomai: process memory not locked (missing mlockall?)\n");
-		fflush(stderr);
-		exit(4);
-	}
-
-	/* XNTRAPSW was set for the thread but no user-defined handler
-	   has been set to override our internal handler, so let's
-	   invoke the default signal action. */
-
-	sa.sa_handler =3D SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags =3D 0;
-	sigaction(SIGXCPU, &sa, NULL);
-	pthread_kill(pthread_self(), SIGXCPU);
-}
+void xeno_handle_mlock_alert(int sig);
=20
 static inline int
 xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module=
)
@@ -132,4 +108,4 @@ xeno_bind_skin_opt(unsigned skin_magic,=20
 	return __xn_mux_shifted_id(muxid);
 }
=20
-#endif /* _XENO_NUCLEUS_BIND_H */
+#endif /* _XENO_ASM_GENERIC_BITS_BIND_H */
Index: include/asm-generic/bits/mlock_alert.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/bits/mlock_alert.h	(revision 0)
+++ include/asm-generic/bits/mlock_alert.h	(revision 0)
@@ -0,0 +1,35 @@
+#ifndef _XENO_ASM_GENERIC_BITS_MLOCK_ALERT_H
+#define _XENO_ASM_GENERIC_BITS_MLOCK_ALERT_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <pthread.h>
+
+__attribute__ ((weak))
+int xeno_sigxcpu_no_mlock =3D 1;
+
+__attribute__ ((visibility ("internal")))
+void xeno_handle_mlock_alert(int sig)
+{
+	struct sigaction sa;
+
+	if (xeno_sigxcpu_no_mlock) {
+		fprintf(stderr, "Xenomai: process memory not locked "
+			"(missing mlockall?)\n");
+		fflush(stderr);
+		exit(4);
+	}
+
+	/* XNTRAPSW was set for the thread but no user-defined handler
+	   has been set to override our internal handler, so let's
+	   invoke the default signal action. */
+
+	sa.sa_handler =3D SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags =3D 0;
+	sigaction(SIGXCPU, &sa, NULL);
+	pthread_kill(pthread_self(), SIGXCPU);
+}
+
+#endif /* _XENO_ASM_GENERIC_BITS_MLOCK_ALERT_H */
Index: include/asm-generic/bits/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/bits/Makefile.am	(revision 1440)
+++ include/asm-generic/bits/Makefile.am	(working copy)
@@ -1,3 +1,8 @@
 includedir =3D $(prefix)/include/asm-generic/bits
=20
-include_HEADERS =3D pod.h intr.h heap.h
+include_HEADERS =3D \
+	bind.h \
+	heap.h \
+	intr.h \
+	mlock_alert.h \
+	pod.h
Index: include/rtai/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtai/syscall.h	(revision 1440)
+++ include/rtai/syscall.h	(working copy)
@@ -31,10 +31,6 @@ int __rtai_syscall_init(void);
=20
 void __rtai_syscall_cleanup(void);
=20
-#elif !defined(__XENO_SIM__)
-
-#include <nucleus/bind.h>
-
 #endif /* __KERNEL__ */
=20
 #endif /* !_RTAI_SYSCALL_H */
Index: include/posix/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/posix/syscall.h	(revision 1440)
+++ include/posix/syscall.h	(working copy)
@@ -114,10 +114,6 @@ void pse51_syscall_cleanup(void);
 }
 #endif
=20
-#elif !defined(__XENO_SIM__)
-
-#include <nucleus/bind.h>
-
 #endif /* __KERNEL__ */
=20
 #endif /* _POSIX_SYSCALL_H */
Index: include/vrtx/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/vrtx/syscall.h	(revision 1440)
+++ include/vrtx/syscall.h	(working copy)
@@ -103,10 +103,6 @@ void vrtxsys_cleanup(void);
 }
 #endif
=20
-#elif !defined(__XENO_SIM__)
-
-#include <nucleus/bind.h>
-
 #endif /* __KERNEL__ */
=20
 #endif /* _XENO_VRTX_SYSCALL_H */
Index: include/rtdm/syscall.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/rtdm/syscall.h	(revision 1440)
+++ include/rtdm/syscall.h	(working copy)
@@ -55,10 +55,6 @@ static inline void rtdm_syscall_cleanup(
 }
 #endif
=20
-#elif !defined(__XENO_SIM__)
-
-#include <nucleus/bind.h>
-
 #endif /* __KERNEL__ */
=20
 #endif /* _RTDM_SYSCALL_H */
Index: include/nucleus/Makefile.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/Makefile.in	(revision 1440)
+++ include/nucleus/Makefile.in	(working copy)
@@ -219,7 +219,6 @@ target_vendor =3D @target_vendor@
 include_HEADERS =3D \
 	assert.h \
 	bheap.h \
-	bind.h \
 	compiler.h \
 	core.h \
 	heap.h \
Index: include/nucleus/bind.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/bind.h	(revision 1440)
+++ include/nucleus/bind.h	(working copy)
@@ -1,135 +0,0 @@
-#ifndef _XENO_NUCLEUS_BIND_H
-#define _XENO_NUCLEUS_BIND_H
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <signal.h>
-#include <pthread.h>
-#include <asm/xenomai/syscall.h>
-
-__attribute__ ((weak))
-int xeno_sigxcpu_no_mlock =3D 1;
-
-static void xeno_handle_mlock_alert(int sig)
-{
-	struct sigaction sa;
-
-	if (xeno_sigxcpu_no_mlock) {
-		fprintf(stderr,
-			"Xenomai: process memory not locked (missing mlockall?)\n");
-		fflush(stderr);
-		exit(4);
-	}
-
-	/* XNTRAPSW was set for the thread but no user-defined handler
-	   has been set to override our internal handler, so let's
-	   invoke the default signal action. */
-
-	sa.sa_handler =3D SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags =3D 0;
-	sigaction(SIGXCPU, &sa, NULL);
-	pthread_kill(pthread_self(), SIGXCPU);
-}
-
-static inline int
-xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module=
)
-{
-	struct sigaction sa;
-	xnfeatinfo_t finfo;
-	int muxid;
-
-#ifdef xeno_arch_features_check
-	xeno_arch_features_check();
-#endif /* xeno_arch_features_check */
-
-	muxid =3D XENOMAI_SYSBIND(skin_magic,
-				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
-	switch (muxid) {
-	case -EINVAL:
-
-		fprintf(stderr, "Xenomai: incompatible feature set\n");
-		fprintf(stderr,
-			"(required=3D\"%s\", present=3D\"%s\", missing=3D\"%s\").\n",
-			finfo.feat_man_s, finfo.feat_all_s, finfo.feat_mis_s);
-		exit(1);
-
-	case -ENOEXEC:
-
-		fprintf(stderr, "Xenomai: incompatible ABI revision level\n");
-		fprintf(stderr, "(needed=3D%lu, current=3D%lu).\n",
-			XENOMAI_ABI_REV, finfo.abirev);
-		exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-		fprintf(stderr,
-			"Xenomai: %s skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n"
-			"(modprobe %s?)\n", skin, module);
-		exit(1);
-	}
-
-	if (muxid < 0) {
-		fprintf(stderr, "Xenomai: binding failed: %s.\n",
-			strerror(-muxid));
-		exit(1);
-	}
-
-	/* Install a SIGXCPU handler to intercept alerts about unlocked
-	   process memory. */
-
-	sa.sa_handler =3D &xeno_handle_mlock_alert;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags =3D 0;
-	sigaction(SIGXCPU, &sa, NULL);
-
-	return __xn_mux_shifted_id(muxid);
-}
-
-static inline int
-xeno_bind_skin_opt(unsigned skin_magic, const char *skin, const char *mo=
dule)
-{
-	xnfeatinfo_t finfo;
-	int muxid;
-
-#ifdef xeno_arch_features_check
-	xeno_arch_features_check();
-#endif /* xeno_arch_features_check */
-
-	muxid =3D XENOMAI_SYSBIND(skin_magic,
-				XENOMAI_FEAT_DEP, XENOMAI_ABI_REV, &finfo);
-	switch (muxid) {
-	case -EINVAL:
-
-		fprintf(stderr, "Xenomai: incompatible feature set\n");
-		fprintf(stderr,
-			"(required=3D\"%s\", present=3D\"%s\", missing=3D\"%s\").\n",
-			finfo.feat_man_s, finfo.feat_all_s, finfo.feat_mis_s);
-		exit(1);
-
-	case -ENOEXEC:
-
-		fprintf(stderr, "Xenomai: incompatible ABI revision level\n");
-		fprintf(stderr, "(needed=3D%lu, current=3D%lu).\n",
-			XENOMAI_ABI_REV, finfo.abirev);
-		exit(1);
-
-	case -ENOSYS:
-	case -ESRCH:
-
-		return -1;
-	}
-
-	if (muxid < 0) {
-		fprintf(stderr, "Xenomai: binding failed: %s.\n",
-			strerror(-muxid));
-		exit(1);
-	}
-
-	return __xn_mux_shifted_id(muxid);
-}
-
-#endif /* _XENO_NUCLEUS_BIND_H */
Index: include/nucleus/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/Makefile.am	(revision 1440)
+++ include/nucleus/Makefile.am	(working copy)
@@ -3,7 +3,6 @@ includedir =3D $(prefix)/include/nucleus
 include_HEADERS =3D \
 	assert.h \
 	bheap.h \
-	bind.h \
 	compiler.h \
 	core.h \
 	heap.h \

--------------070402080209090502070009--

--------------enig887A3736C3EDAF9691003ED0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4dyUniDOoMHTA+kRAsrMAJ4jm+oztwgu7UKYYTINgGrXV2B6NQCeLdrt
95CHzUvz+/4P+D1Lg4WTz2M=
=b1J2
-----END PGP SIGNATURE-----

--------------enig887A3736C3EDAF9691003ED0--

