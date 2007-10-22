Message-Id: <200710221653.l9MGrFEt012760@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Mon, 22 Oct 2007 18:53:09 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0027_01C814DC.D95005C0"
Subject: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0027_01C814DC.D95005C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Please ignore my first wrong mail ;-)

 

Hi,

 

I am trying to found the bug in xenomai for PXA270 machine (xenomai 2.3.4,
ipipe 1.7-06 and kernel 2.6.20).

 

I have localised that the problem is coming when rt_task_create call
__ipipe_restore_pipeline_head (called by xnlock_put_irq_restore) in
ipipe/core.c.

I think that the problem is the call to __clear_bit(IPIPE_STALL_FLAG,
&head->cpudata[cpuid].status); 

If I don't execute this function on the rt_task_create the system doesn't
freeze (but my application doesn't work correctly).

 

I don't know what the problem is. Do you have an idea or a suggestion?

 

Thanks

 

Patrick


------=_NextPart_000_0027_01C814DC.D95005C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 69.6pt 70.85pt 69.6pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><i><font size=3D2 color=3Dblack =
face=3DVerdana><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Verdana;color:black;font-style:
italic'>Please ignore my first wrong =
mail&nbsp;;-)<o:p></o:p></span></font></i></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'><o:p>&nbsp;</o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span =
style=3D'font-size:10.0pt;
font-family:Verdana'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span =
style=3D'font-size:10.0pt;
font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span =
style=3D'font-size:10.0pt;
font-family:Verdana'>I am</span></font><font face=3DVerdana><span =
lang=3DEN-GB
style=3D'font-family:Verdana'> trying</span></font><font =
face=3DVerdana><span
style=3D'font-family:Verdana'> to found the bug in xenomai for PXA270 =
machine
(xenomai 2.3.4, ipipe 1.7-06 and kernel =
2.6.20).<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span =
style=3D'font-size:10.0pt;
font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana'>I have localised that the =
problem
is coming when </span></font><span =
lang=3DEN-GB>rt_task_create</span><font
face=3DVerdana><span lang=3DEN-GB style=3D'font-family:Verdana'> call =
</span></font><span
lang=3DEN-GB>__ipipe_restore_pipeline_head (</span><font =
face=3DVerdana><span
lang=3DEN-GB style=3D'font-family:Verdana'>called by</span></font><span =
lang=3DEN-GB>
xnlock_put_irq_restore) </span><font face=3DVerdana><span lang=3DEN-GB
style=3D'font-family:Verdana'>in =
ipipe/core.c.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana'>I think that the problem =
is the
call to </span></font><span lang=3DEN-GB>__clear_bit(IPIPE_STALL_FLAG,
&amp;head-&gt;cpudata[cpuid].status); </span><font face=3DVerdana><span
lang=3DEN-GB style=3D'font-family:Verdana'><o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana'>If I don&#8217;t execute =
this
function on the </span></font><span =
lang=3DEN-GB>rt_task_create</span><font
face=3DVerdana><span lang=3DEN-GB style=3D'font-family:Verdana'> the =
system
doesn&#8217;t freeze (but my application doesn&#8217;t work =
correctly).<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></=
font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana'>I don&#8217;t know what =
the problem
is. Do you have an idea or a suggestion?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'><o:p>&nbsp;</o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'>Thanks<o:p></o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'><o:p>&nbsp;</o=
:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 color=3Dblack =
face=3DVerdana><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:black'>Patrick<o:p></=
o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0027_01C814DC.D95005C0--


