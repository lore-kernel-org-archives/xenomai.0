Date: Fri, 4 Nov 2016 14:43:52 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20161104144352.0a7da68e@md1em3qc>
In-Reply-To: <784521789.97019.1478258544457@mail.yahoo.com>
References: <1535963144.720900.1478127449409.ref@mail.yahoo.com>
 <1535963144.720900.1478127449409@mail.yahoo.com>
 <20161103094909.6a61f436@md1em3qc>
 <1380536594.723535.1478212421067@mail.yahoo.com>
 <20161104090659.7aba3080@md1em3qc>
 <784521789.97019.1478258544457@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] use of xenomai,
 how to build xenomai3 with graphical desktop in raspberry pi 2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jinlong Shen <shenjinlong@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Fri, 4 Nov 2016 11:22:24 +0000
schrieb Jinlong Shen <shenjinlong@yahoo.com>:

> Hi Henning,
> Hardware version: Raspberry Pi 2WLAN: Edimax USB-WLAN Stick
> Software Version:(1) Linux/Raspberry rpi-4.1.y (Version=3D4 Patch;
> Level=3D 1; Sublevel
> =3D21)(2)Xenomai-3.0.2(3)ipipe-core-4.1.18-arm-4.patch I used
> bcm2709_defconfig. Does it play a role here? With the installation
> from Noobs, it can find the Access Point and type in the
> password.=C2=A0With Xenomai-Linux, I can find the Access Point as well.
> However, I can not get connected. lsusb ifconfig shows that there is
> wlan0 Phy is there.

If the interfaces are there but not working you seem to have the right
modules, maybe you are still missing the firmware blobs?
But that problem does not seem to be a xenomai one. I suggest you try
with a regular 4.1.18 kernel. My guess is that you are missing one step
required to get the WIFI working and the problem can be reproduced with
any similar kernel.
Trying that should confirm that you do not have a problem with the ipipe
kernel and will put you into a position where you can ask around in
other communities as well.

Henning

> Best regards,Jinlong
>=20
>       From: Henning Schild <henning.schild@siemens.com>
>  To: Jinlong Shen <shenjinlong@yahoo.com>=20
>  Sent: Friday, November 4, 2016 9:06 AM
>  Subject: Re: [Xenomai] use of xenomai, how to build xenomai3 with
> graphical desktop in raspberry pi 2=20
> Am Thu, 3 Nov 2016 22:33:41 +0000
> schrieb Jinlong Shen <shenjinlong@yahoo.com>:
>=20
> > Hi Henning,=C2=A0
> > many thanks. It worked.=C2=A0
> > I followed your advice and it worked. However, it is not able to
> > automatic discover Router/Access Point. Any hint? Best
> > regards,Jinlong =20
>=20
> If that worked with the original kernel you network adaptor might
> require an external module. The kernel log should tell you which
> module is the driver for the interface. If your new kernel is missing
> that module you will have to find the sources for it and compile it
> for the new kernel.
> If it never worked you should read a general linux networking guide or
> something specific to your distribution.
>=20
> I do not know the raspi hardware or the kernel support for it. But
> maybe you can let us know which kernel version you are using and what
> kind of network adaptor you are using. The one on the SoC or something
> attached over USB?
>=20
> Henning
>=20
> >=C2=A0 =C2=A0 =C2=A0 From: Henning Schild <henning.schild@siemens.com>
> >=C2=A0 To: Jinlong Shen <shenjinlong@yahoo.com>=20
> > Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
> >=C2=A0 Sent: Thursday, November 3, 2016 9:49 AM
> >=C2=A0 Subject: Re: [Xenomai] use of xenomai, how to build xenomai3 with
> > graphical desktop in raspberry pi 2=20
> > Hey,
> >=20
> > that is not really a xenomai question. More a question on how to
> > prepare a root fs for the board. Or how to exchange the kernel in an
> > existing root fs.
> >=20
> > As far as i understand it you modified an existing image, putting
> > the xenomai kernel and userland in. If that made you loose the GUI
> > you probably forgot some CONFIG_ in the kernel, or you did not copy
> > the kernel modules.
> > Try "make modules_install" with INSTALL_MOD_PATH in your kernel dir
> > to get the modules in a place where you can archive and copy them.
> > If the distro is using any external modules you will have to rebuild
> > and install those as well.
> >=20
> > regards,
> > Henning
> >=20
> >=20
> > Am Wed, 2 Nov 2016 22:57:29 +0000
> > schrieb Jinlong Shen <shenjinlong@yahoo.com>:
> >  =20
> > > Since I may understand it incompletely, I try to give some details
> > > that may help to get myself understood. I wish to learn how to use
> > > Xenomai3 in cobalt mode. I followed the procedure in the following
> > > link with some
> > > modification.=C2=A0http://www.blaess.fr/christophe/2016/05/22/xenomai=
-3-sur-raspberry-pi-2/I
> > > could generate Linux/Xenomai image as well as the user space. I am
> > > having difficult in using buildroot. Since I am not able to
> > > populate a naive SD card with the bootloader(s) and file system,
> > > I installed Raspbian to the SD card using Noobs. =C2=A0After that, I
> > > copied the aforementioned Linux/Xenomai image (renamed as
> > > kerlnel7.img) and User Space to the SD card. Many thanks, the
> > > test functions worked!!! My questions are as follows: (1) I wish
> > > to avoid use of Noobs. How can produce a minimal system on a
> > > naive SD card from an engineering PC? I guess the minimal means
> > > the following=C2=A0 =C2=A0 =C2=A0 (a) the file system (b) bootcode.bi=
n. (c) .elf
> > > for GPU. (d) configure file to specify memory division between
> > > GPU and ARM cores. (2) The system created with Noobs is having
> > > nice HMI ( graphical desktop over HDMI + keyboard). In Xenomai, I
> > > do not have it. How and where can I configure it in order to have
> > > the normal HMI (keyboard, desktop) again?
> > >=20
> > > Best regards,Jinlong
> > > _______________________________________________
> > > Xenomai mailing list
> > > Xenomai@xenomai.org
> > > https://xenomai.org/mailman/listinfo/xenomai   =20
> >=20
> >=20
> >=C2=A0 =C2=A0  =20
>=20
>=20
>   =20


