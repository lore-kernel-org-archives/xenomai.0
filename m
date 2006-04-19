content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C663C2.A5518A2C"
Date: Wed, 19 Apr 2006 17:05:07 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290AC5AE4B@BUDMLVEM03.e2k.ad.ge.com>
From: "Thomas, Brieuc \(GE Healthcare\)" <Brieuc.Thomas@domain.hid>
Subject: [Xenomai-help] my tick takes a break !! 
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

------_=_NextPart_001_01C663C2.A5518A2C
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi every one !

I really don't understand, my porting of application works very well
(under vxworks skin), message, semaphore, timer... Except the task !!
I've got a curious behaviour, when I've got a heavy task, the kernel
tick counter stop during the process!!

And take back when this one is finish.

Therefore the other tasks are freeze and my application crash.

=20

have You already seen this case?

=20

Ps: I use xenomai-2.1.0 & kernel2.6.14-6


------_=_NextPart_001_01C663C2.A5518A2C
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D701220114-19042006>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB"><SPAN=20
class=3D701220114-19042006>Hi every one !</SPAN></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">I really=20
don't understand,&nbsp;<SPAN class=3D701220114-19042006>my</SPAN>=20
porting&nbsp;<SPAN class=3D701220114-19042006>of </SPAN>application =
work<SPAN=20
class=3D701220114-19042006>s</SPAN> very well (under vxworks skin), =
message,=20
semaphore, timer...&nbsp;Except the task !!&nbsp;</SPAN><SPAN =
lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">I've=20
got&nbsp;a curious behaviour, when I've got a heavy task, the kernel =
tick=20
counter stop during the process!!</SPAN><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><?xml:namespace prefix =3D o ns =3D=20
"urn:schemas-microsoft-com:office:office" /><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">And take=20
back&nbsp;when this one is finish.</SPAN><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">Therefore=20
the other tasks&nbsp;are freeze and my application crash.</SPAN><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT size=3D3><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">have <SPAN=20
lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">You&nbsp;</SPAN>already=20
seen this case?</SPAN><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><FONT size=3D3><FONT=20
face=3D"Times New Roman">&nbsp;<o:p></o:p></FONT></FONT></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">Ps: I use=20
xenomai-2.1.0 &amp;&nbsp;kernel2.6.14-6</SPAN><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: =
EN-GB"><o:p></o:p></SPAN></P></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN=20
class=3D701220114-19042006></SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C663C2.A5518A2C--

