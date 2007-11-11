Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C823FD.4DDE4372"
Date: Sat, 10 Nov 2007 17:53:41 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D3285C9@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3285C8@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D3285C8@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] more geode issues
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

------_=_NextPart_001_01C823FD.4DDE4372
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Just to let everyone know, select() still locks up on me with 2.6.22.2
and revision 3169.

=20

All I'm doing is opening up a pipe in linux and select() on it for
reading, and then opening up that pipe on the realtime side. Then, I hit
control-C. I load the program again and it locks up when I hit control-C
again. This won't happen the 2nd time if I unload and reload the
nucleus.

=20

Steven

=20

________________________________

From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
On Behalf Of Steven Seeger
Sent: Saturday, November 10, 2007 5:36 PM
To: xenomai@xenomai.org
Subject: [Xenomai-help] more geode issues

=20

I'm trying to get 2.6.23 to work with rc5. I've also tried trunk. I'm
noticing the following behavior:

=20

I'm using a geode GX1 board. The following relevant settings work with
2.6.22-2 and rc3:

=20

Tickless system, one shot, TSC, geode 2cx200hr timer, and high res
timers.

=20

Everything is great with 2.6.22-2 and this config. The same settings on
2.6.23, however, yield an extremely fast blinking cursor in the
framebuffer when xeno_nucleus is loaded. When xeno_native is loaded, the
system runs fine except the timer interrupt is messed up for linux and
the realtime tasks. A sleep 1 may take a couple minutes to return. If I
switch to another VT and do a cat /lib/* or something, then it runs
fine. I have a realtime task that acts as a sound driver.

=20

I've talked to Philippe about this problem privately, and there's no
real solution yet. I'm just posting it on the list now.

=20

Also, I'm having an issue with select() locking up the system with
pipes. I saw there was a change made to pipe in trunk and am going to
try and get that going with 2.6.22-2 now. If anyone knows anything about
these two issues, please let me know.=20

=20

Thanks,

Steven

=20

PS - It's good to finally be back on the list. I was hoping to not have
to use this email address... but oh well. :-)

=20


------_=_NextPart_001_01C823FD.4DDE4372
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
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
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Just to let everyone know, select() =
still
locks up on me with 2.6.22.2 and revision =
3169.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>All I&#8217;m doing is opening up a =
pipe
in linux and select() on it for reading, and then opening up that pipe =
on the
realtime side. Then, I hit control-C. I load the program again and it =
locks up
when I hit control-C again. This won&#8217;t happen the 2<sup>nd</sup> =
time if
I unload and reload the nucleus.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Steven<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in =
0in 4.0pt'>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid] <b><span =
style=3D'font-weight:bold'>On
Behalf Of </span></b>Steven Seeger<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Saturday, November =
10, 2007
5:36 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
xenomai@xenomai.org<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> [Xenomai-help] =
more geode
issues</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m trying to get 2.6.23 to work with rc5. =
I&#8217;ve
also tried trunk. I&#8217;m noticing the following =
behavior:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m using a geode GX1 board. The following =
relevant
settings work with 2.6.22-2 and rc3:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Tickless system, one shot, TSC, geode 2cx200hr timer, =
and high
res timers.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Everything is great with 2.6.22-2 and this config. =
The same
settings on 2.6.23, however, yield an extremely fast blinking cursor in =
the
framebuffer when xeno_nucleus is loaded. When xeno_native is loaded, the =
system
runs fine except the timer interrupt is messed up for linux and the =
realtime
tasks. A sleep 1 may take a couple minutes to return. If I switch to =
another VT
and do a cat /lib/* or something, then it runs fine. I have a realtime =
task
that acts as a sound driver.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;ve talked to Philippe about this problem =
privately,
and there&#8217;s no real solution yet. I&#8217;m just posting it on the =
list
now.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Also, I&#8217;m having an issue with select() locking =
up the
system with pipes. I saw there was a change made to pipe in trunk and am =
going
to try and get that going with 2.6.22-2 now. If anyone knows anything =
about
these two issues, please let me know. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Steven<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PS &#8211; It&#8217;s good to finally be back on the =
list. I
was hoping to not have to use this email address&#8230; but oh well. =
</span></font><font
size=3D2 face=3DWingdings><span =
style=3D'font-size:10.0pt;font-family:Wingdings'>J</span></font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</div>

</body>

</html>

------_=_NextPart_001_01C823FD.4DDE4372--

