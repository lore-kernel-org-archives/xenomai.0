Message-ID: <44DCAF88.2060801@domain.hid>
Date: Fri, 11 Aug 2006 18:25:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid>
In-Reply-To: <44DB9958.10109@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F781CE59F9ECFA0290C9C33"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Test, benchmark,
 demo frameworks (was: expected output and runtime of switchtest ?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F781CE59F9ECFA0290C9C33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

Jim raised these issues nicely to a generic level. I would like to pick
it up and add some thoughts.

Jim Cromie wrote:
> ...
> FWIW, I noted that xeno-test is not running these:
> - switchbench
> - switchtest
> - irqbench
>=20
> Im not sure they belong in xeno-test though, since they dont
> appear to produce output that shows good vs bad performance,
> only an informal 'sanity' check.

Including switchtest depends on if xeno-test should also do some
elementary stability tests. This can be derived from performance tests
as well, but Gilles' switchtest does it for the various switching
constellations more systematically.

Including irqbench is more tricky as "real" hardware and a second box
are always involved here (so far it only works over null-modem, need to
be extended to some GPIOs or parallel port).

Regarding the output of the various benchmarks I would like to cite
myself here:

https://mail.gna.org/public/xenomai-core/2006-06/msg00195.html

[And as one of the major xeno-test contributors, you may feel included
by the term "test team". ;)]

>=20
> And technically, dont regression tests have to yield
> a PASS / FAIL decision ?  ;-)
>=20

Simple regular output is a good idea whenever the result is simple to
express. A fatally crashing switch test due to broken support on arch
XYZ will make it hard to issue "FAIL"... :)

>=20
> Speaking more broadly, there are 3 possible kinds of test-progs
>=20
> - regression tests
>    PASS / FAIL - either by exit(rc),
>       or by printf( "%s\n", rc ? "not-ok" : "ok")
>       see perl's regression test suite ( 100k separate tests )
>       usually test details, are not tutorial

Have you checked what is already under sim/skins/*/testsuite? I must
confess I don't know if it is easily compilable for non-simulated
execution as well. The best thing would be a test framework that builds
both for the simulator and for "real" usage on the target.

>=20
> - performance tests
>    progs stress xenomai, print performance data
>    should help see performance problems, expose bugs
>    xeno-test aims to collect performance data
>    performance data must be expressive
>       (switchtest is perhaps insufficient here)

See my note above. I think some approach with a generic data collection
suite + various data generators would be really fantastic! Just takes
some brain(s) to design it and some hands to hack it...

>=20
> - examples / tutorials
>    ex: satch.c    simple, clear progs (low feature clutter, etc)
>    Id like to see all demo/**/ progs in single dir
>       forex satch-native, satch-vxworks, etc ..
>       makes for easier browsing
>    simple makefile
>       builds out-of-tree
>       handles kernel-modules and user-progs
>       (Ive seen some clean ones, cant find now.  Mine are crufty:-(
>    'patterns' of usage
>       IWBGreat if we had common usage patterns isolated,
>       named, and described

Basically full ack! Wolfgang and I had this discussion recently in a
private thread on how to deal with demos for the new CAN stack. Xenomai
really needs more of this, and it needs it in a structured, regularly
organised way. Some of my thoughts on a demo repository:

 o Should be located in the same SVN repos, maybe under /demo, in order
   to keep it in sync with ongoing API enhancements/modifications.
   But the distribution should be separate from the release (just like
   the simulator).

 o Must be well commented, i.e. should not only show how things can be
   done, but also why (or why not). That matches very well with your
   patterns.

 o Should include both simple beginners examples as well as a few more
   complex demos.

 o Full ack to your Makefile requirement: stand-alone kernel (Hannes has
   a nice generic one for both 2.4 and 2.6) and user-space makefiles. No
   autotool stuff here. At the same time, we need a script to build and
   maybe even run them automatically to detect breakages.

This will certainly be a longer process and will take some helping
hands, but we first of all need to agree on the basic structure and
requirements, and then give it an (even small) start.

>=20
>=20
> Towards this last item, Ive done 2 things:
>=20
> - poached code from Hannes Mayer :-)
>    http://www.captain.at/xenomai.php
>    task-timers.c does periodic timer 3 ways:
>       sleeper, waiter, alarm.
>=20
> - scrounged old rtai/fusion code (ls -l says Jul 05 ;-)
>    cleaned up, 1/2 compile now
>    maybe theres examples-tutorials-patterns fodder in here.
>=20
>=20
> attached tarball has these in 2 top-level dirs.
> Id like to see if theres a place for them long-term, and clean
> them up so theyre correct and helpful.
>=20

They can serve as a source, but may need to be aligned to a fairly
strict quality level we should apply on all examples. You know, the
clearer the code is, the better the user can adopt it, the less
questions pop up on xenomai-help - and the more time we have to hack
nice new features instead. =3D8)

So, how to proceed?

Jan




--------------enig6F781CE59F9ECFA0290C9C33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE3K+IniDOoMHTA+kRAlhyAJ9ERwZbEZoo+Yql7vCzqjrAMqnQvwCfRKm6
JKKBephfq23xjrIvZ+mWfKc=
=cJpb
-----END PGP SIGNATURE-----

--------------enig6F781CE59F9ECFA0290C9C33--

