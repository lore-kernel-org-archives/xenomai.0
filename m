Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jnCodc7i7zEFMTsRZrGR"
Date: Tue, 17 Oct 2006 11:23:17 +0200
Message-Id: <1161076997.5024.0.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--=-jnCodc7i7zEFMTsRZrGR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here some test-cases:


-sh-3.00# cat /proc/xenomai/rtdm/rttest0/information=20
driver:         xeno_timerbench
version:        0.2.0
peripheral:     Timer Latency Benchmark
provider:       Jan Kiszka
class:          6
sub-class:      0
flags:          NAMED_DEVICE =20
lock count:     0
-sh-3.00# cat /proc/xenomai/rtdm/rttest1/information=20
driver:         xeno_irqbench
version:        0.1.0
peripheral:     IRQ Latency Benchmark
provider:       Jan Kiszka
class:          6
sub-class:      1
flags:          NAMED_DEVICE =20
lock count:     0
-sh-3.00# cat /proc/xenomai/rtdm/rttest2/information=20
driver:         xeno_switchtest
version:        0.1.1
peripheral:     Context Switch Test
provider:       Gilles Chanteperdrix
class:          6
sub-class:      2
flags:          NAMED_DEVICE =20
lock count:     0
-sh-3.00# cat /proc/xenomai/rtdm/named_devices      =20
Hash    Name                            /proc
D6      rttest0                         rttest0
D7      rttest1                         rttest1
D8      rttest2                         rttest2


-sh-3.00# ./latency -D0 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1091011.128|       0.001|      93.252|   93340|
00:00:00/00:00:10

-sh-3.00# ./latency -D1 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1098113.592|       0.001|      93.252|   93340|
00:00:-01/00:00:10

-sh-3.00# ./latency -D2 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1093665.336|       0.001|      93.252|   93340|
00:00:00/00:00:10

-sh-3.00# ./latency -D3 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)
-sh-3.00# ./latency -D4 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)
-sh-3.00# ./latency -D4 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)
-sh-3.00# ./latency -D5 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)
-sh-3.00# ./latency -D6 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)
-sh-3.00# ./latency -D7 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)
-sh-3.00# ./latency -D8 -t 1 -T 10 -p 10000
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
latency: failed to open benchmark device, code -19
(modprobe xeno_timerbench?)



... no success




--=-jnCodc7i7zEFMTsRZrGR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFNKEFbMvu5jIEpfsRAgi/AKCFYQhK956n8DR5KlYMPLK7Xit7fQCfdihn
II10gmOY+2gsUNs8AcGiW+Y=
=Bs9+
-----END PGP SIGNATURE-----

--=-jnCodc7i7zEFMTsRZrGR--


