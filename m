Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C80A75.EA0401D6"
Date: Tue, 9 Oct 2007 15:10:42 +0200
Message-ID: <44D6D942646F9E43B7CFFFD3F250EDCD08E9A5@domain.hid>
From: "MEYLAN Jean-philippe" <Jean-philippe.Meylan@domain.hid>
Subject: [Xenomai-help] Semaphore creation problem in user-space
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

------_=_NextPart_001_01C80A75.EA0401D6
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to make a Xenomai target for Mathwork's Real Time Workshop
Embedded Coder and I need to embed the generated code in an user-space
application. My problem is that I cannot create semaphores correctly.
rt_sem_create() returns me the -17 value instead of 0 or one of the
error codes described in the documentation. I cannot figure what is
the cause of the problem.

This problem appears in the small code I've put in attachment.

Have you any idea of what I'm doing wrong ?

Thanks in advance for your reply.

Best regards,

Jean-Philippe



------_=_NextPart_001_01C80A75.EA0401D6
Content-Type: text/x-csrc;
	name="essai2.c"
Content-Transfer-Encoding: base64
Content-Description: essai2.c
Content-Disposition: attachment;
	filename="essai2.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN5cy9tbWFu
Lmg+CiNpbmNsdWRlIDxuYXRpdmUvc2VtLmg+CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgoKCiNk
ZWZpbmUgU1RBQ0tfU0laRSA4MTkyCgpSVF9UQVNLIHRlc3RfdGFza19wdHI7ClJUX1NFTSBzZW1h
RGVzYzsKCnZvaWQgY2xlYW5fZXhpdChpbnQgZHVtbXkpIHsKCXByaW50ZigiY2xlYW51cFxuIik7
CglydF9zZW1fZGVsZXRlKCZzZW1hRGVzYyk7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pIHsKICBpbnQgZXJyLCByZXQ7CgkKICBwcmludGYoInN0YXJ0XG4iKTsKICBzaWduYWwo
U0lHVEVSTSwgY2xlYW5fZXhpdCk7CQogIHNpZ25hbChTSUdJTlQsIGNsZWFuX2V4aXQpOwkKCiAg
bWxvY2thbGwoTUNMX0NVUlJFTlQgfCBNQ0xfRlVUVVJFKTsKCiAgZXJyID0gcnRfc2VtX2NyZWF0
ZSgmc2VtYURlc2MsICJzZW1hIiwgMCwgU19GSUZPKTsKICBpZiAoZXJyKSB7CiAgICAgcHJpbnRm
KCJlcnJvciBzZW1hIDogJWRcbiIsZXJyKTsKICB9CgogIHBhdXNlKCk7CiAgZmZsdXNoKE5VTEwp
OwogIHJldHVybiAwOwp9Cg==

------_=_NextPart_001_01C80A75.EA0401D6--

