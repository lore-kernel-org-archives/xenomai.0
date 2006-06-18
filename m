Message-ID: <44954920.1050001@domain.hid>
Date: Sun, 18 Jun 2006 14:37:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D65AF0614B1A0AA7728A8E0"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix warning under 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D65AF0614B1A0AA7728A8E0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

this patch avoids type-mismatch warning when building for 2.4.

Jan


--- ksrc/skins/posix/syscall.c  (Revision 1222)
+++ ksrc/skins/posix/syscall.c  (Arbeitskopie)
@@ -1229,7 +1229,7 @@ static int __pthread_condattr_getclock(s

        uattrp =3D (pthread_condattr_t *) __xn_reg_arg1(regs);

-       uclockp =3D (int *) __xn_reg_arg2(regs);
+       uclockp =3D (clockid_t *) __xn_reg_arg2(regs);

        if (!__xn_access_ok
            (curr, VERIFY_READ, (void __user *)uattrp, sizeof(*uattrp)))


--------------enig8D65AF0614B1A0AA7728A8E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFElUkkniDOoMHTA+kRAq/NAJ0dyaN9MtGhNxC87DQ5sWRL+6rH0ACeIe/b
TyMtL0BtTezLvrNHqfLQ9n8=
=nX1a
-----END PGP SIGNATURE-----

--------------enig8D65AF0614B1A0AA7728A8E0--

