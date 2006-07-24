content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6AF23.548E191E"
Date: Mon, 24 Jul 2006 15:16:10 +0200
Message-ID: <E443EE6E95070D46896C24F5C44EA7F53A1547@domain.hid>
From: "Harkema, G.A." <G.A.Harkema@domain.hid>
Subject: [Xenomai-help] dma in rtdm
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

------_=_NextPart_001_01C6AF23.548E191E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hallo,

=20

We are currently trying to develop a realtime usb2.0 stack based on
xenomai rtdm. In non-realtime mode we use first the kmalloc() function
to allocate a dma buffer and use the dma_map_single() function to get
the bus address for the dma engine of the ehci hostcontroller. This
works fine. For use in a realtime context we replaced the kmalloc()
function by the rtdm_malloc() function. In our logs we see that the data
transfer take place, but the dma buffer was not filled with the
(received)data. We don't know where the data in the memory is stored. Is
this the right way for using dma in realtime context ? I guess not., but
what is the right way. Who can help us with this problem.

=20

Thanks.

=20

Kindest Regards,

=20

Gerard

=20

G.A. Harkema

Senior Hardware & Software Engineer

Eindhoven University of Technology

/department of physics

Measurement and Computer Science

Den Dolech 2

P.O.Box 513

5600 MB  Eindhoven

The Netherlands

tel: +31 40 247 4607

fax: +31 40 247 2144

www.tuedacs.nl

P Before you print think about the ENVIRONMENT

=20


------_=_NextPart_001_01C6AF23.548E191E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"country-region"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"Street"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"address"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Webdings;
	panose-1:5 3 1 2 1 5 9 6 7 3;}
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
span.E-mailStijl17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:70.55pt 72.0pt 89.3pt 72.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DNL link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hallo,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>We are currently trying to develop a realtime =
usb2.0
stack based on xenomai rtdm. In non-realtime mode we use first the =
kmalloc()
function to allocate a dma buffer and use the dma_map_single() function =
to get
the bus address for the dma engine of the ehci hostcontroller. This =
works fine.
For use in a realtime context we replaced the kmalloc() function by the
rtdm_malloc() function. In our logs we see that the data transfer take =
place,
but the dma buffer was not filled with the (received)data. We =
don&#8217;t know
where the data in the memory is stored. Is this the right way for using =
dma in
realtime context ? I guess not., but what is the right way. Who can help =
us
with this problem.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Thanks.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Kindest Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Gerard<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>G.A. =
Harkema<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>Senior Hardware =
&amp;
Software Engineer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><st1:PlaceName =
w:st=3D"on"><font size=3D2
  color=3Dblue face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:
  Arial;color:blue'>Eindhoven</span></font></st1:PlaceName><font =
size=3D2
 color=3Dblue face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:
 Arial;color:blue'> <st1:PlaceType =
w:st=3D"on">University</st1:PlaceType></span></font></st1:place><font
size=3D2 color=3Dblue face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:Arial;color:blue'> of =
Technology<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>/department of =
physics<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>Measurement and =
Computer
Science<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>Den Dolech =
2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><st1:address w:st=3D"on"><st1:Street =
w:st=3D"on"><font size=3D2
  color=3Dblue face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:
  Arial;color:blue'>P.O.Box</span></font></st1:Street><font size=3D2 =
color=3Dblue
 face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial;
 color:blue'> 513</span></font></st1:address><font size=3D2 color=3Dblue
face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:Arial;
color:blue'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>5600 MB&nbsp; =
<st1:City
w:st=3D"on"><st1:place =
w:st=3D"on">Eindhoven</st1:place></st1:City><o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>The =
<st1:country-region
w:st=3D"on"><st1:place =
w:st=3D"on">Netherlands</st1:place></st1:country-region><o:p></o:p></span=
></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>tel: +31 40 247 =
4607</span></font><span
lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'>fax: +31 40 247 =
2144<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DArial><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Arial;color:blue'><a
href=3D"http://www.tuedacs.nl">www.tuedacs.nl</a></span></font><span =
lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><strong><b><font size=3D6 color=3Dgreen =
face=3DWebdings><span
lang=3DEN-US =
style=3D'font-size:24.0pt;font-family:Webdings;color:green'>P</span></fon=
t></b></strong><strong><b><font
color=3Dblack face=3D"Times New Roman"><span lang=3DEN-US =
style=3D'color:black'> </span></font></b></strong><font
size=3D1 color=3Dgreen face=3DArial><span lang=3DEN-US =
style=3D'font-size:7.5pt;
font-family:Arial;color:green'>Before you print think about the =
</span></font><strong><b><font
size=3D1 color=3Dgreen face=3DTahoma><span lang=3DEN-US =
style=3D'font-size:7.5pt;
font-family:Tahoma;color:green'>ENVIRONMENT</span></font></b></strong><fo=
nt
size=3D2 color=3Dblue face=3DArial><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:Arial;color:blue'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6AF23.548E191E--

