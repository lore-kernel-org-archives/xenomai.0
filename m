Message-ID: <44354113.9060208@domain.hid>
Date: Thu, 06 Apr 2006 18:25:55 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB0E0FE253F2333F1C34D17F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Important fix for 16550A driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB0E0FE253F2333F1C34D17F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

all users of the xeno_16550A driver: I found an awkward bug in the
driver's interrupt handling which could cause deadlocks in that routine
- and lock-up your machine. This is fixed now both in trunk and the
2.1.x-branch (driver version 1.3.1).

The new version also contains a useful new IOCTL to purge the input and
output queues (generic RTIOC_PURGE, update of the serial profile is yet
pending). Specifically, if you have babbling serial devices which cannot
be stopped (like we here...), this helps to flush the queues and error
states in order to start over with synchronising on the stream.

Jan


--------------enigCB0E0FE253F2333F1C34D17F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFENUETniDOoMHTA+kRAjPyAJ9gwimIqpWmG/HPzRJ7dVXc7q+uPgCfZDSZ
r6QcQ8ArZXevrtEHAPsjxnA=
=5LGg
-----END PGP SIGNATURE-----

--------------enigCB0E0FE253F2333F1C34D17F--

