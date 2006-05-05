Message-ID: <44597D0700060D0D@n120.sc0.cp.net> (added by
	postmaster@domain.hid)
From: "Prashanti Bedapudi" <pbedapudi@domain.hid>
Date: Fri, 5 May 2006 14:24:42 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C6704F.C7DACB50"
In-Reply-To: 
Subject: [Xenomai-help] help with alarams
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

------=_NextPart_000_0000_01C6704F.C7DACB50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

 

Hi,

I am new to xenomai and linux. I am having some problems with alarms. Here
is a sample piece of code that I am using.

If you look at the main function, I have a while(!quit_now)  and I am
setting this flag in the alarm_handler. I am seeing some weird results. When
I have a printf statement in the while(!quit_now) loop as I have below, it
works as expected and the program terminates when the quit_flag is set. But
if I remove the printf() the program never terminates, it just hangs, even
if the quit_now flag is set. 

Any insight into this problem will be greatly appreciated.

 

 

alarm_handler()
{
        for(;;)
        {
           rt_alarm_wait();
           do_processing();
           if(condition met)
           {
               quit_now = TRUE;  /* global variable */
               break;
           }
        }
}
 
main()
{
        rt_alarm_create;
        rt_task_spawn();
        rt_alarm_start();
 
        while(!quit_now)
          printf("Inside while\n");
}
 

 

 

 

thanks in advance,

Shanti


------=_NextPart_000_0000_01C6704F.C7DACB50
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
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am new to xenomai and linux. I am having some =
problems
with alarms. Here is a sample piece of code that I am =
using.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If you look at the main function, I have a
while(!quit_now)&nbsp; and I am setting this flag in the alarm_handler. =
I am
seeing some weird results. When I have a printf statement in the
while(!quit_now) loop as I have below, it works as expected and the =
program
terminates when the quit_flag is set. But if I remove the printf() the =
program
never terminates, it just hangs, even if the quit_now flag is set. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any insight into this problem will be greatly =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<pre><font size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>alarm_handler()<o:p></o:p></span></font></pre>=
<pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>{<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
for(;;)<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
{<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp; rt_alarm_wait();<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp; do_processing();<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp; if(condition met)<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp; {<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; quit_now =3D TRUE;&nbsp; /* =
global variable */<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
break;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp; }<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>}<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>main()<o:p></o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>{<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_alarm_create;<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_task_spawn();<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
rt_alarm_start();<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre><pre><fon=
t
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
while(!quit_now)<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp; printf(&quot;Inside =
while\n&quot;);<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'>}<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></pre>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>thanks in advance,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Shanti<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0000_01C6704F.C7DACB50--



