Message-ID: <4738DB4D.1020703@domain.hid>
Date: Tue, 13 Nov 2007 00:01:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3D21E8C3FEA2364A1013EF39"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 5/5] Report ignored __xn_copy_*_user
	return codes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D21E8C3FEA2364A1013EF39
Content-Type: multipart/mixed;
 boundary="------------000808050906010106000407"

This is a multi-part message in MIME format.
--------------000808050906010106000407
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

As recently suggested, this patch arms the __must_check logic behind
__xn_copy_to_user, __xn_copy_from_user (not on i386 due to lacking
instrumentation of Linux service), __xn_strncpy_from_user.

This patch is only intended to point out what remains to be addressed,
the huge number of warnings make it unsuited form a merge at this -rc sta=
ge.

Jan

--------------000808050906010106000407
Content-Type: text/x-patch;
 name="must_check-xn_copy.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="must_check-xn_copy.patch"

---
 include/asm-generic/wrappers.h |    4 ++++
 include/asm-x86/hal.h          |    4 ++++
 include/asm-x86/hal_32.h       |    2 --
 include/asm-x86/hal_64.h       |    4 ----
 include/asm-x86/syscall_32.h   |   11 ++++-------
 include/asm-x86/syscall_64.h   |   11 ++++-------
 6 files changed, 16 insertions(+), 20 deletions(-)

Index: xenomai/include/asm-x86/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal.h
+++ xenomai/include/asm-x86/hal.h
@@ -46,4 +46,8 @@ extern enum rthal_ktimer_mode rthal_ktim
 #include "hal_64.h"
 #endif
=20
+long __must_check rthal_strncpy_from_user(char *dst,
+					  const char __user *src,
+					  long count);
+
 #endif /* !_XENO_ASM_X86_HAL_H */
Index: xenomai/include/asm-x86/hal_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal_32.h
+++ xenomai/include/asm-x86/hal_32.h
@@ -222,8 +222,6 @@ static inline void rthal_setup_oneshot_a
=20
 #endif /* !__cplusplus */
=20
-long rthal_strncpy_from_user(char *dst, const char __user * src, long co=
unt);
-
 void rthal_latency_above_max(struct pt_regs *regs);
=20
 #endif /* !_XENO_ASM_X86_HAL_32_H */
Index: xenomai/include/asm-x86/hal_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/hal_64.h
+++ xenomai/include/asm-x86/hal_64.h
@@ -138,8 +138,4 @@ static inline void rthal_setup_oneshot_a
=20
 #endif /* !__cplusplus */
=20
-long rthal_strncpy_from_user(char *dst,
-			     const char __user *src,
-			     long count);
-
 #endif /* !_XENO_ASM_X86_HAL_64_H */
Index: xenomai/include/asm-x86/syscall_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/syscall_32.h
+++ xenomai/include/asm-x86/syscall_32.h
@@ -47,13 +47,10 @@
 #define __xn_mux_op(regs)     ((__xn_reg_mux(regs) >> 24) & 0xff)
=20
 /* Our own set of copy-to/from-user macros which must bypass
-   might_sleep() checks. The caller cannot fault and is expected to
-   have checked for bad range before using the copy macros, so we
-   should not have to care about the result. */
-#define __xn_copy_from_user(task,dstP,srcP,n)  \
-    ({ int __err__ =3D __copy_from_user_inatomic(dstP,srcP,n); __err__; =
})
-#define __xn_copy_to_user(task,dstP,srcP,n)  \
-    ({ int __err__ =3D __copy_to_user_inatomic(dstP,srcP,n); __err__; })=

+   might_sleep() checks. The caller is expected to have checked
+   for bad range before using the copy macros. */
+#define __xn_copy_from_user(task,dstP,srcP,n)  __copy_from_user_inatomic=
(dstP,srcP,n)
+#define __xn_copy_to_user(task,dstP,srcP,n)    __copy_to_user_inatomic(d=
stP,srcP,n)
 #define __xn_put_user(task,src,dstP)           __put_user(src,dstP)
 #define __xn_get_user(task,dst,srcP)           __get_user(dst,srcP)
 #define __xn_strncpy_from_user(task,dstP,srcP,n)    wrap_strncpy_from_us=
er(dstP,srcP,n)
Index: xenomai/include/asm-x86/syscall_64.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-x86/syscall_64.h
+++ xenomai/include/asm-x86/syscall_64.h
@@ -47,13 +47,10 @@
 #define __xn_mux_op(regs)     ((__xn_reg_mux(regs) >> 24) & 0xff)
=20
 /* Our own set of copy-to/from-user macros which must bypass
-   might_sleep() checks. The caller cannot fault and is expected to
-   have checked for bad range before using the copy macros, so we
-   should not have to care about the result. */
-#define __xn_copy_from_user(task,dstP,srcP,n)  \
-    ({ int __err__ =3D __copy_from_user_inatomic(dstP,srcP,n); __err__; =
})
-#define __xn_copy_to_user(task,dstP,srcP,n)  \
-    ({ int __err__ =3D __copy_to_user_inatomic(dstP,srcP,n); __err__; })=

+   might_sleep() checks. The caller is expected to have checked
+   for bad range before using the copy macros. */
+#define __xn_copy_from_user(task,dstP,srcP,n)	__copy_from_user_inatomic(=
dstP,srcP,n)
+#define __xn_copy_to_user(task,dstP,srcP,n)	__copy_to_user_inatomic(dstP=
,srcP,n)
 #define __xn_put_user(task,src,dstP)		__put_user(src,dstP)
 #define __xn_get_user(task,dst,srcP)		__get_user(dst,srcP)
 #define __xn_strncpy_from_user(task,dstP,srcP,n) rthal_strncpy_from_user=
(dstP,srcP,n)
Index: xenomai/include/asm-generic/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-generic/wrappers.h
+++ xenomai/include/asm-generic/wrappers.h
@@ -183,6 +183,10 @@ void show_stack(struct task_struct *task
 #define __deprecated  __attribute__((deprecated))
 #endif
=20
+#ifndef __must_check
+#define __must_check
+#endif
+
 #else /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,5,0) */
=20
 #define compat_module_param_array(name, type, count, perm) \

--------------000808050906010106000407--

--------------enig3D21E8C3FEA2364A1013EF39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHONtNniDOoMHTA+kRAhRlAJ9Lwnwp3/eqCOvCukPaUPBGeY6mxgCeNOic
3KRmOdI2DZXp2lEflPyEsNs=
=WnZG
-----END PGP SIGNATURE-----

--------------enig3D21E8C3FEA2364A1013EF39--

