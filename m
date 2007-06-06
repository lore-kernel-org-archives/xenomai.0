From: "DESVAGES Arnaud" <desvages@domain.hid>
Date: Wed, 6 Jun 2007 13:59:49 +0200
Message-ID: <000001c7a832$2f5b9230$0419dcc3@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C7A842.F2E46230"
Subject: [Xenomai-help] real time task disapears... memory problem ?
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

------=_NextPart_000_0001_01C7A842.F2E46230
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I'm currently working on feedback scheduling. I have a set of tasks : an =
MPC
controller, a feedback scheduler, and some disturbance tasks.

=20

To do feedback scheduling, I need to measure the execution time quite
accurately, and xenomai can not measure the execution time spend in the
secondary mode. So I'm trying to stay in the primary mode. I had some =
calloc
and free in one function that made me leave primary mode (for the MPC =
task).

=20

I tried to replace this by a rt_heap, and doing rt_heap_alloc in place =
of
calloc, and I also tried to have static allocation.

=20

=20

In both cases, my MPC task disappears when executing it! (nothing in
/proc/xenomai/stat after the first try to execute it, but present during
initialisation. and the other tasks are still here).

=20

I'm working on it for a few days now, and I can't find out what is =
wrong. I
have tested to increase the maximum locked-in-memory size (in
/etc/security/limits.conf). If I debug it with ddd, all is ok, array are
well allocated...

=20

The strangest thing is that if I put a printf (this make a switch to
secondary mode) saying that heap allocation was successful, everything =
works
fine. So there is a function call that kills my task if I am in primary
mode, and executes well if I am in secondary mode?

=20

=20

Do you have any idea on where may be the mistake? Do you need some more
information?

=20

=20

My config: Linux 2.6.17-x320 preempt

=20

=20

Thanks in advance,

=20

=20

Arnaud DESVAGES

=20


------=_NextPart_000_0001_01C7A842.F2E46230
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

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
	{color:purple;
	text-decoration:underline;}
span.StyleCourrierlectronique17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>Hello,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>I&#8217;m currently working on feedback =
scheduling. I
have a set of tasks : an MPC controller, a feedback scheduler, and some
disturbance tasks.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>To do feedback scheduling, I need to measure =
the
execution time quite accurately, and xenomai can not measure the =
execution time
spend in the secondary mode. So I&#8217;m trying to stay in the primary =
mode. I
had some calloc and free in one function that made me leave primary mode =
(for
the MPC task).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>I tried to replace this by a rt_heap, and =
doing rt_heap_alloc
in place of calloc, and I also tried to have static =
allocation.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>In both cases, my MPC task disappears when =
executing it!
(nothing in /proc/xenomai/stat after the first try to execute it, but =
present
during initialisation&#8230; and the other tasks are still =
here).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>I&#8217;m working on it for a few days now, =
and I can&#8217;t
find out what is wrong. I have tested to increase the maximum =
locked-in-memory
size (in /etc/security/limits.conf). If I debug it with ddd, all is ok, =
array
are well allocated...</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>The strangest thing is that if I put a printf =
(this
make a switch to secondary mode) saying that heap allocation was =
successful, everything
works fine. So there is a function call that kills my task if I am in =
primary
mode, and executes well if I am in secondary mode?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>Do you have any idea on where may be the =
mistake? Do
you need some more information?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>My config: Linux 2.6.17-x320 =
preempt</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>Thanks in advance,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'>Arnaud DESVAGES</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C7A842.F2E46230--


