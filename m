Message-ID: <46816BF3.7040603@domain.hid>
Date: Tue, 26 Jun 2007 21:41:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid>	<1182594345.6000.9.camel@domain.hid>	<467D0684.7030604@domain.hid>	<1182623858.6000.139.camel@domain.hid>	<467E2E9C.90905@domain.hid>	<18046.42783.829807.333066@domain.hid>	<468116FE.4090402@domain.hid>
	<18049.25882.613508.970487@domain.hid>
In-Reply-To: <18049.25882.613508.970487@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig242D8ADEF7C4E17C8BD4EBFD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
--------------enig242D8ADEF7C4E17C8BD4EBFD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > IMO, the only advantage of having absolute timers is to be able to=
 apply
>  > > the posix scheme. So, if I followed correctly your discussion, wha=
t we
>  > > need is:
>  > > - an XNTBISOL flag with a service xntbase_isol which set this flag=
 and
>  > >   unshare the target timebase if it is shared (IOW, if aperiodic)
>  > > - the service xntbase_adjust_time to walk all the absolute timers =
of the
>  > >   non isolated timebases and adjust their expiry date or play thei=
r
>  > >   handler the posix way.
>  >=20
>  > Two questions came up here regarding item #2:
>  >=20
>  >  - Shouldn't we also adjust the non-monotonic timers of an isolated =
base
>  >    if it asks for wallclock tuning? I think so.
>  >=20
>  >  - We don't have a service to walk the list of all pending timers, d=
o
>  >    we? As that touches all of our timer queue variants and I'm not
>  >    familiar with their details (except for plain lists...), I would
>  >    welcome any support on this.
>=20
> I am afraid for other things than lists, we will have to define an
> xntimerq_iterator which holds a little bit more information than just a=

> pointer to a holder.
>=20

So we would have to increase the size of each xntimer_t object? Argh.

Sounds a bit like it's worth to have a closer look at some "two timer
lists, one with adjustable offset"-approach...

Jan


--------------enig242D8ADEF7C4E17C8BD4EBFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGgWv6niDOoMHTA+kRAr3MAJ91Bl1rKi009eTnA6azkNgpLNTKLwCfb4ZD
5CRZ94WPYWVAsUgyR87A1to=
=DgYN
-----END PGP SIGNATURE-----

--------------enig242D8ADEF7C4E17C8BD4EBFD--

