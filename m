Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAD41A.97A9FCD0"
Date: Sun, 4 Apr 2010 10:18:11 -0700
Message-ID: <2319761F7FA0D1479BA77EC2E0A8E7BCDD1848@domain.hid>
From: "Sherk Chung" <sherk.chung@domain.hid>
Subject: [Xenomai-help] Sharing data between multiple Xenomai tasks in the
	same process
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

------_=_NextPart_001_01CAD41A.97A9FCD0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi folks, I have some basic questions regarding having multiple task
threads running in a Xenomai process. =20

=20

We would like to have a Xenomai process with multiple threads (tasks).
The primary task needs to hard-real-time, the others secondary ones will
be using non-real-time drivers so they will be degraded to
soft-real-time.  In order to share information between all the tasks, we
are thinking of doing something simple, such as having a global
structure that all threads can access.  I understand that we'll need
mutexes to preserve data integrity, and that the primary task might be
caught waiting for a lock to release which might cause timing jitter.
But assuming we have that issue under control, are here any other
Xenomai related issues that we should be aware of that might cause the
hard-real-time task to degrade to soft-real-time by doing this?

=20

Some things I'd like to verify:

-        It's generally ok to run multiple Xenomai tasks within a single
process.

-        If one of the secondary tasks is degraded to soft-real-time,
the degradation will be limited only to that particular secondary task,
not to the entire process (so the primary thread will remain
hard-real-time)

-        Having a global structure that all tasks can access is an
acceptable way to share data across Xenomai tasks (no
pipes/queues/sharedmem necessary in this scenario)

-        There is no risk of the primary task degrading to
soft-real-time by sharing a global structure with the secondary tasks
that are degraded to soft-real-time

=20

I'm guessing there is no issue but just wanted to make sure.

=20

Thanks.

=20

-Sherk

=20


------_=_NextPart_001_01CAD41A.97A9FCD0
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
 /* List Definitions */
 @list l0
	{mso-list-id:1671324185;
	mso-list-type:hybrid;
	mso-list-template-ids:255637060 1873573414 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:2;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:Calibri;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
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

<p class=3DMsoNormal>Hi folks, I have some basic questions regarding =
having
multiple task threads running in a Xenomai process.&nbsp; =
<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>We would like to have a Xenomai process with =
multiple threads
(tasks).&nbsp; The primary task needs to hard-real-time, the others =
secondary
ones will be using non-real-time drivers so they will be degraded to =
soft-real-time.&nbsp;
In order to share information between all the tasks, we are thinking of =
doing
something simple, such as having a global structure that all threads can
access.&nbsp; I understand that we&#8217;ll need mutexes to preserve =
data
integrity, and that the primary task might be caught waiting for a lock =
to
release which might cause timing jitter.&nbsp; But assuming we have that =
issue
under control, are here any other Xenomai related issues that we should =
be
aware of that might cause the hard-real-time task to degrade to =
soft-real-time
by doing this?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Some things I&#8217;d like to =
verify:<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>It&#8217;s generally ok to run multiple Xenomai =
tasks
within a single process.<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>If one of the secondary tasks is degraded to
soft-real-time, the degradation will be limited only to that particular =
secondary
task, not to the entire process (so the primary thread will remain
hard-real-time)<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>Having a global structure that all tasks can =
access is
an acceptable way to share data across Xenomai tasks (no =
pipes/queues/sharedmem
necessary in this scenario)<o:p></o:p></p>

<p class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 =
level1 lfo1'><![if !supportLists]><span
style=3D'mso-list:Ignore'>-<span style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]>There is no risk of the primary task degrading =
to
soft-real-time by sharing a global structure with the secondary tasks =
that are
degraded to soft-real-time<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m guessing there is no issue but just =
wanted to make
sure.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>-Sherk<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CAD41A.97A9FCD0--

