Message-ID: <46B70D23.2020404@domain.hid>
Date: Mon, 06 Aug 2007 13:59:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig348E2F2DC0D6DAEB90869D5E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Feel bored? Run sparse.
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
--------------enig348E2F2DC0D6DAEB90869D5E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

if you ever feel bored and want to contribute something useful to the
Xenomai project, you don't need to (though you still may :)) invent a
new timer subsystem, write another fieldbus stack, or port Xenomai to
your cell phone:

Going through the countless sparse naggings ("make C=3D2" on your Xenomai=

kernel, don't forget to install sparse [1] first), analysing their
reasons and, at best, providing some fix-up patches would be highly
appreciated! At first glance, no serious bug hides behind them, but that
was only a glance, and the noise ratio is fairly high. With less noise
here, we may actually use sparse in the future to find potential bugs.

Thanks,
Jan

[1] http://www.kernel.org/pub/software/devel/sparse/


--------------enig348E2F2DC0D6DAEB90869D5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGtw0jniDOoMHTA+kRAszTAJ4wOnWkomIIPtcuJ0sMmPnUCgOGUgCfVNgZ
8qFl3JCZ+B8+qRL8t8AIk+U=
=lYMH
-----END PGP SIGNATURE-----

--------------enig348E2F2DC0D6DAEB90869D5E--

