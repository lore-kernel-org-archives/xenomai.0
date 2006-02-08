Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Watchdog/Interrupt management
Date: Wed, 8 Feb 2006 13:09:41 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0210CFD@EINT11.einet.ad.eivd.ch>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,


> -----Message d'origine-----
> De=A0: Philippe Gerum [mailto:rpm@xenomai.org]
> Envoy=E9=A0: mardi, 7. f=E9vrier 2006 14:45
> =C0=A0: ROSSIER Daniel
> Cc=A0: xenomai@xenomai.org
> Objet=A0: Re: [Xenomai-core] Watchdog/Interrupt management
>=20
> ROSSIER Daniel wrote:
> > Hi all,
> >
> > I've a - probably small ;-) - issue regarding the way how the =
watchdog
> and interrupt management are working together.
> > I'd like to implement a watchdog in a task to ensure that a task is =
well
> alive at periodic interval. For doing some tests, I've
> > implemented a small ISR which interceipts the keyboard interrupts =
(IRQ
> 1). The ISR is simply doing some busy wait burning CPU time,
> > but with a delay greater than the task period.
> > I assume that the ISR locks the rescheduling procedure as it is =
stated
> in the API doc (BTW; many thanks for having solved the doc issue).
> > So, the task switching is temporarly suspended and the watchdog =
should
> raise up an alarm after the ISR has been completed, right?
> > It doesn't.
>=20
> Because Adeos disables interrupts by default when calling an ISR from =
a
> non-Linux
> domain (like Xenomai's). You can re-enable them to get nested =
interrupts
> by doing
> this in your ISR:
>=20
> unsigned long flags;
>=20
> rthal_local_irq_sync(flags);
> <spin>
> rthal_local_irq_restore(flags);

Please, could you just provide me with a small explanation about what =
the rthal_local_irq_sync() function is doing?=20

>=20
> > I've attached the code below (I've removed the function return check =
for
> readibility reasons, but all objects are fine).
> >
> > Another question:  the ISR is called on behalf of the interrupted =
stack
> context: does it mean that the ISR always runs in the stack context of =
the
> highest priority task, i.e. the running task (assume no inversion
> priority), or could it in some cases the kernel stack context (if =
ADEOS is
> currently doing some interruptible stuff..)
> >
>=20
> I-pipe Adeos versions always run interrupt handlers over the stack of =
the
> preempted context.
>=20

So, I presume I can use the  rt_task_self() function to get the task =
which has been pre-empted, right? (and I've always a valid task)


Thanks for your help.

Daniel


