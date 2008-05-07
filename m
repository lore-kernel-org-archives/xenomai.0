Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8B056.E6C9948D"
Date: Wed, 7 May 2008 11:27:46 -0400
Message-ID: <51B669A8A7D2914E9AB2B3F40AC6553E646F7E@afsexc01.aurora.aero>
From: "Karch, Joshua" <jkarch@domain.hid>
Subject: [Xenomai-help] rt_task_send / receive problems various issues and
	bug trace
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

------_=_NextPart_001_01C8B056.E6C9948D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,

I'm using rt_task_send from a talker task and rt_task_receive/reply from =
a listener task.  When I launch the two tasks in the following order: =
listener task,  talker task,  everything runs normally.

However, when I launch the talker task first, and then the listener task =
second, I receive rt_task_send error -22 and after a bit of time the =
listener task starts up. I know this is logical and to be expected, =
however, it appears that issuing the rt_task_send command to a task that =
hasn't been started occasionally locks up sufficient resources to =
prevent the listener task from starting.  By controlling task startup =
order, I was able to circumvent this issue.  Both tasks have similar =
priorities (50, 51).

Additionally, I am unable to use rt_task_send with TM_NONBLOCK
len =3D rt_task_send(listen_task,&talk_send,&talk_reply,TM_NONBLOCK);

I get a bug failure and have to reset the machine-- see below:

The reason I want to use TM_NONBLOCK is so that I can send a trigger =
message from the producer task to the consumer task without requiring a =
reply to trigger the consumer task to act on the data received. I am =
using the rt_task_send trigger message to gate and synchronize the =
consumer task. Is a reply required for all rt_task_send? =20

It seems if I don't send a reply when rt_task_send has a timeout =
specified the sending task locks up and the listening task runs rampant, =
i.e. rt_task_receive no longer blocks and the loop runs with no delay =
and essentially locks up the machine, since I don't use =
rt_set_task_periodic on the listening task.

Here is the trace, and it requires a reboot.  I also can attach the =
code- it is written in c++ with two separate classes as a model of the =
application I am building.

Thank you,

Joshua Karch

talker task started
rt_task_send error
len=3D-22, opcode=3D0
listener task stBUG: unable to handle kernel NULL pointer =
dereferencearted
rt_task_s at virtual address 0000020c
end error
len=3D-printing eip: c014f014 110, opcode=3D0
*pde =3D 00000000=20
Oops: 0000 [#1] PREEMPT=20
Modules linked in: xeno_timerbench nfs ipv6 nfsd lockd nfs_acl sunrpc =
exportfs dm_snapshot dm_mirror dm_mod loop pcmcia firmware_class =
serio_raw psmouse yenta_socket rsrc_nonstatic pcmcia_core cs5535_gpio =
joydev evdev ext3 jbd mbcache usbhid ide_disk generic ohci_hcd ehci_hcd =
amd74xx usbcore ide_core e100 mii

Pid: 1973, comm: listen_task Not tainted (2.6.24.4 #12)
EIP: 0060:[<c014f014>] EFLAGS: 00010093 CPU: 0
EIP is at rt_task_receive+0x113/0x18b
EAX: cdc71f28 EBX: fffffd98 ECX: c03c5500 EDX: cd820acc
ESI: ffffff97 EDI: cd820610 EBP: cdc71edc ESP: cdc71ec4
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process listen_task (pid: 1973, ti=3Dcdc70000 task=3Dcdc6d320 =
task.ti=3Dcdc70000)<0>
I-pipe domain Linux
Stack: 00000000 cdc71f28 00000000 cdc71ee8 cdc6d320 cdc71fb8 cdc71f4c =
c01515bf=20
       b7d083ea cdc71f00 c0102cb1 ce46bc70 c03c7e90 cd820620 cdc6d620 =
cd80ff44=20
       c029f55b cdc71f34 00000082 b91264ee 0000002e cdc6d320 b9127ee2 =
0000002e=20
Call Trace:
 [<c01045f1>] show_trace_log_lvl+0x1a/0x2f
 [<c01046a3>] show_stack_log_lvl+0x9d/0xa5
 [<c0104769>] show_registers+0xbe/0x1fd
 [<c01049c1>] die+0x119/0x20a
 [<c010ef52>] do_page_fault+0x480/0x57e
 [<c010ca34>] __ipipe_handle_exception+0x11e/0x166
 [<c02a0e7f>] error_code+0x6f/0x80
 [<c01515bf>] __rt_task_receive+0xbe/0x113
 [<c0149b0d>] losyscall_event+0x99/0x13d
 [<c013f05b>] __ipipe_dispatch_event+0xac/0x16c
 [<c010c8b1>] __ipipe_syscall_root+0x6a/0xcf
 [<c0103e89>] system_call+0x29/0x4a
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Code: 00 00 8d 87 bc 04 00 00 39 c2 0f 95 c0 0f b6 c0 f7 d8 21 d0 31 db =
3d 58 02 00 00 74 06 8d 98 98 fd ff ff 8b 45 ec be 97 ff ff ff <8b> 93 =
74 04 00 00 3b 50 0c 77 23 85 d2 74 19 89 d1 8b b3 70 04=20
EIP: [<c014f014>] rt_task_receive+0x113/0x18b SS:ESP 0068:cdc71ec4
---[ end trace 523bcd2b73b75979 ]---





------_=_NextPart_001_01C8B056.E6C9948D
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>rt_task_send / receive problems various issues and bug =
trace</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hello,<BR>
<BR>
I'm using rt_task_send from a talker task and rt_task_receive/reply from =
a listener task.&nbsp; When I launch the two tasks in the following =
order: listener task,&nbsp; talker task,&nbsp; everything runs =
normally.<BR>
<BR>
However, when I launch the talker task first, and then the listener task =
second, I receive rt_task_send error -22 and after a bit of time the =
listener task starts up. I know this is logical and to be expected, =
however, it appears that issuing the rt_task_send command to a task that =
hasn't been started occasionally locks up sufficient resources to =
prevent the listener task from starting.&nbsp; By controlling task =
startup order, I was able to circumvent this issue.&nbsp; Both tasks =
have similar priorities (50, 51).<BR>
<BR>
Additionally, I am unable to use rt_task_send with TM_NONBLOCK<BR>
len =3D =
rt_task_send(listen_task,&amp;talk_send,&amp;talk_reply,TM_NONBLOCK);<BR>=

<BR>
I get a bug failure and have to reset the machine-- see below:<BR>
<BR>
The reason I want to use TM_NONBLOCK is so that I can send a trigger =
message from the producer task to the consumer task without requiring a =
reply to trigger the consumer task to act on the data received. I am =
using the rt_task_send trigger message to gate and synchronize the =
consumer task. Is a reply required for all rt_task_send?&nbsp;<BR>
<BR>
It seems if I don't send a reply when rt_task_send has a timeout =
specified the sending task locks up and the listening task runs rampant, =
i.e. rt_task_receive no longer blocks and the loop runs with no delay =
and essentially locks up the machine, since I don't use =
rt_set_task_periodic on the listening task.<BR>
<BR>
Here is the trace, and it requires a reboot.&nbsp; I also can attach the =
code- it is written in c++ with two separate classes as a model of the =
application I am building.<BR>
<BR>
Thank you,<BR>
<BR>
Joshua Karch<BR>
<BR>
talker task started<BR>
rt_task_send error<BR>
len=3D-22, opcode=3D0<BR>
listener task stBUG: unable to handle kernel NULL pointer =
dereferencearted<BR>
rt_task_s at virtual address 0000020c<BR>
end error<BR>
len=3D-printing eip: c014f014 110, opcode=3D0<BR>
*pde =3D 00000000<BR>
Oops: 0000 [#1] PREEMPT<BR>
Modules linked in: xeno_timerbench nfs ipv6 nfsd lockd nfs_acl sunrpc =
exportfs dm_snapshot dm_mirror dm_mod loop pcmcia firmware_class =
serio_raw psmouse yenta_socket rsrc_nonstatic pcmcia_core cs5535_gpio =
joydev evdev ext3 jbd mbcache usbhid ide_disk generic ohci_hcd ehci_hcd =
amd74xx usbcore ide_core e100 mii<BR>
<BR>
Pid: 1973, comm: listen_task Not tainted (2.6.24.4 #12)<BR>
EIP: 0060:[&lt;c014f014&gt;] EFLAGS: 00010093 CPU: 0<BR>
EIP is at rt_task_receive+0x113/0x18b<BR>
EAX: cdc71f28 EBX: fffffd98 ECX: c03c5500 EDX: cd820acc<BR>
ESI: ffffff97 EDI: cd820610 EBP: cdc71edc ESP: cdc71ec4<BR>
&nbsp;DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068<BR>
Process listen_task (pid: 1973, ti=3Dcdc70000 task=3Dcdc6d320 =
task.ti=3Dcdc70000)&lt;0&gt;<BR>
I-pipe domain Linux<BR>
Stack: 00000000 cdc71f28 00000000 cdc71ee8 cdc6d320 cdc71fb8 cdc71f4c =
c01515bf<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b7d083ea cdc71f00 c0102cb1 ce46bc70 =
c03c7e90 cd820620 cdc6d620 cd80ff44<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c029f55b cdc71f34 00000082 b91264ee =
0000002e cdc6d320 b9127ee2 0000002e<BR>
Call Trace:<BR>
&nbsp;[&lt;c01045f1&gt;] show_trace_log_lvl+0x1a/0x2f<BR>
&nbsp;[&lt;c01046a3&gt;] show_stack_log_lvl+0x9d/0xa5<BR>
&nbsp;[&lt;c0104769&gt;] show_registers+0xbe/0x1fd<BR>
&nbsp;[&lt;c01049c1&gt;] die+0x119/0x20a<BR>
&nbsp;[&lt;c010ef52&gt;] do_page_fault+0x480/0x57e<BR>
&nbsp;[&lt;c010ca34&gt;] __ipipe_handle_exception+0x11e/0x166<BR>
&nbsp;[&lt;c02a0e7f&gt;] error_code+0x6f/0x80<BR>
&nbsp;[&lt;c01515bf&gt;] __rt_task_receive+0xbe/0x113<BR>
&nbsp;[&lt;c0149b0d&gt;] losyscall_event+0x99/0x13d<BR>
&nbsp;[&lt;c013f05b&gt;] __ipipe_dispatch_event+0xac/0x16c<BR>
&nbsp;[&lt;c010c8b1&gt;] __ipipe_syscall_root+0x6a/0xcf<BR>
&nbsp;[&lt;c0103e89&gt;] system_call+0x29/0x4a<BR>
&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<BR>
Code: 00 00 8d 87 bc 04 00 00 39 c2 0f 95 c0 0f b6 c0 f7 d8 21 d0 31 db =
3d 58 02 00 00 74 06 8d 98 98 fd ff ff 8b 45 ec be 97 ff ff ff =
&lt;8b&gt; 93 74 04 00 00 3b 50 0c 77 23 85 d2 74 19 89 d1 8b b3 70 =
04<BR>
EIP: [&lt;c014f014&gt;] rt_task_receive+0x113/0x18b SS:ESP =
0068:cdc71ec4<BR>
---[ end trace 523bcd2b73b75979 ]---<BR>
<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8B056.E6C9948D--

