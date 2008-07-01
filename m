From: Leopold Palomo Avellaneda <leo@domain.hid>
Date: Tue, 1 Jul 2008 22:44:38 +0200
References: <200807010043.33331.leo@domain.hid>
	<486A9516.6000703@domain.hid>
In-Reply-To: <486A9516.6000703@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1720233.2UUyPhGUB0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200807012244.42278.leo@domain.hid>
Subject: Re: [Xenomai-help] IRQs and PCIs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--nextPart1720233.2UUyPhGUB0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A Dimarts 01 Juliol 2008, Gilles Chanteperdrix va escriure:
> Leopold Palomo Avellaneda wrote:
> > Hi,
> >
> > maybe is an off toppic, but probably some like me has this issue. I have
> > a mainboard with several PCI and two PCIe. I can configure the PCIe to
> > use with rtnet and xenomai without any important problem.
> >
> > The mobo has an eth and firewire and vga incorporated, so the pci are
> > free. But now, I would like to add a pci network card. I have three:
> > - on for our environtment
> > - two for the rtnet (two robot controlers)
> >
> > and then I would like to have 4
> > - one for another network
> >
> > The problem that I have and I don't know how to solve is that the new p=
ci
> > network card share an irq with another device. So, in my case, I have
> > problems with this. With rtnet, I solve this using pcie devices, but now
> > I cannot.
> >
> > I have configure the xenomai kernel following the FAQ, and I have tested
> > to assign an IRQ in the BIOS. But I have not be able to make the
> > interface works. I have delays in the interface, and google says ;-) th=
at
> > is a problems of sharing IRQs with the eth. And I believe in that ...
> >
> > So, thinking that I would like to use this eth in a normal environment
> > (not rtnet,) but in a box using xenomai, some of you have some "magical"
> > idea, kernel parameter, etc to solve this issue?
> >
> > Thanks in advance,
>
> Well, maybe you can configure the cards controlled by rtnet to actually
> share their irq ? Maybe this would free irqs for other cards ?

it's no problem the rtnet card. I bought two pci-e and they have the MSI an=
d=20
irq 1275. It's the normal pci.

Today I have done it work with the irqpoll option. But I don't know if this=
=20
could make problems to the realtime.

Leo

=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart1720233.2UUyPhGUB0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIapc6aC7AnPlEgH4RAhEpAKCeXXq5h42OMFuVWP/OUL7jH9/NhgCfeQKq
FqBahFvwcsj3RUYzpNBqGeI=
=5duS
-----END PGP SIGNATURE-----

--nextPart1720233.2UUyPhGUB0--

