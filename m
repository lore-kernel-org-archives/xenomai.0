Message-ID: <44E559A1.8040900@domain.hid>
Date: Fri, 18 Aug 2006 08:09:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
References: <44D19F3D.9060700@domain.hid>	<17618.12731.97405.118098@domain.hid>	<44D24257.10605@domain.hid>	<17635.15652.735628.299134@domain.hid>	<44E345D7.4070904@domain.hid>	<17635.21607.931068.951138@domain.hid>	<44E420E4.9050008@domain.hid>	<17636.26900.947012.154313@domain.hid>
	<44E470AA.1040500@domain.hid>
In-Reply-To: <44E470AA.1040500@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6702FA814523135265CBE783"
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
--------------enig6702FA814523135265CBE783
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > Gilles Chanteperdrix wrote:
>>  > > Jan Kiszka wrote:
>>  > >  > > I am thinking again about this patch: some handlers need to =
be
>>  > >  > > rewritten, for example the posix timers handler, because the=
 handler
>>  > >  > > relies on the fact that it is called for every timer expiry =
to compute
>>  > >  > > the overruns count. So maybe this patch should come with the=
 addition of
>>  > >  > > an xntimer_getoverrun service that computes the overrun coun=
t using the
>>  > >  > > tsc ?
>>  > >  > >=20
>>  > >  >=20
>>  > >  > Mmh, that gets close to hrtimer_forward now: push an overdue t=
imer to an
>>  > >  > expiry date that is in the future and return the number of ove=
rruns. But
>>  > >  > do we still want this optimisation of the broken path then? It=
 starts
>>  > >  > getting complex, probably adding more code than it is worth. I=
'm
>>  > >  > starting to vote against my own patch...
>>  > >=20
>>  > > The code to compute the number of overruns from the tsc exists in=

>>  > > xnpod_wait_thread_period, is not this just a matter of refactorin=
g this
>>  > > code in an xntimer_getoverrun ?
>>  > >=20
>>  >=20
>>  > That overrun calculation takes place in thread context, we were
>>  > discussing this for the timer handler. That means, if we generalise=
, we
>>  > would have to pass the overrun counter somehow from the handler to =
the
>>  > awakened thread. Would take another struct field, probably in xnthr=
ead.
>>  > On the other hand, if that could save code in the posix skin, it ma=
y
>>  > make sense.
>>
>> What I had in mind was that timer handlers or threads that are
>> interested in the overruns count could call xntimer_getoverruns, which=

>> computes the overruns count "on-the-fly" using the tsc, i.e. without
>> requiring any additional field.
>>
>=20
> Mmh, may work. I guess we need some code now. I already rebased my
> series over trunk, I could give this approach a try later.
>=20

No, does not work smoothly: While pse51_base_timer_handler would be fine
with xntimer_get_overruns, xnpod_wait_thread_period does its calculation
based on the expiry saved in thread->pexpect. But xntimer_get_overruns
would do this based on the timer object (as its name suggests), and that
expiry will have moved on between the timer handler invocation and the
thread activation. That means xntimer_get_overruns would only be useful
in timer handler context.

Back to square #1 one: What can we gain here? My patch complicates at
least one user, the posix skin, and that only for the sake of slightly
improving a still broken system schedule...

Jan


--------------enig6702FA814523135265CBE783
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE5VmhniDOoMHTA+kRAh0WAJ4r0fyoOYx/Sg8SOQ5zt1lGiYVYHwCeIVda
jCPovL7PCKyD1caVG/beuaU=
=Bdgh
-----END PGP SIGNATURE-----

--------------enig6702FA814523135265CBE783--

