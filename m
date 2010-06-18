From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100609181153.GA27353@domain.hid>
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
	<20100609181153.GA27353@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 19 Jun 2010 01:11:17 +0200
Message-ID: <1276902677.12743.108.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mayday support (was: Re: [RFC] Break out
 of endless user space loops)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org, xenomai@xenomai.org

On Wed, 2010-06-09 at 20:11 +0200, Tschaeche IT-Services wrote:
> On Wed, Jun 09, 2010 at 12:41:23PM +0200, Philippe Gerum wrote:
> > We definitely need user feedback on this. Typically, does arming the
> > nucleus watchdog with that patch support in, properly recovers from your
> > favorite "get me out of here" situation? TIA,
> > 
> > You can pull this stuff from
> > git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.
> 
> manually build a kernel (timeout 1s) with your patches.
> user space linked to 2.5.3 libraries without any patches.
> Looks fine: the amok task is switched to secondary domain
> (we catched the SIGXCPU) running the loop in secondary domain.
> then, on a SIGTRAP the task leaves the loop.
> 
> also, if SIGTRAP arives before SIGXCPU it looks good,
> apart from the latency of 1s.
> 
> did not check the ucontext within the exception handler, yet.
> would like to setup a reproducible kernel build first...
> we will go into deeper testing in 2 weeks.
> 
> maybe we need a finer granularity than 1s for the watchdog timeout.
> is there a chance?

The watchdog is not meant to be used for implementing application-level
health monitors, which is what you seem to be looking after. The
watchdog is really about pulling the break while debugging, as a mean
not to brick your board when things start to hit the crapper, without
knowing anything from the error source. For that purpose, the current 1s
granularity is just fine. It makes the nucleus watchdog as tactful as a
lumberjack, which is what we want in those circumstances: we want it to
point the finger at the problem we did not know about yet and keep the
board afloat; it is neither meant to monitor a specific code we know in
advance that might misbehave, nor provide any kind of smart contingency
plan.

I would rather think that you may need something like a RTDM driver
actually implementing smarter health monitoring features that you could
use along with your app. That driver would expose a normalized socket
interface for observing how things go app-wise, by collecting data about
the current health status. It would have to tap into the mayday routines
for recovering from runaway situations it may detect via its own,
fine-grained watchdog service for instance.

ATM, you can still hack the nucleus watchdog threshold by changing the
periodic setup for its timer in xnpod_enable_timesource(). This said,
increasing the frequency too much would also induce much more overhead,
so YMMV.

> 
> will your patches be merged in an official 2.5.x version?
> 

2.5.4.

> thanks for your great support,
> 
> 	Olli


-- 
Philippe.



