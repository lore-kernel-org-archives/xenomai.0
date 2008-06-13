Message-ID: <3380.62.39.72.60.1213367793.squirrel@domain.hid>
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
Date: Fri, 13 Jun 2008 16:36:33 +0200 (CEST)
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

thank you very much for your work.

I tried your Xenomai 2.4.4.

I began to patch a linux kernel 2.6.20.21 with the i386 adeos patch. I
would to know why you cancelled the i386 adeos patch for linux kernel
2.6.23 ?

So, with the 2.6.20.21, when I execute my test program, I hadn't got a bi=
g
improvement. There were always bugs.

Then, I patched a linux kernel 2.6.25 with the x86 adeos patch.
This time, there was a big improvement when I executed my test
program.But, occasionally, there was a program crash, without bug message=
s
in the kernel traces.
I added debug traces (calls to write function) in my program to understan=
d
why there was this crash. With theses new traces, I had a big crash of my
program execution, and the system is also crashed. (I must reboot my
system)
In this case, I had a Xenomai fatal message in the kernel traces.

To sum up my test program :

In the test program, there are three Xenomai thread :
threadTimeOutEnd (prio : 85): This thread waits the timeout end thanks to
a Semaphore (In the timeout end handler, the Semaphore is posted), and
warns threadTimeOut with a condvar broadcast. This thread calls display
function to debug the program.
threadTimeOut (prio : 80): Malloc memory space to create timeout. Set-up
timeouts of 500ms. Free memory space of achieved timeouts (This thread is
notified of timeout end with a condvar broadcasted by threadTimeOutEnd).
This thread must do the timeout end handler processing.This thread calls
display function to debug the program.
threadDisplay (prio : 70): Call display function in a loop. Normally, thi=
s
thread ends the test program and displays the stack of timeout end
numbers. (if necesserray, adjust the loop counter)

Sorry, my test program is a bit long
#########################################################################=
#######################

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

int StackReadOneElement(int ReadOne_ptr)
{
    int number;
    if ((ReadOne_ptr < 0) || (ReadOne_ptr >=3D STACKSIZE))
    {
        return 0;
    }
    number =3D Stack[ReadOne_ptr];
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
             exit(EXIT_FAILURE);
         }
      }
    }while (bErrWrite);
    if((err =3D pthread_mutex_unlock(&lockDisplay)) !=3D 0)
    {
        if(err !=3D EINTR)
        {
           printf("display : erreur pthread_mutex_unlock : %d,
%s\n",err,strerror(err));
           exit(EXIT_FAILURE);
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
     int err;
     bool bErrSettime =3D false;

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

    do
	{
      bErrSettime =3D false;
      if ((__real_timer_settime((timeOut->timer_h), 0,
                               &(timeOut->tmr_setting),NULL)) < 0)
      {
         err =3D errno;
         printf("StartTimeOut : erreur timer_settime : %d,
%s\n",err,strerror(err));
         if (err =3D=3D EINTR)
         {
              bErrSettime =3D true;
         }
      }
    }while (bErrSettime);
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

    unsigned char Message[200];

    while (1) {
    /*>>>>>********************************************/
    strcpy(Message,"threadTimeOutEnd thread : before sem_wait\n");
    write(2,(char *)Message,strlen((char *)Message));
    /********************************************<<<<<*/

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
       else exit(EXIT_FAILURE);
	  }
    }while (bSemWaitError);

    /*>>>>>********************************************/
    strcpy(Message,"threadTimeOutEnd thread : after sem_wait\n");
    write(2,(char *)Message,strlen((char *)Message));
    /********************************************<<<<<*/

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
                         exit(EXIT_FAILURE);
                    }
                    timeOut0_ptr->number =3D i;
                    i++;
                    display("0 : Start of time out %d - 500ms\n",
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
                         exit(EXIT_FAILURE);
                    }
                    timeOut1_ptr->number =3D i;
                    i++;
                    display("1 : Start of time out %d - 500ms\n",
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
                         exit(EXIT_FAILURE);
                    }
                    timeOut2_ptr->number =3D i;
                    i++;
                    display("2 : Start of time out %d - 500ms\n",
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
                         exit(EXIT_FAILURE);
                    }
                    timeOut3_ptr->number =3D i;
                    i++;
                    display("3 : Start of time out %d - 500ms\n",
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
                         exit(EXIT_FAILURE);
                    }
                    timeOut4_ptr->number =3D i;
                    i++;
                    display("4 : Start of time out %d - 500ms\n",
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
            display("TimeOut thread : bTimeOutEnd : %d\n", bTimeOutEnd);
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
    /*while(1) {
        sleep(10);
    }*/
    return NULL;
}

void* threadDisplay(void * arg) {
    volatile int i=3D0;
    volatile int result;
    int numTimeOut =3D 1;
    display("Display thread\n");
    check_pthread(pthread_mutex_lock(&main_start_lock));
    while (!bMainStart)
        check_pthread(pthread_cond_wait(&start_signal, &main_start_lock))=
;
    check_pthread(pthread_mutex_unlock(&main_start_lock));
    display("Display thread\n");

    while (i <=3D 120000) {
        result =3D func(&i);
        display("Display thread :%d \r",result);
    }
    display("----> End of display thread <----\n");

    display("Display thread: Reading number of achieved timeouts :\n");
    i=3D0;
    while(numTimeOut && (i<STACKSIZE))
    {
        numTimeOut=3DStackReadOneElement(i);
        if(numTimeOut)
        {
           display("[%d]:%d ",i ,numTimeOut);
        }
        i++;
        if(i=3D=3D10 || i=3D=3D20 || i=3D=3D30 || i=3D=3D40 || i=3D=3D50
                    || i=3D=3D60 || i=3D=3D70 || i=3D=3D80 || i=3D=3D90)
        {
            display("\n");
        }
    }
    display("\n");
    exit(0);
    /*while(1)
    {
        sleep(5);
    }*/
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
    exit(EXIT_FAILURE);
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


#########################################################################=
######

Here, this is a script, if you want to launch in a loop my test program
(my program executable name is testTimer12_corrected):

#!/bin/bash
Err=3D0
while [ "$Err" -eq 0 ];
do
{
   date
   ./testTimer12_corrected
   Err=3D$?
}
done


#########################################################################=
#########

Here this is the result of the debug traces :

TimeOutEnd thread
TimeOut thread
Display thread
Main condition broadcast
TimeOutEnd thread
threadTimeOutEnd thread : before sem_wait
TimeOut thread
0 : Start of time out 1 - 500ms
Display thread
1 : Start of time out 2 - 500ms
2 : Start of time out 3 - 500ms
3 : Start of time out 4 - 500ms
4 : Start of time out 5 - 500ms

...

0 : Start of time out 41 - 500ms
1 : Start of time out 42 - 500ms
2 : Start of time out 43 - 500ms
3 : Start of time out 44 - 500ms
Number of time-outs ends : 0
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
TimeOut thread : bTimeOutEnd : 1
Number of time-outs ends : 1
TimeOut40 ends
4 : Start of time out 45 - 500ms
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
threadTimeOutEnd thread : after sem_wait
TimeOut thread : bTimeOutEnd : 1
threadTimeOutEnd thread : before sem_wait
Number of time-outs ends : 2
TimeOut41 ends
Semaphore::Get - erreur sem_wait : errno :4 -> Interrupted system call
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
TimeOut42 ends
0 : Start of time out 46 - 500ms
1 : Start of time out 47 - 500ms
Number of time-outs ends : 2
TimeOut43 ends
TimeOut44 ends
2 : Start of time out 48 - 500ms
3 : Start of time out 49 - 500ms
threadTimeOutEnd thread : after sem_wait
threadTimeOutEnd thread : before sem_wait
TimeOut thread : bTimeOutEnd : 1
Number of time-outs ends : 1
TimeOut45 ends
4 : Start of time out 50 - 500ms
Display thread :92353            <--- the system crashes (I must reboot i=
t)


#########################################################################=
#########

Here this is the kernel traces :

       c70750f0 00000086 00300182 c70e1a20 ffffffff 00000001 c72ca800
c0274fec
       c7080650 c70e1090 00300182 c70e1a20 ffffffff 00000001 c014d9ca
00000200
       c7080650 00000000 c70750f0 c7080650 c71e77e0 00000033 00000000
c70e1150
Call Trace:
 [<c0274fec>] n_tty_receive_buf+0x51c/0x1270
 [<c014d9ca>] rpi_push+0x6a/0x420
 [<c01445a4>] xnpod_suspend_thread+0x424/0x4a0
 [<c014df7c>] rpi_update+0x1fc/0x230
 [<c014a1d7>] xnsynch_sleep_on+0x8e7/0xd10
 [<c014d159>] ppd_lookup+0x19/0x30
 [<c0153258>] pse51_mutex_timedlock_break+0x1f8/0x220
 [<c0161b9e>] __pthread_mutex_lock+0x4e/0x60
 [<c014f6d4>] losyscall_event+0xb4/0x170
 [<c013c5b2>] __ipipe_dispatch_event+0xa2/0x180
 [<c014f620>] losyscall_event+0x0/0x170
 [<c010cac0>] __ipipe_syscall_root+0x40/0xf0
 [<c0102eb9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Xenomai: fatal: Hardened thread threadTimeOut[4698] running in Linux
domain?! (status=3D0x300182, sig=3D1, prev=3Dgatekeeper/0[148])
 CPU  PID    PRI      TIMEOUT  STAT      NAME
>  0  0       80      0        00500080  ROOT
   0  4695     0      0        00300380  testTimer12_cor
   0  4697    85      0        00300182  threadTimeOutEnd
   0  4698    80      0        00300182  threadTimeOut
   0  4699    80      0        00300b80  threadDisplay
Master time base: clock=3D823018273704

       c70c3ecc 00000000 00000000 00000001 c7080650 c0104256 00000000
c0442211
       0000125a c70e1dec c014e3fd c043c6a0 c70c4000 0000125a 00300182
00000001
       c70752cc 00000094 c0584980 c013ce20 00000021 c013ce43 c013bb78
00000021
Call Trace:
 [<c0104256>] show_stack+0x36/0x50
 [<c014e3fd>] schedule_event+0x39d/0x850
 [<c013ce20>] rthal_apc_handler+0x0/0x30
 [<c013ce43>] rthal_apc_handler+0x23/0x30
 [<c013bb78>] __xirq_end+0x39/0x46
 [<c0102f28>] restore_nocheck_notrace+0x0/0xe
 [<c013ce20>] rthal_apc_handler+0x0/0x30
 [<c0106fd1>] native_sched_clock+0x61/0xb0
 [<c013c5b2>] __ipipe_dispatch_event+0xa2/0x180
 [<c014e060>] schedule_event+0x0/0x850
 [<c03dbeb6>] schedule+0x226/0x3b0
 [<c014fe6d>] gatekeeper_thread+0xad/0x140
 [<c03dbe48>] schedule+0x1b8/0x3b0
 [<c0111a40>] default_wake_function+0x0/0x10
 [<c014fdc0>] gatekeeper_thread+0x0/0x140
 [<c0127f42>] kthread+0x42/0x70
 [<c0127f00>] kthread+0x0/0x70
 [<c01032d7>] kernel_thread_helper+0x7/0x10
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#########################################################################=
######

There is a problem with threadTimeOut. Maybe, this thread runs in linux
domain and must come back in xenomai domain, but there is a

problem.

thank you.



