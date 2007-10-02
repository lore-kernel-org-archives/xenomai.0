Message-Id: <200710020904.l9294G6p027811@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Tue, 2 Oct 2007 11:04:19 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002A_01C804E3.FB53A770"
In-Reply-To: <6EB3AFE7F3632E4BA457E506E6DAF4F61451A2@domain.hid>
Subject: [Xenomai-help] rt_task crash kernel
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

------=_NextPart_000_002A_01C804E3.FB53A770
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_002B_01C804E3.FB53A770"


------=_NextPart_001_002B_01C804E3.FB53A770
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I'm using Xenomai 2.3.4 with 2.6.20 kernel on an ARM PXA270 board.

The installation was executed successfully.

 

Now I'm trying to insert a small test module (source code is attached) but
the kernel crashes on rt_task_start().

I have tried the same module on another x86 machine and there is no problem.


I have tried with or without rt_task_set_periodic in aperiodic and periodic
timer mode but the result is the same.

 

Do you have an idea?

 

Regards

 

This message contains information that may be privileged or confidential and
is the property of the Capgemini Group. It is intended only for the person
to whom it is addressed. If you are not the intended recipient, you are not
authorized to read, print, retain, copy, disseminate, distribute, or use
this message or any part thereof. If you receive this message in error,
please notify the sender immediately and delete all copies of this message.

	

------=_NextPart_001_002B_01C804E3.FB53A770
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<title>RE: [Xenomai-core] crashing 2.6.22</title>
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Hi,<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>I&#8217;m using =
Xenomai
2.3.4 with 2.6.20 kernel on an ARM PXA270 =
board.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>The installation =
was executed
successfully.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Now I&#8217;m =
trying to
insert a small test module (source code is attached) but the kernel =
crashes on <i><span
style=3D'font-style:italic'>rt_task_start()</span></i>.<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>I have tried the =
same
module on another x86 machine and there is no problem. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>I have tried =
with or
without <i><span =
style=3D'font-style:italic'>rt_task_set_periodic</span></i> in
aperiodic and periodic timer mode but the result is the =
same.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Do you have an =
idea?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Regards<o:p></o:p=
></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

</div>

</body>

</html>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000>This message =
contains information that may be privileged or confidential and is the =
property of the Capgemini Group. It is intended only for the person to =
whom it is addressed. If you are not the intended recipient,  you are =
not authorized to read, print, retain, copy, disseminate,  distribute, =
or use this message or any part thereof. If you receive this  message in =
error, please notify the sender immediately and delete all  copies of =
this message.<br>
<br>
</font></td></tr></table>
------=_NextPart_001_002B_01C804E3.FB53A770--

------=_NextPart_000_002A_01C804E3.FB53A770
Content-Type: text/plain;
	name="myModule_m.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="myModule_m.c"

/*******************************************************************
 * isrtimer_m.c=20
 *******************************************************************/

#include <native/task.h>
#include <native/intr.h>
#include <native/alarm.h>

#define STACK_SIZE         8192        /* Taille de la pile par d=E9faut =
*/
#define MS                 1000000     /* 1 ms exprim=E9 en ns */
#define TIMER_PERIODIC     1           /* 1: timer p=E9riodique, 0: =
timer ap=E9riodique */

RT_TASK myTask;
RT_ALARM myAlarm;

int err; /* stockage du code d'erreur */


/* cleanup_module() */
void __exit cleanup_module (void) {

  printk("#irqtimer: cleanup\n");

  rt_task_delete(&myTask);

  printk("Bye bye!\n");
}

/* T=E2che p=E9riodique */
void periodic(void *cookie) {
   while(1) {
      printk("debut 20ms\n");
      rt_timer_spin(20 * MS);
      printk("fin 20ms\n");
      rt_task_wait_period(NULL);
   }
}

/* init_module() */
int __init init_module (void) {

  printk("#module de test: starting...\n");

 =20
  /* Timer initialization */
  if (TIMER_PERIODIC)
    err =3D rt_timer_set_mode(MS);   /* periodic mode, one tick will be =
equal to 1 ms */=20
  else
    err =3D rt_timer_set_mode(TM_ONESHOT);

  if (err !=3D 0) {
    printk("Error timer: %d\n", err);
    return -1;
  }


  /*Cr=E9ation de la tache*/
  rt_task_create(&myTask, "taskCharge", STACK_SIZE, 10, 0);
  //rt_task_set_periodic(&myTask,TM_NOW,50*(TIMER_PERIODIC?1:MS));
  rt_task_start(&myTask, periodic, NULL);

  return 0;
}

MODULE_LICENSE("GPL");

------=_NextPart_000_002A_01C804E3.FB53A770--


