Message-ID: <440442FC.8090100@domain.hid>
Date: Tue, 28 Feb 2006 13:33:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] negative values of latency/klatency
References: <440324EE.6030309@domain.hid>
In-Reply-To: <440324EE.6030309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB67A1871FA106F628B7921C1"
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
To: Rudolf Marek <rudolf.marek@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB67A1871FA106F628B7921C1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rudolf Marek wrote:
> Hello all,
>=20
> I tried the latency and klatency demo on some PPC procesor(s) (e500 and=
 60x) and the measurement results are rather strange.
> I observed this with arbitrary version of Adeos/ipipe and on Xenomai 2.=
0.3 older 2.0.x too.
>=20
> -sh-3.00# ./run -- -T 10 -h -l 5
> ...
> RTT|  00:00:01
> RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat=
 worst
> RTD|       -4525|       -4323|        5777|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|       -1777|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|        -565|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|       -1656|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|       -1979|       0|       -4525|      =
  5777
> RTT|  00:00:06
> RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat=
 worst
> RTD|       -4525|       -4444|       -2020|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|       -1050|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|       -1616|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|       -1898|       0|       -4525|      =
  5777
> RTD|       -4525|       -4444|       -1939|       0|       -4525|      =
  5777
> ...
> Well if I set scheduling latency from automatic "0" to "1" I get:

0 means automatic latency compensation (which does not seem to work that
well here, it overcompensates), while 1 effectively means "no
hardware/software scheduling latency" (=3D> 1 ns). See also help of the
related kernel configuration parameters.

>=20
> -sh-3.00# ./run -- -T 10 -h -l 5
>=20
> RTT|  00:00:01
> RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat=
 worst
> RTD|        4767|        4929|       15191|       0|        4767|      =
 15191
> RTD|        4767|        4808|        8282|       0|        4767|      =
 15191
> RTD|        4767|        4808|        8080|       0|        4767|      =
 15191
> RTD|        4808|        4808|        7838|       0|        4767|      =
 15191
> RTD|        4767|        4808|        7272|       0|        4767|      =
 15191
> RTT|  00:00:06
> RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--klat=
 worst
> RTD|        4808|        4808|        7555|       0|        4767|      =
 15191
> RTD|        4767|        4808|        7959|       0|        4767|      =
 15191
> RTD|        4767|        4808|        7393|       0|        4767|      =
 15191
> RTD|        4808|        4808|        7191|       0|        4767|      =
 15191
> RTD|        4767|        4808|        7313|       0|        4767|      =
 15191
>=20
> Is this a bug or feature please? Can someone throw the light?
> Good would be to print the units to the numbers too (ns).
>=20

That was likely a layout question of the latency tool's output. We could
simply dump something like "All latencies in nanoseconds" during
start-up. Would this be more helpful?

Jan


--------------enigB67A1871FA106F628B7921C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBEL8niDOoMHTA+kRAqhMAJ9NlZwT9/ocriddkuQOe6UiFMbVOACeKk0T
yT2UxoayMmvHQI4Y8Vh5Mac=
=gY4I
-----END PGP SIGNATURE-----

--------------enigB67A1871FA106F628B7921C1--

