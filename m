Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB6AAC.636F1B4C"
Date: Wed, 13 Oct 2010 09:58:14 +0200
Message-ID: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C00E@rennsmail06.eu.thmulti.com>
In-Reply-To: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C00C@rennsmail06.eu.thmulti.com>
References: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C00C@rennsmail06.eu.thmulti.com>
From: "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>
Subject: [Xenomai-help] rt_heap and DMA32 zone
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

------_=_NextPart_001_01CB6AAC.636F1B4C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

=20

I am working on 64 bits Linux 2.6.32.15 and xenomai 2.5.4.

I am using rt_heap to share memory between user and kernel domain.=20

I tried to create a shared memory of 16 Mbytes, but it appears that I
cannot create  a heap larger than 3 Mbytes.

The cat /proc/buddyinfo command gives me the following result:

Node 0, zone      DMA      1      2      2      1      2      1      1
0      1      1      3

Node 0, zone    DMA32    103     69     47     28     12      4      2
2      2      3    471

3 Mbytes is the maximum memory on DMA zone. So, It seems that the DMA32
zone is not take into account.

I checked my kernel compilation options but I did not find anything that
could explain this behavior.=20

Is rt_heap able to manage DMA32 zone?=20

=20

Regards,

Jacques

=20

=20


------_=_NextPart_001_01CB6AAC.636F1B4C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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

<p class=3DMsoNormal><span lang=3DEN-US>Hi all,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I am working on 64 bits Linux =
2.6.32.15 and
xenomai 2.5.4.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I am using rt_heap to share =
memory between
user and kernel domain. <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I tried to create a shared =
memory of 16
Mbytes, but it appears that I cannot create&nbsp; a heap larger than 3 =
Mbytes.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>The cat /proc/buddyinfo command =
gives me
the following result:<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Courier =
New"'>Node
0, zone&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:9.0pt;font-family:"Courier =
New"'>Node
0, zone&nbsp;&nbsp;&nbsp; DMA32&nbsp;&nbsp;&nbsp; =
103&nbsp;&nbsp;&nbsp;&nbsp;
69&nbsp;&nbsp;&nbsp;&nbsp; 47&nbsp;&nbsp;&nbsp;&nbsp;
28&nbsp;&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3&nbsp;&nbsp;&nbsp; 471<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>3 Mbytes is the maximum memory =
on DMA zone.
So, It seems that the DMA32 zone is not take into =
account.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I checked my kernel compilation =
options but
I did not find anything that could explain this behavior. =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Is rt_heap able to manage DMA32 =
zone? <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Regards,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Jacques<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CB6AAC.636F1B4C--

