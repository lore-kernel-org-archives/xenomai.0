Message-ID: <464D3F0C.8090109@domain.hid>
Date: Fri, 18 May 2007 07:52:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <17996.15540.824415.263562@domain.hid>	<464C4DE4.1040402@domain.hid>	<17996.20586.564091.503622@domain.hid>	<464C51F7.3000407@domain.hid>	<17996.21557.378577.691298@domain.hid>	<464C5940.2040406@domain.hid>	<17996.29459.426609.506833@domain.hid>
	<17996.31523.958476.460662@domain.hid>
In-Reply-To: <17996.31523.958476.460662@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA9639E44FD75695A12C9751D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] Use tsc for
	implementation	of	clock_gettime.
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
--------------enigA9639E44FD75695A12C9751D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Jan Kiszka wrote:
>  >  > Gilles Chanteperdrix wrote:
>  >  > > Jan Kiszka wrote:
>  >  > >  > Gilles Chanteperdrix wrote:
>  >  > >  > > Jan Kiszka wrote:
>  >  > >  > >  > Gilles Chanteperdrix wrote:
>  >  > >  > >  > > Hi,
>  >  > >  > >  > >=20
>  >  > >  > >  > > here comes, for review, a patch which reduces the ove=
rhead of
>  >  > >  > >  > > clock_gettime by directly reading the tsc in user-spa=
ce for
>  >  > >  > >  > > architectures that support it.
>  >  > >  > >  >=20
>  >  > >  > >  > Highly welcome. But I have one concern: How and when do=
 you propagate
>  >  > >  > >  > wallclock_offset changes to user space?
>  >  > >  > >=20
>  >  > >  > > Since clock_settime is not implemented, never, but if cloc=
k_settime was
>  >  > >  > > implemented, clock_settime would re-issue the __xn_sys_inf=
o syscall.
>  >  > >  >=20
>  >  > >  > This excludes automatic clock adjustment, something I'm conv=
inced we
>  >  > >  > will have to provide in the future.
>  >  > >=20
>  >  > > When we provide automatic clock adjustment, we will have to dev=
ise
>  >  > > something more subtle than just an offset, so we will have to r=
edesign
>  >  >=20
>  >  > I think offset + scaling factor.
>  >  >=20
>  >  > > posix clocks support anyway. Maybe clock_gettime(CLOCK_REALTIME=
) will
>  >  > > then always be a syscall. After all, rt_timer_read is a syscall=
=2E If you
>  >  > > want the fast clock, use CLOCK_MONOTONIC or rt_timer_tsc.
>  >  >=20
>  >  > Actually, the issue of the intermediate approach starts earlier: =
as soon
>  >  > as you have clock_settime. Then you need to sync the offset acros=
s
>  >  > applications in different processes.
>  >  >=20
>  >  > Having clock_monotonic (and maybe also rt_timer_tsc2ns) as a fast=

>  >  > variant already now is not bad. But beyond that, before introduci=
ng a
>  >  > new interface between kernel and user space, I would like to cons=
ider
>  >  > the effort to get it future-proof immediately. That doesn't mean =
that we
>  >  > already have to implement clock adjustment, but we may already pr=
epare
>  >  > the prerequisites.
>  >=20
>  > Ok. Here is a new version that does not break the ABI, and where
>  > clock_gettime(CLOCK_REALTIME) remains a syscall.
>  >=20
>  > Note that it also adds user-space conversions between tsc and ns to =
the
>  > native skin.
>=20
> This one is actually tested.
>=20

Looks good to me, builds and runs fine here.

Jan


--------------enigA9639E44FD75695A12C9751D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGTT8MniDOoMHTA+kRAreVAJ0fnq6dv/d77Au+ov47bdKc9cJv8wCfcFH/
ZjATQgzedMRQWxhxOzPPV6Q=
=yaT1
-----END PGP SIGNATURE-----

--------------enigA9639E44FD75695A12C9751D--

