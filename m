Message-ID: <453C84FE.3050508@domain.hid>
Date: Mon, 23 Oct 2006 11:01:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] x86 FPU switches routines.
References: <453C7C48.30602@domain.hid>
In-Reply-To: <453C7C48.30602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig24B31F86816CC65AE8D01056"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig24B31F86816CC65AE8D01056
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
>=20
> Hi,
>=20
> As once discussed with Heikki, and after a first missed attempt, here
> is a patch for x86 which attempts to cope correctly with Linux (non
> real-time) drivers using FPU in kernel-space.
>=20
> I tested it on my laptop without drivers using FPU, and it appears to
> work correctly, but it would be nice if people that had problems with
> the previous attempt (if I remember correctly, on old pentiums and on
> AMD processors) could test this patch.

Just fired up on a Pentium MMX which used to have problems with the
first approad. Switchtest reports no problems.

What about writing a simple test case for the non-RT in-kernel FPU usage?=


Jan


--------------enig24B31F86816CC65AE8D01056
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPIT+niDOoMHTA+kRAhTAAJ9x9+tKqf2v5Pq+YibRCrOVRF1O/QCghKDL
bDNUA/h4IIq8e6L73WDKNXw=
=cgV6
-----END PGP SIGNATURE-----

--------------enig24B31F86816CC65AE8D01056--

