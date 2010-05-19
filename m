Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAF6EA.5DA2EB47"
Date: Tue, 18 May 2010 17:29:41 -0700
Message-ID: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A1DC@alpine.pivotalsys.com>
From: "Vera Snowball" <vera.snowball@domain.hid>
Subject: [Xenomai-help] xenosim compilation issues
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

------_=_NextPart_001_01CAF6EA.5DA2EB47
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.

=20

I'm trying to install, compile, run xenosim simulator. I'm stuck at the =
'make install' step where the code is compiled and installed into a =
proper location. Here is the place where the problem occurs:

=20

make[1]: Leaving directory =
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/vm'

Making install in adapter

make[1]: Entering directory =
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter'

g++ -DHAVE_CONFIG_H -I. -I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter =
-I../include -D__XENO_SIM__ -fno-exceptions =
-I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/.. =
-I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include    -O2 -MT =
adapter.o -MD -MP -MF .deps/adapter.Tpo -c -o adapter.o =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc

In file included from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/sched.=
h:31,

                 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/pod.h:=
34,

                 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:23:

/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thread=
.h: In function =E2xnthread* xnthread_lookup(xnhandle_t)=E2:

/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/thread=
.h:431: error: invalid conversion from =E2void*=E2 to =E2xnthread*=E2

In file included from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/manager.h:38,

                 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:25:

/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h: At global =
scope:

/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thread.h:52: warning: =
=E2typedef=E2 was ignored in this declaration

/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc: In function =
=E2const char* mvm_get_thread_mode(void*)=E2:

/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:65: error: too =
few arguments to function

/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:67: error: too =
few arguments to function

make[1]: *** [adapter.o] Error 1

make[1]: Leaving directory =
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter'

make: *** [install-recursive] Error 1

=20

=20

This is something I don't think I can solve on my own. Any idea what to =
do in this case is really appreciated.

=20

=20

Best Regards,

Vera


------_=_NextPart_001_01CAF6EA.5DA2EB47
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
p.Body, li.Body, div.Body
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:Arial;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:Arial;
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
font-family:Arial'>Hello.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m trying to install, compile, run xenosim =
simulator.
I&#8217;m stuck at the &#8216;make install&#8217; step where the code is
compiled and installed into a proper location. Here is the place where =
the
problem occurs:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: Leaving directory
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/vm'<o:p></o:p></span></font>=
</p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Making install in =
adapter<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: Entering directory
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter'<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>g++ -DHAVE_CONFIG_H -<st1:place =
w:st=3D"on">I.</st1:place>
-I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter -I../include =
-D__XENO_SIM__
-fno-exceptions -I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/..
-I/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include=A0=A0=A0 =
-O2 -MT adapter.o
-MD -MP -MF .deps/adapter.Tpo -c -o adapter.o
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In file included from
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/sched.=
h:31,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../include/nucleus/pod.h:=
34,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:23:<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../inc=
lude/nucleus/thread.h:
In function =E2xnthread* =
xnthread_lookup(xnhandle_t)=E2:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../../inc=
lude/nucleus/thread.h:431:
error: invalid conversion from =E2void*=E2 to =
=E2xnthread*=E2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>In file included from
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/manager.h:38,<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from =
/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.cc:25:<o:p></o:p></s=
pan></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thr=
ead.h:
At global scope:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/../vm/thr=
ead.h:52:
warning: =E2typedef=E2 was ignored in this =
declaration<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.c=
c: In
function =E2const char* =
mvm_get_thread_mode(void*)=E2:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.c=
c:65:
error: too few arguments to function<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/usr/src/xenomai-2.5.1/xenosim-2.4.7/adapter/adapter.c=
c:67:
error: too few arguments to function<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: *** [adapter.o] Error =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: Leaving directory
`/usr/src/xenomai-2.5.1/xenosim-2.4.7/Build_/adapter'<o:p></o:p></span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make: *** [install-recursive] Error =
1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This is something I don&#8217;t think I can solve on =
my own.
Any idea what to do in this case is really =
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Best Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Vera<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CAF6EA.5DA2EB47--

