Message-ID: <47C06052.2020406@domain.hid>
Date: Sat, 23 Feb 2008 19:05:06 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C02113.7070005@domain.hid>
	<18368.23256.85461.492726@domain.hid>
In-Reply-To: <18368.23256.85461.492726@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2356CB3C1D01006CA5548371"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 2/4] Fix and optimize xnlock_put
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
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2356CB3C1D01006CA5548371
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > As the #ifdef forest was cut down, I once again looked at xnlock_put=
=2E
>  > Why do you have this safety check for the owner also in production c=
ode?
>=20
> Because only one broken xnlock_put could entail a chain reaction of
> broken xnlock sections with code on multiple CPU violating critical
> sections. With the test, we prevent the chain reaction. But I agree thi=
s
> check should not be silent.

When there is a bug, then there is bug and we are hosed. That's why we
have debug checks for finding such cases in advance. Here I was talking
about such a debug check in a hot path on a _production_ system, and
that check even had no fault recovery. That appeared pointless to me.

Just to avoid misunderstandings: This version is not different from the
old one if XENO_OPT_DEBUG_NUCLEUS is on, the switch which was introduced
to cover specifically lock debugging.

Do you have an idea for some cheap fault recovery for broken locking
that we should put in instead?

Jan


--------------enig2356CB3C1D01006CA5548371
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwGBTniDOoMHTA+kRAjvxAJ4pBwAoKng/CkMhmU1CWwJaXmz9IwCfW7px
N3QEwI7uoKJPtTTOq5LYyjE=
=SIq/
-----END PGP SIGNATURE-----

--------------enig2356CB3C1D01006CA5548371--

