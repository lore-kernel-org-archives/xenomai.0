Message-ID: <44046BF9.6090101@domain.hid>
Date: Tue, 28 Feb 2006 16:27:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C029A89A.2576%steve@domain.hid>
In-Reply-To: <C029A89A.2576%steve@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9D1E1F7D6CF8FEDAAC770483"
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D1E1F7D6CF8FEDAAC770483
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> It seems to me that the RTOS should just stop accruing overruns for any=

> suspended thread. What's the point of even allowing it to stay on the o=
ld
> timeline? This algorithm, albeit implemented in kernel modules with cla=
ssic
> RTAI, never had an issue.

Sorry, wildly suspending a periodic thread remains a very unusual design
in my eyes, and no RTOS should be hold responsible for this.

And "RTAI" is void argument: it's API has too many special
characteristics anyway to take this as a reference for anything else
than itself.

>=20
> Well, everything works now with new set_periodic calls, so I guess we c=
an
> all be happy now.
>=20

Ack.

Jan


--------------enig9D1E1F7D6CF8FEDAAC770483
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBGv5niDOoMHTA+kRAgJhAJ0ff2/dpr2LaXWYoOacAAk9iQ0/2QCfVCav
7k/Xfg3FoOHO1+kjv2Wl3Cc=
=UW5i
-----END PGP SIGNATURE-----

--------------enig9D1E1F7D6CF8FEDAAC770483--

