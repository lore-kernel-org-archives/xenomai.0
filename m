Message-ID: <45E15EAA.1040300@domain.hid>
Date: Sun, 25 Feb 2007 11:02:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] x86_64 - Initial results.
References: <200702241526.22786.paul_c@domain.hid>	<200702241655.17697.paul_c@domain.hid>	<1172337463.2161.37.camel@domain.hid>
	<200702250106.32393.paul_c@domain.hid>
In-Reply-To: <200702250106.32393.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1548DBCE5F245D4C206D15A1"
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1548DBCE5F245D4C206D15A1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> Hi Philippe
>=20
> On Saturday 24 February 2007 17:17, Philippe Gerum wrote:
>>>> Ok, the latter looks clearly pathological. The trace should tell us
>>>> more.
>=20
>> Rather the CONFIG_IPIPE_TRACE feature, with the IRQs off tracking opti=
on
>> set
>=20
>=20
> Had to recompile without SMP (see attached config), so used the -03 ipi=
pe=20
> patch with xenomai r2248. Started the latency test, and then fired up X=
 (no=20
> WM) - At which point the latency went in to a zombie state with a massi=
ve=20
> hike in value. ipipe/trace/max, latency log, and dmesg outputs all atta=
ched.
>

Please grab trace/frozen instead, enable verbose mode, and increase
back_trace_points so that the reported latency is fully covered. See

http://www.xenomai.org/index.php/I-pipe:Tracer

for further instructions.

Thanks,
Jan


--------------enig1548DBCE5F245D4C206D15A1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4V6wniDOoMHTA+kRAtD7AJ9jcz5PImYWfsnoXAHdIXKqHSTXoACeMAmI
mMguxk5PHEXUgEZiRksf/Vw=
=JQFL
-----END PGP SIGNATURE-----

--------------enig1548DBCE5F245D4C206D15A1--

