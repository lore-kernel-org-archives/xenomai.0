Message-ID: <44886894.4030407@domain.hid>
Date: Thu, 08 Jun 2006 20:12:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xenomai to AT91RM9200
References: <OFB7509C1E.97C177B3-ONC1257187.004F91D8-C1257187.00503FA0@domain.hid>
In-Reply-To: <OFB7509C1E.97C177B3-ONC1257187.004F91D8-C1257187.00503FA0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig051F3C589A3F82DA5D631175"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Yann.LEPROVOST@wavecom.fr
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig051F3C589A3F82DA5D631175
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Yann,

short on time, short answer:

Yann.LEPROVOST@wavecom.fr wrote:
> jan.kiszka@domain.hid a =E9crit sur 07/06/2006 18:34:24 :
>=20
>> Yann.LEPROVOST@wavecom.fr wrote:
>>> Hi marco,
>>>
>>> There is an issue with porting adeos to AT91RM9200. As i understood,
> adeos
>>> handles system timer interrupt directly to keep real time "tsc" up to=

> date.
>>> To do that, porting xenomai to AT91RM9200 means coding the correct ts=
c
>>> handling functions in arch/arm/mach-at91rm9200/time.c (in the same wa=
y
> as
>>> integrator board).
>>> That's what i tried to do...
>>>
>>> But on AT91RM9200, the system interrupt timer line is shared among
> other
>>> system peripherals such as watchdog, serial debug unit, memory
> controller,
>>> ...
>>> I try to demux the interrupt sharing by modifying code of adeos irq
>>> handling but there are specificities with the interrupt controller I
> can't
>>> deal with...
>>> I have lots of difficulties to understand the overall architecture of=

> the
>>> adeos/xenomai source code...
>> Then please ask questions.
>>
>=20
> __ipipe_handle_irq seems to dispatch each incoming interrupt to each do=
main
> and acknowledge the interrupt controller with the incoming irq.
> I think that "domain->irqs[irq].acknowledge(irq)" calls the irq
> acknowledgement function of the specific AT91RM9200 irq chip... which
> disables the
> corresponding irq line on the interrupt controller. I have seen that th=
e
> call to the ack function has been removed from the do_level_IRQ...which=

> seems coherent.
> The irq line is then reenabled on the interrupt controller when
> do_level_IRQ is called from the Linux domain.
>=20
> However, on the AT91RM9200 irq chip, we need to do a write to a special=

> register to indicate the end of the current interrupt handling (allowin=
g
> the controller
> to reassert the cpu irq line if needed). This special write is handled =
by
> irq_finish function. I though it had been the role of __ipipe_handle_ir=
q to
> call irq_finish. But the call
> is done in asm_do_IRQ which I think is only called when running an irq =
of
> the linux domain...
> It could explain why my kernel freeze, doesn't it ?
>=20
> Can anyone tell me if I'm totally wrong, or give me just a summary of h=
ow
> irqs are normally handled between adeos domain and the irq controller ?=

>=20
>=20
>>> At this time, I have an adeos/xenomai patched kernel which freezes wh=
en
>>> launching the idle process... and I 'm a bit lost !?!
>>> Probably something wrong with the interrupt timer handling...
>>> I'd like to continue to work on xenomai port to AT91RM9200 but I need=

>>> support from people with good knowledge of adeos internals... or a go=
od
>>> documentation starting point on adeos internal.
>>>
>>> I currently stopped working on xenomai/adeos to study ingo molnar
>>> patches...
>> Ah, I just remembered your thread on LKML. Then you may know that the
>> problem is the same with PREEMPT_RT. Thomas pointed out the only
>> solution: Write stubs to manage shared non-RT IRQ sources in RT contex=
t
>> (in PREEMPT_RT terms: create SA_NODELAY stubs for the otherwise thread=
ed
>> drivers).
>>
>> This problem pops up quite regularly, here is my standard reference fo=
r
>> a realisation of such a stub. It actually worked once over RTAI:
>>
>> http://www.mail-archive.com/xenomai@xenomai.org
>> (grab the idea, not the API from this code)
>>
>> The way I would go today: register a real-time IRQ handler for the
>> non-RT driver, silence the IRQ source in that handler (switch off IRQ
>> generation for the particular piece of hardware), save any required
>> information, and issue a soft-IRQ to the Linux domain. Attach the Linu=
x
>> IRQ handler to the soft-IRQ then. In that handler, you could pick up t=
he
>> reasons for the suppressed IRQ, handle it as usual and re-enable the I=
RQ
>> generation by the hardware. This way, the influence on the RT part
>> remains bounded.
>>
>> The reason why this never made it into some real-time Linux variant:
>> it's too-hardware specific, there is not much you can do in the OS to
>> help solving this issue.
>>
>=20
> Well, I have not enough knowledge to appreciate your solution...

The topic is fairly complex, we pulled hairs earlier. ;)

> I though about some kind of irq line demultiplexing in the low level
> function
> in order to avoid irq line sharing. The idea was to change __ipipe_grab=
_irq
> to demultiplex
> each peripheral sharing the line and modifying the irq value send to
> __ipipe_handle_irq in order
> to have each peripheral a unique irq number...

As long as your IRQ sources share the same *physical* line, this will
buy you nothing. The hardware of all involved devices has to release the
IRQ line first in order to re-enable it. Otherwise, you will die in IRQ
storms. That's at least true for level-triggered IRQs (I haven't checked
a scenario with edge-triggering hardware yet).

Jan


--------------enig051F3C589A3F82DA5D631175
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEiGiVniDOoMHTA+kRAsxpAJ4vsxB/+P05IuRJELCb36f4aRBg3wCeOP6s
LOYNGO1QMNEp8JYgYcXQWYs=
=EXpO
-----END PGP SIGNATURE-----

--------------enig051F3C589A3F82DA5D631175--

