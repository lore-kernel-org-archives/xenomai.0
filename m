Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DE6D.B8B39508"
Date: Fri, 22 Sep 2006 10:37:05 -0700
Message-ID: <F75B1CC921BD8E43B7D0484C9AB4C490450F9F@SJEX2003CL1.gmi.domain>
From: "David Betz" <david.betz@domain.hid>
Subject: [Xenomai-help] Running more than one "skin" at the same time?
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

------_=_NextPart_001_01C6DE6D.B8B39508
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is it possible to run more than one skin on top of the nucleus at the
same time? For instance, can I run the pSOS skin at the same time as the
Xenomai Native API? If so, would all of the calls from a single user
mode process have to be to one of the skins or could calls be mixed? In
other words, could a single thread in a user mode process at one point
block on a pSOS semaphore and later block on a Native API semaphore?
What are the rules for mixing and matching API calls?

=20

The problem that I'm trying to solve is that I want to build my software
on top of the Xenomai Native API but I may have a customer who wants to
port their pSOS code onto the same platform. Is there a way to make that
work? They will sometimes need to call functions in my firmware so will
indirectly invoke Native API calls from their pSOS-based code.

=20

Thanks,

David Betz


------_=_NextPart_001_01C6DE6D.B8B39508
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">
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
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is it possible to run more than one skin on top of =
the
nucleus at the same time? For instance, can I run the pSOS skin at the =
same
time as the Xenomai Native API? If so, would all of the calls from a =
single
user mode process have to be to one of the skins or could calls be =
mixed? In
other words, could a single thread in a user mode process at one point =
block on
a pSOS semaphore and later block on a Native API semaphore? What are the =
rules
for mixing and matching API calls?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The problem that I&#8217;m trying to solve is that I =
want to
build my software on top of the Xenomai Native API but I may have a =
customer
who wants to port their pSOS code onto the same platform. Is there a way =
to
make that work? They will sometimes need to call functions in my =
firmware so
will indirectly invoke Native API calls from their pSOS-based =
code.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>David Betz</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6DE6D.B8B39508--

