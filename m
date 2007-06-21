From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467A42FE.1090305@domain.hid>
References: <467639BE.30504@domain.hid>  <467641F3.3010308@domain.hid>
	<1182357772.6137.39.camel@domain.hid>  <46795F21.8040007@domain.hid>
	<1182378551.6079.45.camel@domain.hid>  <467A2FB2.6050006@domain.hid>
	<1182416810.9709.38.camel@domain.hid>  <467A42FE.1090305@domain.hid>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 11:39:58 +0200
Message-Id: <1182418798.9709.50.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-06-21 at 11:21 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-06-21 at 09:58 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> If you think of it, decoupling only requires to keep a constant epoch
> >>> (at least one the nucleus does not update) somewhere within the timebase struct,
> >>> the user code could wire to some value when it sees fit (e.g. pSOSish tm_set(),
> >> I know. It should be simple.
> >>
> >>> or VRTX's sc_stime() and so on). Obtaining a so-called constant-based time would have
> >>> then to be available through an additional method, returning constant_epoch + delta,
> >>> whatever delta means wrt aperiodic/periodic behaviour. The point here is that we
> >>> would just shift the constant epoch - decorrelated from system time - from default
> >>> xntbase_get_time() behaviour to something which should be explicitly requested
> >>> through a new specialized timebase method if needed.
> >> Well, that's precisely the set of new conversion functions I'm a bit
> >> afraid of. But as it now comes with the "special case", not the default
> >> one, I would be fine with it.
> >>
> > 
> > Indeed, it's really about shifting the default behaviour to synchronized
> > timebases. There is not much harm to expect from using specialized
> > services to get a constant-based timebase anyway, since only skin
> > developers would need that, and those people ought to know what they are
> > doing.
> 
> Nope, it's a user thing: The user has to convert timestamps from one
> skin (e.g. an RTDM device) into his own or vice versa. That makes it so
> critical.
> 

We are talking about two different things. RTDM would use the new
uniform and synchronized way of seeing the system time, skins like pSOS
would reinstate their own idea of time based on the constant-epoch
service, if need be.

> > 
> >>> IOW, introducing synchronized timebases is not the issue, making timebase
> >>> synchronization the default behaviour is what has some importance here.
> >> I predict it will save all of us from headache, at least from more
> >> headache than with the other way around. :)
> >>
> > 
> > Ok, let's go for it, the changes are easily identifiable. I guess that
> > is something we could not postpone to 2.5 anyway. I want to merge this
> > asap now, because I don't want to delay -rc1 anymore, and the merge
> > window is almost closed.
> > 
> > Actual uses of this feature - e.g. POSIX resync - should go into -rc2,
> > unless they are (almost) ready for merge right now.
> > 
> 
> Do you already have an idea about the "decoupling API"? Or should we
> postpone this to -rc2 as well?

-rc2, this does not seem to be on the critical path for anyone so far.
What we should have for -rc1 is the infrastructure RTDM would be able to
build over later, and make reliable assumptions about right now for
solving pending design issues.

>  Same for resync as a generic xntbase feature.
> 

Unless the code is ready, this could wait until -rc1 is out. I guess
that Gilles needs some additional time to work the clock_settime()
service the way POSIX wants it anyway. Gilles?

> Jan
> 
-- 
Philippe.



