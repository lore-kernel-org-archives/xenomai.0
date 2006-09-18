Message-ID: <450E6A58.7040202@domain.hid>
Date: Mon, 18 Sep 2006 11:43:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] official TSC model on SMP
References: <450D3764.80601@domain.hid>	<1158513328.4979.45.camel@domain.hid>
	<17677.34698.949600.873431@domain.hid>
In-Reply-To: <17677.34698.949600.873431@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37830C563512F9FB4045AF33"
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
--------------enig37830C563512F9FB4045AF33
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Sun, 2006-09-17 at 13:54 +0200, Jan Kiszka wrote:
>  > > Hi,
>  > >=20
>  > > reading through timer code of Xenomai I just wondered (again) what=
 our
>  > > official model of TSCs on multiprocessor boxes are:
>  > >=20
>  > > 1) (practically) perfectly synchronised without offset
>  > >=20
>  > > 2) synchronised but with (unknown?) offset
>  > >=20
>  > > 3) unsynchronised
>  >=20
>  > The current model is unsynchronized. If anything from the codebase i=
s
>  > found relying on the opposite, be it partially or fully, then it's
>  > utterly broken in the SMP case, and I'm likely the one to blame.
>  > IOW, we don't currently provide any guarantee to anyone that a times=
tamp
>  > could be interpreted anywhere else than the CPU it was read from, an=
d
>  > leave all the related burden to the application developer (e.g. by m=
ean
>  > of managing CPU affinity constraints and the like).
>=20
> I think xntimer_set_sched assumes some continuity, since it reenqueues
> on a different CPU a timer whose date has been set up on one cpu. If we=

> wanted strict unsynchronized tsc, we would have to :
> - compute the difference between the current date and the timer date
> - enqueue the timer on a migration queue
> - send an IPI to the distant CPU
> - on the distant CPU, iterate over the migration queue, recompute the
>   expiration dates and reenqueue the timers.
>=20

I bet there are a few other wrong assumptions about dates hogging around
in our design. At least all timestamp deliveries of RTDM devices on SMP
fall into this group.

It's a fairly unsatisfying situation. How common are unsynchronised
TSCs, also on non x86 archs? I though so far that's an issue of a few
newer AMD multicore CPUs only. I once read the Solaris x86 timer code,
and they, e.g., demand synch'ed TSC IIRC.

Can we make the unsynch'ed case somehow the exception and deal with it
separately (via periodic re-synch based on IPI)? Would make life easier,
though I agree that explicit CPU scheduling of tasks and IRQs are more
appropriate to RT systems. But sometimes you cannot put the IRQ on the
same CPU like the woken up task...

Jan


--------------enig37830C563512F9FB4045AF33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFDmpYniDOoMHTA+kRApd9AJ0dN2npYwDMW9+vD1mXeVERlwtFGgCfc1aM
O+Ros3Ox4wKQ6Lk7N5csQOk=
=EYEB
-----END PGP SIGNATURE-----

--------------enig37830C563512F9FB4045AF33--

