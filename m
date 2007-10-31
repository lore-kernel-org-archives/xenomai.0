From: Leopold Palomo Avellaneda <lepalom@domain.hid>
Date: Wed, 31 Oct 2007 10:36:01 +0100
References: <200709201549.13035.lepalom@domain.hid>
	<200710301604.45488.lepalom@domain.hid>
	<200710310117.44938.berlemont.hauw@domain.hid>
In-Reply-To: <200710310117.44938.berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1732368.NYUqm5EMia";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200710311036.01469.lepalom@domain.hid>
Subject: Re: [Xenomai-help] Comedi driver for use with xenomai
Reply-To: lepalom@domain.hid
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

--nextPart1732368.NYUqm5EMia
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A Dimecres 31 Octubre 2007, Alexis Berlemont va escriure:
> Hi,
>
> > > modprobe firmware?
> >
> > $:/usr/src/xenomai-comedi-rtdm-dev$ sudo modprobe firmware
> > FATAL: Module firmware not found.
>
> Would you mind checking, in your kernel ".config" file, that the option
> CONFIG_FW_LOADER is enabled?

yes, it is. The debian config put is as a module. I load it (I guess) with :

sudo modprobe firmware_class

no problem.=20

Then I load the comedi driver:

sudo insmod comedi_kcore/comedi.ko =20

no problem,

And after, the jr3 driver, but I got with dmesg:=20

jr3pci: module license 'unspecified' taints kernel.
jr3pci: no version for "comedi_add_drv" found: kernel tainted.
jr3pci: Unknown symbol device_unregister
jr3pci: Unknown symbol device_register


so, I cannot load the driver. What I'm doing grong?

> > > > Ok, I have download, compiled and installed. I'm using xenomai
> > > > 2.4-rc4. All have compiled without any problem. Howeber I don't know
> > > > how to use it.
>
> If you manage to insmod this driver, the second step would be : trying to
> attach the jr3_pci driver to a comedi (rtdm) device:
>
> comedi_bin/bin_nrt/comedi_config comedi0 jr3_pci
>
> This should initialize the hardware and download the firmware (available =
in
> the comedi-non-free package from www.comedi.org, I think).
> The instructions are located in the driver source header:
>
> /*
> Driver: jr3_pci
> Description: JR3/PCI force sensor board
> Author: Anders Blomdell <anders.blomdell@domain.hid>
> Devices: [JR3] PCI force sensor board (jr3_pci)
>
>   The DSP on the board requires initialization code, which can
>   be loaded by placing it in /lib/firmware/comedi.
>   The initialization code should be somewhere on the media you got
>   with your card. One version is available from http://www.comedi.org
>   in the comedi_nonfree_firmware tarball.
>
> ...
> */

this is done. I have unload this package and put it on  /lib/firmware/comedi

> I may be unreachable until the end of this week.

no problem.

> Many thanks for your tests!

nops, many thanks to _you_ for the driver

Best regards,

Leo

=2D-=20
=2D-
Linux User 152692
PGP: 0xF944807E
Catalonia

--nextPart1732368.NYUqm5EMia
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKEyBaC7AnPlEgH4RAnH2AJ9R0BYf0ptpNqMowhV2d9wHHHqzWACfZqlI
+8W9Tl7ClUYto2iFs9SDR10=
=QDPh
-----END PGP SIGNATURE-----

--nextPart1732368.NYUqm5EMia--

