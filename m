Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86A7E.AE553D80"
Date: Fri, 8 Feb 2008 11:16:09 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D376A62@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: [Xenomai-help] BUG fs/buffer.c:1245
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

------_=_NextPart_001_01C86A7E.AE553D80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I get the following bug when sending data over tcp/ip from a linux
thread with xenomai apps running:

=20

The reason I ask the list is because the call that triggers this is
irqs_disabled().

=20

What I'm doing is sending data over an RT_PIPE from a realtime task,
while a linux thread wakes up and receives a message from the pipe and
then sends it out over tcp/ip.

=20

Steven

=20

kernel BUG at fs/buffer.c:1245!

invalid opcode: 0000 [#1]

PREEMPT

Modules linked in: nfs lockd sunrpc st_dacsnd(P) eepro100 xeno_native
xeno_nucleus

CPU:    0

EIP:    0060:[<c017e9a2>]    Tainted: P        VLI

EFLAGS: 00010046   (2.6.23.12-target-xenomai #3)

EIP is at __find_get_block+0x182/0x1a0

eax: 00000000   ebx: 00000000   ecx: 00000400   edx: 00033a01

esi: c10551a0   edi: 00033a01   ebp: 00000000   esp: c187dc08

ds: 007b   es: 007b   fs: 0000  gs: 0033  ss: 0068

Process rtlogd (pid: 881, ti=3Dc187c000 task=3Dc13b6aa0 =
task.ti=3Dc187c000)<0>

I-pipe domain Linux

Stack: c1111380 c11114d0 00000000 00000001 00000400 00000000 c017e9d6
c1c69700

       00000000 00000001 00000400 00000000 c017e9d6 00000001 c10ee400
00000000

       00033a01 c10551a0 00000000 00000001 c1b92090 00000000 c01a124b
00000001

Call Trace:

 [<c017e9d6>] __getblk+0x16/0x210

 [<c017e9d6>] __getblk+0x16/0x210

 [<c01a124b>] ext3_getblk+0xfb/0x230

 [<c01a4a79>] dx_probe+0x89/0x2f0

 [<c01a5745>] ext3_find_entry+0x235/0x620

 [<c017e8c4>] __find_get_block+0xa4/0x1a0

 [<c01a008a>] __ext3_get_inode_loc+0xea/0x350

 [<c017e9d6>] __getblk+0x16/0x210

 [<c0117afc>] do_softirq+0x4c/0x60

 [<c01a33f2>] ext3_read_inode+0x1f2/0x320

 [<c0159a33>] kmem_cache_alloc+0x53/0xc0

 [<c016e3b5>] d_rehash+0x15/0x50

 [<c01a718c>] ext3_lookup+0x3c/0x120

 [<c016f42c>] d_alloc+0x1c/0x1a0

 [<c0164d02>] do_lookup+0x122/0x1a0

 [<c0166879>] __link_path_walk+0x7f9/0xeb0

 [<c010bdce>] __ipipe_pin_range_globally+0xfe/0x110

 [<c0166f73>] link_path_walk+0x43/0xc0

 [<c2950b78>] xnarch_trap_fault+0x18/0x20 [xeno_nucleus]

 [<c0275e6a>] exception_event+0x2a/0x40

 [<c015b72f>] get_unused_fd_flags+0x4f/0xe0

 [<c0167225>] do_path_lookup+0x85/0x200

 [<c015e6a3>] get_empty_filp+0x33/0x120

 [<c0167e81>] __path_lookup_intent_open+0x51/0xa0

 [<c0167f60>] path_lookup_open+0x20/0x30

 [<c016806f>] open_namei+0x6f/0x640

 [<c014b636>] acct_stack_growth+0xa6/0xc0

 [<c015baa3>] do_filp_open+0x33/0x60

 [<c2950b78>] xnarch_trap_fault+0x18/0x20 [xeno_nucleus]

 [<c0275e6a>] exception_event+0x2a/0x40

 [<c015b72f>] get_unused_fd_flags+0x4f/0xe0

 [<c015bb20>] do_sys_open+0x50/0xf0

 [<c015bbfc>] sys_open+0x1c/0x20

 [<c0102b81>] syscall_call+0x7/0xb

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Code: ff ff 83 68 14 01 8b 40 08 a8 04 75 2c 85 ed 0f 84 30 ff ff ff 89
e8 e8 7d f6 ff ff e9 24 ff ff ff 89 d8 e8 71 f6 ff ff 90 eb 81 <0f> 0b
eb fe e8 35 36 18 00 e9 08 ff ff ff e8 2b 36 18 00 eb cd

EIP: [<c017e9a2>] __find_get_block+0x182/0x1a0 SS:ESP 0068:c187dc08

/ #

=20


------_=_NextPart_001_01C86A7E.AE553D80
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
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
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I get the following bug when sending data over tcp/ip =
from a
linux thread with xenomai apps running:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The reason I ask the list is because the call that =
triggers
this is irqs_disabled().<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What I&#8217;m doing is sending data over an RT_PIPE =
from a
realtime task, while a linux thread wakes up and receives a message from =
the
pipe and then sends it out over tcp/ip.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Steven<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>kernel BUG at =
fs/buffer.c:1245!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>invalid opcode: 0000 =
[#1]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>PREEMPT<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Modules linked in: nfs lockd sunrpc st_dacsnd(P) =
eepro100
xeno_native xeno_nucleus<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>CPU:&nbsp;&nbsp;&nbsp; 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EIP:&nbsp;&nbsp;&nbsp;
0060:[&lt;c017e9a2&gt;]&nbsp;&nbsp;&nbsp; Tainted:
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
VLI<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EFLAGS: 00010046&nbsp;&nbsp; =
(2.6.23.12-target-xenomai #3)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EIP is at =
__find_get_block+0x182/0x1a0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>eax: 00000000&nbsp;&nbsp; ebx: 00000000&nbsp;&nbsp; =
ecx:
00000400&nbsp;&nbsp; edx: 00033a01<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>esi: c10551a0&nbsp;&nbsp; edi: 00033a01&nbsp;&nbsp; =
ebp:
00000000&nbsp;&nbsp; esp: c187dc08<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>ds: 007b&nbsp;&nbsp; es: 007b&nbsp;&nbsp; fs: =
0000&nbsp; gs:
0033&nbsp; ss: 0068<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Process rtlogd (pid: 881, ti=3Dc187c000 =
task=3Dc13b6aa0
task.ti=3Dc187c000)&lt;0&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I-pipe domain Linux<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Stack: c1111380 c11114d0 00000000 00000001 00000400 =
00000000
c017e9d6 c1c69700<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 =
00000001
00000400 00000000 c017e9d6 00000001 c10ee400 =
00000000<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00033a01 =
c10551a0
00000000 00000001 c1b92090 00000000 c01a124b =
00000001<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Call Trace:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c017e9d6&gt;] =
__getblk+0x16/0x210<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c017e9d6&gt;] =
__getblk+0x16/0x210<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c01a124b&gt;] =
ext3_getblk+0xfb/0x230<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c01a4a79&gt;] =
dx_probe+0x89/0x2f0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c01a5745&gt;] =
ext3_find_entry+0x235/0x620<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c017e8c4&gt;] =
__find_get_block+0xa4/0x1a0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c01a008a&gt;] =
__ext3_get_inode_loc+0xea/0x350<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c017e9d6&gt;] =
__getblk+0x16/0x210<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0117afc&gt;] =
do_softirq+0x4c/0x60<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c01a33f2&gt;] =
ext3_read_inode+0x1f2/0x320<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0159a33&gt;] =
kmem_cache_alloc+0x53/0xc0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c016e3b5&gt;] =
d_rehash+0x15/0x50<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c01a718c&gt;] =
ext3_lookup+0x3c/0x120<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c016f42c&gt;] =
d_alloc+0x1c/0x1a0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0164d02&gt;] =
do_lookup+0x122/0x1a0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0166879&gt;] =
__link_path_walk+0x7f9/0xeb0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c010bdce&gt;]
__ipipe_pin_range_globally+0xfe/0x110<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0166f73&gt;] =
link_path_walk+0x43/0xc0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c2950b78&gt;] xnarch_trap_fault+0x18/0x20
[xeno_nucleus]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0275e6a&gt;] =
exception_event+0x2a/0x40<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c015b72f&gt;] =
get_unused_fd_flags+0x4f/0xe0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0167225&gt;] =
do_path_lookup+0x85/0x200<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c015e6a3&gt;] =
get_empty_filp+0x33/0x120<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0167e81&gt;] =
__path_lookup_intent_open+0x51/0xa0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0167f60&gt;] =
path_lookup_open+0x20/0x30<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c016806f&gt;] =
open_namei+0x6f/0x640<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c014b636&gt;] =
acct_stack_growth+0xa6/0xc0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c015baa3&gt;] =
do_filp_open+0x33/0x60<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c2950b78&gt;] xnarch_trap_fault+0x18/0x20 =
[xeno_nucleus]<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0275e6a&gt;] =
exception_event+0x2a/0x40<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c015b72f&gt;] =
get_unused_fd_flags+0x4f/0xe0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c015bb20&gt;] =
do_sys_open+0x50/0xf0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c015bbfc&gt;] =
sys_open+0x1c/0x20<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;[&lt;c0102b81&gt;] =
syscall_call+0x7/0xb<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Code: ff ff 83 68 14 01 8b 40 08 a8 04 75 2c 85 ed 0f =
84 30
ff ff ff 89 e8 e8 7d f6 ff ff e9 24 ff ff ff 89 d8 e8 71 f6 ff ff 90 eb =
81
&lt;0f&gt; 0b eb fe e8 35 36 18 00 e9 08 ff ff ff e8 2b 36 18 00 eb =
cd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>EIP: [&lt;c017e9a2&gt;] __find_get_block+0x182/0x1a0 =
SS:ESP
0068:c187dc08<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>/ #<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C86A7E.AE553D80--

