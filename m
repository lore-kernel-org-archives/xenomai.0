Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA8D56.2E12536F"
Date: Mon, 4 Jan 2010 09:54:20 -0600
Message-ID: <181804936ABC2349BE503168465576460D420F21@domain.hid>
References: <181804936ABC2349BE503168465576460D23D749@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Retrieving virq based on hardware irq
	forrt_intr_create
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

------_=_NextPart_001_01CA8D56.2E12536F
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am still trying to figure out a good way to reliably get the irq
numbers from user space.  Would it be better to create an interrupt
object using rt_intr_create in kernel space and then retrieve it in user
space with rt_intr_bind?  This way I can use regular kernel services to
retrieve the irq number and only have to worry about the name I give it
in user space.  This could all be done in a simple kernel module.
=20
Would this cause any problems?  I would then have a basically unused ISR
in kernel space, and in user space I would be handling the interrupt
after returning from rt_intr_wait.  I just want to make sure there
shouldn't be any issue using the interrupts in this manner.
=20
Thanks.


________________________________

From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
On Behalf Of Steve Deiters
Sent: Tuesday, December 15, 2009 11:35 AM
To: xenomai@xenomai.org
Subject: [Xenomai-help] Retrieving virq based on hardware irq
forrt_intr_create


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

------_=_NextPart_001_01CA8D56.2E12536F
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii=
">
<META content=3D"MSHTML 6.00.6000.16809" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN class=3D91=
2254215-04012010>I=20
am still trying to figure out&nbsp;a good way to reliably get the irq=
 numbers=20
from user space.&nbsp; Would it be better to create an interrupt object=
 using=20
rt_intr_create in kernel space and then retrieve it in user space with=20
rt_intr_bind?&nbsp; This way I can use regular kernel services to retrie=
ve the=20
irq number and only have to worry about the name I give it in user space=
.&nbsp;=20
This could all be done in a simple kernel module.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN=20
class=3D912254215-04012010></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN=20
class=3D912254215-04012010>Would this cause any problems?&nbsp; I would=
 then have=20
a basically unused ISR in kernel space, and in user space I would be han=
dling=20
the interrupt after returning from rt_intr_wait.&nbsp; I just want to=
 make sure=20
there shouldn't be any issue using the interrupts in this=20
manner.</SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN=20
class=3D912254215-04012010></SPAN></FONT>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN=20
class=3D912254215-04012010>Thanks.</SPAN></FONT></DIV><FONT face=3DArial=20
size=3D2></FONT><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid] <B>On Behalf Of </B>Steve=20
Deiters<BR><B>Sent:</B> Tuesday, December 15, 2009 11:35 AM<BR><B>To:</B=
>=20
xenomai@xenomai.org<BR><B>Subject:</B> [Xenomai-help] Retrieving virq=
 based on=20
hardware irq forrt_intr_create<BR></FONT><BR></DIV>
<DIV></DIV>
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

------_=_NextPart_001_01CA8D56.2E12536F--


