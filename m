Message-ID: <4432E540.1010108@domain.hid>
Date: Tue, 04 Apr 2006 23:29:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig361D432E8995CC05EAFA3F01"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Frozen timer IRQ
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
--------------enig361D432E8995CC05EAFA3F01
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

my colleagues and I need some hint where to continue our search for the
cause of a weird cleanup issue:

An application of our robotics framework sometimes terminates (though
successfully) in a way that the system timer IRQ no longer arrives
afterwards or no re-program takes place anymore. All other Linux IRQs
are fine (Ethernet, keyboard, etc.). I cannot provide an easy test case
yet as besides the framework some expensive gyroscope and the 16550A
driver are involved.

Fortunately, we found a clean way of stabilising the application by
fixing our broken code :) and improving the serial driver (RTIOC_PURGE),
so that the original problem is solved now (unreliable startup and
cleanup). Anyway, the stopped timer is not yet explainable, and that's
why we plan to dig deeper.

Jan


--------------enig361D432E8995CC05EAFA3F01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEMuVAniDOoMHTA+kRAtBnAJsGA+7HEiPXrLivSy6uph6RCKpJOACfTxEX
BGF+OXLbGMqe06mNbGLDuxs=
=Ecbl
-----END PGP SIGNATURE-----

--------------enig361D432E8995CC05EAFA3F01--

