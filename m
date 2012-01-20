From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Fri, 20 Jan 2012 10:17:54 -0600
Message-ID: <C65BAE4E2DF04BD68697066C4075EC78@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0187_01CCD75C.C78866B0"
Subject: [Xenomai-help] rtdm difficulties
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

------=_NextPart_000_0187_01CCD75C.C78866B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Using xenomai 2.6.0 with 2.6.38 kernel and rtdm.  Been working on a rtdm
driver for awhile and all of a sudden I've lost stability.  So, I've =
backed
off all code except for registering an empty realtime irq handler using
rtdm_irq_request().  I'm getting kernel oops, and I don't know why?  The =
irq
handler simply returns RTDM_IRQ_HANDLED and that's it.  I've rebuilt my
kernel several times, and I'm wondering if I'm missing a .config entry =
for
something related to xenomai??  If I take out the irq handler =
registration,
all is fine.  This driver's been working for about 2 weeks, but all of a
sudden I'm getting kernel faults.  Here's what I'm getting from my =
driver
(vme_pd_drv):
=20
[  795.986316] Unable to handle kernel paging request at virtual address
80b112d6
[  795.993905] Unable to handle kernel paging request at virtual address
e28cca55
[  796.001475] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.009045] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.016615] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.044130] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.051696] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.059262] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.106868] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.124353] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.131920] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.139484] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.207081] Unable to handle kernel paging request at virtual address
e5bcf074
[  796.214711] pgd =3D c0004000
[  796.217544] [e5bcf074] *pgd=3D00000000
[  796.221294] Internal error: Oops: 5 [#1] PREEMPT
[  796.266149] last sysfs file: =
/sys/devices/virtual/irqdrv/irqdrv0/uevent
[  796.273082] Modules linked in: vme_pd_drv [last unloaded: vme_pd_drv]
[  796.279846] CPU: 0    Not tainted  (2.6.38-ipipe-dirty #53)
[  796.315847] PC is at show_pte+0x18/0xb0
[  796.319868] LR is at __do_kernel_fault+0x54/0x84
[  796.384733] pc : [<c0059170>]    lr : [<c00592f8>]    psr: a0000113
[  796.384740] sp : c058f1c8  ip : fb020000  fp : 0000031b
[  796.396765] r10: 00000005  r9 : 20000113  r8 : 00000000
[  796.402237] r7 : c058f2a8  r6 : e5bcf050  r5 : e5bcf050  r4 : =
e5bcf074
[  796.449104] r3 : c058f1cc  r2 : c04fbb6f  r1 : e5bcf074  r0 : =
c04fbac9
[  796.455945] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment
kernel
[  796.463604] Control: 10c5387d  Table: 9e52c019  DAC: 00000017
[  796.519769] Process =FC (pid: -598785, stack limit =3D 0xc058e2f0)
=20
=20

------=_NextPart_000_0187_01CCD75C.C78866B0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699"></HEAD>
<BODY>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D001431116-20012012>Using =
xenomai 2.6.0=20
with 2.6.38 kernel and rtdm.&nbsp; Been working on a rtdm driver for =
awhile and=20
all of a sudden I've lost stability.&nbsp; So, I've backed off all code =
except=20
for registering an empty realtime irq handler using <FONT=20
size=3D2>rtdm_irq_request().&nbsp; I'm getting kernel oops, and I don't =
know=20
why?&nbsp; The irq handler simply returns <FONT =
size=3D2>RTDM_IRQ_HANDLED and=20
that's it.&nbsp; I've rebuilt my kernel several times, and I'm wondering =
if I'm=20
missing a .config entry for something related to xenomai??&nbsp; If I =
take out=20
the irq handler registration, all is fine.&nbsp; This driver's =
been&nbsp;working=20
for&nbsp;about&nbsp;2 weeks, but all of a sudden I'm getting kernel=20
faults.&nbsp; Here's what I'm getting from my driver=20
(vme_pd_drv):</FONT></FONT></SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D001431116-20012012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>[&nbsp; 795.986316] Unable to handle =
kernel paging=20
request at virtual address 80b112d6<BR>[&nbsp; 795.993905] Unable to =
handle=20
kernel paging request at virtual address e28cca55<BR>[&nbsp; 796.001475] =
Unable=20
to handle kernel paging request at virtual address e5bcf074<BR>[&nbsp;=20
796.009045] Unable to handle kernel paging request at virtual address=20
e5bcf074<BR>[&nbsp; 796.016615] Unable to handle kernel paging request =
at=20
virtual address e5bcf074<BR>[&nbsp; 796.044130] Unable to handle kernel =
paging=20
request at virtual address e5bcf074<BR>[&nbsp; 796.051696] Unable to =
handle=20
kernel paging request at virtual address e5bcf074<BR>[&nbsp; 796.059262] =
Unable=20
to handle kernel paging request at virtual address e5bcf074<BR>[&nbsp;=20
796.106868] Unable to handle kernel paging request at virtual address=20
e5bcf074<BR>[&nbsp; 796.124353] Unable to handle kernel paging request =
at=20
virtual address e5bcf074<BR>[&nbsp; 796.131920] Unable to handle kernel =
paging=20
request at virtual address e5bcf074<BR>[&nbsp; 796.139484] Unable to =
handle=20
kernel paging request at virtual address e5bcf074<BR>[&nbsp; 796.207081] =
Unable=20
to handle kernel paging request at virtual address e5bcf074<BR>[&nbsp;=20
796.214711] pgd =3D c0004000<BR>[&nbsp; 796.217544] [e5bcf074]=20
*pgd=3D00000000<BR>[&nbsp; 796.221294] Internal error: Oops: 5 [#1]=20
PREEMPT<BR>[&nbsp; 796.266149] last sysfs file:=20
/sys/devices/virtual/irqdrv/irqdrv0/uevent<BR>[&nbsp; 796.273082] =
Modules linked=20
in: vme_pd_drv [last unloaded: vme_pd_drv]<BR>[&nbsp; 796.279846] CPU:=20
0&nbsp;&nbsp;&nbsp; Not tainted&nbsp; (2.6.38-ipipe-dirty =
#53)<BR>[&nbsp;=20
796.315847] PC is at show_pte+0x18/0xb0<BR>[&nbsp; 796.319868] LR is at=20
__do_kernel_fault+0x54/0x84<BR>[&nbsp; 796.384733] pc :=20
[&lt;c0059170&gt;]&nbsp;&nbsp;&nbsp; lr : =
[&lt;c00592f8&gt;]&nbsp;&nbsp;&nbsp;=20
psr: a0000113<BR>[&nbsp; 796.384740] sp : c058f1c8&nbsp; ip : =
fb020000&nbsp; fp=20
: 0000031b<BR>[&nbsp; 796.396765] r10: 00000005&nbsp; r9 : =
20000113&nbsp; r8 :=20
00000000<BR>[&nbsp; 796.402237] r7 : c058f2a8&nbsp; r6 : e5bcf050&nbsp; =
r5 :=20
e5bcf050&nbsp; r4 : e5bcf074<BR>[&nbsp; 796.449104] r3 : c058f1cc&nbsp; =
r2 :=20
c04fbb6f&nbsp; r1 : e5bcf074&nbsp; r0 : c04fbac9<BR>[&nbsp; 796.455945] =
Flags:=20
NzCv&nbsp; IRQs on&nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; ISA ARM&nbsp; =
Segment=20
kernel<BR>[&nbsp; 796.463604] Control: 10c5387d&nbsp; Table: =
9e52c019&nbsp; DAC:=20
00000017<BR>[&nbsp; 796.519769] Process =FC (pid: -598785, stack limit =
=3D=20
0xc058e2f0)</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0187_01CCD75C.C78866B0--


