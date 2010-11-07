From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CD663F2.2080704@domain.hid>
References: <4CC82C8D.3080808@domain.hid>
	<1288816871.1842.84.camel@domain.hid>	 <4CD1DC1B.8060407@domain.hid>
	<4CD1DE12.5010309@domain.hid>	 <4CD1E890.5010702@domain.hid>
	<4CD1EC2F.4040603@domain.hid>	 <4CD1ED16.8030103@domain.hid>
	<4CD1EDA8.10007@domain.hid>	 <4CD1F33C.5070208@domain.hid>
	<4CD1F3F5.5080505@domain.hid>	 <4CD1F4FE.9020908@domain.hid>
	<4CD1F69B.9070100@domain.hid>	 <4CD1F906.1070703@domain.hid>
	<4CD1FABD.1080301@domain.hid>	 <4CD2612C.2070507@domain.hid>
	<4CD279F7.7070502@domain.hid>	 <4CD27C46.8010302@domain.hid>
	<4CD27DC2.7060607@domain.hid>	 <4CD2A96B.3080001@domain.hid>
	<4CD2B2A7.9010900@domain.hid>	 <4CD2C50F.1090604@domain.hid>
	<4CD32E76.3080004@domain.hid>	 <4CD33F0C.1050403@domain.hid>
	<4CD340AA.60002@domain.hid>	 <4CD34355.5020304@domain.hid>
	<4CD35DC7.1000507@domain.hid>	 <4CD3DAC5.6000400@domain.hid>
	<4CD4A0EF.1@domain.hid>	 <4CD5B9FC.6050602@domain.hid>
	<4CD5BC82.6060106@domain.hid> <1289083796.1842.239.camel@domain.hid>
	<4CD5FA26.4090504@domain.hid>  <4CD663F2.2080704@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 07 Nov 2010 11:03:47 +0100
Message-ID: <1289124227.1842.283.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, 2010-11-07 at 09:31 +0100, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> >>> Anyway, after some thoughts, I think we are going to try and make the
> >>> current situation work instead of going back to the old way.
> >>>
> >>> You can find the patch which attempts to do so here:
> >>> http://sisyphus.hd.free.fr/~gilles/sched_status.txt
> >> Ack. At last, this addresses the real issues without asking for
> >> regression funkiness: fix the lack of barrier before testing XNSCHED in
> > 
> > Check the kernel, we actually need it on both sides. Wherever the final
> > barriers will be, we should leave a comment behind why they are there.
> > Could be picked up from kernel/smp.c.
> 
> We have it on both sides: the non-local flags are modified while holding
> the nklock. Unlocking the nklock implies a barrier.

I think we may have an issue with this kind of construct:

xnlock_get_irq*(&nklock)
	xnpod_resume/suspend/whatever_thread()
		xnlock_get_irq*(&nklock)
		...
		xnlock_put_irq*(&nklock)
	xnpod_schedule()
		xnlock_get_irq*(&nklock)
			send_ipi
			=====> xnpod_schedule_handler on dest CPU
		xnlock_put_irq*(&nklock)
xnlock_put_irq*(&nklock)

The issue would be triggered by the use of recursive locking. In that
case, the source CPU would only sync its cache when the lock is actually
dropped by the outer xnlock_put_irq* call and the inner
xnlock_get/put_irq* would not act as barriers, so the remote
rescheduling handler won't always see the XNSCHED update done remotely,
and may lead to a no-op. So we need a barrier before sending the IPI in
__xnpod_test_resched().

This could not happen if all schedule state changes where clearly
isolated from rescheduling calls in different critical sections, but
it's sometimes not an option not to group them for consistency reasons.

> 
> > 
> >> the xnpod_schedule pre-test, and stop sched->status trashing due to
> >> XNINIRQ/XNHTICK/XNRPICK ops done un-synced on nklock.
> >>
> >> In short, this patch looks like moving the local-only flags where they
> >> belong, i.e. anywhere you want but *outside* of the status with remotely
> >> accessed bits. XNRPICK seems to be handled differently, but it makes
> >> sense to group it with other RPI data as you did, so fine with me.
> > 
> > I just hope we finally converge over a solution. Looks like all
> > possibilities have been explored now. A few more comments on this one:
> > 
> > It probably makes sense to group the status bits accordingly (both their
> > values and definitions) and briefly document on which status field they
> > are supposed to be applied.
> 
> Ok, but I wanted them to not use the same values, so that we can use the
> sched->status | sched->lstatus trick in xnpod_schedule. Something is
> lacking too: we probably need to use sched->status | sched->lstatus for
> display in /proc.
> 
> > 
> > I do not understand the split logic - or some bits are simply not yet
> > migrated. XNHDEFER, XNSWLOCK, XNKCOUT are all local-only as well, no?
> > Then better put them in the _local_ status field, that's more consistent
> > (and would help if we once wanted to optimize their cache line usage).
> 
> Maybe the naming is not good the. ->status is everything which is
> modified under nklock, ->lstatus is for XNINIRQ and XNHTICK which are
> modified without holding the nklock.
> 
> > 
> > The naming is unfortunate: status vs. lstatus. This is asking for
> > confusion and typos. They must be better distinguishable, e.g.
> > local_status. Or we need accessors that have debug checks built in,
> > catching wrong bits for their target fields.
> 
> I agree.
> 
> > 
> > Good catch of the RPI breakage, Gilles!
> 

-- 
Philippe.



