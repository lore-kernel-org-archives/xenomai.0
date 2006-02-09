Message-ID: <43EB703C.2090704@domain.hid>
Date: Thu, 09 Feb 2006 17:39:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] More on Shared interrupts
References: <b647ffbd0602070104s63275903q@domain.hid>		<43E86F4D.4050400@domain.hid>		<43E8DFC4.4010805@domain.hid>	<43E9CE95.3070806@domain.hid>	
	<43EAFD8B.7020400@domain.hid>	<43EB1279.3040902@domain.hid>	
	<43EB1741.9080809@domain.hid>	<b647ffbd0602090311x56dbc765x@domain.hid>
	<43EB63D7.2080507@domain.hid>
In-Reply-To: <43EB63D7.2080507@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig742A660CBAC2A288F7360B46"
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
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig742A660CBAC2A288F7360B46
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Anders Blomdell wrote:
> For the last few days, I have tried to figure out a good way to share
> interrupts between RT and non-RT domains. This has included looking
> through Dmitry's patch, correcting bugs and testing what is possible in=

> my specific case. I'll therefore try to summarize at least a few of my
> thoughts.
>=20
> 1. When looking through Dmitry's patch I get the impression that the
> iack handler has very little to do with each interrupt (the test
> 'prev->iack !=3D intr->iack' is a dead giveaway), but is more of a
> domain-specific function (or perhaps even just a placeholder for the
> hijacked Linux ack-function).
>=20
>=20
> 2. Somewhat inspired by the figure in "Life with Adeos", I have
> identified the following cases:
>=20
>   irq K  | ----------- | ---o    |   // Linux only
>   ...
>   irq L  | ---o        |         |   // RT-only
>   ...
>   irq M  | ---o------- | ---o    |   // Shared between domains
>   ...
>   irq N  | ---o---o--- |         |   // Shared inside single domain
>   ...
>   irq O  | ---o---o--- | ---o    |   // Shared between and inside singl=
e
> domain
>=20
> Xenomai currently handles the K & L cases, Dmitrys patch addresses the =
N
> case, with edge triggered interrupts the M (and O after Dmitry's patch)=

> case(s) might be handled by returning RT_INTR_CHAINED | RT_INTR_ENABLE
> from the interrupt handler, for level triggered interrupt the M and O
> cases can't be handled.

I guess you mean it the other way around: for the edge-triggered
cross-domain case we would actually have to loop over both the RT and
the Linux handlers until we are sure, that the IRQ line was released once=
=2E

Luckily, I never saw such a scenario which were unavoidable (it hits you
with ISA hardware which tend to have nice IRQ jumpers or other means -
it's just that you often cannot divide several controllers on the same
extension card IRQ-wise apart).

>=20
> If one looks more closely at the K case (Linux only interrupt), it work=
s
> by when an interrupt occurs, the call to irq_end is postponed until the=

> Linux interrupt handler has run, i.e. further interrupts are disabled.
> This can be seen as a lazy version of Philippe's idea of disabling all
> non-RT interrupts until the RT-domain is idle, i.e. the interrupt is
> disabled only if it indeed occurs.
>=20
> If this idea should be generalized to the M (and O) case(s), one can't
> rely on postponing the irq_end call (since the interrupt is still neede=
d
> in the RT-domain), but has to rely on some function that disables all
> non-RT hardware that generates interrupts on that irq-line; such a
> function naturally has to have intimate knowledge of all hardware that
> can generate interrupts in order to be able to disable those interrupt
> sources that are non-RT.
>=20
> If we then take Jan's observation about the many (Linux-only) interrupt=
s
> present in an ordinary PC and add it to Philippe's idea of disabling al=
l
> non-RT interrupts while executing in the RT-domain, I think that the
> following is a workable (and fairly efficient) way of handling this:
>=20
> Add hardware dependent enable/disable functions, where the enable is
> called just before normal execution in a domain starts (i.e. when
> playing back interrupts, the disable is still in effect), and disable i=
s
> called when normal domain execution end. This does effectively handle
> the K case above, with the added benefit that NO non-RT interrupts will=

> occur during RT execution.
>=20
> In the 8259 case, the disable function could look something like:
>=20
>   domain_irq_disable(uint irqmask) {
>     if (irqmask & 0xff00 !=3D 0xff00) {
>       irqmask &=3D ~0x0004; // Cascaded interrupt is still needed
>       outb(irqmask >> 8, PIC_SLAVE_IMR);
>     }
>     outb(irqmask, PIC_MASTER_IMR);
>   }
>=20
> If we should extend this to handle the M (and O) case(s), the disable
> function could look like:
>=20
>   domain_irq_disable(uint irqmask, shared_irq_t *shared[]) {
>     int i;
>=20
>     for (i =3D 0 ; i < MAX_IRQ ; i++) {
>       if (shared[i]) {
>         shared_irq_t *next =3D shared[i];
>         irqmask &=3D ~(1<<i);
>         while (next) {
>           next->disable();
>       next =3D next->next;
>         }

This obviously means that all non-RT IRQ handlers sharing a line with
the RT domain would have to be registered in that shared[]-list. This
gets close to my old suggestion. Just raises the question how to
organise these interface, both on the RT and the Linux side.

>       }
>     }
>     if (irqmask & 0xff00 !=3D 0xff00) {
>       irqmask &=3D ~0x0004; // Cascaded interrupt is still needed
>       outb(irqmask >> 8, PIC_SLAVE_IMR);
>     }
>     outb(irqmask, PIC_MASTER_IMR);
>   }
>=20
> An obvious optimization of the above scheme, is to never call the
> disable (or enable) function for the RT-domain, since there all
> interrupt processing is protected by the hardware.

Another point is to avoid that looping over disable handlers for IRQs of
the K case. Otherwise, too many device-specific disable handlers had to
be implemented even if only a single Linux device hogs a RT IRQ.

>=20
> Comments, anyone?
>=20

I see your need, we just have to keep in mind that we are currently
discussing the corner case (shared RT/non-RT IRQs) of the corner case
(shared RT IRQs). Whatever will be defined, the normal use case should
define how an efficient interface has to look like. Or we have to add a
lot of #ifdef's...

Jan


--------------enig742A660CBAC2A288F7360B46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD63A8niDOoMHTA+kRAiyDAJ9ZVvQSk1uUCdjmWbTPdZ2OCneX1wCfSQl3
XcY8hrE5Gfjl8S3V7gWZPdg=
=D4su
-----END PGP SIGNATURE-----

--------------enig742A660CBAC2A288F7360B46--

