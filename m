Subject: Re: [Xenomai-help] handling threads within a pod
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44BB4002.4030402@domain.hid>
References: <44B51D2C.10508@domain.hid> <44B52214.7050009@domain.hid>
	<44B60737.6050705@domain.hid> <1152891036.5075.35.camel@domain.hid>
	<44BB4002.4030402@domain.hid>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 10:04:27 +0200
Message-Id: <1153123467.5081.10.camel@domain.hid>
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

On Mon, 2006-07-17 at 09:45 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > ...
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
> 
> I wonder if there isn't the risk of mixing up the schedule inside the
> partitions by suspending/resuming this way. I think the order of
> resuming those threads that were ready before must match the original
> order in the ready-queue at suspension time.
> 

It's a sketchy representation. The real implementation would have to
move all runnable threads to a preemption queue.

> > 
> > The partition slicer can be implemented as a simple periodic timer,
> > whose handler activates existing partitions in a round-robin fashion.
> > 
> > FWIW, mimicking arinc653 over the nucleus is a no-brainer, so there's
> > good hope for IMA380.
> > 
> 
> Jan
-- 
Philippe.



