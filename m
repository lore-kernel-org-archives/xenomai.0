Message-ID: <4D21E45B.90003@domain.hid>
Date: Mon, 03 Jan 2011 15:59:39 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8DE0533AE8DBD2999E2A285B"
Subject: [Xenomai-help] 16550A driver and 2-port pci board, irq sharing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DE0533AE8DBD2999E2A285B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jan,

I try to add support for the Moxa CP132 RS422 dualport pci board to the
16550A driver. In the function rt_16550_open() the call to
rtdm_irq_request() fails with EBUSY (-16) for the second port.

Looking at the source the driver seems to be able to handle multiple
serial ports with the same (shared) IRQ. Any hints ?

Stefan

x86 32bit, xenomai-2.5.5, linux 2.6.32, ipipe 2.7-03,
examples/cross-link app



--------------enig8DE0533AE8DBD2999E2A285B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0h5GQACgkQIPTw9rIdn6qyHACeM7a74IRaS0TBmSFw9+ugsSSl
/XAAn3Z80664XEZE/2IDQssaxlt8S7IH
=Sg6P
-----END PGP SIGNATURE-----

--------------enig8DE0533AE8DBD2999E2A285B--

