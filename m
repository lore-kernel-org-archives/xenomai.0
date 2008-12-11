From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Thu, 11 Dec 2008 16:01:26 +0100
Message-ID: <2220D86D21B55040AB683933DBD97B5A2B086A2E56@domain.hid>
References: <2220D86D21B55040AB683933DBD97B5A2B0863743B@FND-MAILB03.VIA.DK>
	<d6c8ef150812110151i4740a761m7ef85d82c4d20068@domain.hid>
In-Reply-To: <d6c8ef150812110151i4740a761m7ef85d82c4d20068@domain.hid>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2220D86D21B55040AB683933DBD97B5A2B086A2E56FNDMAILB03VIA_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_heap_create problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--_000_2220D86D21B55040AB683933DBD97B5A2B086A2E56FNDMAILB03VIA_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, the CONFIG_XENO_OPT_NATIVE_HEAP has been set.
Part of the .config is shown below:

#
# Real-time sub-system
#
CONFIG_XENOMAI=3Dy
CONFIG_XENO_GENERIC_STACKPOOL=3Dy
CONFIG_XENO_OPT_NUCLEUS=3Dy
CONFIG_XENO_OPT_PERVASIVE=3Dy
# CONFIG_XENO_OPT_ISHIELD is not set
CONFIG_XENO_OPT_PRIOCPL=3Dy
CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy
CONFIG_XENO_OPT_PIPE=3Dy
CONFIG_XENO_OPT_PIPE_NRDEV=3D32
CONFIG_XENO_OPT_REGISTRY=3Dy
CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512
CONFIG_XENO_OPT_SYS_HEAPSZ=3D128
CONFIG_XENO_OPT_SYS_STACKPOOLSZ=3D32
CONFIG_XENO_OPT_STATS=3Dy
# CONFIG_XENO_OPT_DEBUG is not set
# CONFIG_XENO_OPT_SHIRQ is not set

#
# Timing
#
CONFIG_XENO_OPT_TIMING_PERIODIC=3Dy
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0

#
# Scalability
#
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set

#
# Machine
#
CONFIG_XENO_HW_FPU=3Dy

#
# Interfaces
#
CONFIG_XENO_SKIN_NATIVE=3Dy
CONFIG_XENO_OPT_NATIVE_PERIOD=3D0
CONFIG_XENO_OPT_NATIVE_PIPE=3Dy
CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D1024
CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy
CONFIG_XENO_OPT_NATIVE_SEM=3Dy
CONFIG_XENO_OPT_NATIVE_EVENT=3Dy
CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy
CONFIG_XENO_OPT_NATIVE_COND=3Dy
CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy
CONFIG_XENO_OPT_NATIVE_HEAP=3Dy
CONFIG_XENO_OPT_NATIVE_ALARM=3Dy
CONFIG_XENO_OPT_NATIVE_MPS=3Dy
CONFIG_XENO_OPT_NATIVE_INTR=3Dy
# CONFIG_XENO_SKIN_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128
# CONFIG_XENO_OPT_RTDM_SELECT is not set

#
# Drivers
#

#
# Serial drivers
#
CONFIG_XENO_DRIVERS_16550A=3Dy
CONFIG_XENO_DRIVERS_16550A_PIO=3Dy
# CONFIG_XENO_DRIVERS_16550A_MMIO is not set
# CONFIG_XENO_DRIVERS_16550A_ANY is not set

#
# Testing drivers
#
CONFIG_XENO_DRIVERS_TIMERBENCH=3Dy
# CONFIG_XENO_DRIVERS_KLATENCY is not set
CONFIG_XENO_DRIVERS_IRQBENCH=3Dy
# CONFIG_XENO_DRIVERS_SWITCHTEST is not set

#
# CAN drivers
#
# CONFIG_XENO_DRIVERS_CAN is not set

Regards
Hans So
________________________________
From: Bosko Radivojevic [mailto:bosko.radivojevic@domain.hid]
Sent: 11. december 2008 10:52
To: Hans S=F8ndergaard (HSO)
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_heap_create problem

Hans,

have you enabled "memory heaps" option in your kernel config? Option is CON=
FIG_XENO_OPT_NATIVE_HEAP.

Sincerely,
Bosko

--_000_2220D86D21B55040AB683933DBD97B5A2B086A2E56FNDMAILB03VIA_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" xmlns=3D"http://ww=
w.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1"=
>
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><o:SmartTagType
 namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags" name=3D"Person=
Name"/>
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
	{mso-style-type:personal-reply;
	font-family:Verdana;
	color:blue;
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

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DVerdana><span lang=
=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:blue'>Yes, the </span><=
/font><span
lang=3DEN-GB>CONFIG_XENO_OPT_NATIVE_HEAP</span><font size=3D2 color=3Dblue
face=3DVerdana><span lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Ver=
dana;
color:blue'> has been set.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DVerdana><span lang=
=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:blue'>Part of the .conf=
ig is
shown below:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DVerdana><span lang=
=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:blue'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Real-ti=
me
sub-system<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NOMAI=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_GENERIC_STACKPOOL=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NUCLEUS=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_PERVASIVE=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_OPT_ISHIELD is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_PRIOCPL=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_PIPELINE_HEAD=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_PIPE=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_PIPE_NRDEV=3D32<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_REGISTRY=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_REGISTRY_NRSLOTS=3D512<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_SYS_HEAPSZ=3D128<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_SYS_STACKPOOLSZ=3D32<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_STATS=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_OPT_DEBUG is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_OPT_SHIRQ is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Timing<=
o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_TIMING_PERIODIC=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_TIMING_SCHEDLAT=3D0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Scalabi=
lity<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_OPT_SCALABLE_SCHED is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_TIMER_LIST=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_OPT_TIMER_HEAP is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_OPT_TIMER_WHEEL is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Machine=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_HW_FPU=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Interfa=
ces<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_SKIN_NATIVE=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_PERIOD=3D0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_PIPE=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_PIPE_BUFSZ=3D1024<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_REGISTRY=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_SEM=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_EVENT=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_MUTEX=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_COND=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_QUEUE=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_HEAP=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_ALARM=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_MPS=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_NATIVE_INTR=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_SKIN_POSIX is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_SKIN_PSOS is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_SKIN_UITRON is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_SKIN_VRTX is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_SKIN_VXWORKS is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_SKIN_RTAI is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_SKIN_RTDM=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_RTDM_PERIOD=3D0<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_OPT_RTDM_FILDES=3D128<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_OPT_RTDM_SELECT is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Drivers=
<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Serial =
drivers<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_DRIVERS_16550A=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_DRIVERS_16550A_PIO=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_DRIVERS_16550A_MMIO is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_DRIVERS_16550A_ANY is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># Testing=
 drivers<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_DRIVERS_TIMERBENCH=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_DRIVERS_KLATENCY is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>CONFIG_XE=
NO_DRIVERS_IRQBENCH=3Dy<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_DRIVERS_SWITCHTEST is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'><o:p>&nbs=
p;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'># CAN dri=
vers<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#<o:p></o=
:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 face=3D"C=
ourier New"><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:"Courier New"'>#
CONFIG_XENO_DRIVERS_CAN is not set<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DVerdana><span lang=
=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:blue'><o:p>&nbsp;</o:p>=
</span></font></p>

<div>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DVerdana><span lang=
=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:blue'>Regards</span></f=
ont><font
color=3Dblue><span lang=3DEN-GB style=3D'color:blue'><o:p></o:p></span></fo=
nt></p>

<p class=3DMsoNormal><font size=3D2 color=3Dblue face=3DVerdana><span lang=
=3DEN-GB
style=3D'font-size:10.0pt;font-family:Verdana;color:blue'>Hans So</span></f=
ont><span
lang=3DEN-GB><o:p></o:p></span></p>

</div>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font siz=
e=3D3
face=3D"Times New Roman"><span lang=3DEN-US style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span lang=3DEN-US
style=3D'font-size:10.0pt;font-family:Tahoma;font-weight:bold'>From:</span>=
</font></b><font
size=3D2 face=3DTahoma><span lang=3DEN-US style=3D'font-size:10.0pt;font-fa=
mily:Tahoma'>
Bosko Radivojevic [mailto:bosko.radivojevic@domain.hid] <br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> 11. december 2008 10:5=
2<br>
<b><span style=3D'font-weight:bold'>To:</span></b> Hans S=F8ndergaard (HSO)=
<br>
<b><span style=3D'font-weight:bold'>Cc:</span></b> <st1:PersonName w:st=3D"=
on">xenomai@xenomai.org</st1:PersonName><br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> Re: [Xenomai-help]
rt_heap_create problem</span></font><span lang=3DEN-US><o:p></o:p></span></=
p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Hans,<br>
<br>
have you enabled &quot;memory heaps&quot; option in your kernel config? Opt=
ion
is CONFIG_XENO_OPT_NATIVE_HEAP.<br>
<br>
Sincerely,<br>
Bosko<o:p></o:p></span></font></p>

</div>

</body>

</html>

--_000_2220D86D21B55040AB683933DBD97B5A2B086A2E56FNDMAILB03VIA_--

