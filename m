Message-ID: <476076C6.4060604@domain.hid>
Date: Thu, 13 Dec 2007 01:03:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0C9896A4B6D338488AD6FFFE58BAEF1001DB8EEF@serveur3.lgm.com>
In-Reply-To: <0C9896A4B6D338488AD6FFFE58BAEF1001DB8EEF@serveur3.lgm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8BA4D6BCC8DBAFF6098C801A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] CP-118U RTDM Driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: DOURNES Guillaume <Guillaume.DOURNES@lgm.fr>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8BA4D6BCC8DBAFF6098C801A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

DOURNES Guillaume wrote:
> Hi,
>=20
> =20
>=20
> I have a kernel 2.6.20.9 with Xenomai 2.3.4.
>=20
> I chose a Moxa CP-118U board on my project, to be able to drive this PC=
I board with the xeno_16550A module.
>=20
> So I tried to drive one port of this board by calling :
>=20
> =20
>=20
> modprobe mxser
>=20
> rmmod mxser
>=20
> modprobe xeno_16550A ioaddr=3D0xb500 irq=3D5
>=20
> =20
>=20
> And I run my simple software of test.
>=20
> =20
>=20
> But when the task is started, my computer become very slow, as a proces=
s eats a lot of CPU load.
>=20
> This state stay even if I stop the software by CTRL+C, and even if I di=
scharge the xeno_16550A module.
>=20
> Only a reboot allow to go I a good state.
>=20
> =20
>=20
> My question is why the CPU become very loaded, whereas my software do n=
othing.
>=20

Interrupt flood? Check the system activity via /proc/xenomai/irq and
proc/xenomai/stat.

> =20
>=20
> I tried my software with the serial port on my mother board, and with t=
his port, the system stay in a good state. It becomes not very slow.
>=20
> =20
>=20
> Moreover, I contact Moxa and his response was :
>=20
> "I am afraid that you cannot use 16550A module to driver CP-118U.
>=20
> The reason is because we use MU860 but not 16550A in CP118U."
>=20

There might be some subtle minor differences in the MU860 that causes
the existing driver to fail. Someone would have to study the mxser code
in this regard...

Jan


--------------enig8BA4D6BCC8DBAFF6098C801A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHYHbHniDOoMHTA+kRAuQVAJwNY0wBdNzLEMSEflMk33zgbfaLTwCfcWxH
lJPXUaG6JXoLSSbAzmJwjLI=
=2kh5
-----END PGP SIGNATURE-----

--------------enig8BA4D6BCC8DBAFF6098C801A--

