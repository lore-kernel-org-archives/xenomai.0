Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Feb 2009 07:19:45 +0100
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D80308F248@domain.hid>
In-Reply-To: <49957D23.4040806@domain.hid>
References: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
	<499572C2.3060609@domain.hid> <49957D23.4040806@domain.hid>
From: <thomas.debes@domain.hid>
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

I modified the trivial periodic example. That raises the exception only =
when I comment in the printf in demo(...). Basically I want to get =
notified if a floating point exception occurs. We have an automatic code =
generator which generates protection code for underflow, overflow and =
division by zero. This adds a lot of overhead to each application (which =
are very math centric) and suppresses any error. By leaving this code =
out we want to enable FPE's (only in debug mode) and give the users the =
ability to test their algorithms against arithmetic exceptions.


#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fenv.h>
#include <native/task.h>
#include <native/timer.h>

RT_TASK demo_task;
double z;

/* NOTE: error handling omitted. */

void demo(void *arg)
{
	RTIME now, previous;
	rt_task_set_periodic(NULL, TM_NOW, 1000000000);
	previous =3D rt_timer_read();

        double a =3D 23.0;

        z =3D 0;
        a /=3D z;

	while (1) {
		rt_task_wait_period(NULL);
		now =3D rt_timer_read();
		/*printf("Time since last turn: %ld.%06ld ms\n",
		       (long)(now - previous) / 1000000,
		       (long)(now - previous) % 1000000);*/
		       previous =3D now;
	}
}

void catch_signal(int sig)
{
}

int main(int argc, char* argv[])
{
      fesetenv(FE_ENABLED_ENV);

	signal(SIGTERM, catch_signal);
	signal(SIGINT, catch_signal);
	mlockall(MCL_CURRENT|MCL_FUTURE);
	rt_task_create(&demo_task, "trivial", 0, 99, 0);
	rt_task_start(&demo_task, &demo, NULL);
	pause();
	rt_task_delete(&demo_task);
}

Thanks
Thomas

-----Urspr=FCngliche Nachricht-----
Von: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Gesendet: Freitag, 13. Februar 2009 15:01
An: Debes, Thomas RAEK3 MRA
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks

Gilles Chanteperdrix wrote:
> thomas.debes@domain.hid wrote:
>> Hi,
>>
>> I successfully managed to enable FP Exceptions on our MPC5200 board =
for
>> plain linux applications (via fesetenv). When I put the same trigger
>> code (DivByZero) into a (native) RT task no exception is triggered =
until
>> I force a mode switch to secondary mode (e.g. printf). How can I get
>> them without performing the mode switch?
>=20
> An FPU exception triggers a signal, and signal can only be sent to a
> task running in secondary mode. So, even if we managed to get the =
signal
> to be sent to the task immediately, it would cause it to switch to
> secondary mode. Is it really what you want?

Actually, this should not happen. Could you send us a test program?

--=20
                                                 Gilles.

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

