Message-ID: <2405.81.252.86.91.1211549465.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid> 
	<12036.62.39.72.60.1211212126.squirrel@domain.hid> 
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid> 
	<5481.62.39.72.60.1211293804.squirrel@domain.hid> 
	<18483.10408.141546.420660@domain.hid> 
	<2336.81.252.86.91.1211379896.squirrel@domain.hid> 
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid> 
	<15059.81.252.86.91.1211386718.squirrel@domain.hid> 
	<18484.28025.505865.374746@domain.hid> 
	<12142.81.252.86.91.1211467896.squirrel@domain.hid>
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid>
Date: Fri, 23 May 2008 15:31:05 +0200 (CEST)
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

On Thu, May 22, 2008 at 4:51 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
>> Hello,
>>
>> Thanks to a serial console, I obtained the kernel traces before the cr=
ash
>> when I executed Cyclictest.
>> However, I could not have the same error : kernel panic - not syncing:
>> Aiee, killing interrupt handler. The system crashed like before, witho=
ut
>> error message.

> I do not understand what you mean. You tell us that you get no traces,
> but then shows some traces.

> Anyway, could you enable the Xenomai nucleus debugging ? In
> particular, I would be interested to know if you get the fatal "Error
> relaxing a kicked thread".


sorry, my english is bad. I would like to say that I had not the explicit
error message kernel panic - not syncing: Aiee, killing interrupt handler


> On Thu, May 22, 2008 at 4:51 PM, Fabien MAHOT
> <fabien.mahot@domain.hid> wrote:
>> I also tried without your patch, and when I stopped Cyclictest, there
>> was
>> no problem !
>
> Ah! You put interesting information in the middle of I-pipe tracer
> traces, how do you want me to discover them ? So, this is a bug caused
> by my patch. In my patch, do you get better results if you do not set
the XNKICKED bit ?
>
> --
>  Gilles
>

yes, I cancelled XNKICKED in xnthread_set_info call. And, it's better,
there is no problem when I stop Cyclictest.
With my sem_wait test program, sem_wait returns an error when a signal of
time-out end unlocks it, so that's good.
And , I no longer have system crash after the sem_wait call.

However, When I executed my big application, the system crashed when a
thread seemed to call pthread_cond_wait. I m not sure, in this
application, there are a lot of threads. The kernel trace when the system
crashed is : Xenomai: fatal: Relaxing a kicked thread(thread=3DDialogue
serie 1, mask=3D200)?!
That is what you planned. What does this message mean ?
I tried to reproduce this issue with a small test program but I didn't
succeed.

I ve got a test program with this issue, but it's the one in which I ve
got a lock in the time-out end routine. (pthread_cond_broadcast) I posted
it in the mailing list and you corrected it.
I replaced the mutex use by a semaphore.

Otherwise, I ve got an other test program in which there are 3 real-time
threads. Time-outs are created dynamically and have the same duration.
(5ms)
I ve a display function, to display traces on the console. (use write
function)
The threads :
	threadTimeOut : creates and deletes time-outs
	threadTimeOutEnd :  waits the end of a time-out (sem_wait) and indicates
it to threadTimeOut
	threadDisplay : calls display function in a loop.

When I execute this program, there is a system crash. the kernel trace is
: Xenomai: fatal: inserting element twice, holder=3Dc7761c78, qslot=3Dc77=
61160
at include/xenomai/nucleus/queue.h:321
I don't execute it without your patch.

this is the test program :

#########################################################################=
##################

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

#define NB_PTR_TEMPO 3  // 5 tempos maximum
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

// TimeOut_ptr
struct stTimeOut* tabTimeOut_ptr[STACKSIZE];
static unsigned short Write_to_ptr =3D 0;
static unsigned short Read_to_ptr =3D 0;

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
	{
		Write_ptr =3D 0;
	}
	Stack[Write_ptr++] =3D number;
}

int StackRead(void)
{
    int number;
    if (Read_ptr >=3D STACKSIZE)
    {
		Read_ptr =3D 0;
	}
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
    pthread_mutex_lock(&lockDisplay);
    va_list ArgDisplay;
	va_start(ArgDisplay, chaine);
	vsprintf((char *)bufferDisplay,chaine,ArgDisplay);
	write(2, (char*)bufferDisplay, strlen((char *)bufferDisplay));
	//printf(bufferDisplay);
    pthread_mutex_unlock(&lockDisplay);
}

int func(volatile int* i)
{
	return (*i)++;
}

void DeleteTimer(timer_t timer)
{
     if (timer!=3DNULL)
     {
          timer_delete(timer);
     }
}

void EndTimeOut (int signo,siginfo_t *info,void*context)
{
     volatile int i, result =3D 0;

     DeleteTimer(((struct stTimeOut*)(info->si_value.sival_ptr))->timer_h=
);

     StackWrite(((struct stTimeOut*)(info->si_value.sival_ptr))->number);

     if ((sem_post(&TimeOutWait_sem)) =3D=3D -1)
     {
        printf("sem_post error - errno : %d  -> %s\n",errno,
strerror(errno));
     }
}

void StartTimeOut (int nb_Sec, int nb_nSec, struct stTimeOut* timeOut)
{
    (timeOut->sa).sa_flags =3D SA_SIGINFO;
    (timeOut->sa).sa_sigaction =3D EndTimeOut;

    while(sigaction(SIGRTMIN, &(timeOut->sa), NULL) < 0)
    {
        display("sigaction error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    (timeOut->sig_spec).sigev_notify =3D SIGEV_SIGNAL;
    (timeOut->sig_spec).sigev_signo =3D SIGRTMIN;
    (timeOut->sig_spec).sigev_value.sival_ptr =3D timeOut;

    while (timer_create(CLOCK_REALTIME, &(timeOut->sig_spec),
&(timeOut->timer_h)) < 0)
    {
        display("timer_create error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    (timeOut->tmr_setting).it_value.tv_sec =3D nb_Sec;
    (timeOut->tmr_setting).it_value.tv_nsec =3D nb_nSec;
    (timeOut->tmr_setting).it_interval.tv_sec =3D 0;
    (timeOut->tmr_setting).it_interval.tv_nsec =3D 0;

    while (timer_settime((timeOut->timer_h), 0,
&(timeOut->tmr_setting),NULL) < 0)
    {
       display("timer_settime error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

}

/************************** Threads ********************************/
void* threadTimeOutEnd(void * arg) {

    int NbSem =3D 0;
    bool bSemWaitError;

    display("TimeOutCreation thread\n");
	pthread_mutex_lock(&main_start_lock);
	while (!bMainStart)
	{
       pthread_cond_wait(&start_signal, &main_start_lock);
    }
    pthread_mutex_unlock(&main_start_lock);
    display("TimeOutCreation thread\n");

    while (1)
    {
          do
          {
             bSemWaitError =3D false;
             if ((sem_wait(&TimeOutWait_sem)) < 0)
             {
                 display("sem_wait error - errno : %d  -> %s\n",errno,
strerror(errno));
                 if (errno =3D=3D EINTR) // la tache appelant sem_wait a =
=E9t=E9
d=E9bloqu=E9e de son attente par un signal d'interruption
			     {
                      bSemWaitError =3D true;
                 }
             }
          }while (bSemWaitError);

          pthread_mutex_lock(&timeOutEnd_lock);
          if((pthread_cond_broadcast(&TimeOutEnd_signal)) < 0)
          {
              display("pthread_cond_broadcast error - errno : %d  ->
%s\n",errno, strerror(errno));
              exit(0);
          }
          bTimeOutEnd =3D true;
          pthread_mutex_unlock(&timeOutEnd_lock);
    }
}

void* threadTimeOut(void * arg) {
    int i=3D1;
    int j, k, NbTimeOut, numTimeOut;

    timeOut0_ptr =3D timeOut1_ptr =3D timeOut2_ptr =3D timeOut3_ptr =3D
timeOut4_ptr =3D NULL;

	display("TimeOut thread\n");
	pthread_mutex_lock(&main_start_lock);
	while (!bMainStart)
	{
       pthread_cond_wait(&start_signal, &main_start_lock);
    }
    pthread_mutex_unlock(&main_start_lock);
    display("TimeOut thread\n");

    while (i < 100)
    {
          // Malloc and start of time out
          for (j=3D0 ; j < NB_PTR_TEMPO; j++)
          {
              switch(j)
              {
              case 0 : if (timeOut0_ptr =3D=3D NULL)
                       {
                          timeOut0_ptr=3D(struct
stTimeOut*)malloc(sizeof(struct stTimeOut));
                          if (timeOut0_ptr =3D=3D NULL) exit(1);
                          timeOut0_ptr->number =3D i;
                          i++;
                          display("Start of time out %d - 5ms\n",
timeOut0_ptr->number);
                          StartTimeOut(0,500000000,timeOut0_ptr);
                       }
                       break;
              case 1 : if (timeOut1_ptr =3D=3D NULL)
                       {
                          timeOut1_ptr=3D(struct
stTimeOut*)malloc(sizeof(struct stTimeOut));
                          if (timeOut1_ptr =3D=3D NULL) exit(1);
                          timeOut1_ptr->number =3D i;
                          i++;
                          display("Start of time out %d - 5ms\n",
timeOut1_ptr->number);
                          StartTimeOut(0,500000000,timeOut1_ptr);
                       }
                       break;
              case 2 : if (timeOut2_ptr =3D=3D NULL)
                       {
                          timeOut2_ptr=3D(struct
stTimeOut*)malloc(sizeof(struct stTimeOut));
                          if (timeOut2_ptr =3D=3D NULL) exit(1);
                          timeOut2_ptr->number =3D i;
                          i++;
                          display("Start of time out %d - 5ms\n",
timeOut2_ptr->number);
                          StartTimeOut(0,500000000,timeOut2_ptr);
                       }
                       break;
              case 3 : if (timeOut3_ptr =3D=3D NULL)
                       {
                          timeOut3_ptr=3D(struct
stTimeOut*)malloc(sizeof(struct stTimeOut));
                          if (timeOut3_ptr =3D=3D NULL) exit(1);
                          timeOut3_ptr->number =3D i;
                          i++;
                          display("Start of time out %d - 5ms\n",
timeOut3_ptr->number);
                          StartTimeOut(0,500000000,timeOut3_ptr);
                       }
                       break;
              case 4 : if (timeOut4_ptr =3D=3D NULL)
                       {
                          timeOut4_ptr=3D(struct
stTimeOut*)malloc(sizeof(struct stTimeOut));
                          if (timeOut4_ptr =3D=3D NULL) exit(1);
                          timeOut4_ptr->number =3D i;
                          i++;
                          display("Start of time out %d - 5ms\n",
timeOut4_ptr->number);
                          StartTimeOut(0,500000000,timeOut4_ptr);
                       }
                       break;
              }
          }

          pthread_mutex_lock(&timeOutEnd_lock);
          while (!bTimeOutEnd)
          {
                if
((pthread_cond_wait(&TimeOutEnd_signal,&timeOutEnd_lock))
< 0)
                {
                   display("pthread_cond_wait error - errno : %d  ->
%s\n",errno, strerror(errno));
                   exit(0);
                }
          }
          bTimeOutEnd =3D false;
          pthread_mutex_unlock(&timeOutEnd_lock);

          NbTimeOut =3D GetWritePtr() - GetReadPtr();
          display("Number of time-outs ends : %d\n", NbTimeOut);
          for (j=3D0; j < NbTimeOut; j++)
          {
             numTimeOut =3D StackRead();
             display("TimeOut%d ends\n", numTimeOut);
             for (k=3D0; k < NB_PTR_TEMPO; k++)
             {
                  switch(k)
                  {
                  case 0 : if (timeOut0_ptr !=3D NULL)
                           {
                           if (timeOut0_ptr->number =3D=3D numTimeOut)
                              {
                               free(timeOut0_ptr);
                               timeOut0_ptr =3D NULL;
                              }
                           }
                           break;
                  case 1 : if (timeOut1_ptr !=3D NULL)
                           {
                              if (timeOut1_ptr->number =3D=3D numTimeOut)
                              {
                                 free(timeOut1_ptr);
                                 timeOut1_ptr =3D NULL;
                              }
                           }
                           break;
                  case 2 : if (timeOut2_ptr !=3D NULL)
                           {
                              if (timeOut2_ptr->number =3D=3D numTimeOut)
                              {
                                   free(timeOut2_ptr);
                                   timeOut2_ptr =3D NULL;
                              }
                           }
                           break;
                  case 3 : if (timeOut3_ptr !=3D NULL)
                           {
                              if (timeOut3_ptr->number =3D=3D numTimeOut)
                              {
                                   free(timeOut3_ptr);
                                   timeOut3_ptr =3D NULL;
                              }
                           }
                           break;
                  case 4 : if (timeOut4_ptr !=3D NULL)
                           {
                              if (timeOut4_ptr->number =3D=3D numTimeOut)
                              {
                                   free(timeOut4_ptr);
                                   timeOut4_ptr =3D NULL;
                              }
                           }
                           break;
                  }
              }
          }
    }
    while(1)
    {
        sleep(10);
    }
	return NULL;
}

void* threadDisplay(void * arg) {
    volatile int i=3D0;
	volatile int result;
	display("Display thread\n");
	pthread_mutex_lock(&main_start_lock);
	while (!bMainStart)
	{
       pthread_cond_wait(&start_signal, &main_start_lock);
    }
    pthread_mutex_unlock(&main_start_lock);
	display("Display thread\n");

    while (i <=3D 200000) {
        result =3D func(&i);
        display("Display thread :%d \r",result);
    }
    display("End of display thread\n");
    return NULL;
}

/***********************************************************************/
void cleanup_upon_sig(int sig __attribute__((unused)))
{
     DeleteTimer(timeOut0_ptr->timer_h);
     DeleteTimer(timeOut1_ptr->timer_h);
     DeleteTimer(timeOut2_ptr->timer_h);
     exit(0);
}

int main(int argc, char** argv) {
    pthread_attr_t attr;
    pthread_mutexattr_t attr_proto;
    pthread_t p0;
    pthread_t p1;
    pthread_t p2;
    struct sched_param sch;

    // Stack & TabTImeOutptr creation
    StackCreation();

    signal(SIGINT, cleanup_upon_sig);
    signal(SIGTERM, cleanup_upon_sig);

    mlockall(MCL_CURRENT|MCL_FUTURE);

   	// mutex and sem initialisation
	pthread_cond_init(&start_signal, NULL);
    pthread_mutex_init(&main_start_lock, NULL);
    pthread_cond_init(&TimeOutEnd_signal, NULL);
    pthread_mutex_init(&timeOutEnd_lock, NULL);
    sem_init (&TimeOutWait_sem, 0,0);
    pthread_mutexattr_init(&attr_proto);
    pthread_mutexattr_setprotocol(&attr_proto,PTHREAD_PRIO_INHERIT);
    pthread_mutex_init(&lockDisplay, &attr_proto);

    pthread_attr_init(&attr);
    pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

    // TimeOutCreation thread creation
    sch.sched_priority =3D 85;
    pthread_attr_setschedparam(&attr, &sch);
    pthread_create(&p0, &attr, threadTimeOutEnd, NULL);

    // TimeOut thread creation
    sch.sched_priority =3D 80;
    pthread_attr_setschedparam(&attr, &sch);
    pthread_create(&p1, &attr, threadTimeOut, NULL);

	// Display thread creation
	sch.sched_priority =3D 70;
    pthread_attr_setschedparam(&attr, &sch);
    pthread_create(&p2, &attr, threadDisplay, NULL);

    pthread_attr_destroy(&attr);

    display("Main condition broadcast\n");
    // Start of all threads
    pthread_mutex_lock(&main_start_lock);
    bMainStart =3D true;
    pthread_cond_broadcast(&start_signal);
    pthread_mutex_unlock(&main_start_lock);

    while (1) {
        sleep(5);
    }

    return 0;
}

#########################################################################=
#########

Results on the console :

TimeOutCreation thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutCreation thread
TimeOut thread
Start of time out 1 - 5ms
Display thread
Start of time out 2 - 5ms
Start of time out 3 - 5ms
Display thread :8791		<---- the system crashed


I hope that you can help me. I will try to execute this program without
your patch to see what kernel traces I will have if the kernel crashes.
I wonder why my system is so unsteady...

Thanks a lot for your help.


