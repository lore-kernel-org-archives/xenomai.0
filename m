Message-ID: <45435.172.20.62.191.1257358048.squirrel@domain.hid>
Date: Wed, 4 Nov 2009 19:07:28 +0100 (CET)
From: =?utf-8?B?UnViw6luIEdvbnrDoWxleiBkZWwgUG96bw==?= <rubengp@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20091104190728_77288"
Subject: [Xenomai-core] Error in pthread_make_periodic_np
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_20091104190728_77288
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello all,
I am working with Xenomai 2.4.9.1 on Kernel 2.6.30. I try to test the
pperiodic example and I always get the error code 3 in
pthread_make_periodic_np function: ESRCH -> invalid thread.
Why I get that code?
Thanks a lot,

--=20
Rub=C3=A9n Gonz=C3=A1lez del Pozo
University of Salamanca
rubengp@domain.hid
------=_20091104190728_77288
Content-Type: text/x-csrc; name="pperiodic.c"
Content-Disposition: attachment; filename="pperiodic.c"
Content-Transfer-Encoding: quoted-printable

#include <stdio.h>
#include <posix/pthread.h>
#include <posix/errno.h>
#include <signal.h>
#include <sys/mman.h>

#include <rtdk.h>

static int count;
static int goon =3D 1;

static pthread_t id_low;
static pthread_t id_high;

#define LOW_PRIO 5
#define HIGH_PRIO 10

#undef WITH_PRINTF
#undef WITH_SIGXCPU

void init_task(int prio);

void* low_prio_task(void* dummy)
{
    struct sched_param  param;
    int policy;

    pthread_getschedparam(pthread_self(), &policy, &param);
    rt_printf("%s: policy=3D%d prio=3D%d\n",
           __FUNCTION__, policy, param.sched_priority);

    param.sched_priority =3D LOW_PRIO;
    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

    while(goon)
    {
#ifdef WITH_PRINTF
        pthread_set_mode_np(0, PTHREAD_PRIMARY);
        rt_printf("%s %d\n", __FUNCTION__, count);
#endif
        count++;
    }
    rt_printf("Exiting %s, count=3D%d\n", __FUNCTION__, count);

    return 0;
}

void* high_prio_task(void* dummy)
{
    struct timespec tstart =3D { .tv_sec =3D 0, .tv_nsec =3D 0};
#ifdef WITH_PRINTF
    struct timespec tperiod =3D { .tv_sec =3D 0, .tv_nsec =3D 10000000 };
#else
    struct timespec tperiod =3D { .tv_sec =3D 0, .tv_nsec =3D 1000000 };
#endif
    unsigned long overruns =3D 0;
    int tick =3D 0, step =3D 0, loop =3D 0, err;
    struct sched_param  param =3D { .sched_priority =3D HIGH_PRIO };

    rt_printf("Starting %s\n", __FUNCTION__);

    pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

#ifdef WITH_SIGXCPU
    pthread_set_mode_np(0, PTHREAD_WARNSW);
#endif
    rt_printf("BEFORE MAKE PERIODIC\n");

    err =3D pthread_make_periodic_np(pthread_self(), &tstart, &tperiod);
    switch(err)
    {
        case ESRCH:
            rt_printf("ERROR make periodic: ESRCH\n");
            break;

        case ETIMEDOUT:
            rt_printf("ERROR make periodic: ETIMEDOUT\n");
            break;

        default:
            rt_printf("ERROR make periodic: another error: %d\n", err);
            break;
    }
    if (err)
        return (void *)err;

    while (1)
    {
        err =3D pthread_wait_np(&overruns);
#if 0
        if (err)
        {
            pthread_kill(id_low, SIGSTOP);
            rt_printf("%s overruns=3D%lu, tick=3D%d, count=3D%d, err=3D%d=
\n",
                       __FUNCTION__, overruns, tick, count, err);
            return 0;
        }
#endif
        if(step =3D=3D 0 && loop > 100)
        {
            loop =3D 0;
            step =3D 1;
            init_task(LOW_PRIO);
        }
        else if(step =3D=3D 1 && loop > 500)
        {
            loop =3D 0;
            step =3D 2;
            //goon =3D 0;
            pthread_kill(id_low, SIGUSR1);
            rt_printf("SIGUSER1 to id_low: count=3D%d, overruns=3D%lu\n",
                      count, overruns);
        }
        else if(step =3D=3D 2 && loop > 500)
        {
            loop =3D 0;
            step =3D 1;
            pthread_kill(id_low, SIGUSR2);
            rt_printf("SIGUSER2 to id_low: count=3D%d, overruns=3D%lu\n",
                      count, overruns);
        }
        tick++;
        loop++;
    }
    rt_printf("Exiting %s\n", __FUNCTION__);

    return 0;
}

void init_task(int prio)
{
    struct sched_param parm;
    pthread_attr_t attr;

    pthread_attr_init(&attr);
    if(prio =3D=3D HIGH_PRIO)
        pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
    else
        pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    parm.sched_priority =3D prio;
    pthread_attr_setschedparam(&attr, &parm);

    if (prio =3D=3D HIGH_PRIO)
    {
        pthread_create(&id_high, &attr, high_prio_task, NULL);
        pthread_set_name_np(id_high,"high_prio");
    }
    else
    {
        pthread_create(&id_low, &attr, low_prio_task, NULL);
        pthread_set_name_np(id_low,"low_prio");
    }
}

void catch_signal(int sig)
{
    rt_printf("Signal %d catched\n", sig);
}

#ifdef WITH_SIGXCPU
void catch_switch(int sig)
{
    void *bt[32];
    int nentries;

    rt_printf("Signal %d catched\n", sig);

        /* Dump a backtrace of the frame which caused the switch to
    secondary mode: */
    nentries =3D backtrace(bt,sizeof(bt) / sizeof(bt[0]));
    backtrace_symbols_fd(bt,nentries,fileno(stdout));
}
#endif

static void suspend_signal_handler(int sig)
{
    sigset_t signal_set;

    rt_printf("suspend signal handler\n");
    sigfillset(&signal_set);
    sigdelset(&signal_set, SIGUSR2);
    sigsuspend(&signal_set);

    return;
}

static void resume_signal_handler(int sig)
{
    rt_printf("resume signal handler\n");
    return;
}


void init_signals(sigset_t *mask)
{
    struct sigaction sigusr1, sigusr2;

    sigemptyset(mask);
    sigaddset(mask, SIGINT);
    sigaddset(mask, SIGTERM);
    sigaddset(mask, SIGHUP);
    sigaddset(mask, SIGALRM);

    pthread_sigmask(SIG_BLOCK, mask, NULL);

   /*
    * Install the signal handlers for suspend/resume.
   */

    sigemptyset (&sigusr1.sa_mask);
    sigusr1.sa_flags =3D 0;
    sigusr1.sa_handler =3D suspend_signal_handler;
    sigaction(SIGUSR1, &sigusr1, NULL);

    sigemptyset (&sigusr2.sa_mask);
    sigusr2.sa_flags =3D 0;
    sigusr2.sa_handler =3D resume_signal_handler;
    sigaction(SIGUSR2, &sigusr2, NULL);

}

int main(int argc, char *argv[])
{
    sigset_t mask;
    int sig;

    mlockall(MCL_CURRENT|MCL_FUTURE);

    rt_print_auto_init(1);

#ifdef WITH_SIGXCPU
    signal(SIGXCPU, catch_switch);
#endif
#if 0
    signal(SIGTERM, catch_signal);
    signal(SIGINT, catch_signal);
    signal(SIGHUP, catch_signal);
#else
    init_signals(&mask);
#endif

    init_task(HIGH_PRIO);


#if 0
    pthread_join(id_high, NULL);
#else
    sigwait(&mask, &sig);
#endif

    rt_printf("Exiting %s\n", __FUNCTION__);
    return 0;
}
------=_20091104190728_77288--



