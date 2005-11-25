Message-ID: <001f01c5f1a6$cffd8250$1000000a@domain.hid>
From: "Hans-J. Ude" <ude@domain.hid>
Date: Fri, 25 Nov 2005 10:58:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Interrupt processing crashes in semTake
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

I'm porting an vxWorks application to Xenomai at the moment. When it comes
to interrupt handling, there is nothing in the vx skin to handle that (did i
overlook something?). First I've tried to handle that down in the xenomai
layer but problems occured and someone advised me to use a native interrupt
task using rt_intr_wait. I did so but the program segfaults after a minute
or so. I've put a sigsegv handler with a stack backtrace function into the
code. That shows the crash happens in the internals of semTake. Is it
problematic to make skin calls (semGive in my case) from inside the native
irq handler? Is there a bug somewhere in UVM or the test program or settings
or in other words: how are interrups handled properly from the vxWorks skin?

I've tracked the problem down to a test program which is appended to this
mail. I set up the irq number by #define to the irq of my network card. Then
made traffic by copying a large amount of files to the target system. After
about 30000 interrupts the crash happens most times but this value ranges
from about 1000 to 50000.

No clue what could be wrong. I'm using kernel 2.6.13 and xenomai 2.0.1 with
the included ipipe patch on a PIImmx running at 266 Mhz.

The backtrace function is the only debugging function i have since remote
debugging with gdb/gdbserver is still not working properly, but i'm gonna
describe that in detail in anorter post. Here comes the program:

TIA,
Hans

P.S.: Why is root_thread_exit() never called?

/********************** TOP OF FILE *********************/
/* irqtest.c */

#include <native/task.h>
#include <native/intr.h>
#include <vxworks/vxworks.h>
#include <execinfo.h>


// Set this value to the IRQ number you want to monitor
// The network card is a good candidate here
#define TEST_IRQ  9

#define VX_STACKSIZE 8192
#define VX_PRIO_HIGH 10
#define VX_PRIO_MID  100
#define VX_PRIO_LOW  150

void T_vxMain();
void T_irqClient();
void T_irqInfo();

void print_trace (void);
void sigsegv_handler(int sig);

int  semCount;
SEM_ID semIrq;

#define RCC_IRQ_STKSIZE  0 // default stacksize
#define RCC_IRQ_TASKPRIO 99 // highest RT priority
#define RCC_IRQ_TASKMODE 0 // no flags

int  irq_start(int irq);
void irq_stop();
void irq_server(void *cookie);

RT_INTR intr_obj;
RT_TASK intr_task;

/************************** UVM section *****************************/
/********************************************************************/
int root_thread_init()
{
 signal(SIGSEGV,sigsegv_handler);

 taskSpawn ("T_vxMain", VX_PRIO_LOW, VX_FP_TASK, VX_STACKSIZE,
      (FUNCPTR) T_vxMain, 0,0,0,0,0,0,0,0,0,0);
 return 0;
}

void root_thread_exit()
{
 printf("root_thread_exit() called\n");
 irq_stop();
}

/********************************************************************/
void T_vxMain()
{
 semIrq = semBCreate(SEM_Q_PRIORITY, SEM_EMPTY);
// sysClkRateSet(1000); // 1 ms

 taskSpawn ("T_irqClient", VX_PRIO_HIGH, VX_FP_TASK, VX_STACKSIZE,
      (FUNCPTR) T_irqClient, 0,0,0,0,0,0,0,0,0,0);

 taskDelay(500);
 int err = irq_start(TEST_IRQ);
 if (err)
 {
  irq_stop();
  exit(err);
 }

 taskSpawn ("T_irqInfo", VX_PRIO_MID, VX_FP_TASK, VX_STACKSIZE,
      (FUNCPTR) T_irqInfo, 0,0,0,0,0,0,0,0,0,0);
 taskSuspend(0);
}

/********************************************************************/
void T_irqClient()
{
 while(1)
 {
  semTake(semIrq, WAIT_FOREVER);
  ++semCount;
 }
}

/********************************************************************/
void T_irqInfo()
{
 RT_INTR_INFO info;
 int runs = 0;

 while(1)
 {
  rt_intr_inquire(&intr_obj, &info);
  printf ("%d runs, IRQ count: %ld, semCount: %d\n",
     ++runs, info.hits, semCount);
  taskDelay(1000);
 }
}

/************************* Debugging section ************************/
/********************************************************************/
/* Obtain a backtrace and print it to stdout. */
void print_trace (void)
{
       void *array[10];
       size_t size;
       char **strings;
       size_t i;

       size = backtrace (array, 10);
       strings = backtrace_symbols (array, size);
       printf ("Obtained %zd stack frames.\n", size);

       for (i = 0; i < size; i++)
          printf ("%s\n", strings[i]);

       free (strings);
}

/********************************************************************/
void sigsegv_handler(int sig)
{
 print_trace ();
 printf ("\nBad incident happened in Task: %s\n",
    taskName(taskIdSelf()));
  irq_stop();
 signal(SIGSEGV,SIG_DFL);
}

/************************* Interrupt section ************************/
/********************************************************************/
int irq_start(int irq)
{
 int err = rt_intr_create(&intr_obj, irq, I_PROPAGATE);

 if (! err)
 {
  err = rt_task_create(&intr_task, "T_irqServer", RCC_IRQ_STKSIZE,
       RCC_IRQ_TASKPRIO, RCC_IRQ_TASKMODE);
  if (! err)
  {
   err = rt_task_start ( &intr_task, &irq_server, NULL);
   err = rt_intr_enable (&intr_obj);
  }
  else
  {
   printf ("Error rt_task_start() = %d\n",err);
   return err;
  }
 }
 else
 {
  printf ("Error rt_intr_create(%d) = %d\n", irq, err);
  return err;
 }
 return 0;
}

void irq_stop()
{
 rt_task_delete(&intr_task);
 rt_intr_delete(&intr_obj);
}

void irq_server(void *cookie)
{
 while(1)
 {
  if (rt_intr_wait(&intr_obj, TM_INFINITE) > 0)
  {
   /* rt_intr_enable(&intr_obj); */
   semGive (semIrq);
  }
 }
}

/******************** Compiler and linker settings ******************/
/*
gcc -DDEBUG -D__XENO__ -D__XENO_UVM__ -D_REENTRANT -D_GNU_SOURCE
-I/opt/etx/xenomai/include -O0 -g3 -Wall -c
-fmessage-length=0 -oirqtest.o ../irqtest.c

gcc -L/opt/etx/xenomai/lib -L/xchain/486/i486-pc-linux-gnu/lib
-u__xeno_skin_init -rdynamic -oirqtest ./irqtest.o
-lpthread -lnative -lvxworks -lnucleus -luvm
*/
/******************** BOTTOM OF FILE *********************/


