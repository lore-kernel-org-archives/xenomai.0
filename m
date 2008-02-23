Message-ID: <47C06CAD.6060200@domain.hid>
Date: Sat, 23 Feb 2008 19:57:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <47C020A9.3050704@domain.hid>	<47C02113.7070005@domain.hid>	<18368.23256.85461.492726@domain.hid>	<47C06052.2020406@domain.hid>
	<18368.26112.776987.660255@domain.hid>
In-Reply-To: <18368.26112.776987.660255@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA2B926203523BBB320C3D571"
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
--------------enigA2B926203523BBB320C3D571
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > As the #ifdef forest was cut down, I once again looked at xnloc=
k_put.
>  > >  > Why do you have this safety check for the owner also in product=
ion code?
>  > >=20
>  > > Because only one broken xnlock_put could entail a chain reaction o=
f
>  > > broken xnlock sections with code on multiple CPU violating critica=
l
>  > > sections. With the test, we prevent the chain reaction. But I agre=
e this
>  > > check should not be silent.
>  >=20
>  > When there is a bug, then there is bug and we are hosed. That's why =
we
>  > have debug checks for finding such cases in advance. Here I was talk=
ing
>  > about such a debug check in a hot path on a _production_ system, and=

>  > that check even had no fault recovery. That appeared pointless to me=
=2E
>  >=20
>  > Just to avoid misunderstandings: This version is not different from =
the
>  > old one if XENO_OPT_DEBUG_NUCLEUS is on, the switch which was introd=
uced
>  > to cover specifically lock debugging.
>  >=20
>  > Do you have an idea for some cheap fault recovery for broken locking=

>  > that we should put in instead?
>=20
> The fault recovery is to leave the xnlock untouched, in order to avoid
> the chain reaction I was talking about.

But you may later deadlock on it when trying to reacquire this
unbalanced lock. It can help against double releases, granted. Still,
such cases should be eliminated _ahead_ of release via review, so that
one can finally go for the fast unchecked version in the matured system.

> Anyway, I think even production
> code should contain some sanity checks, and this one looks cheap.

I'm fine with a simple check as well. But there should be an _option_
for such checks, even more if they are supposed to be inlined.
Uninlining reduces this pressure, but it still adds text size to the hot
path.

Jan


--------------enigA2B926203523BBB320C3D571
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHwGywniDOoMHTA+kRAlyDAJ9pP1KAFMwIx9efm8EIxirSfJfvOwCfe4zG
w+NRYcbb1kQh2bLCarItZtw=
=cZJr
-----END PGP SIGNATURE-----

--------------enigA2B926203523BBB320C3D571--

