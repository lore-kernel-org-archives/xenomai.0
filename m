Message-ID: <44814293.4000605@domain.hid>
Date: Sat, 03 Jun 2006 10:04:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>
In-Reply-To: <17536.40316.183366.284818@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5AB65469820E77A8948D4144"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5AB65469820E77A8948D4144
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Now that the big context switches bugs have been solved, here is a patc=
h
> that adds a unit test for context switches and FPU switches
> with various type of threads (kernel, user, user in secondary mode,
> not using FPU, using FPU, etc...).

Very good idea! Maybe it's a start to create more of such useful tests.

> As is the case of the latency test
> there is a small RTDM driver in kernel-space, put in the benchmark
> class, even though this test is for unit testing, not for benchmarking.=


"Benchmark" is likely not the right term for such devices anymore. I
guess no one will miss rtbenchmark.h, so what about this:

rttesting.h:
RTDM_CLASS_TESTING
 |
 +-- RTDM_SUBCLASS_TIMER
 |
 +-- RTDM_SUBCLASS_SWITCH

In fact, you may even consider to add some performance tests to your
driver one day. I would find it very interesting to have some numbers on
average domain migration delays or on those various other switching
variants - both from user and kernel contexts. This could then serve
users to decide how to design critical parts of their system (and us to
look for performance regressions).

>=20
> The FPU switches need a small piece of code architecture dependent,
> put in <asm/xenomai/fptest.h>, currently only implemented for x86.
>=20
> The kernel-space driver is called xeno_switchtest.ko, the user-space
> testing tool is called switchtest, because there is already a context
> switch benchmarking tool called "switch".
>=20

By combining both feature sets, the need for different names would
disappear. :)

Jan


--------------enig5AB65469820E77A8948D4144
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEgUKUniDOoMHTA+kRAi1QAJ0T58ot2q+u/zHk3CdgE8ekIvwPQQCfX1uY
AUqiDbgzSKJH0qEdc+RnOP8=
=HAS6
-----END PGP SIGNATURE-----

--------------enig5AB65469820E77A8948D4144--

