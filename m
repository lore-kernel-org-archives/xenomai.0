From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <000001c9c75b$e8f288d0$bad79a70$@com>
References: <000001c9c75b$e8f288d0$bad79a70$@com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 28 Apr 2009 10:48:22 +0200
Message-Id: <1240908502.6990.337.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_intr_wait
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wcall@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2009-04-27 at 11:16 -0600, Wayne Call wrote:
> The code below attempts to process an interrupt in user space.  The
> IRQ is set at 26, and this interrupt fires at once per second.  If the
> rt_intr_create sets the mode to I_NOAUTOENA, the rt_intr_wait detects
> one interrupt, and then no other interrupts are detected.

Doing so, you tell the Xenomai core not to re-enable the handled
interrupt channel when your ISR has returned, so it expects you do that
on your side when your code sees it fit, by calling rt_intr_enable().

>   Likewise for if the mode is set to I_PROPAGATE.=20

This mode implies no-enable as well, since it tells the Xenomai core to
progagate the interrupt notification down to the Linux kernel, and
expects the latter to re-enable the channel when it is done with
handling the IRQ.

>  If the mode is set to 0, it appears that the rt_intr_wait detects
> interrupts at a very high rate, possible thousands per second.  It
> appears that the code is detecting some other interrupt, and not the
> IRQ at 26.
>=20

This can't be. I would rather suspect a level sense interrupt storming
your board because your handler did not clear the interrupt properly.

> =20
>=20
> Below is the irq file and stat file for when the mode is set to
> I_NOAUTOENA or I_PROPAGATE.
>=20
> =20
>=20
>=20
>=20
> =20
>=20
>=20
>=20
> =20
>=20
> Is there a step that I=E2=80=99m missing to get the rt_intr_wait to rec=
ognize
> the correct IRQ?
>=20
> =20
>=20
> Wayne
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> //
>=20
> // pwm_precon.c
>=20
> //=20
>=20
> =20
>=20
> #include <sys/mman.h>
>=20
> #include <signal.h>
>=20
> #include <native/task.h>
>=20
> #include <native/intr.h>
>=20
> #include <stdio.h>
>=20
> #defineCOMPILE_LPL_DEBUG           1
>=20
> #include "../lplLib/lplDebug.h"
>=20
> =20
>=20
> #defineLPL_PWM_PRECON_IRQ_NUMBER   26
>=20
> #defineLPL_PWM_PRECON_TASK_PRIO    99
>=20
> #defineLPL_PWM_PRECON_TASK_MODE    0
>=20
> #defineLPL_PWM_PRECON_TASK_STKSZ   0
>=20
> =20
>=20
> =20
>=20
> RT_INTR     m_interruptDescriptor;
>=20
> RT_TASK     m_serverDescriptor;
>=20
> =20
>=20
> long int    m_isrCounter =3D 0;
>=20
> =20
>=20
> =20
>=20
> void cleanup(int sig);
>=20
> =20
>=20
> =20
>=20
> void lpl_pwm_precon_irq_server(void *cookie)
>=20
> {
>=20
>     int err;
>=20
> =20
>=20
>     for (;;)=20
>=20
>     {
>=20
>        // Wait for next interrupt
>=20
>         err =3D rt_intr_wait(&m_interruptDescriptor, TM_INFINITE);
>=20
>        if (err > 0)=20
>=20
>        {
>=20
>             LPL_DEBUG("process interrupt", m_isrCounter, %d);=20
>=20
>        }
>=20
>         m_isrCounter++;
>=20
>         LPL_DEBUG("isr real-time interrupt", err, %d);=20
>=20
>     }
>=20
> }
>=20
> =20
>=20
> =20
>=20
> int main (int argc, char *argv[])
>=20
> {
>=20
>     int err =3D 0;
>=20
>     intbfinTimerStatus;
>=20
> =20
>=20
>     mlockall(MCL_CURRENT | MCL_FUTURE);
>=20
>     err =3D rt_intr_create(&m_interruptDescriptor,"PWM_PRECON_IRQ",
> LPL_PWM_PRECON_IRQ_NUMBER, I_NOAUTOENA);
>=20
> //    err =3D rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
> LPL_PWM_PRECON_IRQ_NUMBER, I_PROPAGATE);
>=20
> //    err =3D rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
> LPL_PWM_PRECON_IRQ_NUMBER, 0);
>=20
>     LPL_DEBUG("create real-time interrupt", err, %d);=20
>=20
>     err =3D rt_task_create(&m_serverDescriptor,"PWM_PRECON_IRQ_SERVER",
> LPL_PWM_PRECON_TASK_STKSZ,=20
>=20
>                          LPL_PWM_PRECON_TASK_PRIO,
> LPL_PWM_PRECON_TASK_MODE);
>=20
>     LPL_DEBUG("create real-time task", err, %d);=20
>=20
>     if (!err)=20
>=20
>     {
>=20
>         rt_task_start(&m_serverDescriptor, &lpl_pwm_precon_irq_server,
> NULL);
>=20
>         LPL_DEBUG("start real-time task", err, %d);
>=20
>         rt_intr_enable(&m_interruptDescriptor);=20
>=20
>         LPL_DEBUG("enable real-time interrupt", err, %d);
>=20
>     }
>=20
> =20
>=20
>     signal(SIGTERM, cleanup);
>=20
>     signal(SIGINT, cleanup);
>=20
> =20
>=20
>     pause();
>=20
> =20
>=20
>     fflush(NULL);
>=20
> }
>=20
> =20
>=20
> =20
>=20
> void cleanup(int sig)
>=20
> {
>=20
>     int err =3D 0;
>=20
> =20
>=20
>     rt_intr_disable(&m_interruptDescriptor);=20
>=20
>     LPL_DEBUG("disable real-time interrupt", err, %d);=20
>=20
>     rt_intr_delete(&m_interruptDescriptor);
>=20
>     LPL_DEBUG("delete real-time interrupt", err, %d);=20
>=20
>     rt_task_delete(&m_serverDescriptor);
>=20
>     LPL_DEBUG("delete real-time task", err, %d);=20
>=20
> }
>=20
> =20
>=20
> =20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



