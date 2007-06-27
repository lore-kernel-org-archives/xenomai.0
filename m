Message-ID: <46824ED7.5080908@domain.hid>
Date: Wed, 27 Jun 2007 13:49:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467CD519.1060802@domain.hid>	<1182594345.6000.9.camel@domain.hid>	<467D0684.7030604@domain.hid>	<1182623858.6000.139.camel@domain.hid>	<467E2E9C.90905@domain.hid>	<18046.42783.829807.333066@domain.hid>	<468116FE.4090402@domain.hid>	<18049.25882.613508.970487@domain.hid>	<46816BF3.7040603@domain.hid>
	<18049.39084.214526.256889@domain.hid>
In-Reply-To: <18049.39084.214526.256889@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig82250672B34F93ED19DAF8EA"
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
--------------enig82250672B34F93ED19DAF8EA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > IMO, the only advantage of having absolute timers is to be ab=
le to apply
>  > >  > > the posix scheme. So, if I followed correctly your discussion=
, what we
>  > >  > > need is:
>  > >  > > - an XNTBISOL flag with a service xntbase_isol which set this=
 flag and
>  > >  > >   unshare the target timebase if it is shared (IOW, if aperio=
dic)
>  > >  > > - the service xntbase_adjust_time to walk all the absolute ti=
mers of the
>  > >  > >   non isolated timebases and adjust their expiry date or play=
 their
>  > >  > >   handler the posix way.
>  > >  >=20
>  > >  > Two questions came up here regarding item #2:
>  > >  >=20
>  > >  >  - Shouldn't we also adjust the non-monotonic timers of an isol=
ated base
>  > >  >    if it asks for wallclock tuning? I think so.
>  > >  >=20
>  > >  >  - We don't have a service to walk the list of all pending time=
rs, do
>  > >  >    we? As that touches all of our timer queue variants and I'm =
not
>  > >  >    familiar with their details (except for plain lists...), I w=
ould
>  > >  >    welcome any support on this.
>  > >=20
>  > > I am afraid for other things than lists, we will have to define an=

>  > > xntimerq_iterator which holds a little bit more information than j=
ust a
>  > > pointer to a holder.
>  > >=20
>  >=20
>  > So we would have to increase the size of each xntimer_t object? Argh=
=2E
>  >=20
>  > Sounds a bit like it's worth to have a closer look at some "two time=
r
>  > lists, one with adjustable offset"-approach...
>=20
> No, I was thinking about defining a new type xntimerq_iterator, whose
> sole purpose would be to hold the state of an iteration. In fact, we
> only need this in the hashed case, binary heap holders already contain
> enough information.
>=20

OK, if that will not have negative impact on existing code, so much the
better.

Meanwhile I uploaded my current patch stack to
http://www.rts.uni-hannover.de/rtaddon/patches/xenomai. I'm going to
comment on detail aspects later. Just so much: it /should/ be finished
except for the yet empty placeholder re-adjust-timers.patch.

Jan


--------------enig82250672B34F93ED19DAF8EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgk7cniDOoMHTA+kRAntdAJ4rHwQ4yC+jIUPY4zJWHCaOZPJ0fQCeLGBB
fqcDiGOKoZ23GBIKbIB0obs=
=1X4x
-----END PGP SIGNATURE-----

--------------enig82250672B34F93ED19DAF8EA--

