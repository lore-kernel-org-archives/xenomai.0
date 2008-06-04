Message-ID: <12376.62.39.72.60.1212572296.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0806030510u49102575l792550f46b3b3f5f@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid> 
	<18491.29266.196753.611570@domain.hid> 
	<2766.81.252.86.91.1211992159.squirrel@domain.hid> 
	<2ff1a98a0805280931j611ae10er69b968ae8699d63d@domain.hid> 
	<16273.81.252.86.91.1212060383.squirrel@domain.hid> 
	<2ff1a98a0805290614w3d846e6by69b033204f912391@domain.hid> 
	<13639.81.252.86.91.1212153659.squirrel@domain.hid> 
	<18496.31292.674733.417262@domain.hid> 
	<6543.62.39.72.60.1212483756.squirrel@domain.hid> 
	<2ff1a98a0806030212k15afec22qde7a44e2d7e6caaf@domain.hid>
	<2ff1a98a0806030510u49102575l792550f46b3b3f5f@domain.hid>
Date: Wed, 4 Jun 2008 11:38:16 +0200 (CEST)
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

I succeeded to use printk in shadow.c :

So in xnshadow_harden function, there are calls to printk before
ERESTARTSYS returns :

if (signal_pending(this_task) || down_interruptible(&gk->sync))
{
 /* Grab the request token. */
 printk(KERN_DEBUG "xnshadow_harden : return ERESTARTSYS 1\n");
 return -ERESTARTSYS;
}
...
if (rthal_current_domain =3D=3D rthal_root_domain) {
  if (XENO_DEBUG(NUCLEUS) && (!signal_pending(this_task)
	    || this_task->state !=3D TASK_RUNNING))
	xnpod_fatal
	    ("xnshadow_harden() failed for thread %s[%d]",
	     thread->name, xnthread_user_pid(thread));
  printk(KERN_DEBUG "xnshadow_harden : return ERESTARTSYS 2 - thread %s
[%d]\n"
                                   ,thread->name, nthread_user_pid(thread=
));
  return -ERESTARTSYS;
}


Now , when I execute my test program, for each crash, I ve got one of my
two messages in kernel trace.

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

This is the program :

###################################################################

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
    int err;
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
         err =3D errno;
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
    if((err =3D pthread_mutex_unlock(&lockDisplay)) !=3D 0)
    {
        if(err !=3D EINTR)
        {
           printf("display : erreur pthread_mutex_unlock : %d,
%s\n",err,strerror(err));
           exit(0);
        }
    }

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
    char strComm[1024];

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
                    timeOut0_ptr=3D(struct stTimeOut*)malloc(sizeof(struc=
t
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
                    timeOut1_ptr=3D(struct stTimeOut*)malloc(sizeof(struc=
t
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
                    timeOut2_ptr=3D(struct stTimeOut*)malloc(sizeof(struc=
t
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
                    timeOut3_ptr=3D(struct stTimeOut*)malloc(sizeof(struc=
t
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
                    timeOut4_ptr=3D(struct stTimeOut*)malloc(sizeof(struc=
t
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
    check_pthread(pthread_set_name_np( p0,"threadTimeOutEnd"));

    // TimeOut thread creation
    sch.sched_priority =3D 80;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p1, &attr, threadTimeOut, NULL));
    check_pthread(pthread_set_name_np( p1,"threadTimeOut"));

    // Display thread creation
    sch.sched_priority =3D 70;
    check_pthread(pthread_attr_setschedparam(&attr, &sch));
    check_pthread(pthread_create(&p2, &attr, threadDisplay, NULL));
    check_pthread(pthread_set_name_np( p2,"threadDisplay"));

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

####################################################################

I always have severals types of crash :

####################################################################

-->> first : pthread_mutex_unlock returns Unknown error 512

-> console :

TimeOutEnd thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutEnd thread
TimeOut thread
0 : Start of time out 1 - 5ms
Display thread
1 : Start of time out 2 - 5ms
2 : Start of time out 3 - 5ms
3 : Start of time out 4 - 5ms
4 : Start of time out 5 - 5ms
display : erreur pthread_mutex_unlock : 512, Unknown error 512	<--- stop
of test program execution : exit call in display function

-> kernel traces :

BUG: scheduling while atomic: testTimer12_cor/0x00000002/4501
 [<c03631db>] schedule+0x7d/0x354
 [<c010ddc6>] __wake_up_sync+0x58/0x79
 [<c0140b88>] xnshadow_harden+0x93/0x203
 [<c0234860>] tty_ldisc_deref+0x7e/0x9b
 [<c0140d6b>] losyscall_event+0x73/0x13a
 [<c012f475>] __ipipe_dispatch_event+0xb1/0x174
 [<c0140cf8>] losyscall_event+0x0/0x13a
 [<c0108a4c>] __ipipe_syscall_root+0x6b/0xd1
 [<c0102589>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
xnshadow_harden : return ERESTARTSYS 2 - thread threadDisplay [4501]
note: testTimer12_cor[4501] exited with preempt_count 1
Xenomai: Posix: destroying semaphore c7768290.
Xenomai: Posix: destroying mutex c7765c50.
Xenomai: Posix: destroying mutex c7761690.
Xenomai: Posix: destroying mutex c7766b10.
Xenomai: Posix: destroying condition variable c7765d50.
Xenomai: Posix: destroying condition variable c7766d50.

####################################################################

-->> Second : no error code returned by a test program function

-> console :

TimeOutEnd thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutEnd thread
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
0 : Start of time out 6 - 5ms
1 : Start of time out 7 - 5ms
2 : Start of time out 8 - 5ms
3 : Start of time out 9 - 5ms
4 : Start of time out 10 - 5ms
display : erreur write : 4, Interrupted system call
Number of time-outs ends : 1
TimeOut6 ends
0 : Start of time out 11 - 5ms
Number of time-outs ends : 4
TimeOut7 ends
TimeOut8 ends
TimeOut9 ends
TimeOut10 ends
1 : Start of time out 12 - 5ms
2 : Start of time out 13 - 5ms
3 : Start of time out 14 - 5ms
4 : Start of time out 15 - 5ms		<--- stop of test program execution

-> kernel traces :

BUG: scheduling while atomic: testTimer12_cor/0x00000002/4506
 [<c03631db>] schedule+0x7d/0x354
 [<c010ddc6>] __wake_up_sync+0x58/0x79
 [<c0140b88>] xnshadow_harden+0x93/0x203
 [<c0234860>] tty_ldisc_deref+0x7e/0x9b
 [<c0140d6b>] losyscall_event+0x73/0x13a
 [<c012f475>] __ipipe_dispatch_event+0xb1/0x174
 [<c0140cf8>] losyscall_event+0x0/0x13a
 [<c0108a4c>] __ipipe_syscall_root+0x6b/0xd1
 [<c0102589>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
xnshadow_harden : return ERESTARTSYS 2 - thread threadDisplay [4506]
note: testTimer12_cor[4506] exited with preempt_count 1
Xenomai: POSIX: destroyed thread c7760810
Xenomai: Posix: destroying semaphore c7765c50.
Xenomai: Posix: destroying mutex c7765d50.
Xenomai: Posix: destroying mutex c7761690.
Xenomai: Posix: destroying mutex c7768290.
Xenomai: Posix: destroying condition variable c7766d50.
Xenomai: Posix: destroying condition variable c7766b10.

or

BUG: scheduling while atomic: testTimer12_cor/0x00000002/2940
 [<c03631db>] schedule+0x7d/0x354
 [<c010ddc6>] __wake_up_sync+0x58/0x79
 [<c0140b88>] xnshadow_harden+0x93/0x203
 [<c01229fe>] hrtimer_start+0xa1/0xc3
 [<c0140d6b>] losyscall_event+0x73/0x13a
 [<c012f475>] __ipipe_dispatch_event+0xb1/0x174
 [<c0140cf8>] losyscall_event+0x0/0x13a
 [<c0108a4c>] __ipipe_syscall_root+0x6b/0xd1
 [<c0102589>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
xnshadow_harden : return ERESTARTSYS 2 - thread threadTimeOut [2940]
note: testTimer12_cor[2940] exited with preempt_count 1
Xenomai: Posix: destroying semaphore c7760910.
Xenomai: Posix: destroying mutex c7760850.
Xenomai: Posix: destroying mutex c77608d0.
Xenomai: Posix: destroying mutex c7760950.
Xenomai: Posix: destroying condition variable c7760810.
Xenomai: Posix: destroying condition variable c7760890.

####################################################################

-->> Third : no error code returned by a test program function

-> console :

TimeOutEnd thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutEnd thread
TimeOut thread
0 : Start of time out 1 - 5ms
Display thread
1 : Start of time out 2 - 5ms
2 : Start of time out 3 - 5ms
3 : Start of time out 4 - 5ms
4 : Start of time out 5 - 5ms
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
Number of time-outs ends : 4
TimeOut1 ends
TimeOut2 ends
TimeOut3 ends
TimeOut4 ends
...
0 : Start of time out 16 - 5ms
1 : Start of time out 17 - 5ms
2 : Start of time out 18 - 5ms
3 : Start of time out 19 - 5ms
Number of time-outs ends : 1
TimeOut15 ends
4 : Start of time out 20 - 5ms
Number of time-outs ends : 2
TimeOut16 ends
TimeOut17 ends
0 : Start of time out 21 - 5ms
1 : Start of time out 22 - 5ms
Number of time-outs ends : 2
TimeOut18 ends
TimeOut19 ends
2 : Start of time out 23 - 5ms
3 : Start of time out 24 - 5ms
Number of time-outs ends : 1
TimeOut20 ends
4 : Start of time out 25 - 5ms
Display thread :43617		<--- test program crash (ctrl+c to stop it)

-> kernel traces :

xnshadow_harden : return ERESTARTSYS 1
Xenomai: POSIX: destroyed thread c7760810
Xenomai: Posix: destroying semaphore c7761110.
Xenomai: Posix: destroying mutex c7761050.
Xenomai: Posix: destroying mutex c77610d0.
Xenomai: Posix: destroying mutex c7761150.
Xenomai: Posix: destroying condition variable c7761010.
Xenomai: Posix: destroying condition variable c7761090.

or

xnshadow_harden : return ERESTARTSYS 2 - thread threadDisplay [3165]
Xenomai: POSIX: destroyed thread c7760810
Xenomai: Posix: destroying semaphore c7761110.
Xenomai: Posix: destroying mutex c7761050.
Xenomai: Posix: destroying mutex c77610d0.
Xenomai: Posix: destroying mutex c7761150.
Xenomai: Posix: destroying condition variable c7761010.
Xenomai: Posix: destroying condition variable c7761090.

####################################################################

-->> Fourth : test program is executed without crash but there are
xnshadow_harden traces

-> console :
...

-> kernel traces (For example) :
xnshadow_harden : return ERESTARTSYS 1

or

xnshadow_harden : return ERESTARTSYS 2 - thread threadDisplay [2889]

or

xnshadow_harden : return ERESTARTSYS 2 - thread threadTimeOut [2950]

####################################################################

test program is also executed without errors.


It's difficult to me to understand what exactly happens in xnshadow_harde=
n
function. At a moment, there is a problem when display thread or timeout
thread have to return in the xenomai domain, but why ?

thank you for your help.


