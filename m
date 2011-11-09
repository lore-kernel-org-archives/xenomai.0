From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Wed, 9 Nov 2011 17:37:05 -0600
Message-ID: <2AB71B0EA2424A6C953F1BA9E4D51A79@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0011_01CC9F06.33DD19D0"
Subject: [Xenomai-help] Xenomai test progs segfault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0011_01CC9F06.33DD19D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Using 2.6.38 omap kernel on beagleboard xm-c, with 2.5.6 Xenomai and 2.6.38
adeos patch.  Adeos patches went through with no errors.  I do have a
"tweaked" omap3 board file (gpio's and such), but this is a pretty
straightforward kernel (PREEMPT, no power mgmt, no SMP).  Using Codesourcery
2010.09-50 as tool chain on host.
 
Looks like the kernel is ok on boot:
 
[    0.969854] I-pipe: Domain Xenomai registered.
[    0.969900] Xenomai: hal/arm started.
[    0.971906] Xenomai: scheduling class idle registered.
[    0.971937] Xenomai: scheduling class rt registered.
[    1.026001] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[    1.026763] Xenomai: starting native API services.
[    1.027046] Xenomai: starting RTDM services.

 
If I try to run "latency", or some of the other test programs I get a
segfault.  GDB says it's getting a signal SIGXCPU??
 
Been through the kernel .config many, many times!  Not sure where to go from
here?   Any suggestions?
 
Thanks!
 

------=_NextPart_000_0011_01CC9F06.33DD19D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17655"></HEAD>
<BODY>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D253060623-09112011>Using =
2.6.38 omap=20
kernel on beagleboard xm-c, with 2.5.6 Xenomai and 2.6.38 adeos =
patch.&nbsp;=20
Adeos patches went through with no errors.&nbsp; I do have a "tweaked" =
omap3=20
board file (gpio's and such), but this is a pretty straightforward =
kernel=20
(PREEMPT, no power mgmt, no SMP).&nbsp; Using Codesourcery 2010.09-50 as =
tool=20
chain on host.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D253060623-09112011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D253060623-09112011>Looks =
like the=20
kernel is ok on boot:</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D253060623-09112011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN =
class=3D253060623-09112011>[&nbsp;&nbsp;&nbsp;=20
0.969854] I-pipe: Domain Xenomai registered.<BR>[&nbsp;&nbsp;&nbsp; =
0.969900]=20
Xenomai: hal/arm started.<BR>[&nbsp;&nbsp;&nbsp; 0.971906] Xenomai: =
scheduling=20
class idle registered.<BR>[&nbsp;&nbsp;&nbsp; 0.971937] Xenomai: =
scheduling=20
class rt registered.<BR>[&nbsp;&nbsp;&nbsp; 1.026001] Xenomai: real-time =
nucleus=20
v2.5.6 (Wormhole Wizards) loaded.<BR>[&nbsp;&nbsp;&nbsp; 1.026763] =
Xenomai:=20
starting native API services.<BR>[&nbsp;&nbsp;&nbsp; 1.027046] Xenomai: =
starting=20
RTDM services.</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D253060623-09112011><BR>&nbsp;</DIV></SPAN></FONT>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D253060623-09112011>If I =
try to run=20
"latency", or some of&nbsp;the other test programs&nbsp;I get a =
segfault.&nbsp;=20
GDB says it's getting a signal SIGXCPU??</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D253060623-09112011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D253060623-09112011>Been =
through the=20
kernel .config many, many&nbsp;times!&nbsp; Not sure where to go from=20
here?&nbsp;&nbsp; Any suggestions?</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D253060623-09112011></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D253060623-09112011>Thanks!</SPAN></FONT></DIV>
<DIV align=3Dleft><FONT size=3D2 =
face=3DArial></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0011_01CC9F06.33DD19D0--


