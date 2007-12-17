Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C840BE.FD5D83FC"
Date: Mon, 17 Dec 2007 16:10:41 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB2E4@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Xenomai-core] [PATCH] I see negative faults
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

------_=_NextPart_001_01C840BE.FD5D83FC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear Xeonmai/I-Pipe maintainers,

Attached is an obvious patch (to me). Part of it is across I-Pipe.
Is there a reason why the counter was declared signed?
--=20
Stephane

------_=_NextPart_001_01C840BE.FD5D83FC
Content-Type: application/octet-stream;
	name="int-faults.patch"
Content-Transfer-Encoding: base64
Content-Description: int-faults.patch
Content-Disposition: attachment;
	filename="int-faults.patch"

ZGlmZiAtdSAtcjEuMS4xLjQgaGFsLmgKLS0tIGluY2x1ZGUvYXNtLWdlbmVyaWMveGVub21haS9o
YWwuaAkyMyBOb3YgMjAwNyAyMjozOTo0MyAtMDAwMAkxLjEuMS40CisrKyBpbmNsdWRlL2FzbS1n
ZW5lcmljL3hlbm9tYWkvaGFsLmgJMTcgRGVjIDIwMDcgMTM6Mzk6MTQgLTAwMDAKQEAgLTM0Myw3
ICszNDMsNyBAQAogCiBleHRlcm4gcnRoYWxfdHJhcF9oYW5kbGVyX3QgcnRoYWxfdHJhcF9oYW5k
bGVyOwogCi1leHRlcm4gaW50IHJ0aGFsX3JlYWx0aW1lX2ZhdWx0c1tSVEhBTF9OUl9DUFVTXVtS
VEhBTF9OUl9GQVVMVFNdOworZXh0ZXJuIHVuc2lnbmVkIHJ0aGFsX3JlYWx0aW1lX2ZhdWx0c1tS
VEhBTF9OUl9DUFVTXVtSVEhBTF9OUl9GQVVMVFNdOwogCiBleHRlcm4gaW50IHJ0aGFsX2FyY2hf
aW5pdCh2b2lkKTsKIAotLS0ga2VybmVsL3hlbm9tYWkvYXJjaC9nZW5lcmljL2hhbC5jCTIxIE5v
diAyMDA3IDEwOjI2OjMzIC0wMDAwCTEuMS4xLjQKKysrIGtlcm5lbC94ZW5vbWFpL2FyY2gvZ2Vu
ZXJpYy9oYWwuYwkxNyBEZWMgMjAwNyAxMzozOToxNiAtMDAwMApAQCAtODUsNyArODUsNyBAQAog
CiBydGhhbF90cmFwX2hhbmRsZXJfdCBydGhhbF90cmFwX2hhbmRsZXI7CiAKLWludCBydGhhbF9y
ZWFsdGltZV9mYXVsdHNbUlRIQUxfTlJfQ1BVU11bUlRIQUxfTlJfRkFVTFRTXTsKK3Vuc2lnbmVk
IHJ0aGFsX3JlYWx0aW1lX2ZhdWx0c1tSVEhBTF9OUl9DUFVTXVtSVEhBTF9OUl9GQVVMVFNdOwog
CiB2b2xhdGlsZSBpbnQgcnRoYWxfc3luY19vcDsKIApAQCAtNjYyLDcgKzY2Miw3IEBACiAgICAg
ICAgIHAgKz0gc3ByaW50ZihwLCAiXG4lM2Q6ICIsIHRyYXApOwogCiAgICAgICAgIGZvcl9lYWNo
X29ubGluZV9jcHUoY3B1KSB7Ci0gICAgICAgICAgICBwICs9IHNwcmludGYocCwgIiUxMmQiLCBy
dGhhbF9yZWFsdGltZV9mYXVsdHNbY3B1XVt0cmFwXSk7CisgICAgICAgICAgICBwICs9IHNwcmlu
dGYocCwgIiUxMnUiLCBydGhhbF9yZWFsdGltZV9mYXVsdHNbY3B1XVt0cmFwXSk7CiAgICAgICAg
IH0KIAogICAgICAgICBwICs9IHNwcmludGYocCwgIiAgICAoJXMpIiwgcnRoYWxfZmF1bHRfbGFi
ZWxzW3RyYXBdKTsK

------_=_NextPart_001_01C840BE.FD5D83FC--

