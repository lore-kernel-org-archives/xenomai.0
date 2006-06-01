Message-ID: <447EB4A8.5090809@domain.hid>
Date: Thu, 01 Jun 2006 11:34:32 +0200
From: Lionel Perrin <perrin@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to make main sleep ? clock_nanosleep
	?	rt_alarm_wait ?
References: <447E9A1B.10507@domain.hid>
	<17534.43220.103310.355438@domain.hid>
In-Reply-To: <17534.43220.103310.355438@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Thanks for your answer. That's really great to have support so quickly. :)
>  > I got some difficulties to use either rt_alarm_wait or clock_nanosleep.
>  > It seems i haven't understood what's a "context that can sleep".
>  > 
>  > First of all, what do we need to use clock_nanosleep ?
>  > Is it impossible to use this function in the main thread ?
>
> Xenomai clock_nanosleep, nanosleep or rt_alarm_wait services are
> reserved to Xenomai real-time threads, and will return an error of EPERM
> otherwise.
>   
Ok. So the thread "main" is not a Xenomai real-time,  right ?

> If you want to obtain a Xenomai real-time thread using the posix skin
> you have to make it use the SCHED_FIFO policy, either by creating it
> with the pthread_create service, specifying non null creation attributes
> or by changing the scheduling policy of an existing thread with
> the pthread_setschedparam service.
>   
Is it possible to apply those methods to the thread "main" ?
> If you want to obtain a Xenomai real-time thread using the native skin,
> you may create it with the rt_task_create service or turn an existing
> thread into a real-time thread with the rt_task_shadow service.
>
>  > (...)
>  >     ret = nanosleep(&tp, &rmtp);
>  >     switch (errno) {
>  > (...)
>
> errno value is only meaningful if nanosleep returns -1. In particular it
> is not garanteed to be zero if nanosleep did not fail.
>   
Mmm... Copy-Paste mistake.

There's still my sched_setscheduler enigma.
Why the following program need the commented line to run perfectly, and 
why nanosleep failed without those lines  ?

#include <time.h>
#include <stdio.h>
#include <errno.h>
#include <pthread.h>

#define NANOCOEF 0.000000001

double getfloattime(const struct timespec *tp){
    return tp->tv_sec + tp->tv_nsec * NANOCOEF;
}

int setfloattime(struct timespec *tp, double val) {
    tp->tv_sec = (time_t)val;
    tp->tv_nsec = (long) ( ( val - (double)(tp->tv_sec) ) / NANOCOEF );
    return 0;
}

void * task(void * p)
{
    struct timespec tp, rmtp;
    int ret;
   
    clock_gettime( CLOCK_REALTIME, &tp);
    printf("start time : %lf\n", getfloattime( &tp ));
    setfloattime(&tp, 1.0);
    ret = nanosleep(&tp, &rmtp);
    if(ret)
    {
        switch (errno) {
            case 0:       printf("clock_nanosleep ok\n");
            break;
            case EPERM:   printf("the caller context is invalid\n");
            return NULL;
            case ENOTSUP: printf("the specified clock is unsupported\n");
            return NULL;
            case EINVAL:  printf("the specified wakeup time is invalid\n");
            return NULL;
            case EINTR:   printf("this service was interrupted by a 
signal\n");
            return NULL;
        }
    }
    else
    {
        printf("nanosleep OK\n");
    }
    clock_gettime( CLOCK_REALTIME, &tp);
    printf("stop time : %lf\n", getfloattime( &tp ));
    return NULL;
}

int main(int argc, char *argv[])
{
    pthread_t th;
    pthread_attr_t th_attr;
    struct sched_param mysched;
    /*   
    mysched.sched_priority = sched_get_priority_max(SCHED_FIFO) - 1;
    if( sched_setscheduler( 0, SCHED_FIFO, &mysched ) == -1 ) {
        perror("sched_setscheduler");
}*/
   
    if(pthread_attr_init(&th_attr))
        perror("pthead_attr_init");
   
    if (pthread_attr_setschedpolicy(&th_attr, SCHED_FIFO))
        perror("pthread_attr_setschedpolicy");
   
    if (pthread_create(&th, &th_attr, task, NULL))
        perror("pthread_create");;
   
    if(pthread_join(th, NULL))
        perror("pthread_join");

    return 0;
}

