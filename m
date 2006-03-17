From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] VxWorks skin improvement
Date: Fri, 17 Mar 2006 13:04:21 +0100
References: <44196DD8.8040500@domain.hid>
In-Reply-To: <44196DD8.8040500@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GXqGEZx8xGGfRCD"
Message-Id: <200603171304.22679.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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

--Boundary-00=_GXqGEZx8xGGfRCD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 16. M=E4rz 2006 14:53 schrieb Philippe Gerum:
> I'm currently working on extending the VxWorks skin so that it is going to
> be callable from user-space directly, without needing the UVM environment.
> This will also make its functional extension easier in the future,
> especially with respect to bsp-related services.
>
> While I'm at it, I'd also like to polish a few corner cases, so that we
> have the closest possible emulation of the original RTOS services.
> Unfortunately, the VxWorks documentation is rather terse on some
> behavioural aspects, and I have no VxWorks target at hand to test and che=
ck
> them. Therefore, I definitely need help from people reading this list who
> also happen to be VxWorks users, for providing the following missing bits
> of information:
>
> - How does taskName() behave when passed a null task id? Is it equivalent
> to specifying taskIdSelf(), or does it lead to a NULL error return?
It behaves like taskName(taskIdSelf()). see vx_skin.c.
Output was
=2D> vx_skin_test_1

myTaskName is 0xf40500 tShell
value =3D 31 =3D 0x1f

> - How does msgQSend() behave when passed an invalid message priority, i.e.
> neither MSG_PRI_NORMAL nor MSG_PRI_URGENT?
It doesn't care (see pMsgQue.cpp).
Output was
=2D> test_init
task1 started
endTime =A0 1834779057842028544
startTime 1832156649595338752
diff =A0 =A0 =A02622408246689792 2622408246689 microSecs per run 26224082466
task1 nrQuestions 100 nrAnswers 100 nrSwitches 100
value =3D 0 =3D 0x0
> - How does taskInit() behave when passed an invalid set of task options?
> Are the invalid flags ignored, or does the routine return an error status?
All invalid bits arg ignored, no error returned. see vx_skin.c.
Output was:
=2D> vx_skin_test_2

taskInit status is 0

taskOptionGet returns 0 is -1
value =3D 31 =3D 0x1f =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=20
> If you happen to have a VxWorks target at hand regardless of the
> architecture, and are willing to help improving the behavioural correctne=
ss
> of the VxWorks skin, then your input will be most welcome.
Hope this help. Please feel free to ask for more tests.
What about a vxWorks test suite? I would like to contribute to it. (At leas=
t=20
as soon as I have a working Xenomai environment again.) And I would be much=
=20
more confident to recommend Xenomai if it had test suites for its various=20
skins. I hope to be able to make some contributions once I get approval to=
=20
put a few of our internal test routines available under a free license.

Best regards

Niklaus Giger

--Boundary-00=_GXqGEZx8xGGfRCD
Content-Type: text/x-c++src;
  charset="iso-8859-1";
  name="pMsgQue.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pMsgQue.cpp"

/*
 * Copyright (C) 2005 Niklaus Giger <niklaus.giger@domain.hid>.
 *
 * vxWorks is a registered trademark of Wind River Systems, Inc.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Hopefully this program lets you compare the relative performance of
 * taskSwitches and message passing between an original vxWorks image and
 * a xenomai based port.
 */

#ifdef XENOMAI
#include <xeno_config.h>
#include <vxworks/vxworks.h>
#include <xenomai/timer.h>
MODULE_LICENSE("GPL");
#else
#include <vxWorks.h>
#include <stdio.h>
#include <msgQLib.h>
#include <taskLib.h>
#include <sysLib.h>
#include <arch/ppc/vxPpcLib.h>
#define xnprintf printf
#define taskExit exit
#define RTIME UINT64
RTIME rt_timer_tsc();

RTIME rt_timer_tsc()
{
   UINT32 low, high;
   UINT64 res;
   vxTimeBaseGet (&low, &high);
   res = (UINT64) low + ((UINT64) high)<<32;
   return res;
}
#endif


#define TASK_PRI    115
#define STACK_SIZE  8192

MSG_Q_ID question_qid, answer_qid;

int producer_tid,
   consumer_tid,
   test_tid;
static int nrQuestions;
static int nrAnswers;
static int nrSwitches;
void reportState(const char *where)
{
  xnprintf("%s nrQuestions %d nrAnswers %d nrSwitches %d\n",
           where, nrQuestions, nrAnswers, nrSwitches);
}

#define NR_RUNS 100
void task1 (int a0, int a1, int a2, int a3, int a4,
        int a5, int a6, int a7, int a8, int a9)
{
    int msg;
    int sz;
    int j;
    RTIME diff, startTime, endTime;
    xnprintf("task1 started\n");
    startTime = rt_timer_tsc();
    for (j=0; j<NR_RUNS; j++)
    {
	// taskDelay(sysClkRateGet()/2);
	// startTime = rt_timer_tsc();
          msg = nrQuestions;
          msgQSend(question_qid,
                   (char *)&msg,sizeof(msg),WAIT_FOREVER,MSG_PRI_NORMAL);
	  ++nrQuestions;
          if ( (sz = msgQReceive(answer_qid,
                (char *)&msg,sizeof(msg),WAIT_FOREVER)) == ERROR)
          {
            reportState(__func__);
            taskExit(3);
          }
	  ++nrSwitches;
    }
    endTime = rt_timer_tsc();
    diff = endTime - startTime;
    xnprintf("endTime   %16llu\n", endTime);
    xnprintf("startTime %16llu\n", startTime);
    xnprintf("diff      %16llu %llu microSecs per run %llu\n", diff, 
	     diff / 1000, diff / (1000 * NR_RUNS));
    reportState(__func__);
}

void task2 (int a0, int a1, int a2, int a3, int a4,
		    int a5, int a6, int a7, int a8, int a9)
{
  int msg;
  int sz;
  int j;
  int status;
  // for (j=0;j<5;j++)
  while (1)
    {
      if ( (sz = msgQReceive(question_qid,
            (char*)&msg,sizeof(msg),WAIT_FOREVER)) == ERROR)
      {
        reportState(__func__);
        taskExit(3);
      }
      ++nrAnswers;
      msg = nrAnswers;
      status = msgQSend(answer_qid,
               (char *)&msg,sizeof(msg),WAIT_FOREVER,MSG_PRI_NORMAL | 0xffff);
      if(status != OK)
      {
         printf("\n msgQSend failed with status %d", status);
         taskExit(3);
      }
    }
}

const int MeasurementInSeconds = 5;
int test_init(void)
{
	question_qid = msgQCreate(16,sizeof(int),MSG_Q_FIFO);
	answer_qid   = msgQCreate(16,sizeof(int),MSG_Q_FIFO);

	consumer_tid = taskSpawn("tTask1",
				 TASK_PRI,
				 0,
				 STACK_SIZE,
				 (FUNCPTR)&task1,
				 0,0,0,0,0,0,0,0,0,0);

	producer_tid = taskSpawn("tTask2",
				 TASK_PRI,
				 0,
				 STACK_SIZE,
				 (FUNCPTR)&task2,
				 0,0,0,0,0,0,0,0,0,0);
	return 0;
}

#ifdef XENOMAI
int root_thread_init (void)

{	test_tid = taskSpawn("tTask1",
				 TASK_PRI,
				 0,
				 STACK_SIZE,
				 (FUNCPTR)&test_init,
				 0,0,0,0,0,0,0,0,0,0);

	// test_init();
    return 0;
}

void root_thread_exit (void)

{
  xnprintf("root_thread_exit\n");	
  taskDelete(test_tid);
  taskDelete(producer_tid);
  taskDelete(consumer_tid);
  msgQDelete(question_qid);
  msgQDelete(answer_qid);
}
#endif

--Boundary-00=_GXqGEZx8xGGfRCD
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="vx_skin_1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vx_skin_1.c"

#include <vxWorks.h>
#include <stdio.h>
#include "taskLib.h"

void vx_skin_test_1()
{
   char *myTaskName = taskName(0);
   printf("\nmyTaskName is %p %s\n",myTaskName, myTaskName); 
}

void vx_skin_test_2()
{
   char                   *stack_base;
   char                   *task_name=0;
   WIND_TCB               *tcb_base;
   STATUS                  status;
   int                     stack_size = 2048;
   int                     priority = 150;
   int                     options = -1;
   FUNCPTR                 entry_point = (FUNCPTR) vx_skin_test_1;
   tcb_base = (WIND_TCB *) malloc ( sizeof (WIND_TCB) );
   stack_base = malloc (stack_size);
   status = taskInit (tcb_base,                       /* TaskControlBlock */
                      task_name,                      /* Task-Name */
                      priority,                       /* Prioritaet der neuen Task */
                      options,                        /* Task-Optionen */
                      stack_base + stack_size,        /* Stack-Start */
                      stack_size,                     /* Stack-Groesse */
                      entry_point,                    /* Task-Funktion */
                      1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
   printf("\ntaskInit status is %d\n", status); 
   options = 0xaffeaffe;
   status = taskOptionsGet((int)tcb_base, &options);
   printf("\ntaskOptionGet returns %d is %d\n", status, options); 

}


--Boundary-00=_GXqGEZx8xGGfRCD--

