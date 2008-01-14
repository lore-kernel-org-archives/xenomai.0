Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C856EE.43901882"
Date: Mon, 14 Jan 2008 15:42:33 -0500
Message-ID: <BF58A8AFB316514587D61EADBFBF4C41DB1FC4@domain.hid>
From: "Kyle Howell" <khowell@domain.hid>
Subject: [Xenomai-core] [PATCH] Fix typo bug in ipipe_pin_range
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

------_=_NextPart_001_01C856EE.43901882
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C856EE.43901882"


------_=_NextPart_002_01C856EE.43901882
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi,

Ran across these typos in ipipe_pin_pud_range and ipipe_pin_pmd_range. On l=
arge vmas, they cause a lot of extra iteration and may cause some page tabl=
e corruption.

--
Kyle Howell

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20

------_=_NextPart_002_01C856EE.43901882
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7651.59">
<TITLE>[PATCH] Fix typo bug in ipipe_pin_range</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
Ran across these typos in ipipe_pin_pud_range and ipipe_pin_pmd_range. On l=
arge vmas, they cause a lot of extra iteration and may cause some page tabl=
e corruption.<BR>
<BR>
--<BR>
Kyle Howell<BR>
</FONT>
</P>

<pre>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
This email and any files transmitted with it are
confidential and intended solely for the use of the
named recipient or recipients.  If you have received
this email in error please notify the sender
immediately. =20
</pre></BODY>
</HTML>
------_=_NextPart_002_01C856EE.43901882--

------_=_NextPart_001_01C856EE.43901882
Content-Type: text/x-patch;
	name="pin_fix.patch"
Content-Transfer-Encoding: base64
Content-Description: pin_fix.patch
Content-Disposition: attachment;
	filename="pin_fix.patch"

ZGlmZiAtdU5yIGxpbnV4LTIuNi4yMy4xMi1pcGlwZS9tbS9tZW1vcnkuYyBsaW51eC0yLjYuMjMu
MTItaXBpcGUtZml4L21tL21lbW9yeS5jCi0tLSBsaW51eC0yLjYuMjMuMTItaXBpcGUvbW0vbWVt
b3J5LmMJMjAwOC0wMS0xNCAxNTowMDo1OS4wMDAwMDAwMDAgLTA1MDAKKysrIGxpbnV4LTIuNi4y
My4xMi1pcGlwZS1maXgvbW0vbWVtb3J5LmMJMjAwOC0wMS0xNCAxNToxMDowMi4wMDAwMDAwMDAg
LTA1MDAKQEAgLTI5NDYsNyArMjk0Niw3IEBACiAJcG1kID0gcG1kX29mZnNldChwdWQsIGFkZHIp
OwogCWRvIHsKIAkJbmV4dCA9IHBtZF9hZGRyX2VuZChhZGRyLCBlbmQpOwotCQlpZiAoaXBpcGVf
cGluX3B0ZV9yYW5nZShtbSwgcG1kLCB2bWEsIGFkZHIsIGVuZCkpCisJCWlmIChpcGlwZV9waW5f
cHRlX3JhbmdlKG1tLCBwbWQsIHZtYSwgYWRkciwgbmV4dCkpCiAJCQlyZXR1cm4gLUVOT01FTTsK
IAl9IHdoaWxlIChwbWQrKywgYWRkciA9IG5leHQsIGFkZHIgIT0gZW5kKTsKIAlyZXR1cm4gMDsK
QEAgLTI5NjIsNyArMjk2Miw3IEBACiAJcHVkID0gcHVkX29mZnNldChwZ2QsIGFkZHIpOwogCWRv
IHsKIAkJbmV4dCA9IHB1ZF9hZGRyX2VuZChhZGRyLCBlbmQpOwotCQlpZiAoaXBpcGVfcGluX3Bt
ZF9yYW5nZShtbSwgcHVkLCB2bWEsIGFkZHIsIGVuZCkpCisJCWlmIChpcGlwZV9waW5fcG1kX3Jh
bmdlKG1tLCBwdWQsIHZtYSwgYWRkciwgbmV4dCkpCiAJCQlyZXR1cm4gLUVOT01FTTsKIAl9IHdo
aWxlIChwdWQrKywgYWRkciA9IG5leHQsIGFkZHIgIT0gZW5kKTsKIAlyZXR1cm4gMDsK

------_=_NextPart_001_01C856EE.43901882--

