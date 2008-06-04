Message-ID: <14864600.1212570529651.JavaMail.ngmail@domain.hid>
Date: Wed, 4 Jun 2008 11:08:49 +0200 (CEST)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] RT Application on isolated core
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

Hi!

I am doing some experiments on a Core2Duo CPU and I have some question on i=
t.
My setup is the following:
I have Xenomai 2.3.3 and kernel 2.6.20.4, SMP enabled.
I start the kernel with the option isolcpus=3D1 which works as all linux ta=
sks run on
CPU 0 (i.e. core 0).
Now, I start a very small Xenomai (native skin) application with on real ti=
me task=20
on CPU 1 (core 1).=20
This application realizes an endless loop that does some dummy math operati=
ons=20
(to burn CPU power...).
I am connected remotely to the PC (via telnet, no X available).
When I start the real time application I can work on a second telnet sessio=
n for a while.
However, after a couple of seconds, the PC seems to freeze as I am no longe=
r able=20
to work via telnet. I have to reset the PC to continue.

My question is now: What is happening here? This real time application is t=
he only one to
run on CPU 1, however there still seems to be a dependency to CPU 0.
When I place a rt_task_sleep() within the loop, everything is fine.

Thanks for all ideas on this.

Regards

Mathias

########## Start of Demo Application ################
#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <math.h>

RT_TASK task_desc;

volatile double d;
void mytask(void *cookie)
{
    int i;
    for (i=3D0; i< 10000; i++)
    {
        int j;
        for (j=3D0; j<10000000; j++)
        {
            d =3D d + 1.32 * j * sin(j+123.2 + i * 121.2);
        }
        // Uncomment this to avoid freeze:
        // rt_task_sleep(10000);
    }
}
int main(void)
{
    mlockall(MCL_CURRENT|MCL_FUTURE);
    rt_task_spawn(&task_desc, "mytask", 0, 81, T_JOINABLE | T_FPU | T_CPU(1=
), &mytask, NULL);
    rt_task_join(&task_desc);
    printf("End\n");
    return 0;
}
########## End of Demo Application ################



--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv

