Date: Tue, 25 Apr 2006 13:43:16 +0200
From: Daniel Simon <Daniel.Simon@domain.hid>
Message-ID: <20060425134316.017836e8@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart_Tue__25_Apr_2006_13_43_16_+0200_LiWXctSKuDvHl0T/"
Subject: [Xenomai-help] Posix skin illegal seek on sem_wait
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

--Multipart_Tue__25_Apr_2006_13_43_16_+0200_LiWXctSKuDvHl0T/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

I am a xenomai newbie, and testing some of my existing test programs
with the xenomai posix skin.

While testing the file in attachment (testwait) the semaphore does not
block and returns errno 29 (illegal seek). What can be the reason? This
program runs (with a bad timing) under plain 2.6.15 linux.

Mining in the list archive I have found the following sentence (post on
Fri, 21 Oct 2005) : "Pending on a semaphore is forbidden for non-Xenomai
threads..."

What makes the difference between a Xenomai thread and an ordinary nptl
thread, other than the compilation and linking flags?

	Daniel

-- 
***********The difference between theory and practice****************
**************is larger in practice than in theory*******************

      Daniel SIMON    Projet POP ART  INRIA Rhone-Alpes
ZIRST, 655 avenue de l'Europe, 38330 MONTBONNOT SAINT MARTIN, FRANCE 
 Daniel.Simon@domain.hid Phone:(33)476615328 Fax:(33)476615252
	 http://pop-art.inrialpes.fr/people/simon/

*********************************************************************

--Multipart_Tue__25_Apr_2006_13_43_16_+0200_LiWXctSKuDvHl0T/
Content-Type: text/x-csrc; name=testwait.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=testwait.c

#include "testwait.h"

///Function that returns the cpu time in nanoseconds
inline long long GetCpuTime(void)
{
    clock_gettime(HORLOGE, &orctime);
    return (long long)((&orctime)->tv_sec) *NSEC_PER_SEC + (long long)((&orctime)->tv_nsec);
}

// Trap Ctrl C Interruption
void InterruptC_Handler(void)
{
    printf("Ctrl C Interrupt\n");
    printf ("jittermoy = %ld, jittermax = %ld \n", (long)moy / ji, (long)max);
    printf("sem_post(mainSem); \n");
    sem_post(mainSem);
}

int orcTimerSigMask(void)
{
    sigset_t set/* , oldsig */;
    /* int status; */

    sigfillset(&set);
    if (pthread_sigmask(SIG_BLOCK, &set, NULL) != OK)
    {
        printf("pthread_sigmask Failed %d \n", errno);
        return ERROR;
    }
    sigemptyset(&set);
    sigaddset(&set, SIGINT);
    if (pthread_sigmask(SIG_UNBLOCK, &set, NULL) != OK)
    {
        printf("pthread_sigmask Failed %d \n", errno);
        return ERROR;
    }

    return OK;
}
int orcTimerSigUnMask(void)
{
    sigset_t set/* , oldsig */;
    /* int status; */

    sigfillset(&set);
    if (pthread_sigmask(SIG_BLOCK, &set, NULL) != OK)
    {
        printf("pthread_sigmask Failed %d \n", errno);
        return ERROR;
    }

    sigemptyset(&set);
    sigaddset(&set, TIMER1_SIGNAL);
    if (pthread_sigmask(SIG_UNBLOCK, &set, NULL) != OK)
    {
        printf("pthread_sigmask Failed %d \n", errno);
        return ERROR;
    }
    sigemptyset(&set);
    sigaddset(&set, SIGINT);
    if (pthread_sigmask(SIG_UNBLOCK, &set, NULL) != OK)
    {
        printf("pthread_sigmask Failed %d \n", errno);
        return ERROR;
    }

    return OK;
}

void setTimer(void)
{

    printf("setTimer function\n");
    orcTimerSigMask();
    pthread_sigmask(SIG_SETMASK, NULL, &oldsig);
    if ((status = sigismember(&oldsig, TIMER1_SIGNAL)) == 0) printf("TIMER1_SIGNAL NOT BLOCKED in begin setTimer\n");
    else if (status == 1) printf("TIMER1_SIGNAL is BLOCKED in begin setTimer\n");
    else perror("error in sigismember()");

    printf("waiting mainSem...\n");

        err = sem_wait(mainSem);
        printf("mainSem returns %d  ", err);
        if (err != 0) {perror("mainSem");
	  printf("errno = %d \n", errno);}

    printf("finishing...\n");
    // Cancel the timer
    if (timer_delete(t1) == OK) printf("timer deleted\n");

    return ;

}
void clock_it(void)
{
  int Nsig;
  sigset_t clockset;
  
  orcTimerSigMask();
    sigemptyset(&clockset);
    sigaddset(&clockset,TIMER1_SIGNAL);
  printf("clock-it init\n");
    pthread_sigmask(SIG_SETMASK, NULL, &oldsig);
    status = sigismember(&oldsig, TIMER1_SIGNAL);
    if (status == 0) printf("TIMER1_SIGNAL NOT BLOCKED in clock-it\n");
    else if (status == 1) printf("TIMER1_SIGNAL is BLOCKED in clock-it\n");
    else perror("clock-it init error in sigismember()");

    while (1)
    {
      printf("before sigwait \n");
      sigwait(&clockset,&Nsig); 
      printf("clock_it loop\n");
        now = GetCpuTime();

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
            jinc = (now - startime) / 1000;
            jitter = (jinc - (long long) new_setting1.it_interval.tv_nsec / 1000);
            drift += jitter;
            hjitter = abs(jitter);
            moy += hjitter;
            ji++;
            if (hjitter > max) max = hjitter;
#ifdef DEBUG
            printf("increment %ld absjitter %ld drift %ld \n", (long)jinc, (long) hjitter, (long) drift);
#endif
            startime = now;
        }
    }
    return;
}

int main(void)
{
    signal(SIGINT, (void(*)(int))InterruptC_Handler);
    pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
    mysched.sched_priority = sched_get_priority_max(SCHED_FIFO) - 1;
    if ( sched_setscheduler( 0, SCHED_FIFO, &mysched ) == -1 )
    {
        printf("ERROR IN SETTING THE POSIX SCHEDULER\n");
        exit(1);
    }
    mlockall(MCL_CURRENT | MCL_FUTURE);
    orcTimerSigMask();
    pthread_sigmask(SIG_SETMASK, NULL, &oldsig);
    if ((status = sigismember(&oldsig, TIMER1_SIGNAL)) == 0) printf("TIMER1_SIGNAL NOT BLOCKED in main\n");
    else if (status == 1) printf("TIMER1_SIGNAL is BLOCKED in main\n");
    else perror("error in sigismember()");
    printf("RTSIG_MAX = %ld\n", sysconf(_SC_RTSIG_MAX));
    RTPRIO_MIN = sched_get_priority_min(SCHED_FIFO);
    RTPRIO_MAX = sched_get_priority_max(SCHED_FIFO);
    printf("RTPRIO_MIN = %d RTPRIO_MAX = %d\n", RTPRIO_MIN, RTPRIO_MAX);


    mainSem = malloc(sizeof(sem_t));
    if (mainSem == 0)
    {
        printf("ERROR mainSem init \n");
        return 0;
    }
    memset(mainSem, 0, sizeof(sem_t));

    if ((status = sem_init(mainSem, 0, 0)) == OK)
    {
#ifdef DEBUG
        printf("mainSemCreate %p\n", mainSem);
#endif

    }
    else
    {
        printf("mainSemCreate failed\n"); exit(1);
    }

    sig1.sigev_notify = SIGEV_SIGNAL;
    sig1.sigev_signo = TIMER1_SIGNAL;
    sig1.sigev_value.sival_ptr = &t1;

    new_setting1.it_value.tv_sec = 0;
    new_setting1.it_value.tv_nsec = 2000000;
    new_setting1.it_interval.tv_sec = 0;
    new_setting1.it_interval.tv_nsec = 2000000;
#ifdef DEBUG
    printf("TimerSetTime:: new_setting1.it_interval.tv_sec = %ld, new_setting1.it_interval.tv_nsec = %ld \n", new_setting1.it_interval.tv_sec, new_setting1.it_interval.tv_nsec);

    toto = clock_getres(HORLOGE, &clock_resolution);
    printf("Clock resolution is %ld seconds, %ld nanoseconds\n",
           clock_resolution.tv_sec, clock_resolution.tv_nsec);
#endif
    retval = timer_create(HORLOGE, &sig1, &t1);
    if (retval != 0)
    {
        printf("TIMER_CREATE() FAILED\n");
        exit(1);
    }
    else printf("timer created\n");
    if (timer_settime(t1, 0, &new_setting1, NULL) == 0) printf("posix timer runs\n");

    pthread_sigmask(SIG_SETMASK, NULL, &oldsig);
    if ((status = sigismember(&oldsig, TIMER1_SIGNAL)) == 0) printf("TIMER1_SIGNAL NOT BLOCKED in endof setTimer\n");
    else if (status == 1) printf("TIMER1_SIGNAL is BLOCKED in endof setTimer\n");
    else perror("error in sigismember()");

    if (((tid) = (pthread_t*) malloc (sizeof(pthread_t))) == NULL)
    {
        printf("Error malloc orcspawn\n" );
        exit(1);
    }
    if (pthread_create(tid, NULL, (FUNCPTR)clock_it, arg) != 0)
    {
        printf("pthread_create failed\n"); exit(1);
    }
    schedattributes.sched_priority = RTPRIO_MAX;
    pthread_setschedparam(*tid, SCHED_FIFO, &schedattributes);
    pthread_getschedparam(*tid, &pol, &schedattriget);
    prioget = schedattriget.sched_priority;
    printf("thr clock-it created pol %d prio %d Id %p \n", pol, prioget, tid);


    if (pthread_create(&thr_setTimer, NULL, (FUNCPTR)setTimer, NULL) != 0)
    {
        printf("thr_setTimer failed\n"); exit(1);
    }
    schedattributes.sched_priority = RTPRIO_MAX;
    pthread_setschedparam(thr_setTimer, SCHED_FIFO, &schedattributes);
    pthread_getschedparam(thr_setTimer, &pol, &schedattriget);
    prioget = schedattriget.sched_priority;
    printf("thr_setTimer created pol %d prio %d Id %p \n", pol, prioget,&thr_setTimer );
    //waiting...
    pthread_join(thr_setTimer, NULL);
    printf("pthread_join returns\n");

    j = sem_destroy(mainSem);
    if (j == OK)
    {
        free(mainSem); printf("mainSem deleted\n");
    }
    if (pthread_kill(*tid, 0) == OK)
    {
        printf("TaskDelete %p\n", tid);
        status = pthread_cancel(*tid);
    }
    if (status == OK) free(tid);
    return OK;
}


--Multipart_Tue__25_Apr_2006_13_43_16_+0200_LiWXctSKuDvHl0T/
Content-Type: text/x-chdr; name=testwait.h
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=testwait.h

#include <features.h>
#include <values.h>
#include <unistd.h>
#include <limits.h>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <errno.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <semaphore.h>
#include <pthread.h>
#include <sched.h>
#include <posix_time.h>
#include <bits/siginfo.h> 
#include <asm/mman.h>
#include <unistd.h> /* pour libc5 */
#include <sys/io.h> /* pour glibc */ 
#define ADR_LPT 0x378;  // ou 0x278
#include <linux/module.h>

typedef void * (*FUNCPTR) (void *);
typedef void * (*SOSO) (void *); /**< Special type to be used for casting in pthread_create() */

#define NSEC_PER_SEC 1000000000

#define OK 0
#define ERROR -1
#define STATUS int

#define FALSE 0
#define TRUE 1
//#define TIMER1_SIGNAL SIGALRM
#define TIMER1_SIGNAL SIGRTMAX
//#define HORLOGE CLOCK_REALTIME 
#define HORLOGE CLOCK_MONOTONIC
#define POLICY 1

static int ji = 0;
//static int togparport = 0;
static long long startime, now;
static long long hjitter, jinc, max, moy, drift, jitter;
struct timespec clock_resolution;
struct itimerspec new_setting1, current;
int toto;
struct timespec orctime, oldtime, inittime;
int cr = OK;
struct sched_param mysched;
struct sigevent sig1;
struct sigaction old_sa;
timer_t t1;
static sigset_t oldsig;
int j, retval;
sem_t * mainSem;
sem_t * handSem;
int status, err;
pthread_t * tid;
pthread_attr_t attributes;
struct sched_param schedattributes;
char *dummy;
int pol, prio = 99;
void * arg;
int prioget;
struct sched_param schedattriget;
union sigval sval;
siginfo_t t1info;
pthread_t thr_setTimer;
int RTPRIO_MIN, RTPRIO_MAX;

--Multipart_Tue__25_Apr_2006_13_43_16_+0200_LiWXctSKuDvHl0T/
Content-Type: application/octet-stream; name=Makefile
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=Makefile

CiMgVG8gdXNlIHRoaXMgbWFrZWZpbGUgd2l0aCB4ZW5vLWNvbmZpZyBub3QgbG9jYXRlZCBpbiBQ
QVRILCB0eXBlIDoKIyBtYWtlIFhFTk9fQ09ORklHPS9wYXRoL3RvL3hlbm8tY29uZmlnClhFTk9f
Q09ORklHPXhlbm8tY29uZmlnCnByZWZpeCA6PSAkKHNoZWxsICQoWEVOT19DT05GSUcpIC0tcHJl
Zml4KQoKCmlmZXEgKCQocHJlZml4KSwpCiQoZXJyb3IgUGxlYXNlIGFkZCA8eGVub21haS1pbnN0
YWxsLXBhdGg+L2JpbiB0byB5b3VyIFBBVEggdmFyaWFibGUgb3IgdHlwZTogXAptYWtlIFhFTk9f
Q09ORklHPTx4ZW5vbWFpLWluc3RhbGwtcGF0aD4vYmluL3hlbm8tY29uZmlnKQplbmRpZgoKVkVS
U0lPTiA9IHhwb3NpeCAKQVJDSCAgID0gbGludXgKQVBQTEkgICAgPSBUZXN0bGF0CkJJTiAgICAg
ID0gIC4KSU5DTFVERSAgPSAtSS4gLUkkKEhPTUUpL2luY2x1ZGUgIy1JL3Vzci9zcmMvbGludXgt
aHJ0L0RvY3VtZW50YXRpb24vaGlnaC1yZXMtdGltZXJzL2xpYiAtSS91c3Ivc3JjL2xpbnV4LWhy
dC9Eb2N1bWVudGF0aW9uL2hpZ2gtcmVzLXRpbWVycy91c3JfaW5jbCAgIApMSUJESVJTX1VTUiAg
PSAtTCQoSE9NRSkvbGliLyQoQVJDSCkgIy1ML3Vzci9zcmMvbGludXgtaHJ0L0RvY3VtZW50YXRp
b24vaGlnaC1yZXMtdGltZXJzL2xpYgpMSUJfU1RBVElDID0gLUwvdXNyL2xpYi9ucHRsIApMSUJT
X1VTUiAgPSAtbG0gLWxydCAtbHB0aHJlYWQgIApERUJVRyAgICA9IC1nIC1EREVCVUcKI0RFQlVH
ICAgID0gLU8yIC1EREVCVUcKQ0ZMQUdTICAgPSAkKERFQlVHKSAtRF9HTlVfU09VUkNFIC1EX1JF
RU5UUkFOVCAtV2FsbCAtV3N0cmljdC1wcm90b3R5cGVzIC1PMiAKQ0ZMQUdTX1JUOj0gJChzaGVs
bCAkKFhFTk9fQ09ORklHKSAtLXBvc2l4LWNmbGFncykgLWcKTERGTEFHU19SVDo9ICQoc2hlbGwg
JChYRU5PX0NPTkZJRykgLS1wb3NpeC1sZGZsYWdzKQoKQ0MgPSBnY2MKTEQgPSBsZAoKYWxsOiB0
ZXN0d2FpdAoKdGVzdHdhaXQ6IHRlc3R3YWl0LmMgdGVzdHdhaXQuaAoJJChDQykgJChDRkxBR1Mp
ICQoQ0ZMQUdTX1JUKSAkKExERkxBR1NfUlQpIC1vIHRlc3R3YWl0IHRlc3R3YWl0LmMgJChJTkNM
VURFKSAkKExJQkRJUlNfVVNSKSAkKExJQlNfVVNSKQoKCmNsZWFuOiAKCXJtIC1yZiB0ZXN0d2Fp
dCAgKi5vICp+Cg==

--Multipart_Tue__25_Apr_2006_13_43_16_+0200_LiWXctSKuDvHl0T/--

