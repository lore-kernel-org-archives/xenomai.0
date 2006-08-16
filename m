From: Nicola Pezzotti <nicola17@domain.hid>
Subject: Re: [Xenomai-help] problem with installation
Date: Wed, 16 Aug 2006 21:37:09 +0200
References: <20060816190510.20935.qmail@domain.hid>
	<44E36F6A.7060004@domain.hid>
In-Reply-To: <44E36F6A.7060004@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608162137.09103.nicola17@domain.hid>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Alle 21:18, mercoled=C3=AC 16 agosto 2006, Jan Kiszka ha scritto:
> Nicola Pezzotti wrote:
> > Hi all.
> >     I'm trying to install Xenomai on my pc.
> > To do that I'm following this guide
> > http://www.captain.at/xenomai-2.1-installation.php
> > I'm using Kubuntu 6.6, linux-2.6.17 kernel and xenomai-2.2.0
> > I have runned the script prepare-kernel.sh with the correct option as in
> > README.INSTALL
> > Everything go well untill I reboot the system, then I have those errors
> >
> >
> > Uncompressing Linux... ok, booting the kernel
> > MP-BIOS bug 8254 timer not connected to IO-APIC
> > Xenomai: incompatible timer mode(aperiodic found, need aperiodic)
>
>                                                          ^^^^^^^^^
> I guess this this is a typo, isn't it? I would expect "periodic" here.

Sorry=20
Xenomai: incompatible timer mode(aperiodic found, need periodic)


> > Xenomai: VxWorks skin init failed code -16
> > Kernel Panic - not syncing: VFS Unable to mount root fs on unknow
> > -block(0,0)
>
> The VxWorks skin requires periodic timer mode. If you don't plan to use
> it, drop it from the kernel config . If you do want it, either set
> CONFIG_XENO_OPT_TIMING_PERIOD to some reasonable value (see also the
> related kernel-config help), or turn the nucleus into a module and pass
> the period via the module parameter "tick_arg" when insmod'ing
> xeno_nucleus later.
>

I need VxWorks skin... can you give me an hint abount this configuration? i=
n=20
what part of installation I must this flag?

Sorry but I'm newbie in this procedure


> > Someone can give me an help? where I can found an official installation
> > guide
> > (Sorry for my bad english)
> > Thanks
>
> README.INSTALL and TROUBLESHOOTING are the official guides. For the
> rest: you are already on the right list. ;)
>
> Jan


very very very thanks for the help

