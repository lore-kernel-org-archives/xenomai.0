Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C894D1.AC5667BA"
Date: Wed, 2 Apr 2008 16:56:04 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD381F8@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Xenomai-core] [PATCH] glibcism in src/skins/posix/thread.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C894D1.AC5667BA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Here's attached a patch working around a glibcism. It is necessary=20
for uClib environment. The patch is against Xenomai 2.4.3.

Cheers
--=20
Stephane

------_=_NextPart_001_01C894D1.AC5667BA
Content-Type: application/octet-stream;
	name="posix-skin-glibcism.patch"
Content-Transfer-Encoding: base64
Content-Description: posix-skin-glibcism.patch
Content-Disposition: attachment;
	filename="posix-skin-glibcism.patch"

LS0tIHNyYy9za2lucy9wb3NpeC90aHJlYWQuYwk1IE1hciAyMDA4IDE0OjE1OjQwIC0wMDAwCTEu
MS4xLjUKKysrIHNyYy9za2lucy9wb3NpeC90aHJlYWQuYwkyIEFwciAyMDA4IDA5OjE0OjQxIC0w
MDAwCkBAIC0yODIsNiArMjgyLDggQEAKIAljaGFyIHZlcnNbMTI4XTsKIAlwdGhyZWFkX2F0dHJf
aW5pdCgmZGVmYXVsdF9hdHRyKTsKIAlsaW51eHRocmVhZHMgPQotCQkhY29uZnN0cihfQ1NfR05V
X0xJQlBUSFJFQURfVkVSU0lPTiwgdmVycywgc2l6ZW9mKHZlcnMpKQotCQl8fCBzdHJzdHIodmVy
cywgImxpbnV4dGhyZWFkcyIpOworI2lmZGVmIF9DU19HTlVfTElCUFRIUkVBRF9WRVJTSU9OCisJ
CSFjb25mc3RyKF9DU19HTlVfTElCUFRIUkVBRF9WRVJTSU9OLCB2ZXJzLCBzaXplb2YodmVycykp
IHx8CisjZW5kaWYKKwkJc3Ryc3RyKHZlcnMsICJsaW51eHRocmVhZHMiKTsKIH0K

------_=_NextPart_001_01C894D1.AC5667BA--

