From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4C4D9131.7080504@domain.hid>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid> <1280149567.1856.15.camel@domain.hid>
	<4C4D9131.7080504@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 11:06:27 -0300
Message-ID: <1280153187.1856.25.camel@domain.hid>
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

I'm sorry for this question, but shoud I execute:

git clone http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git

When I perform this instruction, the terminal blocks. I can access this
link using the browser. (As you can see, I am not very good git user).

Thank you for your help.

Best regards,

Flavio

On Mon, 2010-07-26 at 15:44 +0200, Gilles Chanteperdrix wrote:
> Flavio Alves wrote:
> > Hello,
> > 
> > I tried to perform the steps indicated by the README and I am still
> > having problems to correctly patch the linux kernel with xenomai for the
> > imx51 processor.
> > 
> > I followed the README file from Xenomai package and the Denx
> > instructions
> > (http://www.denx.de/en/view/Software/SoftwareXenomaiProjects#Xenomai_Real_Time_Support_for_i).
> > 
> > Here are the steps that I performed and I would like to know what am I
> > doing wrong or if I can continue that it will work correctly:
> > 
> > * mkdir linux
> > * cd linux
> > * git clone git://git.denx.de/linux-2.6-denx.git
> > * cd linux-2.6-denx
> > * git checkout rel_imx_2.6.31_10.02
> 
> I do not know if it makes a differences, but when I made the port, I
> used the Freescale tree, as described in ksrc/arch/arm/patches/README in
> Xenomai sources.
> 
> > * wget http://download.gna.org/xenomai/stable/
> > * wget
> > http://www.denx.de/en/pub/Software/SoftwareXenomaiProjects/adeos-ipipe-2.6.31-arm-1.15-01-imx51.patch
> > * tar xjvf xenomai-2.5.3.tar.bz2
> > * cd xenomai-2.5.3/ksrc/arch/arm/patches
> > * wget
> > http://www.denx.de/en/pub/Software/SoftwareXenomaiProjects/adeos-ipipe-2.6.31-arm-1.15-01.patch
> > * cd ../../../..
> > * scripts/prepare-kernel.sh --linux=/home/linux/imx51/linux-2.6-denx
> > --adeos=/home/linux/imx51/xenomai-2.5.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.31-arm-1.15-01.patch --arch=arm --verbose
> 
> You are advised to use the latest patch for 2.6.31, which is 1.15-02.
> You will get one reject when applying the adeos patch on the Freescale
> tree, but this one should be harmless.
> 



