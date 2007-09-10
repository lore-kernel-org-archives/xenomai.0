Message-ID: <46E58BE4.9090109@domain.hid>
Date: Mon, 10 Sep 2007 20:24:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
In-Reply-To: <1ce16a2c0709100614u3f23fce9yd2be767406fa536a@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig57BAA791F6CDE7A8688BABA3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] adding PCI support to 16550A.c
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
--------------enig57BAA791F6CDE7A8688BABA3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bachman Kharazmi wrote:
> I've tried to make the pci serial controller visable to the 16550
> driver by adding:
> ## FROM 16550A.c
> static int rt_16550_interrupt(rtdm_irq_t * irq_context)
> {
> 	struct rt_16550_context *ctx;
> 	unsigned long base;
> 	int mode;
> 	int iir;
> 	uint64_t timestamp =3D rtdm_clock_read();
> 	int rbytes =3D 0;
> 	int events =3D 0;
> 	int modem;
> 	int ret =3D RTDM_IRQ_NONE;
> // TEST
> struct pci_dev *pdev =3D NULL;  // from
> http://bachman.tor.lindesign.se/tmp/driver/sunix/snx_golden.c
> pdev =3D pci_get_device(0, 0, pdev); // from
                       ^^^^^^
You need to provide the fitting vendor and device ID here. Then you have
to call pci_device_enable on that pdev - if it's not NULL (ie. not
found). That should tell us if it's already enough to enable the device.

Jan


--------------enig57BAA791F6CDE7A8688BABA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG5YvkniDOoMHTA+kRAiK8AJwKNt1gRR5bOyISME0YZhfoTbTzMQCeM4is
bc+XGhnH6CjrSlgY0eTw64Y=
=GXxp
-----END PGP SIGNATURE-----

--------------enig57BAA791F6CDE7A8688BABA3--

