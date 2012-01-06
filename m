From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Fri, 6 Jan 2012 08:11:18 -0600
Message-ID: <56E1AEF6484D429588063ADA1D312704@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0019_01CCCC4A.C6259620"
Subject: [Xenomai-help] IRQ issue
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

------=_NextPart_000_0019_01CCCC4A.C6259620
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Using Xen 2.6 with 2.6.38 kernel, have a kernel module with an ISR
registered using rtdm_irq_request() that schedules a work queue.  This queue
thread makes an spi call.
 
All seems to work fine, but I'm seeing this message periodically:
 
[ 4465.323999] Xenomai: unlocking unlocked nucleus lock c0bc79c8 on CPU #0
[ 4465.324010]          owner  = kernel/xenomai/nucleus/intr.c:450
(xnintr_irq_handler(), CPU #0)
[ 4465.340102] [<c00572ac>] (unwind_backtrace+0x0/0xe0) from [<c0055078>]
(show_stack+0x10/0x14)
[ 4465.349080] [<c0055078>] (show_stack+0x10/0x14) from [<c00e1a20>]
(xnintr_irq_handler+0x210/0x3a0)
[ 4465.358524] [<c00e1a20>] (xnintr_irq_handler+0x210/0x3a0) from
[<c00c16dc>] (__ipipe_dispatch_wired_nocheck+0x50/0xa0)
[ 4465.369770] [<c00c16dc>] (__ipipe_dispatch_wired_nocheck+0x50/0xa0) from
[<c006f5f8>] (gpio_demux_inner+0x3c/0x54)
[ 4465.380700] [<c006f5f8>] (gpio_demux_inner+0x3c/0x54) from [<c006f73c>]
(gpio_irq_handler+0x12c/0x168)
[ 4465.390537] [<c006f73c>] (gpio_irq_handler+0x12c/0x168) from [<c0058cb0>]
(__ipipe_handle_irq+0xf0/0x154)
[ 4465.400649] [<c0058cb0>] (__ipipe_handle_irq+0xf0/0x154) from
[<c0058db8>] (__ipipe_grab_irq+0x48/0x64)
[ 4465.410576] [<c0058db8>] (__ipipe_grab_irq+0x48/0x64) from [<c0465bc4>]
(__irq_svc+0x44/0xe8)
[ 4465.419589] [<c0465bc4>] (__irq_svc+0x44/0xe8) from [<c00c189c>]
(__ipipe_unstall_root+0x2c/0x34)
[ 4465.428959] [<c00c189c>] (__ipipe_unstall_root+0x2c/0x34) from
[<c005243c>] (cpu_idle+0x8c/0xe4)
[ 4465.438243] [<c005243c>] (cpu_idle+0x8c/0xe4) from [<c00088bc>]
(start_kernel+0x2b0/0x30c)
[ 4465.446938] [<c00088bc>] (start_kernel+0x2b0/0x30c) from [<80008034>]
(0x80008034)

Not sure what this one means??  I see the "cpu_idle", and I vaguely recall
some issue with that....but I don't remember what this was?

------=_NextPart_000_0019_01CCCC4A.C6259620
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699"></HEAD>
<BODY>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D139120414-06012012>Using =
Xen 2.6 with=20
2.6.38 kernel, have a kernel module with an ISR registered using =
<B><FONT=20
color=3D#642880 size=3D2><FONT color=3D#642880=20
size=3D2>rtdm_irq_request</B></FONT></FONT><FONT size=3D2>() that =
schedules a work=20
queue.&nbsp; This queue thread makes an spi =
call.</FONT></SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D139120414-06012012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D139120414-06012012>All =
seems to work=20
fine, but I'm seeing this message periodically:</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN =
class=3D139120414-06012012></SPAN></FONT><FONT=20
size=3D2 face=3DArial><SPAN =
class=3D139120414-06012012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>[ 4465.323999] Xenomai: unlocking =
unlocked nucleus=20
lock c0bc79c8 on CPU #0<BR>[=20
4465.324010]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
owner&nbsp; =3D=20
kernel/xenomai/nucleus/intr.c:450 (xnintr_irq_handler(), CPU #0)<BR>[=20
4465.340102] [&lt;c00572ac&gt;] (unwind_backtrace+0x0/0xe0) from=20
[&lt;c0055078&gt;] (show_stack+0x10/0x14)<BR>[ 4465.349080] =
[&lt;c0055078&gt;]=20
(show_stack+0x10/0x14) from [&lt;c00e1a20&gt;]=20
(xnintr_irq_handler+0x210/0x3a0)<BR>[ 4465.358524] [&lt;c00e1a20&gt;]=20
(xnintr_irq_handler+0x210/0x3a0) from [&lt;c00c16dc&gt;]=20
(__ipipe_dispatch_wired_nocheck+0x50/0xa0)<BR>[ 4465.369770] =
[&lt;c00c16dc&gt;]=20
(__ipipe_dispatch_wired_nocheck+0x50/0xa0) from [&lt;c006f5f8&gt;]=20
(gpio_demux_inner+0x3c/0x54)<BR>[ 4465.380700] [&lt;c006f5f8&gt;]=20
(gpio_demux_inner+0x3c/0x54) from [&lt;c006f73c&gt;]=20
(gpio_irq_handler+0x12c/0x168)<BR>[ 4465.390537] [&lt;c006f73c&gt;]=20
(gpio_irq_handler+0x12c/0x168) from [&lt;c0058cb0&gt;]=20
(__ipipe_handle_irq+0xf0/0x154)<BR>[ 4465.400649] [&lt;c0058cb0&gt;]=20
(__ipipe_handle_irq+0xf0/0x154) from [&lt;c0058db8&gt;]=20
(__ipipe_grab_irq+0x48/0x64)<BR>[ 4465.410576] [&lt;c0058db8&gt;]=20
(__ipipe_grab_irq+0x48/0x64) from [&lt;c0465bc4&gt;] =
(__irq_svc+0x44/0xe8)<BR>[=20
4465.419589] [&lt;c0465bc4&gt;] (__irq_svc+0x44/0xe8) from =
[&lt;c00c189c&gt;]=20
(__ipipe_unstall_root+0x2c/0x34)<BR>[ 4465.428959] [&lt;c00c189c&gt;]=20
(__ipipe_unstall_root+0x2c/0x34) from [&lt;c005243c&gt;]=20
(cpu_idle+0x8c/0xe4)<BR>[ 4465.438243] [&lt;c005243c&gt;] =
(cpu_idle+0x8c/0xe4)=20
from [&lt;c00088bc&gt;] (start_kernel+0x2b0/0x30c)<BR>[ 4465.446938]=20
[&lt;c00088bc&gt;] (start_kernel+0x2b0/0x30c) from [&lt;80008034&gt;]=20
(0x80008034)<BR></FONT></DIV>
<DIV><SPAN class=3D139120414-06012012><FONT size=3D2 face=3DArial>Not =
sure what this=20
one means??&nbsp; I see the "cpu_idle", and I vaguely recall some issue =
with=20
that....but I don't remember what this =
was?</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_0019_01CCCC4A.C6259620--


