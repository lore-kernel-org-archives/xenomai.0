From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <y2x48abf2c21004291716m769fc355ld978b2da54d4ea1d@domain.hid>
References: <i2z48abf2c21004282309r50f047bck4be213c0aac6efe1@domain.hid>
	<4BD99F8C.3090800@domain.hid>
	<p2y48abf2c21004290820g1dabc981y5a1dbd141f64059e@domain.hid>
	<1272554724.28983.444.camel@domain.hid>
	<y2x48abf2c21004291716m769fc355ld978b2da54d4ea1d@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Apr 2010 10:29:54 +0200
Message-ID: <1272616194.24705.36.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] cyclictest gives out segmentation fault with
 xenomai 2.5.2 in powerpc arch
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pan <pppeterpppan@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-04-30 at 08:16 +0800, Peter Pan wrote:
> It's an EVM board of PPC460GT.
> 
> I think the processor is very powerful, that may make xenomai workable
> on our system.

> I'll try to reduce the latency to a proper value.

When you are done, I'd be interested in knowing the proper calibration
value for this platform, so that I can pre-set it in
include/asm-powerpc/calibration.h for future users.

PS: echo 0 > /proc/xenomai/latency is the way to disable the
anticipation in setting timer shots, so that you can determine the
minimum latency of your platform, i.e. abs(min-lat) from the latency
test output, on an idle system.

TIA,

> 
> Thanks alot.
> 
> 2010/4/29 Philippe Gerum <rpm@xenomai.org>:
> > On Thu, 2010-04-29 at 23:20 +0800, Peter Pan wrote:
> >> I searched through the archive, some one says that there is a git
> >> commit to sole the problem. I downloaded the latest xenomai-2.5 git,
> >> the problem is gone.
> >>
> >> But I found another problem. When I use the "latency" test, all the
> >> min latency time gives out a minus value. Is that normal?
> >
> > Yes. Your board has better internal latency than the default calibration
> > expects (i.e. time to traverse the Xenomai stack from IRQ receipt to
> > activating the thread), so the timer shot is anticipated too much.
> > Try reducing the value stored in /proc/xenomai/latency, until your
> > system is calibrated. You can wire this value in your Kconfig
> > afterwards.
> >
> > Which ppc hw are you running Xenomai on?
> >
> >>
> >> 2010/4/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> >> > Peter Pan wrote:
> >> >> I downloaded the ipipe-2.6 from git.denx.de, head     is
> >> >> "ipipe-2.6.32-powerpc". Then I downloaded xenomai-2.5.2 and patch the
> >> >> kernel. Then I install the xenomai applications into our rootfs. I
> >> >> just run cyclictest in /usr/xenomai/share/xenomai/testsuit/cyclic/run,
> >> >> it gives out following line:
> >> >>
> >> >> *
> >> >> *
> >> >> * Type ^C to stop this application.
> >> >> *
> >> >> *
> >> >> 0.00 0.05 0.03 2/24 1010
> >> >>
> >> >> T: 0 (    0) P:99 I: 1000000 C:       0 Min: 1000000 Act:       0 Avg:
> >> >>       0 Max:-1000000
> >> >> Segmentation fault
> >> >
> >> > Probably a stack overflow. Could you run the application inside gdb to
> >> > check that?
> >> >
> >> > --
> >> >                                            Gilles.
> >> >
> >>
> >> _______________________________________________
> >> Xenomai-help mailing list
> >> Xenomai-help@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-help
> >
> >
> > --
> > Philippe.
> >
> >
> >


-- 
Philippe.



