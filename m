MIME-Version: 1.0
In-Reply-To: <530BC103.3010809@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
Date: Tue, 25 Feb 2014 20:04:37 +0000
Message-ID: <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Thanks Gilles,

Do you mean to execute ipipe_trace_freeze instead of the warning and
kernel/irq/handle.c:146
?

I've recompiled the kernel with the following code in handle.c:146
 13 irqreturn_t

 12 handle_irq_event_percpu(struct irq_desc *desc, struct irqaction
*action)
 11 {

 10     irqreturn_t retval = IRQ_NONE;

  9     unsigned int flags = 0, irq = desc->irq_data.irq;

  8

  7     do {

  6         irqreturn_t res;

  5

  4         trace_irq_handler_entry(irq, action);

  3         res = action->handler(irq, action->dev_id);

  2         trace_irq_handler_exit(irq, action, res);

  1

145         if (!irqs_disabled()) ipipe_trace_freeze(1);

  1

  2         if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled
interrupts\n",
  3                   irq, action->handler))

  4             local_irq_disable();


But this does not trigger trace freeze.
What is the 'unsigned int v' in the definition of ipipe_trace_freeze?


On 24 February 2014 22:00, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/24/2014 10:19 PM, Gregory Dymarek wrote:
> > Hi Gilles,
> >
> > I compiled the kernel width the stack unwind disabled and it throws the
> > same warning while booting: http://pastebin.com/mSTnPACr
> > [    1.948056] WARNING: at kernel/irq/handle.c:146
> > handle_irq_event_percpu+0x198/0x1c0(
> > [    1.959568] irq 32 handler usb_hcd_irq+0x0/0x84 enabled interrupts
> >
> > Also, when unlpugging USB devices I get kernel panics:
> > http://pastebin.com/Nr87y8Ki
>
> Yes, but we now have a clear trace, where we see that ipipe_do_irq is
> indeed called.
>
> >
> > What else would you need to see to identify the actual failure?
> > How should be the root domain stalled, how to look for it?
>
> The simplest solution is to enable the I-pipe tracer, and trigger a
> trace freeze instead of the warning.
>
> The I-pipe tracer should show us where the root domain is unstalled.
>
> --
>                                                                 Gilles.
>
