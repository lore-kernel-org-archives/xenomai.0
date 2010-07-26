From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <1279048661.31665.81.camel@domain.hid>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 10:06:07 -0300
Message-ID: <1280149567.1856.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel compilation procedures for imx51
Reply-To: flavio.alves@domain.hid
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

Hello,

I tried to perform the steps indicated by the README and I am still
having problems to correctly patch the linux kernel with xenomai for the
imx51 processor.

I followed the README file from Xenomai package and the Denx
instructions
(http://www.denx.de/en/view/Software/SoftwareXenomaiProjects#Xenomai_Real_Time_Support_for_i).

Here are the steps that I performed and I would like to know what am I
doing wrong or if I can continue that it will work correctly:

* mkdir linux
* cd linux
* git clone git://git.denx.de/linux-2.6-denx.git
* cd linux-2.6-denx
* git checkout rel_imx_2.6.31_10.02.00
* wget http://download.gna.org/xenomai/stable/
* wget
http://www.denx.de/en/pub/Software/SoftwareXenomaiProjects/adeos-ipipe-2.6.31-arm-1.15-01-imx51.patch
* tar xjvf xenomai-2.5.3.tar.bz2
* cd xenomai-2.5.3/ksrc/arch/arm/patches
* wget
http://www.denx.de/en/pub/Software/SoftwareXenomaiProjects/adeos-ipipe-2.6.31-arm-1.15-01.patch
* cd ../../../..
* scripts/prepare-kernel.sh --linux=/home/linux/imx51/linux-2.6-denx
--adeos=/home/linux/imx51/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.31-arm-1.15-01.patch --arch=arm --verbose

Preparing kernel 2.6.31 in /home/linux/imx51/linux-2.6-denx...
Adeos found - bypassing patch.
Adeos/arm 1.15-01 installed.
Links installed.
Build system ready.

* cd ../linux-2.6-denx
* patch -p0 < ../adeos-ipipe-2.6.31-arm-1.15-01-imx51.patch

patching file b/arch/arm/Makefile
Hunk #1 FAILED at 50.
1 out of 1 hunk FAILED -- saving rejects to file b/arch/arm/Makefile.rej
patching file b/arch/arm/mach-mx51/mx51_3stack.c
Hunk #1 FAILED at 798.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-mx51/mx51_3stack.c.rej
patching file b/arch/arm/plat-mxc/time.c
Hunk #1 FAILED at 113.
Hunk #2 FAILED at 434.
Hunk #3 FAILED at 453.
Hunk #4 FAILED at 488.
Hunk #5 FAILED at 508.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/time.c.rej

Best regards,

Flavio

On Tue, 2010-07-13 at 16:17 -0300, Flavio Alves wrote:
> Hello Gilles,
> 
> On Tue, 2010-07-13 at 20:54 +0200, Gilles Chanteperdrix wrote:
> > Flavio Alves wrote:
> > > Hello,
> > > 
> > > I would like to build a linux kernel with Xenomai to run on a iMX51
> > > board (iMX51EVK).
> > > 
> > > I am currently using the last version of the BSP from Freescale website
> > > (LTIB). If I apply the BSP's patches before the Xenomai's patches, the
> > > patches are not applied. So, I first apply Xenomai's patches and then
> > > BSP's patches.
> > > 
> > > The problem in this approach is that I have compilation errors, even if
> > > I have all the patches successfully applied.
> > > 
> > > I saw at Denx homepage that there is a specific patch for Xenomai for
> > > iMX51. But the patch provided by the website must be used into the
> > > "rel_imx_2.6.31_10.02.00" tag in in Freescale's LTIB source tree. I
> > > believe the release version of LTIB that I am using is 10.04.00 (and not
> > > 10.02.00) and maybe that's the reason why it is not compiling. How do I
> > > get that release of LTIB?
> > > 
> > > I saw that the patch provided in the website
> > > (adeos-ipipe-2.6.31-arm-1.15-01.patch) is different from the Xenomai
> > > 2.5.3 package (adeos-ipipe-2.6.31-arm-1.15-02.patch). Does it mean that
> > > this topic was solved?
> > 
> > No. There is no way this topic can be "solved". The Adeos I-pipe patches
> > are meant to be applied to the mainline kernel. When you try to apply it
> > to some other tree, you get some issues.
> > 
> > The patch adeos-ipipe-2.6.31-arm-1.15-01-imx51.patch (which adds support
> > for IMX51) is meant to be applied to the rel_imx_2.6.31_10.02.00 relase.
> > It was not tested with any other release, so, yes, chances are that you
> > will get issues if you try and apply it to something else. If you want
> > to checkout the previous release, use git.
> > 
> > More information on this topic may be found in
> > ksrc/arch/arm/patches/README in Xenomai souces.
> > 
> 
> I would ask you how to do that, but that's included in the README. Thank
> you for the help.
> 
> Best regards,
> 
> Flavio
> 
> 



