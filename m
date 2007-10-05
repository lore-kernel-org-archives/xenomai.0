Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C80749.B5884E82"
Date: Fri, 5 Oct 2007 14:16:50 +0200
Message-ID: <F1566C6D794188449A9EFA4E903560F304482059@domain.hid>
From: "Ruud Bos" <Ruud.Bos@domain.hid>
Subject: [Xenomai-help] Shared libraries
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

------_=_NextPart_001_01C80749.B5884E82
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

Hi,

=20

I've got a question about Xenomai wrt the use of shared libraries.

I'm using the native skin in Xenomai 2.3.3 with a vanilla 2.6.20 kernel.

=20

I'd like to put pipe wrapper functions in a shared library, so multiple
applications (both realtime and non-realtime) can use pipes to
intercommunicate.

This way I don't have to bother about which application needs to create
the pipes.

=20

Is this at all possible and would this have a negative impact on
latencies?

=20

Thanks in advance,

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

------_=_NextPart_001_01C80749.B5884E82
Content-Type: text/HTML;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:=
schemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html=
40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">
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
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I&#8217;ve got a question about Xenomai wrt the use of
shared libraries.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I&#8217;m using the native skin in Xenomai 2.3.3 with =
a
vanilla 2.6.20 kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>I&#8217;d like to put pipe wrapper functions in a shar=
ed
library, so multiple applications (both realtime and non-realtime) can us=
e pipes
to intercommunicate.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>This way I don&#8217;t have to bother about which
application needs to create the pipes.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Is this at all possible and would this have a negative=
 impact
on latencies?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span style=3D'font-size=
:10.0pt;
font-family:Arial'>Thanks in advance,<o:p></o:p></span></font></p>

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

------_=_NextPart_001_01C80749.B5884E82--

