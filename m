Message-ID: <4666CE67.5000903@domain.hid>
Date: Wed, 06 Jun 2007 17:10:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1181140977.4666c7f17f634@domain.hid>
In-Reply-To: <1181140977.4666c7f17f634@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig47E7BDCBDF1880C188C4CB30"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xenomai for mach-imx.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: garryt <garryt@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig47E7BDCBDF1880C188C4CB30
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

garryt wrote:
> Hello,
>=20
> I have compiled xenomai for an mach-imx (MC9328 MX-1) with ipipe 1.7-03=
=2E This
> include small modifications to files according to the =E2=80=9Cadapting=
 ARM I-pipe patch
> to a new board=E2=80=9D Documentation taht i could provide 4 sure.
> By the way there is an additional __ipipe_mach_get_tscinfo function to =
define..
>=20
> ipipe is 1.7-03, Linux kernel is 2.6.20 and xenomai from svn trunk.
>=20
> I then run the testsuite to be sure that it is ok...Could someone on th=
is list
> tell me if these results are valid and similar to close architecture ?
> Unfortunately i only have this board and nothing to compare to...
>=20
> By the way would it be a possible "idea" to create a repository of resu=
lts of
> testsuite prgs on different architure ( with no load for example ? ) fr=
om people
> on this list ? I have looked with no success for that...

This idea exists for a long time, it "just" requires some effort to
implement it. Basically, all pieces are there: testsuites, load
descriptions, broad user base. We only need a well-defined procedure to
collect the data.

One idea, surely the most elegant one, is to do this automatically, have
a database back-end + web front-end and make the user only hit "submit"
in some benchmark tool. But maybe a more reachable approach could be to
open a new Wiki page and upload stuff there. Anyone willing to give this
a start, e.g. by defining the layout, describing the steps to obtain data=
?

>=20
> Anyway here are the results from various tests that I run for only few =
seconds,
> but further testing shows me this is stable.
>=20
> All these tests were performed with no extra load...

And thus they are almost meaningless. Please read the TROUBLESHOOTING
file on this topic ("How do I adequately stress-test?").

>=20
> --------------------------------------------
> # arm-latency -t 0 -T 10 -p 1000
> =3D=3D Sampling period: 1000 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTD|       7.312|     101.812|     107.750|       0|       7.312|     1=
07.750
> RTD|       7.187|      46.750|     108.625|       0|       7.187|     1=
08.625
> RTD|       7.187|      45.500|     113.437|       0|       7.187|     1=
13.437
> RTD|       6.937|      44.812|     107.875|       0|       6.937|     1=
13.437
> RTD|       6.937|      43.562|     112.750|       0|       6.937|     1=
13.437
> RTD|       7.187|      42.875|     108.562|       0|       6.937|     1=
13.437
> RTD|       6.937|      41.687|     114.375|       0|       6.937|     1=
14.375
> RTD|       7.187|      41.000|     107.937|       0|       6.937|     1=
14.375
> RTD|       6.937|      39.875|     111.000|       0|       6.937|     1=
14.375
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|       6.937|      49.750|     114.375|       0|    00:00:10/00:00:=
10
>=20
> # arm-latency -t 1 -T 10 -p 1000
> =3D=3D Sampling period: 1000 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTD|       3.312|       3.735|      44.125|       0|       3.312|      =
44.125
> RTD|       3.312|       3.769|      43.687|       0|       3.312|      =
44.125
> RTD|       3.312|       3.843|      43.687|       0|       3.312|      =
44.125
> RTD|       3.312|       3.741|      43.687|       0|       3.312|      =
44.125
> RTD|       3.312|       3.823|      44.125|       0|       3.312|      =
44.125
> RTD|       3.375|       3.742|      43.750|       0|       3.312|      =
44.125
> RTD|       3.375|       3.822|      44.250|       0|       3.312|      =
44.250
> RTD|       3.312|       3.777|      43.625|       0|       3.312|      =
44.250
> RTD|       3.312|       3.821|      43.875|       0|       3.312|      =
44.250
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|       3.312|       3.785|      44.250|       0|    00:00:10/00:00:=
10
>=20
>=20
> # arm-latency -t 2 -T 10 -p 1000
> =3D=3D Sampling period: 1000 us
> =3D=3D Test mode: in-kernel timer handler
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (in-kernel timer handler, 1000 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTD|      -3.500|      -3.385|      16.125|       0|      -3.500|      =
16.125
> RTD|      -3.500|      -3.327|      16.063|       0|      -3.500|      =
16.125
> RTD|      -3.562|      -3.337|      16.063|       0|      -3.562|      =
16.125
> RTD|      -3.500|      -3.341|      15.938|       0|      -3.562|      =
16.125
> RTD|      -3.562|      -3.333|      16.125|       0|      -3.562|      =
16.125
> RTD|      -3.500|      -3.339|      16.563|       0|      -3.562|      =
16.563
> RTD|      -3.500|      -3.342|      16.125|       0|      -3.562|      =
16.563
> RTD|      -3.562|      -3.341|      16.000|       0|      -3.562|      =
16.563
> RTD|      -3.500|      -3.336|      16.188|       0|      -3.562|      =
16.563
> ---|------------|------------|------------|--------|-------------------=
------
> RTS|      -3.562|      -3.342|      16.563|       0|    00:00:10/00:00:=
10
>=20
> ?? <0 results ?? is there a particular meaning to this...

Too early shots. Xenomai's estimated scheduling latency that is taken
into account when programming a timer is too large.

>=20
> # ./arm-cyclictest -l 20000
> 0.00 0.00 0.00 1/24 290
>=20
> T: 0 (  290) P:99 I:    1000 C:   20000 Min:      12 Act:      12 Avg: =
     21 1
> Xenomai: POSIX: destroyed thread c0c01320
>=20
>=20
> # arm-switchbench
> =3D=3D Sampling period: 100 us
> =3D=3D Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|      15.625|       7.625|      83.187|       51470
>=20
> # arm-switchbench -n 20000
> =3D=3D Sampling period: 100 us
> =3D=3D Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|      14.875|       6.000|      32.937|       12422
>=20
> almost lost??

Too short period, see your (unloaded!) numbers above.

>=20
> # arm-switchbench -n 20000 -p 300
> =3D=3D Sampling period: 300 us
> =3D=3D Do not interrupt this program
> RTH|     lat min|     lat avg|     lat max|        lost
> RTD|      15.625|      48.312|      89.062|           0
>=20
> # arm-switchtest -n
> =3D=3D Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-=
7 rtuo-8
> RTT|  00:00:01
> RTH|ctx switches|-------total
> RTD|         900|         900
> RTD|         909|        1809
> RTD|         903|        2712
> RTD|         906|        3618
> RTD|         909|        4527
> RTD|         909|        5436
> RTD|         909|        6345
> RTD|         900|        7245
> RTD|         900|        8145
> RTD|         900|        9045
> RTD|         909|        9954
> RTD|         333|       10287
> Xenomai: POSIX: destroyed thread c0c00b20
>=20
> Thanks for your answer, this mail is long, sorry ;)
>=20

Jan


--------------enig47E7BDCBDF1880C188C4CB30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZs5nniDOoMHTA+kRAhxHAJ4i8nEe8KlqV5U9uPJAPfjlsPFsyQCdHgmj
SE1J21iGRbPQZEF7GdaCwNk=
=6aTS
-----END PGP SIGNATURE-----

--------------enig47E7BDCBDF1880C188C4CB30--

