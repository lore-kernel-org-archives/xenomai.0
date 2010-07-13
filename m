From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4C3CB655.1020801@domain.hid>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Jul 2010 16:17:41 -0300
Message-ID: <1279048661.31665.81.camel@domain.hid>
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

Hello Gilles,

On Tue, 2010-07-13 at 20:54 +0200, Gilles Chanteperdrix wrote:
> Flavio Alves wrote:
> > Hello,
> > 
> > I would like to build a linux kernel with Xenomai to run on a iMX51
> > board (iMX51EVK).
> > 
> > I am currently using the last version of the BSP from Freescale website
> > (LTIB). If I apply the BSP's patches before the Xenomai's patches, the
> > patches are not applied. So, I first apply Xenomai's patches and then
> > BSP's patches.
> > 
> > The problem in this approach is that I have compilation errors, even if
> > I have all the patches successfully applied.
> > 
> > I saw at Denx homepage that there is a specific patch for Xenomai for
> > iMX51. But the patch provided by the website must be used into the
> > "rel_imx_2.6.31_10.02.00" tag in in Freescale's LTIB source tree. I
> > believe the release version of LTIB that I am using is 10.04.00 (and not
> > 10.02.00) and maybe that's the reason why it is not compiling. How do I
> > get that release of LTIB?
> > 
> > I saw that the patch provided in the website
> > (adeos-ipipe-2.6.31-arm-1.15-01.patch) is different from the Xenomai
> > 2.5.3 package (adeos-ipipe-2.6.31-arm-1.15-02.patch). Does it mean that
> > this topic was solved?
> 
> No. There is no way this topic can be "solved". The Adeos I-pipe patches
> are meant to be applied to the mainline kernel. When you try to apply it
> to some other tree, you get some issues.
> 
> The patch adeos-ipipe-2.6.31-arm-1.15-01-imx51.patch (which adds support
> for IMX51) is meant to be applied to the rel_imx_2.6.31_10.02.00 relase.
> It was not tested with any other release, so, yes, chances are that you
> will get issues if you try and apply it to something else. If you want
> to checkout the previous release, use git.
> 
> More information on this topic may be found in
> ksrc/arch/arm/patches/README in Xenomai souces.
> 

I would ask you how to do that, but that's included in the README. Thank
you for the help.

Best regards,

Flavio



