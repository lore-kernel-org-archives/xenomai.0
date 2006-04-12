Message-ID: <443CB06C.2080202@domain.hid>
Date: Wed, 12 Apr 2006 09:46:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] question about the latency test running on	Blackfin
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>	<1144294706.12272.32.camel@domain.hid>
	<4434BDBD.9060102@domain.hid>	<1144412822.21632.10.camel@domain.hid>
	<44365CFA.1020506@domain.hid>
	<1144809772.7286.47.camel@domain.hid>
In-Reply-To: <1144809772.7286.47.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9D6E4E6CC4D1DCD4919E177C"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Li Yi <yi.li@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D6E4E6CC4D1DCD4919E177C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Li Yi wrote:
> Hi Philippe,
>=20
> According to your answers, I updated the document on Xenomai on
> Blackfin: (http://docs.blackfin.uclinux.org/doku.php?id=3Dadeos) with t=
he
> test result of different modes, setting  XENO_OPT_TIMING_SCHEDLAT =3D 1=
=2E
> But I still have some question about the test result, hoping for your
> help:
>=20
> When running this test in mode 0, the worst case latency is 65 us, (HSD=
|
> max| 65 - 66 | 1). This result is get when there is no workload. Can I
> say this system is "Hard Real-time" because most of the latency samples=

> are in a  limited range? =20

Soft RT: the more samples remain under the required limit the higher is
         the quality of the system

Hard RT: ALL samples must be below the limit

So, for hard RT, those 65 us is the interesting number. How did you
create the system load? Typical tests contain some cache benchmarking
tool (I prefer calibrator: http://www.cwi.nl/~manegold/Calibrator) +
network load (e.g. ping -f) + hard disk or other persistent storage
access (e.g. dd if=3D<your-disk> of=3D/dev/null).

How much MHz does your board have, and to what can it be compared when
looking at other architectures. 65 us looks quite (too?) good for
low-end, but maybe the blackfin isn't actually low-end.

>=20
> That is, from the test result:
> HSS|    min|        59|     31.746|      0.632
> HSS|    avg|    599965|     33.365|      2.151
> HSS|    max|        59|     53.339|      2.739
>=20
> Can I make the conclusion that the schedule latency is "determinative" =
and the system is "hard real-time"? If not,
> what is the expected test result? Xenomai is able to provide hard real-=
time, right?

Yes, Xenomai is a hard-RT system. But this doesn't depend on a specific
worst-case latency number, rather on the fact that a hardware-dependent
upper limit can be provided that is independent of the (here:) Linux load=
=2E

Jan


--------------enig9D6E4E6CC4D1DCD4919E177C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEPLBsniDOoMHTA+kRAvZIAJwM5+zHvBXlcRD85C7DPJu576qZ/gCaAy9R
b0zJa0mekAgV4GwV4yWxS4Q=
=2gKo
-----END PGP SIGNATURE-----

--------------enig9D6E4E6CC4D1DCD4919E177C--

