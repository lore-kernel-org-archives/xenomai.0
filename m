From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Thu, 21 Aug 2008 12:11:51 +0200
Message-ID: <2220D86D21B55040AB683933DBD97B5A263B7AAA98@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2220D86D21B55040AB683933DBD97B5A263B7AAA98FNDMAILB03VIA_"
MIME-Version: 1.0
Subject: [Xenomai-help] How to get pid in Xenomai?
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

--_000_2220D86D21B55040AB683933DBD97B5A263B7AAA98FNDMAILB03VIA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.
1) Can you tell me, how to get the task id for the current (running) rt_tas=
k?
I have tried to use getpid(), but this function always gives the same id as=
 result.
I am running several periodic rt_tasks and need their id's.

2) In Xenomai the priority inheritance protocol is implemented.
Safety-Critical Java (http://jcp.org/en/jsr/detail?id=3D302) requires the p=
riority ceiling emulation protocol.
Have you any plan to implement and include this protocol in Xenomai?

Regards
Hans Sondergaard




--_000_2220D86D21B55040AB683933DBD97B5A263B7AAA98FNDMAILB03VIA_
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
 /* List Definitions */
 @list l0
	{mso-list-id:775248277;
	mso-list-type:hybrid;
	mso-list-template-ids:-1141482912 -1024932254 67502105 67502107 67502095 6=
7502105 67502107 67502095 67502105 67502107;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DDA link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Hello.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>1) Can you tell me, how to get the task id for =
the
current (running) rt_task?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>I have tried to use getpid(), but this function=
 always
gives the same id as result.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>I am running several periodic rt_tasks and need=
 their
id&#8217;s.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>2) In Xenomai the priority inheritance protocol=
 is
implemented.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Safety-Critical Java (<a
href=3D"http://jcp.org/en/jsr/detail?id=3D302">http://jcp.org/en/jsr/detail=
?id=3D302</a>)
requires the priority ceiling emulation protocol.<o:p></o:p></span></font><=
/p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Have you any plan to implement and include this
protocol in Xenomai?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>=A0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Hans Sondergaard<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_2220D86D21B55040AB683933DBD97B5A263B7AAA98FNDMAILB03VIA_--

