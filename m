Message-ID: <45E58DA9.5030907@domain.hid>
Date: Wed, 28 Feb 2007 15:11:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] task not being scheduled
References: <45E494AC.5050603@domain.hid> <200702280750.24918.jweber@domain.hid>
In-Reply-To: <200702280750.24918.jweber@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC7985252BC6C02FFBAA215E9"
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
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC7985252BC6C02FFBAA215E9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Weber wrote:
> Switching to the linked timer list from the heap list fixed it.
>=20

OK, good to know.

Gilles, could you provide some ready-to-apply instrumentation patch?

Jeff, you have the ultimate test case now. Will you have some time to
run that test on your box so that we can quickly find and resolve the bug=
?

Jan


--------------enigC7985252BC6C02FFBAA215E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5Y2pniDOoMHTA+kRAgJZAJ9h10AFzDdeaJX2ZFiMxksO4OjxBQCfRvep
1jO+Z0bBB/7EKMQr70I5JXo=
=ZGCC
-----END PGP SIGNATURE-----

--------------enigC7985252BC6C02FFBAA215E9--

