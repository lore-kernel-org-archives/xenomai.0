From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1245677021.9238.6.camel@domain.hid>
References: <1243526358.898.21.camel@domain.hid>
	<1243529533.22173.6.camel@domain.hid> <1243533530.898.36.camel@domain.hid>
	<1243547223.22173.54.camel@domain.hid> <1245677021.9238.6.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 11:30:19 +0200
Message-Id: <1245749419.3986.165.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running out of stack memory in kernel-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-06-22 at 09:23 -0400, Andreas Glatz wrote:
> Hi,
> 
> 
> > What bothers me is that you seem to determine a latency based on
> > measurements of a round trip time, obtained on an ethernet network. So
> > it is a bit difficult for me to give any interpretation about the 70 us
> > figure; too many variables in that equation.
> > 
> > > 
> 
> 
> I finally upgraded Xenomai from version 2.4.4 to 2.4.8
> as you strongly suggested last time and I can say 
> that this fixes all of the bugs we found in the earlier 
> version. Thanks a lot for that!!
> 
> Furthermore I did some serious measurements with the new
> Xenomai version on an MPC8360. In short, I measured
> an interrupt latency around 7us when running in kernel-space
> and around 35us when running in user-space. You can find
> the details of those measurements the end of this Email!
> 
> I have two more questions:
> 
> 1) In the legacy code I am porting, critical sections are
> protected by disabling/enabling ALL interrupts (like
> sti/cli in kernel-space). This method is much faster than
> locking a mutex, which might put a task to sleep.

Usually yes, but at the expense of wrecking the priority-based model of
the RTOS when misused.

>  Are there
> similar, portable functions available under Xenomai or IPIPE?

You should never rely directly on I-pipe features, using a Xenomai
interface is the way to go.

If writing driver code based on RTDM (the recommended way), see there:
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdmsync.html

Otherwise, if you are writing ad hoc application code in kernel space,
which is asking for trouble (yeah, I can't help it, sorry), you will
have to resort to core services from the Xenomai nucleus directly: see
splhigh(), splexit(), xnlock_get[irqsave], xnlock_put[_irqrestore].
Regarding the second form, you may notice a pre-defined lock called
"nklock", which is used by the nucleus internally. You may use it at
your own risk (basically introducing more latency if misused), but you
may also define your own RT spinlock based on the xnlock_t type, taking
care of possible locking order issues with the nklock.
see include/asm-generic/system.h.

Disclaimer: I never gave you any information about how to write sloppy
code abusing design layers, just like I did. This is not me writing
this. This information shall not be known outside of the Internet.
If, despite all due diligence from my side, you happen to receive this
information, this is strictly unwanted.

> 
> 2) In the legacy code we also have some low priority
> tasks which are performing lengthy operations (around 1s).
> Of course, those low-priority tasks prevent Linux tasks
> from running. In our case this behaviour is bad. Just in 
> the case of those low-priority task, Linux should be able 
> to preempt those tasks. From our viewpoint, the best solution
> to that problem would be if we could assign those tasks 
> the same or a lower priority than Linux tasks. That would
> give us the best of both worlds: We could call Xenomai 
> API functions from those task without switching back and
> forth between primary and secondary mode and Linux tasks 
> wouldn't be preempted.

You could either set your scheduling parameters to SCHED_RR to relax the
system once in while, given that this would only approximate what you
want to do, or you could upgrade to 2.5, which provides a sporadic
server scheduling class. In that case, you could fine tune the amount of
runtime devoted to any given task of your system, within a given period
of time.

> 
> 
> Thanks again to you and the other Xenomai contributors 
> for producing such a good piece of Software!! I hope 
> that you'll keep the good work up. I'm also looking
> forward trying out Version 2.5!
> 
> 
> Best regards,
> Andreas Glatz
> 
> 
> 
> 
> 
> 
> 
> 
> 
> ---------------------------------------------------------
> 
> The test setup is shown in file "testsetup.pdf". 
> 
> We are running a Xenomai application on the MPC8360 
> which grabs the UEC 7 IRQ and replaces the RX and TX 
> buffers and buffer rings of the Linux UEC driver by its 
> own RX and TX buffers and buffer rings. Those buffers are 
> allocated from a RT_HEAP object which was created with 
> the H_DMA flag. The Xenomai application is highly portable 
> between kernel- and user-space. The only differences between
> the kernel-space and user-space version is the way they
> are linked (shared libraries vs exported functions).
> 
> The Xenomai application periodically sends a 64byte 
> Ethernet frame over the 100Mbit MII Interface to the 
> Ethernet Switch where the Frame is looped back on
> Port 1. The frame travels back over the MII interface 
> to the MPC8360 and is received by the Xenomai application.
> 
> As described in "testsetup.pdf" we measured the following
> signals with an Oscilloscope: Rx_DV, Tx_EN, GPIO Pin.
> 
> The GPIO Pin is toggled every time the UEC 7 ISR is called.
> The UEC 7 Interrupt is triggered after Rx_DV and Tx_EN 
> go from high to low. So the time between the neg. slope of
> Rx_DV and Tx_EN and a Pin state change is the equal to 
> the interrupt delay. See "loopks.pdf" and "loopus.pdf"
> for detailed results. 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



