MIME-Version: 1.0
Date: Tue, 13 Dec 2011 10:48:38 +0800
Message-ID: <CAO0Fu5Bh-PUZuyzL+hZWJJQ9wCJs8pmnZ6=+rkuVs0Xuc=1TxQ@mail.gmail.com>
From: Lifeng Wang <lfwangcn@domain.hid>
Content-Type: multipart/alternative; boundary=f46d040714d9ceff6004b3f049d6
Subject: [Xenomai-help] When startup the preemptive priority-base scheduling,
 at the start pont, I observed the output with wrong order.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--f46d040714d9ceff6004b3f049d6
Content-Type: text/plain; charset=ISO-8859-1

/*****************************************************************************/
//#include <stdio.h>
//#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>

#include <rtdk.h>
/*****************************************************************************/

#define Task_00_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_00_TASK_PRIO  2     /* RT priority */
#define Task_00_TASK_MODE  T_FPU /* No flags */

#define Task_01_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_01_TASK_PRIO  7     /* RT priority */
#define Task_01_TASK_MODE  T_FPU /* No flags */

#define Task_02_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_02_TASK_PRIO  5     /* RT priority */
#define Task_02_TASK_MODE  T_FPU /* No flags */

#define Task_03_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_03_TASK_PRIO  6     /* RT priority */
#define Task_03_TASK_MODE  T_FPU /* No flags */

#define Task_04_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_04_TASK_PRIO  4     /* RT priority */
#define Task_04_TASK_MODE  T_FPU /* No flags */

#define Task_05_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_05_TASK_PRIO  8     /* RT priority */
#define Task_05_TASK_MODE  T_FPU /* No flags */

#define Task_06_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_06_TASK_PRIO  9     /* RT priority */
#define Task_06_TASK_MODE  T_FPU /* No flags */

#define Task_07_TASK_STKSZ 0     /* Stack size (use default one) */
#define Task_07_TASK_PRIO  3     /* RT priority */
#define Task_07_TASK_MODE  T_FPU /* No flags */

#define BASEPERIOD 0    // baseperiod 0 to get ns
#define SPINTIME   1e7  // spin time in ns

static int Task_00_Prio;
static int Task_01_Prio;
static int Task_02_Prio;
static int Task_03_Prio;
static int Task_04_Prio;
static int Task_05_Prio;
static int Task_06_Prio;
static int Task_07_Prio;

static RT_TASK Task_00;
static RT_TASK Task_01;
static RT_TASK Task_02;
static RT_TASK Task_03;
static RT_TASK Task_04;
static RT_TASK Task_05;
static RT_TASK Task_06;
static RT_TASK Task_07;

static int Task_00_Counts = 0;
static int Task_01_Counts = 0;
static int Task_02_Counts = 0;
static int Task_03_Counts = 0;
static int Task_04_Counts = 0;
static int Task_05_Counts = 0;
static int Task_06_Counts = 0;
static int Task_07_Counts = 0;

static RT_SEM mainsync;


#if 1
static void Task_00_00 (void *cookie)
{
  int err;
  RTIME period = 4000000000LL;

  rt_sem_p(&mainsync,TM_INFINITE);

#if 0
  rt_task_set_periodic(NULL, TM_NOW, period);
#endif

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("Task_00 rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_00 is runned:%dtimes; Task_00_Prio:%d\n",
++Task_00_Counts, Task_00_Prio);

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) {
      rt_printf("Task_00: Error for delayed\n");
    }
#endif
  }
}
#endif


#if 1
static void Task_01_01 (void *cookie)
{
  int err;
  RTIME period = 2000000000LL;

  rt_sem_p(&mainsync,TM_INFINITE);

#if 0
  rt_task_set_periodic(NULL, TM_NOW, period);
#endif

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("Task_01 rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_01 is runned:%dtimes; Task_01_Prio:%d\n",
++Task_01_Counts, Task_01_Prio);

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) {
      rt_printf("Task_01: Error for delayed\n");
    }
#endif
  }
}
#endif


#if 1
static void Task_02_02 (void *cookie)
{
  int err;
  RTIME period = 1000000000LL;

  rt_sem_p(&mainsync,TM_INFINITE);

#if 0
  rt_task_set_periodic(NULL, TM_NOW, period);
#endif

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_02 is runned:%dtimes; Task_02_Prio:%d\n",
++Task_02_Counts, Task_02_Prio);

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) {
      rt_printf("Task_02: Error for delayed\n");
     }
#endif
  }
}
#endif


#if 1
static void Task_03_03 (void *cookie)
{
  int err;
  RTIME period = 1000000000LL;
  RTIME runtime;

  rt_sem_p(&mainsync,TM_INFINITE);

#if 0
  rt_task_set_periodic(NULL, TM_NOW, period);
#endif

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_03 is runned:%dtimes; Task_03_Prio:%d\n",
++Task_03_Counts, Task_03_Prio);

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) {
      rt_printf("Task_03: Error for delayed\n");
    }
#endif
  }
}
#endif


#if 1
static void Task_04_04 (void *cookie)
{
  int err;
  RTIME period = 1000000000LL;

  rt_sem_p(&mainsync,TM_INFINITE);

//  rt_task_set_periodic(NULL, TM_NOW, period);

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_04 is runned:%dtimes; Task_04_Prio:%d\n",
++Task_04_Counts, Task_04_Prio);

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) {
      rt_printf("Task_04: Error for delayed\n");
     }
#endif
  }
}
#endif


#if 1
static void Task_05_05 (void *cookie)
{
  int err;
  RTIME period = 1000000000LL;

  rt_sem_p(&mainsync,TM_INFINITE);

#if 0
  rt_task_set_periodic(NULL, TM_NOW, period);
#endif

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_05 is runned:%dtimes; Task_05_Prio:%d\n",
++Task_05_Counts, Task_05_Prio);

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) {
      rt_printf("Task_05: Error for delayed\n");
    }
#endif
  }
}
#endif


#if 1
static void Task_06_06 (void *cookie)
{
  int err;
  RTIME period = 1000000000LL;

  rt_sem_p(&mainsync,TM_INFINITE);

//  rt_task_set_periodic(NULL, TM_NOW, period);

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_06 is runned:%dtimes; Task_06_Prio:%d\n",
++Task_06_Counts, Task_06_Prio);

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) rt_printf("rt_task_sleep(): Error\n");
#endif
  }
}
#endif


#if 1
static void Task_07_07 (void *cookie)
{
  int err;
  RTIME period = 1000000000LL;

  rt_sem_p(&mainsync,TM_INFINITE);

//  rt_task_set_periodic(NULL, TM_NOW, period);

  for (;;) {
#if 0
    err = rt_task_wait_period(NULL);
    if (err != 0) rt_printf("rt_task_wait_period(): Error\n");
#endif

    rt_printf("Task_07 is runned:%dtimes; Task_07_Prio:%d\n",
++Task_07_Counts, Task_07_Prio);
    rt_printf("\n");

#if 1
    err = rt_task_sleep(1000000000LL);
    if (err != 0) rt_printf("rt_task_sleep(): Error\n");
#endif
  }
}
#endif


void xenomai_init(void)
{
  int err;
  err = mlockall(MCL_CURRENT|MCL_FUTURE);
  if(err != 0) rt_printf("Error for mlcokall()\n");

  /* Perform auto-init of rt_print buffers if the task doesn't do so */
  rt_print_auto_init(1);
  rt_printf("Xenomai: Initialization successed\n\n");
}


int main (int argc, char *argv[])
{
  int err;

  printf("\nPlease press Ctrl-c to end the program\n");

  xenomai_init(); //Xenomai RT enviroment initialize

  //semaphore to sync task startup on
  err = rt_sem_create(&mainsync,"Main_Sem",0,/*S_FIFO*/S_PRIO);

  //set timing to ns
  err = rt_timer_set_mode(BASEPERIOD);

/*****************************************************************************/

#if 1
  rt_printf("Multi-tasking creat and start now.\n");

  err = rt_task_create(&Task_00,
                       "Task_00_Name",
                       Task_00_TASK_STKSZ,
                       Task_00_TASK_PRIO,
                       Task_00_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_00: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_00,&Task_00_00,NULL);
  if (err != 0) {
    rt_printf("Task_00: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_00: Creat and Start now.\n");
#endif

#if 1
  err = rt_task_create(&Task_01,
                       "Task_01_Name",
                       Task_01_TASK_STKSZ,
                       Task_01_TASK_PRIO,
                       Task_01_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_01: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_01,&Task_01_01,NULL);
  if (err != 0) {
    rt_printf("Task_01: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_01: Creat and Start now.\n");
#endif

#if 1
  err = rt_task_create(&Task_02,
                       "Task_02_Name",
                       Task_02_TASK_STKSZ,
                       Task_02_TASK_PRIO,
                       Task_02_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_02: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_02,&Task_02_02,NULL);
  if (err != 0) {
    rt_printf("Task_02: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_02: Creat and Start now.\n");
#endif

#if 1
  err = rt_task_create(&Task_03,
                       "Task_03_Name",
                       Task_03_TASK_STKSZ,
                       Task_03_TASK_PRIO,
                       Task_03_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_03: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_03,&Task_03_03,NULL);
  if (err != 0) {
    rt_printf("Task_03: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_03: Creat and Start now.\n");
#endif

#if 1
  err = rt_task_create(&Task_04,
                       "Task_04_Name",
                       Task_04_TASK_STKSZ,
                       Task_04_TASK_PRIO,
                       Task_04_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_04: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_04,&Task_04_04,NULL);
  if (err != 0) {
    rt_printf("Task_04: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_04: Creat and Start now.\n");
#endif

#if 1
  err = rt_task_create(&Task_05,
                       "Task_05_Name",
                       Task_05_TASK_STKSZ,
                       Task_05_TASK_PRIO,
                       Task_05_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_05: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_05,&Task_05_05,NULL);
  if (err != 0) {
    rt_printf("Task_05: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_05: Creat and Start now.\n");
#endif

#if 1
  err = rt_task_create(&Task_06,
                       "Task_06_Name",
                       Task_06_TASK_STKSZ,
                       Task_06_TASK_PRIO,
                       Task_06_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_06: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_06,&Task_06_06,NULL);
  if (err != 0) {
    rt_printf("Task_06: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_06: Creat and Start now.\n");
#endif

#if 1
  err = rt_task_create(&Task_07,
                       "Task_07_Name",
                       Task_07_TASK_STKSZ,
                       Task_07_TASK_PRIO,
                       Task_07_TASK_MODE);
  if (err != 0) {
    rt_printf("Task_07: Error for creating task.\n");
    return (-1);
  }

  err = rt_task_start(&Task_07,&Task_07_07,NULL);
  if (err != 0) {
    rt_printf("Task_07: Error for starting task.\n");
    return (-1);
  }

  rt_printf("Task_07: Creat and Start now.\n");
#endif

/*****************************************************************************/
#if 1
  #if 1
  Task_00_Prio = 90;
  Task_01_Prio = 80;
  Task_02_Prio = 70;
  Task_03_Prio = 60;
  Task_04_Prio = 50;
  Task_05_Prio = 40;
  Task_06_Prio = 30;
  Task_07_Prio = 20;
  #endif

  rt_task_set_priority(&Task_00, Task_00_Prio);
  rt_task_set_priority(&Task_01, Task_01_Prio);
  rt_task_set_priority(&Task_02, Task_02_Prio);
  rt_task_set_priority(&Task_03, Task_03_Prio);
  rt_task_set_priority(&Task_04, Task_04_Prio);
  rt_task_set_priority(&Task_05, Task_05_Prio);
  rt_task_set_priority(&Task_06, Task_06_Prio);
  rt_task_set_priority(&Task_07, Task_07_Prio);
#endif

/*****************************************************************************/
  rt_printf("\nMulti-tasking scheduling now. Have fun.\n");

  rt_sem_broadcast(&mainsync);

  pause(); // Plese press the key of "Ctrl-c" to end the program

  return 0;
}


########################################################
[root@domain.hid examples]# make
--xeno-cflags is deprecated, use --skin=name --cflags instead
--xeno-ldflags is deprecated, use --skin=name --ldflags instead
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-declaration -pipe -D__XENO__   -L/usr/xenomai/lib
-lxenomai -lpthread -lrt  -lnative -Xlinker -rpath -Xlinker
/usr/xenomai/lib  test.c   -o test

[root@domain.hid examples]# ./test

Please press Ctrl-c to end the program
Xenomai: Initialization successed

Multi-tasking creat and start now.
Task_00: Creat and Start now.
Task_01: Creat and Start now.
Task_02: Creat and Start now.
Task_03: Creat and Start now.
Task_04: Creat and Start now.
Task_05: Creat and Start now.
Task_06: Creat and Start now.
Task_07: Creat and Start now.

Multi-tasking scheduling now. Have fun.
Task_00 is runned:1times; Task_00_Prio:90
Task_01 is runned:1times; Task_01_Prio:80
Task_02 is runned:1times; Task_02_Prio:70
Task_05 is runned:1times; Task_05_Prio:40
Task_03 is runned:1times; Task_03_Prio:60
Task_06 is runned:1times; Task_06_Prio:30
Task_04 is runned:1times; Task_04_Prio:50
Task_07 is runned:1times; Task_07_Prio:20

Task_00 is runned:2times; Task_00_Prio:90
Task_01 is runned:2times; Task_01_Prio:80
Task_02 is runned:2times; Task_02_Prio:70
Task_03 is runned:2times; Task_03_Prio:60
Task_04 is runned:2times; Task_04_Prio:50
Task_05 is runned:2times; Task_05_Prio:40
Task_06 is runned:2times; Task_06_Prio:30
Task_07 is runned:2times; Task_07_Prio:20

Task_00 is runned:3times; Task_00_Prio:90
Task_01 is runned:3times; Task_01_Prio:80
Task_02 is runned:3times; Task_02_Prio:70
Task_03 is runned:3times; Task_03_Prio:60
Task_04 is runned:3times; Task_04_Prio:50
Task_05 is runned:3times; Task_05_Prio:40
Task_06 is runned:3times; Task_06_Prio:30
Task_07 is runned:3times; Task_07_Prio:20

^C
[root@domain.hid examples]#

##################################################################
Fedora 14 Linux kernel-2.6.35.9
Xenomai-2.6.0

This example program contains eight tasks with different prioities.
The Task_00 has the highest priority. The Task_07 has the lowest priority.
Each task can run and delay the same time of 1 second.

My question is that. When startup the preemptive priority-base
scheduling,at the start pont,
I observed the output:
Multi-tasking scheduling now. Have fun.
Task_00 is runned:1times; Task_00_Prio:90
Task_01 is runned:1times; Task_01_Prio:80
Task_02 is runned:1times; Task_02_Prio:70
Task_05 is runned:1times; Task_05_Prio:40  :Why?
Task_03 is runned:1times; Task_03_Prio:60  :Why?
Task_06 is runned:1times; Task_06_Prio:30  :Why?
Task_04 is runned:1times; Task_04_Prio:50  :Why?
Task_07 is runned:1times; Task_07_Prio:20

But I think that,the correct output shoud be that and must be that:
Task_00 is runned:1times; Task_00_Prio:90
Task_01 is runned:1times; Task_01_Prio:80
Task_02 is runned:1times; Task_02_Prio:70
Task_03 is runned:1times; Task_03_Prio:60
Task_04 is runned:1times; Task_04_Prio:50
Task_05 is runned:1times; Task_05_Prio:40
Task_06 is runned:1times; Task_06_Prio:30
Task_07 is runned:1times; Task_07_Prio:20

Why is it not?
Can someone tell me why and tell me how to write the correct code for the
preemptive priority-base scheduling.

Happy new year to everyone.

Wang Lifeng
lfwangcn@domain.hid
>From Suzhou,China

--f46d040714d9ceff6004b3f049d6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family:arial,sans-serif;font-size:13px;border-collapse:=
collapse"><div><font face=3D"arial, sans-serif"><span style=3D"border-colla=
pse:collapse">/************************************************************=
*****************/</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">//#include &lt;stdio.h&gt;</span></font></div><div><font face=3D"arial,=
 sans-serif"><span style=3D"border-collapse:collapse">//#include &lt;stdlib=
.h&gt;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#include &lt;unistd.h&gt;</span></font></div><div><font face=3D"arial, =
sans-serif"><span style=3D"border-collapse:collapse">#include &lt;sys/mman.=
h&gt;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#include &lt;native/task.h&gt;</span></font=
></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#include &lt;native/timer.h&gt;</span></font></div><div><font face=3D"a=
rial, sans-serif"><span style=3D"border-collapse:collapse">#include &lt;nat=
ive/sem.h&gt;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#include &lt;rtdk.h&gt;</span></font></div>=
<div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">/=
***************************************************************************=
**/</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D=
"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_00_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_00_TASK_PRIO =A02 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_00_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_01_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_01_TASK_PRIO =A07 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_01_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_02_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_02_TASK_PRIO =A05 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_02_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_03_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_03_TASK_PRIO =A06 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_03_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_04_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_04_TASK_PRIO =A04 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_04_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_05_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_05_TASK_PRIO =A08 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_05_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_06_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_06_TASK_PRIO =A09 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_06_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define Task_07_TASK_STKSZ 0 =A0 =A0 /* Stack size =
(use default one) */</span></font></div><div><font face=3D"arial, sans-seri=
f"><span style=3D"border-collapse:collapse">#define Task_07_TASK_PRIO =A03 =
=A0 =A0 /* RT priority */</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#define Task_07_TASK_MODE =A0T_FPU /* No flags */</span></font></div><d=
iv><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse=
"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">#define BASEPERIOD 0 =A0 =A0// baseperiod 0 to get =
ns</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"=
border-collapse:collapse">#define SPINTIME =A0 1e7 =A0// spin time in ns</s=
pan></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">static int Task_00_Prio;</span></font></div=
><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic int Task_01_Prio;</span></font></div><div><font face=3D"arial, sans-s=
erif"><span style=3D"border-collapse:collapse">static int Task_02_Prio;</sp=
an></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static int Task_03_Prio;</span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">static int Task_04_Prio=
;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static int Task_05_Prio;</span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">static int Task_06_Prio=
;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static int Task_07_Prio;</span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse"><br></span></font></div=
><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic RT_TASK Task_00;</span></font></div><div><font face=3D"arial, sans-se=
rif"><span style=3D"border-collapse:collapse">static RT_TASK Task_01;</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static RT_TASK Task_02;</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">static RT_TASK Task_03;<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static RT_TASK Task_04;</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">static RT_TASK Task_05;<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static RT_TASK Task_06;</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">static RT_TASK Task_07;<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">static int Task_00_Counts =3D 0;</span></fo=
nt></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static int Task_01_Counts =3D 0;</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">static int Task=
_02_Counts =3D 0;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static int Task_03_Counts =3D 0;</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">static int Task=
_04_Counts =3D 0;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static int Task_05_Counts =3D 0;</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">static int Task=
_06_Counts =3D 0;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static int Task_07_Counts =3D 0;</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse"><br></span></fo=
nt></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static RT_SEM mainsync;</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse"><br></span></font></div>=
<div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"><=
br></span></font></div><div><font face=3D"arial, sans-serif"><span style=3D=
"border-collapse:collapse">#if 1</span></font></div><div><font face=3D"aria=
l, sans-serif"><span style=3D"border-collapse:collapse">static void Task_00=
_00 (void *cookie)</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">{</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">=A0=A0int err;</span></font></div><div><font =
face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0R=
TIME period =3D 4000000000LL;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0</span></font></div><div><font face=3D"arial, sans-serif"><sp=
an style=3D"border-collapse:collapse">=A0=A0rt_sem_p(&amp;mainsync,TM_INFIN=
ITE);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 0</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0rt_task_=
set_periodic(NULL, TM_NOW, period);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse">=A0=A0</span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0for (=
;;) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 0</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">=A0=A0 =A0err =3D rt_task_wait_period(NULL=
);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;Task_00 rt_task_wait_period()=
: Error\n&quot;);</span></font></div><div><font face=3D"arial, sans-serif">=
<span style=3D"border-collapse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quot;Task_00 is runned=
:%dtimes; Task_00_Prio:%d\n&quot;, ++Task_00_Counts, Task_00_Prio);</span><=
/font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1 =A0 =A0</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
 =A0err =3D rt_task_sleep(1000000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial=
, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0 =A0rt_pri=
ntf(&quot;Task_00: Error for delayed\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0}</span></font></div><div><font face=3D"arial, sans-serif"><s=
pan style=3D"border-collapse:collapse">#endif</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
}</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">}</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">#endif</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse"><br></span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">#if 1</span></font></di=
v><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic void Task_01_01 (void *cookie)</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">{</span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0int err;</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse">=A0=A0RTIME period =3D 2000000000=
LL;=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0rt_sem_p(&amp;mainsync,TM_INFINITE);<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 0 =A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0rt_t=
ask_set_periodic(NULL, TM_NOW, period);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0for (=
;;) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 0</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">=A0=A0 =A0err =3D rt_task_wait_period(NULL=
);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;Task_01 rt_task_wait_period()=
: Error\n&quot;);</span></font></div><div><font face=3D"arial, sans-serif">=
<span style=3D"border-collapse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quot;Task_01 is runned=
:%dtimes; Task_01_Prio:%d\n&quot;, ++Task_01_Counts, Task_01_Prio);</span><=
/font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0err =
=3D rt_task_sleep(1000000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial=
, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0 =A0rt_pri=
ntf(&quot;Task_01: Error for delayed\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0}</span></font></div><div><font face=3D"arial, sans-serif"><s=
pan style=3D"border-collapse:collapse">#endif</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
}</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">}</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">#endif</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse"><br></span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">#if 1</span></font></di=
v><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic void Task_02_02 (void *cookie)</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">{</span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0int err;</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse">=A0=A0RTIME period =3D 1000000000=
LL;=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0rt_sem_p(&amp;mainsync,TM_INFINITE);<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 0 =A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0rt_t=
ask_set_periodic(NULL, TM_NOW, period);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0for (=
;;) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 0</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">=A0=A0 =A0err =3D rt_task_wait_period(NULL=
);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_wait_period(): Error\=
n&quot;);</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quot;Task_02 is runned=
:%dtimes; Task_02_Prio:%d\n&quot;, ++Task_02_Counts, Task_02_Prio);</span><=
/font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1 =A0 =A0</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
 =A0err =3D rt_task_sleep(1000000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial=
, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0 =A0rt_pri=
ntf(&quot;Task_02: Error for delayed\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 }</span></font></div><div><font face=3D"arial, sans-serif"><=
span style=3D"border-collapse:collapse">#endif</span></font></div><div><fon=
t face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=
=A0}</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">}</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">#endif</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse"><br></span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">#if 1</span></font></di=
v><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic void Task_03_03 (void *cookie)</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">{</span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0int err;</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse">=A0=A0RTIME period =3D 1000000000=
LL;=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0RTIME runtime;</span></font></div><div><font face=3D"arial, sans-=
serif"><span style=3D"border-collapse:collapse"><br></span></font></div><di=
v><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"=
>=A0=A0rt_sem_p(&amp;mainsync,TM_INFINITE);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 0 =A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0rt_t=
ask_set_periodic(NULL, TM_NOW, period);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0for (=
;;) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 0</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">=A0=A0 =A0err =3D rt_task_wait_period(NULL=
);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_wait_period(): Error\=
n&quot;);</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quot;Task_03 is runned=
:%dtimes; Task_03_Prio:%d\n&quot;, ++Task_03_Counts, Task_03_Prio);</span><=
/font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0err =
=3D rt_task_sleep(1000000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial=
, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0 =A0rt_pri=
ntf(&quot;Task_03: Error for delayed\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0}</span></font></div><div><font face=3D"arial, sans-serif"><s=
pan style=3D"border-collapse:collapse">#endif</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
}</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">}</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">#endif</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse"><br></span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">#if 1</span></font></di=
v><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic void Task_04_04 (void *cookie)</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">{</span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0int err;</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse">=A0=A0RTIME period =3D 1000000000=
LL;=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0rt_sem_p(&amp;mainsync,TM_INFINITE);<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse">// =A0rt_task_set_periodic(NULL, TM_NOW, =
period);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0for (;;) {</span></font></div><div><f=
ont face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">#if=
 0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0err =3D rt_task_wait_period(NULL);=A0</span></font></div><div=
><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=
=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_wait_period(): Error\n&qu=
ot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0r=
t_printf(&quot;Task_04 is runned:%dtimes; Task_04_Prio:%d\n&quot;, ++Task_0=
4_Counts, Task_04_Prio);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0err =
=3D rt_task_sleep(1000000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial=
, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0 =A0rt_pri=
ntf(&quot;Task_04: Error for delayed\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 }=A0</span></font></div><div><font face=3D"arial, sans-serif=
"><span style=3D"border-collapse:collapse">#endif</span></font></div><div><=
font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=
=A0=A0}</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">}</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">#endif</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse"><br></span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">#if 1</span></font></di=
v><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic void Task_05_05 (void *cookie)</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">{</span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0int err;</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse">=A0=A0RTIME period =3D 1000000000=
LL;=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0rt_sem_p(&amp;mainsync,TM_INFINITE);<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 0 =A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0rt_t=
ask_set_periodic(NULL, TM_NOW, period);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0for (=
;;) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 0</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">=A0=A0 =A0err =3D rt_task_wait_period(NULL=
);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_wait_period(): Error\=
n&quot;);</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quot;Task_05 is runned=
:%dtimes; Task_05_Prio:%d\n&quot;, ++Task_05_Counts, Task_05_Prio); =A0 =A0=
</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0err =
=3D rt_task_sleep(1000000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial=
, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0 =A0rt_pri=
ntf(&quot;Task_05: Error for delayed\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0}</span></font></div><div><font face=3D"arial, sans-serif"><s=
pan style=3D"border-collapse:collapse">#endif</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
}</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">}</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">#endif</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse"><br></span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">#if 1</span></font></di=
v><div>

<font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">s=
tatic void Task_06_06 (void *cookie)</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">{</span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0int err;</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse">=A0=A0RTIME period =3D 1000000000=
LL;=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0rt_sem_p(&amp;mainsync,TM_INFINITE);<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse">// =A0rt_task_set_periodic(NULL, TM_NOW, =
period);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0for (;;) {</span></font></div><div><f=
ont face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">#if=
 0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0err =3D rt_task_wait_period(NULL);=A0</span></font></div><div=
><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=
=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_wait_period(): Error\n&qu=
ot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0r=
t_printf(&quot;Task_06 is runned:%dtimes; Task_06_Prio:%d\n&quot;, ++Task_0=
6_Counts, Task_06_Prio); =A0 =A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1 =A0=A0</span></font></div><div><font =
face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =
=A0err =3D rt_task_sleep(1000000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_sleep(): Error\n&quot=
;);</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D=
"border-collapse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">}</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">#endif</span></=
font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse"><br></span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">#if 1</span></f=
ont></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">static void Task_07_07 (void *cookie)</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">{</span></=
font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0int err;</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse">=A0=A0RTIME period =3D 1000000000=
LL;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0rt_sem_p(&amp;mainsync,TM_INFINITE);<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse">// =A0rt_task_set_periodic(NULL, TM_NOW, =
period);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0for (;;) {=A0</span></font></div><div=
><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=
#if 0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0err =3D rt_task_wait_period(NULL);=A0</span></font></div><div=
><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=
=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_wait_period(): Error\n&qu=
ot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0r=
t_printf(&quot;Task_07 is runned:%dtimes; Task_07_Prio:%d\n&quot;, ++Task_0=
7_Counts, Task_07_Prio);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;\n&quot;); =A0 =A0</span></font></div><div><f=
ont face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"><br=
></span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 1 =A0 =A0</span></font></div><div><font face=3D"arial, sans-serif">=
<span style=3D"border-collapse:collapse">=A0=A0 =A0err =3D rt_task_sleep(10=
00000000LL);=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0if (err !=3D 0) rt_printf(&quot;rt_task_sleep(): Error\n&quot=
;);</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D=
"border-collapse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">}</span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">#endif</span></=
font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse"><br></span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">void xenomai_in=
it(void)</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">{</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">=A0=A0int err;</span></font></div><div><font =
face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0e=
rr =3D mlockall(MCL_CURRENT|MCL_FUTURE);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if(err !=3D 0) rt_printf(&quot;Error for mlcokall()\n&quot;);</sp=
an></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border=
-collapse:collapse">=A0=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0/* Perform auto-init of rt_print buffers if the task doesn&#39;t =
do so */</span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0rt_print_auto_init(1);</span></font><=
/div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_printf(&quot;Xenomai: Initialization successed\n\n&quot;);</sp=
an></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border=
-collapse:collapse">}</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse"><br></span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">int main (int a=
rgc, char *argv[])</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">{</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">=A0=A0int err;</span></font></div><div><font =
face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">=A0=A0printf(&quot;\nPlease press Ctrl-c to end the=
 program\n&quot;);</span></font></div><div><font face=3D"arial, sans-serif"=
><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">=A0=A0xenomai_init(); //Xenomai RT enviroment initi=
alize</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">=A0=A0//semaphore to sync task startup on</span></f=
ont></div><div><font face=3D"arial, sans-serif"><span style=3D"border-colla=
pse:collapse">=A0=A0err =3D rt_sem_create(&amp;mainsync,&quot;Main_Sem&quot=
;,0,/*S_FIFO*/S_PRIO);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0//set timing to ns</span></font></div=
><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:colla=
pse">=A0=A0err =3D rt_timer_set_mode(BASEPERIOD);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse">/****************************************=
*************************************/ =A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 1</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">=A0=A0rt_printf(&quot;Multi-tasking creat =
and start now.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">=A0=A0err =3D rt_task_create(&amp;Task_00,<=
/span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_00_Name&quot;=
,</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"b=
order-collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tas=
k_00_TASK_STKSZ,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_00_TASK_PRIO,</span=
></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-c=
ollapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_00_TA=
SK_MODE);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_00: Error for creating task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">=A0=A0err =3D rt_task_start(&amp;Task_00,&amp;Task_=
00_00,NULL);</span></font></div><div><font face=3D"arial, sans-serif"><span=
 style=3D"border-collapse:collapse">=A0=A0if (err !=3D 0) {</span></font></=
div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_00: Error for starting task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">=A0=A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0rt_p=
rintf(&quot;Task_00: Creat and Start now.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">#if 1</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0err =3D rt_task_create(&amp;Task_01,</span></font></div><div><fon=
t face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_01_Name&quot;,</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_01_TASK_STKSZ,</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_01_T=
ASK_PRIO,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_01_TASK_MODE);</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0if (err !=3D 0) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_01: Error for creating task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0err =
=3D rt_task_start(&amp;Task_01,&amp;Task_01_01,NULL);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_01: Error for starting task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse">=A0=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_printf(&quot;Task_01: Creat and Start now.\n&quot;);</span></f=
ont></div><div><font face=3D"arial, sans-serif"><span style=3D"border-colla=
pse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0err =3D =
rt_task_create(&amp;Task_02,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_02_Name&quot;=
,</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"b=
order-collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tas=
k_02_TASK_STKSZ,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_02_TASK_PRIO,</span=
></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-c=
ollapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_02_TA=
SK_MODE);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_02: Error for creating task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">=A0=A0err =3D rt_task_start(&amp;Task_02,&amp;Task_=
02_02,NULL);</span></font></div><div><font face=3D"arial, sans-serif"><span=
 style=3D"border-collapse:collapse">=A0=A0if (err !=3D 0) {</span></font></=
div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_02: Error for starting task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">=A0=A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0rt_p=
rintf(&quot;Task_02: Creat and Start now.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">#if 1</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0err =3D rt_task_create(&amp;Task_03,</span></font></div><div><fon=
t face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_03_Name&quot;,</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_03_TASK_STKSZ,</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_03_T=
ASK_PRIO,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_03_TASK_MODE);</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0if (err !=3D 0) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_03: Error for creating task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">=A0=A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0err =
=3D rt_task_start(&amp;Task_03,&amp;Task_03_03,NULL);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_03: Error for starting task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse">=A0=A0 =A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_printf(&quot;Task_03: Creat and Start now.\n&quot;);</span></f=
ont></div><div><font face=3D"arial, sans-serif"><span style=3D"border-colla=
pse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0err =3D =
rt_task_create(&amp;Task_04,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_04_Name&quot;=
,</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"b=
order-collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tas=
k_04_TASK_STKSZ,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_04_TASK_PRIO,</span=
></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-c=
ollapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_04_TA=
SK_MODE);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_04: Error for creating task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse">=A0=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0err =3D rt_task_start(&amp;Task_04,&amp;Task_04_04,NULL);</span><=
/font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-col=
lapse:collapse">=A0=A0if (err !=3D 0) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_04: Error for starting task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">=A0=A0 =A0</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
rt_printf(&quot;Task_04: Creat and Start now.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">#if 1</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0err =3D rt_task_create(&amp;Task_05,</span></font></div><div><fon=
t face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_05_Name&quot;,</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_05_TASK_STKSZ,</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_05_T=
ASK_PRIO,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_05_TASK_MODE);</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0if (err !=3D 0) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_05: Error for creating task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">=A0=A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0err =
=3D rt_task_start(&amp;Task_05,&amp;Task_05_05,NULL);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_05: Error for starting task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse">=A0=A0 =A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_printf(&quot;Task_05: Creat and Start now.\n&quot;);</span></f=
ont></div><div><font face=3D"arial, sans-serif"><span style=3D"border-colla=
pse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">#if 1</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0err =3D =
rt_task_create(&amp;Task_06,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_06_Name&quot;=
,</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"b=
order-collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Tas=
k_06_TASK_STKSZ,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_06_TASK_PRIO,</span=
></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-c=
ollapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_06_TA=
SK_MODE);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_06: Error for creating task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse">=A0=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0err =3D rt_task_start(&amp;Task_06,&amp;Task_06_06,NULL);</span><=
/font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-col=
lapse:collapse">=A0=A0if (err !=3D 0) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_06: Error for starting task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">=A0=A0 =A0</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0=
rt_printf(&quot;Task_06: Creat and Start now.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#endif</span></font></div><div><font face=3D"arial, sans-serif"><span s=
tyle=3D"border-collapse:collapse"><br></span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">#if 1</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0err =3D rt_task_create(&amp;Task_07,</span></font></div><div><fon=
t face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Task_07_Name&quot;,</span=
></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_07_TASK_STKSZ,</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_07_T=
ASK_PRIO,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Task_07_TASK_MODE);</spa=
n></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-=
collapse:collapse">=A0=A0if (err !=3D 0) {</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0rt_printf(&quot;Task_07: Error for creating task.\n&quot;);</=
span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bord=
er-collapse:collapse">=A0=A0 =A0return (-1);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0}</span></font></div><div><font face=3D"arial, sans-serif"><span =
style=3D"border-collapse:collapse">=A0=A0</span></font></div><div><font fac=
e=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0err =
=3D rt_task_start(&amp;Task_07,&amp;Task_07_07,NULL);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0if (err !=3D 0) {</span></font></div><div><font face=3D"arial, sa=
ns-serif"><span style=3D"border-collapse:collapse">=A0=A0 =A0rt_printf(&quo=
t;Task_07: Error for starting task.\n&quot;);</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0 =A0return (-1);</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">=A0=A0}</span></font></di=
v><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:coll=
apse">=A0=A0 =A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_printf(&quot;Task_07: Creat and Start now.\n&quot;);</span></f=
ont></div><div><font face=3D"arial, sans-serif"><span style=3D"border-colla=
pse:collapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">/******************************************=
***********************************/</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">#if 1</span></font></div><div><font face=3D"arial, sans-serif"><span st=
yle=3D"border-collapse:collapse">=A0=A0#if 1</span></font></div><div><font =
face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0T=
ask_00_Prio =3D 90;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0Task_01_Prio =3D 80;</span></font></div><div><font face=3D"arial,=
 sans-serif"><span style=3D"border-collapse:collapse">=A0=A0Task_02_Prio =
=3D 70;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0Task_03_Prio =3D 60;</span></font></div><div><font face=3D"arial,=
 sans-serif"><span style=3D"border-collapse:collapse">=A0=A0Task_04_Prio =
=3D 50;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0Task_05_Prio =3D 40;</span></font></div><div><font face=3D"arial,=
 sans-serif"><span style=3D"border-collapse:collapse">=A0=A0Task_06_Prio =
=3D 30;</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0Task_07_Prio =3D 20;</span></font></div><div><font face=3D"arial,=
 sans-serif"><span style=3D"border-collapse:collapse">=A0=A0#endif</span></=
font></div><div>

<span style=3D"font-family:arial,sans-serif;border-collapse:collapse">=A0</=
span></div><div><font face=3D"arial, sans-serif"><span style=3D"border-coll=
apse:collapse">=A0=A0rt_task_set_priority(&amp;Task_00, Task_00_Prio);</spa=
n></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_task_set_priority(&amp;Task_01, Task_01_Prio);</span></font></=
div><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:co=
llapse">=A0=A0rt_task_set_priority(&amp;Task_02, Task_02_Prio);</span></fon=
t></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_task_set_priority(&amp;Task_03, Task_03_Prio);</span></font></=
div><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:co=
llapse">=A0=A0rt_task_set_priority(&amp;Task_04, Task_04_Prio);</span></fon=
t></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_task_set_priority(&amp;Task_05, Task_05_Prio);</span></font></=
div><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:co=
llapse">=A0=A0rt_task_set_priority(&amp;Task_06, Task_06_Prio);</span></fon=
t></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_task_set_priority(&amp;Task_07, Task_07_Prio);</span></font></=
div><div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:co=
llapse">#endif</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">/******************************************=
***********************************/</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_printf(&quot;\nMulti-tasking scheduling now. Have fun.\n&quot;=
);</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"=
border-collapse:collapse">=A0=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0rt_sem_broadcast(&amp;mainsync);</span></font></div><div><font fa=
ce=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">=A0=A0 =
=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0pause(); // Plese press the key of &quot;Ctrl-c&quot; to end the =
program</span></font></div><div><font face=3D"arial, sans-serif"><span styl=
e=3D"border-collapse:collapse">=A0=A0</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">=A0=A0return 0;</span></font></div><div><font face=3D"arial, sans-serif=
"><span style=3D"border-collapse:collapse">}</span></font></div><div><font =
face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse"><br></span></font></div><div><font face=3D"arial, s=
ans-serif"><span style=3D"border-collapse:collapse">#######################=
#################################</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">[root@domain.hid examples]# make</span></font></div><div><font face=3D"arial=
, sans-serif"><span style=3D"border-collapse:collapse">--xeno-cflags is dep=
recated, use --skin=3Dname --cflags instead</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead</span=
></font></div><div><font face=3D"arial, sans-serif"><span style=3D"border-c=
ollapse:collapse">gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wa=
ll -Werror-implicit-function-declaration -pipe -D__XENO__ =A0 -L/usr/xenoma=
i/lib -lxenomai -lpthread -lrt =A0-lnative -Xlinker -rpath -Xlinker /usr/xe=
nomai/lib =A0test.c =A0 -o test</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">[root@domain.hid examples]# ./test=A0</span></fo=
nt></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">Please press Ctrl-c to end the program</spa=
n></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Xenomai: Initialization successed</span></font></div><div><font face=3D=
"arial, sans-serif"><span style=3D"border-collapse:collapse"><br></span></f=
ont></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Multi-tasking creat and start now.</span></font></div><div><font face=
=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_00: Cr=
eat and Start now.</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_01: Creat and Start now.</span></font></div><div><font face=3D"ari=
al, sans-serif"><span style=3D"border-collapse:collapse">Task_02: Creat and=
 Start now.</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_03: Creat and Start now.</span></font></div><div><font face=3D"ari=
al, sans-serif"><span style=3D"border-collapse:collapse">Task_04: Creat and=
 Start now.</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_05: Creat and Start now.</span></font></div><div><font face=3D"ari=
al, sans-serif"><span style=3D"border-collapse:collapse">Task_06: Creat and=
 Start now.</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_07: Creat and Start now.</span></font></div><div><font face=3D"ari=
al, sans-serif"><span style=3D"border-collapse:collapse"><br></span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Multi-tasking scheduling now. Have fun.</span></font></div><div><font f=
ace=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_00 =
is runned:1times; Task_00_Prio:90</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_01 is runned:1times; Task_01_Prio:80</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
2 is runned:1times; Task_02_Prio:70</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_05 is runned:1times; Task_05_Prio:40</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
3 is runned:1times; Task_03_Prio:60</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_06 is runned:1times; Task_06_Prio:30</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
4 is runned:1times; Task_04_Prio:50</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_07 is runned:1times; Task_07_Prio:20</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"><br></=
span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_00 is runned:2times; Task_00_Prio:90</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
1 is runned:2times; Task_01_Prio:80</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_02 is runned:2times; Task_02_Prio:70</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
3 is runned:2times; Task_03_Prio:60</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_04 is runned:2times; Task_04_Prio:50</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
5 is runned:2times; Task_05_Prio:40</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_06 is runned:2times; Task_06_Prio:30</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
7 is runned:2times; Task_07_Prio:20</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">Task_00 is runned:3times; Task_00_Prio:90</=
span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_01 is runned:3times; Task_01_Prio:80</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
2 is runned:3times; Task_02_Prio:70</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_03 is runned:3times; Task_03_Prio:60</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
4 is runned:3times; Task_04_Prio:50</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_05 is runned:3times; Task_05_Prio:40</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
6 is runned:3times; Task_06_Prio:30</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_07 is runned:3times; Task_07_Prio:20</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"><br></=
span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">^C</span></font></div><div><font face=3D"arial, sans-serif"><span style=
=3D"border-collapse:collapse">[root@domain.hid examples]#</span></font></div><di=
v><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse"=
><br>

</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D"bo=
rder-collapse:collapse">###################################################=
###############</span></font></div><div><font face=3D"arial, sans-serif"><s=
pan style=3D"border-collapse:collapse">Fedora 14 Linux kernel-2.6.35.9</spa=
n></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Xenomai-2.6.0</span></font></div><div><font face=3D"arial, sans-serif">=
<span style=3D"border-collapse:collapse"><br></span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">This e=
xample program contains eight tasks with different prioities.</span></font>=
</div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">The Task_00 has the highest priority. The Task_07 has the lowest priori=
ty.</span></font></div><div><font face=3D"arial, sans-serif"><span style=3D=
"border-collapse:collapse">Each task can run and delay the same time of 1 s=
econd.</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">My question is that. When startup the preem=
ptive priority-base scheduling,at the start pont,</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">I observed the output:</span></font></div><div><font face=3D"arial, san=
s-serif"><span style=3D"border-collapse:collapse">Multi-tasking scheduling =
now. Have fun.</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_00 is runned:1times; Task_00_Prio:90</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
1 is runned:1times; Task_01_Prio:80</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_02 is runned:1times; Task_02_Prio:70</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
5 is runned:1times; Task_05_Prio:40 =A0:Why?</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_03 is runned:1times; Task_03_Prio:60 =A0:Why?</span></font></div><=
div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collaps=
e">Task_06 is runned:1times; Task_06_Prio:30 =A0:Why?</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_04 is runned:1times; Task_04_Prio:50 =A0:Why?</span></font></div><=
div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collaps=
e">Task_07 is runned:1times; Task_07_Prio:20</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">But I think that,the correct output shoud b=
e that and must be that:</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_00 is runned:1times; Task_00_Prio:90</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
1 is runned:1times; Task_01_Prio:80</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_02 is runned:1times; Task_02_Prio:70</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
3 is runned:1times; Task_03_Prio:60</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_04 is runned:1times; Task_04_Prio:50</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
5 is runned:1times; Task_05_Prio:40</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se">Task_06 is runned:1times; Task_06_Prio:30</span></font></div><div><font=
 face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Task_0=
7 is runned:1times; Task_07_Prio:20</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">Why is it not?</span></font></div><div><fon=
t face=3D"arial, sans-serif"><span style=3D"border-collapse:collapse">Can s=
omeone tell me why and tell me how to write the correct code for the preemp=
tive priority-base scheduling.</span></font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><div><font face=3D"arial, sans-serif"><span sty=
le=3D"border-collapse:collapse">Happy new year to everyone.</span></font></=
div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><br></span></font></div><font color=3D"#888888"><div><font face=3D"aria=
l, sans-serif"><span style=3D"border-collapse:collapse">Wang Lifeng</span><=
/font></div>

<div><font face=3D"arial, sans-serif"><span style=3D"border-collapse:collap=
se"><a href=3D"mailto:lfwangcn@domain.hid" style=3D"color:rgb(0,0,204)" targ=
et=3D"_blank">lfwangcn@domain.hid</a></span></font></div><div><font face=3D"=
arial, sans-serif"><span style=3D"border-collapse:collapse">From Suzhou,Chi=
na</span></font></div>

</font></span>

--f46d040714d9ceff6004b3f049d6--

