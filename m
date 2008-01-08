Message-ID: <24653876.1199792394399.JavaMail.ngmail@domain.hid>
Date: Tue, 8 Jan 2008 12:39:54 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <2ff1a98a0801080223l4c975df8qbc64c164b9697454@domain.hid>
	<14854214.1199776626079.JavaMail.ngmail@domain.hid>
Subject: Re: [Xenomai-help] posix functions for real time and non real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

Hi Gilles,

thank you very much for the response.
I tried this out and found one strange thing:
When I run the following simple example (that uses the __real_pthread_ func=
tions)
the executable appears in the /proc/xenomai/stat list.
As I am calling __real_pthread_create() I expected that my program does not=
 appear
in xenomai at all.
Build is done using xeno-config --posix-cflags plus -O2 -Wall. For linking =
xeno-config --posix-ldflags=20
is used.

Another question:
Is there a special header file available that has some defines to map the p=
thread_xxx
function to __real_pthread_xxx.
By including this header I do not have to modify the C code of that files t=
hat should
use the non real-time functions.

Thanks for any response on that.

Regards

Mathias

-------------- BEGIN OF CODE ---------------
#include <stdio.h>
#include <sys/mman.h>
#include <pthread.h>

#define USE_REAL
pthread_t thread;

void *mytaska(void *cookie)
{
    int i;
    for (i=3D0; i < 5; i++)
    {
        struct timespec rqtp;
        printf("Task A\n");
        rqtp.tv_sec =3D 1;
        rqtp.tv_nsec =3D 0;
#ifdef USE_REAL
        __real_nanosleep(&rqtp, 0);
#else
        nanosleep(&rqtp, 0);
#endif
    }
    return 0;
}

int main(void)
{
    int i;
    mlockall(MCL_CURRENT|MCL_FUTURE);
    printf("pid: %i\n", getpid());
#ifdef USE_REAL
    __real_pthread_create(&thread, NULL, mytaska, NULL);
#else
    pthread_create(&thread, NULL, mytaska, NULL);
#endif
    for (i=3D0; i<3; i++)
    {
        struct timespec rqtp;
        printf("Main\n");
        rqtp.tv_sec =3D 1;
        rqtp.tv_nsec =3D 0;
#ifdef USE_REAL
        __real_nanosleep(&rqtp, 0);
#else
        __nanosleep(&rqtp, 0);
#endif
    }
    pthread_join(thread, NULL);
    printf("Main: A joined\n");
    return 0;
}
------------- END OF CODE ----------


> On Jan 8, 2008 8:17 AM, M. Koehrer <mathias_koehrer@domain.hid> wrote:
> > Hi everybody,
> >
> > I have a fairly huge application that consists of several real time
> threads and several non real time (posix) threads.
> > For the non real time threads I use the pthread_create function and e.g=
.
> the pthread_mutex_lock/unlock functions to
> > synchronize them.
> > Is it possible to use the Xenomai Posix skin for real time threads as
> well?
> > When linking against pthread_rt and pthread I have two "variants" of e.=
g.
> pthread_create. One to be used for real
> > time threads and one for the non real time threads. How are they
> distinguished?
> > How can I define to create a real time task using pthread_create and ho=
w
> can I define to create a non real time task
> > using pthread_create.
>=20
> In fact, linking agains pthread_rt is not enough to use Xenomai posix
> skin real-time services, in order to get the real-time pthread_create,
> you have to add to the link flags of your application
> -Wl,--wrap,pthread_create. Note that you do not have to pass the
> --wrap yourself, xeno-config --posix-ldflags will pass all the --wrap
> flags.
>=20
> Once you pass the -Wl,--wrap,pthread_create to gcc, all calls to
> pthread_create in your code are replaced with calls to
> __wrap_pthread_create, and all calls to __real_pthread_create are
> replaced with calss to the original, non wrapped, pthread_create.
>=20
> So, when an application is compiled for Xenomai posix skin, the
> pthread_* services are the real-time services, and the
> __real_pthread_* services are non real-time services.
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT F=DCR ALLE NEUEINSTEIGER
Jetzt bei Arcor: g=FCnstig und schnell mit DSL - das All-Inclusive-Paket
f=FCr clevere Doppel-Sparer, nur  29,95 Euro  inkl. DSL- und ISDN-Grundgeb=
=FChr!
http://www.arcor.de/rd/emf-dsl-2

