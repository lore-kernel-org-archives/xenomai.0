From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Fri, 8 Feb 2008 12:09:29 +0100
Message-ID: <2220D86D21B55040AB683933DBD97B5A014BAEAC93@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2220D86D21B55040AB683933DBD97B5A014BAEAC93FNDMAILB03VIA_"
MIME-Version: 1.0
Subject: [Xenomai-help] Using rt_task_notify and rt_task_catch ?
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

--_000_2220D86D21B55040AB683933DBD97B5A014BAEAC93FNDMAILB03VIA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you for an excellent answer Jan 23, 2008, about using periodic rt_tas=
ks.

Next I want to program sporadic/aperiodic tasks.

My idea is to call rt_task_notify (& task, signal) when an event occurs.

The task has a run-method doing something like:

  for(;;)
  {
    rt_task_catch (&doSomeWork); // catch the event and call doSomeWork, - =
and then wait for next event
   }

But I can not get it work.

Have you a little example-program showing how to be programmed?

Hans S=F8ndergaard


--_000_2220D86D21B55040AB683933DBD97B5A014BAEAC93FNDMAILB03VIA_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Verdana;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:3.0cm 2.0cm 3.0cm 2.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DDA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Thank you for an excellent answer Jan 23, 2008,
about using periodic rt_tasks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Next I want to program sporadic/aperiodic tasks=
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>My idea is to call rt_task_notify (&amp; task, =
signal)
when an event occurs.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>The task has a run-method doing something like:=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>=A0 for(;;)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>=A0 {=A0=A0=A0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>=A0=A0=A0 rt_task_catch (&amp;doSomeWork); // c=
atch the
event and call doSomeWork, - and then wait for next event<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>=A0=A0 }<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>But I can not get it work.<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Have you a little example-program showing how t=
o be
programmed?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Hans S=F8ndergaard<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_2220D86D21B55040AB683933DBD97B5A014BAEAC93FNDMAILB03VIA_--

