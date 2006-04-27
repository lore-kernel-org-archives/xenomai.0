content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C669DF.69C53E18"
Date: Thu, 27 Apr 2006 11:46:09 +0200
Message-ID: <5B122FD931231D408AC32630D1B1F7290AF754C6@domain.hid>
From: "Thomas, Brieuc \(GE Healthcare\)" <Brieuc.Thomas@domain.hid>
Subject: [Xenomai-help] rt_task_slice() Behaviour
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

------_=_NextPart_001_01C669DF.69C53E18
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I read everywhere than Xenomai scheduler supports round-robin policies,
but I don't find any explanation or example about how to manage it.

I used a Native API, my configuration is:
status=3Dperiodic:setup=3D202:tickval=3D1000000:..

And I would like to have a RR behaviour with a time slice to 10ms, and
the only function than I found to do that is "rt_task_slice(&task, 10)"
: but there is no behaviour change.

I tried to use xnpod_activate_rr, but I can't include pod.h without any
errors. I think it's a stupid question but what I forget to do?

=20

------_=_NextPart_001_01C669DF.69C53E18
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2800.1528" name=3DGENERATOR></HEAD>
<BODY>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">Hello,</SPAN><SPAN=20
lang=3DEN-GB=20
style=3D"FONT-FAMILY: 'Arial Unicode MS'; mso-ansi-language: =
EN-GB"><?xml:namespace=20
prefix =3D o ns =3D "urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB">&nbsp;<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">I read=20
everywhere than Xenomai scheduler supports round-robin policies, but I =
don't=20
find any explanation or example about how to manage it.</SPAN><SPAN =
lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">I used a=20
Native API, my configuration is:=20
status=3Dperiodic:setup=3D202:tickval=3D1000000:..<o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">And I=20
would like to have a RR behaviour with a time slice to 10ms, and the =
only=20
function than I found to do that is "rt_task_slice(&amp;task, 10)" : but =
there=20
is no behaviour change.</SPAN><SPAN lang=3DEN-GB=20
style=3D"mso-ansi-language: EN-GB"><o:p></o:p></SPAN></P>
<P class=3DMsoNormal style=3D"MARGIN: 0cm 0cm 0pt"><SPAN lang=3DEN-GB=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; mso-ansi-language: =
EN-GB">I tried to=20
use xnpod_activate_rr, but I can't include pod.h without any errors. I =
think=20
it's a stupid question but what I forget to do?</SPAN><SPAN lang=3DEN-GB =

style=3D"mso-ansi-language: EN-GB"><o:p></o:p></SPAN></P>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D834381709-27042006></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C669DF.69C53E18--

