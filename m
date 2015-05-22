From: "Mann, Anthony M" <Anthony.Mann@Honeywell.com>
Date: Fri, 22 May 2015 15:18:44 +0000
Message-ID: <2769EB0871C23A4C8DB00D1218015E8E1B0D0791@de08ex3008.global.ds.honeywell.com>
References: <2769EB0871C23A4C8DB00D1218015E8E1B0CE61F@de08ex3008.global.ds.honeywell.com>
In-Reply-To: <2769EB0871C23A4C8DB00D1218015E8E1B0CE61F@de08ex3008.global.ds.honeywell.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Thread not receiving signal
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,
I am trying to get the thread (timing) to wait for the signal (SIGRTMIN).  =
 It is not receiving the signal.  When sigwait is moved to the main thread,=
 the signal is received.  The program uses POSIX wrappers.

How can I get the timing thread to receive the signal?

Also, in an article, it stated "any application linking against libcobalt h=
as its main thread attached to the real-time system automatically".  When a=
 thread is created from the main, will that thread be in the primary or sec=
ondary mode?

Below is an example of the program.

The system is setup with:
Ubuntu 14.04 LTS
vanilla kernel linux 3.14.33
ipipe-core-3.14.33-x86-8.patch
xenomai-3.0-rc4
Build args: --with-core=3Dcobalt --enable-smp --enable-pshared
            --host=3Dx86_64-linux host_alias=3Dx86_64-linux

Thanks for your help with my previous signal issue.

Tony


-------------------------------------------------
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
char    *bs30_path =3D "/bsem30";  /* main */
int bsfd30;
sem_t   *main_semaphore;

int status=3D0;

/*      Thread Entries       */
extern  void timing();

int gfos;

/*       Thread functions    */
#include "thrds2.c"


/* Routine that is called when timer expires */
 void timer_intr(int sig, siginfo_t *extra, void *cruft) {
    int value=3D0;
    sem_post(timing_semaphore);

    if (sem_getvalue(timing_semaphore,&value) < 0)
        printf("Error with sem getvalue\n"); }

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

    /* create mask */
    if (sigemptyset(&allsigs) < 0)
                printf("sigemptyset error\n");
			=09
	sigaddset(&allsigs, SIGRTMIN);
=09
    /*     Create the threads       */
    add_thread("timing",timing);

    /*      Thread start       */
    if (start_thrd("timing"))
    {
        printf("Cannot start Timing Thread!");
        exit(0);
    }

    /*      Setup main & Thread Priorities        */
    schedule_parameter.sched_priority =3D 17;
    if(pthread_setschedparam(tidp0, SCHED_FIFO,
                                       &schedule_parameter) =3D=3D -1) {
        printf("Error setting scheduler policy.  Program Terminated");
        perror(" Scheduler problem");
        exit(-1);
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

    /* Main loop */
    while (1) {
        if (sem_wait(main_semaphore) =3D=3D -1)=20
		{
			perror("main semaphore error:: ");
			exit(0);
		}
	=09
		***
	}
}

        if(fexit_mon =3D=3D 1) {
            printf("\nPROGRAM TERMINATION COMMENSING!!!\n");
			***
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
	int sig;


    change_priority("timing",45);

	while (1)
	{
    /*   Wait for SIGRTMIN */
		if ((sigwait(&sigm, &sig) > ))
		{
			pritnf("Sigwait error\n");
			perror("sigwait: ");
		}

				***
		}
	}
}

