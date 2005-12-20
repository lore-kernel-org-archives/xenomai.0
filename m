Message-ID: <43A89841.1070407@domain.hid>
Date: Wed, 21 Dec 2005 00:48:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Shared Memory?
References: <20051220183927.T16178@domain.hid>
In-Reply-To: <20051220183927.T16178@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7EAE3F4F187629100E286C87"
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
To: Kent Borg <kentborg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EAE3F4F187629100E286C87
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Kent Borg wrote:
> Looking at the Xenomai documentation, I can't see how to do shared
> memory communication between a realtime and non-realtime userland
> task.  Do I just use regular Linux shared memory, but somehow lock it
> down?
> 

Use mixed RT/non-RT threads and you will have shared mem for free, use
processes and you only have to ask linux for some shared fragments. In
any case don't forget to mlockall() your RT-processes!

Jan


PS: You only need "special" Xenomai services for allocating mem when you
want to shared it between kernel and user land.

--------------enig7EAE3F4F187629100E286C87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDqJhBniDOoMHTA+kRAiI4AJ9kg+rj68/cpKu6K3tJw0O1P6EucwCaAsxA
bUr3OhR4a9mblAXbDS32VE8=
=0qgi
-----END PGP SIGNATURE-----

--------------enig7EAE3F4F187629100E286C87--

