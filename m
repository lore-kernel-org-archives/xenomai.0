Message-ID: <45C1EBF9.1060409@domain.hid>
Date: Thu, 01 Feb 2007 14:32:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: : [Xenomai-help] Running real time task on one of the cores of
References: <16848045.1170336251056.JavaMail.ngmail@domain.hid>
In-Reply-To: <16848045.1170336251056.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig33D6B9DE7450D14573F82E69"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33D6B9DE7450D14573F82E69
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Jan,
>=20
> I found it in the latest SVN version but not in the 2.3 Xenomai...=20
> As my system is working currently very stable, I do not want to change =
the Xenomai version...

Oh, indeed, that got merged after the release. Obviously I'm too
bleeding-edge focused. :)

Try to extract the diff of #2011 and apply it on your tree. This should
fit seamlessly.

Jan


--------------enig33D6B9DE7450D14573F82E69
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwev5niDOoMHTA+kRAkn0AJ4ik9ahRkCnlXC4gkl2ODBmbMwF9QCfSkl3
eT5//LXxPIBrRydknjWORms=
=BjCK
-----END PGP SIGNATURE-----

--------------enig33D6B9DE7450D14573F82E69--

