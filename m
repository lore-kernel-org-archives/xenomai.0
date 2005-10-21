Message-ID: <4358DC25.9010307@domain.hid>
Date: Fri, 21 Oct 2005 14:16:37 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls          (cond, sem,
	mutex, etc).
References: <4357C3E1.1040701@domain.hid>
	<4357C9F7.2060808@domain.hid>	<4357CF67.8080601@domain.hid>
	<4357DF0F.3060806@domain.hid> <435896AA.1060103@domain.hid>
	<4358C885.8010808@domain.hid>
In-Reply-To: <4358C885.8010808@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF50FC21586E5E20DD59349CB"
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
--------------enigF50FC21586E5E20DD59349CB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Ignacio Garc=EDa P=E9rez wrote:
> In my previous (long) message I forgot something. I think that without
> support for abolute timeouts in the nucleus, the RTAI skin cannot be
> accurately implemented (*_until and *_timed calls).
>=20

Then something must be wrong, e.g. here: ;)

http://www.rts.uni-hannover.de/xenomai/lxr/source/skins/rtdm/drvlib.c?v=3D=
SVN#L280
(other skins do it similar but have to deal with more complexity)

I does work as you can see, it just takes some locking. :)

Well, it's not that accurate as it could be at best, that's true, but
the short time you "loose" between the conversions in the skin and the
nucleus is not significant compared to the overall jitter you always
face on an OS.

Jan


--------------enigF50FC21586E5E20DD59349CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDWNwlncNeS9Q0k+IRAiW9AJ9L5HFMxed/3snq6teF9M+xnmfiqwCdHBl5
PrrpyJh6IzBj4FkO0f8HCKU=
=rmyJ
-----END PGP SIGNATURE-----

--------------enigF50FC21586E5E20DD59349CB--

