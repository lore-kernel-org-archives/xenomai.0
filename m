From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4C600D17.2020609@domain.hid>
References: <1279046702.31665.65.camel@domain.hid>	<4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid>	<1280149567.1856.15.camel@domain.hid>
	<4C4D9131.7080504@domain.hid>	<1280153187.1856.25.camel@domain.hid>
	<4C4D97AC.2030609@domain.hid>	<1280154697.1856.29.camel@domain.hid>
	<4C4D9E04.6060407@domain.hid>	<1280156219.1856.32.camel@domain.hid>
	<4C4DA340.4030400@domain.hid>	<1280187666.1963.34.camel@domain.hid>
	<4C4E8A64.1000701@domain.hid>	<1280239972.1865.7.camel@domain.hid>
	<4C4EEBE3.9020806@domain.hid>
	<AANLkTim4A+3sLGzgdhc_Xhfn0bAW+hLZtuUJVyVocLOZ@mail.gmail.com>
	<AANLkTimGA5k4Vu_aQNXx1bBhT2X3KAZytAKZHWD-HNHK@mail.gmail.com>
	<4C4F7B47.6040709@domain.hid>
	<AANLkTin-4N_AdZiEK+dqxsz=E_ZHxDnoGxQikOJCkVo9@domain.hid>
	<4C585D60.2040809@domain.hid> <1281356497.17126.19.camel@domain.hid>
	<4C600D17.2020609@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 14:37:58 -0300
Message-ID: <1281375478.23731.6.camel@domain.hid>
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

Just to report, it worked. We have a working Xenomai version on imx51evk
using the approach described into the readme file.

Best regards,

Flavio

On Mon, 2010-08-09 at 16:13 +0200, Gilles Chanteperdrix wrote:
> Flavio Alves wrote:
> > Hello,
> > 
> > I'm still having problems in compiling the kernel with xenomai for the
> > imx51.
> > 
> > I'm having the following error:
> > 
> >   LD      .tmp_vmlinux1
> > arch/arm/plat-mxc/built-in.o: In function `mxc_dvfs_core_probe':
> > isp1504xc.c:(.devinit.text+0x334): undefined reference to
> > `cpufreq_trig_needed'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > The steps used are the indicated at the xenomai patches README. The
> > defconfig that I'm using is imx51_defconfig, from the mainstream kernel.
> 
> I validated the babbage board with a config derived from this config.
> 
> > 
> > I know that it is not a xenomai issue, but it is caused when I run make
> > menuconfig and disable the CPU frequency scaling feature, in order to
> > disable the warning (if the warning is present, xenomai is not
> > compiled).
> 
> No. The warning is just that: a warning.
> 



