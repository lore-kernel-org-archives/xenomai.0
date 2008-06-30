Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DA96.A912E837"
Date: Mon, 30 Jun 2008 11:51:29 +0200
Message-ID: <A3B06EAFE0D9C14096681C935E0B300802531682@domain.hid>
From: "Kaeppeler, Oliver" <Oliver.Kaeppeler@domain.hid>
Subject: [Xenomai-help] Problem with X-Window
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

------_=_NextPart_001_01C8DA96.A912E837
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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


------_=_NextPart_001_01C8DA96.A912E837
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
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
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
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
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

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
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp; =
3593&nbsp;&nbsp;&nbsp;&nbsp;
1&nbsp;&nbsp; 0&nbsp; 08:55&nbsp; ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:00:00&nbsp; =
&nbsp;&nbsp;/opt/kde3/bin/kdm<o:p></o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier =
New";font-weight:bold'>root&nbsp;
3603&nbsp; 3593&nbsp; 99&nbsp; 08:55&nbsp; tty7&nbsp;&nbsp; =
00:35:09&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;/usr/bin/Xorg
&#8211;br &#8211;nolisten tcp :0 vt7 &#8211;auth =
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
3611&nbsp;&nbsp; 0&nbsp; 08:55&nbsp; ? =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
/opt/kde3/bin/kdm_greet<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp; =
3619&nbsp;
3611&nbsp;&nbsp; 0&nbsp; 08:55&nbsp; ? =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
/bin/sh /etc/X11/xdm/Xsetup<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Courier New"><span =
lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:"Courier New"'>root&nbsp; =
3625&nbsp; 3619&nbsp;&nbsp;
0&nbsp; 08:55&nbsp; ? =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;numlockx on<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>The process Xorg (PID 3603) seems to =
&#8220;hang&#8221;
somehow. After 35 minutes the wait cursor is still =
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
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1'><font size=3D2 =
face=3DArial><span
     lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>either =
the BIOS
     option &#8220;Processor power management&#8221; is set to =
&#8220;Enabled&#8221;
     or at least to &#8220;GV3 Only&#8221; (Speed =
Stepping)<o:p></o:p></span></font></li>
 <li class=3DMsoNormal style=3D'mso-list:l0 level1 lfo1'><font size=3D2 =
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

------_=_NextPart_001_01C8DA96.A912E837--

