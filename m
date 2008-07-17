Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8E7FB.B76069E1"
Date: Thu, 17 Jul 2008 12:56:06 +0200
Message-ID: <A3B06EAFE0D9C14096681C935E0B3008026F4B96@domain.hid>
In-Reply-To: <A3B06EAFE0D9C14096681C935E0B300802531682@domain.hid>
References: <A3B06EAFE0D9C14096681C935E0B300802531682@domain.hid>
From: "Kaeppeler, Oliver" <Oliver.Kaeppeler@domain.hid>
Subject: Re: [Xenomai-help] Problem with X-Window
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

------_=_NextPart_001_01C8E7FB.B76069E1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Switching off the ipipe trace solves the mentioned problem (echo 0 >
/proc/ipipe/trace/enable).

=20

If ipipe trace is enabled, Xorg is hanging (100% cpu usage). strace
shows that Xorg enters the "clone" syscall but it is aborted with
ERESTARTNOINTR because there is a SIGALRM signal pending. After the
signal handler is executed, the kernel will then force re-entering the
syscall but SIGALRM will abort it again. It's an infinite loop.

=20

strace also shows that the "clone" syscall takes a very long time. It is
significant shorter if ipipe tracing is disabled, so that SIGALRM never
interrupts this syscall.

=20

Regards,

Oliver Kaeppeler.

=20

=20

________________________________

Von: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
Im Auftrag von Kaeppeler, Oliver
Gesendet: Montag, 30. Juni 2008 11:51
An: xenomai@xenomai.org
Betreff: [Xenomai-help] Problem with X-Window

=20

Hello,

=20

starting init 5 (or just kdm) results in just showing the wait cursor -
the login screen is not reached. In this state the system can only be
accessed from outside via ssh. Via ssh the following information are
retrieved:

=20

# ps -efH

. . .=20

root     1     0   0  08:51  ?      00:00:02  init [5]

. . .

root  3593     1   0  08:55  ?      00:00:00    /opt/kde3/bin/kdm

root  3603  3593  99  08:55  tty7   00:35:09      /usr/bin/Xorg -br
-nolisten tcp :0 vt7 -auth /var/lib/xdm/authdir/authfiles/A:0-F7SRvr

root  3611  3593   0  08:55  ?      00:00:00        -:0

root  3618  3611   0  08:55  ?      00:00:00
/opt/kde3/bin/kdm_greet

root  3619  3611   0  08:55  ?      00:00:00          /bin/sh
/etc/X11/xdm/Xsetup

root  3625  3619   0  08:55  ?      00:00:00            numlockx on

=20

The process Xorg (PID 3603) seems to "hang" somehow. After 35 minutes
the wait cursor is still displayed...

=20

A similar problem already was posted in Xenomai-help archive in 2007-09
as "Functional difference between tty and xterm". Unfortunately the
mentioned solution doesn't work for me.

=20

I am using OpenSUSE 10.3, Kernel 2.6.24.5, Xenomai 2.4.3 (I also tried
2.6.23.9/2.4.0) on an Intel Core Due CPU. Mobile 945GM/GMS, 943/940GML
Express Integrated Graphics Controller.

=20

Surprisingly calling sax2 works (within init 3).

=20

There is no X problem if=20

*	either the BIOS option "Processor power management" is set to
"Enabled" or at least to "GV3 Only" (Speed Stepping)
*	or the kernel is used without Xenomai (same config)

=20

There is no significant difference in /var/log/Xorg.0.log between with
and without Xenomai.

=20

Does anybody has an idea about this X-Window problem with Xenomai?
Thanks in advance.
Oliver Kaeppeler.

=20


------_=_NextPart_001_01C8E7FB.B76069E1
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
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
span.E-MailFormatvorlage17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.E-MailFormatvorlage18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 @list l0
	{mso-list-id:537933075;
	mso-list-type:hybrid;
	mso-list-template-ids:-1050279084 67567617 67567619 67567621 67567617 =
67567619 67567621 67567617 67567619 67567621;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level4
	{mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level7
	{mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1
	{mso-list-id:1629891952;
	mso-list-template-ids:-1725806618;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Switching off =
the ipipe
trace solves the mentioned problem (echo 0 &gt; =
/proc/ipipe/trace/enable).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>If ipipe trace =
is
enabled, Xorg is hanging (100% cpu usage). strace shows that Xorg enters =
the &#8220;clone&#8221;
syscall but it is aborted with ERESTARTNOINTR because there is a SIGALRM =
signal
pending. After the signal handler is executed, the kernel will then =
force re-entering
the syscall but SIGALRM will abort it again. It&#8217;s an infinite =
loop.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>strace also =
shows that
the &#8220;clone&#8221; syscall takes a very long time. It is =
significant
shorter if ipipe tracing is disabled, so that SIGALRM never interrupts =
this syscall.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Regards,<o:p></o:=
p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'>Oliver =
Kaeppeler.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p>=
</span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>Von:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'>
xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
<b><span
style=3D'font-weight:bold'>Im Auftrag von </span></b>Kaeppeler, =
Oliver<br>
<b><span style=3D'font-weight:bold'>Gesendet:</span></b> Montag, 30. =
Juni 2008
11:51<br>
<b><span style=3D'font-weight:bold'>An:</span></b> =
xenomai@xenomai.org<br>
<b><span style=3D'font-weight:bold'>Betreff:</span></b> [Xenomai-help] =
Problem
with X-Window</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>starting init 5 (or just kdm) results in just =
showing
the wait cursor &#8211; the login screen is not reached. In this state =
the
system can only be accessed from outside via ssh. Via ssh the following
information are retrieved:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'># ps =
&#8211;efH<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>. . . =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>root&nbsp;&nbsp;&nbsp; &nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;
0&nbsp;&nbsp; 0&nbsp; 08:51&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:00:02&nbsp; init [5]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>. . =
.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp;
3593&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp; 0&nbsp; 08:55&nbsp;
?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00&nbsp; =
&nbsp;&nbsp;/opt/kde3/bin/kdm<o:p></o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New";font-weight:bold'>root&nbsp;
3603&nbsp; 3593&nbsp; 99&nbsp; 08:55&nbsp; tty7&nbsp;&nbsp; =
00:35:09&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;/usr/bin/Xorg &#8211;br &#8211;nolisten tcp :0 =
vt7
&#8211;auth =
/var/lib/xdm/authdir/authfiles/A:0-F7SRvr<o:p></o:p></span></font></b></p=
>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp; =
3611&nbsp;
3593&nbsp;&nbsp; 0&nbsp; 08:55&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-:0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp; =
3618&nbsp;
3611&nbsp;&nbsp; 0&nbsp; 08:55&nbsp; ?
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
/opt/kde3/bin/kdm_greet<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp; =
3619&nbsp;
3611&nbsp;&nbsp; 0&nbsp; 08:55&nbsp; ?
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
/bin/sh /etc/X11/xdm/Xsetup<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp; =
3625&nbsp;
3619&nbsp;&nbsp; 0&nbsp; 08:55&nbsp; ? =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;numlockx on<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>The process Xorg (PID 3603) seems to
&#8220;hang&#8221; somehow. After 35 minutes the wait cursor is still
displayed&#8230;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>A similar problem already was posted in =
Xenomai-help
archive in 2007-09 as &#8222;Functional difference between tty and =
xterm&#8220;.
Unfortunately the mentioned solution doesn&#8217;t work for =
me.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I am using OpenSUSE 10.3, Kernel 2.6.24.5, =
Xenomai
2.4.3 (I also tried 2.6.23.9/2.4.0) on an Intel Core Due CPU. Mobile =
945GM/GMS,
943/940GML Express Integrated Graphics =
Controller.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Surprisingly calling sax2 works (within init =
3).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>There is no X problem if =
<o:p></o:p></span></font></p>

<ul style=3D'margin-top:0cm' type=3Ddisc>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo3'><font size=3D2 =
face=3DArial><span
     lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>either =
the BIOS
     option &#8220;Processor power management&#8221; is set to
     &#8220;Enabled&#8221; or at least to &#8220;GV3 Only&#8221; (Speed
     Stepping)<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo3'><font size=3D2 =
face=3DArial><span
     lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>or the =
kernel is
     used without Xenomai (same config)<o:p></o:p></span></font></li>
</ul>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>There is no significant difference in
/var/log/Xorg.0.log between with and without =
Xenomai.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Does anybody has an idea about this X-Window =
problem
with Xenomai?<br>
Thanks in advance.<br>
Oliver Kaeppeler.</span></font><span lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8E7FB.B76069E1--

