Subject: Re: [Adeos-main] __adeos_handle_event
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>
References: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1098196627.666.9.camel@domain.hid>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 16:37:07 +0200
Content-Transfer-Encoding: quoted-printable
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: =?ISO-8859-1?Q?Andr=E9?= Tousch <andre.tousch@domain.hid>
Cc: adeos-main@gna.org

On Tue, 2004-10-19 at 15:10, Andr=E9 Tousch wrote:
> Hi,
>=20
> I'm currently using Adeos 2.4/armnommu to run an RTOS with Linux.=20
> It works well but I have a problem with events.
> I use __adeos_handle_event(ADEOS_USER_EVENT, &event) to send informatio=
n
> from Linux to the RTOS.
> Reciprocally, I use adeos_propagate_irq(IRQ_A) to send information from
> the RTOS to Linux.
> Now I have the following scenario: Linux sends an event to the RTOS,
> which replies from the event handler by propagating an IRQ.=20
>=20
> 1) Linux does __adeos_handle_event(ADEOS_USER_EVENT). Domain switches t=
o
> RTOS
> 2) RTOS handles the event. It adeos_propagate_irq()'s to Linux.
> 3) RTOS does adeos_suspend_domain(). Domain switches back to Linux.
> 4) Linux runs from just after the context switch in
> __adeos_handle_event(). No __adeos_sync_stage() is made, and the IRQ_A
> handler is not called before next hardware IRQ.
>=20
> Why is there no call to __adeos_sync_stage() in __adeos_handle_event()?=
=20

It's on purpose. Flushing the IRQ log inside the event handling loop has
a dreadful side-effect on 2.6.
2.4 code has converged to the 2.6 implementation here. This said,
running:

__adeos_handle_event()
adeos_unstall_stage()

should work as expected.=20

> Or do I miss something?
> Thanks for you support
>=20
> Regards,
> Andr=E9 Tousch
>=20
>=20
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
--=20

Philippe.


