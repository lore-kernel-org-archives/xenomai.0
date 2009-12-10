Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Dec 2009 10:36:22 +0100
Message-ID: <EA8B423DB69FD24FA233008019A052AE016689FC@zue-s-15.zue.zwick.de>
From: "Soboljew, Patrick" <Patrick.Soboljew@domain.hid>
Subject: [Xenomai-help] Problem with gettimeofday
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


Hello all,

I have a problem concering the system time in xenomai 2.4.9.1 kernel
2.6.30. The framework I use calls gettimeofday() to get the absolute
system time which is then passed to pthread_cond_timedwait. The problem
is that when I add for example 1ms wait time the pthread_cond_timedwait
waits much longer. I've checked /proc/xenomai/sched and I can see that
the timeout is far too large. So I wrote a small test program to isolate
the problem. I compared the results (only the seconds which is enough to
show the problem) and there is a huge difference.

On my system (Intel Core2, 1,6 GHz) the output of the test program shows
the following output:
Time1: 1260437136
Time2: 1145908535

The curious thing is: I have a vmware image with a xenomai kernel (same
version). The problem cannot be reproduced here.=20

Anybody an idea?

Thanks for your help,
Patrick Soboljew



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Example Code begin =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#include <pthread.h>
#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>

void SetupRtThread()
{
    int RetVal =3D 0;
    struct sched_param SParam;
    SParam.sched_priority =3D 1;
    int Policy =3D SCHED_FIFO;
    if ((RetVal =3D pthread_setschedparam(pthread_self(), Policy,
&SParam)) !=3D 0)
    {
        printf("pthread_setschedparam: %s", strerror(RetVal));
        exit(RetVal);
    }
}


int main (int /*argc*/, char** /*argv[]*/)
{
    mlockall(MCL_CURRENT | MCL_FUTURE);
    SetupRtThread();

    printf("1\n");

    timeval Time1;
    if (gettimeofday(&Time1,0) !=3D 0)
    {
        fprintf(stderr, "Error gettimeofday\n");
        return -1;
    }

    timespec Time2;
    if (clock_gettime(CLOCK_REALTIME, &Time2) !=3D 0)
    {
        fprintf(stderr, "Error clock_gettime");
        return -1;
    }
    printf("Time1: %ld\n", Time1.tv_sec);
    printf("Time2: %ld\n", Time2.tv_sec);

    return 0;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Example Code end =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

