In-Reply-To: <44870010.5050602@domain.hid>
Subject: Re: [Xenomai-core] Porting xenomai to AT91RM9200
Message-ID: <OFB7509C1E.97C177B3-ONC1257187.004F91D8-C1257187.00503FA0@domain.hid>
From: Yann.LEPROVOST@wavecom.fr
Date: Thu, 8 Jun 2006 16:30:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Content-Transfer-Encoding: quoted-printable
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

jan.kiszka@domain.hid a =E9crit sur 07/06/2006 18:34:24 :

> Yann.LEPROVOST@wavecom.fr wrote:
> > Hi marco,
> >
> > There is an issue with porting adeos to AT91RM9200. As i understood,
adeos
> > handles system timer interrupt directly to keep real time "tsc" up to
date.
> > To do that, porting xenomai to AT91RM9200 means coding the correct tsc
> > handling functions in arch/arm/mach-at91rm9200/time.c (in the same way
as
> > integrator board).
> > That's what i tried to do...
> >
> > But on AT91RM9200, the system interrupt timer line is shared among
other
> > system peripherals such as watchdog, serial debug unit, memory
controller,
> > ...
> > I try to demux the interrupt sharing by modifying code of adeos irq
> > handling but there are specificities with the interrupt controller I
can't
> > deal with...
> > I have lots of difficulties to understand the overall architecture of
the
> > adeos/xenomai source code...
>
> Then please ask questions.
>

__ipipe_handle_irq seems to dispatch each incoming interrupt to each domain
and acknowledge the interrupt controller with the incoming irq.
I think that "domain->irqs[irq].acknowledge(irq)" calls the irq
acknowledgement function of the specific AT91RM9200 irq chip... which
disables the
corresponding irq line on the interrupt controller. I have seen that the
call to the ack function has been removed from the do_level_IRQ...which
seems coherent.
The irq line is then reenabled on the interrupt controller when
do_level_IRQ is called from the Linux domain.

However, on the AT91RM9200 irq chip, we need to do a write to a special
register to indicate the end of the current interrupt handling (allowing
the controller
to reassert the cpu irq line if needed). This special write is handled by
irq_finish function. I though it had been the role of __ipipe_handle_irq to
call irq_finish. But the call
is done in asm_do_IRQ which I think is only called when running an irq of
the linux domain...
It could explain why my kernel freeze, doesn't it ?

Can anyone tell me if I'm totally wrong, or give me just a summary of how
irqs are normally handled between adeos domain and the irq controller ?


> >
> > At this time, I have an adeos/xenomai patched kernel which freezes when
> > launching the idle process... and I 'm a bit lost !?!
> > Probably something wrong with the interrupt timer handling...
> > I'd like to continue to work on xenomai port to AT91RM9200 but I need
> > support from people with good knowledge of adeos internals... or a good
> > documentation starting point on adeos internal.
> >
> > I currently stopped working on xenomai/adeos to study ingo molnar
> > patches...
>
> Ah, I just remembered your thread on LKML. Then you may know that the
> problem is the same with PREEMPT_RT. Thomas pointed out the only
> solution: Write stubs to manage shared non-RT IRQ sources in RT context
> (in PREEMPT_RT terms: create SA_NODELAY stubs for the otherwise threaded
> drivers).
>
> This problem pops up quite regularly, here is my standard reference for
> a realisation of such a stub. It actually worked once over RTAI:
>
> http://www.mail-archive.com/xenomai@xenomai.org
> (grab the idea, not the API from this code)
>
> The way I would go today: register a real-time IRQ handler for the
> non-RT driver, silence the IRQ source in that handler (switch off IRQ
> generation for the particular piece of hardware), save any required
> information, and issue a soft-IRQ to the Linux domain. Attach the Linux
> IRQ handler to the soft-IRQ then. In that handler, you could pick up the
> reasons for the suppressed IRQ, handle it as usual and re-enable the IRQ
> generation by the hardware. This way, the influence on the RT part
> remains bounded.
>
> The reason why this never made it into some real-time Linux variant:
> it's too-hardware specific, there is not much you can do in the OS to
> help solving this issue.
>

Well, I have not enough knowledge to appreciate your solution...
I though about some kind of irq line demultiplexing in the low level
function
in order to avoid irq line sharing. The idea was to change __ipipe_grab_irq
to demultiplex
each peripheral sharing the line and modifying the irq value send to
__ipipe_handle_irq in order
to have each peripheral a unique irq number...

Yann


