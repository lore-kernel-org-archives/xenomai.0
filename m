Message-ID: <441ACB7E.5080309@domain.hid>
Date: Fri, 17 Mar 2006 15:45:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] VxWorks skin improvement
References: <44196DD8.8040500@domain.hid>
	<200603171304.22679.niklaus.giger@domain.hid>
In-Reply-To: <200603171304.22679.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Niklaus Giger wrote:
> Am Donnerstag, 16. M=E4rz 2006 14:53 schrieb Philippe Gerum:
>=20
>>I'm currently working on extending the VxWorks skin so that it is going=
 to
>>be callable from user-space directly, without needing the UVM environme=
nt.
>>This will also make its functional extension easier in the future,
>>especially with respect to bsp-related services.
>>
>>While I'm at it, I'd also like to polish a few corner cases, so that we
>>have the closest possible emulation of the original RTOS services.
>>Unfortunately, the VxWorks documentation is rather terse on some
>>behavioural aspects, and I have no VxWorks target at hand to test and c=
heck
>>them. Therefore, I definitely need help from people reading this list w=
ho
>>also happen to be VxWorks users, for providing the following missing bi=
ts
>>of information:
>>
>>- How does taskName() behave when passed a null task id? Is it equivale=
nt
>>to specifying taskIdSelf(), or does it lead to a NULL error return?
>=20
> It behaves like taskName(taskIdSelf()). see vx_skin.c.
> Output was
> -> vx_skin_test_1
>=20
> myTaskName is 0xf40500 tShell
> value =3D 31 =3D 0x1f
>=20
>=20
>>- How does msgQSend() behave when passed an invalid message priority, i=
.e.
>>neither MSG_PRI_NORMAL nor MSG_PRI_URGENT?
>=20
> It doesn't care (see pMsgQue.cpp).
> Output was
> -> test_init
> task1 started
> endTime   1834779057842028544
> startTime 1832156649595338752
> diff      2622408246689792 2622408246689 microSecs per run 26224082466
> task1 nrQuestions 100 nrAnswers 100 nrSwitches 100
> value =3D 0 =3D 0x0
>=20
>>- How does taskInit() behave when passed an invalid set of task options=
?
>>Are the invalid flags ignored, or does the routine return an error stat=
us?
>=20
> All invalid bits arg ignored, no error returned. see vx_skin.c.
> Output was:
> -> vx_skin_test_2
>=20
> taskInit status is 0
>=20
> taskOptionGet returns 0 is -1
> value =3D 31 =3D 0x1f                =20
>=20
>>If you happen to have a VxWorks target at hand regardless of the
>>architecture, and are willing to help improving the behavioural correct=
ness
>>of the VxWorks skin, then your input will be most welcome.
>=20
> Hope this help. Please feel free to ask for more tests.

Great, I will fix the skin using this information. Thanks.

> What about a vxWorks test suite? I would like to contribute to it.

You would be most welcome doing so.

  (At least
> as soon as I have a working Xenomai environment again.)
  And I would be much
> more confident to recommend Xenomai if it had test suites for its vario=
us=20
> skins. I hope to be able to make some contributions once I get approval=
 to=20
> put a few of our internal test routines available under a free license.
>=20

The most useful way to help would be to develop the testsuite for validat=
ing the=20
recent evolution of the VxWorks skin, which now has a fully native call i=
nterface=20
from user-space, i.e. it does not need the UVM layer anymore, albeit the =
former=20
way will still be available. Let me know whenever you want to help this w=
ay, so=20
that we could synchronize, for a better efficiency in fixing the potentia=
l issues.

> Best regards
>=20
> Niklaus Giger
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> /*
>  * Copyright (C) 2005 Niklaus Giger <niklaus.giger@domain.hid>.
>  *
>  * vxWorks is a registered trademark of Wind River Systems, Inc.
>  *
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License as
>  * published by the Free Software Foundation; either version 2 of the
>  * License, or (at your option) any later version.
>  *
>  * This program is distributed in the hope that it will be useful,
>  * but WITHOUT ANY WARRANTY; without even the implied warranty of
>  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>  * GNU General Public License for more details.
>  *
>  * You should have received a copy of the GNU General Public License
>  * along with this program; if not, write to the Free Software
>  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307=
, USA.
>  *
>  * Hopefully this program lets you compare the relative performance of
>  * taskSwitches and message passing between an original vxWorks image a=
nd
>  * a xenomai based port.
>  */
>=20
> #ifdef XENOMAI
> #include <xeno_config.h>
> #include <vxworks/vxworks.h>
> #include <xenomai/timer.h>
> MODULE_LICENSE("GPL");
> #else
> #include <vxWorks.h>
> #include <stdio.h>
> #include <msgQLib.h>
> #include <taskLib.h>
> #include <sysLib.h>
> #include <arch/ppc/vxPpcLib.h>
> #define xnprintf printf
> #define taskExit exit
> #define RTIME UINT64
> RTIME rt_timer_tsc();
>=20
> RTIME rt_timer_tsc()
> {
>    UINT32 low, high;
>    UINT64 res;
>    vxTimeBaseGet (&low, &high);
>    res =3D (UINT64) low + ((UINT64) high)<<32;
>    return res;
> }
> #endif
>=20
>=20
> #define TASK_PRI    115
> #define STACK_SIZE  8192
>=20
> MSG_Q_ID question_qid, answer_qid;
>=20
> int producer_tid,
>    consumer_tid,
>    test_tid;
> static int nrQuestions;
> static int nrAnswers;
> static int nrSwitches;
> void reportState(const char *where)
> {
>   xnprintf("%s nrQuestions %d nrAnswers %d nrSwitches %d\n",
>            where, nrQuestions, nrAnswers, nrSwitches);
> }
>=20
> #define NR_RUNS 100
> void task1 (int a0, int a1, int a2, int a3, int a4,
>         int a5, int a6, int a7, int a8, int a9)
> {
>     int msg;
>     int sz;
>     int j;
>     RTIME diff, startTime, endTime;
>     xnprintf("task1 started\n");
>     startTime =3D rt_timer_tsc();
>     for (j=3D0; j<NR_RUNS; j++)
>     {
> 	// taskDelay(sysClkRateGet()/2);
> 	// startTime =3D rt_timer_tsc();
>           msg =3D nrQuestions;
>           msgQSend(question_qid,
>                    (char *)&msg,sizeof(msg),WAIT_FOREVER,MSG_PRI_NORMAL=
);
> 	  ++nrQuestions;
>           if ( (sz =3D msgQReceive(answer_qid,
>                 (char *)&msg,sizeof(msg),WAIT_FOREVER)) =3D=3D ERROR)
>           {
>             reportState(__func__);
>             taskExit(3);
>           }
> 	  ++nrSwitches;
>     }
>     endTime =3D rt_timer_tsc();
>     diff =3D endTime - startTime;
>     xnprintf("endTime   %16llu\n", endTime);
>     xnprintf("startTime %16llu\n", startTime);
>     xnprintf("diff      %16llu %llu microSecs per run %llu\n", diff,=20
> 	     diff / 1000, diff / (1000 * NR_RUNS));
>     reportState(__func__);
> }
>=20
> void task2 (int a0, int a1, int a2, int a3, int a4,
> 		    int a5, int a6, int a7, int a8, int a9)
> {
>   int msg;
>   int sz;
>   int j;
>   int status;
>   // for (j=3D0;j<5;j++)
>   while (1)
>     {
>       if ( (sz =3D msgQReceive(question_qid,
>             (char*)&msg,sizeof(msg),WAIT_FOREVER)) =3D=3D ERROR)
>       {
>         reportState(__func__);
>         taskExit(3);
>       }
>       ++nrAnswers;
>       msg =3D nrAnswers;
>       status =3D msgQSend(answer_qid,
>                (char *)&msg,sizeof(msg),WAIT_FOREVER,MSG_PRI_NORMAL | 0=
xffff);
>       if(status !=3D OK)
>       {
>          printf("\n msgQSend failed with status %d", status);
>          taskExit(3);
>       }
>     }
> }
>=20
> const int MeasurementInSeconds =3D 5;
> int test_init(void)
> {
> 	question_qid =3D msgQCreate(16,sizeof(int),MSG_Q_FIFO);
> 	answer_qid   =3D msgQCreate(16,sizeof(int),MSG_Q_FIFO);
>=20
> 	consumer_tid =3D taskSpawn("tTask1",
> 				 TASK_PRI,
> 				 0,
> 				 STACK_SIZE,
> 				 (FUNCPTR)&task1,
> 				 0,0,0,0,0,0,0,0,0,0);
>=20
> 	producer_tid =3D taskSpawn("tTask2",
> 				 TASK_PRI,
> 				 0,
> 				 STACK_SIZE,
> 				 (FUNCPTR)&task2,
> 				 0,0,0,0,0,0,0,0,0,0);
> 	return 0;
> }
>=20
> #ifdef XENOMAI
> int root_thread_init (void)
>=20
> {	test_tid =3D taskSpawn("tTask1",
> 				 TASK_PRI,
> 				 0,
> 				 STACK_SIZE,
> 				 (FUNCPTR)&test_init,
> 				 0,0,0,0,0,0,0,0,0,0);
>=20
> 	// test_init();
>     return 0;
> }
>=20
> void root_thread_exit (void)
>=20
> {
>   xnprintf("root_thread_exit\n");=09
>   taskDelete(test_tid);
>   taskDelete(producer_tid);
>   taskDelete(consumer_tid);
>   msgQDelete(question_qid);
>   msgQDelete(answer_qid);
> }
> #endif
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> #include <vxWorks.h>
> #include <stdio.h>
> #include "taskLib.h"
>=20
> void vx_skin_test_1()
> {
>    char *myTaskName =3D taskName(0);
>    printf("\nmyTaskName is %p %s\n",myTaskName, myTaskName);=20
> }
>=20
> void vx_skin_test_2()
> {
>    char                   *stack_base;
>    char                   *task_name=3D0;
>    WIND_TCB               *tcb_base;
>    STATUS                  status;
>    int                     stack_size =3D 2048;
>    int                     priority =3D 150;
>    int                     options =3D -1;
>    FUNCPTR                 entry_point =3D (FUNCPTR) vx_skin_test_1;
>    tcb_base =3D (WIND_TCB *) malloc ( sizeof (WIND_TCB) );
>    stack_base =3D malloc (stack_size);
>    status =3D taskInit (tcb_base,                       /* TaskControlB=
lock */
>                       task_name,                      /* Task-Name */
>                       priority,                       /* Prioritaet der=
 neuen Task */
>                       options,                        /* Task-Optionen =
*/
>                       stack_base + stack_size,        /* Stack-Start */
>                       stack_size,                     /* Stack-Groesse =
*/
>                       entry_point,                    /* Task-Funktion =
*/
>                       1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
>    printf("\ntaskInit status is %d\n", status);=20
>    options =3D 0xaffeaffe;
>    status =3D taskOptionsGet((int)tcb_base, &options);
>    printf("\ntaskOptionGet returns %d is %d\n", status, options);=20
>=20
> }
>=20


--=20

Philippe.

