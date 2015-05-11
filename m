From: "Mann, Anthony M" <Anthony.Mann@Honeywell.com>
Date: Mon, 11 May 2015 19:04:05 +0000
Message-ID: <2769EB0871C23A4C8DB00D1218015E8E1B0CE61F@de08ex3008.global.ds.honeywell.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Signal not received
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

The code below uses POSIX and when compiled for a Linux kernel, it
works.  When the code is compiled to use the Cobalt real-time kernel, the
POSIX calls are wrapped (--posix).  Executing the program, the thread,
timer and semaphore work but the signal from the expired timer (SIGRTMIN)
is not delivered but is in the queue.  I had tried to unblock all signals
when the signal was detected in the queue.  That did not work either.

Also, when compiled for the Linux kernel, sigemptyset with sigsuspend
causes the main loop to suspend; however, the POSIX wrappped version,
sigsuspend did not suspend the loop.  Sigprocmask was needed to be call
first, then it suspended.  Since the SIGTRMIN was not received the main
goes no further.  However, when pressing ctrl-c, the SIGINT is received
and calls the kill_handler routine as intented.  Then the main loop
continues.

I am new to Xenomai and any suggestions on why the program is not
receiving the SIGRTMIN signal and how to correct it will be much
appreciated.

The system is setup with:
Ubuntu 14.04 LTS
vanilla kernel linux 3.14.33
ipipe-core-3.14.33-x86-8.patch
xenomai-3.0-rc4
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared
            --host=3Dx86_64-linux host_alias=3Dx86_64-linux

Thanks,

Tony


----------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/types.h>
#include <pthread.h>
#include <semaphore.h>
#include <signal.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <signal.h>
#include <errno.h>

#include "/usr/xenomai/include/cobalt/wrappers.h"

/* This is needed if compiling for linux kernel, remove for Cobalt
#define sigev_notify_thread_id _sigev_un._tid
------------------------------- */

short fexit_t1=3D0, fexit_mon=3D0;

timer_t timer_id;
timer_t * __restrict__ timer_id_rptr;

struct sigaction    act, oact, act1, oact1;
struct tm gmt;

/* Timer variables */
struct sigaction sa;
sigset_t allsigs;
struct itimerspec tmr_setting;


/*  Define threads and attributes
*********************************/
pthread_t tidp0;        /* main */

pthread_t tidp1;        /* timing */
pthread_attr_t attr1;


/*      Semaphores for threads
******************************/
char    *bs30_path =3D "/bsem30";  /* timing */
int bsfd30;
sem_t   *timing_semaphore;

int status=3D0;

/*      Thread Entries       */
extern  void timing();

int gfos;

/*       Thread functions    */
#include "thrds2.c"


/* Routine that is called when timer expires */
void timer_intr(int sig, siginfo_t *extra, void *cruft)
{
    int value=3D0;
    sem_post(timing_semaphore);

    if (sem_getvalue(timing_semaphore,&value) < 0)
        printf("Error with sem getvalue\n");
}

/***********************************************************************/
void kill_handler( int sig)
{
    if (sig =3D=3D SIGCHLD)
    {
                                printf("CHILD Signal captured !!!\n");
    }else{
        printf("%s\n","program killed\n");
        fexit_mon =3D 1;
    }
    printf("fexit mon set in kill handler\n");
    fflush(stdout);
}


int main()
{
                int pid, tc;

                char msg[120];

    /* Timer variables */
    struct sigaction sa;
    struct sigevent sig_spec;
    struct sigevent * __restrict__ sig_spec_rptr;
    sigset_t allsigs;
    struct itimerspec tmr_setting;
    struct itimerspec * __restrict__ tmr_setting_rptr;

    struct itimerspec *tmr_value;

    struct sched_param schedule_parameter;

    /* Testing variables*/
    sigset_t pendingmask;
    union sigval sigvalret;
    /* *********** */

    /*  Setup error handler parameters   */
    act1.sa_handler =3D kill_handler;
    if(sigemptyset(&act1.sa_mask) =3D=3D -1) {
        perror("sigemptyset");
        exit(EXIT_FAILURE);
    }

    act1.sa_flags   =3D 0;
    if(sigaction(SIGINT, &act1, &oact1) =3D=3D -1) {
        perror("sigaction");
        exit(EXIT_FAILURE);
    }

    /*     Create the threads       */
    add_thread("timing",timing);

    /*      Setup main & Thread Priorities        */
    schedule_parameter.sched_priority =3D 17;
    if(pthread_setschedparam(tidp0, SCHED_FIFO,
                                                                           =
                                                                           =
              &schedule_parameter) =3D=3D -1) {
        printf("Error setting scheduler policy.  Program Terminated");
        perror(" Scheduler problem");
        exit(-1);
    }

    /*      Thread start       */
    if (start_thrd("timing"))
    {
        printf("Cannot start Timing Thread!");
        exit(0);
    }

    /* setup signal to respond to timer */
    sigemptyset(&sa.sa_mask);
    sa.sa_flags =3D SA_SIGINFO;
    sa.sa_sigaction =3D timer_intr;

    if ( sigaction(SIGRTMIN, &sa, NULL) < 0 )
    {
        perror("sigaction");
        printf("Timer signal setup failed");
        exit(0);
    }
    sig_spec.sigev_notify =3D SIGEV_THREAD_ID;
    sig_spec.sigev_signo =3D SIGRTMIN;
    sig_spec.sigev_notify_thread_id =3D getpid();
    sig_spec.sigev_value.sival_ptr =3D &timer_id;

    /* create timer, which uses the REALTIME clock */
    timer_id_rptr =3D &timer_id;
    sig_spec_rptr =3D &sig_spec;

   if ((timer_create(CLOCK_REALTIME,sig_spec_rptr,timer_id_rptr)) < 0 )
    {
        perror("timer create");
        printf("Error creating timer\n");
        exit(0);
    }

    tmr_setting.it_value.tv_sec =3D 0;
    tmr_setting.it_value.tv_nsec =3D 50000000;
    tmr_setting.it_interval.tv_sec =3D 0;
    tmr_setting.it_interval.tv_nsec =3D 50000000;

    tmr_setting_rptr =3D &tmr_setting;
    if (timer_settime(timer_id,0,tmr_setting_rptr,NULL) < 0 ) {
                perror("settimer");
        printf("Error setting timer parameters");
        exit(0);
    }
    printf("timer SET\n");
    fflush(stdout);

    /* wait for signals */
    if (sigemptyset(&allsigs) < 0)
                printf("sigemptyset error\n");

    sigprocmask(SIG_BLOCK, &allsigs, NULL);

    /* Main loop */
    while (1) {
        sigsuspend(&allsigs);

                                                /* Testing signal status */
                                if (sigpending(&pendingmask) < 0)
                                                perror("sigpending");
                                if (sigismember(&pendingmask, SIGRTMIN))
                                {
                                                printf("\nSIGRTMIN pending\=
n");
                                /*           sigaddset(&allsigs, SIGRTMIN);
                                                sigprocmask(SIG_UNBLOCK, &a=
llsigs, NULL); */
                                }

                                if (sigqueue(pid, NULL, sigvalret) < 0)
                                                perror("sigqueue error");
                                else
                                                printf("*");

        if(fexit_mon =3D=3D 1) {
            printf("\nPROGRAM TERMINATION COMMENSING!!!\n");
            sleep (5);

                                                fexit_t1 =3D 1;
                                                printf("Killing timing sema=
phore\n");
                                                sem_post(timing_semaphore);

                                                sleep(1);

            if (pthread_join(thrd_id("timing"), (void **)&status) =3D=3D -1=
)
            {
                sprintf(msg,"%s%d","timing thread - pthread_join error, sta=
tus =3D ", status);
                printf("%s\n", msg);
                printf("timing thread - pthread_join error, status =3D %d\n=
",status);
            }

            delete_thrd(thrd_id("timing"));

            if(sem_unlink(bs30_path) =3D=3D -1) {       /* remove bin-semph=
 */
                printf("unlink error for timing semaphore");
                perror("sem_unlink bsem30");
            }
            exit(0);
        }else{
                sched_yield();
       }
    }
                printf("Done.\n");
                exit(0);
}


/*          timing process         */
void timing()
{
    long int   seconds;
    int        fos;  /* fraction of second */
    char       msg[80];


    printf("Timing!!!\n");
    fflush(stdout);

    seconds                    =3D 0;
    fos                        =3D 0;

    change_priority("timing",45);

    /*   Setup Binary Semaphore */
    if((timing_semaphore =3D sem_open(bs30_path, O_CREAT ,0644, 0)) =3D=3D =
-1) {
        if(errno !=3D EEXIST) {
            printf("Error opening timing semaphore");
            perror("timing [30] mksem");
            fexit_mon =3D 1;
            printf("fexit mon set in sem open exist / timing thread\n");
            sched_yield();
        }
    }

    /*   Wait on Signals */
    while (1) {
        /*  Normal signal process */
        if(sem_wait(timing_semaphore) =3D=3D -1) {
                    printf("sem_wait error in timing thread");
            perror("sem_wait 30 perror");
            fexit_mon =3D 1;
            sched_yield();
        }

                                ***
        sched_yield();
    }
}
