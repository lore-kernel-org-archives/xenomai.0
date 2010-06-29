Message-ID: <4C2A74C0.2000909@domain.hid>
Date: Wed, 30 Jun 2010 00:33:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <8EA2C2C4116BF44AB370468FBF85A777016574B413@domain.hid>	<4C2A078E.80009@domain.hid>
	<8EA2C2C4116BF44AB370468FBF85A7770165815E06@domain.hid>
In-Reply-To: <8EA2C2C4116BF44AB370468FBF85A7770165815E06@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9B30BD9357762589DB4A4D65"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] machine hangs running oprofile on xenomai kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Sydir, Jerry" <jerry.sydir@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B30BD9357762589DB4A4D65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[please do not top-post]

Sydir, Jerry wrote:
> Hi Jan,
>=20
> Thanks for your reply. I tried loading the oprofile module with timer=3D=
1 and oprofile seems to work (doesn't hang the system and spits out some =
results). So it appears that the use of NMIs are the problem. Do you have=
 any suggestions on what to try next?

Now someone would have to dig into the code path taken by oprofile
during NMI handling to find the reason for the lock-up. Did you have any
real-time jobs running when starting the profiling, or was Xenomai idle?

On the other hand, oprofile is a legacy interface. It probably makes
more sense to try and, if required, fix perf instead.

Jan


--------------enig9B30BD9357762589DB4A4D65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkwqdMYACgkQitSsb3rl5xQz7QCgtqvI6gMLmW3qYSB3dFAhrlNM
+dgAoJoy85mDx8tL2cUV5iY11wxdHvKz
=VhK5
-----END PGP SIGNATURE-----

--------------enig9B30BD9357762589DB4A4D65--

