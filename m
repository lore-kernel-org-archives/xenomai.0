From: Leopold Palomo Avellaneda <leo@domain.hid>
Date: Tue, 1 Jul 2008 00:43:29 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8269032.1ADHaBy0Y0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200807010043.33331.leo@domain.hid>
Subject: [Xenomai-help] IRQs and PCIs
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

--nextPart8269032.1ADHaBy0Y0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

maybe is an off toppic, but probably some like me has this issue. I have a=
=20
mainboard with several PCI and two PCIe. I can configure the PCIe to use wi=
th=20
rtnet and xenomai without any important problem.

The mobo has an eth and firewire and vga incorporated, so the pci are free.=
=20
But now, I would like to add a pci network card. I have three:
=2D on for our environtment
=2D two for the rtnet (two robot controlers)

and then I would like to have 4
=2D one for another network

The problem that I have and I don't know how to solve is that the new pci=20
network card share an irq with another device. So, in my case, I have =20
problems with this. With rtnet, I solve this using pcie devices, but now I=
=20
cannot.

I have configure the xenomai kernel following the FAQ, and I have tested to=
=20
assign an IRQ in the BIOS. But I have not be able to make the interface=20
works. I have delays in the interface, and google says ;-) that is a proble=
ms=20
of sharing IRQs with the eth. And I believe in that ...

So, thinking that I would like to use this eth in a normal environment (not=
=20
rtnet,) but in a box using xenomai, some of you have some "magical" idea,=20
kernel parameter, etc to solve this issue?

Thanks in advance,

Regards,

Leo


=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart8269032.1ADHaBy0Y0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIaWGVaC7AnPlEgH4RAoWrAKCUW+x+m5sVxrtS9vVVlbRZvkTrGQCfVqX+
CRNmuZ1Vw5LIQt1DX1oakJE=
=RwJO
-----END PGP SIGNATURE-----

--nextPart8269032.1ADHaBy0Y0--

