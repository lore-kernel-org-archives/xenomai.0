Message-ID: <4CB06CE9.9090204@domain.hid>
Date: Sat, 09 Oct 2010 15:23:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEDE9B86A7EFFAC30F660BA6D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [forge] irqbench removal
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDE9B86A7EFFAC30F660BA6D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe,

irqbench does not inherently depend on a third I-pipe domain. It is a
useful testcase, the only in our portfolio that targets a peripheral
device use case. In fact, it was only of the first test cases for Native
RTDM IIRC.

Please revert the removal and then cut out only the few parts that
actually instantiate an additional domain (i.e. mode 3.

Thanks,
Jan


--------------enigEDE9B86A7EFFAC30F660BA6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkywbOwACgkQitSsb3rl5xR2AgCcC55yf6GPS76dH/rNM70GdrbV
JjUAn3r+KGR4UZC6+1v5BS/1OV0ErTBs
=bD2Z
-----END PGP SIGNATURE-----

--------------enigEDE9B86A7EFFAC30F660BA6D--

