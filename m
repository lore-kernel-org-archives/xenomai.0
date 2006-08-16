Message-ID: <44E345D7.4070904@domain.hid>
Date: Wed, 16 Aug 2006 18:20:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
References: <44D19F3D.9060700@domain.hid>	<17618.12731.97405.118098@domain.hid>	<44D24257.10605@domain.hid>
	<17635.15652.735628.299134@domain.hid>
In-Reply-To: <17635.15652.735628.299134@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1258F536DA16EFFD3742876"
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD1258F536DA16EFFD3742876
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > A simple patch, just like suggested by Gilles, to avoid looping=
 over
>  > >  > periodic xntimer handlers in case of overruns.
>  > >  >=20
>  > >  > It saves the current TSC on loop entry and uses this value late=
r when
>  > >  > forwarding the timer. Is is the overhead of re-reading the TSC =
on all
>  > >  > archs negligible and should we rather go that way?
>  > >=20
>  > >  >(...)
>  > >  > -				xntimerh_date(&timer->aplink) +=3D
>  > >  > -				    nkpod->htimer.interval;
>  > >  > +				while ((xntimerh_date(&timer->aplink) +=3D
>  > >  > +				        nkpod->htimer.interval) < now);
>  > >=20
>  > > I think you are patching the wrong addition, the one you are inter=
ested
>  > > in is most probably the one at the bottom of xntimer_do_tick_aperi=
odic.
>  > >=20
>  >=20
>  > Ouch, indeed. Guess I should start reading what I patch. Here comes =
a
>  > second try.
>  >=20
>  > I'm still in favour of saving the TSC instead of re-reading it.
>  > Otherwise we would have to pave the code with #ifdefs for the case
>  > xnarch_get_cpu_tsc() is slow for a specific setup. Not that nice, is=
 it?
>=20
> I am thinking again about this patch: some handlers need to be
> rewritten, for example the posix timers handler, because the handler
> relies on the fact that it is called for every timer expiry to compute
> the overruns count. So maybe this patch should come with the addition o=
f
> an xntimer_getoverrun service that computes the overrun count using the=

> tsc ?
>=20

Mmh, that gets close to hrtimer_forward now: push an overdue timer to an
expiry date that is in the future and return the number of overruns. But
do we still want this optimisation of the broken path then? It starts
getting complex, probably adding more code than it is worth. I'm
starting to vote against my own patch...

Jan


--------------enigD1258F536DA16EFFD3742876
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE40XXniDOoMHTA+kRAtF+AJ901GZCDcwZ2Mhp/tIGt6u9vaV89gCZARYs
21GZM97/rwbK1YJ39LDXvco=
=ACsN
-----END PGP SIGNATURE-----

--------------enigD1258F536DA16EFFD3742876--

