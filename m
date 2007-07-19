From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <469F84B3.6070104@domain.hid>
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>
	<913919.1184311634860.JavaMail.ngmail@domain.hid>
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>
	<469F84B3.6070104@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 18:03:55 +0200
Message-Id: <1184861035.28303.108.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze after
	rt_task_start
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
Cc: xenomai@xenomai.org

On Thu, 2007-07-19 at 17:35 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-07-19 at 14:40 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>>> And when looking at the holders of rpilock, I think one issue could be
> >>>> that we hold that lock while calling into xnpod_renice_root [1], ie.
> >>>> doing a potential context switch. Was this checked to be save?
> >>> xnpod_renice_root() does no reschedule immediately on purpose, we would
> >>> never have been able to run any SMP config more than a couple of seconds
> >>> otherwise. (See the NOSWITCH bit).
> >> OK, then it's not the cause.
> >>
> >>>> Furthermore, that code path reveals that we take nklock nested into
> >>>> rpilock [2]. I haven't found a spot for the other way around (and I hope
> >>>> there is none)
> >>> xnshadow_start().
> >> Nope, that one is not holding nklock. But I found an offender...
> > 
> > Gasp. xnshadow_renice() kills us too.
> 
> Looks like we are approaching mainline "qualities" here - but they have
> at least lockdep (and still face nasty races regularly).
> 

We only have a 2-level locking depth at most, thare barely qualifies for
being compared to the situation with mainline. Most often, the more
radical the solution, the less relevant it is: simple nesting on very
few levels is not bad, bugous nesting sequence is.

> As long as you can't avoid nesting or the inner lock only protects
> really, really trivial code (list manipulation etc.), I would say there
> is one lock too much... Did I mention that I consider nesting to be
> evil? :-> Besides correctness, there is also an increasing worst-case
> behaviour issue with each additional nesting level.
> 

In this case, we do not want the RPI manipulation to affect the
worst-case of all other threads by holding the nklock. This is
fundamentally a migration-related issue, which is a situation that must
not impact all other contexts relying on the nklock. Given this, you
need to protect the RPI list and prevent the scheduler data to be
altered at the same time, there is no cheap trick to avoid this.

We need to keep the rpilock, otherwise we would have significantly large
latency penalties, especially when domain migration are frequent, and
yes, we do need RPI, otherwise the sequence for emulated RTOS services
would be plain wrong (e.g. task creation).

Ok, the rpilock is local, the nesting level is bearable, let's focus on
putting this thingy straight.

> Jan
> 
-- 
Philippe.



