MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <552915AE.4000809@xenomai.org>
References: <CAKk99t04WrAswcZb-YZJ2ZJzPjnev=Zq0S5cTr_u_E2Aftv-Xg@mail.gmail.com>
 <552915AE.4000809@xenomai.org>
Date: Mon, 13 Apr 2015 13:37:50 +0100
Message-ID: <CAKk99t0VmN0L1D+VpNRv4B4m=fNxj_n_2tzu=tvYBqdOJRjJdA@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] How to propagate Interrupt down the pipeline in
 cobalt (xenoma 3.x)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 11 April 2015 at 13:38, Philippe Gerum <rpm@xenomai.org> wrote:

>
>
 I can not figure out a way to
> > decide if an interrupt is to be propagated to Linux or not.
> >
> > I tried to install both IRQs as shared handlers:
> >
> > RT domain:
> > ret = rtdm_irq_request(&intr, IRQ, irq_handler, RTDM_IRQTYPE_SHARED,
> name,
> > NULL);
> >
> > Linux domain:
> > ret = request_irq(RTCIRQ, rtc_interrupt, 0, name, NULL));
> >
> > and return from the RT ISR:
> >
> > RTDM_IRQ_NONE.
>
> - RTDM_IRQ_NONE
> + XN_ISR_PROPAGATE
>
>
Ok
I changed the return of the RT ISR to just XN_IRQ_PRPAGATE (I did not find
XN_ISR_PROPAGATE on Cobalt API from Xenomai 3.x).
It now propagates the interrupt notification to Linux Domain.
Thanks

I also tried returning:

RTDM_IRQ_NONE | XN_ISR_PROPAGATE

or

RTDM_IRQ_HANDLED | XN_ISR_PROPAGATE

Both of thenm still propagates int notifications to Linux.

So, the proper way to mark an interrupt as handled in RT Domain and to
propagate it to Linux domain is this last one (RTDM_IRQ_HANDLED
| XN_ISR_PROPAGATE)?



> Sharing IRQs between the rt domain and linux leads to a basic priority
> inversion problem with level type interrupts, since one would have to
> keep the IRQ line masked until the linux handler eventually had a chance
> to process the same event. This would obviously delay the next interrupt
> from the same device for the rt domain.
>

ok


> For this reason, their is no API for implementing such sharing
> explicitly anymore, since it is discouraged. However, the mechanism is
> still in place for the (rare) desperate cases when there would be no
> other option, and the application could cope with the incurred delay.
> This hack is enabled when a RTDM interrupt handler returns
> XN_ISR_PROPAGATE, in which case the interrupt line is not unmasked upon
> return from the handler, and the event is posted to the linux domain.


My goal is just to show how interrupts can be propagated down the pipeline
to the next domain or how the Linux domain can be starved from interrupts.

Something like the Interrupt Shield referred in Xenomai documentation used
to starve Linux form events notifications while a real time task enters
secondary mode to run a Linux system call, and all the Linux kernel
inherits the RT priority of this RT task while executing the system call.

Helder



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
