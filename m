From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0B475ED@EINT11.einet.ad.eivd.ch>
References: <FDBBB5CC70676540B3EF7CFE83FD94E099942B@EINT11.einet.ad.eivd.ch>
	<1188824753.6037.27.camel@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0B475ED@EINT11.einet.ad.eivd.ch>
Content-Type: text/plain
Date: Mon, 03 Sep 2007 22:31:10 +0200
Message-Id: <1188851470.28092.65.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] RE : Activation of IRQ handler in the
	Linux	domain
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-09-03 at 19:58 +0200, ROSSIER Daniel wrote:
> >On Mon, 2007-09-03 at 14:11 +0200, ROSSIER Daniel wrote:
> >> Hello,
> >>
> >>
> >>
> >> I'm doing a small RT application using the I2C driver from Linux.
> >>
> >> At a certain time, when the task is activated and data are written to
> >> the I2C bus,
> >>
> >> the driver waits for a IRQ that confirmed the data have been sent out.
> >> The write function
> >>
> >> actually polls a variable state until a timeout or a state change
> >> occurring on reception of that IRQ (done by the handler).
> >>
> >>
> >>
> >> However, since driver functions are called from the Xenomai domain,
> >> the IRQ handler is not processed
> >>
> >> at the reception since the hander belongs to the Linux domain. It ends
> >> up with a timeout
> >>
> >> during the write.
> >>
> >>
> >>
> >> I implemented a local ISR within the Xenomai application, but the
> >> propagation of IRQ is not performed
> >>
> >> while the task is running.
> >
> >Which is expected. All the pipeline abstraction relies on the very
> >fundamental assumption that domains run by priority order, which in turn
> >means that a high priority domain must run until all the pending work is
> >processed, and a Xenomai task in a runnable state represents some
> >pending work for the Xenomai domain. Make your Xenomai task sleep on
> >some synchronization object (likely a RTDM one) for synchronizing with
> >the code which signals the wakeup condition, and the pending IRQ will
> >flow down to Linux as expected. Busy waiting for such condition is a
> >dead end here.
> 
> Ok, I totally agree. I've tried to use a rtdm_event object which I've
> declared in the Linux driver side. Then, the write function is called from a RT task,
> then it calls rtdm_event_wait() at a certain point, and the i2c ISR performs a rtdm_event_signal()
> to wake up the RT task. However, I got a kernel crash when rtdm_event_wait() is called.
> 

Make sure to test the return of rtdm_event_wait() in your loop. Maybe
its fails and returns with some error code you don't detect, causing an
infinite tight loop.

> 
> The i2c driver is statically linked in the kernel (zImage), but I'm not sure 
> if I'm right declaring a rtdm object in the kernel directly. Can you confirm?
> 

If you want to keep the i2c driver statically bound to the kernel, you
don't have any other choice than defining the RTDM object the same way,
except by using some hairy indirect reference to such object via a
pointer, which would be uselessly complex in any case.

> Another point where I'm not sure: does a call to rtdm_event_signal() suspend the execution
> of the linux ISR,

Yes, at least if the RT task is pending on the object at the time it is
signaled. Your RT task has higher priority than the Linux kernel running
one of its ISRs.

>  or will the ISR terminate properly before yielding to the RT task?

No. The Linux ISR will be preempted immediately by posting the object.

> Because it might complicate the work between the (partially finished, without unmasked IRQ) handler
> and the RT task...
> 

It's complicated because the design you are trying to implement has a
flaw: you want to make a high priority task synchronize on a low
priority event. Maybe you should consider moving the i2c interrupt
handler as a Xenomai ISR. What prevents you from doing that?

> Thanks in advance for the clarification.
> 
> >
> >>  Is there a way to tell Adeos to forward the IRQ to the Linux domain
> >> with no delay
> >>
> >> so that the Linux handler can be called? or do I need to re-implement
> >> the ISR in the Xenomai application?
> >>
> >
> >Your code cannot be on both side of the same fence. Either you want a
> >real-time guarantee for interrupt delivery and task dispatching and you
> >need a Xenomai ISR to process IRQs to wake-up some Xenomai task; or, you
> >don't need any guarantee, but still want Linux to process the i2c IRQs
> >just for the purpose of recycling some vanilla code, and in such a case,
> >you need to make the Linux IRQ handler wake up the Xenomai task. In the
> >latter case, the Xenomai task (in primary RT mode) must sleep at some
> >point waiting for the wake up event, there is no sideways possible here.
> >You may call rt_sem_v() or sem_post(), or a rtdm object signaling
> >routines from a Linux context to wake up a real-time sleeper.
> >
> >>
> >>
> >> Thanks for any hints.
> >>
> >>
> >>
> >> Daniel
> >>
> >>
> >>
> >>
> >> _______________________________________________
> >> Xenomai-core mailing list
> >> Xenomai-core@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-core
> >--
> >Philippe.
> >
> 
-- 
Philippe.



