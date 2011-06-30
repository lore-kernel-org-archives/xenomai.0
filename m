From: VEYSSIERE Nicolas <nicolas.veyssiere@domain.hid>
Date: Thu, 30 Jun 2011 11:12:02 +0200
Message-ID: <18837_1309425123_4E0C3DE3_18837_902_2_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283@domain.hid>
Content-Language: fr-FR
Content-Type: multipart/alternative;
	boundary="_000_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283THSONEA01CM_"
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai 2.5.6 with Valgrind ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283THSONEA01CM_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am asking for an already answered question from a very long time ago.

How can I use valgrind with Xenomai ?

Here (https://mail.gna.org/public/xenomai-help/2006-03/msg00072.html) Gille=
s C. tells us to use --enable-atomic-core

But I can't find this option. Maybe it has been renamed ?


# valgrind ./trivial-periodic
=3D=3D27300=3D=3D Memcheck, a memory error detector
=3D=3D27300=3D=3D Copyright (C) 2002-2010, and GNU GPL'd, by Julian Seward =
et al.
=3D=3D27300=3D=3D Using Valgrind-3.6.1 and LibVEX; rerun with -h for copyri=
ght info
=3D=3D27300=3D=3D Command: ./trivial-peridic
=3D=3D27300=3D=3D
--27300-- WARNING: unhandled syscall: 555
--27300-- You may be able to write your own handler.
--27300-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--27300-- Nevertheless we consider this a bug.  Please report
--27300-- it at http://valgrind.org/support/bug_reports.html.
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)
=3D=3D27300=3D=3D
=3D=3D27300=3D=3D HEAP SUMMARY:
=3D=3D27300=3D=3D     in use at exit: 0 bytes in 0 blocks
=3D=3D27300=3D=3D   total heap usage: 0 allocs, 0 frees, 0 bytes allocated
=3D=3D27300=3D=3D
=3D=3D27300=3D=3D All heap blocks were freed -- no leaks are possible
=3D=3D27300=3D=3D
=3D=3D27300=3D=3D For counts of detected and suppressed errors, rerun with:=
 -v
=3D=3D27300=3D=3D ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 7 fr=
om 7)



Thanks for all.

--
Nicolas VEYSSIERE


--_000_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283THSONEA01CM_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
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
	{margin:0cm;
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
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
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

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hello,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I am asking for an already answered question from a ve=
ry
long time ago.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>How can I use valgrind with Xenomai ?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Here (<a
href=3D"https://mail.gna.org/public/xenomai-help/2006-03/msg00072.html">htt=
ps://mail.gna.org/public/xenomai-help/2006-03/msg00072.html</a>)
Gilles C. tells us to use --enable-atomic-core<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>But I can't find this option. Maybe it has been rename=
d ?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal># valgrind ./trivial-periodic<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D Memcheck, a memory error detector<o:=
p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D Copyright (C) 2002-2010, and GNU GPL=
'd, by Julian
Seward et al.<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D Using Valgrind-3.6.1 and LibVEX; rer=
un with -h for
copyright info<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D Command: ./trivial-peridic<o:p></o:p=
></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D<o:p></o:p></p>

<p class=3DMsoNormal>--27300-- WARNING: unhandled syscall: 555<o:p></o:p></=
p>

<p class=3DMsoNormal>--27300-- You may be able to write your own handler.<o=
:p></o:p></p>

<p class=3DMsoNormal>--27300-- Read the file README_MISSING_SYSCALL_OR_IOCT=
L.<o:p></o:p></p>

<p class=3DMsoNormal>--27300-- Nevertheless we consider this a bug.&nbsp; P=
lease
report<o:p></o:p></p>

<p class=3DMsoNormal>--27300-- it at
http://valgrind.org/support/bug_reports.html.<o:p></o:p></p>

<p class=3DMsoNormal>Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disa=
bled.<o:p></o:p></p>

<p class=3DMsoNormal>(modprobe xeno_native?)<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D HEAP SUMMARY:<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D&nbsp;&nbsp;&nbsp;&nbsp; in use at ex=
it: 0 bytes in 0 blocks<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D&nbsp;&nbsp; total heap usage: 0 allo=
cs, 0 frees, 0 bytes
allocated<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D All heap blocks were freed -- no lea=
ks are
possible<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D For counts of detected and suppresse=
d errors,
rerun with: -v<o:p></o:p></p>

<p class=3DMsoNormal>=3D=3D27300=3D=3D ERROR SUMMARY: 0 errors from 0 conte=
xts
(suppressed: 7 from 7)<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks for all.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>-- </span><span
style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'line-height:9.0pt;mso-line-height-rule:exactl=
y'><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Nicolas VEYSSIERE</spa=
n><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283THSONEA01CM_--

