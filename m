MIME-Version: 1.0
In-Reply-To: <530CFB0D.8040001@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
 <530CFB0D.8040001@xenomai.org>
Date: Tue, 25 Feb 2014 20:23:49 +0000
Message-ID: <CAEbDrgnptcM4BCMnpOpS0pqGN=FE3vn4dKgiwNdMDw7U9yuwJg@mail.gmail.com>
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

I should have added more context.

I'm sure I recompiled the kernel correctly with CONFIG_IPIPE_TRACE
Because, when I unplug my USB device i get the ipipe trace now instead of
default kernel panic.

   CONFIG_IPIPE_DEBUG=y

   CONFIG_IPIPE_DEBUG_CONTEXT=y

   CONFIG_IPIPE_DEBUG_INTERNAL=y

   CONFIG_IPIPE_TRACE=y

   CONFIG_IPIPE_TRACE_ENABLE=y

   CONFIG_IPIPE_TRACE_MCOUNT=y

   CONFIG_IPIPE_TRACE_IRQSOFF=y

   CONFIG_IPIPE_TRACE_SHIFT=14

   CONFIG_IPIPE_TRACE_VMALLOC=y

   CONFIG_IPIPE_TRACE_PANIC=y

Adding ipipe_trace_freeze to irq/handle.c:146 does not seem to trigger the
trace. Even if I define it in the main code block (without if statement)
this prints nothing. Could this be that a early printk is needed or some
other similar ipipe respective routine?

Is there another way of tracing the issue down?


On 25 February 2014 20:20, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/25/2014 09:04 PM, Gregory Dymarek wrote:
> > Thanks Gilles,
> >
> > Do you mean to execute ipipe_trace_freeze instead of the warning and
> > kernel/irq/handle.c:146
> > ?
>
> Yes.
>
> >
> > I've recompiled the kernel with the following code in handle.c:146
> >  13 irqreturn_t
> >
> >  12 handle_irq_event_percpu(struct irq_desc *desc, struct irqaction
> > *action)
> >  11 {
> >
> >  10     irqreturn_t retval = IRQ_NONE;
> >
> >   9     unsigned int flags = 0, irq = desc->irq_data.irq;
> >
> >   8
> >
> >   7     do {
> >
> >   6         irqreturn_t res;
> >
> >   5
> >
> >   4         trace_irq_handler_entry(irq, action);
> >
> >   3         res = action->handler(irq, action->dev_id);
> >
> >   2         trace_irq_handler_exit(irq, action, res);
> >
> >   1
> >
> > 145         if (!irqs_disabled()) ipipe_trace_freeze(1);
> >
> >   1
> >
> >   2         if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled
> > interrupts\n",
> >   3                   irq, action->handler))
> >
> >   4             local_irq_disable();
> >
> >
> > But this does not trigger trace freeze.
>
> the tracer should be compiled-in and started, see:
> http://www.xenomai.org/index.php/Xenomai:I-pipe_Tracer#API
>
>
> > What is the 'unsigned int v' in the definition of ipipe_trace_freeze?
>
> It is a value you will find back in the trace.
>
>
> --
>                                                                 Gilles.
>
