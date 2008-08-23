Message-ID: <48AFCB3F.6070902@domain.hid>
Date: Sat, 23 Aug 2008 10:33:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig64F1B48783B0941A593EAA75"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Racy pse51_mutex_check_init?
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
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig64F1B48783B0941A593EAA75
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

trying to understand the cb_read/write lock usage, some question came up
here: What prevents that the mutexq iteration in pse51_mutex_check_init
races against pse51_mutex_destroy_internal?

If nothing, then I wonder if we actually have to iterate over the whole
queue to find out whether a given object has been initialized and
registered already or not. Can't this be encoded differently?

BTW, shadow_mutex.mutex is a kernel pointer sitting in a user-reachable
memory region? Why not using a handle here, like the native skin does?
Won't that allow to resolve the issue above as well?

Jan


--------------enig64F1B48783B0941A593EAA75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkivy0IACgkQniDOoMHTA+kSFACdFejMrdmostbEXwNC64QRm4rH
dIoAn2KDGbnYcEyz97HlG3u1bVQTpaYX
=QwWW
-----END PGP SIGNATURE-----

--------------enig64F1B48783B0941A593EAA75--

