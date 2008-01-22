Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C85D2A.6E035682"
Date: Tue, 22 Jan 2008 14:10:19 -0500
Message-ID: <BF58A8AFB316514587D61EADBFBF4C4101746604@domain.hid>
From: "Kyle Howell" <khowell@domain.hid>
Subject: [Xenomai-help] x86_64 user/system process accounting
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

------_=_NextPart_001_01C85D2A.6E035682
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an x86_64 (Core2)
system. I'm finding that all of my CPU cycles are being accounted as
kernel time rather than user time. The correct processes are still
billed, but the system is always 0% user. I'm wondering if this problem
is specific to my setup, or if it is a real bug. Can anyone else out
there running x86_64 confirm or deny this behavior?
=20
# cat /proc/stat
cpu  0 0 2678 115748 14 0 3 0
cpu0 0 0 2678 115748 14 0 3 0
.=2E.
=20
Some things I've tried:
CONFIG_SMP makes no difference
CONFIG_XENO_OPT_ISHIELD makes no difference
Problem goes away without CONFIG_XENOMAI and CONFIG_IPIPE
=20
Xenomai config items:
CONFIG_XENOMAI=3Dy
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
CONFIG_XENO_OPT_STATS=3Dy
# CONFIG_XENO_OPT_DEBUG is not set
CONFIG_XENO_OPT_SHIRQ=3Dy
# CONFIG_XENO_OPT_TIMING_PERIODIC is not set
CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0
# CONFIG_XENO_OPT_SCALABLE_SCHED is not set
CONFIG_XENO_OPT_TIMER_LIST=3Dy
# CONFIG_XENO_OPT_TIMER_HEAP is not set
# CONFIG_XENO_OPT_TIMER_WHEEL is not set
CONFIG_XENO_HW_FPU=3Dy
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=3Dy
# CONFIG_XENO_HW_SMI_WORKAROUND is not set
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
# CONFIG_XENO_OPT_NATIVE_INTR is not set
# CONFIG_XENO_SKIN_POSIX is not set
# CONFIG_XENO_SKIN_PSOS is not set
# CONFIG_XENO_SKIN_UITRON is not set
# CONFIG_XENO_SKIN_VRTX is not set
# CONFIG_XENO_SKIN_VXWORKS is not set
# CONFIG_XENO_SKIN_RTAI is not set
CONFIG_XENO_SKIN_RTDM=3Dy
CONFIG_XENO_OPT_RTDM_PERIOD=3D0
CONFIG_XENO_OPT_RTDM_FILDES=3D128

--
Kyle Howell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20

------_=_NextPart_001_01C85D2A.6E035682
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>I'm runni=
ng Xenomai=20
2=2E4.1 against Linux 2.6.23.12 on an x86_64 (Core2)&nbsp;system. I'm findi=
ng that=20
all of my CPU cycles are being accounted as kernel time rather than user ti=
me.=20
The correct processes are still billed, but the system is always 0% user. I=
'm=20
wondering if this problem is specific to my setup, or if it is a&nbsp;real =
bug.=20
Can anyone else out there running x86_64 confirm or deny this=20
behavior?</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2># cat=20
/proc/stat<BR>cpu&nbsp; 0 0 2678 115748 14 0 3 0<BR>cpu0 0 0 2678 115748 14=
 0 3=20
0<BR>...</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>Some thin=
gs I've=20
tried:</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>CONFIG_SM=
P makes no=20
difference</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2>CONFIG_XENO_OPT_ISHIELD makes no difference</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>Problem&n=
bsp;goes=20
away without&nbsp;CONFIG_XENOMAI and CONFIG_IPIPE</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>Xenomai&n=
bsp;config=20
items:</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2>CONFIG_XENOMAI=3Dy<BR>CONFIG_XENO_OPT_NUCLEUS=3Dy<BR>CONFIG_XENO_O=
PT_PERVASIVE=3Dy<BR>#=20
CONFIG_XENO_OPT_ISHIELD is not=20
set<BR>CONFIG_XENO_OPT_PRIOCPL=3Dy<BR>CONFIG_XENO_OPT_PIPELINE_HEAD=3Dy<BR>=
CONFIG_XENO_OPT_PIPE=3Dy<BR>CONFIG_XENO_OPT_PIPE_NRDEV=3D32<BR>CONFIG_XENO_=
OPT_REGISTRY=3Dy<BR>CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D512<BR>CONFIG_XENO_O=
PT_SYS_HEAPSZ=3D128<BR>CONFIG_XENO_OPT_STATS=3Dy<BR>#=20
CONFIG_XENO_OPT_DEBUG is not set<BR>CONFIG_XENO_OPT_SHIRQ=3Dy</FONT></SPAN>=
</DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>#=20
CONFIG_XENO_OPT_TIMING_PERIODIC is not=20
set<BR>CONFIG_XENO_OPT_TIMING_SCHEDLAT=3D0</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>#=20
CONFIG_XENO_OPT_SCALABLE_SCHED is not set<BR>CONFIG_XENO_OPT_TIMER_LIST=3Dy=
<BR>#=20
CONFIG_XENO_OPT_TIMER_HEAP is not set<BR># CONFIG_XENO_OPT_TIMER_WHEEL is n=
ot=20
set</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2>CONFIG_XENO_HW_FPU=3Dy</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>#=20
CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set<BR>CONFIG_XENO_HW_SMI_DETECT=
=3Dy<BR>#=20
CONFIG_XENO_HW_SMI_WORKAROUND is not set</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2>CONFIG_XENO_SKIN_NATIVE=3Dy<BR>CONFIG_XENO_OPT_NATIVE_PERIOD=3D0<B=
R>CONFIG_XENO_OPT_NATIVE_PIPE=3Dy<BR>CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=3D10=
24<BR>CONFIG_XENO_OPT_NATIVE_REGISTRY=3Dy<BR>CONFIG_XENO_OPT_NATIVE_SEM=3Dy=
<BR>CONFIG_XENO_OPT_NATIVE_EVENT=3Dy<BR>CONFIG_XENO_OPT_NATIVE_MUTEX=3Dy<BR=
>CONFIG_XENO_OPT_NATIVE_COND=3Dy<BR>CONFIG_XENO_OPT_NATIVE_QUEUE=3Dy<BR>CON=
FIG_XENO_OPT_NATIVE_HEAP=3Dy<BR>CONFIG_XENO_OPT_NATIVE_ALARM=3Dy<BR>CONFIG_=
XENO_OPT_NATIVE_MPS=3Dy<BR>#=20
CONFIG_XENO_OPT_NATIVE_INTR is not set<BR># CONFIG_XENO_SKIN_POSIX is not=20
set<BR># CONFIG_XENO_SKIN_PSOS is not set<BR># CONFIG_XENO_SKIN_UITRON is n=
ot=20
set<BR># CONFIG_XENO_SKIN_VRTX is not set<BR># CONFIG_XENO_SKIN_VXWORKS is =
not=20
set<BR># CONFIG_XENO_SKIN_RTAI is not=20
set<BR>CONFIG_XENO_SKIN_RTDM=3Dy<BR>CONFIG_XENO_OPT_RTDM_PERIOD=3D0<BR>CONF=
IG_XENO_OPT_RTDM_FILDES=3D128<BR></FONT></SPAN><SPAN=20
class=3D971495318-22012008><FONT face=3DArial size=3D2></FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial=20
size=3D2>--</FONT></SPAN></DIV>
<DIV><SPAN class=3D971495318-22012008><FONT face=3DArial size=3D2>Kyle=20
Howell</DIV></FONT></SPAN><pre>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20
</pre></BODY></HTML>

------_=_NextPart_001_01C85D2A.6E035682--

