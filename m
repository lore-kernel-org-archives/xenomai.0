Date: Sat, 28 Apr 2007 14:54:42 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Message-ID: <20070428125442.GB7003@domain.hid>
References: <4850965.1177589052502.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <4850965.1177589052502.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* M. Koehrer <mathias_koehrer@domain.hid> [2007-04-26 14:04]:
>=20
> I am using kernel 2.6.20.4 and Xenomai 2.3.1 on a SMP enabled dual core P=
entium 4.
> Everything works fine when I do not enable the CONFIG_PCI_MSI (Messages s=
ignaled interrupts) for
> PCI Express.
> As I am always short with interrupts I want to use MSI for the PCIe base
> I/O devices like Ethernet.

Didn't follow the thread, but as workaround to disable MSI in Linux
you can boot with 'pci=3Dnomsi'.


Thanks,
   Bernhard
--=20
M=FCtter lieben ihre Kinder mehr, als V=E4ter es tun, weil sie sicher sein =
k=F6nnen,
dass es ihre sind.
	-- Aristoteles

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQCVAwUBRjNEDuiVHo+2lFT9AQLi3gP6AzxjIUAAe0Khy9ViKOQEQ0xEIRIIHxzx
SU4oBlVS9xA7wGsMaHvrS3S1ocI0ntpW8M1329lz2QaUJ05NT9B0MlFKGyP0t9tV
MQ3rXHaOq7jz8oavFMxhjaDUYqen81g8NO+DpjOOReO9dKMBcLiffmAt8kkqQgKU
Ru1K3KDIYZg=
=zAIX
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--

