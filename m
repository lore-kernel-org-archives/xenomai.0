Date: Fri, 12 May 2006 17:24:56 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20060512172456.555caf51@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary=Multipart_Fri__12_May_2006_17_24_56_+0200_5Mrwxo00f0bShb3q
Subject: [Xenomai-help] starnge latencies with native
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--Multipart_Fri__12_May_2006_17_24_56_+0200_5Mrwxo00f0bShb3q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I'm doing some tests with the native skins. The attached program uses
an alarm to trigger a periodic task and measures the sampling latency. 

Initial latencies are in the range of tens of millisecs. and then
decrease slowly to the range of microsecs:

rt_timer_set_mode(TM_ONESHOT) started 
alarm started with period 1000000000 ns 
increment 1124642266 absjitter 124642266  
increment 937743828 absjitter 62256172  
increment 1031095424 absjitter 31095424  
increment 984466651 absjitter 15533349  
increment 1007758686 absjitter 7758686  
increment 996126407 absjitter 3873593  
increment 1001934707 absjitter 1934707  
increment 999039749 absjitter 960251  
increment 1000477139 absjitter 477139  
increment 999759707 absjitter 240293  
increment 1000119631 absjitter 119631  
increment 999938964 absjitter 61036  
increment 1000029816 absjitter 29816  
increment 999985508 absjitter 14492  
increment 1000004750 absjitter 4750  
increment 999998882 absjitter 1118  
increment 1000000946 absjitter 946  
increment 999998780 absjitter 1220  
increment 1000001951 absjitter 1951  
increment 999999514 absjitter 486  
increment 999998746 absjitter 1254  
[...]

 What may be wrong? 

I observe the same behaviour if the periodic sampling is given by a
rt_periodic task or by a rt_sleep_until in the clock loop...

	Daniel

-- 
      Daniel SIMON    Projet POP ART  INRIA Rhone-Alpes
ZIRST, 655 avenue de l'Europe, 38330 MONTBONNOT SAINT MARTIN, FRANCE 
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
	 http://pop-art.inrialpes.fr/people/simon/



--Multipart_Fri__12_May_2006_17_24_56_+0200_5Mrwxo00f0bShb3q
Content-Type: text/x-csrc; name=orcalarm.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=orcalarm.c

//#include "orcnative.h"
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/time.h>
#include <sys/io.h>
#include <sys/mman.h>
#include <native/types.h>
#include <native/task.h>
#include <native/queue.h>
#include <native/intr.h>
#include <native/timer.h>
#include <native/sem.h>
#include <native/alarm.h>
#include <native/heap.h>
#include <native/queue.h>
#include <native/syscall.h>
#define STACK_SIZE 8192
#define MIN_PRIO 1
#define MAX_PRIO 99

typedef void * (*FUNCPTR) (void *);
typedef void * (*SOSO) (void *); /**< Special type to be used for casting in pthread_create() */
//                     --s-ms-us-ns
RTIME task_period_ns = 1000000000llu;
#define NSEC_PER_SEC 1000000000
#define NBCLKS 3
#define BASECLK 0.001 //seconds !!!

#define OK 0
#define ERROR -1
#define STATUS int

#define FALSE 0
#define TRUE 1
#define POLICY 1

static int ji = 0;
//static int togparport = 0;
static RTIME startime, now, inittime, nexttime;
static long long hjitter, jinc, max, moy, drift, jitter;
struct timespec clock_resolution;

RT_SEM mainSem;
RT_SEM handSem;
RT_ALARM BaseClk;
int status, err, end = 0;
//pthread_t * tid;
char *dummy;
RT_TASK thr_clockit;


///Function that returns the cpu time in nanoseconds
inline long long GetCpuTime(void)
{
    return (long long)rt_timer_read();
}

// Trap Ctrl C Interruption
void clean_exit(int dummy)
{
    printf("Ctrl C Interrupt\n");
/*     printf("rt_sem_v(mainSem); \n"); */
/*     rt_sem_v(&mainSem); */
    end = 1;
    err = rt_task_join(&thr_clockit);
    if (err != 0)printf("rt_task_join() error %d \n", err);

    printf("deleting rt devices \n");
    rt_alarm_delete(&BaseClk);
    rt_task_delete(&thr_clockit);
    //rt_sem_delete(&mainSem);
    return ;
}

int orcTimerSigMask(void)
{
    sigset_t set;
    sigfillset(&set);
    if ((err = pthread_sigmask(SIG_BLOCK, &set, NULL)) != OK)
    {
        printf("pthread_sigmask Failed %d \n", err);
        return ERROR;
    }
    sigemptyset(&set);
    sigaddset(&set, SIGINT);
    sigaddset(&set, SIGTERM);
    if ((err = pthread_sigmask(SIG_UNBLOCK, &set, NULL)) != OK)
    {
        printf("pthread_sigmask Failed %d \n", err);
        return ERROR;
    }

    return OK;
}

void setTimer(void)
{
    /***starting timer ***/
    err = rt_timer_set_mode(TM_ONESHOT);
    if (err != 0)perror("rt_timer_set_mode()");
    else printf("rt_timer_set_mode(TM_ONESHOT) started \n");
    err = rt_alarm_create(&BaseClk, "BaseClock");
    if (err != 0)printf("rt_alarm_create() error %d \n", err);
    err = rt_alarm_start(&BaseClk,
                         task_period_ns,
                         task_period_ns);
    if (err != 0)printf("rt_alarm_start() error %d \n", err);

    else printf("alarm started with period %llu ns \n", task_period_ns);
    return ;

}

void clock_it(void *cookie)
{
  int ret;
    while (!end)
    {
        ret = rt_task_set_mode(0, T_PRIMARY, NULL);
        if (ret)
        {
            printf("error while rt_task_set_mode, code %d\n", ret);
            return ;
        }
/* #ifdef DEBUG */
/*         printf("before alarm_wait \n"); */
/* #endif */
        err = rt_alarm_wait(&BaseClk);
        now = GetCpuTime();
/* #ifdef DEBUG */
/*         printf("clock_it loop\n"); */
/* #endif */
        if (ji == 0)
        {
            max = moy = drift = 0;
            startime = now;
            ji++;
        }
        else if (ji == 1)
        {
            ji++;startime = now;
        }
        else
        {
            jinc = (long long)(now - startime);
            jitter = (jinc - (long long)task_period_ns );
            drift += jitter;
            hjitter = abs(jitter);
            moy += hjitter;
            ji++;
            if (hjitter > max) max = hjitter;
#ifdef DEBUG
            printf("increment %ld absjitter %ld  \n", (long)jinc, (long) hjitter);
#endif
            startime = now;
        }
    }
    printf ("jittermoy = %ld, jittermax = %ld \n", (long)moy / ji, (long)max);
    return ;
}

int main(void)
{

    orcTimerSigMask();

    mlockall(MCL_CURRENT | MCL_FUTURE);

    signal(SIGTERM, clean_exit);
    signal(SIGINT, clean_exit);

    setTimer();

    err = rt_task_spawn(&thr_clockit,
                        "MyAlarmServer",
                        0,
                        MAX_PRIO,
                        T_FPU|T_JOINABLE,
                        &clock_it,
                        NULL);

    if (err != 0) printf("rt_task_spawn error %d \n", err);

/*     err = rt_sem_create(&mainSem, "MainSem", 0, S_FIFO); */
/*     if (err != 0) printf("rt_sem_create error %d \n", err); */

/*     err = rt_sem_p(&mainSem, TM_INFINITE); */
/*     if (err != 0) printf("rt_sem_p error %d \n", err); */


    pause();
    fflush(NULL);

    return 0;
}




--Multipart_Fri__12_May_2006_17_24_56_+0200_5Mrwxo00f0bShb3q--

