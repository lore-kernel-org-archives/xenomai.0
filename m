Message-ID: <4533D031.4040306@domain.hid>
Date: Mon, 16 Oct 2006 20:32:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] which way to obtain irq#
References: <4533C841.3040108@domain.hid>
In-Reply-To: <4533C841.3040108@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C8BAB8D95295937C260B74B"
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
To: Marcelo Coelho <mjcoelho@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7C8BAB8D95295937C260B74B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Marcelo Coelho wrote:
> Hi!
>=20
>=20
> I'm developing a driver based on RTDM, and i'm having some problems
> related to IRQ discovery (related to the fact that the driver is
> starting to do something).
>=20
> So, there is 2 ways to obtain the IRQ number:
>     pci_device -> irq
> or
>     pci_read_config_byte( pci_device, PCI_INTERRUPT_LINE, (unsigned
> char*) &irq )
>=20
>=20
> The difference between these is that the 1st presents the "real" irq
> number (between 1 and 15) and the other presents the "virtual" irq
> (between 1 and 255).

[I think you swapped the terms "real" and "virtual" here, no?]

You have to use the first one like any Linux driver (RTDM is no
different in this regard).

>=20
>=20
> From your experience, is there any problem using the virtual irq number=

> (the 1st option)?
>=20
>=20
>=20
> Thanks for your answers!!
>=20
>=20

Jan


--------------enig7C8BAB8D95295937C260B74B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFM9AxniDOoMHTA+kRAjL3AJ9nzRFFQ3KulcWtflNxAXcdBRIJLgCfcuUw
v5Nedub4M334P5hNiAvrmrg=
=o6TD
-----END PGP SIGNATURE-----

--------------enig7C8BAB8D95295937C260B74B--

