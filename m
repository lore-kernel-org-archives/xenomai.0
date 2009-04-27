From: "Wayne Call" <wcall@domain.hid>
Date: Mon, 27 Apr 2009 11:16:31 -0600
Message-ID: <000001c9c75b$e8f288d0$bad79a70$@com>
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0001_01C9C729.9E5818D0"
Content-Language: en-us
Subject: [Xenomai-help] rt_intr_wait
Reply-To: wcall@domain.hid
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

This is a multipart message in MIME format.

------=_NextPart_000_0001_01C9C729.9E5818D0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0002_01C9C729.9E5818D0"


------=_NextPart_001_0002_01C9C729.9E5818D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

The code below attempts to process an interrupt in user space.  The IRQ is
set at 26, and this interrupt fires at once per second.  If the
rt_intr_create sets the mode to I_NOAUTOENA, the rt_intr_wait detects one
interrupt, and then no other interrupts are detected.  Likewise for if the
mode is set to I_PROPAGATE.  If the mode is set to 0, it appears that the
rt_intr_wait detects interrupts at a very high rate, possible thousands per
second.  It appears that the code is detecting some other interrupt, and not
the IRQ at 26.

 

Below is the irq file and stat file for when the mode is set to I_NOAUTOENA
or I_PROPAGATE.

 



 



 

Is there a step that I'm missing to get the rt_intr_wait to recognize the
correct IRQ?

 

Wayne

 

 

 

//

// pwm_precon.c

// 

 

#include <sys/mman.h>

#include <signal.h>

#include <native/task.h>

#include <native/intr.h>

#include <stdio.h>

#define COMPILE_LPL_DEBUG           1

#include "../lplLib/lplDebug.h"

 

#define LPL_PWM_PRECON_IRQ_NUMBER   26

#define LPL_PWM_PRECON_TASK_PRIO    99

#define LPL_PWM_PRECON_TASK_MODE    0

#define LPL_PWM_PRECON_TASK_STKSZ   0

 

 

RT_INTR     m_interruptDescriptor;

RT_TASK     m_serverDescriptor;

 

long int    m_isrCounter = 0;

 

 

void cleanup(int sig);

 

 

void lpl_pwm_precon_irq_server(void *cookie)

{

    int err;

 

    for (;;) 

    {

        // Wait for next interrupt

        err = rt_intr_wait(&m_interruptDescriptor, TM_INFINITE);

        if (err > 0) 

        {

            LPL_DEBUG("process interrupt", m_isrCounter, %d); 

        }

        m_isrCounter++;

        LPL_DEBUG("isr real-time interrupt", err, %d); 

    }

}

 

 

int main (int argc, char *argv[])

{

    int err = 0;

    int bfinTimerStatus;

 

    mlockall(MCL_CURRENT | MCL_FUTURE);

    err = rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
LPL_PWM_PRECON_IRQ_NUMBER, I_NOAUTOENA);

//    err = rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
LPL_PWM_PRECON_IRQ_NUMBER, I_PROPAGATE);

//    err = rt_intr_create(&m_interruptDescriptor, "PWM_PRECON_IRQ",
LPL_PWM_PRECON_IRQ_NUMBER, 0);

    LPL_DEBUG("create real-time interrupt", err, %d); 

    err = rt_task_create(&m_serverDescriptor, "PWM_PRECON_IRQ_SERVER",
LPL_PWM_PRECON_TASK_STKSZ, 

                         LPL_PWM_PRECON_TASK_PRIO,
LPL_PWM_PRECON_TASK_MODE);

    LPL_DEBUG("create real-time task", err, %d); 

    if (!err) 

    {

        rt_task_start(&m_serverDescriptor, &lpl_pwm_precon_irq_server,
NULL);

        LPL_DEBUG("start real-time task", err, %d);

        rt_intr_enable(&m_interruptDescriptor); 

        LPL_DEBUG("enable real-time interrupt", err, %d);

    }

 

    signal(SIGTERM, cleanup);

    signal(SIGINT, cleanup);

 

    pause();

 

    fflush(NULL);

}

 

 

void cleanup(int sig)

{

    int err = 0;

 

    rt_intr_disable(&m_interruptDescriptor); 

    LPL_DEBUG("disable real-time interrupt", err, %d); 

    rt_intr_delete(&m_interruptDescriptor);

    LPL_DEBUG("delete real-time interrupt", err, %d); 

    rt_task_delete(&m_serverDescriptor);

    LPL_DEBUG("delete real-time task", err, %d); 

}

 

 


------=_NextPart_001_0002_01C9C729.9E5818D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"2050" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>The code below attempts to process an interrupt in =
user
space.&nbsp; The IRQ is set at 26, and this interrupt fires at once per
second.&nbsp; If the rt_intr_create sets the mode to I_NOAUTOENA, the =
rt_intr_wait
detects one interrupt, and then no other interrupts are detected.&nbsp;
Likewise for if the mode is set to I_PROPAGATE.&nbsp; If the mode is set =
to 0, it
appears that the rt_intr_wait detects interrupts at a very high rate, =
possible
thousands per second.&nbsp; It appears that the code is detecting some =
other
interrupt, and not the IRQ at 26.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Below is the irq file and stat file for when the =
mode is set
to I_NOAUTOENA or I_PROPAGATE.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><img width=3D669 height=3D110 =
id=3D"Picture_x0020_1"
src=3D"cid:image001.png@domain.hid"><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><img width=3D669 height=3D122 =
id=3D"Picture_x0020_2"
src=3D"cid:image002.png@domain.hid"><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Is there a step that I&#8217;m missing to get the
rt_intr_wait to recognize the correct IRQ?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Wayne<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'background:white'><i><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:green'>//</span></i><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><i><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:green'>// pwm_precon.c</span></i><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><i><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:green'>// </span></i><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#include</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&lt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>sys/mman.h</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&gt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#include</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&lt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>signal.h</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&gt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#include</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&lt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>native/task.h</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&gt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#include</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&lt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>native/intr.h</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&gt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#include</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&lt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>stdio.h</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>&gt;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#define</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>
COMPILE_LPL_DEBUG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; </span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy'>1</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#include</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;../lplLib/lplDebug.h&quot;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#define</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>
LPL_PWM_PRECON_IRQ_NUMBER&nbsp;&nbsp; </span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:navy'>26</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#define</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>
LPL_PWM_PRECON_TASK_PRIO&nbsp;&nbsp;&nbsp; </span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:navy'>99</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#define</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>
LPL_PWM_PRECON_TASK_MODE&nbsp;&nbsp;&nbsp; </span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:navy'>0</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:olive'>#define</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>
LPL_PWM_PRECON_TASK_STKSZ&nbsp;&nbsp; </span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:navy'>0</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>RT_INTR&nbsp;&nbsp;&nbsp;&nbsp;
m_interruptDescriptor;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>RT_TASK&nbsp;&nbsp;&nbsp;&nbsp;
m_serverDescriptor;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:purple'>long</span></b><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'> </span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;
m_isrCounter =3D </span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:navy'>0</span><span style=3D'font-size:10.0pt;font-family:"Courier =
New";
color:black'>;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:purple'>void</span></b><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'> =
<b>cleanup</b>(</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
sig);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:purple'>void</span></b><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'> =
<b>lpl_pwm_precon_irq_server</b>(</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>void</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
*cookie)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:maroon'>{</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
err;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>for</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> (;;) =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; </span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>{</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><i><span style=3D'font-size:10.0pt;font-family:"Courier =
New";color:green'>//
Wait for next interrupt</span></i><span =
style=3D'font-size:10.0pt;font-family:
"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
err =3D <b>rt_intr_wait</b>(&amp;m_interruptDescriptor, =
TM_INFINITE);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><b><span style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>if</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> (err =
&gt; </span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy'>0</span><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>) =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>{</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
<b>LPL_DEBUG</b>(</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:teal'>&quot;process interrupt&quot;</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>, m_isrCounter, %d); =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>}</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
m_isrCounter++;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>LPL_DEBUG</b>(</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:teal'>&quot;isr real-time interrupt&quot;</span><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'>, err, %d); =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; </span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>}</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:maroon'>}</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:purple'>int</span></b><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'> <b>main</b> =
(</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> argc, =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>char</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
*argv</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>[]</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:maroon'>{</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> err =
=3D </span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy'>0</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>
bfinTimerStatus;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>mlockall</b>(MCL_CURRENT
| MCL_FUTURE);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; err =3D =
<b>rt_intr_create</b>(&amp;m_interruptDescriptor,
</span><span style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;PWM_PRECON_IRQ&quot;</span><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>,
LPL_PWM_PRECON_IRQ_NUMBER, I_NOAUTOENA);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><i><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:green'>//&nbsp;&nbsp;&nbsp; err =3D
rt_intr_create(&amp;m_interruptDescriptor, &quot;PWM_PRECON_IRQ&quot;,
LPL_PWM_PRECON_IRQ_NUMBER, I_PROPAGATE);</span></i><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><i><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:green'>//&nbsp;&nbsp;&nbsp; err =3D
rt_intr_create(&amp;m_interruptDescriptor, &quot;PWM_PRECON_IRQ&quot;,
LPL_PWM_PRECON_IRQ_NUMBER, 0);</span></i><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>LPL_DEBUG</b>(</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;create
real-time interrupt&quot;</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:black'>, err, %d); <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; err =3D =
<b>rt_task_create</b>(&amp;m_serverDescriptor,
</span><span style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;PWM_PRECON_IRQ_SERVER&quot;</span><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>,
LPL_PWM_PRECON_TASK_STKSZ, <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;
LPL_PWM_PRECON_TASK_PRIO, =
LPL_PWM_PRECON_TASK_MODE);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>LPL_DEBUG</b>(</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;create
real-time task&quot;</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:black'>, err, %d); <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>if</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> (!err) =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp; &nbsp;</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>{</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>rt_task_start</b>(&amp;m_serverDescriptor, =
&amp;lpl_pwm_precon_irq_server, </span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#C04000'>NULL</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>LPL_DEBUG</b>(</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:teal'>&quot;start real-time task&quot;</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>, err, %d);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>rt_intr_enable</b>(&amp;m_interruptDescriptor); =
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier =
New";color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>LPL_DEBUG</b>(</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:teal'>&quot;enable real-time interrupt&quot;</span><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'>, err, =
%d);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; </span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:maroon'>}</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#C04000'>signal</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>(SIGTERM,
cleanup);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#C04000'>signal</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>(SIGINT,
cleanup);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>pause</b>();<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#C04000'>fflush</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>(</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:#C04000'>NULL</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:maroon'>}</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><b><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:purple'>void</span></b><span =
style=3D'font-size:
10.0pt;font-family:"Courier New";color:black'> =
<b>cleanup</b>(</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> =
sig)<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:maroon'>{</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
</span><b><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:purple'>int</span></b><span
style=3D'font-size:10.0pt;font-family:"Courier New";color:black'> err =
=3D </span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:navy'>0</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:black'>;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>rt_intr_disable</b>(&amp;m_interruptDescriptor);
<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>LPL_DEBUG</b>(</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;disable
real-time interrupt&quot;</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:black'>, err, %d); <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>rt_intr_delete</b>(&amp;m_interruptDescriptor);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>LPL_DEBUG</b>(</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;delete
real-time interrupt&quot;</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:black'>, err, %d); <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>rt_task_delete</b>(&amp;m_serverDescriptor);<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'>&nbsp;&nbsp;&nbsp; =
<b>LPL_DEBUG</b>(</span><span
style=3D'font-size:10.0pt;font-family:"Courier =
New";color:teal'>&quot;delete
real-time task&quot;</span><span =
style=3D'font-size:10.0pt;font-family:"Courier New";
color:black'>, err, %d); <o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:maroon'>}</span><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'background:white'><span =
style=3D'font-size:10.0pt;
font-family:"Courier New";color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_001_0002_01C9C729.9E5818D0--

------=_NextPart_000_0001_01C9C729.9E5818D0
Content-Type: image/png;
	name="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <image001.png@domain.hid>

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
UQj8P355YBap2KUjAAAAAElFTkSuQmCC

------=_NextPart_000_0001_01C9C729.9E5818D0
Content-Type: image/png;
	name="image002.png"
Content-Transfer-Encoding: base64
Content-ID: <image002.png@domain.hid>

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

------=_NextPart_000_0001_01C9C729.9E5818D0--


