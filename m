Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6FCF0.19513F8C"
Date: Tue, 31 Oct 2006 13:25:56 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0144D680@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-help] Kernel OOps large appl.
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

------_=_NextPart_001_01C6FCF0.19513F8C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
we are porting our application to the POSIX skin of Xenomai. We are
using a 2.4.25 Denx based Kernel with 4 days old Xenomai 2.3-devel svn
trunk on a MPC5200B based custom board. The application spawns 36
Threads, uses 265 mutexes and 22 condition variables. We increased all
numbers that can be set inside Xenomai kernel config to 10x, just to be
sure we are not blowing out Kernel limits (Prinzip: Stange im Nebel).
=20
=20
The following output of ksymoops will be done for the occuring oops:
=20
Oops: kernel access of bad area, sig: 11
NIP: C0012A00 XER: 20000000 LR: C00129DC SP: C9589E30 REGS: c9589d80
TRAP: 0300    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c9588000[294] 'ApplicationExe' Last syscall: 285344299
last math c8020000 last altivec 00000000
GPR00: C00129DC C9589E30 C9588000 FFFFFFFF C0008878 C01F82C0 C9587FFF
C01FCF48
GPR08: 003C62E0 C01FCF40 6C800000 CDE86268 00000000 1001A288 00000000
00000000
GPR16: 00000000 00000000 C0200000 C0240000 C0210000 C0200000 C0200000
C0210000
GPR24: 00000001 C0230000 C0260000 C0222420 CFE50000 00000000 00000000
C9589E30
Call backtrace:
C00129DC C011FB94 C0120F18 C0025FBC C000D638 C0005A3C 0FFD9F80
0FC4B888 0FC4B750 0FC0CF40 0FFD890C 0FF68FC0 0EE6C9A0
Warning (Oops_read): Code line not seen, dumping what data is available
=20

>>NIP; c0012a00 <schedule+2a4/574>   <=3D=3D=3D=3D=3D
=20
>>GPR0; c00129dc <schedule+280/574>
>>GPR4; c0008878 <_switch_to+5c/90>
>>GPR5; c01f82c0 <init_signals+3d4/504>
>>GPR7; c01fcf48 <ipipe_root+1008/2dc0>
>>GPR9; c01fcf40 <ipipe_root+1000/2dc0>
>>GPR18; c0200000 <pid_base_dentry_operations+4/18>
>>GPR19; c0240000 <read_buffers+b20/8000>
>>GPR20; c0210000 <__ksymtab_get_buffer_flushtime+0/8>
>>GPR21; c0200000 <pid_base_dentry_operations+4/18>
>>GPR22; c0200000 <pid_base_dentry_operations+4/18>
>>GPR23; c0210000 <__ksymtab_get_buffer_flushtime+0/8>
>>GPR25; c0230000 <exec_domains_lock+394/400>
>>GPR26; c0260000 <xnpipe_states+1630/9600>
>>GPR27; c0222420 <rtcan_init+4/4c>
=20
Trace; c00129dc <schedule+280/574>
Trace; c011fb94 <xnshadow_ppd_lookup_inner+12c/1d4>
Trace; c0120f18 <xnshadow_sys_bind+298/300>
Trace; c0025fbc <__ipipe_dispatch_event+b4/198>
Trace; c000d638 <__ipipe_syscall_root+44/e0>
Trace; c0005a3c <DoSyscall+1c/90>
Trace; 0ffd9f80 Before first symbol
Trace; 0fc4b888 Before first symbol
Trace; 0fc4b750 Before first symbol
Trace; 0fc0cf40 Before first symbol
Trace; 0ffd890c Before first symbol
Trace; 0ff68fc0 Before first symbol
Trace; 0ee6c9a0 Before first symbol
=20
=20
=20
The call right before entering the system space traced down with a
running gdb is __wrap_clock_nanosleep().
It always happens here. But when just testing this function alone in a
cycle, no kernel oops happens. The oops seems to be a correlation of
different events.
=20
=20
On the other side we have a constant problem with clock_nanosleep() in
that it always returns after 1/4 of the supposed time.
=20
I.e. calling
=20
struct timespec t
t.tv_sec =3D 5; t.tv_nsec =3D 0;
clock_nanosleep(CLOCK_REALTIME, 0, &t, NULL);
=20
returns after 1 second and not 4.
=20
Whereas clock_gettime(CLOCK_REALTIME, &t) works correctly (i.e. the
difference of two timestamps taken before and after clock_nanosleep()
with the above settings results in a diff time of 1 sec). So somehow the
external hardware timer setup is incorrect or maybe frequencies ?
=20
Any ideas ?
=20
=20
Regards,
=20
Daniel.
=20

------_=_NextPart_001_01C6FCF0.19513F8C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2963" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2>Hi,</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial size=3D2>we are =
porting our=20
application to the POSIX skin of Xenomai. We are using a 2.4.25 Denx =
based=20
Kernel with 4 days old Xenomai 2.3-devel svn trunk on a MPC5200B based =
custom=20
board. The application spawns 36 Threads, uses 265 mutexes and 22 =
condition=20
variables. We increased all numbers that can be set inside Xenomai =
kernel=20
config&nbsp;to 10x, just to be sure we are not blowing out Kernel limits =

(Prinzip: Stange im Nebel).</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial size=3D2>The =
following output=20
of ksymoops&nbsp;will be done for the occuring oops:</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial size=3D2>Oops: =
kernel access=20
of bad area, sig: 11<BR>NIP: C0012A00 XER: 20000000 LR: C00129DC SP: =
C9589E30=20
REGS: c9589d80 TRAP: 0300&nbsp;&nbsp;&nbsp; Not tainted<BR>Using =
defaults from=20
ksymoops -t elf32-powerpc -a powerpc:common<BR>MSR: 00009032 EE: 1 PR: 0 =
FP: 0=20
ME: 1 IR/DR: 11<BR>TASK =3D c9588000[294] 'ApplicationExe' Last syscall: =

285344299<BR>last math c8020000 last altivec 00000000<BR>GPR00: C00129DC =

C9589E30 C9588000 FFFFFFFF C0008878 C01F82C0 C9587FFF C01FCF48<BR>GPR08: =

003C62E0 C01FCF40 6C800000 CDE86268 00000000 1001A288 00000000=20
00000000<BR>GPR16: 00000000 00000000 C0200000 C0240000 C0210000 C0200000 =

C0200000 C0210000<BR>GPR24: 00000001 C0230000 C0260000 C0222420 CFE50000 =

00000000 00000000 C9589E30<BR>Call backtrace:<BR>C00129DC C011FB94 =
C0120F18=20
C0025FBC C000D638 C0005A3C 0FFD9F80<BR>0FC4B888 0FC4B750 0FC0CF40 =
0FFD890C=20
0FF68FC0 0EE6C9A0<BR>Warning (Oops_read): Code line not seen, dumping =
what data=20
is available</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV><SPAN class=3D780154912-31102006><FONT face=3DArial =
size=3D2>
<DIV><BR>&gt;&gt;NIP; c0012a00 &lt;schedule+2a4/574&gt;&nbsp;&nbsp;=20
&lt;=3D=3D=3D=3D=3D</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt;&gt;GPR0; c00129dc &lt;schedule+280/574&gt;<BR>&gt;&gt;GPR4; =
c0008878=20
&lt;_switch_to+5c/90&gt;<BR>&gt;&gt;GPR5; c01f82c0=20
&lt;init_signals+3d4/504&gt;<BR>&gt;&gt;GPR7; c01fcf48=20
&lt;ipipe_root+1008/2dc0&gt;<BR>&gt;&gt;GPR9; c01fcf40=20
&lt;ipipe_root+1000/2dc0&gt;<BR>&gt;&gt;GPR18; c0200000=20
&lt;pid_base_dentry_operations+4/18&gt;<BR>&gt;&gt;GPR19; c0240000=20
&lt;read_buffers+b20/8000&gt;<BR>&gt;&gt;GPR20; c0210000=20
&lt;__ksymtab_get_buffer_flushtime+0/8&gt;<BR>&gt;&gt;GPR21; c0200000=20
&lt;pid_base_dentry_operations+4/18&gt;<BR>&gt;&gt;GPR22; c0200000=20
&lt;pid_base_dentry_operations+4/18&gt;<BR>&gt;&gt;GPR23; c0210000=20
&lt;__ksymtab_get_buffer_flushtime+0/8&gt;<BR>&gt;&gt;GPR25; c0230000=20
&lt;exec_domains_lock+394/400&gt;<BR>&gt;&gt;GPR26; c0260000=20
&lt;xnpipe_states+1630/9600&gt;<BR>&gt;&gt;GPR27; c0222420=20
&lt;rtcan_init+4/4c&gt;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Trace; c00129dc &lt;schedule+280/574&gt;<BR>Trace; c011fb94=20
&lt;xnshadow_ppd_lookup_inner+12c/1d4&gt;<BR>Trace; c0120f18=20
&lt;xnshadow_sys_bind+298/300&gt;<BR>Trace; c0025fbc=20
&lt;__ipipe_dispatch_event+b4/198&gt;<BR>Trace; c000d638=20
&lt;__ipipe_syscall_root+44/e0&gt;<BR>Trace; c0005a3c=20
&lt;DoSyscall+1c/90&gt;<BR>Trace; 0ffd9f80 Before first symbol<BR>Trace; =

0fc4b888 Before first symbol<BR>Trace; 0fc4b750 Before first =
symbol<BR>Trace;=20
0fc0cf40 Before first symbol<BR>Trace; 0ffd890c Before first =
symbol<BR>Trace;=20
0ff68fc0 Before first symbol<BR>Trace; 0ee6c9a0 Before first=20
symbol</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial size=3D2>The =
call right=20
before entering the system space traced down with a running gdb is=20
__wrap_clock_nanosleep().</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial size=3D2>It =
always happens=20
here. But when just testing this function alone in a cycle, no kernel =
oops=20
happens. The oops seems to be a correlation of different=20
events.</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial size=3D2>On the =
other side we=20
have a constant problem with clock_nanosleep() in that it always returns =

after&nbsp;1/4 of the supposed time.</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2>I.e.&nbsp;calling</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006></SPAN><SPAN =
class=3D780154912-31102006><FONT=20
face=3DArial size=3D2>struct timespec t</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial =
size=3D2>t.tv_sec =3D 5;=20
t.tv_nsec =3D 0;</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2>clock_nanosleep(CLOCK_REALTIME, 0, &amp;t, =
NULL);</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial =
size=3D2>returns after 1=20
second and not 4.</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial =
size=3D2>Whereas=20
clock_gettime(CLOCK_REALTIME, &amp;t)&nbsp;works correctly (i.e. the =
difference=20
of two timestamps taken before and after clock_nanosleep() with the =
above=20
settings results in a diff time of 1 sec). So somehow the external =
hardware=20
timer setup is incorrect or maybe frequencies ?</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial size=3D2>Any =
ideas=20
?</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2>Regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2>Daniel.</FONT></SPAN></DIV>
<DIV><SPAN class=3D780154912-31102006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C6FCF0.19513F8C--

