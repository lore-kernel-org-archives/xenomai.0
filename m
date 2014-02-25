Message-ID: <530CFB0D.8040001@xenomai.org>
Date: Tue, 25 Feb 2014 21:20:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFRN56pZkzmYwBpyupYkbj+V1mgYUPHk4YfLshSs-zFGGw@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
 <530A8767.4030004@xenomai.org>
 <CAEbDrgmf+RtS5gS5SKO7eq66ge-LHoJ0hTOC=yeRmUgk0MXqog@mail.gmail.com>
 <530BC103.3010809@xenomai.org>
 <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
In-Reply-To: <CAEbDrgnFr7YvfoMmFQx=PBKSFEWvwJftx0wZx39ySMqRO2X6gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: xenomai@xenomai.org

On 02/25/2014 09:04 PM, Gregory Dymarek wrote:
> Thanks Gilles,
> 
> Do you mean to execute ipipe_trace_freeze instead of the warning and
> kernel/irq/handle.c:146
> ?

Yes.

> 
> I've recompiled the kernel with the following code in handle.c:146
>  13 irqreturn_t
> 
>  12 handle_irq_event_percpu(struct irq_desc *desc, struct irqaction
> *action)
>  11 {
> 
>  10     irqreturn_t retval = IRQ_NONE;
> 
>   9     unsigned int flags = 0, irq = desc->irq_data.irq;
> 
>   8
> 
>   7     do {
> 
>   6         irqreturn_t res;
> 
>   5
> 
>   4         trace_irq_handler_entry(irq, action);
> 
>   3         res = action->handler(irq, action->dev_id);
> 
>   2         trace_irq_handler_exit(irq, action, res);
> 
>   1
> 
> 145         if (!irqs_disabled()) ipipe_trace_freeze(1);
> 
>   1
> 
>   2         if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled
> interrupts\n",
>   3                   irq, action->handler))
> 
>   4             local_irq_disable();
> 
> 
> But this does not trigger trace freeze.

the tracer should be compiled-in and started, see:
http://www.xenomai.org/index.php/Xenomai:I-pipe_Tracer#API


> What is the 'unsigned int v' in the definition of ipipe_trace_freeze?

It is a value you will find back in the trace.


-- 
                                                                Gilles.

