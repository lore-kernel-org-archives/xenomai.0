Message-ID: <44DB6877.6010702@domain.hid>
Date: Thu, 10 Aug 2006 19:10:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] PPC posted results (testsuite latency)
References: <1299EF3181B10F479D85C3280132852422DAF1@domain.hid>
In-Reply-To: <1299EF3181B10F479D85C3280132852422DAF1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAEAAB971CF993E36C719C2DE"
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
To: GUARDIOLA-FALCO Sebastien 204282 <Sebastien.GUARDIOLA-FALCO@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEAAB971CF993E36C719C2DE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

GUARDIOLA-FALCO Sebastien 204282 wrote:
> Hi,
>=20
> Here are the results for a PowerPC MVME2700 267Mhz (32Mo RAM + 1024kb L=
2-cache).
> Can someone cross-check them?
>=20
> The default value for the kernel parameter "scheduling latency" led me =
to negative results, so I changed it to 4500ns. Can I improve those resul=
ts with another walue, or with other parameters?
> For the klatency test, I get more or less the half time I get in latenc=
y.
>=20
> =3D=3D Sampling period: 100 us
>  =3D=3D All results in microseconds
> RTT|  00:00:01
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTD|       1.859|       3.239|       6.179|       0|       1.859|      =
 6.179
> RTD|       2.159|       3.239|      13.559|       0|       1.859|      =
13.559
> ...

Looks quite good, maybe too good. Did you load your box? See
TROUBLESHOOTING for some hints on this. Also let it run for a longer peri=
od.

Jan


--------------enigAEAAB971CF993E36C719C2DE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE22h3niDOoMHTA+kRAqAaAJ9HCm8lud22Y8/g16U7iUitKuR0uwCfXmX0
FRIgeqrSdw8wH4kosZQW39U=
=WEu0
-----END PGP SIGNATURE-----

--------------enigAEAAB971CF993E36C719C2DE--

