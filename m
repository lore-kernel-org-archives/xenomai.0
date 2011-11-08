Message-ID: <4EB947C3.4040604@domain.hid>
Date: Tue, 08 Nov 2011 16:16:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <201111081606.52859.leo@domain.hid>
In-Reply-To: <201111081606.52859.leo@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1AAC2AFE62F79B6A73171C4F"
Subject: Re: [Xenomai-help] rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1AAC2AFE62F79B6A73171C4F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-11-08 16:06, Leopold Palomo-Avellaneda wrote:
> Hi,
>=20
> sorry if the question is simple stupid but I have downloaded some code =
from=20
> [1] and I have realized that they have develop some drivers using rtdm =
model,=20
> but developed for rtai.
>=20
> Looking the code, it seems that there's no rtai includes (just ones for=
 the=20
> examples with creation of tasks, etc).
>=20
> So, use this code in xenomai should be straightforward, no?

Yes - except when it's not. :)

RTDM was designed to make drivers more portable, and this has been
proven to work a few times before. You may want to give it a try.

Jan


--------------enig1AAC2AFE62F79B6A73171C4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk65R8MACgkQitSsb3rl5xTA7wCg3cujP2AGTbciSCHxS/3uS0bx
GR4AmgIfVtbDswrzOkL77tEVTWuzy0H0
=BupC
-----END PGP SIGNATURE-----

--------------enig1AAC2AFE62F79B6A73171C4F--

