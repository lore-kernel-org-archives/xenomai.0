Message-ID: <46697DFD.9010702@domain.hid>
Date: Fri, 08 Jun 2007 18:04:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070608150953.3095d7bd@domain.hid>
	<46697496.9040307@domain.hid>
In-Reply-To: <46697496.9040307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1FDE6FBB89FE382F082EDAED"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] measuring tasks execution time
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
--------------enig1FDE6FBB89FE382F082EDAED
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> - Note that migrating life-time stats between CPUs requires rebasing th=
e
>   thread start time properly.

Nonsense. CPU-local clocks are considered offset-free for Xenomai use.


--------------enig1FDE6FBB89FE382F082EDAED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaX39niDOoMHTA+kRAu1zAJ4ugvz9AUJLYdrF5S4oDE/DKFC/mgCcCR5h
Bk57w9a0QFpcH/3EfuXeRjo=
=BqOd
-----END PGP SIGNATURE-----

--------------enig1FDE6FBB89FE382F082EDAED--

