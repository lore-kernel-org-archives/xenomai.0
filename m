Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70F13.A874F50A"
Date: Thu, 23 Nov 2006 15:25:50 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB015D5270@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] Debugging in Xenomai
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

------_=_NextPart_001_01C70F13.A874F50A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
our application deadlocks from time to time.=20
=20
To isolate which of the threads are deadlocked, I look into
/proc/xenomai/stat. Here I can see if there are context switches
happening or not. Further I can see which threads have which PID and
which task state they are into. One of the task states that is not clear
to me btw is the state "X" or "relaxed shadow". Anybody ?
=20
So after gathering that I have some basic idea which of the threads is
having a deadlock and now the question is, how to continue ?
=20
One of the next steps would be finding out which actual function back
trace the suspicious thread has. So I execute gdb and try to attach to
the appropriate process, which works. Problem: sending Ctrl-C doesn't
work, independant of if gdb is executed via ssh or serial console. So I
cannot stop the actual program beeing debugged, rendering the gdb
approach useless. Also sending SIGINT to the GDB process doesn't work.
It seems to be simply ignored. As I understand CTRL-C is effectively
sending SIGINT and is sent to GDB itself and not to the underlying appl.
=20
Of course I always can insert logger output strings. I even wrote a
logger that doesn't force to switch the process into secondary mode. I
just thought we might have something that gives a developer a more
effective way of fastly finding out which task has which actual back
trace.
=20
Under VxWorks there is a very elegant way of debugging with the help of
the userLib. Of course this is possible here because VxWorks makes no
distinction between user and kernel space and the shell itself is
running as a task having access to symbol tables etc. You can say "i"
which gives a similar output as /proc/xenomai/stat but with much more
informations like stack size, actual stack consumption, actual executed
function pointer, etc. "b" gives you a global breakpoint for any
function. One can get stack traces without the help of gdb via "tt",
etc. etc.
=20
In Xenomai I suppose the actual stack execution pointer, stack size,
etc. of a task has to be available to the kernel as well, so
principially it should be possible to provide more informations than
what /proc/xenomai/stat or /proc/xenomai/sched provide. Those migrating
from VxWorks (and many others probably as well) would certainly like
that.
=20
How do the Xenomai veterans debug their application in case of deadlocks
/ synchronization errors, crashes etc. ?
=20
=20
Best regards,
=20
Daniel.

------_=_NextPart_001_01C70F13.A874F50A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>our =
application=20
deadlocks from time to time. </FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>To =
isolate which of=20
the threads are deadlocked, I look into /proc/xenomai/stat. Here I can =
see if=20
there are context switches happening or not. Further I can see which =
threads=20
have which PID and which task state they are into. One of the task =
states that=20
is not clear to me btw is the state "X" or "relaxed shadow". Anybody=20
?</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial =
size=3D2>So&nbsp;after=20
gathering that I have some basic idea which of the threads is having a =
deadlock=20
and now the question is, how to continue ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>One of =
the next=20
steps would be finding out which actual function back trace the =
suspicious=20
thread has. So I execute gdb and try to attach to the appropriate =
process, which=20
works. Problem: sending Ctrl-C doesn't work, independant of if gdb is =
executed=20
via ssh or serial console. So I cannot stop the actual program beeing =
debugged,=20
rendering the gdb approach useless. Also sending SIGINT to the GDB =
process=20
doesn't work. It seems to be simply ignored. As I understand CTRL-C is=20
effectively sending SIGINT and is sent to GDB itself and not to the =
underlying=20
appl.</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>Of =
course I always=20
can insert logger output strings. I even wrote a logger that doesn't =
force to=20
switch the process into secondary mode. I just thought we might have =
something=20
that gives&nbsp;a developer a more effective way of fastly finding out =
which=20
task has which actual back trace.</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>Under =
VxWorks there=20
is a very elegant way of debugging&nbsp;with the help of the userLib. Of =
course=20
this is possible here because VxWorks makes no distinction between user =
and=20
kernel space and the shell itself is running as a task having access to =
symbol=20
tables etc. You can say "i" which gives a similar output as =
/proc/xenomai/stat=20
but with much more informations like&nbsp;stack size, actual stack =
consumption,=20
actual executed function pointer, etc. "b" gives you&nbsp;a global =
breakpoint=20
for any function. One can get stack&nbsp;traces without the help of gdb =
via=20
"tt", etc. etc.</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>In =
Xenomai I suppose=20
the actual&nbsp;stack execution&nbsp;pointer, stack size, etc. of a task =
has to=20
be available to the kernel as well, so principially it should be =
possible to=20
provide more informations than what /proc/xenomai/stat or =
/proc/xenomai/sched=20
provide. Those migrating from VxWorks (and many others probably as well) =
would=20
certainly like that.</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>How do =
the Xenomai=20
veterans debug their application in case of deadlocks / synchronization =
errors,=20
crashes&nbsp;etc. ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial size=3D2>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D700410314-23112006><FONT face=3DArial=20
size=3D2>Daniel.</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C70F13.A874F50A--

