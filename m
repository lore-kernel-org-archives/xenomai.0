Message-ID: <462CAB3B.9080408@domain.hid>
Date: Mon, 23 Apr 2007 14:48:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46265FC8.1070207@domain.hid>	<1176926837.5010.90.camel@domain.hid>	<46268879.30507@domain.hid>	<462C7DF4.9060002@domain.hid>	<1177324208.30217.98.camel@domain.hid>	<17964.35957.487976.245056@domain.hid>
	<17964.36864.695360.167360@domain.hid>
In-Reply-To: <17964.36864.695360.167360@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6EDC57883CB633EB687282B7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EDC57883CB633EB687282B7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Philippe Gerum wrote:
>  >  > On Mon, 2007-04-23 at 11:35 +0200, Jan Kiszka wrote:
>  >  > > BTW, with latest SVN trunk and scalable sched, the oopses are g=
one but
>  >  > > latency still doesn't start up:
>  >  > >=20
>  >  > > root@domain.hid :/root# cat /proc/xenomai/sched=20
>  >  > > CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT      =
 NAME
>  >  > >   0  0       -1      0          0          master    R         =
 ROOT
>  >  > >   0  930      0      0          0          master    R         =
 display-928
>  >  > >   0  931     99      0          0          master    R         =
 sampling-928
>  >  > > root@domain.hid :/root# cat /proc/xenomai/stat =20
>  >  > > CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>  >  > >   0  0      0          0          0     00500080  100.0  ROOT
>  >  > >   0  930    0          0          0     00300188    0.0  displa=
y-928
>  >  > >   0  931    0          0          0     00300188    0.0  sampli=
ng-928
>  >  >=20
>  >  > Two threads in ready state with higher priority than the root one=
: this
>  >  > means that a rescheduling opportunity has been missed, or more
>  >  > precisely, someone may be lying to xnpod_schedule() wrt to priori=
ty
>  >  > ordering when the scalable sched is enabled.
>  >=20
>  > ffsmlq uses ffnz, and there are two implementations of ffnz, one in
>  > asm/hal.h which is correct on x86_64, the other in nucleus/system.h
>  > which uses ffs hence only operates on ints.
>=20
> Never mind, nucleus/system.h is only included when using Xenomai header=
s
> in user-space. Nevertheless, it should probably use ffsl instead of ffs=
=2E
>=20

Who the hell is using the ffnz implementation in system.h? The
simulator? I kicked it out for a x64-build here, and I got no noticeable
effects.


--------------enig6EDC57883CB633EB687282B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLKs7niDOoMHTA+kRAo4RAJ9rVzUNXxny8eFNNBKXz/8YG1tf0QCdEU3Z
u6NHfReQi3TaRgs+KHOd9/I=
=uj43
-----END PGP SIGNATURE-----

--------------enig6EDC57883CB633EB687282B7--

