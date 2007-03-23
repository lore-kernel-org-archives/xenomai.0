Subject: Re: [Xenomai-core] [Fwd: [rfc][patch] queued spinlocks (i386)]
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4603E7FD.4010207@domain.hid>
References: <4603DA8F.8050900@domain.hid> <1174660491.4606.17.camel@domain.hid>
	<4603E7FD.4010207@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 16:05:49 +0100
Message-Id: <1174662349.4606.38.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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

On Fri, 2007-03-23 at 15:45 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2007-03-23 at 14:47 +0100, Jan Kiszka wrote:
> >> That idea sounds worthwhile for xnlocks as well, doesn't it?
> > 
> > Not sure, yet. Real starvation on xnlocks would require non-RT activity
> > to be completely locked out on all CPUs in the first place for that to
> > happen, which would be the sign of a serious design flaw. I see no way
> > to solve such initial problem by adding some fairness to the lock
> > dispatching policy in primary mode.
> 
> I wasn't primarily thinking about avoiding starvation (would indeed be
> bad if a system suffers from such a risk) but about making spinlock
> contention more predictable in case that successive (but bounded) lock
> acquisitions may occur.

Ack. The problem I still see is that for a given number of contending
CPUs, and the resulting ininterrupted contention time which would not
raise the starvation issue, that approach would need to be more
efficient than the "fairness" already introduced by issuing relax ops
inside the busy-wait loop. Admittedly, not all CPUs try to be fair in
this case (IIRC, x86 does though).

> 
> > 
> > Still, thinking about this patch, since there is a price to pay for this
> > approach due to serious cache-bouncing on high contention, using the
> > waiter priority to manage the pending queue instead of a simple FIFO
> > ticketing would be at least logically better, but likely even more
> > costly.
> 
> Yeah, I thought about such approaches as well before. Don't have my
> drafts on this at hand, but it was costly, specifically /wrt spinlock size.
> 
> Jan
> 
-- 
Philippe.



