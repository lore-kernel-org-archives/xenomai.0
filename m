Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 7 Feb 2006 12:11:59 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E00430BC@EINT11.einet.ad.eivd.ch>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
Subject: [Xenomai-core] Watchdog/Interrupt management
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hi all,

I've a - probably small ;-) - issue regarding the way how the watchdog =
and interrupt management are working together.
I'd like to implement a watchdog in a task to ensure that a task is well =
alive at periodic interval. For doing some tests, I've
implemented a small ISR which interceipts the keyboard interrupts (IRQ =
1). The ISR is simply doing some busy wait burning CPU time,
but with a delay greater than the task period.
I assume that the ISR locks the rescheduling procedure as it is stated =
in the API doc (BTW; many thanks for having solved the doc issue).
So, the task switching is temporarly suspended and the watchdog should =
raise up an alarm after the ISR has been completed, right?
It doesn't.
I've attached the code below (I've removed the function return check for =
readibility reasons, but all objects are fine).

Another question:  the ISR is called on behalf of the interrupted stack =
context: does it mean that the ISR always runs in the stack context of =
the highest priority task, i.e. the running task (assume no inversion =
priority), or could it in some cases the kernel stack context (if ADEOS =
is currently doing some interruptible stuff..)

Many thanks for your feedback.

Cheers
Daniel


-----------------------------------------------------
#include <native/task.h>
#include <native/intr.h>
#include <native/alarm.h>

#define STACK_SIZE 8192
#define MS         1000000

RT_INTR isrDesc;
RT_TASK highPrioTask;
RT_ALARM alarm;

int isrKbdHandler(struct xnintr* _idesc) {

  printk("#IRQKeyb\n\n");

  rt_timer_spin(100*MS); // Arg. in ns
  return RT_INTR_CHAINED;
}

void __exit cleanup_module (void) {

  rt_intr_delete(&isrDesc);
  rt_task_delete(&highPrioTask);
  rt_alarm_delete(&alarm);

  printk("Bye bye!\n");
}

void alarmHandler(RT_ALARM *alarmDesc, void *cookie) {
  printk("#ALERT:\n\n");
}

void periodicTaskHigh(void *cookie) {

  while (1) {
    rt_alarm_start(&alarm, 51, TM_INFINITE);
    rt_task_wait_period();
  }
}

int __init init_module (void) {

  rt_timer_set_mode(MS);   /* So, one tick will be equal to 1 ms */
  rt_intr_create(&isrDesc, 1, isrKbdHandler, NULL);
  rt_alarm_create(&alarm, "ALARM", alarmHandler, NULL);
  rt_task_create(&highPrioTask, "highPrioTask", STACK_SIZE, 10, 0);

  rt_task_set_periodic(&highPrioTask, TM_NOW, 50);
  rt_task_start(&highPrioTask, periodicTaskHigh, NULL);

  return 0;
}

MODULE_LICENSE("GPL");

-------------------------------------------------------------------------=
----------

