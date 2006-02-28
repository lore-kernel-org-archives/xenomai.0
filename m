Message-ID: <44045A6D.7000508@domain.hid>
Date: Tue, 28 Feb 2006 15:13:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <440324EE.6030309@domain.hid> <440442FC.8090100@domain.hid>
In-Reply-To: <440442FC.8090100@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0AAA0530264E695219A801D9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [Xenomai-help] negative values of
	latency/klatency
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai@xenomai.org, Rudolf Marek <rudolf.marek@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0AAA0530264E695219A801D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Rudolf Marek wrote:
>> ...
>> RTT|  00:00:01
>> RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--kla=
t worst
>> RTD|        4767|        4929|       15191|       0|        4767|     =
  15191
>> RTD|        4767|        4808|        8282|       0|        4767|     =
  15191
>> RTD|        4767|        4808|        8080|       0|        4767|     =
  15191
>> RTD|        4808|        4808|        7838|       0|        4767|     =
  15191
>> RTD|        4767|        4808|        7272|       0|        4767|     =
  15191
>> RTT|  00:00:06
>> RTH|----klat min|----klat avg|----klat max| overrun|---klat best|--kla=
t worst
>> RTD|        4808|        4808|        7555|       0|        4767|     =
  15191
>> RTD|        4767|        4808|        7959|       0|        4767|     =
  15191
>> RTD|        4767|        4808|        7393|       0|        4767|     =
  15191
>> RTD|        4808|        4808|        7191|       0|        4767|     =
  15191
>> RTD|        4767|        4808|        7313|       0|        4767|     =
  15191
>>
>> Is this a bug or feature please? Can someone throw the light?
>> Good would be to print the units to the numbers too (ns).
>>
>=20
> That was likely a layout question of the latency tool's output. We coul=
d
> simply dump something like "All latencies in nanoseconds" during
> start-up. Would this be more helpful?
>=20

The output of latency is indeed inconsistent. Histogram and stats are
printed in microseconds, intermediate and overall latencies go out as
nanoseconds. Anyone any objections to switch to micros with 3 digits
after the decimal point? Patch is ready to be applied.

=3D=3D Sampling period: 150 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 150 us period)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       8.935|      13.824|      39.951|       0|       8.935|
39.951
RTD|       8.998|      14.619|      36.867|       0|       8.935|
39.951
RTD|       8.576|      14.604|      37.417|       0|       8.576|
39.951
RTD|       3.018|      14.623|      40.466|       0|       3.018|
40.466
[grabbed on a low-end board]

Jan


--------------enig0AAA0530264E695219A801D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFEBFptniDOoMHTA+kRAt0ZAJjkc8qZUzFrvMsh0x8npetn1P4sAJ0V/2JX
LrJzXIBFm9B/jl9nV8mr9Q==
=z4CM
-----END PGP SIGNATURE-----

--------------enig0AAA0530264E695219A801D9--

