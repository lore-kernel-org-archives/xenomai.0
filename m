Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CC0E1B.CC8A1362"
Date: Mon, 9 May 2011 09:36:23 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF174ECBA@AREXCH02.mra.roland-man.biz>
In-Reply-To: <4DC25C69.5020001@domain.hid>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz><1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>	<4DBFE062.3020902@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E87B@AREXCH02.mra.roland-man.biz>	<4DC03CE8.4050608@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>	<4DC0F4E0.2070707@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174EA21@domain.hid>
	<4DC25C69.5020001@domain.hid>
From: <dietmar.schindler@domain.hid>
Subject: Re: [Xenomai-help] message pipe message boundaries
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC0E1B.CC8A1362
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Thursday, May 05, 2011 10:15 AM
> ...
> You can provide the readv implementation, and implement read in terms =
of
> readv by passing an iovec with just one buffer. Please also try and =
make
> the code a bit more readable than in the previous patch, with only one
> statement and one "if" by line.

Hello,

thank you for your suggestions. I now remade the patch accordingly. If =
you have further improvements to suggest, please let me know.

--=20
Dietmar

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

------_=_NextPart_001_01CC0E1B.CC8A1362
Content-Type: application/octet-stream;
	name="pipe.diff"
Content-Transfer-Encoding: base64
Content-Description: pipe.diff
Content-Disposition: attachment;
	filename="pipe.diff"

SW5kZXg6IHBpcGUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBwaXBlLmMJKHJldmlzaW9uIDM1NTUpCisrKyBw
aXBlLmMJKHJldmlzaW9uIDM1NzcpCkBAIC03MjksOCArNzI5LDggQEAKIAlyZXR1cm4gMDsKIH0K
IAotc3RhdGljIHNzaXplX3QgeG5waXBlX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsCi0JCQkgICBj
aGFyICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQorc3RhdGljIHNzaXplX3QgeG5w
aXBlX3JlYWR2KHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBzdHJ1Y3QgaW92ZWMgKmlvdmVjLAor
CQkJICAgIHVuc2lnbmVkIGxvbmcgbnJfc2VncywgbG9mZl90ICpwcG9zKQogewogCXN0cnVjdCB4
bnBpcGVfc3RhdGUgKnN0YXRlID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwogCWludCBzaWdwZW5kaW5n
LCBlcnIgPSAwOwpAQCAtNzM5LDkgKzczOSw4IEBACiAJc3RydWN0IHhuaG9sZGVyICpoOwogCXNz
aXplX3QgcmV0OwogCXNwbF90IHM7Ci0KLQlpZiAoIWFjY2Vzc19vayhWRVJJRllfV1JJVEUsIGJ1
ZiwgY291bnQpKQotCQlyZXR1cm4gLUVGQVVMVDsKKwljaGFyICpidWY7CisJc2l6ZV90IGNvdW50
ID0gMDsKIAogCXhubG9ja19nZXRfaXJxc2F2ZSgmbmtsb2NrLCBzKTsKIApAQCAtNzgyLDggKzc4
MSwyMSBAQAogCSAqLwogCiAJaW5ieXRlcyA9IDA7CisJcmV0ID0gMDsKIAogCWZvciAoOzspIHsK
KwkJaWYgKGluYnl0ZXMgPT0gY291bnQgJiYgbnJfc2VncykgeworCQkJYnVmID0gaW92ZWMtPmlv
dl9iYXNlLCBjb3VudCA9IGlvdmVjKystPmlvdl9sZW47CisJCQktLW5yX3NlZ3M7CisJCQlpbmJ5
dGVzID0gMDsKKwkJCWlmICghYWNjZXNzX29rKFZFUklGWV9XUklURSwgYnVmLCBjb3VudCkpIHsK
KwkJCQllcnIgPSAtRUZBVUxUOworCQkJCWJyZWFrOworCQkJfQorCisJCQljb250aW51ZTsKKwkJ
fQorCiAJCW5ieXRlcyA9IHhucGlwZV9tX3NpemUobWgpIC0geG5waXBlX21fcmRvZmYobWgpOwog
CiAJCWlmIChuYnl0ZXMgKyBpbmJ5dGVzID4gY291bnQpCkBAIC04MDcsMTAgKzgxOSwxMCBAQAog
CiAJCWluYnl0ZXMgKz0gbmJ5dGVzOwogCQl4bnBpcGVfbV9yZG9mZihtaCkgKz0gbmJ5dGVzOwor
CQlyZXQgKz0gbmJ5dGVzOwogCX0KIAotCXN0YXRlLT5pb25yZCAtPSBpbmJ5dGVzOwotCXJldCA9
IGluYnl0ZXM7CisJc3RhdGUtPmlvbnJkIC09IHJldDsKIAogCWlmICh4bnBpcGVfbV9zaXplKG1o
KSA+IHhucGlwZV9tX3Jkb2ZmKG1oKSkKIAkJcHJlcGVuZHEoJnN0YXRlLT5vdXRxLCAmbWgtPmxp
bmspOwpAQCAtODM3LDYgKzg0OSwxMyBAQAogCXJldHVybiBlcnIgPyA6IHJldDsKIH0KIAorc3Rh
dGljIHNzaXplX3QgeG5waXBlX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsCisJCQkgICBjaGFyICpi
dWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQoreworCXN0cnVjdCBpb3ZlYyBpb3YgPSB7
IC5pb3ZfYmFzZSA9IGJ1ZiwgLmlvdl9sZW4gPSBjb3VudCB9OworCXJldHVybiB4bnBpcGVfcmVh
ZHYoZmlsZSwgJmlvdiwgMSwgcHBvcyk7Cit9CisKIHN0YXRpYyBzc2l6ZV90IHhucGlwZV93cml0
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJCSAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3Vu
dCwgbG9mZl90ICpwcG9zKQogewpAQCAtMTA2MCw2ICsxMDc5LDcgQEAKIHN0YXRpYyBzdHJ1Y3Qg
ZmlsZV9vcGVyYXRpb25zIHhucGlwZV9mb3BzID0gewogCS5vd25lciA9IFRISVNfTU9EVUxFLAog
CS5yZWFkID0geG5waXBlX3JlYWQsCisJLnJlYWR2ID0geG5waXBlX3JlYWR2LAogCS53cml0ZSA9
IHhucGlwZV93cml0ZSwKIAkucG9sbCA9IHhucGlwZV9wb2xsLAogCS5pb2N0bCA9IHhucGlwZV9p
b2N0bCwK

------_=_NextPart_001_01CC0E1B.CC8A1362--



