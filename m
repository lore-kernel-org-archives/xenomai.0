From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1241037937.26544.126.camel@domain.hid>
References: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
	<1240479431.6990.30.camel@domain.hid>
	<1240482629.7599.45.camel@domain.hid>
	<1240487288.6990.71.camel@domain.hid>
	<Pine.LNX.4.64.0904271229410.719@domain.hid>
	<49F640A0.4010904@domain.hid> <49F64500.50901@domain.hid>
	<Pine.LNX.4.64.0904271720580.6463@domain.hid>
	<49F69187.9030402@domain.hid>
	<Pine.LNX.4.64.0904291204500.15719@domain.hid>
	<1241037937.26544.126.camel@domain.hid>
Content-Type: text/plain
Date: Wed, 29 Apr 2009 22:48:18 +0200
Message-Id: <1241038098.26544.127.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Lockups on a new Celeron-430 system detected and
 resolved.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Wed, 2009-04-29 at 22:45 +0200, Philippe Gerum wrote:
> On Wed, 2009-04-29 at 12:48 -0700, Martin Shepherd wrote:
> > On Tue, 28 Apr 2009, Gilles Chanteperdrix wrote:
> > > On my side, disabling NO_HZ is enough to make the issue disappear.
> > 
> > I finally just got around to trying this, but unfortunately, disabling
> > NO_HZ and re-enabling HPET_TIMER and x86_PM_TIMER caused the lockups
> > to return on my new Celeron-based system. I also tried just disabling
> > NO_HZ and X86_PM_TIMER, while leaving just HPET_TIMER enabled, but
> > this also resulted in lock-ups. So on my system, the only way to
> > prevent the lockups, continues to be to turn off both X86_PM_TIMER and
> > HPET_TIMER. Just in case they are useful, I have placed the offending
> > kernel configuration file and corresponding contents of dmesg after a
> > reboot, for the case of NO_HZ disabled and both timers enabled, at:
> > 
> >   http://www.astro.caltech.edu/~mcs/xenomai/config-2.6.29.1-xenomai-2.5-rc1
> >   http://www.astro.caltech.edu/~mcs/dmesg
> 
> Thanks. The issue which is suspected so far is a Linux tick being lost
> when the linux timing sub-system operates in oneshot mode, e.g. over the
> hires timers, and particularly when Xenomai intercepts the LAPIC clock
> event for its own duties. The fact that either one of PM_TIMER or HPET
> must be enabled to raise the problem is confirmed; NO_HZ seems out of
> the picture. Switching HPET/PM_TIMER on

s,on,off,

>  causes the LAPIC clock event to
> undergo periodic timing instead, which does not trigger the bug, or more
> precisely, silently papers over it.
> 
> It's fully reproducible now, thanks to your past investigations. The bug
> triggers almost immediately when switchtest is started (instead of
> latency), and a dd loop runs in the background.
> 
> > 
> > Martin
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



