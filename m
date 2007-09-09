Message-ID: <46E41146.1060701@domain.hid>
Date: Sun, 09 Sep 2007 17:29:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>	<1189285467.6013.20.camel@domain.hid>	<1ce16a2c0709090730o1a803c99r70aea4410eda49ed@domain.hid>	<46E4085F.3080509@domain.hid>
	<1ce16a2c0709090809y5e1732adj5081fcb556734142@domain.hid>
In-Reply-To: <1ce16a2c0709090809y5e1732adj5081fcb556734142@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDC5CA3A87B0D279A693515DC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] serial module problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bachman Kharazmi <bahkha@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDC5CA3A87B0D279A693515DC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> sandbox:~/golden_2.6# ls
> Makefile  README  driver  snxdump  snxlink  snxmknod  snxterm
> sandbox:~/golden_2.6# modprobe snx_golden

See, you already need some out-of-tree driver to make this adapter work
with standard Linux - and you expect the driver that comes with Xenomai
to work with it out of the box?

The question is now *what* is special about this adapter and its driver.
Where do you have the code from? What's its license?

> sandbox:~/golden_2.6# setserial -g /dev/ttySNX0
> /dev/ttySNX0, UART: 16650, Port: 0xbc00, IRQ: 3
> sandbox:~/golden_2.6# setserial -g /dev/ttySNX1
> /dev/ttySNX1, UART: 16650, Port: 0xbc08, IRQ: 3
> sandbox:~/golden_2.6# setserial -g /dev/ttySNX2
> /dev/ttySNX2, UART: 16650, Port: 0xb800, IRQ: 3
> sandbox:~/golden_2.6# setserial -g /dev/ttySNX3
> /dev/ttySNX3, UART: 16650, Port: 0xb808, IRQ: 3
> sandbox:~/golden_2.6# setserial -g /dev/ttySNX4
> /dev/ttySNX4, UART: 16650, Port: 0xb400, IRQ: 3
> etc..
>=20
> It's a sunix 4066 8port pci serial controller.
>=20
> The irq file shows:
> sandbox:~/golden_2.6# cat /proc/xenomai/irq
> IRQ         CPU0
>   0:         221         [timer]
>  34:       10767         [virtual]
>=20
> If this is a irq releated problem, how can I solve it? :/

IRQs only show up there when they are in use, and that is the case when
the port is opened (ie. the test program is running).

Jan


--------------enigDC5CA3A87B0D279A693515DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG5BFGniDOoMHTA+kRAnF2AJ9H5LxsW5sV/+DDPNMArxPX//ExtACfQKiY
NeLfMtAoEJ1PwqbH/RQohP0=
=aAek
-----END PGP SIGNATURE-----

--------------enigDC5CA3A87B0D279A693515DC--

