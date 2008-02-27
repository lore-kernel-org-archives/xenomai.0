From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Wed, 27 Feb 2008 20:54:36 +0100
Message-ID: <2220D86D21B55040AB683933DBD97B5A014DF68EF2@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2220D86D21B55040AB683933DBD97B5A014DF68EF2FNDMAILB03VIA_"
MIME-Version: 1.0
Subject: [Xenomai-help] rt_intr_create fails, err = 38 (ENOSYS)
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

--_000_2220D86D21B55040AB683933DBD97B5A014DF68EF2FNDMAILB03VIA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

My rt_tasks (periodic) and rt_events work now.
Next I have started using interrupts: rt_intr_create.

It fails with return value =3D 38 (ENOSYS).

I follow the template from Xenomai's homepage: user_irq.c

In .config I have set: CONFIG_XENO_NATIVE_INTR=3Dy.

Have you any suggestions to solve the problem?
I have noticed that Sarra Risto had the same problem (December 18, 2007).

Hans



--_000_2220D86D21B55040AB683933DBD97B5A014DF68EF2FNDMAILB03VIA_
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
10.0pt;font-family:Verdana'>My rt_tasks (periodic) and rt_events work now.<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Next I have started using interrupts: rt_intr_c=
reate.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>It fails with return value =3D 38 (ENOSYS).<o:p=
></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>I follow the template from Xenomai&#8217;s home=
page:
user_irq.c<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>In .config I have set: CONFIG_XENO_NATIVE_INTR=
=3Dy.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Have you any suggestions to solve the problem?<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>I have noticed that Sarra Risto had the same
problem (December 18, 2007).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DVerdana><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Verdana'>Hans <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

--_000_2220D86D21B55040AB683933DBD97B5A014DF68EF2FNDMAILB03VIA_--

