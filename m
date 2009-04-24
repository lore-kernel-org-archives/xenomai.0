From: "Wayne Call" <wcall@domain.hid>
Date: Fri, 24 Apr 2009 15:37:25 -0600
Message-ID: <003f01c9c524$dc109aa0$9431cfe0$@com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0040_01C9C4F2.91762AA0"
Content-Language: en-us
Subject: [Xenomai-help] rt_alarm_create
Reply-To: wcall@domain.hid
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

This is a multipart message in MIME format.

------=_NextPart_000_0040_01C9C4F2.91762AA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are two rt_alarm_create functions.  One is for the kernel space and
the other is for user space.  

 

I have a linux driver that has an interrupt service routine.  When the
driver is loaded using insmod, it executes the rt_alarm_create.  When the
interrupt is triggered, the interrupt service routine executes the
rt_alarm_start function.  When the rt_alarm_start function expires, it
executes the alarm handler code.  All this code is executed in kernel space.


 

What I would like to do is create a user application that executes the alarm
handler code rather than the linux driver in kernel space.  If the
rt_alarm_create is executed in kernel space, is there a way to pass the
alarm descriptor to user space?

 

Wayne

 


------=_NextPart_000_0040_01C9C4F2.91762AA0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>There are two rt_alarm_create functions.&nbsp; One =
is for
the kernel space and the other is for user space.&nbsp; <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have a linux driver that has an interrupt service =
routine.&nbsp;
When the driver is loaded using insmod, it executes the =
rt_alarm_create.&nbsp;
When the interrupt is triggered, the interrupt service routine executes =
the
rt_alarm_start function.&nbsp; When the rt_alarm_start function expires, =
it
executes the alarm handler code.&nbsp; All this code is executed in =
kernel
space. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>What I would like to do is create a user =
application that
executes the alarm handler code rather than the linux driver in kernel =
space.&nbsp;
If the rt_alarm_create is executed in kernel space, is there a way to =
pass the
alarm descriptor to user space?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Wayne<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0040_01C9C4F2.91762AA0--


