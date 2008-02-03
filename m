Message-ID: <47A63D49.4050700@domain.hid>
Date: Sun, 03 Feb 2008 23:16:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18340.31233.591834.293535@domain.hid>
In-Reply-To: <18340.31233.591834.293535@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig50D7171AB6013ECE066A13D1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH 0/5] Support for select v2.
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
--------------enig50D7171AB6013ECE066A13D1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Hi,
>=20
> after some tests, bug fixes and optimizations, here comes a second vers=
ion of=20
> the patch-set adding select support to xenomai posix skin.
>=20

Puh, a lot of code, and my brain is still full of KGDB stuff I'm trying
to polish for mainline since days.

The approach looks consistent to me. I would just suggest to make the
whole thing configurable, so that it doesn't add overhead to systems
which do not use it.

Out of curiosity: Did you already have a chance to compare a
multi-threaded demo application with one based on these new select servic=
es?

I guess your current test cases are built on top of RTnet, aren't they?
Would be nice, also for regression testing, to have some demo for
/examples, e.g. exploiting the CAN stack (because it has virtual CAN,
thus it is usable without hardware).

Jan


--------------enig50D7171AB6013ECE066A13D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHpj1NniDOoMHTA+kRArgyAJ9KRM/F0IxstcpaaZpR1UfXlEAzYQCfeJ7u
EhC8/D2xhpR9wkQ9608mvpg=
=nUN7
-----END PGP SIGNATURE-----

--------------enig50D7171AB6013ECE066A13D1--

