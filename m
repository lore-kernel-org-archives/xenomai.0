Message-ID: <4421D80D.9020504@domain.hid>
Date: Thu, 23 Mar 2006 00:04:45 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Interrupt priorities
References: <200603201647.51941.lbocseg@domain.hid>
In-Reply-To: <200603201647.51941.lbocseg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Rodrigo Rosenfeld Rosas wrote:
> Hi Philippe.
>=20
> I was wondering if there are any plans to provide an option to Xenomai =
to=20
> allow the use of interrupt priorities. I mean, by having the timer sour=
ce as=20
> the most prioritary interrupt so that the scheduler could preempt the=20
> interrupt.
>=20
> Let me explain why such option would be good. When I was testing my=20
> framegrabber driver, I had to reboot my PC about 10 times until I could=
=20
> identificate what was causing total freeze of the system. The problem w=
as on=20
> the interrupt handler. One of the problems was that I was not clearing =
the=20
> interrupt events correctly so that the handler was in loop. The other p=
roblem=20
> was a crash inside the interrupt due to something like:
>=20
> uint64_t timestamp=3Drtdm_clock_read();
> b.timestamp =3D *((struct timeval *) timestamp);
>=20
> Where it should be
> b.timestamp =3D *((struct timeval *) &timestamp);
>=20
> I forgot the '&' char.
>=20
> If it was possible to preempt the interrupt, by a task of greater prior=
ity, I=20
> could write a watchdog that would disable the interrupt in case the sys=
tem=20
> stops responding.
>=20
> Do you think it would worth providing such option to Xenomai, at least =
as a=20
> debug feature?
>=20

Actually, this is an Adeos issue. Adeos should be taught to preserve hw=20
interrupt priorities, or at least be given some sort of fairness, when=20
syncing the interrupt log. Currently, high-numbered IRQs are processed=20
before low-numbered ones, so if the former pile up indefinitely, this=20
could prevent the delivery of the latter.

A way to pull the brake when some interrupt channel goes wild is to=20
activate Xenomai's NMI watchdog, which is never pipelined on any Adeos=20
implementation. This requires an APIC to be available on your x86 CPU=20
though. Additionally, interrupt serialization could be prevented just by=20
re-enabling hw interrupts in Xenomai's ISR, since the nucleus supports=20
reentrancy, but I don't think that's the issue you experienced. Timer=20
IRQs did show up, but likely remained stuck in the log due to the=20
misbehaving IRQ channel with higher software priority.

> Best Regards,
>=20
> Rodrigo.
>=20
> P.S: BTW, I think my driver is usable now, so that you (or someone else=
) could=20
> cite it in some article or documentation. When I finish my master thesi=
s (my=20
> deadline is the end of June ), I think I'll have time to comment it bet=
ter=20
> and to remove the Data Translation specific code so that it can me made=
=20
> available as a template for real-time video interfaces. Or maybe you co=
uld=20
> convince Data Translation to allow me to show all the code! ;)
>=20

Having a reusable template would already be nice, and likely appreciated=20
by the RTDM people too, since that's precious on hand information.

> 	=09
> _______________________________________________________
> Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discad=
or agora!
> http://br.acesso.yahoo.com
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20


--=20

Philippe.

