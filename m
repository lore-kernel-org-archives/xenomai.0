Message-ID: <440179BC.2090407@domain.hid>
Date: Sun, 26 Feb 2006 10:49:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] "top" doesn't start ?
References: <4400F7B1.6050408@domain.hid>
In-Reply-To: <4400F7B1.6050408@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig63795613D3D96599610E6DCC"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig63795613D3D96599610E6DCC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Hi all!
>=20
> I just recognized that "top" doesn't start if the
> RTDM demo
> http://www.captain.at/xenomai-real-time-driver-example.php
> runs.
>=20
> =3D> "user" runs, "top" is started:
> "top" doesn't start as long as "user" is running.
>=20
> When "user" is terminated, "top" displays the ncurses screen.
>=20
> xeno-2.1-rc3
> K2.6.15
>=20
> Anyone got an idea ?

That's because you grab the standard timer but do not propagate it to
Linux (all timed activity of Linux freezes, not just top). Moreover,
this demo only works in case Xenomai is using the APIC timer. Otherwise,
that IRQ is blocked for RT drivers (Dmitry's shared IRQ patch is not yet
merged).

Jan


--------------enig63795613D3D96599610E6DCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAXnAniDOoMHTA+kRAiITAJwJsHz3yW1+Ql+TutcCHpm3yPjeKwCfdQWM
TMYjgfqmvFhOUJi8kWcftEQ=
=FCFE
-----END PGP SIGNATURE-----

--------------enig63795613D3D96599610E6DCC--

