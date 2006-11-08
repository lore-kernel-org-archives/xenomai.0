Message-ID: <4551F3DF.7010704@domain.hid>
Date: Wed, 08 Nov 2006 16:12:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Problem with RTDM
References: <BAY101-F18757D131B37DE8D8DE3FEE2F10@domain.hid>
In-Reply-To: <BAY101-F18757D131B37DE8D8DE3FEE2F10@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67C52B2B859771610ACFB12E"
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
To: Marco Rossi <cicciobombo123@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig67C52B2B859771610ACFB12E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marco Rossi wrote:
> Hi every body. I have to test if xenomai support my multiport serial
> board with shared interrupt. To do this im using a program found at=20
> http://www.captain.at/xenomai-serial-port-example.php; when i run the
> program i get the error:
>   relocation error: ./rt_serial_uprog: undefined symbol: rt_dev_read.
> The version of Xenomai used is 2.2.4.

Did you use the provided Makefile? It should like your application
against librtdm as required.

Jan


--------------enig67C52B2B859771610ACFB12E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUfPfniDOoMHTA+kRAo/7AJ4uOeEp5eVkgdx+tzd6OeN1BQiPKACfWsOU
2gbTLwMmwOe4CJw+mTWJ7/c=
=Qezh
-----END PGP SIGNATURE-----

--------------enig67C52B2B859771610ACFB12E--

