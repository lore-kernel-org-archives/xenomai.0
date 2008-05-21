Message-ID: <2336.81.252.86.91.1211379896.squirrel@domain.hid>
In-Reply-To: <18483.10408.141546.420660@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
Date: Wed, 21 May 2008 16:24:56 +0200 (CEST)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello,

I tried your patch. Now, sem_wait() returns an Interrupt system call erro=
r
when a time-out end signal arrives. That's good.

But, with the same test program, the one which tests sem_wait(), my syste=
m
crashes a while after the same_wait() call. (System freeze --> reboot)
After sem_wait() call, there are a mutex unlock and a sleep calls, but I
can't say if they are a problem with them :
- With mutex unlock call and sleep call: the system crashes between these
calls. (printf() calls)
- If I cancel mutex unlock, the threads sleeps and the system is good.
- If I add a sem_post() in the EndTimeOut handler, sem_wait wakes up the
thread but the system crashes before or over mutex unlock processing.

before your patch, with this program, i had sem_wait problem but no crash
of the system.

#include <sys/mman.h>
#include <pthread.h>
#include <unistd.h>
#include <sys/time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include <time.h>
#include <math.h>
#include <signal.h>
#include <semaphore.h>
#include <errno.h>

// Timer
timer_t timer_h;
struct sigaction    sa;
struct sigevent     sig_spec;
struct itimerspec   tmr_setting;

// Thread start
pthread_mutex_t start_thread_lock;

// Time-out end
sem_t  TimeOut_sem;

/************************ Functions ******************************/
void DeleteTimer(timer_t timer)
{
     if (timer!=3DNULL)
     {
          timer_delete(timer);
     }
}

void EndTimeOut (int signo,siginfo_t *info,void*context)
{
     // no sem_post() !

     //if ((sem_post(&TimeOut_sem)) < 0)
     //{
     //   printf("sem_post error - errno : %d  -> %s\n",errno,
strerror(errno));
     //}
}

void StartTimeOut (int nb_Sec, int nb_nSec)
{
    sa.sa_flags =3D SA_SIGINFO;
    sa.sa_sigaction =3D EndTimeOut;

    if(sigaction(SIGRTMIN, &(sa), NULL)=3D=3D-1)
    {
        printf("sigaction error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    sig_spec.sigev_notify =3D SIGEV_SIGNAL;
    sig_spec.sigev_signo =3D SIGRTMIN;
    sig_spec.sigev_value.sival_ptr =3D NULL;

    if (timer_create(CLOCK_REALTIME, &(sig_spec), &(timer_h)) =3D=3D -1)
    {
        printf("timer_create error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    tmr_setting.it_value.tv_sec =3D nb_Sec;
    tmr_setting.it_value.tv_nsec =3D nb_nSec;
    tmr_setting.it_interval.tv_sec =3D 0;
    tmr_setting.it_interval.tv_nsec =3D 0;

    if (timer_settime(timer_h, 0, &(tmr_setting),NULL) =3D=3D -1)
    {
       printf("timer_settime error - errno : %d  -> %s\n",errno,
strerror(errno));
    }
}

/************************** Threads ********************************/
void* threadTimeOut(void * arg) {

    if ((pthread_mutex_lock(&start_thread_lock)) < 0)
    {
        printf("pthread_mutex_lock error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    printf("Start of timeOut\n");
    StartTimeOut(1,500000000);

    printf("Wait of timeOut end\n");
    while ((sem_wait(&TimeOut_sem)) < 0)
    {
        printf("sem_wait error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    printf("End of timeOut thread\n");

    int err =3D pthread_mutex_unlock(&start_thread_lock);
    /*if ((pthread_mutex_unlock(&start_thread_lock)) < 0)
    {*/
        printf("pthread_mutex_unlock error - err : %d - errno : %d  ->
%s\n", err, errno, strerror(errno));
    //}

    while(1)
    {
        printf("avant sleep\n");
        sleep(10);
        printf("apres sleep\n");
    }
	return NULL;
}

/***********************************************************************/
void cleanup_upon_sig(int sig __attribute__((unused)))
{
     DeleteTimer(timer_h);
     exit(0);
}

int main(int argc, char** argv) {
    pthread_attr_t attr;
    pthread_mutexattr_t attr_proto;
    pthread_t p1;
    struct sched_param sch;

    signal(SIGINT, cleanup_upon_sig);
    signal(SIGTERM, cleanup_upon_sig);

    mlockall(MCL_CURRENT|MCL_FUTURE);

   	// mutex and sem initialisation
    pthread_mutex_init(&start_thread_lock, NULL);
    sem_init (&TimeOut_sem, 0,0);

    pthread_attr_init(&attr);
    pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

    // TimeOut thread creation
    sch.sched_priority =3D 80;
    pthread_attr_setschedparam(&attr, &sch);

    pthread_mutex_lock(&start_thread_lock);
    pthread_create(&p1, &attr, threadTimeOut, NULL);
    pthread_attr_destroy(&attr);
    pthread_mutex_unlock(&start_thread_lock);

    while (1) {
        sleep(5);
    }

    return 0;
}


