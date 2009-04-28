Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9C820.7D40593E"
Date: Tue, 28 Apr 2009 18:43:42 +0200
Message-ID: <DF9F3A3C150B0646A17FF1487C1B6D5E019F64AA@rennsmail06.eu.thmulti.com>
From: "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>
Subject: [Xenomai-help] ARM interrupt latency
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

------_=_NextPart_001_01C9C820.7D40593E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

=20

I am using xenomai 2.3.4 on a product based on ARM1136.

- I create several interrupt objects using "rt_intr_create" routine from =
user-space and their associated interrupt tasks that permanently wait =
for interrupt using "rt_intr_wait" routine.

- The application contains also several user tasks to manage specific =
functionalities.

- The processing in the interrupt tasks is very short: typically only =
resume the user task.

=20

By adding some embedded spies, I notice high latencies between interrupt =
task and user task (maximum 300=B5s, average 100=B5s).

If I supposed inherent interrupt latency on ARM is around 30=B5s, I can =
explain the latency between interrupt task and user task by the =
important number of interrupts on my system (around 100 IRQ are =
generated in each period of 20ms). It means than only 5 or 6 IRQ at the =
same time can produced this effect ...

=20

So, first I'd like to have your opinion on this interpretation ...

And in a second step, do you think that It could be interesting and =
especially sufficient in term of performance, to directly manage =
interrupt in kernel space instead of user space?

Additionally, if I choose this solution, should I publish the source =
code (as kernel and xenomai are under GPL)?

=20

Thanks in advance

=20

Jacques


------_=_NextPart_001_01C9C820.7D40593E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
	{color:#606420;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:21.0cm 842.0pt;
	margin:72.0pt 89.85pt 72.0pt 89.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3D"#606420">

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DFR =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am using xenomai 2.3.4 on a product based on =
ARM1136.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- I create several interrupt objects using <i><span
style=3D'font-style:italic'>&#8220;rt_intr_create&#8221;</span></i> =
routine from
user-space and their associated interrupt tasks that permanently wait =
for
interrupt using <i><span =
style=3D'font-style:italic'>&#8220;rt_intr_wait&#8221;</span></i>
routine.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- The application contains also several user tasks to =
manage
specific functionalities.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>- The processing in the interrupt tasks is very =
short: typically
only resume the user task.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>By adding some embedded spies, I notice high =
latencies
between interrupt task and user task (maximum 300=B5s, average =
100=B5s).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If I supposed inherent interrupt latency on ARM is =
around
30=B5s, I can explain the latency between interrupt task and user task =
by the
important number of interrupts on my system (around 100 IRQ are =
generated in
each period of 20ms). It means than only 5 or 6 IRQ at the same time can =
produced
this effect &#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>So, first I&#8217;d like to have your opinion on this =
interpretation
&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>And in a second step, do you think that It could be
interesting and especially sufficient in term of performance, to =
directly
manage interrupt in kernel space instead of user =
space?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Additionally, if I choose this solution, should I =
publish
the source code (as kernel and xenomai are under =
GPL)?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Jacques<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C9C820.7D40593E--

