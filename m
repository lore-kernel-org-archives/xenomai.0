Message-ID: <447AF4E3.8080603@domain.hid>
Date: Mon, 29 May 2006 15:19:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai on PXA255
References: <1148554757.9498.19.camel@domain.hid>
In-Reply-To: <1148554757.9498.19.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDB5E0AD8AC6DA3028CED0380"
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
To: Bart Jonkers <jonkersbart@domain.hid>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB5E0AD8AC6DA3028CED0380
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Bart Jonkers wrote:
> Hey,
>=20
> I'm trying to run Xenomai enabled kernel on the PXA255 (arm). When I
> compile the patched kernel, I get some undefined references errors.
> When I search through the patched kernel, I found the functions an
> variables defined for the integrator architecture.
>=20
> Which functions and variables need I to define for the PXA255 and what
> are there purpose, so I can add support for the PXA255 processor.
> Or are there some patches around to support the PXA255.

The guru (Philippe) is not in the house, but I put those two guys on the
CC who contributed a lot of ARM code. Maybe someone can comment on the
required adoptions (I'm no ARM expert).

You may furthermore speed up the discussion by naming the undefined
symbols to motivate other patch authors to explain their meanings.

Jan


--------------enigDB5E0AD8AC6DA3028CED0380
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEevTjniDOoMHTA+kRAg/OAJwOCvgIUl/0DdSdK2pwmaE0qgoj5wCfax4X
QoGEipNWemDuW2uNI+tWyrA=
=bnIC
-----END PGP SIGNATURE-----

--------------enigDB5E0AD8AC6DA3028CED0380--

