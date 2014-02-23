MIME-Version: 1.0
In-Reply-To: <530A69FD.9060708@xenomai.org>
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <530A69FD.9060708@xenomai.org>
Date: Sun, 23 Feb 2014 22:18:29 +0000
Message-ID: <CAEbDrg=PLtrwo3aDUDa6wOJzsj7P4kmYZ64irV8e+P7MiEzTig@mail.gmail.com>
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

Thank you for such quick response!

Actually yes, this is a warning. Sorry.

That's the content:
irqreturn_t handle_irq_event_percpu(struct irq_desc *desc, struct irqaction
*action)
...
 if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled interrupts\n",
irq, action->handler))
      local_irq_disable();


Should the IRQs be 'not disabled' at the first place?

When running unpatched kernel this is not the case.


On 23 February 2014 21:37, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 02/23/2014 10:27 PM, Gregory Dymarek wrote:
> > Hi,
> >
> >
> > I compiled a fresh rpi-3.8 kernel using the following patches (from
> > xenomai-2.6.3):
> > - ipipe-core-3.8.13-raspberry-pre-2.patch
> > - ipipe-core-3.8.13-arm-3.patch
> > - ipipe-core-3.8.13-raspberry-post-2.patch
> >
> > All compiled well, but when booting this kernel it reports an exception.
> > The entire boot log is here: http://pastebin.com/K7v44nPw
> >
> > I am still not very faimiliar with the architecture so I am not really
> able
> > to sort it myself...
> > Any advise please?
>
>
>
> >
> > [    1.915956] hub 1-0:1.0: 1 port detected
> > [    1.923672] ------------[ cut here ]------------
> > [    1.931807] WARNING: at kernel/irq/handle.c:146
> > handle_irq_event_percpu+0x190/0x1b4()
>
> It is not an exception, it is a warning, what is there at
> kernel/irq/handle.c:146 in the kernel you are using?
>
>
> --
>                                                                 Gilles.
>
