Message-Id: <8slsrl$4tljao@domain.hid>
From: "Gao" <gwysu@domain.hid>
Date: Tue, 14 Dec 2010 16:21:45 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001B_01CB9BAB.05197B20"
Subject: [Xenomai-help] Kernel crash caused by t_delete
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

------=_NextPart_000_001B_01CB9BAB.05197B20
Content-Type: multipart/related;
	boundary="----=_NextPart_001_001C_01CB9BAB.05197B20"


------=_NextPart_001_001C_01CB9BAB.05197B20
Content-Type: multipart/alternative;
	boundary="----=_NextPart_002_001D_01CB9BAB.05197B20"


------=_NextPart_002_001D_01CB9BAB.05197B20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello again:
 
 
 I an experiencing a rough issue about pSoS+ skin. I am using linux kernel
2.6.33.4, xenomai 2.5.4 and  adeos-ipipe-2.6.33.4-powerpc-2.9-01.patch on
MPC870.  The pSoS+  emulator is built as module. Attached is the demo.c used
to test.
 
When I run the demo at first time as follow step:
insmod xeno_psos.ko
./demo
It can run normally. 
But when I run it again with the following steps
rmmod xeno_psos 
insmod xeno_psos.ko
./demo
 
the kernel will crash with below information:
 
kernel BUG at fs/buffer.c:1271!
 
Oops: Exception in kernel mode, sig: 5 [#1]
 
RxT-Carrier
 
Modules linked in: module_mem xeno_psos 
 
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
 
 
The problem seemed to caused by t_delete(0). 
Sometimes, once the issue happens, after I power off the target and power on
again, and do nothing, the kerenl will still crach with above information.
 
Do anyone have an idea about the issues. Thanks in advance.
 
 
Best regards,
Wenyi Gao

 


------=_NextPart_002_001D_01CB9BAB.05197B20
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
<BODY id=3DridBody background=3Dcid:949141907@domain.hid>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D486354802-05122007><FONT =
size=3D3><SPAN=20
class=3D949141907-14122010>Hello again:</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D949141907-14122010></SPAN><FONT=20
size=3D3>&nbsp;<SPAN class=3D949141907-14122010>I an&nbsp;experiencing=20
a&nbsp;rough&nbsp;issue about pSoS+ skin. I am using linux kernel =
2.6.33.4,=20
xenomai&nbsp;2.5.4 and&nbsp;</SPAN>=20
adeos-ipipe-2.6.33.4-powerpc-2.9-01.patch&nbsp;<SPAN=20
class=3D949141907-14122010>on&nbsp;MPC870.&nbsp;&nbsp;The=20
pSoS+</SPAN>&nbsp;&nbsp;<SPAN class=3D949141907-14122010>emulator is =
built as=20
module. Attached is the demo.c used to test.</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>When I run the demo&nbsp;at first time as =
follow=20
step:</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>insmod =
xeno_psos.ko</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>./demo</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>It can run normally. =
</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>But when I run it again with the following=20
steps</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>rmmod xeno_psos </SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>insmod =
xeno_psos.ko</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>./demo</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>the kernel will crash with below=20
information:</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>kernel BUG at=20
fs/buffer.c:1271!</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>Oops: Exception in kernel mode, sig: 5=20
[#1]</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>RxT-Carrier</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>Modules linked in: module_mem xeno_psos=20
</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>NIP: c00d6608 LR: c00d682c CTR:=20
c010ff78</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>REGS: c1a15ba0 TRAP: 0700&nbsp;&nbsp; Not =
tainted&nbsp;=20
(2.6.33.4)</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;&nbsp; =
CR:=20
44820442&nbsp; XER: 20000000</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>TASK =3D c190ed60[348] 'MAIN' THREAD:=20
c1a14000</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>GPR00: 00000001 c1a15c50 c190ed60 c14021a0 =
00040002=20
00001000 00000080 00004000 </SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>GPR08: 00000fff c0390000 00000000 02000400 =
44820442=20
109eb2a0 01ffe800 01ff50a0 </SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>GPR16: 01fd05d8 01ff507c ffffff9c c1a15e64 =
fffffff4=20
c03b0000 c1a15d98 c1a15da0 </SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>GPR24: c14a72c0 c1942d80 00040002 c14021a0 =
c14a7cd0=20
00001000 c0394ae0 c193ec00 </SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>NIP [c00d6608]=20
__find_get_block+0x28/0x22c</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>LR [c00d682c]=20
__getblk+0x20/0x220</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>Call Trace:</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15c50] [20000000] 0x20000000=20
(unreliable)</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15ca0] [c00d682c]=20
__getblk+0x20/0x220</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15cd0] [c0105e90]=20
__ext3_get_inode_loc+0xe4/0x364</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15d00] [c0109d08]=20
ext3_iget+0x60/0x56c</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15d30] [c010dbd0]=20
ext3_lookup+0xf8/0x164</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15d60] [c00bb270]=20
do_lookup+0x1b4/0x210</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15d90] [c00bccfc]=20
link_path_walk+0x564/0xbfc</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15df0] [c00bd3dc]=20
path_walk+0x48/0xcc</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15e20] [c00bd550]=20
do_path_lookup+0x64/0x6c</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15e40] [c00be370]=20
do_filp_open+0xd8/0x9a8</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15f10] [c00afff4]=20
do_sys_open+0x64/0x130</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>[c1a15f40] [c000f8a0]=20
ret_from_syscall+0x0/0x38</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>Instruction dump:</SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>813f000c 4bffffac 7c0802a6 9421ffb0 7d800026 =
bf210034=20
90010054 91810030 </SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>3d20c039 80094ae0 3bc94ae0 540007fe =
&lt;0f000000&gt;=20
38000008 7c0903a6 3d20c039 </SPAN></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>---[ end trace f21c6826c169a5b9=20
]---</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>The problem seemed to caused by t_delete(0).=20
</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D949141907-14122010>Sometimes, once the issue happens, after I =
power off=20
the target and power on again, and do nothing, the kerenl will still =
crach with=20
above information.</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D949141907-14122010><FONT=20
size=3D3>Do anyone have an idea about the issues. Thanks in=20
advance.</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Wenyi=20
Gao</FONT></SPAN></DIV><IFRAME width=3D100 height=3D0></IFRAME>
<P>&nbsp;</P></BODY></HTML>

------=_NextPart_002_001D_01CB9BAB.05197B20--

------=_NextPart_001_001C_01CB9BAB.05197B20
Content-Type: image/gif;
	name="Blank Bkgrd.gif"
Content-Transfer-Encoding: base64
Content-ID: <949141907@domain.hid>

R0lGODlhLQAtAID/AP////f39ywAAAAALQAtAEACcAxup8vtvxKQsFon6d02898pGkgiYoCm6sq2
7iqWcmzOsmeXeA7uPJd5CYdD2g9oPF58ygqz+XhCG9JpJGmlYrPXGlfr/Yo/VW45e7amp2tou/lW
xo/zX513z+Vt+1n/tiX2pxP4NUhy2FM4xtjIUQAAOw==

------=_NextPart_001_001C_01CB9BAB.05197B20--

------=_NextPart_000_001B_01CB9BAB.05197B20
Content-Type: application/octet-stream;
	name="demo.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="demo.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>=0A=
#include <errno.h>=0A=
#include <sys/mman.h>
#include <psos.h>=0A=

#define EVENT1 1
#define EVENT2 2
=0A=
#define ERR_NO_ERROR	SUCCESS=0A=
=0A=

/************************************************************************=
*****
**  demo program global data structures
*************************************************************************=
****/
char partition_task2_part[1024];
char partition_task3_part[2048];
=0A=
=0A=
ULONG part2_numblks;
ULONG part3_numblks;

ULONG task1_id;
ULONG task2_id;
ULONG task3_id;
ULONG task4_id;=0A=
ULONG task5_id;=0A=

ULONG queue2_id;
ULONG queue3_id;
=0A=
ULONG timer_id;=0A=

ULONG part2_id;
ULONG part3_id;

ULONG sema41_id;

=0A=
#if 1
void task1( ULONG dummy0, ULONG dummy1, ULONG dummy2, ULONG dummy3 )
{
ULONG err, event, i;
char buffer[20];

tm_wkafter( 50 );

for (;;) {
    printf( "\r\ntask1 waiting on event mask %lx\n",
            (unsigned long)(EVENT1 | EVENT2) );
    err =3D ev_receive( EVENT1 | EVENT2, EV_ALL, 0, &event );

    if (event & EVENT1) {=0A=
    =0A=
    printf("received event 1\n");=0A=
        =0A=
      {
          for (i =3D 0; i < 10; i++)
              buffer[i] =3D 'A' + i;
          buffer[i] =3D 0;

          printf("\r\ntask1's message for task2: %s\n", buffer );

          err =3D q_vsend( queue2_id, buffer, 11 );
         // err =3D pt_retbuf( part2_id, buffer );
      }=0A=
     =20
    }=0A=
   =20
    if (event & EVENT2) {=0A=
    =0A=
    printf("received event 2\n");=0A=
    =0A=
   =20
      {
          for (i =3D 0; i < 10; i++)
              buffer[i] =3D 'Z' - i;
          buffer[i] =3D 0;

          printf("\r\ntask1's message for task3: %s\n", buffer );
          err =3D q_send( queue3_id, buffer );
          //err =3D pt_retbuf( part3_id, buffer );
      }=0A=
      =0A=
=0A=
         =20
    }=0A=
   =20
  }=0A=
=20
}
#endif
/*-----------------------------------------------------------------------=
*/
/*
 *  task2  - First consumer task. It tells the producer that it is ready =
to
 *           receive a message by posting an event on which producer is =
pending.
 *           Then it pends on the queue where producer posts the =
message.
 */

void task2( ULONG dummy0, ULONG dummy1, ULONG dummy2, ULONG dummy3 )
{
ULONG err, i;
char foo;
char msg[128];
ULONG msglen;
	 printf( "task2 is running\n");=0A=
=0A=

  for (;;) {=0A=
  =0A=
  tm_wkafter( 200 );=0A=
 =20
    err =3D ev_send( task1_id, EVENT1 );
	=0A=
	#if 1=09
    printf( "\r\ntask2 waiting on vqueue %ld", queue2_id );
    err =3D q_vreceive( queue2_id, Q_WAIT, 0L, msg, 128, &msglen );
    if ( err !=3D ERR_NO_ERROR )
        printf( "\r\nq_vreceive returned error %lx", err );
    else
    {
        printf("\r\ntask2 received message from task1: %s\n", msg);

        for (i =3D 0; msg[i]; i++)
            foo ^=3D msg[i];
    }=0A=
   #endif=20
  }
}

void task3( ULONG dummy0, ULONG dummy1, ULONG dummy2, ULONG dummy3 )
{
    ULONG err;
    int i;
    char foo, *msg;

  for (;;) {=0A=
  tm_wkafter( 200 );
    err =3D ev_send( task1_id, EVENT2 );
	#if 1
    printf( "\r\ntask3 waiting on queue %ld", queue3_id );
    err =3D q_receive( queue3_id, Q_WAIT, 0L, msg );
    if ( err !=3D ERR_NO_ERROR )
        printf( "\r\nq_receive returned error %lx", err );
    else
    {
        printf("\r\ntask3 received message from task1: %s\n", msg);

        for (i =3D 0; msg[i]; i++)
            foo +=3D msg[i];
    }=0A=
    #endif=20
  }
}
=0A=
=0A=
=0A=
void task5( ULONG dummy0, ULONG dummy1, ULONG dummy2, ULONG dummy3 )
{
  =0A=
  printf("\r\nTask5 start running");=0A=
 =20
  for (;;)=0A=
  {=0A=
  	tm_wkafter( 200 );=0A=
  	printf("\r\nTask5 is running");
 	 =20
  }
}=0A=
=0A=
void task4( ULONG dummy0, ULONG dummy1, ULONG dummy2, ULONG dummy3 )
{=0A=
	ULONG err,index;
	=0A=
	printf("\r\nTask4 start running");=0A=
	=0A=
		 printf( "\r\nCreating Queue 2" );=0A=
    err =3D q_vcreate( "QUE2", /*Q_PRIOR*/Q_FIFO, 1, 128, &queue2_id );=0A=
    if ( err !=3D ERR_NO_ERROR )=0A=
        printf( "task4... returned error %lx", err );
 	=0A=
=0A=
    index =3D 0;=09
  for (;;)=0A=
  {=0A=
  	tm_wkafter( 1000);
	index++;
=09
  	printf("\r\nTask4 is running");
	if (index >=3D 10)
	{
		index =3D 0;
		break;
	}
  }
  printf("\r\nTask4 is breaking\n");
  t_delete(0);
  tm_wkafter(1000);
}=0A=
=0A=
=0A=
=0A=
=0A=

/*-----------------------------------------------------------------------=
*/

/************************************************************************=
*****
**  user system initialization, shutdown, and resource cleanup
*************************************************************************=
****/
void
    user_sysroot( void )
{
    ULONG err;
	=0A=
	mlockall(MCL_CURRENT|MCL_FUTURE);=0A=
=0A=
  	#if 1=0A=
     printf( "\r\nCreating Task 4" );
    err =3D t_create( "TSK4", 10, 4096, 4096, T_LOCAL, &task4_id );
    if(err !=3D ERR_NO_ERROR)=0A=
    	printf("\r\nCreating Task 4 error %x", err);
    err =3D t_start( task4_id, T_TSLICE, task4, (ULONG *)NULL );
	if(err !=3D ERR_NO_ERROR)=0A=
    	printf("\r\nStart Task 4 error %x", err);=0A=
    #endif=0A=

    printf( "\r\n" );
}
=0Dint main(void)=0A=
{=0A=
	user_sysroot();=0A=
	int index =3D 0;
	int flag =3D 0;

	for(;;)
	{=0A=
		printf("\n\rmain thread is running\n\r");
		 tm_wkafter(1000);

		 index++;
=09
		if (index >=3D 10)
		{
			if (!flag)
			{
				//t_delete(task4_id);
				flag =3D 1;
			}
		}
		if(index >=3D 20)
			break;
		 =0A=
	}
	t_delete(0);

	return 0;=0A=
}=0A=

------=_NextPart_000_001B_01CB9BAB.05197B20--


