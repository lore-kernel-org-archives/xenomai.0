Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65D7C.CD58FA6A"
Date: Tue, 11 Apr 2006 17:30:02 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290AA05846@domain.hid>
From: "Thomas, Brieuc \(GE Healthcare\)" <Brieuc.Thomas@domain.hid>
Subject: [Xenomai-help] Vxworks skin & Task priority
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

------_=_NextPart_001_01C65D7C.CD58FA6A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello,   =20

I'm trying to use the Vxworks skin,  with RealTime task. But I've got a
problem during a task test.

I would like to configure the scheduler in Round Robin mode and launch a
first blocking task, and a second one, with an higher priority, which
kill the first one after a while. But the first task never give back the
CPU and my computer freeze !   =20

You can give a look to my program:

#include "vxworks/vxworks.h"=20
#define CLK_RATE 50
#define SSEXEC_SYSCLKRATE 1000=20
#define SSEXEC_TIMESLICE 10=20
#include "CTime.h"
static int IdTasktTest ;
static int IdTasktDestroy ;
=20
void TaskTest(void)
{     while(1);
      //CTime::sleepInMs(1000);  //  Work without any problem if I put
this ligne.
}
=20
void Destroy()
{
   CTime::sleepInMs(4000);
   taskDelete(IdTasktTest);
   printf("TasktTest Destroy\n");=20
}
=20
int CreateTask(void)
{
   IdTasktTest =3D taskSpawn ( "tTest",20, VX_FP_TASK,0x5000,
(FUNCPTR)TaskTest, 0,0,0,0,0,0,0,0,0,0 );
   IdTasktDestroy =3D taskSpawn ("Destroy",1, VX_FP_TASK,
0x5000,(FUNCPTR)Destroy, 0,0,0,0,0,0,0,0,0,0 );
  =20
   if ((IdTasktTest=3D=3DERROR)||(IdTasktDestroy=3D=3DERROR)) {
      printf("Error in taskSpawn on tTest or watchdog \n");
      return ERROR;
      }
printf("sortie de taskSpawn on Test \n");
return OK;
}
=20
int root_thread_init (void)
{=20
   xnpod_activate_rr(SSEXEC_TIMESLICE);
=20
   CreateTask();
   return 0;
}
=20
void root_thread_exit (void)
{
   taskDelete(IdTasktDestroy);
}
=20
Any Ideas ?
=20
Thanks in advance.

Brieuc THOMAS


------_=_NextPart_001_01C65D7C.CD58FA6A
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial>
<P><FONT size=3D2>Hello,&nbsp;&nbsp;&nbsp; </FONT></P>
<P><FONT size=3D2>I'm trying to use the Vxworks skin,&nbsp; with =
RealTime task.=20
But I've got a problem during a task test.</FONT></P>
<P><FONT size=3D2>I would like to configure the scheduler in Round Robin =
mode and=20
launch a first blocking task, and a second one, with an higher priority, =
which=20
kill the first one after a while. But the first task never give back the =
CPU and=20
my computer freeze !&nbsp;&nbsp;&nbsp; </FONT></P>
<P><FONT size=3D2>You can give a look to my program:</FONT></P>
<ADDRESS><FONT size=3D2>#include "vxworks/vxworks.h" </FONT></ADDRESS>
<ADDRESS><FONT size=3D2>#define CLK_RATE 50</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>#define SSEXEC_SYSCLKRATE 1000 </FONT></ADDRESS>
<ADDRESS><FONT size=3D2>#define SSEXEC_TIMESLICE 10 </FONT></ADDRESS>
<ADDRESS><FONT size=3D2>#include "CTime.h"</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>static int IdTasktTest ;</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>static int IdTasktDestroy ;</FONT></ADDRESS>
<ADDRESS><FONT size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT size=3D2>void TaskTest(void)</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>{<SPAN=20
class=3D407243708-11042006>&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>=20
while(1);</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN=20
class=3D685462115-11042006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN>//C=
Time::sleepInMs(1000);<SPAN=20
class=3D685462115-11042006>&nbsp; //&nbsp;&nbsp;Work without any problem =
if I put=20
this ligne.</SPAN></FONT></ADDRESS>
<ADDRESS><FONT size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT size=3D2>void Destroy()</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>{</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>CTime::sleepInMs(4000);</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>taskDelete(IdTasktTest);</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>printf("TasktTest Destroy\n"); </FONT></ADDRESS>
<ADDRESS><FONT size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT size=3D2>int CreateTask(void)</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>{</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>IdTasktTest =3D taskSpawn<SPAN class=3D407243708-11042006> =
</SPAN>(=20
"tTest",20, VX_FP_TASK,0x5000, (FUNCPTR)TaskTest, 0,0,0,0,0,0,0,0,0,0=20
);</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>IdTasktDestroy =3D taskSpawn<SPAN class=3D407243708-11042006>=20
</SPAN>("Destroy",1, VX_FP_TASK, 0x5000,(FUNCPTR)Destroy, =
0,0,0,0,0,0,0,0,0,0=20
);</FONT></ADDRESS>
<ADDRESS><SPAN class=3D407243708-11042006><FONT size=3D2>&nbsp;&nbsp;=20
</FONT></SPAN></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006><SPAN=20
class=3D407243708-11042006>&nbsp;&nbsp; </SPAN></SPAN>if=20
((IdTasktTest=3D=3DERROR)||(IdTasktDestroy=3D=3DERROR)) =
{</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN =
class=3D407243708-11042006>&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D407243708-11042006>&nbsp;&nbsp; </SPAN></SPAN>printf("Error in =
taskSpawn=20
on tTest or watchdog \n");</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN=20
class=3D407243708-11042006>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>return=20
ERROR;</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN =
class=3D407243708-11042006>&nbsp;&nbsp;&nbsp;<SPAN=20
class=3D407243708-11042006>&nbsp;&nbsp; </SPAN></SPAN>}</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>printf("sortie de taskSpawn on Test =
\n");</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>return OK;</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT size=3D2>int root_thread_init (void)</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>{ </FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>xnpod_activate_rr(SSEXEC_TIMESLICE);</FONT></ADDRESS>
<ADDRESS><FONT size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>CreateTask();</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp; =
</SPAN>return=20
0;</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>}</FONT></ADDRESS>
<ADDRESS><FONT size=3D2></FONT>&nbsp;</ADDRESS>
<ADDRESS><FONT size=3D2>void root_thread_exit (void)</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>{</FONT></ADDRESS>
<ADDRESS><FONT size=3D2><SPAN class=3D407243708-11042006>&nbsp;&nbsp;=20
</SPAN>taskDelete(IdTasktDestroy);</FONT></ADDRESS>
<ADDRESS><FONT size=3D2>}</FONT></ADDRESS><PRE><SPAN =
class=3D407243708-11042006></SPAN><FONT =
size=3D2>&nbsp;</FONT></PRE><PRE><SPAN class=3D407243708-11042006><FONT =
size=3D2>Any Ideas ?</FONT></SPAN></PRE><PRE><SPAN =
class=3D407243708-11042006><SPAN class=3D407243708-11042006><FONT =
face=3DArial></FONT></SPAN></SPAN><FONT =
size=3D2>&nbsp;</FONT></PRE><PRE><SPAN class=3D407243708-11042006><SPAN =
class=3D407243708-11042006><FONT face=3DArial size=3D2>Thanks in =
advance.</FONT></SPAN></PRE>
<P><SPAN class=3D407243708-11042006><FONT face=3DArial size=3D2>Brieuc=20
THOMAS</FONT></SPAN></P></SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C65D7C.CD58FA6A--

