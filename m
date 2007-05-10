Message-ID: <12120203.1178785866207.JavaMail.ngmail@domain.hid>
Date: Thu, 10 May 2007 10:31:06 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <1178727256.11688.35.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <1178727256.11688.35.camel@domain.hid>
	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Philippe,
>=20
> I'm not sure the cost is as much as 2 us, unless you don't use the
> sysenter/sysexit protocol for syscalls Xenomai manages properly
> (--enable-x86-sep). It seems you are going through the ancient 0x80
> exception vector, but still, I agree that the point remains: no
> contention should mean no transition to kernel.
>=20
I did some measurements to get precise values here.
For this I used the following Xenomai program that accesses a semaphore twi=
ce
within a loop (p followed by v).
---------------------------------
#include <native/task.h>
#include <native/sem.h>

RT_TASK taska_desc;
RT_SEM sem;

void mytaska(void *cookie)
{
    int i;
    RTIME tim1, tim2;
    #define LOOPS 100000

    tim1 =3D rt_timer_read();
    for (i=3D0; i < LOOPS; i++)
    {
        rt_sem_p(&sem, TM_INFINITE);
        rt_sem_v(&sem);
    }
    tim2 =3D rt_timer_read();
    printf("delta is %llu per step: %llu\n",
            tim2-tim1,
            (tim2-tim1)/ LOOPS);
}

int main(void)
{
    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_sem_create(&sem, "mysem", 1 ,0);
    rt_task_create(&taska_desc, "mytaska", 0, 81, T_JOINABLE);
    rt_task_start(&taska_desc, &mytaska, NULL);
    rt_task_join(&taska_desc);
    rt_sem_delete(&sem);
    return 0;
}
-----------------------------
I measured the following runtime:
For configuring Xenomai without any option:  4.8us per step
Configuring Xenomai with --enable-x86-sep: 4.5us per step.

I ran this experiment on a 3.2 GHz Pentium D on a server main board with
E7230 chipset.
Xenomai 2.3.1, kernel 2.6.20.4, SMP
Thus the performance here is not really excellent (as there is no need to d=
o
a task switch.

I agree with all the comments that recommended to improve the design first =
before
trying to improve the OS performance.=20
However, if there is (RT)OS, I expect it to be as fast as possible.
Because, even if I have a "perfect" design, I need the OS - otherwise I wou=
ld just
live without the OS.=20
A better design could help to reduce OS calls but it can not avoid it compl=
etely.
Also, a lock less designs might lead to additional data copies which is als=
o a known=20
performance killer. So I think this is a decision that has to be made on ba=
se of the concrete=20
project. General rules do not help here.

Thanks for all comments!

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

