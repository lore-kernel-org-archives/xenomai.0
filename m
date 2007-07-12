Message-ID: <46960A4B.5070206@domain.hid>
Date: Thu, 12 Jul 2007 13:02:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070625175107.438849fa@domain.hid>	<467FF391.8020401@domain.hid>	<20070627105726.7db7a459@domain.hid>	<46825054.7030800@domain.hid>	<20070629164326.15579570@domain.hid>	<4690B86C.1000907@domain.hid>	<20070711155932.4b88699e@domain.hid>	<4694E96B.5020801@domain.hid>	<20070711173545.709225f1@domain.hid>	<4694FD99.3030405@domain.hid>	<20070711185529.62544380@domain.hid>	<469549AF.5090102@domain.hid>
	<20070712113039.14050727@domain.hid>
In-Reply-To: <20070712113039.14050727@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig839AA4870D5C7CE29341A232"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig839AA4870D5C7CE29341A232
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Wed, 11 Jul 2007 23:20:47 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>> I've merge you changes (whitespaces...)
> sorry for bad formatting, my dev. tool is emacs, which sometimes refuse=
 to
> understand tabs...
>=20
>> http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/enhance-thread-=
stats-v2.patch
>=20
> this patch seems ok:
> -patched against release 2764 (with 2 self-corrected hunks), compiled o=
n a
> 2.6.20 kernel and test on a P3/UP
>=20
>  -my former basic tests (2 periodic tasks providing remote or self
> exectime probing) still give consistent measures (exectime.c in attachm=
ent)

Nice to hear.

>=20
> -I am thinking about more demanding tests, with intertasks preemption a=
nd
> overloads, but in that case the problem is how to assess the measuremen=
ts?
> Logic analyzer? Be care also with rt_timer_spin, which is not busy-slee=
ping for
> all the specified time when it is preempted...

You could play with the I-pipe tracer
(http://xenomai.org/index.php/I-pipe:Tracer). If you disable function
tracing (CONFIG_IPIPE_TRACE_MCOUNT), you will be left with far less
overwhelming data, specifically with the instrumentation points on every
Xenomai context switch. That should allow some estimation of the thread
execution times (minus noise due to the IRQs). And then there is highly
experimental LTTng, but it's... well, highly experimental.

Jan


--------------enig839AA4870D5C7CE29341A232
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGlgpMniDOoMHTA+kRAjwoAJkBFlyN+Hs8Q1U56PbXbHgWbJXBdwCeP6/k
meM5Mghfz21K3BB6/iLQQQ4=
=DcjU
-----END PGP SIGNATURE-----

--------------enig839AA4870D5C7CE29341A232--

