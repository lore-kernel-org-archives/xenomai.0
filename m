From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Wed, 10 Dec 2008 21:33:07 +0100
Message-ID: <2220D86D21B55040AB683933DBD97B5A2B0863743B@FND-MAILB03.VIA.DK>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2220D86D21B55040AB683933DBD97B5A2B0863743BFNDMAILB03VIA_"
MIME-Version: 1.0
Subject: [Xenomai-help] rt_heap_create problem
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

--_000_2220D86D21B55040AB683933DBD97B5A2B0863743BFNDMAILB03VIA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Xenomai.

I use Xenimai 2.4.3 and Linux 2.6.24 on an AT91SAM9260 processor based on A=
RM926EJ-S.
My problem is that the code snippet below gives an error -2.
As you can see, I have tried different HEAP_MODE values.

Earlier, I used the code on x86 without problem.

Hope, you can help me.

Regards
Hans So


RT_HEAP  aheap;

#define HEAP_SIZE  (4*1024)
#define HEAP_MODE   0  //H_SINGLE //H_MAPPABLE // have tried different cons=
tants


err =3D rt_heap_create (&aheap, "MyHeap", HEAP_SIZE, HEAP_MODE);

if (err)
{
  printf ("[3] rt heap create error: %d \n", err);
  catch_signal (2); // Ctrl-c: cleanup and exit
}



--_000_2220D86D21B55040AB683933DBD97B5A2B0863743BFNDMAILB03VIA_
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
10.0pt;font-family:Verdana'>Hello Xenomai.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>I use Xenimai 2.4.3 and Linux 2.6.24 on an AT91=
SAM9260
processor based on ARM926EJ-S.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>My problem is that the code snippet below gives=
 an
error -2.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>As you can see, I have tried different HEAP_MOD=
E
values.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Earlier, I used the code on x86 without problem=
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Hope, you can help me.<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Regards<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Hans So=A0 <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>RT_HEAP=
=A0 aheap;<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#define
HEAP_SIZE=A0 (4*1024)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#define
HEAP_MODE=A0 =A00=A0 //H_SINGLE //H_MAPPABLE // have tried different consta=
nts<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>err =3D
rt_heap_create (&amp;aheap, &quot;MyHeap&quot;, HEAP_SIZE, HEAP_MODE); <o:p=
></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>if (err)<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>{<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>=A0 print=
f
(&quot;[3] rt heap create error: %d \n&quot;, err);<o:p></o:p></span></font=
></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>=A0 catch=
_signal
(2); // Ctrl-c: cleanup and exit<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span style=3D'fon=
t-size:10.0pt;
font-family:"Courier New"'>}</span></font><font size=3D2 face=3DVerdana><sp=
an
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Verdana'><o:p></o:p></sp=
an></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_2220D86D21B55040AB683933DBD97B5A2B0863743BFNDMAILB03VIA_--

