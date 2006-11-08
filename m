Message-ID: <4551D421.7020109@domain.hid>
Date: Wed, 08 Nov 2006 13:57:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN, fix warnings on ARM, etc.
References: <4551C634.4050902@domain.hid>
In-Reply-To: <4551C634.4050902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1CDC3EE48133EEF332C1A5F6"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1CDC3EE48133EEF332C1A5F6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hello,
>=20
> the attached patch fixes:
>=20
>    * ksrc/drivers/can/sja1000/rtcan_peak_dng.c: Fix warnings when
>    building for ARM and fix bugs in the exit code.
>=20
>    * ksrc/drivers/can/sja1000/rtcan_mem.c: Fix warnings when
>    building for ARM.
>=20

Thanks, applied.

Jan


--------------enig1CDC3EE48133EEF332C1A5F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUdQhniDOoMHTA+kRAkIaAJ9IFTVspNhDwa/Ix/p2lNjbX8HSDQCcCEOM
oTcopXmlp6Us/aoQX/Q0Ibk=
=6QW1
-----END PGP SIGNATURE-----

--------------enig1CDC3EE48133EEF332C1A5F6--

