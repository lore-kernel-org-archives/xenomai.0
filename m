Message-ID: <6543.62.39.72.60.1212483756.squirrel@domain.hid>
In-Reply-To: <18496.31292.674733.417262@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<12142.81.252.86.91.1211467896.squirrel@domain.hid>
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid>
	<2405.81.252.86.91.1211549465.squirrel@domain.hid>
	<2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid>
	<5871.81.252.86.91.1211789666.squirrel@domain.hid>
	<18491.29266.196753.611570@domain.hid>
	<2766.81.252.86.91.1211992159.squirrel@domain.hid>
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid>
	<16273.81.252.86.91.1212060383.squirrel@domain.hid>
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid>
	<13639.81.252.86.91.1212153659.squirrel@domain.hid>
	<18496.31292.674733.417262@domain.hid>
Date: Tue, 3 Jun 2008 11:02:36 +0200 (CEST)
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

I tried your new patch and, now there is no longer issue of priority
inheritance with a mutex. Thanks a lot for that.

However, there are still problems with my big application. It still crash=
es.

>From the test program that you corrected (with check functions), I
succeeded to reproduce them.

Write function returns "Interrrupt system call" error (EINTR). this is
normal.

but I ve got the same error message with pthread_mutex_unlock. In the
specification of this function, there is a note about that : "These
functions shall not return an error code of [EINTR]." (these functions ar=
e
pthread_mutex_lock, pthread_mutex_unlock, pthread_mutex_trylock)

So I ve got 3 error types :
pthread_mutex_unlock returns "Interrrupt system call" and "Unknown error
512". When there is "Unknown error 512" message, there are "Bug :
scheduling while atomic" kernel traces.
In the last error type, My test program is stopped without display of a
function error return code and there are also "Bug : scheduling while
atomic" kernel traces.

In the test program, there are three Xenomai thread :
threadTimeOutEnd (prio : 85): This thread waits the timeout end thanks to
a Semaphore (In the timeout end handler, the Semaphore is posted), and
warns threadTimeOut with a condvar broadcast. This thread calls display
function to debug the program.
threadTimeOut (prio : 80): Malloc memory space to create timeout. Set-up
timeouts of 5ms. Free memory space of achieved timeouts (This thread is
notified of timeout end with a condvar broadcasted by threadTimeOutEnd).
This thread must do the timeout end handler processing.This thread calls
display function to debug the program.
threadDisplay (prio : 70): Call display function in a loop.

This is the program : (sorry, it is a bit long. I can t reduce it)

##############################################################

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

#define NB_PTR_TEMPO 5  // 5 timeouts maximum
#define STACKSIZE 350

// stack
static int Stack[STACKSIZE];
static unsigned short Write_ptr =3D 0;
static unsigned short Read_ptr =3D 0;

// Display
pthread_mutex_t lockDisplay;
unsigned char bufferDisplay[2048];

// Timer
struct stTimeOut {
    timer_t timer_h;
    struct sigaction    sa;
    struct sigevent     sig_spec;
    struct itimerspec   tmr_setting;
    int number;
}*timeOut0_ptr, *timeOut1_ptr, *timeOut2_ptr, *timeOut3_ptr, *timeOut4_pt=
r;

// Thread start
pthread_cond_t  start_signal;
pthread_mutex_t main_start_lock;
bool bMainStart =3D false;
// Time-out end
pthread_cond_t   TimeOutEnd_signal;
pthread_mutex_t  timeOutEnd_lock;
bool bTimeOutEnd =3D false;
sem_t  TimeOutWait_sem;

// Stack mutex
pthread_mutex_t Stack_lock;

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
    ({                                                \
        int _status =3D (expr);                 \
        check(__FILE__, __LINE__, #expr, _status, errno);  \
    })

/************************ Stack functions *************************/

int StackCreation(void)
{
    Write_ptr =3D 0;
    Read_ptr  =3D 0;
    return 0;
}

void StackWrite(int number)
{
    if (Write_ptr >=3D STACKSIZE)
        Write_ptr =3D 0;
    Stack[Write_ptr++] =3D number;
}

int StackRead(void)
{
    int number;
    if (Read_ptr >=3D STACKSIZE)
        Read_ptr =3D 0;
    number =3D Stack[Read_ptr++];
    return number;
}

unsigned short GetWritePtr(void)
{
    return Write_ptr;
}

unsigned short GetReadPtr(void)
{
    return Read_ptr;
}

/************************ Functions ******************************/
void display(char * chaine,...)
{
    check_pthread(pthread_mutex_lock(&lockDisplay));
    va_list ArgDisplay;
    va_start(ArgDisplay, chaine);
    check_unix(vsprintf((char *)bufferDisplay,chaine,ArgDisplay));
    bool bErrWrite =3D false;
    do
	{
      bErrWrite =3D false;
      if (write(2, (char*)bufferDisplay, strlen((char *)bufferDisplay)) <=
 0)
      {
         int err =3D errno;
         printf("display : erreur write : %d, %s\n",err,strerror(err));
         if (err =3D=3D EINTR)
         {
              bErrWrite =3D true;
         }
         else
         {
             exit(0);
         }
      }
    }while (bErrWrite);
    check_pthread(pthread_mutex_unlock(&lockDisplay));
}

int func(volatile int* i)
{
    return (*i)++;
}

void DeleteTimer(timer_t timer)
{
    if (timer!=3DNULL)
        check_unix(__real_timer_delete(timer));
}

void EndTimeOut (int signo,siginfo_t *info,void*context)
{
    volatile int i, result =3D 0;

    DeleteTimer(((struct stTimeOut*)(info->si_value.sival_ptr))->timer_h)=
;

    StackWrite(((struct stTimeOut*)(info->si_value.sival_ptr))->number);

    check_unix(sem_post(&TimeOutWait_sem));
}

void StartTimeOut (int nb_Sec, int nb_nSec, struct stTimeOut* timeOut)
{
    (timeOut->sa).sa_flags =3D SA_SIGINFO;
    (timeOut->sa).sa_sigaction =3D EndTimeOut;

    check_unix(sigaction(SIGRTMIN, &(timeOut->sa), NULL));

    (timeOut->sig_spec).sigev_notify =3D SIGEV_SIGNAL;
    (timeOut->sig_spec).sigev_signo =3D SIGRTMIN;
    (timeOut->sig_spec).sigev_value.sival_ptr =3D timeOut;

    check_unix(__real_timer_create(CLOCK_REALTIME, &(timeOut->sig_spec),
                            &(timeOut->timer_h)));

    (timeOut->tmr_setting).it_value.tv_sec =3D nb_Sec;
    (timeOut->tmr_setting).it_value.tv_nsec =3D nb_nSec;
    (timeOut->tmr_setting).it_interval.tv_sec =3D 0;
    (timeOut->tmr_setting).it_interval.tv_nsec =3D 0;

    check_unix(__real_timer_settime((timeOut->timer_h), 0,
                             &(timeOut->tmr_setting),NULL));
}

/************************** Threads ********************************/
void* threadTimeOutEnd(void * arg) {

    int NbSem =3D 0;
    bool bSemWaitError;

    display("TimeOutEnd thread\n");
    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart) {
        check_pthread(pthread_cond_wait(&start_signal, &main_start_lock))=
;
    }
    check_pthread(pthread_mutex_unlock(&main_start_lock));
    display("TimeOutEnd thread\n");

    while (1) {
    do
    {
      bSemWaitError =3D false;
      if (sem_wait (&TimeOutWait_sem)<0)
      {
	int err =3D errno;
        display("Semaphore::Get - erreur sem_wait : errno :%d -> %s\n"
                                                 ,err,strerror(err));
        if (err =3D=3D EINTR)
	{
	  bSemWaitError =3D true;
        }
      }
    }while (bSemWaitError);

    check_pthread(pthread_mutex_lock(&timeOutEnd_lock));
    check_pthread(pthread_cond_broadcast(&TimeOutEnd_signal));
    bTimeOutEnd =3D true;
    check_pthread(pthread_mutex_unlock(&timeOutEnd_lock));
    }
}

void* threadTimeOut(void * arg) {
   int i=3D1;
   int j, k, NbTimeOut, numTimeOut;

   timeOut0_ptr =3D timeOut1_ptr =3D timeOut2_ptr =3D timeOut3_ptr =3D
timeOut4_ptr =3D NULL;

   display("TimeOut thread\n");
   check_pthread(pthread_mutex_lock(&main_start_lock));
   while (!bMainStart)
        check_pthread(pthread_cond_wait(&start_signal, &main_start_lock))=
;
   check_pthread(pthread_mutex_unlock(&main_start_lock));
   display("TimeOut thread\n");

    while (i < 100) {
        // Malloc and start of time out
        for (j=3D0 ; j < NB_PTR_TEMPO; j++) {
          switch(j) {
          case 0 : if (timeOut0_ptr =3D=3D NULL) {
                  timeOut0_ptr=3D(struct stTimeOut*)malloc(sizeof(struct
stTimeOut));
                  if (timeOut0_ptr =3D=3D NULL)
                  {
                       display("0 : Malloc error\n");
                       exit(1);
                  }
                  timeOut0_ptr->number =3D i;
                  i++;
                  display("0 : Start of time out %d - 5ms\n",
                           timeOut0_ptr->number);
                  StartTimeOut(0,500000000,timeOut0_ptr);
                }
                break;
           case 1 : if (timeOut1_ptr =3D=3D NULL) {
                  timeOut1_ptr=3D(struct stTimeOut*)malloc(sizeof(struct
stTimeOut));
                  if (timeOut1_ptr =3D=3D NULL)
                  {
                       display("1 : Malloc error\n");
                       exit(1);
                  }
                  timeOut1_ptr->number =3D i;
                  i++;
                  display("1 : Start of time out %d - 5ms\n",
                          timeOut1_ptr->number);
                  StartTimeOut(0,500000000,timeOut1_ptr);
              }
              break;
          case 2 : if (timeOut2_ptr =3D=3D NULL) {
                  timeOut2_ptr=3D(struct stTimeOut*)malloc(sizeof(struct
stTimeOut));
                  if (timeOut2_ptr =3D=3D NULL)
                  {
                       display("2 : Malloc error\n");
                       exit(1);
                  }
                  timeOut2_ptr->number =3D i;
                  i++;
                  display("2 : Start of time out %d - 5ms\n",
                          timeOut2_ptr->number);
                  StartTimeOut(0,500000000,timeOut2_ptr);
              }
              break;
          case 3 : if (timeOut3_ptr =3D=3D NULL) {
                  timeOut3_ptr=3D(struct stTimeOut*)malloc(sizeof(struct
stTimeOut));
                  if (timeOut3_ptr =3D=3D NULL)
                  {
                       display("3 : Malloc error\n");
                       exit(1);
                  }
                  timeOut3_ptr->number =3D i;
                  i++;
                  display("3 : Start of time out %d - 5ms\n",
                            timeOut3_ptr->number);
                  StartTimeOut(0,500000000,timeOut3_ptr);
              }
              break;
          case 4 : if (timeOut4_ptr =3D=3D NULL) {
                  timeOut4_ptr=3D(struct stTimeOut*)malloc(sizeof(struct
stTimeOut));
                  if (timeOut4_ptr =3D=3D NULL)
                  {
                       display("4 : Malloc error\n");
                       exit(1);
                  }
                  timeOut4_ptr->number =3D i;
                  i++;
                  display("4 : Start of time out %d - 5ms\n",
                         timeOut4_ptr->number);
                  StartTimeOut(0,500000000,timeOut4_ptr);
              }
              break;
          }
      }
      check_pthread(pthread_mutex_lock(&timeOutEnd_lock));
      while (!bTimeOutEnd){
          check_pthread(pthread_cond_wait(&TimeOutEnd_signal,
                                          &timeOutEnd_lock));
          }
      bTimeOutEnd =3D false;
      check_pthread(pthread_mutex_unlock(&timeOutEnd_lock));
      NbTimeOut =3D GetWritePtr() - GetReadPtr();
      display("Number of time-outs ends : %d\n", NbTimeOut);
      for (j=3D0; j < NbTimeOut; j++) {
            numTimeOut =3D StackRead();
            display("TimeOut%d ends\n", numTimeOut);
            for (k=3D0; k < NB_PTR_TEMPO; k++) {
                switch(k) {
                case 0 : if (timeOut0_ptr !=3D NULL) {
                        if (timeOut0_ptr->number =3D=3D numTimeOut) {
                            free(timeOut0_ptr);
                            timeOut0_ptr =3D NULL;
                        }
                    }
                    break;
                case 1 : if (timeOut1_ptr !=3D NULL) {
                        if (timeOut1_ptr->number =3D=3D numTimeOut) {
                            free(timeOut1_ptr);
                            timeOut1_ptr =3D NULL;
                        }
                    }
                    break;
                case 2 : if (timeOut2_ptr !=3D NULL) {
                        if (timeOut2_ptr->number =3D=3D numTimeOut) {
                            free(timeOut2_ptr);
                            timeOut2_ptr =3D NULL;
                        }
                    }
                    break;
                case 3 : if (timeOut3_ptr !=3D NULL) {
                        if (timeOut3_ptr->number =3D=3D numTimeOut) {
                            free(timeOut3_ptr);
                            timeOut3_ptr =3D NULL;
                        }
                    }
                    break;
                case 4 : if (timeOut4_ptr !=3D NULL) {
                        if (timeOut4_ptr->number =3D=3D numTimeOut) {
                            free(timeOut4_ptr);
                            timeOut4_ptr =3D NULL;
                        }
                    }
                    break;
                }
            }
        }
    }
    while(1) {
        sleep(10);
    }
    return NULL;
}

void* threadDisplay(void * arg) {
    volatile int i=3D0;
    volatile int result;
    display("Display thread\n");
    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart)
        check_pthread(pthread_cond_wait(&start_signal, &main_start_lock))=
;
    check_pthread(pthread_mutex_unlock(&main_start_lock));
    display("Display thread\n");

    while (i <=3D 100000) {
        result =3D func(&i);
        display("Display thread :%d \r",result);
    }
    display("End of display thread\n");
    return NULL;
}

/***********************************************************************/
void cleanup_upon_sig(int sig __attribute__((unused)))
{
    if (timeOut0_ptr)
        DeleteTimer(timeOut0_ptr->timer_h);
    if (timeOut1_ptr)
        DeleteTimer(timeOut1_ptr->timer_h);
    if (timeOut2_ptr)
        DeleteTimer(timeOut2_ptr->timer_h);
    if (timeOut3_ptr)
        DeleteTimer(timeOut3_ptr->timer_h);
    if (timeOut4_ptr)
        DeleteTimer(timeOut4_ptr->timer_h);
    exit(0);
}

int main(int argc, char** argv) {
    pthread_attr_t attr;
    pthread_mutexattr_t attr_proto;
    pthread_t p0;
    pthread_t p1;
    pthread_t p2;
    struct sched_param sch;

    // Stack creation
    StackCreation();

    check_unix(signal(SIGINT, cleanup_upon_sig));
    check_unix(signal(SIGTERM, cleanup_upon_sig));

    check_unix(mlockall(MCL_CURRENT|MCL_FUTURE));

    // mutex and sem initialisation
    check_pthread(pthread_cond_init(&start_signal, NULL));
    check_pthread(pthread_mutex_init(&main_start_lock, NULL));
    check_pthread(pthread_cond_init(&TimeOutEnd_signal, NULL));
    check_pthread(pthread_mutex_init(&timeOutEnd_lock, NULL));
    check_unix(sem_init (&TimeOutWait_sem, 0,0));
    check_pthread(pthread_mutexattr_init(&attr_proto));
    check_pthread(pthread_mutexattr_setprotocol(&attr_proto,PTHREAD_PRIO_=
INHERIT));
    check_pthread(pthread_mutex_init(&lockDisplay, &attr_proto));

    check_pthread(pthread_attr_init(&attr));
    check_pthread(pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCH=
ED));
    check_pthread(pthread_attr_setschedpolicy(&attr, SCHED_FIFO));

    // TimeOutEnd thread creation
    sch.sched_priority =3D 85;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p0, &attr, threadTimeOutEnd, NULL));

    // TimeOut thread creation
    sch.sched_priority =3D 80;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p1, &attr, threadTimeOut, NULL));

    // Display thread creation
    sch.sched_priority =3D 70;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p2, &attr, threadDisplay, NULL));

    check_pthread(pthread_attr_destroy(&attr));

    display("Main condition broadcast\n");
    // Start of all threads
    check_pthread(pthread_mutex_lock(&main_start_lock));
    bMainStart =3D true;
    check_pthread(pthread_cond_broadcast(&start_signal));
    check_pthread(pthread_mutex_unlock(&main_start_lock));

    while (1) {
        sleep(5);
    }

    return 0;
}

#########################################################################=
#########

-->> First type of error (pthread_mutex_unlock returns Interrupted system
call)

-> Result on the console :

TimeOutCreation thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutCreation thread
TimeOut thread
0 : Start of time out 1 - 5ms
Display thread
1 : Start of time out 2 - 5ms
2 : Start of time out 3 - 5ms
3 : Start of time out 4 - 5ms
4 : Start of time out 5 - 5ms
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
Number of time-outs ends : 5
TimeOut1 ends
TimeOut2 ends
TimeOut3 ends
TimeOut4 ends
TimeOut5 ends
...
0 : Start of time out 26 - 5ms
1 : Start of time out 27 - 5ms
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
Number of time-outs ends : 3
TimeOut23 ends
TimeOut24 ends
TimeOut25 ends
2 : Start of time out 28 - 5ms
3 : Start of time out 29 - 5ms
4 : Start of time out 30 - 5ms
display : erreur write : 4, Interrupted system call
Number of time-outs ends : 1
TimeOut26 ends
0 : Start of time out 31 - 5ms
Number of time-outs ends : 1
TimeOut27 ends
1 : Start of time out 32 - 5ms
testTimer12_corrected.c:169: pthread_mutex_unlock(&lockDisplay):
Interrupted system call    <--- Stop of the program (exit(EXIT_FAILURE) o=
f
check function)

-> Kernel traces (Normal) :

Xenomai: Posix: destroying semaphore c7760910.
Xenomai: Posix: destroying mutex c7760850.
Xenomai: Posix: destroying mutex c77608d0.
Xenomai: Posix: destroying mutex c7760950.
Xenomai: Posix: destroying condition variable c7760810.
Xenomai: Posix: destroying condition variable c7760890.

#########################################################################=
#########

-->> Second type of error (pthread_mutex_unlock returns Unknown error 512=
)

-> Result on the console :

TimeOutCreation thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutCreation thread
TimeOut thread
0 : Start of time out 1 - 5ms
Display thread
1 : Start of time out 2 - 5ms
2 : Start of time out 3 - 5ms
3 : Start of time out 4 - 5ms
4 : Start of time out 5 - 5ms
testTimer12_corrected.c:169: pthread_mutex_unlock(&lockDisplay): Unknown
error 512   <--- Stop of the program (exit(EXIT_FAILURE) of check
function)

-> Kernel traces :

BUG: scheduling while atomic: testTimer12_cor/0x00000002/3083
 [<c0362553>] schedule+0x7d/0x354
 [<c010ddc6>] __wake_up_sync+0x58/0x79
 [<c0140b7f>] xnshadow_harden+0x8a/0x1c0
 [<c02347e0>] tty_ldisc_deref+0x7e/0x9b
 [<c0140d28>] losyscall_event+0x73/0x13a
 [<c012f475>] __ipipe_dispatch_event+0xb1/0x174
 [<c0140cb5>] losyscall_event+0x0/0x13a
 [<c0108a4c>] __ipipe_syscall_root+0x6b/0xd1
 [<c0102589>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
note: testTimer12_cor[3083] exited with preempt_count 1
Xenomai: Posix: destroying semaphore c7760910.
Xenomai: Posix: destroying mutex c7760850.
Xenomai: Posix: destroying mutex c77608d0.
Xenomai: Posix: destroying mutex c7760950.
Xenomai: Posix: destroying condition variable c7760810.
Xenomai: Posix: destroying condition variable c7760890.

#########################################################################=
#########

-->> Third type of error

-> Result on the console :

TimeOutCreation thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutCreation thread
TimeOut thread
0 : Start of time out 1 - 5ms
Display thread
1 : Start of time out 2 - 5ms
2 : Start of time out 3 - 5ms
3 : Start of time out 4 - 5ms
4 : Start of time out 5 - 5ms
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
Number of time-outs ends : 5
TimeOut1 ends
TimeOut2 ends
TimeOut3 ends
TimeOut4 ends
TimeOut5 ends
...
0 : Start of time out 16 - 5ms
1 : Start of time out 17 - 5ms
2 : Start of time out 18 - 5ms
3 : Start of time out 19 - 5ms
4 : Start of time out 20 - 5ms
Display tSemaphore::Get - erreur sem_wait : errno :4 -> Interrupted syste=
m
call
Number of time-outs ends : 1
TimeOut16 ends
0 : Start of time out 21 - 5ms
Number of time-outs ends : 4
TimeOut17 ends
TimeOut18 ends
TimeOut19 ends
TimeOut20 ends
1 : Start of time out 22 - 5ms
2 : Start of time out 23 - 5ms
3 : Start of time out 24 - 5ms
4 : Start of time out 25 - 5ms     <--- Stop of the program

-> Kernel traces :

BUG: scheduling while atomic: testTimer12_cor/0x00000002/3108
 [<c0362553>] schedule+0x7d/0x354
 [<c010ddc6>] __wake_up_sync+0x58/0x79
 [<c0140b7f>] xnshadow_harden+0x8a/0x1c0
 [<c02347e0>] tty_ldisc_deref+0x7e/0x9b
 [<c0140d28>] losyscall_event+0x73/0x13a
 [<c012f475>] __ipipe_dispatch_event+0xb1/0x174
 [<c0140cb5>] losyscall_event+0x0/0x13a
 [<c0108a4c>] __ipipe_syscall_root+0x6b/0xd1
 [<c0102589>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
note: testTimer12_cor[3108] exited with preempt_count 1
Xenomai: Posix: destroying semaphore c7760910.
Xenomai: Posix: destroying mutex c7760850.
Xenomai: Posix: destroying mutex c77608d0.
Xenomai: Posix: destroying mutex c7760950.
Xenomai: Posix: destroying condition variable c7760810.
Xenomai: Posix: destroying condition variable c7760890.

#########################################################################=
#########

I think that second and third error types are the same problem.
Sometimes, the program is also successfully executed.

What do you think about these traces ?

Thank you



