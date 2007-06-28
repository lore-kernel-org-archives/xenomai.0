Message-ID: <4683F0E4.2060801@domain.hid>
Date: Thu, 28 Jun 2007 19:33:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>	<4680DA9B.5020501@domain.hid>	<46838C9C.7030303@domain.hid>
	<18051.37616.432109.725998@domain.hid>
In-Reply-To: <18051.37616.432109.725998@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig71256CA4491E3E37B3B82E6E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Group-based RT caps
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
--------------enig71256CA4491E3E37B3B82E6E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Jan Kiszka wrote:
>  > > Fillod Stephane wrote:
>  > >> ...
>  > >> I think Johan was not asking to disable the mlockall, but to allo=
w some.
>  > >> non-root user to be able to do it. He found his solution anyway, =
which
>  > >> is worth an entry in the FAQ.
>  > >>
>  > >> Since it is going to be a FAQ for those people in embedded busine=
ss,
>  > >> some
>  > >> tricks to allow non-root operation of mlockall, SCHED_FIFO, etc.,=
 would
>  > >> be=20
>  > >> useful. For example, you may hack the commoncap in linux/security=
/,=20
>  > >> or a better solution would be to rely on realtime-lsm[1][2], than=
ks to=20
>  > >> the audio folks.
>  > >>
>  > >> [1] http://sourceforge.net/projects/realtime-lsm/
>  > >> [2] http://lwn.net/Articles/110346/
>  > >>
>  > >=20
>  > > I think we could and should incorporate such a feature into the nu=
cleus.
>  > >=20
>  > > There is already code in xnshadow_map playing with cap_effective, =
but
>  > > that happens too late. Instead, we should establish a group-based =
access
>  > > control just like rt-lsm (the other knobs of that module are eithe=
r
>  > > irrelevant for Xenomai (mlock=3D0) or broken security-wise (any=3D=
1)) and
>  > > raise the required caps for a process that belongs to the specifie=
d
>  > > group, likely when an Xenomai interface gets attached by that proc=
ess.
>  > >=20
>  > > Comments? Volunteer coders...?
>  >=20
>  > I couldn't resist, the approach looked too simple and appealing:
>  >=20
>  > http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/rt-caps-group=
=2Epatch
>  >=20
>  > Actually, it's even more advanced than realtime-lsm in so far as it =
also
>  > checks for secondary group membership. You can use the nucleus modul=
e
>  > parameter "xenomai_gid" to control the Xenomai group, also during
>  > runtime using /sys.
>  >=20
>  > Works nicely for me. I'm able to run testsuite programs under my use=
r
>  > account that now additionally belongs to the "xenomai" group. :)
>  >=20
>  > One issue popped up and costed some nerves: linuxthreads-based
>  > pthread_create() (non-NPTL glibc, uClibc) with SCHED_FIFO/RR attribu=
te
>  > fails already in userland because that library overeagerly checks fo=
r
>  > root permissions. This is now worked around, but maybe not in the
>  > cleanest way as it changes the initial thread scheduling order (more=

>  > problematic for the POSIX skin than for Native).
>=20
> no problem with the posix skin: the scheduling order is enforced by the=

> use of a semaphore.
>=20

OK, that's good.

So if this patch might be worth merging, can we push the Linux scheduler
adjustments for all skins into the trampoline epilogue? Philippe?

Jan


--------------enig71256CA4491E3E37B3B82E6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg/DkniDOoMHTA+kRAqygAJsFaQaENlWTz7kpBUkD7sk3yuk2EwCghKrs
u4aaKoFSTQzE4M+az/ojHV8=
=azwQ
-----END PGP SIGNATURE-----

--------------enig71256CA4491E3E37B3B82E6E--

