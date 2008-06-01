Message-ID: <48430361.7070004@domain.hid>
Date: Sun, 01 Jun 2008 22:15:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18498.60991.572819.581076@domain.hid>	<4842F10D.7060601@domain.hid>	<18498.62016.697156.829501@domain.hid>	<4842F62D.6010008@domain.hid>
	<18499.473.653868.93704@domain.hid>
In-Reply-To: <18499.473.653868.93704@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDEF5014DF24545B0D4F8331F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] enum rtdm_selecttype
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
--------------enigDEF5014DF24545B0D4F8331F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Philippe Gerum wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > Hi Jan,
>  > >  > >=20
>  > >  > > when compiling xenomai v2.4.x for ARM with gcc 4.2.1, I get p=
lenty of
>  > >  > > warnings like:
>  > >  > > xenomai-arm/kernel/xenomai/skins/posix/syscall.c:38:
>  > >  > > xenomai-arm/include/xenomai/rtdm/rtdm_driver.h:206: warning: =
parameter has incomplete type
>  > >  > >=20
>  > >  > > So it seems gcc 4.2.1 does not like the enum being used in fu=
nction
>  > >  > > prototypes without being defines. So, could we move the enum =
definition
>  > >  > > before the functions using it ?
>  > >  > >=20
>  > >  >=20
>  > >  > We can sort this out with a simple forward declaration.
>  > >=20
>  > > That is the way it is done today, but gcc 4.2.1 seems not to like
>  > > it. Maybe recent C standards allow the compiler to pick the smalle=
st type
>  > > for the enum as C++ does ?
>  > >=20
>  >=20
>  > Or any integral type the implementation sees fit actually. Well, yes=
, maybe it
>  > is indeed bits of the C++ standard dripping on the C implementation =
of GCC,
>  > especially if forward decl of enums is not explicitly defined by the=
 C standard.
>=20
> Actually it is gcc 3.4 which does not like the forward decl, not gcc 4.=
2

I'm fine with moving it if that helps to make all compilers happy. Just
ensure that it remains in the right doxygen group.

Jan


--------------enigDEF5014DF24545B0D4F8331F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFIQwNmniDOoMHTA+kRAvdAAJ9eJdq3YTIVc4jdC7feyYCVW6Q2HACfUcqs
IVPEVO1dqaPc2KNuYUFUUEA=
=+mr5
-----END PGP SIGNATURE-----

--------------enigDEF5014DF24545B0D4F8331F--

