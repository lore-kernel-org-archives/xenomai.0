Message-ID: <448719FF.8090409@domain.hid>
Date: Wed, 07 Jun 2006 20:25:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>
	<17543.5163.684144.582942@domain.hid>
In-Reply-To: <17543.5163.684144.582942@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F9FA7FB2ACD45E55BA9996B"
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
--------------enig6F9FA7FB2ACD45E55BA9996B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  >=20
>  > Now that the big context switches bugs have been solved, here is a p=
atch
>  > that adds a unit test for context switches and FPU switches
>  > with various type of threads (kernel, user, user in secondary mode,
>  > not using FPU, using FPU, etc...). As is the case of the latency tes=
t
>  > there is a small RTDM driver in kernel-space, put in the benchmark
>  > class, even though this test is for unit testing, not for benchmarki=
ng.
>  >=20
>  > The FPU switches need a small piece of code architecture dependent,
>  > put in <asm/xenomai/fptest.h>, currently only implemented for x86.
>  >=20
>  > The kernel-space driver is called xeno_switchtest.ko, the user-space=

>  > testing tool is called switchtest, because there is already a contex=
t
>  > switch benchmarking tool called "switch".
>=20
> Here is an updated version, applying the remarks of Jim and Jan:
> renamed rtbenchmark rttesting, and renamed the already existing context=

> switch benchmark switchbench. The patch is large but contains mostly
> renames.
>=20
> I would prefer to commit this version before implementing the other
> changes, namely allowing kernel-space non real-time tasks to use the FP=
U
> and merging the context switches benchmark test with this test.
>=20

Ack, but please only use svn move for the renaming to keep the history.

Jan


--------------enig6F9FA7FB2ACD45E55BA9996B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFEhxn/niDOoMHTA+kRAopSAJjAvm4KhzOd+n+PfntBhMlgAcG8AJ90THCc
FBU/w+8fsx1UUyA4hOyBOw==
=Y5I5
-----END PGP SIGNATURE-----

--------------enig6F9FA7FB2ACD45E55BA9996B--

