From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 19 Nov 2007 20:28:22 +0100
References: <473391B0.5040809@domain.hid>
	<200711152309.00386.niklaus.giger@domain.hid>
	<473CC49D.3030504@domain.hid>
In-Reply-To: <473CC49D.3030504@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200711192028.23604.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] buildbot and state of xenomai on PPC440?
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Hi Steve

Thanks for your reply. I compiled the kernel.
But I can only load a kernel which was configured for the ppc architecture
make -j2 ARCH=3Dppc CROSS_COMPILE=3Dppc_4xx- O=3D../build-linux-sequoia-DEN=
X-v2.6.23=20
sequoia_defconfig

If I pass
make -j2 ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_4xx-=20
O=3D../build-linux-sequoia-DENX-v2.6.23 sequoia_defconfig
the board hangs after=20
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.23
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1461799 Bytes =3D  1.4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
I passed the same arguments to the kernel as before. Do I have to specify=20
something different? For the kernel? or a u-boot parameter?

Thanks in advance for your help

Best regards


Am Donnerstag, 15. November 2007 schrieb Steven A. Falco:
> I have a Sequoia board.  I am using ELDK 4.1 for compiler tools, and the
> kernel is from the denx git (version 2.6.23).  I am using the svn
> version of Xenomai.  All seems pretty good.
>
>     Steve
>
> Niklaus Giger wrote:
> > Hi
> >
> > For a series of personal problems I have been away from the xenomai
> > project and the buildbot I maintained for some time is quite bit rotten.
> > If there is interest around I think I will soon be able to put in some
> > work to bring into shape again.
> >
> > I have a Yosemite PPC440 board at home which I could easily integrate in
> > my buildbot environment. At work I sometimes can run tests on our Sequo=
ia
> > evaluation board.
> >
> > At work I was very busy bringing up a custom HW board with a PPC440EPx
> > (very close to the Sequoia evaluation board from AMCC) on it. It is
> > running U-Boot and in June I ported Linux in a spare couple of hours and
> > it compiled during a weekend happily the Linux kernel. As I am having
> > problems getting a proprietary OS into a good shape (performance
> > problems, unable to change the default page size). Also sometimes I
> > observe a odd application behaviour (e.g. spurious problems running some
> > testsuites).
> >
> > Therefore I would like to get my old (but only half finished) port of o=
ur
> > base library to the Xenomai vxWorks skin working again.
> >
> > Following the xenomai mailing list there seems to be some activity on
> > PPC440. Could someone please tell me which kernel (denx, stock
> > kernel.org) flavour/version against which xenomai worked well? What were
> > the exacts parameters for the prepare-kernel.sh? Are these parameters
> > still correct against the trunk?
> >
> > Any hints would be greatly appreciated.
> >
> > Best regards
> >
> > Niklaus Giger



=2D-=20
Niklaus Giger
Wieshoschet 6
CH-8753 Mollis
Tel. ++41 55 612 20 54 (privat)
Tel. ++41 55 618 64 68 (Gesch=E4ft)

