Message-ID: <45C225D1.7060503@domain.hid>
Date: Thu, 01 Feb 2007 18:39:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5974B17FF6A067EF2D9FB369"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [BUG] timer issues with SVN head
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5974B17FF6A067EF2D9FB369
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

just to save my current finding and maybe trigger some feedback:

We just tried both 2.3.x-SVN and trunk with our "reference robot". While
2.3.x behaves fine, weird things happened with trunk /wrt some serial
device. We saw reception timeouts and no serial IRQs.

So I fired up a second box with plain latency test (all the latest: SVN,
2.6.19.2, ipipe-i386-1.6-06):

> root@domain.hid :/root# latency     =20
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTD| 1299105.405| 1505168.638|  -14316.105|    3671| 1299105.405|  -143=
16.105
> RTD| 1220704.831| 1779065.782|-1220608.470|    7345| 1220704.831|-12206=
08.470
> RTD|   14316.105|-1760409.537|-1554398.542|   11018| 1220704.831|-12206=
08.470
> RTD|   14316.105| 2122222.174|-1966597.124|   14691| 1220704.831|-12206=
08.470
> RTD|   14316.105| 1709930.735| 1916083.739|   18372| 1220704.831|-12206=
08.470

Houston, I think we have a problem.

Periodic mode is on, but all skins are using the master time base. I
suspect some time conversion issues. I'll try to dig deeper -- later.

Jan


--------------enig5974B17FF6A067EF2D9FB369
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwiXSniDOoMHTA+kRAtJeAJ4gwfLX7V9I9UyNRJ+d9Hz2QCi4mACffdVV
K5xrquTz39cJnuJuqnEKHzo=
=gG6l
-----END PGP SIGNATURE-----

--------------enig5974B17FF6A067EF2D9FB369--

