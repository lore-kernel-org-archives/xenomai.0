Subject: Re: [Xenomai-help] handling threads within a pod
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44B7BF28.6000500@domain.hid>
References: <44B51D2C.10508@domain.hid> <44B52214.7050009@domain.hid>
	<44B60737.6050705@domain.hid> <1152891036.5075.35.camel@domain.hid>
	<44B7BF28.6000500@domain.hid>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 21:04:03 +0200
Message-Id: <1152903843.3399.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, Khalil GHORBAL <kg@domain.hid>

On Fri, 2006-07-14 at 17:58 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2006-07-13 at 10:41 +0200, Khalil GHORBAL wrote:
> > 
> >> I'll give an example to explain the issue:
> >> Assuming having multiple threads in our active pod, these threads can be 
> >> in different states.
> >> The running thread have to get the *extinfo* field of thread named 
> >> "COM_THREAD" (for example) if exists.
> >>
> >> All services of the nucleus need a *xnthread_t* structure to identify 
> >> the thread to treat, we can't have a list or something similar to sweep 
> >> existing threads. All I've found is the global queue, doubly-linked and 
> >> circular, which link all threads.
> >> So all informations I have is the number of threads and a way to go from 
> >> one holder to another
> >> without really be able to identify the thread and read the other fields.
> >>
> > 
> > Forget about extinfo; you don't need this, and it's old cruft we are
> > going to kill in later versions anyway. What you need to handle
> > arinc653-like temporal partitioning is something along these lines:
> > 
> > struct ima380_process {
> > 	xnthread_t threadbase;	/* process control block */
> > 	xnholder_t ptlink;	/* link to next partition */
> > 	/* ... */
> > };
> > 
> > struct ima380_partition {
> > 	xnqueue_t procq;	/* chains ima380 processes */
> > 	/* ... */
> > };
> > 
> > Don't refer to Xenomai's global thread queue, just manage your own
> > process queues populating a partition object abstraction.
> > 
> > Then use the XNHELD bit which has been specifically added as a
> > suspensive condition to handle temporal partitioning. This way, XNSUSP
> > remains available for suspending processes forcibly within a partition
> > (suspension bits are conjunctive). IOW, only the processes pertaining to
> > the running partition will have the XNHELD bit cleared, others will have
> > this bit set, and as such, suspended by the nucleus, which is what you
> > want.
> > 
> > void deactivate_partition (struct ima380_partition *pt)
> > {
> > 	foreach(thread in pt->procq) {
> > 		xnpod_suspend_thread(thread,XNHELD,XN_INFINITE,NULL);
> > 	}
> > }
> > 
> > void activate_partition (struct ima380_partition *pt)
> > {
> > 	foreach(thread in pt->procq) {
> > 		xnpod_resume_thread(thread,XNHELD);
> > 	}
> > }
> > 
> > The partition slicer can be implemented as a simple periodic timer,
> > whose handler activates existing partitions in a round-robin fashion.
> > 
> > FWIW, mimicking arinc653 over the nucleus is a no-brainer, so there's
> > good hope for IMA380.
> > 
> 
> The way described above is certainly the preferred one for a first
> approach.

It's the only sane one I see without changing the real-time pod design.
Additionally, ima380 or arinc653 over Linux must be aimed at simulation
purposes, otherwise, this would make no sense. In such context,  it
should be possible to relax constraints about runtime performances
somehow, even if predictability must still be guaranted (hopefully, no
one really wants to run partitions with an insane number of processes).

>  But I wonder if switching full schedules isn't more efficient,
> scalable, and simply more "partitioned" than this O(n) method. I haven't
> looked at details yet, but is there anything that may prevent such
> "hard" switch ATM?
> 

The fact that no "partition" abstraction exists at pod level. The way to
implement this would be to get first the pluggable scheduler
infrastructure, and see a partitioned system as just some
(meta-)scheduler holding sub-schedulers. We just can't pay the price of
adding the partition abstraction to the vast majority of mimicked RTOSes
that don't care about such twisted design (IIRC, temporal partitioning
for arinc653 was basically a kludge around hardware constraints for
simulating multi-node activity). So this abstraction should be better
implemented as some meta scheduler add-on.

> Another topic that my addiction to perfectionism brought to my mind are
> partitioned timers. Anyway, once we switch whole schedules, shouldn't
> those timers be switched automatically as well? Considering that a
> partition switch would be triggered by a timer, one would only have to
> restart the timer IRQ over the new sched to continue. In theory...
> 

Since each resource would need to be associated to a given partition,
timers would have to follow the common rule, which opens a number of
issues as to reduce the impact of built-in partitioning for skins that
don't care about it. Quite frankly, I must admit that my bain cycles are
not particularly focused on that issue, right now.

> Jan
> 
-- 
Philippe.



