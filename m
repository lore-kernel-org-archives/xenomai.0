Message-ID: <4500182A.6000009@domain.hid>
Date: Thu, 07 Sep 2006 15:01:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Linux + PREEMPT_RT + LTTng + Xenomai
References: <200609071445.53611.Serge.Noiraud@domain.hid>
In-Reply-To: <200609071445.53611.Serge.Noiraud@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC60E2D59E8F5D39CC6A7111D"
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
To: Serge Noiraud <serge.noiraud@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC60E2D59E8F5D39CC6A7111D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Serge Noiraud wrote:
> Hi, everybody
>=20
> 	I'm new to this list and I have several questions :
>=20
> I currently use linux 2.6.16 + rt from Ingo Molnar + LTTng on IA32 arch=
itecture.
>=20
> I would like to know how difficult will be the job to add Xenomai over =
this.
> Perhaps this is already in your roadmap ?

It is, see yesterday's thread on this:
https://mail.gna.org/public/xenomai-help/2006-09/msg00029.html

LTTng will likely be supported far earlier. The nucleus is prepared for
it for quite a while, we are currently just lacking a recent LTT+Ipipe
combo patch. But this task is scheduled to start soon. See also this
list's archive or xenomai-core on related discussions.

> Do we need to wait for a main line inclusion of the RT patch ?
>=20

Not necessarily, though this would simplify things.

However, any helping hand or mind can accelerate the process. So,
contributions are welcome. What application scenario do you have in mind?=


Jan


--------------enigC60E2D59E8F5D39CC6A7111D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFABgqniDOoMHTA+kRAv3RAJ9YG8+0QrWwPMSjlTorcgN4J7wP3QCdHmyI
INjJ3WuLDMcP2hCwr2sJxck=
=op+w
-----END PGP SIGNATURE-----

--------------enigC60E2D59E8F5D39CC6A7111D--

