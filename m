Message-ID: <4D21FF77.5000101@domain.hid>
Date: Mon, 03 Jan 2011 17:55:19 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4D21E45B.90003@domain.hid>
In-Reply-To: <4D21E45B.90003@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7E8A2B48730F5D6761411734"
Subject: Re: [Xenomai-help] 16550A driver and 2-port pci board, irq sharing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E8A2B48730F5D6761411734
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03.01.2011 15:59, Stefan Kisdaroczi wrote:
> Hi Jan,
>
> I try to add support for the Moxa CP132 RS422 dualport pci board to the=

> 16550A driver. In the function rt_16550_open() the call to
> rtdm_irq_request() fails with EBUSY (-16) for the second port.
>
> Looking at the source the driver seems to be able to handle multiple
> serial ports with the same (shared) IRQ. Any hints ?
>  =20

enabling CONFIG_XENO_OPT_SHIRQ did help ... sorry
Stefan



--------------enig7E8A2B48730F5D6761411734
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0h/30ACgkQIPTw9rIdn6rCRQCcDw1MmTmTX2K/5yD/ZvGiCKTm
bscAn09ffueAiOvHXqskGsRRVoLCYHzE
=Xwwm
-----END PGP SIGNATURE-----

--------------enig7E8A2B48730F5D6761411734--

