From: "Terry Fryar" <terry.fryar@domain.hid>
Date: Thu, 22 Dec 2011 18:38:37 -0600
Message-ID: <56F449AE83D74177BAC5887692E0EF55@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00AB_01CCC0D8.ECA8DBE0"
Subject: [Xenomai-help] Interrupt numbers
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

------=_NextPart_000_00AB_01CCC0D8.ECA8DBE0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Using Xenomai 2.60 with 2.6.38 omap kernel on beagleboard xm.  
 
Trying to use a GPIO pin as an interrupt and catch this in a xenomai
userspace program.  Got the GPIO132 pin set as an input and is working fine.
I guess I'll need to set the irq enable register on the omap cpu to enable
it to generate irqs.  Now...what irq number do I use in the xenomai
rt_intr_create() function call??  I'm not sure how the omap gpio interrupts
are mapped to the linux kernel/xenomai stuff??  Can I use what's in the
arch/arm/plat-omap/include/plat/irqs.h header file?  It appears that each
bank of GPIO pins has it's own interrupt number??
 
Thanks!
 

------=_NextPart_000_00AB_01CCC0D8.ECA8DBE0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" =
http-equiv=3DContent-Type>
<META name=3DGENERATOR content=3D"MSHTML 8.00.7601.17699"></HEAD>
<BODY>
<DIV><SPAN class=3D143493200-23122011><FONT size=3D2 face=3DArial>Using =
Xenomai 2.60=20
with 2.6.38 omap kernel on beagleboard xm.&nbsp; </FONT></SPAN></DIV>
<DIV><SPAN class=3D143493200-23122011><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D143493200-23122011><FONT size=3D2 face=3DArial>Trying =
to use a GPIO=20
pin as an interrupt and catch this in a xenomai userspace program.&nbsp; =
Got the=20
GPIO132 pin set as an input and is working fine.&nbsp; I guess I'll need =
to set=20
the irq enable register on the omap cpu to enable it to generate =
irqs.&nbsp;=20
</FONT></SPAN><SPAN class=3D143493200-23122011><FONT size=3D2 =
face=3DArial>Now...what=20
irq number do I use in the xenomai&nbsp;<FONT color=3D#642880 =
size=3D2><FONT=20
color=3D#000000 size=3D2>rt_intr_create() function call??&nbsp; I'm not =
sure how the=20
omap gpio interrupts are mapped to the linux kernel/xenomai =
stuff??&nbsp; Can I=20
use what's in the arch/arm/plat-omap/include/plat/irqs.h header =
file?&nbsp; It=20
appears that each bank of GPIO pins has it's own interrupt=20
number??</FONT></FONT></FONT></SPAN></DIV>
<DIV><SPAN class=3D143493200-23122011><FONT size=3D2=20
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D143493200-23122011><FONT size=3D2=20
face=3DArial>Thanks!</FONT></SPAN></DIV>
<DIV><FONT size=3D2 face=3DArial></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_00AB_01CCC0D8.ECA8DBE0--


