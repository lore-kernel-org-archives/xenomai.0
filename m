Message-Id: <8slc8n$imkgbb@domain.hid>
From: "Gao" <gwysu@domain.hid>
Date: Wed, 1 Sep 2010 17:02:52 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1283330338.1709.1919.camel@domain.hid>
Subject: Re: [Xenomai-help] Powerpc kernel cannot boot with xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Thank you Philippe very much. Yes, it seems that Xenomail may not =
support
the MPC870 cpu. But you mean the Xenomai with linux 2.6.34 kernel can
support it, right? Another question, is there a officail document that =
say
runing Xenomai on the mpc855 family processors needs 2.6.34 kernel?=20

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: 2010=C4=EA9=D4=C21=C8=D5 16:39
To: Gao
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] Powerpc kernel cannot boot with xenomai

On Wed, 2010-09-01 at 16:11 +0800, Gao wrote:
> Hi Philippe,
>=20
> Are you sure  xenomai(2.5.4) doesn't support the cpu MPC870? Thank =
you.
>=20

I'm saying that your particular board is not known to run Xenomai, =
nothing
else. Those which officially do are listed here:
http://www.xenomai.org/index.php/Embedded_Device_Support#Supported_Archit=
ect
ures

In any case, if you want to run Xenomai on a processor from the mpc855
family, 2.6.34 is a requirement.

>=20
> Wenyi Gao
>=20
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org]
> Sent: 2010=C4=EA9=D4=C21=C8=D5 15:53
> To: Gao
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Powerpc kernel cannot boot with xenomai
>=20
> On Wed, 2010-09-01 at 15:47 +0800, Gao wrote:
> > Hi All,
> > =20
> > I patched the kernel with xenomai, but the kernel "cuImage" cannot=20
> > boot up, below is the console output:
> >     =20
> > U-Boot 2009.06.00-svn21572 (Aug 24 2010 - 11:20:12)
> > =20
> > CPU:   MPC885ZPnn at 100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present
>=20
> This board is not supported. What goes wrong is likely the I-pipe=20
> patch for this particular hardware.
>=20
> > Board: RXT-2000
> > I2C:   ready
> > DRAM:  32 MB
> > 1 gd->ram_size =3D (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> > 2 gd->ram_size =3D (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> > IRIS: bd->bi_memsize (2000000) gd(ff002ec0)->gd->ram_size(2000000)
> > IRIS: bd->bi_memsize (2000000)
> > Now running in RAM - U-Boot at: 01f89000
> > FLASH: 16 MB
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   FEC ETHERNET
> > IRIS: IDE testing
> > IRIS: CONFIG_CMD_IDE
> > PCMCIA:IRIS: NO CONFIG_START_IDE
> > SanDisk SDP 5/3 0.6
> >             Fixed Disk Card
> >             IDE interface
> >             [silicon] [unique] [single] [sleep] [standby] [idle]=20
> > [low power] Bus 0: OK
> >   Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#:
> > AOZ043010001455
> >             Type: Removable Hard Disk
> >             Capacity: 1918.0 MB =3D 1.8 GB (3928176 x 512) Hit any =
key=20
> > to stop autoboot:  0 ## Booting kernel from Legacy Image at 00100000 =

> > ...
> >    Image Name:   Linux-2.6.33.4
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1873951 Bytes =3D  1.8 MB
> >    Load Address: 00400000
> >    Entry Point:  00400558
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK Memory <- <0x0 0x0> (0MB)
> > ENET0: local-mac-address <- 00:00:00:00:00:00 CPU clock-frequency <- =

> > 0x0 (0MHz) CPU timebase-frequency <- 0x0 (0MHz)
> > =20
> > zImage starting: loaded at 0x00400000 (sp: 0x01b88990) Allocating=20
> > 0x3d6de0 bytes for kernel ...
> > gunzipping (0x00000000 <- 0x0040c000:0x007fd97c)...done 0x3adf34=20
> > bytes
> > =20
> > Linux/PowerPC load:
> > Finalizing device tree... flat tree at 0x80a300
> >=20
> > =20
> > =20
> > Before I patched xenomai, the kernel can boot up with below console
> > output:
> > =20
> > =20
> > CPU:   MPC885ZPnn at 100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present
> > Board: RXT-2000
> > I2C:   ready
> > DRAM:  32 MB
> > 1 gd->ram_size =3D (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> > 2 gd->ram_size =3D (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
> > IRIS: bd->bi_memsize (2000000) gd(ff002ec0)->gd->ram_size(2000000)
> > IRIS: bd->bi_memsize (2000000)
> > Now running in RAM - U-Boot at: 01f89000
> > FLASH: 16 MB
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   FEC ETHERNET
> > IRIS: IDE testing
> > IRIS: CONFIG_CMD_IDE
> > PCMCIA:IRIS: NO CONFIG_START_IDE
> > SanDisk SDP 5/3 0.6
> >             Fixed Disk Card
> >             IDE interface
> >             [silicon] [unique] [single] [sleep] [standby] [idle]=20
> > [low power] Bus 0: OK
> >   Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#:
> > AOZ043010001455
> >             Type: Removable Hard Disk
> >             Capacity: 1918.0 MB =3D 1.8 GB (3928176 x 512) Hit any =
key=20
> > to stop autoboot:  0 ## Booting kernel from Legacy Image at 00100000 =

> > ...
> >    Image Name:   Linux-2.6.33.4
> >    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> >    Data Size:    1697346 Bytes =3D  1.6 MB
> >    Load Address: 00400000
> >    Entry Point:  00400558
> >    Verifying Checksum ... OK
> >    Uncompressing Kernel Image ... OK Memory <- <0x0 0x2000000>=20
> > (32MB)
> > ENET0: local-mac-address <- 00:d0:dd:ff:20:00 CPU clock-frequency <- =

> > 0x5f5e100 (100MHz) CPU timebase-frequency <- 0x2faf08 (3MHz) CPU=20
> > bus-frequency <- 0x2faf080 (50MHz)
> > =20
> > zImage starting: loaded at 0x00400000 (sp: 0x01b88990) Allocating=20
> > 0x35e3f0 bytes for kernel ...
> > gunzipping (0x00000000 <- 0x0040c000:0x00799450)...done 0x349f2c=20
> > bytes
> > =20
> > Linux/PowerPC load: root=3D/dev/sda1 rw rootfstype=3Dext3=20
> > ip=3D169.254.0.2::169.254.0.1:255.255.0.0 console=3DttyCPM0,38400=20
> > Finalizing device tree... flat tree at 0x7a6300 Using RxT-Carrier=20
> > machine description ...................
> >=20
> > =20
> > It seems the boot loader doesn't pass the boot parameters to the=20
> > kernel that cannot boot up. Any one can help me? Thanks in advance.
> > =20
> > =20
> > =20
> > =20
> > Best regards,
> > Wenyi Gao
> > =20
> >=20
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>=20
> --
> Philippe.
>=20
>=20
>=20

--
Philippe.




