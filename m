From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Wed, 18 Jan 2012 09:12:42 -0600
Message-ID: <28CCC3D1EEE841E184D8E5663EBDCCBE@TerryHP>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00F9_01CCD5C1.56FAC060"
Subject: [Xenomai-help] Compile error
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

------=_NextPart_000_00F9_01CCD5C1.56FAC060
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Using xenomai 2.6.0 with 2.6.38 kernel.  Turned off
CONFIG_XENO_OPT_PERVASIVE, and now I can't compile kernel:
 
CC      kernel/xenomai/nucleus/synch.o
kernel/xenomai/nucleus/synch.c: In function 'xnsynch_release_thread':
kernel/xenomai/nucleus/synch.c:688:3: error: implicit declaration of
function 'xnthread_get_rescnt'
kernel/xenomai/nucleus/synch.c:689:4: error: implicit declaration of
function 'xnshadow_send_sig'

There are some ifdef's for this flag....how to compile xenomai kernel
without pervasive user support?  Only using kernel modules with xenomai at
this point, and I'm trying to optimize the kernel performance....
 
Thanks!

------=_NextPart_000_00F9_01CCD5C1.56FAC060
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699"></HEAD>
<BODY>
<DIV><FONT size=3D2 face=3DArial><SPAN class=3D917160815-18012012>Using =
xenomai 2.6.0=20
with 2.6.38 kernel.&nbsp; Turned off CONFIG_XENO_OPT_PERVASIVE, and now =
I can't=20
compile kernel:</SPAN></FONT></DIV>
<DIV><FONT size=3D2 face=3DArial><SPAN=20
class=3D917160815-18012012></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2 face=3DArial>CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
kernel/xenomai/nucleus/synch.o<BR>kernel/xenomai/nucleus/synch.c: In =
function=20
'xnsynch_release_thread':<BR>kernel/xenomai/nucleus/synch.c:688:3: =
error:=20
implicit declaration of function=20
'xnthread_get_rescnt'<BR>kernel/xenomai/nucleus/synch.c:689:4: error: =
implicit=20
declaration of function 'xnshadow_send_sig'<BR></FONT></DIV>
<DIV><SPAN class=3D917160815-18012012><FONT size=3D2 face=3DArial>There =
are some=20
ifdef's for this flag....how to compile xenomai kernel without pervasive =
user=20
support?&nbsp; Only using kernel modules with xenomai at this point, and =
I'm=20
trying to optimize the kernel performance....</FONT></SPAN></DIV>
<DIV><SPAN class=3D917160815-18012012><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D917160815-18012012><FONT size=3D2=20
face=3DArial>Thanks!</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_00F9_01CCD5C1.56FAC060--


