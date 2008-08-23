Message-ID: <48AFCCED.30102@domain.hid>
Date: Sat, 23 Aug 2008 10:40:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6EC82A517A7F99A5F3C01EE8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Remove redundant LOCK prefix
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
--------------enig6EC82A517A7F99A5F3C01EE8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

According to Linux and the Intel spec, this prefix is not needed.

---
 include/asm-x86/atomic_32.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/include/asm-x86/atomic_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-x86/atomic_32.h
+++ b/include/asm-x86/atomic_32.h
@@ -64,7 +64,7 @@ struct __xeno_xchg_dummy { unsigned long
 static inline unsigned long xnarch_atomic_xchg (volatile void *ptr,
 						unsigned long x)
 {
-	__asm__ __volatile__(LOCK_PREFIX "xchgl %0,%1"
+	__asm__ __volatile__("xchgl %0,%1"
 			     :"=3Dr" (x)
 			     :"m" (*__xeno_xg(ptr)), "0" (x)
 			     :"memory");


--------------enig6EC82A517A7F99A5F3C01EE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkivzO0ACgkQniDOoMHTA+mhowCdFOcYdNx8WCWf0JQ9wqN9U+V0
V4YAn1twOpkf/FXHJ33eCoT9QK8j5Z6b
=uIGb
-----END PGP SIGNATURE-----

--------------enig6EC82A517A7F99A5F3C01EE8--

