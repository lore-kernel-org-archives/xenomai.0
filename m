MIME-Version: 1.0
In-Reply-To: <4FE46F5F.1060500@xenomai.org>
References: <CAHue_TXhjY-74oUNzuuS=ygCEhcVFeiAB+4ZesjKX19B9WobaA@mail.gmail.com>
	<4FCDFB35.1050705@xenomai.org>
	<CAHue_TUB-6nufH_O-PRojDPVfpDom+DCv1-_ERV4-xOfEzu2Dg@mail.gmail.com>
	<4FCE28F8.9040001@xenomai.org>
	<CAHue_TW1ntMpOxwACiawgtm67nYq_e7i11CDxz=CfpGGwRes_A@mail.gmail.com>
	<4FD8F4B5.7000001@xenomai.org>
	<CAHue_TXMiLTxiK2ZORVccov2wqd+ML-H0zwhLoDYh+7+8_56xw@mail.gmail.com>
	<4FE46F5F.1060500@xenomai.org>
Date: Wed, 27 Jun 2012 16:20:32 +0200
Message-ID: <CAHue_TX3UmeMbu9mU_YSKdHeN8oUYFhaeA=mUGgpvJzjnaEdxw@mail.gmail.com>
From: =?ISO-8859-2?Q?Marcin_Ku=B6ka?= <marckuska@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] unsupported ARM9 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Ok thank you for helping me out! You've been very helpfull.

Just for anyone trying to do the same in future:

I used two of git projects from http://git.xenomai.org/ipipe-gch.git/

   - ipipe-gch.git (linux kernel)
   - xenomai-2.6.git (the file HAVE TO be named xenomai-2.6 as buildroot
   will be looking for that folder and if he denies to find it in
   'output/build' it will start downloading the common xenomai from xenomai
   site and we don't want that)


In buildroot:

   - Kernel->Kernel version (Custom tarball) and specify the URL of a
   tarball (ipipe-gch linux kernel)
   - Linux Kernel Extensions -> UNCHECK Adeos/Xenomai Real-time patch

then build the kernel and that's all.

For me it worked.

Many thanks to Gilles!


Marcin Ku=B6ka
2012/6/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 06/22/2012 03:07 PM, Marcin Ku=B6ka wrote:
> > 2012/6/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >>
> >> For instance, the fact that you are compiling both
> >> arch/arm/common/timer-sp.c and smp_twd.c will lead to a conflict the w=
ay
> >> timer-sp.c is currently made. omap4 has the same problem since for
> >> instance arch/arm/mach-omap2/timer.c is compiled both in the omap3 and
> >> the omap4 case. So, just look at how it is done, and do it the same wa=
y.
> >>
> >> Another simpler solution is to start from the ipipe core-3.2 branch,
> >> which supports being built for several SOCs. However, it will require
> >> upgrading to xenomai 2.6 branch head.
> >>
> >> --
> >>                                                                Gilles.
> >>
> >>
> > Ok I checked the arch/arm/common/timer-sp.c (i assume this file
> implements
> > the timer for vexpress) and all the__ipipe_mach_timerint;
> > __ipipe_mach_timerstolen; and so on, are there and there is nothing to =
be
> > done there. I don't know if i understand you right. Which part should I
> do
> > the same as with omap4?
>
> The problem is that if you are compiling with CONFIG_SMP for a cortex
> a9, there is also an __ipipe_mach_timerint, __ipipe_mach_timerstolen,
> etc... in the generic code for cortex a9. So, you get multiple definition=
s.
>
> omap4 has exactly the same problem, because it compiles some code which
> is common with omap3, already modified for CONFIG_IPIPE.
>
> So what you have to do is solve the multiple definitions for vexpress
> the way they are solved for the omap4/omap3.
>
> >
> >
> > About that simpler solution using ipipe core-3.2 branch. There is no
> ipipe
> > core-3.2 at the http://download.gna.org/adeos/patches/v3.x/arm/ site or
> am
> > I looking for wrong site?
>
> Yes, I am talking about a branch in the adeos ipipe git repository. The
> patch is not released yet. But anyway, for what you have to do, working
> with git is much simpler than working with patches.
>
> --
>                                            Gilles.
>



--=20
Marcin Ku=B6ka
