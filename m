Message-ID: <4523B2EC.3050805@domain.hid>
Date: Wed, 04 Oct 2006 15:11:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Please remove "-I." in "xeno-config --*-cflags
References: <OFEF08EF89.60F083EE-ONC12571FD.003F2533-C12571FD.00429C50@domain.hid>
In-Reply-To: <OFEF08EF89.60F083EE-ONC12571FD.003F2533-C12571FD.00429C50@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF9099006EE0D1CD66729730F"
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
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF9099006EE0D1CD66729730F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas Wiedemann wrote:
> Hi,
>=20
> setting "-I." in the compiler flags in scripts/xeno-config.in
> messes up the include file search order of the compiler,
> and i can't see any good reason for it to be there.

I don't see any obvious reason as well. A quick test with our software
stack revealed no problems when removing it, but we should first wait
for further input on the original reason behind it (seems to date back
into fusion times...).

BTW, providing a patch, even if it's trivial, is always welcome in such
cases.

> the
> other flags except the xenomai include-path and the
> defines are questionable, too. At least "-Wall" and
> "-pipe" should be left to the programmer of the
> application.

Well, -Wall should be considered a reasonable policy to keep code clean.
Me feeling is that this switch is fairly appropriate, specifically for
real-time applications. But it can easily be relaxed by adding specific
-Wno-xxx after the Xenomai flags. And *that* should happen explicitly.

-pipe is an optimisation of the build process, something one may
discuss, though I don't see an immediate reason why it could fail in the
context of Xenomai applications (that should use the GNU toolchain anyway=
).

Jan

PS: sed 's/-I.//' applied on xeno-config output may meanwhile save your
day...


--------------enigF9099006EE0D1CD66729730F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFI7LsniDOoMHTA+kRAtu+AJ43aMYrYJyO04bRuAt52n2B40PSVQCdEVY7
rduz+Lx97RrP0uEPV6DrSlw=
=wgkB
-----END PGP SIGNATURE-----

--------------enigF9099006EE0D1CD66729730F--

