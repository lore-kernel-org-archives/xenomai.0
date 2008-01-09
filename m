Message-ID: <014d01c852bc$5d4bff10$2903050a@domain.hid>
From: "kapilkumar.jain" <kapilkumar.jain@domain.hid>
Date: Wed, 9 Jan 2008 18:07:15 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_014A_01C852EA.76FF8020"
Subject: [Xenomai-core] Interrupt Sharing
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

------=_NextPart_000_014A_01C852EA.76FF8020
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Mr. Jan Kiszka

Long before i have asked solution for Interrupt sharing problem between non=
 real time & real time module,
as i have found it is difficult to disable the non real time.

I have found the solution by return RTDM_IRQ_NONE | XN_ISR_PROPAGATE. from =
the ISR.


Thanks & Regards
Kapil Kumar Jain
SDG | Ext. 249
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


------=_NextPart_000_014A_01C852EA.76FF8020
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
<DIV><FONT face=3DArial size=3D2>Dear Mr. Jan <FONT face=3D"Times New Roman=
"=20
size=3D3>Kiszka</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Long before i have asked solution for Inte=
rrupt=20
sharing problem between non real time &amp; real time module,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>as i have found it is difficult to disable=
 the non=20
real time.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have found the solution by return RTDM_I=
RQ_NONE |=20
XN_ISR_PROPAGATE. from the ISR.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks &amp; Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Kapil Kumar Jain</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>SDG | Ext. 249</FONT></DIV></BODY><br />**=
************** CAUTION - Disclaimer *****************=20
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

------=_NextPart_000_014A_01C852EA.76FF8020--


