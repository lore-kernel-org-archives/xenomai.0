Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CC1625.FD4DB1D4"
Date: Thu, 19 May 2011 15:09:29 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF179D0DF@AREXCH02.mra.roland-man.biz>
In-Reply-To: <4DCA52E8.80904@domain.hid>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz><1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>	<4DBFE062.3020902@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E87B@AREXCH02.mra.roland-man.biz>	<4DC03CE8.4050608@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174E92F@AREXCH02.mra.roland-man.biz>	<4DC0F4E0.2070707@domain.hid>	<1183078C0D064042B3AD2D03E3859EF174EA21@domain.hid>	<4DC25C69.5020001@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174ECBA@AREXCH02.mra.roland-man.biz>
	<4DCA52E8.80904@domain.hid>
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

------_=_NextPart_001_01CC1625.FD4DB1D4
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, May 11, 2011 11:12 AM
> ...
> I am sorry to ask you to change your patch again, but the loop is =
quite
> hard to understand. It would be nice if you could use a simple loops
> which copies the pieces of the iovec. So, maybe use two nested loops.

Never mind. I now remade the patch with two nested loops. If you have =
further changes to suggest, please let me know.

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

------_=_NextPart_001_01CC1625.FD4DB1D4
Content-Type: application/octet-stream;
	name="pipe.diff"
Content-Transfer-Encoding: base64
Content-Description: pipe.diff
Content-Disposition: attachment;
	filename="pipe.diff"

SW5kZXg6IHBpcGUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBwaXBlLmMJKHJldmlzaW9uIDM1NTUpCisrKyBw
aXBlLmMJKHJldmlzaW9uIDM2MzgpCkBAIC03MjksOCArNzI5LDggQEAKIAlyZXR1cm4gMDsKIH0K
IAotc3RhdGljIHNzaXplX3QgeG5waXBlX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsCi0JCQkgICBj
aGFyICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQorc3RhdGljIHNzaXplX3QgeG5w
aXBlX3JlYWR2KHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBzdHJ1Y3QgaW92ZWMgKmlvdmVjLAor
CQkJICAgIHVuc2lnbmVkIGxvbmcgbnJfc2VncywgbG9mZl90ICpwcG9zKQogewogCXN0cnVjdCB4
bnBpcGVfc3RhdGUgKnN0YXRlID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwogCWludCBzaWdwZW5kaW5n
LCBlcnIgPSAwOwpAQCAtNzQwLDkgKzc0MCw2IEBACiAJc3NpemVfdCByZXQ7CiAJc3BsX3QgczsK
IAotCWlmICghYWNjZXNzX29rKFZFUklGWV9XUklURSwgYnVmLCBjb3VudCkpCi0JCXJldHVybiAt
RUZBVUxUOwotCiAJeG5sb2NrX2dldF9pcnFzYXZlKCZua2xvY2ssIHMpOwogCiAJaWYgKCF0ZXN0
Yml0cyhzdGF0ZS0+c3RhdHVzLCBYTlBJUEVfS0VSTl9DT05OKSkgewpAQCAtNzgxLDE2ICs3Nzgs
MjYgQEAKIAkgKiBlbnRpcmVseS4KIAkgKi8KIAotCWluYnl0ZXMgPSAwOworCXJldCA9IDA7CiAK
LQlmb3IgKDs7KSB7CisJZm9yICg7IG5yX3NlZ3MtLTsgKytpb3ZlYykKKwl7CisJICAgIGNoYXIg
KmJ1ZiA9IGlvdmVjLT5pb3ZfYmFzZTsKKwkgICAgc2l6ZV90IGNvdW50ID0gaW92ZWMtPmlvdl9s
ZW47CisJCisJICAgIGlmICghYWNjZXNzX29rKFZFUklGWV9XUklURSwgYnVmLCBjb3VudCkpIHsK
KwkJICAgIGVyciA9IC1FRkFVTFQ7CisJCSAgICBicmVhazsKKwkgICAgfQorCisJICAgIGZvciAo
aW5ieXRlcyA9IDA7IGluYnl0ZXMgPCBjb3VudDsgKSB7CiAJCW5ieXRlcyA9IHhucGlwZV9tX3Np
emUobWgpIC0geG5waXBlX21fcmRvZmYobWgpOwogCiAJCWlmIChuYnl0ZXMgKyBpbmJ5dGVzID4g
Y291bnQpCiAJCQluYnl0ZXMgPSBjb3VudCAtIGluYnl0ZXM7CiAKIAkJaWYgKG5ieXRlcyA9PSAw
KQotCQkJYnJlYWs7CisJCQlnb3RvIGNsZWFudXA7CiAKIAkJeG5sb2NrX3B1dF9pcnFyZXN0b3Jl
KCZua2xvY2ssIHMpOwogCQkvKiBNb3JlIGRhdGEgY291bGQgYmUgYXBwZW5kZWQgd2hpbGUgZG9p
bmcgdGhpczogKi8KQEAgLTgwMiwxNSArODA5LDE3IEBACiAKIAkJaWYgKGVycikgewogCQkJZXJy
ID0gLUVGQVVMVDsKLQkJCWJyZWFrOworCQkJZ290byBjbGVhbnVwOwogCQl9CiAKIAkJaW5ieXRl
cyArPSBuYnl0ZXM7CiAJCXhucGlwZV9tX3Jkb2ZmKG1oKSArPSBuYnl0ZXM7CisJCXJldCArPSBu
Ynl0ZXM7CisJICAgIH0KIAl9CiAKLQlzdGF0ZS0+aW9ucmQgLT0gaW5ieXRlczsKLQlyZXQgPSBp
bmJ5dGVzOworY2xlYW51cDoKKwlzdGF0ZS0+aW9ucmQgLT0gcmV0OwogCiAJaWYgKHhucGlwZV9t
X3NpemUobWgpID4geG5waXBlX21fcmRvZmYobWgpKQogCQlwcmVwZW5kcSgmc3RhdGUtPm91dHEs
ICZtaC0+bGluayk7CkBAIC04MzcsNiArODQ2LDEzIEBACiAJcmV0dXJuIGVyciA/IDogcmV0Owog
fQogCitzdGF0aWMgc3NpemVfdCB4bnBpcGVfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwKKwkJCSAg
IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCit7CisJc3RydWN0IGlvdmVj
IGlvdiA9IHsgLmlvdl9iYXNlID0gYnVmLCAuaW92X2xlbiA9IGNvdW50IH07CisJcmV0dXJuIHhu
cGlwZV9yZWFkdihmaWxlLCAmaW92LCAxLCBwcG9zKTsKK30KKwogc3RhdGljIHNzaXplX3QgeG5w
aXBlX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQkJICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6
ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCiB7CkBAIC0xMDYwLDYgKzEwNzYsNyBAQAogc3RhdGlj
IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgeG5waXBlX2ZvcHMgPSB7CiAJLm93bmVyID0gVEhJU19N
T0RVTEUsCiAJLnJlYWQgPSB4bnBpcGVfcmVhZCwKKwkucmVhZHYgPSB4bnBpcGVfcmVhZHYsCiAJ
LndyaXRlID0geG5waXBlX3dyaXRlLAogCS5wb2xsID0geG5waXBlX3BvbGwsCiAJLmlvY3RsID0g
eG5waXBlX2lvY3RsLAo=

------_=_NextPart_001_01CC1625.FD4DB1D4--



