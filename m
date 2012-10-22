Message-ID: <508547AC.7020103@xenomai.org>
Date: Mon, 22 Oct 2012 15:18:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50812949.5040403@openwide.fr> <50814532.5090408@xenomai.org>
	<5082CD5C.1040409@openwide.fr> <5082DED2.1050405@xenomai.org>
	<50835162.5020401@openwide.fr> <50844242.7010107@xenomai.org>
	<5084863E.7030900@openwide.fr>
In-Reply-To: <5084863E.7030900@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] s3c24xx with clocksource/clockevent (kernel 3.2.21)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 10/22/2012 01:33 AM, Romain Naour wrote:

> Le 21/10/2012 20:43, Gilles Chanteperdrix a =C3=A9crit :
>> On 10/21/2012 03:35 AM, Romain Naour wrote:
>>
>>>> You mean the patch for the UART ? I can not take that patch. You hav=
e to
>>>> understand what goes wrong in the I-pipe core, or irq chip callbacks=

>>>> implementation for this processor, and fix it there, not in the irq
>>>> handler for the serial interrupt.
>>> I think there is a problem when Linux unmask an IRQ line with
>>> irq_enable() and when there is an IRQ pending behind.
>>> I made some comments on the ipipe-tracer log
>>> (UART-samsung-bug-ipipe-tracer.txt)
>>
>> Ok: first comment: thanks to this patch:
>> http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3D352ee0736=
8a89133df74948f3dd71ae657c519a0;hp=3D5e7413789eb3d1ca1613e986cbeb6c979082=
a217
>>
>> We know that irq_state_clr_masked is called when unmask_irq is called.=

>>
>> Second, to know why cond_unmask_irq does not unmask the irq, you can u=
se
>> ipipe_trace_special to print the value of the various conditions.
>>
>> It would have been better to include the relevant parts of the trace i=
n
>> the mail body, this would have made answering simpler.
>>
> Ok, sorry for that.
>=20
> here are some new trace with id :
> (1): IRQ enabled =3D=3D 1
> (2): IRQ masked =3D=3D 1
> (3): Treads oneshot =3D=3D 1


Ok, so, if it is a oneshot irq, it means that it is a threaded irq, and
should be unmasked by the irq thread, not by handle_level_irq. You
should find the reason why the irq thread does not unmask it.

As explained on the page I directed you too, converting a spinlock to an
ipipe_spinlock is not something that should be done lightly. Otherwise,
you might well end-up with large masking sections, so, I would try and
find what section needs to run with irqs off, and only disable irqs for
that section.

A good candidate would be for instance, in s3c24xx_serial_start_tx, to
shuts off irqs around enable_irq and tx_enabled(port) =3D 1. Or,
alternatively, put tx_enabled(port) =3D 1 before the call to enable_irq,
and put a compiler barrier so that the instructions to not get reordered.=


Another candidate would be irq_enable in kernel/irq/chip.c, shut off the
irqs around the whole section, or move irq_state_clk_masked before the
call to irq_unmask with a compiler barrier.

Yet another candidate would be changing cond_unmask_irq in
kernel/irq/chip.c.

--=20
                                                                Gilles.


