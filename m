Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88443.D22CB62E"
Date: Wed, 12 Mar 2008 14:20:13 +0100
Message-ID: <F1566C6D794188449A9EFA4E903560F3054BE9A0@domain.hid>
From: "Ruud Bos" <Ruud.Bos@domain.hid>
Subject: [Xenomai-help] rt_queue name clash
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

------_=_NextPart_001_01C88443.D22CB62E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

Hi all,

=20

When I try to create a queue from user space and name it just like the
executable, rt_queue_create always returns -EEXIST.

/proc/xenomai/registry shows that no queues with that name have been
registered.

=20

Is this a bug or intended behaviour?

=20

I'm using xenomai 2.4.2 on kernel 2.6.24.2 patched with ipipe
2.6.24-x86-2.0-03

=20

Ruud



=0A -- DISCLAIMER -- Fico B.V.=0A=0AThis e-mail is confidential and inten=
ded solely for the use of the individuals to whom =0Ait is addressed and =
may be protected by legal privilege. If you are not the intended=0Arecipi=
ent, be advised that you have received this e-mail in error and that any =
disclosure,=0Ause, dissemination, forwarding, printing or copying of this=
 e-mail is strictly prohibited.=0AFico B.V. rules out any and every liabi=
lity resulting from any electronic transmission.=0AIf you have received t=
his e-mail in error, please notify;=0A=0AFico B.V. by telephone on +31 26=
 3196100. =0A

------_=_NextPart_001_01C88443.D22CB62E
Content-Type: text/HTML;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:=
schemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html=
40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman";}
a:link, span.MsoHyperlink
=09{color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:Arial;
=09color:windowtext;}
@page Section1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
=09{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Hi all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>When I try to create a queue from user space and name =
it
just like the executable, rt_queue_create always returns &#8211;EEXIST.<o=
:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>/proc/xenomai/registry shows that no queues with that =
name
have been registered.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Is this a bug or intended behaviour?<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I&#8217;m using xenomai 2.4.2 on kernel 2.6.24.2 patch=
ed
with ipipe 2.6.24-x86-2.0-03<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Ruud<o:p></o:p></span></font></p>

</div>


<DIV><P><HR>
<BR>=0A -- DISCLAIMER -- Fico B.V.<BR>=0A<BR>=0AThis e-mail is confidenti=
al and intended solely for the use of the individuals to whom <BR>=0Ait i=
s addressed and may be protected by legal privilege. If you are not the i=
ntended<BR>=0Arecipient, be advised that you have received this e-mail in=
 error and that any disclosure,<BR>=0Ause, dissemination, forwarding, pri=
nting or copying of this e-mail is strictly prohibited.<BR>=0AFico B.V. r=
ules out any and every liability resulting from any electronic transmissi=
on.<BR>=0AIf you have received this e-mail in error, please notify;<BR>=0A=
<BR>=0AFico B.V. by telephone on +31 26 3196100. <BR>=0A
</P></DIV>
</body>

</html>

------_=_NextPart_001_01C88443.D22CB62E--

