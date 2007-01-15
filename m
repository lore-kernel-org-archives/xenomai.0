Message-ID: <45AB8C96.7000204@domain.hid>
Date: Mon, 15 Jan 2007 15:15:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig936E2FA602D9FF3C6D4FB9F8"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RTDM] Profile versioning
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
--------------enig936E2FA602D9FF3C6D4FB9F8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

just a short information about the latest RTDM check-in:

RTDM device profiles are meant to standardise and stabilise the
interface between drivers on one side and applications or other drivers
on the other. Still, they might evolve over the time, potentially
causing incompatibilities.

In order to help both driver writers and application developers to
publish and detect, respectively, those changes, a versioning scheme for
profiles has now been established. Drivers can export the supported
profile version in the rtdm_device structure, applications can query
that version (+ further data) via the generic, core-implemented IOCTL
RTIOC_DEVICE_INFO.

Jan


--------------enig936E2FA602D9FF3C6D4FB9F8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFq4yWniDOoMHTA+kRAr7+AJ4lBOY1legyT/rYT67whA0JOB8O7QCeJsHv
y6kVPC5nGBM1B6VI7Sz68Ws=
=Sdmy
-----END PGP SIGNATURE-----

--------------enig936E2FA602D9FF3C6D4FB9F8--

