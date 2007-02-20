Message-ID: <45DB5FC0.6060004@domain.hid>
Date: Tue, 20 Feb 2007 21:53:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pcspeaker
References: <45DB5A29.9080506@domain.hid>
In-Reply-To: <45DB5A29.9080506@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1AB186280E67EAAABFF2B646"
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
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1AB186280E67EAAABFF2B646
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi
>=20
> I have some form of kernel recompiled in which I have the power
> management turned off. The PCspeaker is also unselected but it comes
> alive anyway. This is the result -or so it seems- of the soundcard
> driver. I would like to rmmod the sound card driver after booting if
> this interferes with xenomai but there are so many dependencies snd-thi=
s
> and snd-that, that its not trivial.
>=20
> -Is this sound-card driver a problem for xenomai?

Nope.

> -how can I be sure that the pc speaker is harmless for xenomai

Yes, as long as you are not targeting a very low-end x86 platform (any
pre-Pentium system without TSC support). But Xenomai will warn you then
during kernel configuration.

Jan


--------------enig1AB186280E67EAAABFF2B646
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF21/AniDOoMHTA+kRArTeAKCBThpnqWdNaijKwx5eHd8zUhKoOQCZAdQd
P8zUvKCzwc/osN8uFQneUUs=
=/v3w
-----END PGP SIGNATURE-----

--------------enig1AB186280E67EAAABFF2B646--

