Message-ID: <45CC3866.8070706@domain.hid>
Date: Fri, 09 Feb 2007 10:01:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6BF79213687771E542A996DB"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Fix warnings for kernel 2.4 builds
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
--------------enig6BF79213687771E542A996DB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Index: include/asm-generic/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/wrappers.h	(Revision 2167)
+++ include/asm-generic/wrappers.h	(Arbeitskopie)
@@ -257,8 +257,6 @@ unsigned long __va_to_kva(unsigned long=20
 					   &(p)->pending.signal, \
 					   &(p)->signal->shared_pending.signal)
=20
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,20)
 #define DECLARE_WORK_NODATA(f, n)	DECLARE_WORK(f, n, NULL)
 #define DECLARE_WORK_FUNC(f)		void f(void *cookie)
@@ -267,4 +265,6 @@ unsigned long __va_to_kva(unsigned long=20
 #define DECLARE_WORK_FUNC(f)		void f(struct work_struct *work)
 #endif /* >=3D 2.6.20 */
=20
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */



--------------enig6BF79213687771E542A996DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFzDhpniDOoMHTA+kRAkEwAJ9ss/iZ8Jed/ke3HV+oGzXFI4tjGACeIwcU
xx9KYFo5j4QqjsKC+QYkePo=
=Edq8
-----END PGP SIGNATURE-----

--------------enig6BF79213687771E542A996DB--

