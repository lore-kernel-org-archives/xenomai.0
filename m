Message-ID: <12142.81.252.86.91.1211467896.squirrel@domain.hid>
In-Reply-To: <18484.28025.505865.374746@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
	<2336.81.252.86.91.1211379896.squirrel@domain.hid>
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid>
	<15059.81.252.86.91.1211386718.squirrel@domain.hid>
	<18484.28025.505865.374746@domain.hid>
Date: Thu, 22 May 2008 16:51:36 +0200 (CEST)
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

Thanks to a serial console, I obtained the kernel traces before the crash
when I executed Cyclictest.
However, I could not have the same error : kernel panic - not syncing:
Aiee, killing interrupt handler. The system crashed like before, without
error message.

kernel traces :

#########################################################################=
#######################

I-pipe: Detected illicit call from domain 'Xenomai'
        into a service reserved for domain 'Linux' and below.
 [<c0102f2e>] show_trace_log_lvl+0x1f/0x34
 [<c0103b32>] show_trace+0x17/0x19
 [<c0103b87>] dump_stack+0x1a/0x1c
 [<c01323ab>] ipipe_check_context+0x70/0x7b
 [<c010f5a7>] sub_preempt_count+0x18/0x9f
 [<c036d91c>] _spin_unlock_irq+0x1c/0x31
 [<c010fbd5>] ipipe_reenter_root+0x3c/0xb6
 [<c0140667>] xnshadow_relax+0xe8/0x118
 [<c0140bf9>] hisyscall_event+0x1d9/0x226
 [<c0133806>] __ipipe_dispatch_event+0xde/0x1c2
 [<c01095f4>] __ipipe_syscall_root+0x74/0x105
 [<c01027b9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I-pipe tracer log (100 points):
   +  func                    0 ipipe_trace_panic_freeze+0x9
(ipipe_check_context+0x39)
   +  func                   -1 ipipe_check_context+0xc
(sub_preempt_count+0x18)
   +  func                   -1 sub_preempt_count+0xc (_spin_unlock_irq+0=
x1c)
 | +  end     0x80000000     -2 __ipipe_unstall_root+0x44
(_spin_unlock_irq+0x12)
 | +  func                   -3 __ipipe_sync_stage+0xe
(__ipipe_unstall_root+0x33)
 | +  begin   0x80000000     -4 __ipipe_unstall_root+0x1a
(_spin_unlock_irq+0x12)
   +  func                   -5 __ipipe_unstall_root+0x8
(_spin_unlock_irq+0x12)
   +  func                   -5 debug_locks_off+0x8 (spin_bug+0x17)
   +  func                   -6 spin_bug+0xe (_raw_spin_unlock+0x58)
   +  func                   -7 debug_locks_off+0x8 (spin_bug+0x17)
   +  func                   -8 spin_bug+0xe (_raw_spin_unlock+0x30)
   +  func                   -9 _raw_spin_unlock+0x9 (_spin_unlock_irq+0x=
d)
   +  func                  -10 _spin_unlock_irq+0x8
(ipipe_reenter_root+0x3c)
   +  func                  -10 ipipe_reenter_root+0xe (xnshadow_relax+0x=
e8)
 | +  end     0x80000000    -11 __ipipe_restore_pipeline_head+0xa7
(xnshadow_relax+0xc7)
 | #  func                  -12 __ipipe_restore_pipeline_head+0xd
(xnshadow_relax+0xc7)
 | #  func                  -13 xnpod_suspend_thread+0xe
(xnshadow_relax+0xa3)
 | #  [  173] gatekeep 0    -16 xnpod_schedule_runnable+0x47 (rpi_push+0x=
192)
 | #  func                  -17 xnpod_schedule_runnable+0xe (rpi_push+0x1=
92)
 | #  func                  -19 rpi_push+0xe (xnshadow_relax+0x6b)
 | #  func                  -21 __ipipe_set_irq_pending+0xb
(__ipipe_schedule_irq+0x6e)
 | #  func                  -22 __ipipe_schedule_irq+0xe
(rthal_apc_schedule+0x64)
 | #  func                  -23 rthal_apc_schedule+0xa
(schedule_linux_call+0x99)
 | #  func                  -23 schedule_linux_call+0xe (xnshadow_relax+0=
x61)
 | +  begin   0x80000000    -24 xnshadow_relax+0x36 (hisyscall_event+0x1d=
9)
   +  func                  -25 xnshadow_relax+0xe (hisyscall_event+0x1d9=
)
   +  func                  -26 hisyscall_event+0xe
(__ipipe_dispatch_event+0xde)
 | +  end     0x80000001    -27 __ipipe_dispatch_event+0xcf
(__ipipe_syscall_root+0x74)
 | +  begin   0x80000001    -28 __ipipe_dispatch_event+0x2c
(__ipipe_syscall_root+0x74)
   +  func                  -29 __ipipe_dispatch_event+0xe
(__ipipe_syscall_root+0x74)
   +  func                  -30 __ipipe_syscall_root+0xa (system_call+0x2=
9)
 | +  end     0x80000001    -86 __ipipe_dispatch_event+0x1ad
(__ipipe_syscall_root+0x74)
 | +  begin   0x80000001    -87 __ipipe_dispatch_event+0x101
(__ipipe_syscall_root+0x74)
 | +  end     0x80000000    -89 __ipipe_restore_pipeline_head+0xa7
(pthread_setschedparam+0x16b)
 | #  func                  -90 __ipipe_restore_pipeline_head+0xd
(pthread_setschedparam+0x16b)
 | #  [ 2981] lt-cycli 0    -91 xnpod_schedule+0x92
(pthread_setschedparam+0x145)
 | #  func                  -92 xnpod_schedule+0xe
(pthread_setschedparam+0x145)
 | #  func                  -93 xnpod_set_thread_mode+0xe
(pthread_setschedparam+0x140)
 | #  [ 2981] lt-cycli 0    -95 xnpod_resume_thread+0x66
(xnpod_renice_thread_inner+0x92)
 | #  func                  -96 xnpod_resume_thread+0xe
(xnpod_renice_thread_inner+0x92)
 | #  func                  -97 xnpod_renice_thread_inner+0xe
(xnpod_renice_thread+0x12)
 | #  func                  -98 xnpod_renice_thread+0x8
(pthread_setschedparam+0x133)
 | +  begin   0x80000000   -100 pthread_setschedparam+0x27
(__pthread_setschedparam+0x1cd)
   +  func                 -101 pthread_setschedparam+0xe
(__pthread_setschedparam+0x1cd)
 | +  end     0x80000000   -102 __ipipe_restore_pipeline_head+0xa7
(__pthread_find+0xf9)
 | #  func                 -103 __ipipe_restore_pipeline_head+0xd
(__pthread_find+0xf9)
 | +  begin   0x80000000   -104 __pthread_find+0x89
(__pthread_setschedparam+0x59)
   +  func                 -105 __pthread_find+0xe
(__pthread_setschedparam+0x59)
   +  func                 -106 __pthread_setschedparam+0xe
(losyscall_event+0x9e)
 | +  end     0x80000000   -107 ipipe_unstall_pipeline_head+0x6a
(xnshadow_harden+0x158)
 | #  begin   0x80000000   -108 ipipe_unstall_pipeline_head+0x1a
(xnshadow_harden+0x158)
   #  func                 -108 ipipe_unstall_pipeline_head+0x8
(xnshadow_harden+0x158)
   #  func                 -111 xnpod_switch_fpu+0xb (xnshadow_harden+0xc=
9)
 | #  end     0x80000000   -112 __sched_text_start+0x2dd
(xnshadow_harden+0x9f)
 | #  func                 -113 debug_smp_processor_id+0xb (__switch_to+0=
x26)
 | #  func                 -114 __switch_to+0xe (__sched_text_start+0x2b9=
)
 | #  func                 -115 debug_smp_processor_id+0xb
(xnpod_schedule+0x6d3)
 | #  [ 2967] lt-cycl -1   -116 xnpod_schedule+0x92
(xnpod_schedule_handler+0x15)
 | #  func                 -117 xnpod_schedule+0xe
(xnpod_schedule_handler+0x15)
 | #  func                 -118 xnpod_schedule_handler+0x8 (__virq_end+0x=
2a)
 | +  func                 -119 __ipipe_sync_stage+0xe
(ipipe_suspend_domain+0x80)
 | +  func                 -120 ipipe_suspend_domain+0xe
(__ipipe_walk_pipeline+0x57)
 |   +func                 -121 __ipipe_walk_pipeline+0xa
(__ipipe_restore_pipeline_head+0x96)
 | * +func                 -122 __ipipe_restore_pipeline_head+0xd
(gatekeeper_thread+0x145)
 | * +func                 -123 __ipipe_set_irq_pending+0xb
(__ipipe_dispatch_wired+0x5f)
 | * +func                 -124 __ipipe_dispatch_wired+0xb
(__ipipe_handle_irq+0x7c)
 | * +func                 -125 __ipipe_handle_irq+0xe
(ipipe_trigger_irq+0x92)
 | * +func                 -126 memcpy+0xe (ipipe_trigger_irq+0x8d)
 | * +func                 -127 ipipe_trigger_irq+0xe (xnpod_schedule+0x2=
8)
 | * +func                 -128 xnpod_schedule+0xe (gatekeeper_thread+0x1=
1d)
 | * +func                 -129 disengage_irq_shield+0xb
(gatekeeper_thread+0x118)
 | * +[ 2981] lt-cycl 99   -131 xnpod_resume_thread+0x66
(gatekeeper_thread+0x113)
 | * +func                 -132 xnpod_resume_thread+0xe
(gatekeeper_thread+0x113)
 |   +begin   0x80000000   -133 gatekeeper_thread+0xeb (kthread+0x3e)
 |   +end     0x80000000   -134 __ipipe_restore_pipeline_head+0xa7
(rpi_pop+0x1c1)
 | * +func                 -135 __ipipe_restore_pipeline_head+0xd
(rpi_pop+0x1c1)
 |   +begin   0x80000000   -136 rpi_pop+0x22 (gatekeeper_thread+0xd9)
     +func                 -137 rpi_pop+0xe (gatekeeper_thread+0xd9)
     +func                 -138 kthread_should_stop+0x8
(gatekeeper_thread+0xbc)
     +func                 -139 ipipe_check_context+0xc
(sub_preempt_count+0x18)
     +func                 -140 sub_preempt_count+0xc
(__sched_text_start+0x367)
     +func                 -141 ipipe_check_context+0xc
(sub_preempt_count+0x18)
     +func                 -142 sub_preempt_count+0xc (_spin_unlock_irq+0=
x1c)
 |   +end     0x80000000   -142 __ipipe_unstall_root+0x44
(_spin_unlock_irq+0x12)
 |   #begin   0x80000000   -143 __ipipe_unstall_root+0x1a
(_spin_unlock_irq+0x12)
     #func                 -144 __ipipe_unstall_root+0x8
(_spin_unlock_irq+0x12)
     #func                 -145 _raw_spin_unlock+0x9 (_spin_unlock_irq+0x=
d)
     #func                 -146 _spin_unlock_irq+0x8
(__sched_text_start+0x313)
 |   #end     0x80000000   -147 __sched_text_start+0x2dd
(gatekeeper_thread+0xb7)
 |   #func                 -149 debug_smp_processor_id+0xb (__switch_to+0=
x26)
 |   #func                 -150 __switch_to+0xe (__sched_text_start+0x2b9=
)
 |   #begin   0x80000000   -151 __sched_text_start+0x1b8
(xnshadow_harden+0x9f)
 |   #end     0x80000001   -152 __ipipe_dispatch_event+0x1ad
(__sched_text_start+0x1a6)
 |   #begin   0x80000001   -153 __ipipe_dispatch_event+0x101
(__sched_text_start+0x1a6)
 |   #end     0x80000000   -154 __ipipe_restore_pipeline_head+0xa7
(schedule_event+0x3a7)
 | * #func                 -155 __ipipe_restore_pipeline_head+0xd
(schedule_event+0x3a7)
 |   #begin   0x80000000   -156 schedule_event+0x22e
(__ipipe_dispatch_event+0xde)
     #func                 -157 schedule_event+0xe
(__ipipe_dispatch_event+0xde)
 |   #end     0x80000001   -158 __ipipe_dispatch_event+0xcf
(__sched_text_start+0x1a6)
 |   #begin   0x80000001   -159 __ipipe_dispatch_event+0x2c
(__sched_text_start+0x1a6)

#########################################################################=
#############################


I also tried without your patch, and when I stopped Cyclictest, there was
no problem !



Morever, I tried one of my test program about time-out end. (without your
patch)
In order to know if my system is really crash, I ran the timeout test
program and also an another test program in which the highest priority
thread is created. this last one calls printf function and sleeps.
So, when the execution of time-out test pogram crashed, I hoped that the
highest priority thread still ran.

Sometimes, the execution of time-out test pogram crashes but the system i=
s
OK, and the Highest priority thread runs.
But, I ve got also this case : the execution of time-out test pogram
crashes and the system is crashed. In this case, I ve got bug traces
(scheduling while atomic). I must reboot my system.


HighestPriorityThread.C

#########################################################################=
################

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

// Thread start
pthread_mutex_t start_thread_lock;

void* threadHighPriority(void * arg) {

    if ((pthread_mutex_lock(&start_thread_lock)) < 0)
    {
        printf("pthread_mutex_lock error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    if ((pthread_mutex_unlock(&start_thread_lock)) < 0)
    {
        printf("pthread_mutex_unlock error - errno : %d  -> %s\n", errno,
strerror(errno));
    }

    while(1)
    {
        printf("ThreadHighPriority : sleep 30s\n");
        sleep(30);
    }
	return NULL;
}

/***********************************************************************/
int main(int argc, char** argv) {
    pthread_attr_t attr;
    pthread_t p1;
    struct sched_param sch;

    mlockall(MCL_CURRENT|MCL_FUTURE);

   	// mutex and sem initialisation
    pthread_mutex_init(&start_thread_lock, NULL);

    pthread_attr_init(&attr);
    pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

    // TimeOut thread creation
    sch.sched_priority =3D 99;
    pthread_attr_setschedparam(&attr, &sch);

    pthread_mutex_lock(&start_thread_lock);
    pthread_create(&p1, &attr, threadHighPriority, NULL);
    pthread_attr_destroy(&attr);
    pthread_mutex_unlock(&start_thread_lock);

    while (1) {
        sleep(5);
    }

    return 0;
}

#########################################################################=
##############


testTimer10.C (this program uses sem_wait without your patch but there is
a management)

#########################################################################=
##############

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
#include <rtdk.h>  // rt_printf()

#define NB_PTR_TEMPO 3  // 5 time-out max
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
sem_t  TimeOut_sem;

// Stack mutex
pthread_mutex_t Stack_lock;

// Display file
FILE *file =3D NULL;

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
	number =3D Stack[Read_ptr];
	return number;
}

int StackReadValid (void)
{
    Read_ptr++;
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

     if ((sem_post(&TimeOut_sem)) =3D=3D -1)
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
        printf("sigaction error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    (timeOut->sig_spec).sigev_notify =3D SIGEV_SIGNAL;
    (timeOut->sig_spec).sigev_signo =3D SIGRTMIN;
    (timeOut->sig_spec).sigev_value.sival_ptr =3D timeOut;

    while (timer_create(CLOCK_REALTIME, &(timeOut->sig_spec),
&(timeOut->timer_h)) < 0)
    {
        printf("timer_create error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

    (timeOut->tmr_setting).it_value.tv_sec =3D nb_Sec;
    (timeOut->tmr_setting).it_value.tv_nsec =3D nb_nSec;
    (timeOut->tmr_setting).it_interval.tv_sec =3D 0;
    (timeOut->tmr_setting).it_interval.tv_nsec =3D 0;

    while (timer_settime((timeOut->timer_h), 0,
&(timeOut->tmr_setting),NULL) < 0)
    {
       printf("timer_settime error - errno : %d  -> %s\n",errno,
strerror(errno));
    }

}

/************************** Threads ********************************/
void* threadTimeOut(void * arg) {
    int i=3D1;
    int j, k, NbTimeOut, numTimeOut, err;
    int NbSem =3D 0;
    bool bFirstTimeOut =3D false;
    bool bEndTimeOutExec =3D false;

    timeOut0_ptr =3D timeOut1_ptr =3D timeOut2_ptr =3D timeOut3_ptr =3D
timeOut4_ptr =3D NULL;

	display("TimeOut thread\n");
	while (!bMainStart)
	{
       pthread_mutex_lock(&main_start_lock);
       pthread_cond_wait(&start_signal, &main_start_lock);
       pthread_mutex_unlock(&main_start_lock);
    }
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

          bFirstTimeOut =3D true;
          while (bFirstTimeOut =3D=3D true || NbSem > 0)
          {
             bFirstTimeOut =3D false;

             while((sem_wait(&TimeOut_sem)) < 0)
             {
                 printf("sem_wait error - errno : %d  -> %s\n",errno,
strerror(errno));
             }

             numTimeOut =3D StackRead();
             if (numTimeOut)
             {
                StackReadValid();
                printf("TimeOut%d ends\n", numTimeOut);
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
                                if (timeOut1_ptr->number =3D=3D numTimeOu=
t)
                                {
                                   free(timeOut1_ptr);
                                   timeOut1_ptr =3D NULL;
                                }
                             }
                             break;
                    case 2 : if (timeOut2_ptr !=3D NULL)
                             {
                                if (timeOut2_ptr->number =3D=3D numTimeOu=
t)
                                {
                                     free(timeOut2_ptr);
                                     timeOut2_ptr =3D NULL;
                                }
                             }
                             break;
                    case 3 : if (timeOut3_ptr !=3D NULL)
                             {
                                if (timeOut3_ptr->number =3D=3D numTimeOu=
t)
                                {
                                     free(timeOut3_ptr);
                                     timeOut3_ptr =3D NULL;
                                }
                             }
                             break;
                    case 4 : if (timeOut4_ptr !=3D NULL)
                             {
                                if (timeOut4_ptr->number =3D=3D numTimeOu=
t)
                                {
                                     free(timeOut4_ptr);
                                     timeOut4_ptr =3D NULL;
                                }
                             }
                             break;
                    }
                }
                if ((sem_getvalue(&TimeOut_sem,&NbSem)) =3D=3D -1)
                {
                   printf("sem_getvalue error - errno : %d  ->
%s\n",errno, strerror(errno));
                }
             }
             else  NbSem =3D 0;
          }
    }
    //printf("End of timeOut thread\n");
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
	while (!bMainStart)
	{
         pthread_mutex_lock(&main_start_lock);
         pthread_cond_wait(&start_signal, &main_start_lock);
         pthread_mutex_unlock(&main_start_lock);
    }
	display("Display thread\n");

    while (i <=3D 20000) {
        result =3D func(&i);
        display("Display thread :%d \r",result);
    }
    display("End of display thread\n");
    return NULL;
}

/***********************************************************************/
void cleanup_upon_sig(int sig __attribute__((unused)))
{
     //fclose(file);
     DeleteTimer(timeOut0_ptr->timer_h);
     DeleteTimer(timeOut1_ptr->timer_h);
     DeleteTimer(timeOut2_ptr->timer_h);
     exit(0);
}

int main(int argc, char** argv) {
    pthread_attr_t attr;
    pthread_mutexattr_t attr_proto;
    pthread_t p1;
    pthread_t p2;
    struct sched_param sch;

    // rt_printf initialisation
    rt_print_auto_init(1);

    // Stack creation
    StackCreation();

    signal(SIGINT, cleanup_upon_sig);
    signal(SIGTERM, cleanup_upon_sig);

    mlockall(MCL_CURRENT|MCL_FUTURE);

   	// mutex and sem initialisation
	pthread_cond_init(&start_signal, NULL);
    pthread_mutex_init(&main_start_lock, NULL);
    sem_init (&TimeOut_sem, 0,0);
    pthread_mutexattr_init(&attr_proto);
    pthread_mutexattr_setprotocol(&attr_proto,PTHREAD_PRIO_INHERIT);
    pthread_mutex_init(&lockDisplay, &attr_proto);

    pthread_attr_init(&attr);
    pthread_attr_setinheritsched(&attr,PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

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
########

kernel traces :

#########################################################################=
########

BUG: scheduling while atomic: testTimer10/0x00000002/2854
 [<c0102f2e>] show_trace_log_lvl+0x1f/0x34
 [<c0103b32>] show_trace+0x17/0x19
 [<c0103b87>] dump_stack+0x1a/0x1c
 [<c010f9dd>] __schedule_bug+0x48/0x4a
 [<c036b536>] __sched_text_start+0x8e/0x381
 [<c0140816>] xnshadow_harden+0x9f/0x167
 [<c0140957>] losyscall_event+0x79/0x142
 [<c0133806>] __ipipe_dispatch_event+0xde/0x1c2
 [<c01095f4>] __ipipe_syscall_root+0x74/0x105
 [<c01027b9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: scheduling while atomic: testTimer10/0x00000002/2854
 [<c0102f2e>] show_trace_log_lvl+0x1f/0x34
 [<c0103b32>] show_trace+0x17/0x19
 [<c0103b87>] dump_stack+0x1a/0x1c
 [<c010f9dd>] __schedule_bug+0x48/0x4a
 [<c036b536>] __sched_text_start+0x8e/0x381
 [<c0140816>] xnshadow_harden+0x9f/0x167
 [<c0140957>] losyscall_event+0x79/0x142
 [<c0133806>] __ipipe_dispatch_event+0xde/0x1c2
 [<c01095f4>] __ipipe_syscall_root+0x74/0x105
 [<c01027b9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: scheduling while atomic: testTimer10/0x00000002/2854
 [<c0102f2e>] show_trace_log_lvl+0x1f/0x34
 [<c0103b32>] show_trace+0x17/0x19
 [<c0103b87>] dump_stack+0x1a/0x1c
 [<c010f9dd>] __schedule_bug+0x48/0x4a
 [<c036b536>] __sched_text_start+0x8e/0x381
 [<c0140816>] xnshadow_harden+0x9f/0x167
 [<c0140957>] losyscall_event+0x79/0x142
 [<c0133806>] __ipipe_dispatch_event+0xde/0x1c2
 [<c01095f4>] __ipipe_syscall_root+0x74/0x105
 [<c01027b9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: scheduling while atomic: testTimer10/0x00000002/2854
 [<c0102f2e>] show_trace_log_lvl+0x1f/0x34
 [<c0103b32>] show_trace+0x17/0x19
 [<c0103b87>] dump_stack+0x1a/0x1c
 [<c010f9dd>] __schedule_bug+0x48/0x4a
 [<c036b536>] __sched_text_start+0x8e/0x381
 [<c0140816>] xnshadow_harden+0x9f/0x167
 [<c0140957>] losyscall_event+0x79/0x142
 [<c0133806>] __ipipe_dispatch_event+0xde/0x1c2
 [<c01095f4>] __ipipe_syscall_root+0x74/0x105
 [<c01027b9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: scheduling while atomic: testTimer10/0x00000002/2854
 [<c0102f2e>] show_trace_log_lvl+0x1f/0x34
 [<c0103b32>] show_trace+0x17/0x19
 [<c0103b87>] dump_stack+0x1a/0x1c
 [<c010f9dd>] __schedule_bug+0x48/0x4a
 [<c036b536>] __sched_text_start+0x8e/0x381
 [<c0140816>] xnshadow_harden+0x9f/0x167
 [<c0140957>] losyscall_event+0x79/0x142
 [<c0133806>] __ipipe_dispatch_event+0xde/0x1c2
 [<c01095f4>] __ipipe_syscall_root+0x74/0x105
 [<c01027b9>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#########################################################################=
#######

I don't succeed to understand these bug traces. Could you help me, please=
?
I think that a thread must be preempted or must be in hold whereas it
should be in execution.

thanks.



