Message-ID: <465D3B37.9000900@domain.hid>
Date: Wed, 30 May 2007 10:52:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465D2BE1.1080302@domain.hid> <465D3053.2040002@domain.hid>
	<465D383C.5040203@domain.hid>
In-Reply-To: <465D383C.5040203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE474EEAED368108DA8D63EDD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Newbie question]Segmentation fault with
 user-space binary
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodolfo Bamberg <rolfetas@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE474EEAED368108DA8D63EDD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodolfo Bamberg wrote:
> I tried to use latency and got this. Am I missing something within the
> Kernel? I didn't find an option for TSC. I use the 2.6.20.4 kernel
>=20
> /usr/bin $ latency
> Xenomai: incompatible feature set
> (required=3D"sep tsc", present=3D"sep", missing=3D"tsc").
>=20

Make sure your kernel config contains CONFIG_M586TSC or better - or
build the user space part with --disable-x86-tsc (but only if your
hardware is really predating any Pentium class CPU).

Jan


--------------enigE474EEAED368108DA8D63EDD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGXTs3niDOoMHTA+kRAnUeAJ9R+7wsOZgiVoEjjCmGJSjP+UhDfgCdEj4s
EFqDX0nm/3ToXEVtzW+zMFM=
=8uv2
-----END PGP SIGNATURE-----

--------------enigE474EEAED368108DA8D63EDD--

