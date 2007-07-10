Message-ID: <22554361.1184054457326.JavaMail.ngmail@domain.hid>
Date: Tue, 10 Jul 2007 10:00:57 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Sporadic PC freeze after rt_task_start
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi everybody,

I noticed a sporadic freeze of my PC using Xenomai 2.3.1 and kernel 2.6.20.=
4 on a Pentium D.
adeos-ipipe-2.6.20-i386-1.8-01.patch.

The freeze happened sporadically on one of our systems, occasionally it too=
k up to 6 hours  to get it.
Using a PCI Post Code board and writing POST codes to it, I was able to loc=
ate the code that was causing
the issue. And finally I was able to extract it to a very simple program th=
at shows the same behaviour!!

Here is my simple test program:
**************************************** BEGIN *****************
#include <stdio.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/sem.h>


RT_TASK taska_desc;

void mytaska(void *cookie)
{
    int i;

    for (i=3D0; i < 5; i++)
    {
        rt_task_sleep(5000000);
    }
}

int main(void)
{
    int i;
    int j;
    mlockall(MCL_CURRENT|MCL_FUTURE);

    for (j=3D0; j < 100; j++)
        for (i=3D10; i < 15000; i++)
        {
            rt_task_create(&taska_desc, "mytaska", 0, 81, T_JOINABLE | T_FP=
U | T_CPU(1));
            rt_task_start(&taska_desc, &mytaska, NULL);
            usleep(1500);

            rt_task_join(&taska_desc);
            if ( i % 100 =3D=3D 0)
                printf("Loop %i\n", i);
        }

    return 0;
}
*************************************** END *******************************=
****
It is important to know, that I started the kernel with isolcpus=3D1, i.e. =
all non-realtime tasks
are running on CPU 0.
Somehow it seems to have to do with the usleep() that is following the rt_t=
ask_start.
usleep() is executed on CPU 0 and rt_task_start starts a task on CPU 1...
Can this be as the begin of usleep() is executed before the task is started=
 but the end of
usleep() is when the task has already started. Could this be a cause for a =
race condition?

I leave the program running for a while and somehow it freezes the PC (only=
 reset works).

Any feedback on this is welcome!

Regards

Mathias






--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  39,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

