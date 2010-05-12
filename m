From: Bryan Hilterbrand <bhilterbrand@domain.hid>
Date: Wed, 12 May 2010 15:46:17 -0600
Message-ID: <D7352E9EB94BE54D8E052C5D9FE0932925D0A89EC1@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D7352E9EB94BE54D8E052C5D9FE0932925D0A89EC1seeredgeseert_"
MIME-Version: 1.0
Subject: [Xenomai-help] External interrupt never received
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_D7352E9EB94BE54D8E052C5D9FE0932925D0A89EC1seeredgeseert_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm using Xenomai 2.3.1 and uClinux 2007r1 on an embedded product that I in=
herited. The product runs on the Blackfin 536, and we have an external inte=
rrupt coming into PG8 (port G pin 8) of the processor. I created a test pro=
gram that takes a pin number as an input argument, creates a real-time task=
, creates a Xenomai interrupt within the task, and then waits for the inter=
rupt to occur. The application never gets past the rt_intr_wait(...).

Here is the test program:

#include <stdio.h>
#include <signal.h>

#include <asm-blackfin/mach-bf537/irq.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/intr.h>


#define INT_STACK_SIZE    0
#define INT_PRIORITY      71

RT_INTR             m_genericIntDescriptor;
RT_TASK             m_genericSrvrDescriptor;
int                 m_interruptPin           =3D 8;    // Default to port G=
 pin 8


void generic_irq_server(void *cookie)
{
    int    err           =3D 0;
    int    running       =3D 1;
    int    firstTime     =3D 1;
    int    count         =3D 0;
    RTIME  lastTicks     =3D 0;
    RTIME  curTicks      =3D 0;
    RTIME  elapsedTicks  =3D 0;

    printf("Initializing PG%d IRQ:\n", m_interruptPin); fflush(stdout);

    // Detector - Create a real-time interrupt
    err =3D rt_intr_create(&m_genericIntDescriptor, "GENERIC_PORTG_IRQ", IR=
Q_PG0 + m_interruptPin, I_NOAUTOENA);
    if (err < 0)
    {
        printf("ERROR: Could not create generic real-time interrupt: %d\n",=
 err);
        return;
    }

    printf("...IRQ_PG%d object created; entering wait loop\n", m_interruptP=
in); fflush(stdout);

    // Run forever
    while (running =3D=3D 1)
    {
        // Enable the interrupt
        rt_intr_enable(&m_genericIntDescriptor);

        err =3D rt_intr_wait(&m_genericIntDescriptor, TM_INFINITE);

        if (firstTime)
        {
            printf("PG%d int alive\n", m_interruptPin);
            firstTime =3D 0;
        }
    }
}

static void clean_exit(int sig)
{
    int err;

    rt_intr_disable(&m_genericIntDescriptor);
    rt_intr_delete(&m_genericIntDescriptor);
    rt_task_delete(&m_genericSrvrDescriptor);
}

/////////////////////////////////////////
// main
//
//
int main(int argc, char *argv[])
{
    int err =3D 0;

    mlockall(MCL_CURRENT | MCL_FUTURE);

    if (argc > 1)
    {
        m_interruptPin =3D atoi(argv[1]);
        printf("Configuring for pin %d\n", m_interruptPin);
    }

    // Create the generic interrupt server as a real-time task
    err =3D rt_task_create(&m_genericSrvrDescriptor, "GENERIC_PORTG_IRQ_SER=
VER", INT_STACK_SIZE, INT_PRIORITY, T_JOINABLE);
    if (err < 0)
    {
        printf("ERROR: Could not create real-time task for the generic inte=
rrupt server: %d\n", err);
        return -1;
    }

    printf("Interrupt task created\n"); fflush(stdout);

    // Start the generic interrupt server as a real-time task
    err =3D rt_task_start(&m_genericSrvrDescriptor, &generic_irq_server, NU=
LL);
    if (err < 0)
    {
        printf("ERROR: Could not start real-time task for the generic inter=
rupt server: %d\n", err);
        return -1;
    }

    printf("...task started\n"); fflush(stdout);

    signal(SIGTERM, clean_exit);
    signal(SIGINT, clean_exit);

    pause();

    fflush(NULL);
    return 0;
}

Do I need to set this interrupt up externally to this program (like in uCli=
nux or something)?

Is there something wrong with this program that needs to be fixed?

Thanks for any help you can give! I've been beating my head against the wal=
l for a long time, and the Blackfin uClinux forum wasn't able to help me.

Bryan


--_000_D7352E9EB94BE54D8E052C5D9FE0932925D0A89EC1seeredgeseert_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>I&#8217;m using Xenomai 2.3.1 and uClinux 2007r1 on an
embedded product that I inherited. The product runs on the Blackfin 536, an=
d we
have an external interrupt coming into PG8 (port G pin 8) of the processor.=
 I
created a test program that takes a pin number as an input argument, create=
s a real-time
task, creates a Xenomai interrupt within the task, and then waits for the
interrupt to occur. The application never gets past the rt_intr_wait(&#8230=
;).<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Here is the test program:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#include<=
/span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> &lt;stdio.=
h&gt;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#include<=
/span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> &lt;signal=
.h&gt;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#include<=
/span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> &lt;</span=
><b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>asm</span=
></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>-blackfin/m=
ach-bf537/irq.h&gt;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#include<=
/span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>
&lt;sys/mman.h&gt;</span><span style=3D'font-size:9.0pt;font-family:"Courie=
r New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#include<=
/span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>
&lt;native/task.h&gt;</span><span style=3D'font-size:9.0pt;font-family:"Cou=
rier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#include<=
/span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>
&lt;native/intr.h&gt;</span><span style=3D'font-size:9.0pt;font-family:"Cou=
rier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#define</=
span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> INT_STACK_=
SIZE&nbsp;&nbsp;&nbsp;
0</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>#define</=
span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> INT_PRIORI=
TY&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;71</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o=
:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>RT_INTR&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
m_genericIntDescriptor;</span><span style=3D'font-size:9.0pt;font-family:"C=
ourier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>RT_TASK&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
m_genericSrvrDescriptor;</span><span style=3D'font-size:9.0pt;font-family:"=
Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>int</span=
></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;m_interruptPin&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 8;&nbsp;&nbsp;&nbsp; </span><span style=3D'font-size:9.0pt;font-family:=
"Courier New";
color:#3F7D5F'>// Default to port G pin 8</span><span style=3D'font-size:9.=
0pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>void</spa=
n></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>
generic_irq_server(</span><b><span style=3D'font-size:9.0pt;font-family:"Co=
urier New";
color:#7F0055'>void</span></b><span style=3D'font-size:9.0pt;font-family:"C=
ourier New";
color:black'> *cookie)</span><span style=3D'font-size:9.0pt;font-family:"Co=
urier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>{</span><sp=
an
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>int</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
err&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;</spa=
n><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>int</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
running&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 1;</span><span style=3D'fon=
t-size:
9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>int</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
firstTime&nbsp;&nbsp;&nbsp;&nbsp; =3D 1;</span><span style=3D'font-size:9.0=
pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>int</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
RTIME&nbsp; lastTicks&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
RTIME&nbsp; curTicks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
RTIME&nbsp; elapsedTicks&nbsp; =3D 0;</span><span style=3D'font-size:9.0pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
printf(</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#2A00FF'>&quot;Initializing PG%d IRQ:\n&quot;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>,
m_interruptPin); fflush(stdout);</span><span style=3D'font-size:9.0pt;font-=
family:
"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p=
></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D=
5F'>//
Detector - Create a real-time interrupt</span><span style=3D'font-size:9.0p=
t;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
err =3D rt_intr_create(&amp;m_genericIntDescriptor, </span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#2A00FF'>&quot;GEN=
ERIC_PORTG_IRQ&quot;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>, IRQ_PG0 +
m_interruptPin, I_NOAUTOENA);</span><span style=3D'font-size:9.0pt;font-fam=
ily:
"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>if</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> (err &lt; =
0)</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
{</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#2A00FF'>&quot;ERROR: Could not create generic real-time interrupt:
%d\n&quot;</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:black'>, err);</span><span style=3D'font-size:9.0pt;font-family:"Cour=
ier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>return</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>;</span><sp=
an
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
}</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
printf(</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#2A00FF'>&quot;...IRQ_PG%d object created; entering wait loop\n&quot;=
</span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>,
m_interruptPin); fflush(stdout);</span><span style=3D'font-size:9.0pt;font-=
family:
"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D=
5F'>//
Run forever</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'=
><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>while</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> (running =
=3D=3D 1)</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
{</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D=
5F'>//
Enable the interrupt</span><span style=3D'font-size:9.0pt;font-family:"Cour=
ier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
rt_intr_enable(&amp;m_genericIntDescriptor);</span><span style=3D'font-size=
:9.0pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
err =3D rt_intr_wait(&amp;m_genericIntDescriptor, TM_INFINITE);</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>if</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> (firstTime=
)</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
{</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;printf(</span><span style=3D'font-size:9.0pt;font-f=
amily:
"Courier New";color:#2A00FF'>&quot;PG%d int alive\n&quot;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>,
m_interruptPin);</span><span style=3D'font-size:9.0pt;font-family:"Courier =
New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;firstTime =3D 0;</span><span style=3D'font-size:9.0=
pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
}</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
}</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>}</span><sp=
an
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:9.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>static</s=
pan></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> </span><b>=
<span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>void</spa=
n></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> clean_exit=
(</span><b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>int</span=
></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> sig)</span=
><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>{</span><sp=
an
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>int</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> err;</span=
><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
rt_intr_disable(&amp;m_genericIntDescriptor); </span><span style=3D'font-si=
ze:
9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
rt_intr_delete(&amp;m_genericIntDescriptor);</span><span style=3D'font-size=
:9.0pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
rt_task_delete(&amp;m_genericSrvrDescriptor);</span><span style=3D'font-siz=
e:
9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>}</span><sp=
an
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><span style=3D'font-size=
:9.0pt;
font-family:"Courier New"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D5F'>/////////=
////////////////////////////////</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D5F'>// main</=
span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D5F'>// </span=
><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D5F'>//</span>=
<span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><b><spa=
n
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>int</span=
></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> main(</spa=
n><b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>int</span=
></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> argc, </sp=
an><b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>char</spa=
n></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> *argv[])</=
span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>{</span><sp=
an
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>int</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> err =3D 0;=
</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
mlockall(MCL_CURRENT | MCL_FUTURE);</span><span style=3D'font-size:9.0pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>if</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> (argc &gt;=
 1)</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
{</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;m_interruptPin =3D atoi(argv[1]);</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;printf(</span><span style=3D'font-size:9.0pt;font-f=
amily:
"Courier New";color:#2A00FF'>&quot;Configuring for pin %d\n&quot;</span><sp=
an
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>,
m_interruptPin);</span><span style=3D'font-size:9.0pt;font-family:"Courier =
New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
}</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D=
5F'>//
Create the generic interrupt server as a real-time task</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
err =3D rt_task_create(&amp;m_genericSrvrDescriptor, </span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#2A00FF'>&quot;GEN=
ERIC_PORTG_IRQ_SERVER&quot;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>, INT_STACK=
_SIZE,
INT_PRIORITY, T_JOINABLE);</span><span style=3D'font-size:9.0pt;font-family=
:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>if</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> (err &lt; =
0)</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
{</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#2A00FF'>&quot;ERROR: Could not create real-time task for the generic
interrupt server: %d\n&quot;</span><span style=3D'font-size:9.0pt;font-fami=
ly:
"Courier New";color:black'>, err);</span><span style=3D'font-size:9.0pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>return</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> -1;</span>=
<span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
}</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
printf(</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#2A00FF'>&quot;Interrupt task created\n&quot;</span><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>);
fflush(stdout);</span><span style=3D'font-size:9.0pt;font-family:"Courier N=
ew"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#3F7D=
5F'>//
Start the generic interrupt server as a real-time task</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
err =3D rt_task_start(&amp;m_genericSrvrDescriptor, &amp;generic_irq_server=
, </span><b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:#7F0055'>NULL</spa=
n></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>);</span><s=
pan
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>if</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> (err &lt; =
0)</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
{</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#2A00FF'>&quot;ERROR: Could not start real-time task for the generic
interrupt server: %d\n&quot;</span><span style=3D'font-size:9.0pt;font-fami=
ly:
"Courier New";color:black'>, err);</span><span style=3D'font-size:9.0pt;
font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>return</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> -1;</span>=
<span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
}</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:=
p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
printf(</span><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#2A00FF'>&quot;...task started\n&quot;</span><span style=3D'font-size=
:9.0pt;
font-family:"Courier New";color:black'>); fflush(stdout);</span><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
signal(SIGTERM, clean_exit);</span><span style=3D'font-size:9.0pt;font-fami=
ly:
"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
signal(SIGINT, clean_exit);</span><span style=3D'font-size:9.0pt;font-famil=
y:
"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
pause();</span><span style=3D'font-size:9.0pt;font-family:"Courier New"'><o=
:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'><o:p>&nbsp;</o:p></span=
></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
fflush(</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";
color:#7F0055'>NULL</span></b><span style=3D'font-size:9.0pt;font-family:"C=
ourier New";
color:black'>);</span><span style=3D'font-size:9.0pt;font-family:"Courier N=
ew"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'>&nbsp;&nbsp=
;&nbsp;
</span><b><span style=3D'font-size:9.0pt;font-family:"Courier New";color:#7=
F0055'>return</span></b><span
style=3D'font-size:9.0pt;font-family:"Courier New";color:black'> 0</span><s=
pan
style=3D'font-size:9.0pt;font-family:"Courier New"'>;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in;text-autospace:none'><span
style=3D'font-size:9.0pt;font-family:"Courier New"'>}<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Do I need to set this interrupt up externally to this =
program
(like in uClinux or something)?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Is there something wrong with this program that needs =
to be
fixed?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks for any help you can give! I&#8217;ve been beat=
ing my
head against the wall for a long time, and the Blackfin uClinux forum wasn&=
#8217;t
able to help me.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Bryan<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_D7352E9EB94BE54D8E052C5D9FE0932925D0A89EC1seeredgeseert_--

