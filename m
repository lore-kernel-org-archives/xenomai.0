Message-ID: <913919.1184311634860.JavaMail.ngmail@domain.hid>
Date: Fri, 13 Jul 2007 09:27:14 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <4694ED98.6000000@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <4694ED98.6000000@domain.hid>
	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>
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

I did another test to identify the freeze. I have plugged in a POST-CODE 80=
 PCI board into the PC
and instrumented the code to write to port 80 to find out where the freeze =
actually happens.
It seems not to return for rt_task_start as the last written POST code (see=
 source code below)  is 0x30.
I hope to find a time slot to modify the kernel to do another test.
The bad thing is that it takes really long to get the freeze (up to a coupl=
e of hours).

Regards

Mathias

---------------------------------- BEGIN SOURCE CODE ----------------------=
-
#include <stdio.h>
#include <sys/mman.h>
#include <sys/io.h>

#include <native/task.h>
#include <native/sem.h>


RT_TASK taska_desc;

void mytaska(void *cookie)
{
    int i;

    outb(0x80,0x80);

    for (i=3D0; i < 5; i++)
    {
        rt_task_sleep(5000000);
        outb(0x90,0x80);
        // printf("Task A\n");
    }
    outb(0xa0,0x80);

    // printf("End of task A\n");
}


int main(void)
{
    int i;
    int j;
    ioperm(0x80, 1, 1);
    mlockall(MCL_CURRENT|MCL_FUTURE);

    for (j=3D0; j < 10000; j++)
        for (i=3D10; i < 15000; i++)
        {
            outb(0x20, 0x80);
            rt_task_create(&taska_desc, "mytaska", 0, 81, T_JOINABLE | T_FP=
U | T_CPU(1));
            outb(0x30, 0x80);
            rt_task_start(&taska_desc, &mytaska, NULL);
            outb(0x40, 0x80);
            usleep(1500);
            outb(0x50, 0x80);

            rt_task_join(&taska_desc);
            if ( i % 100 =3D=3D 0)
                printf("Loop %i %i\n", j,  i);
        }


    return 0;
}
--------------------------- END  -----------------

=20
> > Nothing obvious. Leaves us with probable timing differences or the
> > different versions of our setups (I found this over 2.3.2 and trunk).
>=20
> My posted issue is a classic race of self-terminating the native task on
> CPU1 vs. remote-terminating it from CPU0. When the latter wins, things
> fall apart. Some solution needs more thoughts.
>=20
> Anyway, this issues is most probably unrelated to your bug.
>=20
> >=20
> > OK, further analysis on your side would be appreciated. E.g. trying the
> > latest release, switching on debug features in Xenomai like the NMI
> > watchdog or nucleus debugging. Also, nailing down what service call
> > precisely locks up (the join, the termination of the task, etc.) would
> > be good to reduce the search space.
> >=20
>=20
> As you posted in a different mail, recent versions make no difference.
> Could you now switch on the watchdog and nucleus debugging?
>=20
> Thanks,
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

