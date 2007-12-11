Message-ID: <00a501c83bee$de20b5c0$2903050a@domain.hid>
From: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
Date: Tue, 11 Dec 2007 17:40:49 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00A2_01C83C1C.F7BC4200"
Subject: [Xenomai-core] Interrupt Handling in Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------=_NextPart_000_00A2_01C83C1C.F7BC4200
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

The problem i faced in Registering Interrupt in Xenomai, if my interrupt li=
ne is shared with the ethernet irqs.

If we register for the interrupt line which is shared by ethernet irqs we w=
ill get the continuous interrupt.

According to the Xenomai interrupt handling - we should return RTDM_IRQ_NON=
E for unhandled interrupt.
and RTDM_IRQ_HANDLED for interrupt handled.

the problem if I return RTDM_IRQ_NONE, system get hanged with message
__XINTIRQ_ No Body cared for IRQ 19

IRQ 19 - same irq sharing with ethernet & my module.

If instead of RTDM_IRQ_NONE i will return 0; it will not hang.
but i am not sure about the functionality when it wil share with some other=
 irq which is important.

what is the meaning of returning 0 from Xenomai ISR?


With Regards
Kapil Kumar Jain
**************** CAUTION - Disclaimer *****************This email may conta=
in confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribu=
tion or disclosure by others is strictly prohibited. If you are not the int=
ended recipient (or authorized to receive for the recipient), please contac=
t the sender by reply email and delete all copies of this message. Also, em=
ail is susceptible to data corruption, interception, tampering, unauthorize=
d amendment and viruses. We only send and receive emails on the basis that =
we are not liable for any such corruption, interception, tampering, amendme=
nt or viruses or any consequence thereof.=20
*********** End of Disclaimer ***********DataPatterns ITS Group**********


------=_NextPart_000_00A2_01C83C1C.F7BC4200
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hello all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The problem i faced in Registering Interru=
pt in=20
Xenomai, if my interrupt line is shared with the ethernet irqs.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If we register for the interrupt line whic=
h is=20
shared by ethernet irqs we will get the continuous interrupt.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>According to the Xenomai interrupt handlin=
g - we=20
should return RTDM_IRQ_NONE for unhandled interrupt.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and RTDM_IRQ_HANDLED for interrupt=20
handled.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>the problem if I return RTDM_IRQ_NONE, sys=
tem get=20
hanged with message</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>__XINTIRQ_ No Body cared for IRQ 19</FONT>=
</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>IRQ 19 - same irq sharing with ethernet &a=
mp; my=20
module.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If instead of RTDM_IRQ_NONE i will return =
0; it=20
will not hang.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>but i am not sure about the functionality =
when it=20
wil share with some other irq which is important.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>what is the meaning of returning 0 from Xe=
nomai=20
ISR?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>With Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kapil Kumar=20
Jain</FONT></DIV></FONT></DIV></BODY><br />**************** CAUTION - Discl=
aimer *****************=20
This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention,
distribution or disclosure by others is strictly prohibited. If you
are not the intended recipient (or authorized to receive for the
recipient), please contact the sender by reply email and delete all
copies of this message. Also, email is susceptible to data
corruption, interception, tampering, unauthorized amendment and
viruses. We only send and receive emails on the basis that we are
not liable for any such corruption, interception, tampering,
amendment or viruses or any consequence thereof.=20
<br />*********** End of Disclaimer ***********
<a href=3D"http://www.datapatternsindia.com/"><b>DataPatterns ITS Group</b>=
</a>**********
<br />
</HTML>

------=_NextPart_000_00A2_01C83C1C.F7BC4200--


