Subject: Re: [Adeos-main] End of interrupt scheduling
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
In-Reply-To: <41B974E9.7080801@domain.hid>
References: <008b01c4b5dd$04d20890$7405a8c0@domain.hid>
	 <1098196627.666.9.camel@domain.hid> <1098196994.666.11.camel@domain.hid>
	 <41B974E9.7080801@domain.hid>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1102807988.696.87.camel@domain.hid>
Mime-Version: 1.0
Date: Sun, 12 Dec 2004 00:33:08 +0100
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
To: Andre Tousch <andre.tousch@domain.hid>
Cc: adeos-main@gna.org

On Fri, 2004-12-10 at 11:05, Andre Tousch wrote:
> Hi,
>=20
> I'm currently using an RTOS with Linux/Adeos on ARM. The original=20
> behaviour of the RTOS interrupt handler is:
>=20
> - Lock interrupts
> - Call high-level interrupt handler
> - Unlock interrupts
> - Schedule()
>=20
> Adeos behaviour on sync_stage is:
> - Stall domain
> - Call interrupt handler
> -  Unstall Domain
>=20
> If I want to imitate the original RTOS behaviour, I have to schedule=20
> (RTOS scheduler) at end of interrupt.
> I cannot do that in this domain's interrupt handler, since it would=20
> Schedule() with domain stalled, and thus the domain would not receive=20
> the interrupts until it gives control back to Adeos by suspending itsel=
f.
> So the only way I've found to do that was to had a hook in Adeos which=20
> would be called at sync_stage, just after interrupt handler call.
> Thus the modified Adeos behaviour on sync_stage is:
>=20
> - Stall domain
> - Call interrupt handler
> -  Unstall Domain
> - Call EndOfInterrupt Handler.
>=20
> Now I have exactly the behaviour expected from my RTOS.
>=20
> My question is, was there already a way to obtain this behaviour in Ade=
os?
>=20

In short, the answer is: you don't need to put any hooks.

Your rtos_schedule() routine is expected to reinstate the interrupt mask
of the resumed thread, after having saved it on entry as it was
scheduled out, thus overriding the current setting inherited by your
interrupt handler. Unless your thread called rtos_schedule() with
interrupts off, the resumption will thus unstall your domain's stage as
a side-effect. Even in the former case (i.e. called with interrupts
off), the resuming thread is expected to unstall the pipeline at some
point in time, or at the very least schedule out asap if it happens to
always run interrupts off.

i.e.

void rtos_schedule (void)

{
    unsigned long flags;

   /* Entering with interrupts on */
   flags =3D adeos_test_and_stall_pipeline_from(&your_rt_domain);

   /* Now running interrupt-free for performing critical stuff involved
       by switching contexts */
   ... pick next thread and switch context...

 adeos_restore_pipeline_from(&your_rt_domain,flags);
  /* Exiting with interrupts on */
}

If rtos_schedule() leads to a no-op because no thread switch has taken
place, then your IRQ handler will return to __adeos_sync_stage() which
will in turn unlock the stage.

You can find a complete illustration of this in the RTAI implementation
btw.

> Best regards,
> Andr=E9
>=20
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
--=20

Philippe.


