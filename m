Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87948.07760756"
Date: Wed, 27 Feb 2008 14:52:44 +0100
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E08F317@domain.hid>
From: "Markus Osterried" <markus.osterried@domain.hid>
Subject: [Xenomai-core] Error when exiting pSOS-task with return
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is a multi-part message in MIME format.

------_=_NextPart_001_01C87948.07760756
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
with Xenomai 2.4 on Linux 2.6.18 on PowerPC I have seen the following
trace:
=20
Feb 26 19:37:25 (none) user.err kernel: BUG: sleeping function called
from invalid context at kernel/rwsem.c:20
Feb 26 19:37:25 (none) user.warn kernel: in_atomic():0,
irqs_disabled():1
Feb 26 19:37:25 (none) user.warn kernel: Call Trace:
Feb 26 19:37:25 (none) user.warn kernel: [C19BFE50] [C000C114]
show_stack+0x58/0x188 (unreliable)
Feb 26 19:37:25 (none) user.warn kernel: [C19BFEA0] [C00128B0]
__might_sleep+0xdc/0xf0
Feb 26 19:37:25 (none) user.warn kernel: [C19BFEC0] [C0032304]
down_read+0x24/0x58
Feb 26 19:37:25 (none) user.warn kernel: [C19BFED0] [C00192C8]
exit_mm+0x34/0xec
Feb 26 19:37:25 (none) user.warn kernel: [C19BFEF0] [C001B000]
do_exit+0x21c/0x98c
Feb 26 19:37:25 (none) user.warn kernel: [C19BFF30] [C001B810]
complete_and_exit+0x0/0x28
Feb 26 19:37:25 (none) user.warn kernel: [C19BFF40] [C00041A0]
ret_from_syscall+0x0/0x38
=20
=20
This happens (sometimes) when a pSOS-task exits by returning from its
main function.
I have changed the return statement into t_delete(0) and there was no
error anymore, so this isn't a major issue.
=20
But anyway I would like to know whether this is a xenomai bug or it
isn't allowed to exit a pSOS-task by returning from main function.
I have seen at end of psos_task_trampoline that there is a
pthread_exit() instead of a t_delete().
=20
Thanks
Markus
=20

------_=_NextPart_001_01C87948.07760756
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1595" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D968462213-27022008>Hello,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D968462213-27022008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D968462213-27022008>with =
Xenomai 2.4 on=20
Linux 2.6.18 on PowerPC I have seen the following =
trace:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D968462213-27022008></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN =
class=3D968462213-27022008></SPAN></FONT><FONT face=3DArial=20
size=3D2><SPAN class=3D968462213-27022008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.err kernel: =
BUG:=20
sleeping function called from invalid context at =
kernel/rwsem.c:20<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel:=20
in_atomic():0, irqs_disabled():1<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
Call=20
Trace:<BR><SPAN class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
[C19BFE50]=20
[C000C114] show_stack+0x58/0x188 (unreliable)<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
[C19BFEA0]=20
[C00128B0] __might_sleep+0xdc/0xf0<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
[C19BFEC0]=20
[C0032304] down_read+0x24/0x58<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
[C19BFED0]=20
[C00192C8] exit_mm+0x34/0xec<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
[C19BFEF0]=20
[C001B000] do_exit+0x21c/0x98c<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
[C19BFF30]=20
[C001B810] complete_and_exit+0x0/0x28<BR><SPAN=20
class=3D968462213-27022008>Feb</SPAN>&nbsp;<SPAN=20
class=3D968462213-27022008>2</SPAN>6 19:37:25 (none) user.warn kernel: =
[C19BFF40]=20
[C00041A0] ret_from_syscall+0x0/0x38</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial size=3D2>This =
happens=20
(sometimes) when a pSOS-task exits by returning from its main=20
function.</FONT></SPAN></DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial size=3D2>I have =
changed the=20
return statement into t_delete(0) and there was no error anymore, so =
this isn't=20
a major issue.</FONT></SPAN></DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial size=3D2>But =
anyway I would=20
like to know whether this is a xenomai bug or it isn't allowed to exit a =

pSOS-task by returning from main function.</FONT></SPAN></DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial size=3D2>I have =
seen&nbsp;at=20
end of&nbsp;psos_task_trampoline that there is a pthread_exit() instead =
of a=20
t_delete().</FONT></SPAN></DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial=20
size=3D2>Thanks</FONT></SPAN></DIV>
<DIV><SPAN class=3D968462213-27022008><FONT face=3DArial=20
size=3D2>Markus</FONT></SPAN></DIV>
<DIV><SPAN class=3D968462213-27022008></SPAN>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C87948.07760756--

