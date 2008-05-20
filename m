Message-ID: <5481.62.39.72.60.1211293804.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid> 
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid> 
	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid> 
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
Date: Tue, 20 May 2008 16:30:04 +0200 (CEST)
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

Thank you,

I tried to use rt_fprintf(stderr) or rt_printf(), but there is no debug
traces on my Screen. But when I used fprintf(stderr) or printf(), there i=
s
no problem, I ve got traces on my screen.
Compilation is good, I don't know why it doesn't work.

I also checked the info->si_value.sival_ptr value and it is good.

My StackWrite and StackRead functions don't need a mutex. There is no
conflict between them.

Otherwise, I decided to cancel the lock use in EndTimeOut and I use a
semaphore to indicate the time-out end to TimeOut thread. But there is a
bug.
This test program explains it :
When TimeOut thread starts a time-out and waits the associated semaphore
(sem_wait()). When signal of time-out end arrives, TimeOut thread wakes u=
p
whereas there is no sem_post(), and sem_wait returns no error.


/************************************************************************=
/

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

    pthread_mutex_lock(&start_thread_lock);

    printf("Start of timeOut\n");
    StartTimeOut(1,500000000);

    printf("Wait of timeOut end\n");
    if ((sem_wait(&TimeOut_sem)) < 0)
    {
        printf("sem_wait error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    printf("End of timeOut thread\n");

    pthread_mutex_unlock(&start_thread_lock);

    while(1)
    {
        sleep(10);
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
    pthread_mutex_unlock(&start_thread_lock);

    while (1) {
        sleep(5);
    }

    return 0;
}


/************************************************************************=
************/

Result on the screen :

Start of timeOut
Wait of timeOut end
End of timeOut thread



The use of a semphore doesn't change my problem, I always have system cra=
sh.




