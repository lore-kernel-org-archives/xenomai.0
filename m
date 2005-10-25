Message-ID: <435E0921.20001@domain.hid>
Date: Tue, 25 Oct 2005 12:29:53 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to implement a GUI for RT apps?
References: <435D7D8C.1010004@domain.hid> <435E079F.4030108@domain.hid>
In-Reply-To: <435E079F.4030108@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD577A2A0149AD37A7DC08537"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD577A2A0149AD37A7DC08537
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
>>1. What's the best way to implement a GUI for a RT app?
>=20
>=20
> Make it non-RT. The "U" in "GUI" is user. Users are not real time.
>=20

Not true. That thread must be mapped to Xenomai in order to use
rt-mutexes. Otherwise, one has to use rt-pipes.

Jan


--------------enigD577A2A0149AD37A7DC08537
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXgkhncNeS9Q0k+IRAkkVAJ47CB7iwWbTKGy++XQhoPbOh4AQNACgx2y+
a0tPqM4rC/K329KL+ESK+jM=
=NxGW
-----END PGP SIGNATURE-----

--------------enigD577A2A0149AD37A7DC08537--

