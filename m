Message-ID: <48CE8CE7.6030209@domain.hid>
Date: Mon, 15 Sep 2008 18:27:19 +0200
From: Harco Kuppens <h.kuppens@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040300080204080705010203"
Subject: [Xenomai-help] keyboard interrupt
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

This is a multi-part message in MIME format.
--------------040300080204080705010203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I tried to make a demo program which showed how that user space task 
waiting for an interrupt with rt_intr_wait automatically gets an 
increase in priority when the interrupt arrives so that it can be dealed 
with immediately.

In my program I use the keyboard interrupt IRQ=1. I have a priority task 
doing spinning for 3 seconds using 100% of theCPU. During this spinning 
I want to test if a low priority task can still get an interrupt from 
the keyboard by letting the end user type some letters on the keyboard when
My program works but only  the first interrupt gets caught when the high 
priority task is running. The following interrupts are only dealed with 
when the high priority task is done.
Probably because linux first has to finish the first interrupt?
I thought that the adeos pipeline kept  interrupts on a hold between 
xenomai and linux, until xenomai has done its work. But in my example it 
seems that the second interrupt has to wait for linux has finished 
handling the first interrupt. That is really something you don't want.

Is my interpretation wrong, or do I something wrong in my code?

best regards
Harco Kuppens

ps. my code is in the attachment



--------------040300080204080705010203
Content-Type: text/plain;
 name="keyboard.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="keyboard.c"

/* task getting high interrupt priority  */

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/io.h>

#include <native/task.h>
#include <native/timer.h>
#include <native/intr.h>

#include  <rtdk.h>

static  RT_INTR myinterrupt;


static RT_TASK IRQHandlerTask;
static RT_TASK SomeTask;


// duration activity in task
static RTIME some_task_activity = 3e9; // in nanoseconds (2900ms)

static int interrupts = 0;	/* number of served interrupts */

#define KEYBOARD_IRQ 1

//  Connect our ISR to the parallel port interrupt.
int setup_ISR(void) {

   // set handler
   // important to propagate interrupts to Linux!
  rt_intr_create(&myinterrupt,"myinterrupt",KEYBOARD_IRQ,I_PROPAGATE);


  // enable the IRQ in the adeos pipeline for Xenomai, so that after this we
  // can expect interupts really be coming!
  rt_printf("enable IRQ\n");
  rt_intr_enable(&myinterrupt);
  // note: by default is keyboard interrupt already enabled,
  //       but we add this line to be sure

  return 0; // no error
}

/*
   IRQHandler increases the interrupts count
 */
void IRQHandler (void *cookie)
{
     int p;
     int number_of_interrupts_waiting;
  RT_TASK *curtask;
  RT_TASK_INFO curtaskinfo;

  // inquire current task
  curtask=rt_task_self();
  rt_task_inquire(curtask,&curtaskinfo);
  rt_printf("Task prio : %d \n", curtaskinfo.cprio);     
  //rt_printf("Task status : %u \n", curtaskinfo.status);     

  for (;;) {
        /* Wait for the next interrupt */
        number_of_interrupts_waiting = rt_intr_wait(&myinterrupt,TM_INFINITE);
        interrupts++;
        rt_printf("at interrupt : interrupts=%d\n",interrupts);
        rt_task_inquire(curtask,&curtaskinfo);
        rt_printf("Task prio : %d \n", curtaskinfo.cprio);     
  }
}

// the some_task Task does some spinning at a high priority
// during the execution of this task the user should press some keys
// at the keyboard to see if the IRQhandler task with lower priority
// will interrupt this task when waiting for an interrupt using rt_intr_wait
void some_task (void *cookie)
{
    int i;

    rt_printf("at start some task : interrupts=%d\n",interrupts);
    rt_timer_spin(some_task_activity);
    rt_printf("at end some task : interrupts=%d\n",interrupts);
   
    return;
}

//startup code
void startup()
{
  int retval;


  rt_printf("start\n");
  rt_timer_set_mode(0);// set clock tick to nanoseconds

  /* setup interupt handler */
  retval=setup_ISR();
  if (retval) {
    rt_printf("\n\n stopped program : problems configuring interrupt handler \n\n");
    return;
  }
  // handler with average priority
  rt_task_create(&IRQHandlerTask, "IRQHandlerTask", 0, 50, 0);
  rt_task_start(&IRQHandlerTask, &IRQHandler, NULL);
  // create some other task with a much higher priority than irq handler task!
  rt_task_create(&SomeTask, "SomeTask", 0, 70, 0);
  rt_task_start(&SomeTask, &some_task, NULL);

}

void init_xenomai() {
  /* Avoids memory swapping for this program */
  mlockall(MCL_CURRENT|MCL_FUTURE);

  /* Perform auto-init of rt_print buffers if the task doesn't do so */
  rt_print_auto_init(1);
}

int main(int argc, char* argv[])
{

  sleep(1);
  printf("\nType CTRL-C to end this program\n\n" );
  printf("\nPress some keys to generate interrupts\n" );

  // code to set things to run xenomai
  init_xenomai();

  //startup code
  startup();

  // wait for CTRL-c is typed
  pause();
}



--------------040300080204080705010203--

