Message-ID: <43B27936.2000108@domain.hid>
Date: Wed, 28 Dec 2005 12:38:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 2.4.32 compilation error + old timer example
	problem
References: <43B1F5CE.7030407@domain.hid>
In-Reply-To: <43B1F5CE.7030407@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1180FCE1536153C5242BAE82"
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
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1180FCE1536153C5242BAE82
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hannes Mayer wrote:
> I checked out xeno.trunk just a few minutes ago.
> With kernel 2.4.32, kernel compilation fails with this:
> 
> mq.c: In function `mq_notify':
> mq.c:475: error: `SIGEV_SIVNAL' undeclared (first use in this function)
> mq.c:475: error: (Each undeclared identifier is reported only once
> mq.c:475: error: for each function it appears in.)
> 
> kernel/xenomai/skins/posix/mq.c
> SIGEV_SIVNAL => SIGEV_SIGNAL
> 
> ..with that it succeeds.
> 
> But still my timer example doesn't work - see:
> https://mail.gna.org/public/xenomai-help/2005-12/msg00020.html
> 

Is this problem only related to the periodic timer mode?

Jan

--------------enig1180FCE1536153C5242BAE82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDsnk2niDOoMHTA+kRAn7mAJ9MPoAvtBi1pc+ZdpbhDZGRbB6P5ACfQCrl
y3JmNxbhIx0zwvvTxloeUU0=
=gkW/
-----END PGP SIGNATURE-----

--------------enig1180FCE1536153C5242BAE82--

