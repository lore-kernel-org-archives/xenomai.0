MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAF37E.99ACADC6"
Content-class: urn:content-classes:message
Date: Fri, 14 May 2010 09:00:38 -0700
Message-ID: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
From: "Sherk Chung" <sherk.chung@domain.hid>
Subject: [Xenomai-help] rt_mutex created prior to main causes board to
	freeze?
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

------_=_NextPart_001_01CAF37E.99ACADC6
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

We are using Xenomai on an AT91 ARM board.  We wrote a program that
creates multiple Xenomai tasks, which use rt_mutexes to when accessing
some shared global variables.  The rt_mutexes used are declared
globally, as in the example below.  Since the objects sharedVar1,
shredVar2, etc. are declared on the global stack, the rt_mutexes are
created prior to main() getting executed.  The problem we are having is
that our program is causing our HW to freeze up on program load, it
never gets to the first line of main(), and our HW supplier pointed out
that we must call mlockall() and the set up the signal handlers before
creating the mutexes.

=20

Is there a problem with creating rt_mutexes the way we are doing, and
should that cause the ARM board to freeze?  (the same program loads fine
on an x86)

Thanks in advance.


-Sherk

=20

-------------

=20

#include <native/queue.h>

#include <native/mutex.h>

#include "main.h"

=20

template <class T>

class SyncObject {

    private:

RT_MUTEX mutex;

    public:

T value;

SyncObject(const char* desc){  rt_mutex_create(&mutex, desc);  }

               ~SyncObject(){  rt_mutex_delete(&mutex);  }

               void lock(){  rt_mutex_acquire(&mutex, TM_INFINITE);  }=20

               void unlock(){  rt_mutex_release(&mutex);   }

} ;

=20

SyncObject<int> g_sharedVar1; // global sync object used by multiple
tasks

SyncObject<int> g_sharedVar2; // global sync object used by multiple
tasks

SyncObject<int> g_sharedVar3; // global sync object used by multiple
tasks

=20

main(argv, argc)

{

  printf ("Starting execution of main");   //  Program crashes before
executing this line of code

=20

  signal(SIGTERM, handleShutdownSignal);

  signal(SIGINT, handleShutdownSignal);

=20

  signal(SIGXCPU, handleTaskModeChange); // signal num 24

=20

  mlockall(MCL_CURRENT | MCL_FUTURE);

=20

  // create all queues

  err =3D rt_queue_create(&g_output_data_queue, =
g_output_data_queue_name,
OUTPUT_DATA_Q_LEN * sizeof(OutputData), OUTPUT_DATA_Q_LEN, Q_SHARED);

  err =3D rt_queue_create(&g_log_queue, g_log_queue_name, LOG_Q_LEN *
sizeof(LogMessage), LOG_Q_LEN, Q_SHARED);

=20

  // create all remaining tasks ///////

  err =3D rt_task_spawn(&rtTask1,"Task1", 0, 2, 0, &task1, =
&errHandler1);

  err =3D rt_task_spawn(&rtTask2," Task2", 0, 10, 0, &task2,
&errHandler2);

  err =3D rt_task_spawn(&rtTask3,"Task3", 0, 10, 0, &task3, =
&errHandler3);

  err =3D rt_task_spawn(&rtTask4,"Task4", 0, 2, 0, &task4, & =
errHandler4);

=20

}


------_=_NextPart_001_01CAF37E.99ACADC6
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" =
xmlns:p=3D"urn:schemas-microsoft-com:office:powerpoint" =
xmlns:a=3D"urn:schemas-microsoft-com:office:access" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" =
xmlns:s=3D"uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" =
xmlns:rs=3D"urn:schemas-microsoft-com:rowset" xmlns:z=3D"#RowsetSchema" =
xmlns:b=3D"urn:schemas-microsoft-com:office:publisher" =
xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadsheet" =
xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" =
xmlns:odc=3D"urn:schemas-microsoft-com:office:odc" =
xmlns:oa=3D"urn:schemas-microsoft-com:office:activation" =
xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" =
xmlns:rtc=3D"http://microsoft.com/officenet/conferencing" =
xmlns:D=3D"DAV:" xmlns:Repl=3D"http://schemas.microsoft.com/repl/" =
xmlns:mt=3D"http://schemas.microsoft.com/sharepoint/soap/meetings/" =
xmlns:x2=3D"http://schemas.microsoft.com/office/excel/2003/xml" =
xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" =
xmlns:ois=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" =
xmlns:dir=3D"http://schemas.microsoft.com/sharepoint/soap/directory/" =
xmlns:ds=3D"http://www.w3.org/2000/09/xmldsig#" =
xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint/dsp" =
xmlns:udc=3D"http://schemas.microsoft.com/data/udc" =
xmlns:xsd=3D"http://www.w3.org/2001/XMLSchema" =
xmlns:sub=3D"http://schemas.microsoft.com/sharepoint/soap/2002/1/alerts/"=
 xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#" =
xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" =
xmlns:sps=3D"http://schemas.microsoft.com/sharepoint/soap/" =
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance" =
xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/soap" =
xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" =
xmlns:udcp2p=3D"http://schemas.microsoft.com/data/udc/parttopart" =
xmlns:wf=3D"http://schemas.microsoft.com/sharepoint/soap/workflow/" =
xmlns:dsss=3D"http://schemas.microsoft.com/office/2006/digsig-setup" =
xmlns:dssi=3D"http://schemas.microsoft.com/office/2006/digsig" =
xmlns:mdssi=3D"http://schemas.openxmlformats.org/package/2006/digital-sig=
nature" =
xmlns:mver=3D"http://schemas.openxmlformats.org/markup-compatibility/2006=
" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns:mrels=3D"http://schemas.openxmlformats.org/package/2006/relationshi=
ps" xmlns:spwp=3D"http://microsoft.com/sharepoint/webpartpages" =
xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/2006/types"=
 =
xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/2006/messag=
es" =
xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/SlideLibrary/=
" =
xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortalServer/Pub=
lishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" =
xmlns:st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
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

<p class=3DMsoNormal>We are using Xenomai on an AT91 ARM board.&nbsp; We =
wrote a
program that creates multiple Xenomai tasks, which use rt_mutexes to =
when
accessing some shared global variables.&nbsp; The rt_mutexes used are =
declared
globally, as in the example below.&nbsp; Since the objects sharedVar1, =
shredVar2,
etc. are declared on the global stack, the rt_mutexes are created prior =
to main()
getting executed.&nbsp; The problem we are having is that our program is
causing our HW to freeze up on program load, it never gets to the first =
line of
main(), and our HW supplier pointed out that we must call mlockall() and =
the
set up the signal handlers before creating the mutexes.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Is there a problem with creating rt_mutexes the way =
we are
doing, and should that cause the ARM board to freeze?&nbsp; (the same =
program loads
fine on an x86)<o:p></o:p></p>

<p class=3DMsoNormal>Thanks in advance.<o:p></o:p></p>

<p class=3DMsoNormal><br>
-Sherk<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>-------------<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>#include &lt;native/queue.h&gt;<o:p></o:p></p>

<p class=3DMsoNormal>#include &lt;native/mutex.h&gt;<o:p></o:p></p>

<p class=3DMsoNormal>#include &#8220;main.h&#8221;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>template &lt;class T&gt;<o:p></o:p></p>

<p class=3DMsoNormal>class SyncObject {<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; private:<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>RT_MUTEX =
mutex;<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; &nbsp;&nbsp;public:<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>T value;<o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-indent:.5in'>SyncObject(const char* =
desc){&nbsp;
rt_mutex_create(&amp;mutex, desc);&nbsp; }<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
~SyncObject(){&nbsp;
rt_mutex_delete(&amp;mutex);&nbsp; }<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void
lock(){&nbsp; rt_mutex_acquire(&amp;mutex, TM_INFINITE);&nbsp; } =
<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void
unlock(){&nbsp; rt_mutex_release(&amp;mutex);&nbsp;&nbsp; =
}<o:p></o:p></p>

<p class=3DMsoNormal>} ;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>SyncObject&lt;int&gt; g_sharedVar1; // global sync =
object
used by multiple tasks<o:p></o:p></p>

<p class=3DMsoNormal>SyncObject&lt;int&gt; g_sharedVar2; // global sync =
object
used by multiple tasks<o:p></o:p></p>

<p class=3DMsoNormal>SyncObject&lt;int&gt; g_sharedVar3; // global sync =
object
used by multiple tasks<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>main(argv, argc)<o:p></o:p></p>

<p class=3DMsoNormal>{<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; printf (&#8220;Starting execution of =
main&#8221;);&nbsp;&nbsp;
// &nbsp;Program crashes before executing this line of =
code<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp; signal(SIGTERM, =
handleShutdownSignal);<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; signal(SIGINT, =
handleShutdownSignal);<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp; signal(SIGXCPU, handleTaskModeChange); // =
signal num
24<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp; mlockall(MCL_CURRENT | =
MCL_FUTURE);<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp; // create all queues<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; err =3D =
rt_queue_create(&amp;g_output_data_queue,
g_output_data_queue_name, OUTPUT_DATA_Q_LEN * sizeof(OutputData),
OUTPUT_DATA_Q_LEN, Q_SHARED);<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; err =3D rt_queue_create(&amp;g_log_queue,
g_log_queue_name, LOG_Q_LEN * sizeof(LogMessage), LOG_Q_LEN, =
Q_SHARED);<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&nbsp; // create all remaining tasks =
///////<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; err =3D =
rt_task_spawn(&amp;rtTask1,&quot;Task1&quot;,
0, 2, 0, &amp;task1, &amp;errHandler1);<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; err =3D rt_task_spawn(&amp;rtTask2,&quot; =
Task2&quot;,
0, 10, 0, &amp;task2, &amp;errHandler2);<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; err =3D =
rt_task_spawn(&amp;rtTask3,&quot;Task3&quot;,
0, 10, 0, &amp;task3, &amp;errHandler3);<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; err =3D =
rt_task_spawn(&amp;rtTask4,&quot;Task4&quot;,
0, 2, 0, &amp;task4, &amp; errHandler4);<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>}<o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CAF37E.99ACADC6--

