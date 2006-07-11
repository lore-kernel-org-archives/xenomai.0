Message-ID: <44B3BE9B.5040203@domain.hid>
Date: Tue, 11 Jul 2006 17:07:07 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai beginner problem
References: <200607111633.09508.technique@domain.hid>
In-Reply-To: <200607111633.09508.technique@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE8539C93EA23ECA7E1E5F1F5"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Chaplet <technique@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE8539C93EA23ECA7E1E5F1F5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Martin Chaplet wrote:
> On 7/11, Jan Kiszka wrote:
>=20
> 	Kim Chuan Lim wrote:
> 		I am interested with the hard real time serial port example from..
> 		http://www.captain.at/xenomai-serial-port-example.php
>=20
> 		The following is the error message i received when i try to run the
> 		program..
> 		./rt_serial_uprog
> 		rt_serial_uprog: PRESS CTRL-C to EXIT
> 		rt_serial_uprog: timer started
> 		rt_serial_uprog: can't open rtser0
> 		rt_serial_uprog: stop timer
>=20
> 		May i know which device is "rtser0"?
> 		shall i just change it to /dev/ttyS0?
>=20
> 	Check Hannes' doku: you have to load the xeno_16550A driver.
>=20
>=20
> I'm also a beginner on Xenomai and I have the same problem as Kim Chuan=
 Lim.
>  I verified my configuration : RTDM skin and 16550A driver are both int=
egrated=20
> in my 2.6.16 kernel, so these modules don't exist.
> Shall I create rtser0 node ?

Nope, there is no such thing as device nodes under Xenomai's RTDM skin.
But when your 16550A driver is compiled into the kernel, you have to
provide some hardware parameters via the boot command line to configure
at least one port:

8250.nr_uarts=3D0		(to keep Linux away from using the UARTs)
xeno_16550A.ioaddr=3D0x3f8 (first UART)
xeno_16550A.irq=3D4	(first UART)

Of course, you can also increase 8250.nr_uarts and move the 16550A
driver to some other port etc. I guess this should make it into
doc/txt/16550A-driver.txt as well...

Alternatively, turning xeno_16550A into a module again allows you to
reconfigure your hardware on a running system. Then that mentioned doc
file fully applies again.

Jan


--------------enigE8539C93EA23ECA7E1E5F1F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEs76bncNeS9Q0k+IRAoPsAJ0bVQzWQFbBe2PW3U8Y8pE8so6EbgCfc6D0
Xz8qu4PeA1QV5JnrUKnhBXk=
=SSaY
-----END PGP SIGNATURE-----

--------------enigE8539C93EA23ECA7E1E5F1F5--

