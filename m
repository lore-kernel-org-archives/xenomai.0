Message-ID: <4AEE9067.5050904@domain.hid>
Date: Mon, 02 Nov 2009 08:55:19 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AED83C0.8050002@domain.hid>
In-Reply-To: <4AED83C0.8050002@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF5153AC118AE746ACDCF77B0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Two real time NICs in same PC? (RTnet)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Benjamin Biegel <biegel@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5153AC118AE746ACDCF77B0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Benjamin Biegel wrote:
> I have only found documentation about the possibility to run a=20
> non-RT-NIC and a RT-NIC at the same time, which is possible.
>=20
> But is it possible on the same PC to have:
> - One NIC being master or slave in an RTnet network
> - One other NIC capturing frames with RTcap
> ?

Yes, this is possible. It is even the default if you use RTnet's startup
script and config (only one NIC is configured, and if there are two NICs
of the same type, only the first one is claimed by RTnet).

>=20
> (The whole point is to have a network of PCs running RTnet, so that=20
> their clocks are synchronized. Then have these same PCs capture frames =

> via RTcap. In this way the captured timestamps can be compared and =20
> Ethernet  frame travel times can be calculated.)

Note that the measurement jitter /may/ still be in the same order of
your travel delays.

Jan


--------------enigF5153AC118AE746ACDCF77B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrukGcACgkQitSsb3rl5xSxOQCgpB6rBKtU2tUEXPNd4l7dRTtU
vEsAoII0Mqzz8AlqhPRWF23E1F6wwJ5f
=awvq
-----END PGP SIGNATURE-----

--------------enigF5153AC118AE746ACDCF77B0--

