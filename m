From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <469F5BA5.1030407@domain.hid>
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
	<469F5BA5.1030407@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 15:55:18 +0200
Message-Id: <1184853318.28303.79.camel@domain.hid>
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
Cc: xenomai-help <xenomai@xenomai.org>, "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

On Thu, 2007-07-19 at 14:40 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> >> And when looking at the holders of rpilock, I think one issue could be
> >> that we hold that lock while calling into xnpod_renice_root [1], ie.
> >> doing a potential context switch. Was this checked to be save?
> > 
> > xnpod_renice_root() does no reschedule immediately on purpose, we would
> > never have been able to run any SMP config more than a couple of seconds
> > otherwise. (See the NOSWITCH bit).
> 
> OK, then it's not the cause.
> 
> > 
> >> Furthermore, that code path reveals that we take nklock nested into
> >> rpilock [2]. I haven't found a spot for the other way around (and I hope
> >> there is none)
> > 
> > xnshadow_start().
> 
> Nope, that one is not holding nklock.

Indeed, but this only works because its callers who may hold this lock
do not activate shadow threads so far. This looks so fragile... I'll add
some comment about this in the doc.

> But I found an offender...
> 
> > 
> >> , but such nesting is already evil per se...
> > 
> > Well, nesting spinlocks only falls into evilness when you get a circular
> > graph, but since the rpilock is a rookie in the locking team, I'm going
> > to check this.
> 
> Take this one: gatekeeper_thread calls into rpi_pop with nklock
> acquired. So we have a classic ABAB locking bug. Bang!
> 

Damnit.

The fix needs some thought and attention, we are running against the
deletion path here.

PS: Time to switch to -core.

> Jan
> 
-- 
Philippe.



