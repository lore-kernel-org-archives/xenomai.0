Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65ED6.6C071A98"
Date: Thu, 13 Apr 2006 10:44:05 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290AAB13BC@BUDMLVEM03.e2k.ad.ge.com>
From: "Thomas, Brieuc \(GE Healthcare\)" <Brieuc.Thomas@domain.hid>
Subject: [Xenomai-help] Re: Vxworks skin & Task priority 
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

------_=_NextPart_001_01C65ED6.6C071A98
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Thank you for your explanation about thread !
=20
Always in the same bug, I'll try to test my configuration with this
program.
RR timeslice =3D10ms ticks=3D1/ms
and  two task (with same priority) that increase a counter variable each
time that it takes again the cpu.
We can See the result see bellow:
=20
    Xenomai/uvm: real-time nucleus v2.1 (Champagne) loaded.
    starting VxWorks services.
    Start 0 taskChanged 0
    Start testRun1 0 taskChanged 0
    Run testRun1 0 taskChanged 1
    Start testRun2 10 taskChanged 1
    Run testRun2 10 taskChanged 2
    Run testRun1 20 taskChanged 3
    Run testRun2 30 taskChanged 4
    Run testRun1 40 taskChanged 5
    Run testRun2 50 taskChanged 6
    End testRun1 60 taskChanged 6
    End testRun2 60 taskChanged 6
    End 150 taskChanged 6
=20
The period is put to 500ms (taskPeriod =3D50), and we can see than every
10ms the context change. OK
But now my problem is: If I change the number of my period "taskPeriod".
My computer freezes  without any print.
So, It's this problem than I don't understand. Can anybody help me?=20
=20
#include "vxworks/vxworks.h"=20
#define CLK_RATE 50
#define SSEXEC_SYSCLKRATE 1000=20
#define SSEXEC_TIMESLICE 10=20
=20
static SEM_ID _semaphoreId;
static int taskRunning =3D 0;
static int taskChanged =3D 0;
#define taskPeriod 50               // <<<<<<<<<<<<<<<<<
=20
void testRun1()
{
    printf("Start testRun1 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
    const unsigned int taskId =3D 1;
    unsigned int startTime1 =3D tickGet();
=20
    while(tickGet() < (startTime1 + taskPeriod))
    {
        if(semTake(_semaphoreId, WAIT_FOREVER) !=3D OK) return;
        if(taskRunning !=3D taskId)
        {
            taskRunning =3D taskId;
            taskChanged++;
            printf("Run testRun1 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
        }
        if(semGive(_semaphoreId) !=3D OK) return;
    }
    printf("End testRun1 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
}
=20
void testRun2()
{
    printf("Start testRun2 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
    const unsigned int taskId =3D 2;
    unsigned int startTime1 =3D tickGet();
=20
    while(tickGet() < (startTime1 + taskPeriod))
    {
        if(semTake(_semaphoreId, WAIT_FOREVER) !=3D OK) return;
        if(taskRunning !=3D taskId)
        {
            taskRunning =3D taskId;
            taskChanged++;
            printf("Run testRun2 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
        }
        if(semGive(_semaphoreId) !=3D OK) return;
    }
    printf("End testRun2 %d taskChanged %d\n", (int)tickGet(),
taskChanged);
}
=20
int CreateTask(void)
{
    _semaphoreId =3D semMCreate(SEM_Q_PRIORITY);
    printf("Start %d taskChanged %d\n", (int)tickGet(), taskChanged);
=20
    int taskRun1 =3D taskSpawn("testRun1",100, VX_FP_TASK,
0x5000,(FUNCPTR)testRun1, 0,1,2,3,4,5,6,7,8,9 );
    int taskRun2 =3D taskSpawn("testRun2",100, VX_FP_TASK,
0x5000,(FUNCPTR)testRun2, 0,1,2,3,4,5,6,7,8,9 );
    taskDelay(taskPeriod + 100);
=20
    printf("End %d taskChanged %d\n", (int)tickGet(), taskChanged);
    return OK;
}
=20
int rootTask (void)
{=20
    sysClkRateSet(SSEXEC_SYSCLKRATE);
    tickSet(0);
    kernelTimeSlice(SSEXEC_TIMESLICE);=20
    CreateTask();
    return OK;
}
=20
int root_thread_init (void)
{
    return !taskSpawn("root",0,VX_FP_TASK,0x5000,(FUNCPTR)rootTask,
0,0,0,0,0,0,0,0,0,0 );
}
=20

------_=_NextPart_001_01C65ED6.6C071A98
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D250220207-13042006>Thank =
you&nbsp;for=20
your explanation about thread !</SPAN></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT face=3DArial size=3D2><SPAN =

class=3D250220207-13042006></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D250220207-13042006>Always =
in the same=20
bug, I'll try to test my configuration with this =
program.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D250220207-13042006>RR =
timeslice =3D10ms=20
ticks=3D1/ms</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>and&nbsp; two task=20
(with same priority)&nbsp;that increase a counter variable&nbsp;each =
time that=20
it takes again the cpu.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>We&nbsp;can See the=20
result see bellow:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT><SPAN =
class=3D250220207-13042006><FONT=20
face=3DArial size=3D2></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Xenomai/uvm: =
real-time=20
nucleus v2.1 (Champagne) loaded.</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>starting VxWorks=20
services.</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Start 0 taskChanged =

0</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Start testRun1 0 =
taskChanged=20
0</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Run testRun1 0 =
taskChanged=20
1</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Start testRun2 10 =
taskChanged=20
1</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Run testRun2 10 =
taskChanged=20
2</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Run testRun1 20 =
taskChanged=20
3</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Run testRun2 30 =
taskChanged=20
4</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Run testRun1 40 =
taskChanged=20
5</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>Run testRun2 50 =
taskChanged=20
6</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>End testRun1 60 =
taskChanged=20
6</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>End testRun2 60 =
taskChanged=20
6</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>End 150 taskChanged =

6</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT face=3DArial=20
size=3D2></FONT></SPAN></FONT></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D250220207-13042006>The =
period is put to=20
500ms (taskPeriod =3D50), and we can see than every 10ms the context =
change.=20
OK</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D250220207-13042006>But =
now my problem=20
is: If I change the number of my period "taskPeriod". My computer =
freezes&nbsp;=20
without any print.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT face=3DArial size=3D2><SPAN =

class=3D250220207-13042006>So, It's this problem than I don't =
understand. Can=20
anybody help me?&nbsp;</SPAN></FONT></FONT></FONT></DIV>
<DIV><FONT><SPAN class=3D250220207-13042006><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>#include "vxworks/vxworks.h" =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>#define CLK_RATE 50</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>#define SSEXEC_SYSCLKRATE 1000 =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>#define SSEXEC_TIMESLICE 10 =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>static SEM_ID =
_semaphoreId;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>static int taskRunning =3D =
0;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>static int taskChanged =3D =
0;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>#define taskPeriod 50&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>//=20
&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;</FON=
T></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>void testRun1()</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>{</FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; </SPAN>printf("Start =
testRun1 %d=20
taskChanged %d\n", (int)tickGet(), taskChanged);</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>const unsigned int taskId =3D 1;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>unsigned int startTime1 =3D tickGet();</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>while(tickGet() &lt; (startTime1 + taskPeriod))</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN>if(semTake(_semaphoreId, WAIT_FOREVER) !=3D OK) =
return;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN>if(taskRunning !=3D=20
taskId)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN>{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN></SPAN>taskRunning =3D=20
taskId;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN>taskChanged++;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN></SPAN>printf("Run=20
testRun1 %d taskChanged %d\n", (int)tickGet(), =
taskChanged);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN>if(semGive(_semaphoreId) !=3D OK) return;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>printf("End testRun1 %d taskChanged %d\n", (int)tickGet(),=20
taskChanged);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>void testRun2()</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>printf("Start testRun2 %d taskChanged %d\n", (int)tickGet(),=20
taskChanged);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>const unsigned int taskId =3D 2;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>unsigned int startTime1 =3D tickGet();</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>while(tickGet() &lt; (startTime1 + taskPeriod))</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN>if(semTake(_semaphoreId, WAIT_FOREVER) !=3D OK) =
return;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN>if(taskRunning !=3D=20
taskId)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN>{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN></SPAN>taskRunning =3D=20
taskId;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN>taskChanged++;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN></SPAN>printf("Run=20
testRun2 %d taskChanged %d\n", (int)tickGet(), =
taskChanged);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp; =
</SPAN></SPAN>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN>if(semGive(_semaphoreId) !=3D OK) return;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>printf("End testRun2 %d taskChanged %d\n", (int)tickGet(),=20
taskChanged);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>int CreateTask(void)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>_semaphoreId =3D semMCreate(SEM_Q_PRIORITY);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>printf("Start %d taskChanged %d\n", (int)tickGet(),=20
taskChanged);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>int taskRun1 =3D taskSpawn("testRun1",100, VX_FP_TASK,=20
0x5000,(FUNCPTR)testRun1, 0,1,2,3,4,5,6,7,8,9 );</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>int taskRun2 =3D taskSpawn("testRun2",100, VX_FP_TASK,=20
0x5000,(FUNCPTR)testRun2, 0,1,2,3,4,5,6,7,8,9 );</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>taskDelay(taskPeriod + 100);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D250220207-13042006></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>printf("End %d taskChanged %d\n", (int)tickGet(),=20
taskChanged);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>return OK;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>int rootTask (void)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>{ </FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>sysClkRateSet(SSEXEC_SYSCLKRATE);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>tickSet(0);</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>kernelTimeSlice(SSEXEC_TIMESLICE); </FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>CreateTask();</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>return OK;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>int root_thread_init =
(void)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>{</FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D250220207-13042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>return !taskSpawn("root",0,VX_FP_TASK,0x5000,(FUNCPTR)rootTask,=20
0,0,0,0,0,0,0,0,0,0 );</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>}</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C65ED6.6C071A98--

