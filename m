Message-ID: <2026261.1184070574283.JavaMail.ngmail@domain.hid>
Date: Tue, 10 Jul 2007 14:29:34 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <469345EB.6060302@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <469345EB.6060302@domain.hid>
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Jan,

I have compiled and started your test.
It works fine - no error or warning...
The output is:
rt_task_spawn=3D0
sched_setaffinity=3D0
rt_task_delete=3D0

Regards

Mathias

> M. Koehrer wrote:
> > Hi everybody,
> >=20
> > I noticed a sporadic freeze of my PC using Xenomai 2.3.1 and kernel
> 2.6.20.4 on a Pentium D.
> > adeos-ipipe-2.6.20-i386-1.8-01.patch.
> >=20
> > The freeze happened sporadically on one of our systems, occasionally it
> took up to 6 hours  to get it.
> > Using a PCI Post Code board and writing POST codes to it, I was able to
> locate the code that was causing
> > the issue. And finally I was able to extract it to a very simple progra=
m
> that shows the same behaviour!!
> >=20
> > Here is my simple test program:
> > **************************************** BEGIN *****************
> > #include <stdio.h>
> > #include <sys/mman.h>
> >=20
> > #include <native/task.h>
> > #include <native/sem.h>
> >=20
> >=20
> > RT_TASK taska_desc;
> >=20
> > void mytaska(void *cookie)
> > {
> >     int i;
> >=20
> >     for (i=3D0; i < 5; i++)
> >     {
> >         rt_task_sleep(5000000);
> >     }
> > }
> >=20
> > int main(void)
> > {
> >     int i;
> >     int j;
> >     mlockall(MCL_CURRENT|MCL_FUTURE);
> >=20
> >     for (j=3D0; j < 100; j++)
> >         for (i=3D10; i < 15000; i++)
> >         {
> >             rt_task_create(&taska_desc, "mytaska", 0, 81, T_JOINABLE |
> T_FPU | T_CPU(1));
> >             rt_task_start(&taska_desc, &mytaska, NULL);
> >             usleep(1500);
> >=20
> >             rt_task_join(&taska_desc);
> >             if ( i % 100 =3D=3D 0)
> >                 printf("Loop %i\n", i);
> >         }
> >=20
> >     return 0;
> > }
> > *************************************** END
> ***********************************
> > It is important to know, that I started the kernel with isolcpus=3D1, i=
.e.
> all non-realtime tasks
> > are running on CPU 0.
> > Somehow it seems to have to do with the usleep() that is following the
> rt_task_start.
> > usleep() is executed on CPU 0 and rt_task_start starts a task on CPU 1.=
..
> > Can this be as the begin of usleep() is executed before the task is
> started but the end of
> > usleep() is when the task has already started. Could this be a cause fo=
r a
> race condition?
> >=20
> > I leave the program running for a while and somehow it freezes the PC
> (only reset works).
> >=20
> > Any feedback on this is welcome!
>=20
> Maybe you are seeing the same bug like this test exposes:
>=20
> #include <native/task.h>
> #include <sched.h>
> #include <sys/mman.h>
>=20
> void func(void *arg)
> {
> =09rt_task_set_periodic(NULL, TM_NOW, 1000000000LL);
> =09while(1) rt_task_wait_period(NULL);
> }
>=20
> main()
> {
> =09RT_TASK task;
> =09cpu_set_t set;
>=20
> =09mlockall(MCL_CURRENT|MCL_FUTURE);
> =09printf("rt_task_spawn=3D%d\n", rt_task_spawn(&task, "Receiver", 0,
> =09       10, 0, func, NULL));
> =09CPU_ZERO(&set);
> =09CPU_SET(1, &set);
> =09printf("sched_setaffinity=3D%d\n", sched_setaffinity(0,
> =09       sizeof(cpu_set_t), &set));
> =09sleep(1);
> =09printf("rt_task_delete=3D%d\n", rt_task_delete(&task));
> }
>=20
> Though, this test doesn't hard-lock, just stalls the process in some
> zombie state.
>=20
> This bug is already scheduled for closer examination, stay tuned.
>=20
> In the meantime: Is it possible to check if
>  a) my demo code happens to lock up hard for you?
>  b) any behaviour changes with latest xeno-2.3.2/ipipe-1.8-05 and your
>     test case?
>=20
> Thanks for reporting,
> Jan
>=20
>=20
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

