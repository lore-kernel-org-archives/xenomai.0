Message-ID: <16273.81.252.86.91.1212060383.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid> 
	<15059.81.252.86.91.1211386718.squirrel@domain.hid> 
	<18484.28025.505865.374746@domain.hid> 
	<12142.81.252.86.91.1211467896.squirrel@domain.hid> 
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid> 
	<2405.81.252.86.91.1211549465.squirrel@domain.hid> 
	<2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid> 
	<5871.81.252.86.91.1211789666.squirrel@domain.hid> 
	<18491.29266.196753.611570@domain.hid> 
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
Date: Thu, 29 May 2008 13:26:23 +0200 (CEST)
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

I succeed to reduce my test program.
Now, I ve got two xenomai threads.
threadDisplay (prio : 70) : locks a mutex (conflict_lock mutex) and passe=
s
between Xenomai and Linux domain. (call to sleep())
threadTimeOut (prio : 80) : Starts one timeout of 5ms and tries to lock
the mutex taken by threadDisplay. (Priority Inheritance)

threadTimeOut waits the conflict_lock unlock of threadDisplay. With
priority inheritance, threadTimeOut gives its priority to threadDisplay.
But, threadTimeOut must also do the EndTimeOut() processing. When the
timeout end signal arrives, if threadDisplay is into Linux Domain, the
system crashes.

this my test program :

#########################################################################=
###

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
#include <errno.h>

// Timer
timer_t timer_h;
struct sigaction    sa;
struct sigevent     sig_spec;
struct itimerspec   tmr_setting;
// Thread start
pthread_cond_t  start_signal;
pthread_mutex_t main_start_lock;
bool bMainStart =3D false;
// Conflict mutex
pthread_mutex_t  conflict_lock;

/************************ Check Functions ******************************/
void check(const char *file, int line, const char *service,
                                             int status, int err)
{
    if (status >=3D 0)
        return;

    fprintf(stderr, "%s:%d: %s: %s\n", file, line, service, strerror(err)=
);
    exit(EXIT_FAILURE);
}

#define check_pthread(expr)                \
    ({                                                \
        int _status =3D (expr);                 \
        check(__FILE__, __LINE__, #expr, -_status, _status);        \
    })

#define check_unix(expr) \
    check(__FILE__, __LINE__, #expr, (expr), errno)

/************************ Functions ******************************/
void DeleteTimer(timer_t timer)
{
    if (timer!=3DNULL)
        check_unix(timer_delete(timer));
}

void EndTimeOut (int signo,siginfo_t *info,void*context)
{
}

void StartTimeOut (int nb_Sec, int nb_nSec)
{
    sa.sa_flags =3D SA_SIGINFO;
    sa.sa_sigaction =3D EndTimeOut;

    check_unix(sigaction(SIGRTMIN, &sa, NULL));

    sig_spec.sigev_notify =3D SIGEV_SIGNAL;
    sig_spec.sigev_signo =3D SIGRTMIN;
    sig_spec.sigev_value.sival_ptr =3D NULL;

    check_unix(timer_create(CLOCK_REALTIME, &sig_spec,
                            &timer_h));

    tmr_setting.it_value.tv_sec =3D nb_Sec;
    tmr_setting.it_value.tv_nsec =3D nb_nSec;
    tmr_setting.it_interval.tv_sec =3D 0;
    tmr_setting.it_interval.tv_nsec =3D 0;

    check_unix(timer_settime(timer_h, 0,
                             &tmr_setting,NULL));
}

/************************** Threads ********************************/
void* threadTimeOut(void * arg)
{
    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart)
        check_pthread(pthread_cond_wait(&start_signal, &main_start_lock))=
;
    check_pthread(pthread_mutex_unlock(&main_start_lock));

    printf("threadTimeOut : Start of a timeout\n");
    StartTimeOut(0,500000000);

    // threadTimeOut waits the conflict_lock unlock of threadDisplay
    // With priority inheritance, threadTimeOut gives its priority to
    // threadDisplay. But, threadTimeOut must also do the EndTimeOut()
    // processing. When the timeout end signal arrives, the system crashe=
s.
    check_pthread(pthread_mutex_lock(&conflict_lock));
    printf("threadTimeOut : Hold conflict_lock\n");

    while (1)
    {
        sleep(10);
    }
    return NULL;
}

void* threadDisplay(void * arg) {
    int i=3D0;

    // threadDisplay locks conflict_lock. Like this, when threadTimeOut
    // wants conflict_lock, it must give its priority to threadDisplay.
    check_pthread(pthread_mutex_lock(&conflict_lock));
    printf("threadDisplay : Hold conflict_lock\n");

    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart)
        check_pthread(pthread_cond_wait(&start_signal, &main_start_lock))=
;
    check_pthread(pthread_mutex_unlock(&main_start_lock));
    printf("threadDisplay : start\n");

    check_unix(sleep(10));  // Pass into Linux Domain

    printf("threadDisplay : end\n");

    check_pthread(pthread_mutex_unlock(&conflict_lock));
    while (1)
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
    pthread_t p2;
    struct sched_param sch;

    check_unix(signal(SIGINT, cleanup_upon_sig));
    check_unix(signal(SIGTERM, cleanup_upon_sig));

    check_unix(mlockall(MCL_CURRENT|MCL_FUTURE));

    // mutex and sem initialisation
    check_pthread(pthread_cond_init(&start_signal, NULL));
    check_pthread(pthread_mutex_init(&main_start_lock, NULL));
    check_pthread(pthread_mutexattr_init(&attr_proto));
    check_pthread(pthread_mutexattr_setprotocol(&attr_proto,PTHREAD_PRIO_=
INHERIT));
    check_pthread(pthread_mutex_init(&conflict_lock, &attr_proto));

    check_pthread(pthread_attr_init(&attr));
    check_pthread(pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCH=
ED));
    check_pthread(pthread_attr_setschedpolicy(&attr, SCHED_FIFO));

    // TimeOut thread creation
    sch.sched_priority =3D 80;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p1, &attr, threadTimeOut, NULL));

    // Display thread creation
    sch.sched_priority =3D 70;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p2, &attr, threadDisplay, NULL));

    check_pthread(pthread_attr_destroy(&attr));

    printf("Main condition broadcast\n");
    // Start of all threads
    check_pthread(pthread_mutex_lock(&main_start_lock));
    bMainStart =3D true;
    check_pthread(pthread_cond_broadcast(&start_signal));
    check_pthread(pthread_mutex_unlock(&main_start_lock));

    while (1)
    {
        sleep(5);
    }

    return 0;
}

#########################################################################=
####

result on the console :

threadDisplay : Hold conflict_lock
Main condition broadcast
threadTimeOut : Start of a timeout
threadDisplay : start
			<---- the system crashes


#########################################################################=
####

Error kernel traces :

Xenomai: fatal: removing non-linked element, holder=3Dc7741c84,
qslot=3Dc04fbfc0 at include/xenomai/nucleus/queue.h:728
 CPU  PID    PRI      TIMEOUT  STAT      NAME
>  0  0       -1      0        00500080  ROOT
   0  2830     0      0        00300380  testTimer13_bis
   0  2832    80      0        00300180  testTimer13_bis
   0  2833    70      0        00300380  testTimer13_bis
Master time base: clock=3D59161137551
c043dd60 00000000 00000000 c7741c84 000000b1 c01037d1 c03bcfed c04fbfc0
c04fbfc0 c013f6e1 c03b8f16 c773c000 c04fbfc0 c03b9014 000002d8 00000086
c7741a20 ffffffff 00000002 00000001 c7741220 c04f5884 c0135c49 c043de38
Call Trace:
 [<c01037d1>] show_stack+0x27/0x2b
 [<c013f6e1>] rpi_update+0x166/0x22e
 [<c0135c49>] xnpod_resume_thread+0x119/0x527
 [<c0136160>] xnpod_unblock_thread+0x48/0x79
 [<c01401af>] sigwake_event+0xa1/0x104
 [<c012f475>] __ipipe_dispatch_event+0xb1/0x174
 [<c014010e>] sigwake_event+0x0/0x104
 [<c0118981>] signal_wake_up+0x3f/0x53
 [<c01192f9>] specific_send_sig_info+0x83/0x8e
 [<c011945e>] send_sig_info+0x3f/0x85
 [<c0149b73>] pse51_signal_handle_request+0x6d/0xd9
 [<c012fb9a>] rthal_apc_handler+0x0/0x2d
 [<c014f9bd>] pse51_lostage_handle_request+0x2b/0x53
 [<c012fbbd>] rthal_apc_handler+0x23/0x2d
 [<c012ebc4>] __xirq_end+0x2a/0x37
 [<c012fb9a>] rthal_apc_handler+0x0/0x2d
 [<c012ebd1>] __virq_end+0x0/0xa7
 [<c0130060>] hal_read_proc+0x55/0x6c
 [<c01087ef>] __ipipe_handle_irq+0x11c/0x13c
 [<c010125b>] default_idle+0x27/0x39
 [<c0101234>] default_idle+0x0/0x39
 [<c0102841>] common_interrupt+0x21/0x40
 [<c0101234>] default_idle+0x0/0x39
 [<c010125b>] default_idle+0x27/0x39
 [<c0100b7c>] cpu_idle+0x42/0x6b
 [<c043e9dc>] start_kernel+0x23b/0x240
 [<c043e323>] unknown_bootoption+0x0/0x195
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I hope that my test program is easy to understand and that you also have
the crash.

Thanks




