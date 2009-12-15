Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA7DAC.E6A8CE5D"
Date: Tue, 15 Dec 2009 11:34:47 -0600
Message-ID: <181804936ABC2349BE503168465576460D23D749@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Retrieving virq based on hardware irq for
	rt_intr_create
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

------_=_NextPart_001_01CA7DAC.E6A8CE5D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am using a PowerPC processor with an IPIC interrupt controller.  I
know all the interrupt numbers assigned in the IPIC.  From userspace,=
 I
would like to use rt_intr_create to control an interrupt.  However, I
don't know how to reliably retrieve the kernel assigned virq based on
the hardware interrupt number.  I would like to be able to either
retrieve this information somehow, or set up the kernel virq mapping so
that I can force the desired virq mapping to the hardware irq number.
=20
I'm not familiar enough with the kernel irq code to know how to do
either of these.  I browsed through the code in irq.c.  It looks like
the function irq_find_mapping is reserving space for NUM_ISA_INTERRUPTS,
which I don't care about and is preventing me from getting a 1:1 mapping
with the hardware irq.  I suppose I could get rid of that, but I'm
hoping for a more practical solution.
=20
Any help would be appreciated.
=20
Thanks.

------_=_NextPart_001_01CA7DAC.E6A8CE5D
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii=
">
<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D756020717-15122009>I am=
 using a PowerPC=20
processor with an IPIC interrupt controller.&nbsp; I know all the interr=
upt=20
numbers assigned in the IPIC.&nbsp; From userspace, I would like to use=20
rt_intr_create to control an interrupt.&nbsp; However, I don't know how=
 to=20
reliably retrieve the kernel assigned virq based on the hardware interru=
pt=20
number.&nbsp; I would like to be able to either retrieve this informatio=
n=20
somehow, or set up the kernel virq mapping so that I can force the desir=
ed virq=20
mapping to the hardware irq number.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D756020717-15122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D756020717-15122009>I'm=
 not familiar=20
enough with the kernel irq code to know how to do either of these.&nbsp;=
 I=20
browsed through the code in irq.c.&nbsp; It looks like the function=20
irq_find_mapping is reserving space for NUM_ISA_INTERRUPTS, which I don'=
t care=20
about and is preventing me from getting a 1:1 mapping with the hardware=20
irq.&nbsp; I suppose I could get rid of that, but I'm hoping for a more=20
practical solution.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D756020717-15122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D756020717-15122009>Any=
 help would be=20
appreciated.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D756020717-15122009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D756020717-15122009>Thanks.</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01CA7DAC.E6A8CE5D--


