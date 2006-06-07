Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C68A1E.0321A60A"
Date: Wed, 7 Jun 2006 12:34:53 +0200
Message-ID: <88AEA5AC18A141439A0D954EB037B0D30439F327@domain.hid>
From: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
Subject: [Xenomai-core] Ipipe hook at system call exit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C68A1E.0321A60A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hallo Philippe

=20

Jan Kiszka referred me to you discussing our problem with a missing
Ipipe hook at system call exit.=20

We at Siemens A&D do have a Linux realtime approach which is based on a
previous ADEOS version. When trying to port an improved version to the
Ipipe version for kernel 2.6.15.4 we ran into the problem of not having
an event hook at system call exit. Let me explain the need for it by
briefly outlining our approach.

It is a two kernel approach based on the model of a multihreaded process
(means 2.6 kernel) where the threads above  a certain static priority
level e.g. 68 are scheduled by the  scheduler of the realtime kernel.
The realtime kernel maintains exactly the same systemcall interface as
the Linux kernel. The entire process works uniformely with the glibc.
The glibc isn't aware under which scheduler the current thread is
executing. To make this happen and having both schedulers  to work with
the same struct task struct  we had to put some restrictions on the
signalling for the realtime domain (restrictions which make sense for
the realtime arena anyway). Because of that transparency this approach
combines somehow the advantages of a separated realtime kernel with the
user convenience of  PREEMPT_RT. (the user convenience was the driving
requirement for our approach)

=20

Now to the question why we need a hook at systemcall exit.=20

The hook at systemcall entry branches to the system call handling of the
realtime kernel, which is also entered via a systemcall table. The
handling can be grouped in three classes

-         complete handling in the realtime domain e.g. timer_settime(),
sigwait()

-         only migration of the thread to the Linux scheduler. Basically
all calls needed for setup e.g. open(), mmap(), pthread_create().  The
migration is transparent for the ipipe code, the thread continues
execution in the Linux domain with the call of the Linux system call
table (the priority hasn't changed).

-         handling in the realtime domain and migration to the Linux
domain if the thread priority has dropped unter the boundary (e.g
releasing a mutex with priority ceiling)

=20

In particular for the second case a check needs to be done at sytem call
exit as to whether the thread has to migrate (back) to the realtime
scheduler. But this is also needed when a call issued in the Linux
raises the priority above the threshold. A third reason for the hook is
to touch the corresponding pages after a brk() or mmap() call for
getting residency.

 Note:

The migration only takes place for threads of a process marked as
realtime.=20

Currently we allow only for one realtime process. First it is sufficient
for us and second it allows us to maintain the futex queue (each domain
maintains a local queue) of the realtime domain with virtual addresses
(no mm_lock). =20

=20

So this hook at system call exit is a necessity for us. Of course we
could do a private patch, but do you see a possibility to have it in the
standard Ipipe-patch?

=20

=20

Karl-Heinz Krause

Siemens A&D

Nbg.-Moorenbrunn

=20

=20

=20

=20


------_=_NextPart_001_01C68A1E.0321A60A
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
	{mso-list-id:1772045459;
	mso-list-type:hybrid;
	mso-list-template-ids:509743302 -1859251592 67567619 67567621 67567617 =
67567619 67567621 67567617 67567619 67567621;}
@list l0:level1
	{mso-level-start-at:11;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
-->
</style>

</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>Hallo Philippe<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>Jan Kiszka referred me to you discussing our =
problem
with a missing Ipipe hook at system call exit. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>We at Siemens A&amp;D do have a Linux =
realtime
approach which is based on a previous ADEOS version. When trying to port =
an
improved version to the Ipipe version for kernel 2.6.15.4 we ran into =
the
problem of not having an event hook at system call exit. Let me explain =
the
need for it by briefly outlining our =
approach.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>It is a two kernel approach based on the =
model of a
multihreaded process (means 2.6 kernel) where the threads above&nbsp; a =
certain
static priority level e.g. 68 are scheduled by the&nbsp; scheduler of =
the
realtime kernel. The realtime kernel maintains exactly the same =
systemcall
interface as the Linux kernel. The entire process works uniformely with =
the
glibc. The glibc isn't aware under which scheduler the current thread is
executing. To make this happen and having both schedulers&nbsp; to work =
with
the same struct task struct&nbsp; we had to put some restrictions on the
signalling for the realtime domain (restrictions which make sense for =
the
realtime arena anyway). Because of that transparency this approach =
combines
somehow the advantages of a separated realtime kernel with the user =
convenience
of&nbsp; PREEMPT_RT. (the user convenience was the driving requirement =
for our
approach)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>Now to the question why we need a hook at =
systemcall
exit. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>The hook at systemcall entry branches to the =
system
call handling of the realtime kernel, which is also entered via a =
systemcall
table. The handling can be grouped in three =
classes<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:36.0pt;text-indent:-27.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span lang=3DEN-GB =
style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span lang=3DEN-GB>complete =
handling
in the realtime domain e.g. timer_settime(), =
sigwait()<o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'margin-left:27.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span lang=3DEN-GB =
style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span lang=3DEN-GB>only =
migration of
the thread to the Linux scheduler. Basically all calls needed for setup =
e.g.
open(), mmap(), pthread_create().&nbsp; The migration is transparent for =
the
ipipe code, the thread continues execution in the Linux domain with the =
call of
the Linux system call table (the priority hasn't =
changed).<o:p></o:p></span></p>

<p class=3DMsoNormal =
style=3D'margin-left:27.0pt;text-indent:-18.0pt;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D3 face=3D"Times New Roman"><span lang=3DEN-GB =
style=3D'font-size:12.0pt'><span
style=3D'mso-list:Ignore'>-<font size=3D1 face=3D"Times New Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></font></span></span></font><![endif]><span lang=3DEN-GB>handling =
in the
realtime domain and migration to the Linux domain if the thread priority =
has
dropped unter the boundary (e.g releasing a mutex with priority =
ceiling)<o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>In particular for the second case a check =
needs to be
done at sytem call exit as to whether the thread has to migrate (back) =
to the
realtime scheduler. But this is also needed when a call issued in the =
Linux
raises the priority above the threshold. A third reason for the hook is =
to
touch the corresponding pages after a brk() or mmap() call for getting
residency.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp;Note:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>The migration only takes place for threads of =
a
process marked as realtime. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>Currently we allow only for one realtime =
process. First
it is sufficient for us and second it allows us to maintain the futex =
queue
(each domain maintains a local queue) of the realtime domain with =
virtual
addresses (no mm_lock). &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>So this hook at system call exit is a =
necessity for
us. Of course we could do a private patch, but do you see a possibility =
to have
it in the standard Ipipe-patch?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Karl-Heinz Krause<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Siemens A&amp;D<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>Nbg.-Moorenbrunn<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C68A1E.0321A60A--

