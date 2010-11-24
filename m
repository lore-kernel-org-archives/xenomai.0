Message-Id: <8slt5a$7j1pnr@domain.hid>
From: "Gao" <gwysu@domain.hid>
Date: Wed, 24 Nov 2010 13:32:23 +0800
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0012_01CB8BDC.091B6F50"
Subject: [Xenomai-help] Kernel crash issues running pSoS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_0012_01CB8BDC.091B6F50
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0013_01CB8BDC.091DE050"


------=_NextPart_001_0013_01CB8BDC.091DE050
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
 
I am running pSoS skin with Xenomai 2.5.3 and kernel 2.6.33.4 on powerpc
cpu: MPC870, sometimes the kernel crashes with dump informaion:
      
load_------------[ cut here ]------------
 
kernel BUG at fs/buffer.c:1271!
 
Oops: Exception in kernel mode, sig: 5 [#1]
 
RxT-Carrier
 
load_------------[ cut here ]------------
 
kernel BUG at fs/buffer.c:1271!
 
Oops: Exception in kernel mode, sig: 5 [#1]
 
RxT-Carrier
 
Modules linked in: xeno_psos
 
NIP: c00d6608 LR: c00d682c CTR: c010ff78
 
REGS: c1a15ba0 TRAP: 0700   Not tainted  (2.6.33.4)
 
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 44820442  XER: 20000000
 
TASK = c190ed60[348] 'MAIN' THREAD: c1a14000
 
GPR00: 00000001 c1a15c50 c190ed60 c14021a0 00040002 00001000 00000080
00004000 
 
GPR08: 00000fff c0390000 00000000 02000400 44820442 109eb2a0 01ffe800
01ff50a0 
 
GPR16: 01fd05d8 01ff507c ffffff9c c1a15e64 fffffff4 c03b0000 c1a15d98
c1a15da0 
 
GPR24: c14a72c0 c1942d80 00040002 c14021a0 c14a7cd0 00001000 c0394ae0
c193ec00 
 
NIP [c00d6608] __find_get_block+0x28/0x22c
 
LR [c00d682c] __getblk+0x20/0x220
 
Call Trace:
 
[c1a15c50] [20000000] 0x20000000 (unreliable)
 
[c1a15ca0] [c00d682c] __getblk+0x20/0x220
 
[c1a15cd0] [c0105e90] __ext3_get_inode_loc+0xe4/0x364
 
[c1a15d00] [c0109d08] ext3_iget+0x60/0x56c
 
[c1a15d30] [c010dbd0] ext3_lookup+0xf8/0x164
 
[c1a15d60] [c00bb270] do_lookup+0x1b4/0x210
 
[c1a15d90] [c00bccfc] link_path_walk+0x564/0xbfc
 
[c1a15df0] [c00bd3dc] path_walk+0x48/0xcc
 
[c1a15e20] [c00bd550] do_path_lookup+0x64/0x6c
 
[c1a15e40] [c00be370] do_filp_open+0xd8/0x9a8
 
[c1a15f10] [c00afff4] do_sys_open+0x64/0x130
 
[c1a15f40] [c000f8a0] ret_from_syscall+0x0/0x38
 
Instruction dump:
 
813f000c 4bffffac 7c0802a6 9421ffb0 7d800026 bf210034 90010054 91810030 
 
3d20c039 80094ae0 3bc94ae0 540007fe <0f000000> 38000008 7c0903a6 3d20c039 
 
---[ end trace f21c6826c169a5b9 ]---

 
Also the following issue happens:
 
 
------------[ cut here ]------------
 
Badness at kernel/softirq.c:143
 
NIP: c0022df8 LR: c0251a88 CTR: c0222650
 
REGS: c1a31b10 TRAP: 0700   Not tainted  (2.6.33.4)
 
MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 42008442  XER: 20000000
 
TASK = c190e940[348] 'MAIN' THREAD: c1a30000
 
GPR00: 00000001 c1a31bc0 c190e940 00000000 00000004 0000000f 00000001
00000001 
 
GPR08: 00000000 c03b9860 00000001 00000000 000367ad 109eacd0 ac1f025d
00000000 
 
GPR16: 00000000 00000000 00004e20 00000000 ac1f025d 00000000 00000000
0000000c 
 
GPR24: 0000cba8 00004000 00000000 c1876800 c1929600 c1839c80 c182f84c
c1a30000 
 
NIP [c0022df8] local_bh_enable+0x30/0xa8
 
LR [c0251a88] dev_queue_xmit+0x110/0x48c
 
Call Trace:
 
[c1a31bc0] [c1839c80] 0xc1839c80 (unreliable)
 
[c1a31bd0] [c0251a88] dev_queue_xmit+0x110/0x48c
 
[c1a31c00] [c026de34] ip_finish_output+0xfc/0x314
 
[c1a31c20] [c026e0d0] ip_local_out+0x34/0x48
 
[c1a31c30] [c026e364] ip_push_pending_frames+0x280/0x39c
 
[c1a31c60] [c028cbec] udp_push_pending_frames+0x128/0x3e4
 
[c1a31c90] [c028e290] udp_sendmsg+0x2f8/0x5dc
 
[c1a31d40] [c0295384] inet_sendmsg+0x4c/0x78
 
[c1a31d60] [c023cae8] sock_sendmsg+0x90/0xc8
 
[c1a31e30] [c023d60c] sys_sendto+0xbc/0xf0
 
[c1a31f00] [c023e738] sys_socketcall+0x17c/0x204
 
[c1a31f40] [c000f8a0] ret_from_syscall+0x0/0x38
 
Instruction dump:
 
7c0802a6 9421fff0 93e1000c 90010014 543f0024 801f000c 740903ff 41820064 
 
3d20c03c 39299860 89690042 69600001 <0f000000> 2f8b0000 419e0064 813f000c 

 
 
Does anyone experience the problem or have idea about the problem? Thanks. 
 
 
 
Best regards,
Wenyi Gao

 


------=_NextPart_001_0013_01CB8BDC.091DE050
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE id=3DridTitle>Blank</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<STYLE><!-- body  { font-family: Arial, Helvetica; font-size: 10pt; =
color: #000000; margin-top: 25px; margin-left: 25px; } P.msoNormal, =
LI.msoNormal  { font-family: Helvetica, "Times New Roman"; font-size: =
10pt; margin-top: 0px; margin-left: 0px; color: "#ffffcc"; } --></STYLE>

<META content=3D"MSHTML 6.00.2900.3698" name=3DGENERATOR></HEAD>
<BODY id=3DridBody background=3Dcid:687222405@domain.hid>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>H<SPAN=20
class=3D687222405-24112010>ello</SPAN><SPAN=20
class=3D687222405-24112010>,</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D687222405-24112010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010></SPAN><FONT=20
size=3D3><SPAN class=3D687222405-24112010>I am running =
pSoS&nbsp;skin&nbsp;with=20
Xenomai 2.5.3 and kernel 2.6.33.4 on powerpc cpu: MPC870, sometimes the=20
kernel&nbsp;crashes with&nbsp;dump =
informaion:</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D687222405-24112010>&nbsp;</SPAN>&nbsp;&nbsp;&nbsp;&nbsp;=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>load_------------[ =
cut here=20
]------------</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>kernel BUG at=20
fs/buffer.c:1271!</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Oops: Exception in =
kernel mode,=20
sig: 5 [#1]</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3>RxT-Carrier</FONT></SPAN></DIV>
<DIV><FONT size=3D4></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>load_------------[ =
cut here=20
]------------</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>kernel BUG at=20
fs/buffer.c:1271!</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Oops: Exception in =
kernel mode,=20
sig: 5 [#1]</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3>RxT-Carrier</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Modules linked in:=20
xeno_psos</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>NIP: c00d6608 LR: =
c00d682c CTR:=20
c010ff78</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>REGS: c1a15ba0 =
TRAP:=20
0700&nbsp;&nbsp; Not tainted&nbsp; (2.6.33.4)</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>MSR: 00029032=20
&lt;EE,ME,CE,IR,DR&gt;&nbsp; CR: 44820442&nbsp; XER:=20
20000000</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>TASK =3D =
c190ed60[348] 'MAIN'=20
THREAD: c1a14000</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>GPR00: 00000001 =
c1a15c50=20
c190ed60 c14021a0 00040002 00001000 00000080 00004000 =
</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>GPR08: 00000fff =
c0390000=20
00000000 02000400 44820442 109eb2a0 01ffe800 01ff50a0 =
</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>GPR16: 01fd05d8 =
01ff507c=20
ffffff9c c1a15e64 fffffff4 c03b0000 c1a15d98 c1a15da0 =
</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>GPR24: c14a72c0 =
c1942d80=20
00040002 c14021a0 c14a7cd0 00001000 c0394ae0 c193ec00 =
</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>NIP [c00d6608]=20
__find_get_block+0x28/0x22c</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>LR [c00d682c]=20
__getblk+0x20/0x220</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Call =
Trace:</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15c50] =
[20000000]=20
0x20000000 (unreliable)</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15ca0] =
[c00d682c]=20
__getblk+0x20/0x220</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15cd0] =
[c0105e90]=20
__ext3_get_inode_loc+0xe4/0x364</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15d00] =
[c0109d08]=20
ext3_iget+0x60/0x56c</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15d30] =
[c010dbd0]=20
ext3_lookup+0xf8/0x164</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15d60] =
[c00bb270]=20
do_lookup+0x1b4/0x210</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15d90] =
[c00bccfc]=20
link_path_walk+0x564/0xbfc</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15df0] =
[c00bd3dc]=20
path_walk+0x48/0xcc</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15e20] =
[c00bd550]=20
do_path_lookup+0x64/0x6c</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15e40] =
[c00be370]=20
do_filp_open+0xd8/0x9a8</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15f10] =
[c00afff4]=20
do_sys_open+0x64/0x130</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>[c1a15f40] =
[c000f8a0]=20
ret_from_syscall+0x0/0x38</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Instruction=20
dump:</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>813f000c 4bffffac =
7c0802a6=20
9421ffb0 7d800026 bf210034 90010054 91810030 </FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>3d20c039 80094ae0 =
3bc94ae0=20
540007fe &lt;0f000000&gt; 38000008 7c0903a6 3d20c039 =
</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>---[ end trace =
f21c6826c169a5b9=20
]---<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D687222405-24112010><FONT size=3D4>Also the following issue=20
happens:</FONT></SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D4><SPAN=20
class=3D687222405-24112010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D4><SPAN=20
class=3D687222405-24112010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>------------[ cut here ]------------</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>Badness at kernel/softirq.c:143</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>NIP: c0022df8 LR: c0251a88 CTR: =
c0222650</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>REGS: c1a31b10 TRAP: 0700&nbsp;&nbsp; Not tainted&nbsp;=20
(2.6.33.4)</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;&nbsp; CR: 42008442&nbsp; =
XER:=20
20000000</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>TASK =3D c190e940[348] 'MAIN' THREAD: =
c1a30000</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>GPR00: 00000001 c1a31bc0 c190e940 00000000 00000004 0000000f =
00000001=20
00000001 </FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>GPR08: 00000000 c03b9860 00000001 00000000 000367ad 109eacd0 =
ac1f025d=20
00000000 </FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>GPR16: 00000000 00000000 00004e20 00000000 ac1f025d 00000000 =
00000000=20
0000000c </FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>GPR24: 0000cba8 00004000 00000000 c1876800 c1929600 c1839c80 =
c182f84c=20
c1a30000 </FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>NIP [c0022df8] =
local_bh_enable+0x30/0xa8</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>LR [c0251a88] =
dev_queue_xmit+0x110/0x48c</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>Call Trace:</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31bc0] [c1839c80] 0xc1839c80 =
(unreliable)</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31bd0] [c0251a88]=20
dev_queue_xmit+0x110/0x48c</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31c00] [c026de34]=20
ip_finish_output+0xfc/0x314</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31c20] [c026e0d0] =
ip_local_out+0x34/0x48</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31c30] [c026e364]=20
ip_push_pending_frames+0x280/0x39c</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31c60] [c028cbec]=20
udp_push_pending_frames+0x128/0x3e4</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31c90] [c028e290] =
udp_sendmsg+0x2f8/0x5dc</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31d40] [c0295384] =
inet_sendmsg+0x4c/0x78</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31d60] [c023cae8] =
sock_sendmsg+0x90/0xc8</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31e30] [c023d60c] =
sys_sendto+0xbc/0xf0</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31f00] [c023e738]=20
sys_socketcall+0x17c/0x204</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>[c1a31f40] [c000f8a0]=20
ret_from_syscall+0x0/0x38</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>Instruction dump:</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>7c0802a6 9421fff0 93e1000c 90010014 543f0024 801f000c 740903ff =
41820064=20
</FONT></SPAN></SPAN></DIV>
<DIV><FONT size=3D3></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D687222405-24112010><FONT=20
size=3D3>3d20c03c 39299860 89690042 69600001 &lt;0f000000&gt; 2f8b0000 =
419e0064=20
813f000c <BR></FONT></SPAN></DIV></SPAN>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D687222405-24112010><FONT size=3D4>Does anyone =
experience&nbsp;the problem or=20
have idea about the&nbsp;problem?=20
Thanks.&nbsp;</FONT></SPAN></DIV></FONT></SPAN>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Wenyi=20
Gao</FONT></SPAN></DIV><IFRAME width=3D100 height=3D0></IFRAME>
<P><FONT size=3D4></FONT>&nbsp;</P></BODY></HTML>

------=_NextPart_001_0013_01CB8BDC.091DE050--

------=_NextPart_000_0012_01CB8BDC.091B6F50
Content-Type: image/gif;
	name="Blank Bkgrd.gif"
Content-Transfer-Encoding: base64
Content-ID: <687222405@domain.hid>

R0lGODlhLQAtAID/AP////f39ywAAAAALQAtAEACcAxup8vtvxKQsFon6d02898pGkgiYoCm6sq2
7iqWcmzOsmeXeA7uPJd5CYdD2g9oPF58ygqz+XhCG9JpJGmlYrPXGlfr/Yo/VW45e7amp2tou/lW
xo/zX513z+Vt+1n/tiX2pxP4NUhy2FM4xtjIUQAAOw==

------=_NextPart_000_0012_01CB8BDC.091B6F50--


