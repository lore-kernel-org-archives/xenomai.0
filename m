Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65E3B.FD171E70"
Date: Wed, 12 Apr 2006 16:18:36 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290AA52FC4@domain.hid>
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

------_=_NextPart_001_01C65E3B.FD171E70
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

>> I'm trying to use the Vxworks skin, with RealTime task. But I've got
a > problem during a task test.
>>
>> I would like to configure the scheduler in Round Robin mode and
launch a=20
>> first blocking task, and a second one, with an higher priority, which

>> kill the first one after a while. But the first task never give back
the
>> CPU and my computer freeze !=20
>Your code does not make what you believe: the first created task
preempts the module init code immediately, which never has a chance to
create a second task.
>> (...)
>> xnpod_activate_rr(SSEXEC_TIMESLICE);
>You are supposed to use kernelTimeSlice() to enable round-robin.
--=20
=20
Thank you for your answer Gilles !
Unfortunately, I still have the same problem with the correction, see
bellow. Is my roundrobin configuration is entirely correct (RR,Ticks and
time slice)?
is a task can take 100% of the CPU?
=20
#include "vxworks/vxworks.h"=20
=20
#define CLK_RATE 50
#define SSEXEC_SYSCLKRATE 1000=20
#define SSEXEC_TIMESLICE 10=20
=20
static int IdTasktTest ;
static int IdTasktDestroy ;
=20
=20
void TaskTest(void)
{=20
    while(1);
        //CTime::sleepInMs(1000);  //  Work without any problem if I put
this ligne
}
=20
void Destroy()
{=20
    taskDelay(1000);
    taskDelete(IdTasktTest);
    printf("**TasktTest Destroy**\n");=20
}
=20
int CreateTask(void)
{
    IdTasktDestroy =3D taskSpawn("Destroy",1, VX_FP_TASK,
0x5000,(FUNCPTR)Destroy, 0,0,0,0,0,0,0,0,0,0 );
    taskDelay(6);
    IdTasktTest =3D taskSpawn( "tTest",10, VX_FP_TASK,
0x5000,(FUNCPTR)TaskTest,0,0,0,0,0,0,0,0,0,0 );=20
    taskDelay(6);
=20
    printf("sortie de taskSpawn on Test \n");
    return OK;
}
=20
int rootTask (void)
{=20
    kernelTimeSlice(SSEXEC_TIMESLICE);=20
    tickSet(SSEXEC_SYSCLKRATE);
    //sysClkRateSet(SSEXEC_SYSCLKRATE):
    CreateTask();
    return OK;
}
=20
int root_thread_init (void)
{
    return
!IdTasktROOT=3DtaskSpawn("root",0,VX_FP_TASK,0x5000,(FUNCPTR)rootTask,
0,0,0,0,0,0,0,0,0,0 );=20
}
=20

------_=_NextPart_001_01C65E3B.FD171E70
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt; I'm trying to use the Vxworks =
skin,=20
with RealTime task. But I've got a &gt; problem during a task=20
test.</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt;</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt; I would like to configure the =
scheduler=20
in Round Robin mode and launch a </FONT></FONT></ADDRESS>
<ADDRESS><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt; first blocking task, and a =
second=20
one,&nbsp;with an higher priority, which </FONT></FONT></FONT></ADDRESS>
<ADDRESS><FONT><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt; kill the first one after a =
while. But=20
the first task never give back the</FONT></FONT></FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt; CPU and my computer freeze !=20
</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>Your code does not make what you =
believe:=20
the first created task preempts the module init code immediately, which =
never=20
has a chance to create a second task.</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt; (...)</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>&gt;=20
xnpod_activate_rr(SSEXEC_TIMESLICE);</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&gt;</SPAN>You are supposed to use =
kernelTimeSlice() to=20
enable round-robin.</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>-- </FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>Thank you for your answer<SPAN=20
class=3D889434113-12042006> </SPAN>Gilles !</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><FONT face=3D"Times New =
Roman"><SPAN=20
class=3D889434113-12042006>Unfortunately,</SPAN></FONT>&nbsp;<SPAN=20
class=3D889434113-12042006>I still&nbsp;have the same problem with the =
correction,=20
see bellow. Is my roundrobin configuration is&nbsp;entirely correct =
(RR,Ticks=20
and time slice)?</SPAN></FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D889434113-12042006>is a task=20
can take 100% of the CPU?</SPAN></FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>#include "vxworks/vxworks.h" =
</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>#define CLK_RATE =
50</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>#define SSEXEC_SYSCLKRATE 1000=20
</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>#define SSEXEC_TIMESLICE 10 =
</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>static int IdTasktTest =
;</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>static int IdTasktDestroy =
;</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>void =
TaskTest(void)</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>{ </FONT></ADDRESS>
<ADDRESS><FONT><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>while(1);</FONT></FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN>//CTime::sleepInMs(1000);<SPAN class=3D685462115-11042006>&nbsp;=20
//&nbsp;&nbsp;Work without any problem if I put this=20
ligne</SPAN></FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>void Destroy()</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>{ </FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>taskDelay(1000);</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>taskDelete(IdTasktTest);</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp; </SPAN>printf("**TasktTest =

Destroy**\n"); </FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>int =
CreateTask(void)</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>{</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp; </SPAN>IdTasktDestroy =3D=20
taskSpawn("Destroy",1, VX_FP_TASK, 0x5000,(FUNCPTR)Destroy, =
0,0,0,0,0,0,0,0,0,0=20
);</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>taskDelay(6);</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp; </SPAN>IdTasktTest =3D =
taskSpawn(=20
"tTest",10, VX_FP_TASK, 0x5000,(FUNCPTR)TaskTest,0,0,0,0,0,0,0,0,0,0 );=20
</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>taskDelay(6);</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp; </SPAN>printf("sortie de =
taskSpawn=20
on Test \n");</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp; </SPAN>return=20
OK;</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>int rootTask =
(void)</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>{ </FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>kernelTimeSlice(SSEXEC_TIMESLICE); </FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>tickSet(SSEXEC_SYSCLKRATE);</FONT></FONT></ADDRESS>
<ADDRESS><SPAN class=3D889434113-12042006><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;=20
//sysClkRateSet(SSEXEC_SYSCLKRATE):</FONT></SPAN></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp;=20
</SPAN>CreateTask();</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp; </SPAN>return=20
OK;</FONT></FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>int root_thread_init =
(void)</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial size=3D2>{</FONT></ADDRESS>
<ADDRESS><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D889434113-12042006>&nbsp;&nbsp;&nbsp; </SPAN>return=20
!IdTasktROOT=3DtaskSpawn("root",0,VX_FP_TASK,0x5000,(FUNCPTR)rootTask,=20
0,0,0,0,0,0,0,0,0,0 ); </FONT></FONT></ADDRESS>
<ADDRESS>}</ADDRESS><PRE>&nbsp;</PRE></BODY></HTML>

------_=_NextPart_001_01C65E3B.FD171E70--

