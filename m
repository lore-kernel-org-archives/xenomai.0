Message-ID: <447E9A1B.10507@domain.hid>
Date: Thu, 01 Jun 2006 09:41:15 +0200
From: Lionel Perrin <perrin@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] How to make main sleep ? clock_nanosleep ?
	rt_alarm_wait ?
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

I got some difficulties to use either rt_alarm_wait or clock_nanosleep.
It seems i haven't understood what's a "context that can sleep".

First of all, what do we need to use clock_nanosleep ?
Is it impossible to use this function in the main thread ?

I tried this :

#include <stdio.h>
#include <time.h>
#include <errno.h>

#define NANOCOEF 0.000000001

double getfloattime(const struct timespec *tp){
    return tp->tv_sec + tp->tv_nsec * NANOCOEF;
}

int setfloattime(struct timespec *tp, double val) {
    tp->tv_sec = (time_t)val;
    tp->tv_nsec = (long) ( ( val - (double)(tp->tv_sec) ) / NANOCOEF );
    return 0;
}

int main(int argc, char *argv[])
{
    struct timespec tp, rmtp;
    int ret;
   
    clock_gettime( CLOCK_REALTIME, &tp);
    printf("start time : %lf\n", getfloattime( &tp ));
    setfloattime(&tp, 1.0);
    ret = nanosleep(&tp, &rmtp);
    switch (errno) {
        case 0:       printf("clock_nanosleep ok\n");
        break;
        case EPERM:   printf("the caller context is invalid\n");
        return errno;
        case ENOTSUP: printf("the specified clock is unsupported\n");
        return errno;
        case EINVAL:  printf("the specified wakeup time is invalid\n");
        return errno;
        case EINTR:   printf("this service was interrupted by a signal\n");
        return errno;
    }
    clock_gettime( CLOCK_REALTIME, &tp);
    printf("stop time : %lf\n", getfloattime( &tp ));
    return 0;
}

but nanosleep won't work :(

I also tried to put this nanosleep into a thread, to set thread 
scheduling policy to SCHED_FIFO, but that's not better...
I solve my problem puting nanosleep in thread with policy set to 
'SCHED_FIFO' and adding those lines in main:
mysched.sched_priority = sched_get_priority_max(SCHED_FIFO) - 1;
if( sched_setscheduler( 0, SCHED_FIFO, &mysched ) == -1 ) {
    perror("sched_setscheduler");
}
but I don't know why this is correct...

Is it impossible to make the main thread sleep ?

I had the same problem with native API and rt_alarm_wait.

Any help would be usefull.
Thanks

