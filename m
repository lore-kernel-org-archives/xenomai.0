Message-ID: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
Date: Wed, 22 Nov 2006 12:38:54 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] What returns rt_task_self in relation to
	rt_task_create
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

Hi all,

I have a simple question concerning the Xenomai native API:
According to the API documentation, rt_task_self returns the=20
address of the caller's task descriptor.
I have now written the following (simple application):
---------- START ----------
#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>

RT_TASK task_desc;

void mytask(void *cookie)
{
    RT_TASK *tsk =3D rt_task_self();
    printf("rt_task_self  %p\n"
           "task_desc     %p\n", tsk, &task_desc);
}

int main(void)
{
    mlockall(MCL_CURRENT|MCL_FUTURE);

    rt_task_create(&task_desc, "mytaskname", 0, 80, T_JOINABLE);
    rt_task_start(&task_desc, &mytask, NULL);

    rt_task_join(&task_desc);

    return 0;
}
------------ END -----------

I expect now that rt_task_self() returns exactly the address of the task_de=
sc.
However, a different address is returned.=20
The output of the application from above is:
rt_task_self  0x804a050
task_desc     0x8049878

How are those addresses related - how can I find out the descriptor address=
=20
used for rt_task_create() at runtime?

Background of the question:
I want to write an application that uses a couple of similar tasks.
I have to store some task-specific information (internal states...).
Now I am looking for a simple way to get this information at runtime from m=
y task
by calling rt_task_self() (or something similar) to use this address to rea=
ch my
additional information.

Thanks for any idea on this.

Regards

Mathias



--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2

