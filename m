Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CC096A.41D32BDD"
Date: Tue, 3 May 2011 10:15:25 +0200
Message-ID: <1183078C0D064042B3AD2D03E3859EF174E826@domain.hid>
In-Reply-To: <1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz>
References: <1183078C0D064042B3AD2D03E3859EF174E31A@AREXCH02.mra.roland-man.biz><1303849652.1961.7.camel@domain.hid><1183078C0D064042B3AD2D03E3859EF174E3E4@domain.hid><1183078C0D064042B3AD2D03E3859EF174E43D@AREXCH02.mra.roland-man.biz><1303940558.1932.33.camel@domain.hid>
	<1183078C0D064042B3AD2D03E3859EF174E5BC@AREXCH02.mra.roland-man.biz>
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

------_=_NextPart_001_01CC096A.41D32BDD
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: xenomai-help-bounces@domain.hid
[mailto:xenomai-help-bounces@domain.hid]
> On Behalf Of dietmar.schindler@domain.hid
> Sent: Friday, April 29, 2011 8:31 AM
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] message pipe message boundaries
>=20
> > From: Philippe Gerum [mailto:rpm@xenomai.org]
> > Sent: Wednesday, April 27, 2011 11:43 PM
> >
> > On Wed, 2011-04-27 at 14:22 +0200, dietmar.schindler@domain.hid
> > wrote:
> > > ... Wouldn't it be desirable to implement the
> > > readv file operation in the rtpipe driver so that the guarantee
"One
> > > read() per rt_pipe_write()" could cover readv(2) also?
> >
> > No objection to merge this. Patch welcome.
>=20
> Well, I'll try to come up with one.

We at manroland now use (with Xenomai 2.4) the attached patch, which
implements the readv file operation in the rtpipe driver so that the
assertion "One read() per rt_pipe_write()" (message boundaries
preserved) covers readv(2) also.
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

------_=_NextPart_001_01CC096A.41D32BDD
Content-Type: application/octet-stream;
	name="pipe.diff"
Content-Transfer-Encoding: base64
Content-Description: pipe.diff
Content-Disposition: attachment;
	filename="pipe.diff"

SW5kZXg6IGJyYW5jaGVzL01SX1hlbm9tYWkyXzQvc291cmNlL2tzcmMvbnVjbGV1cy9waXBlLmMK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQotLS0gYnJhbmNoZXMvTVJfWGVub21haTJfNC9zb3VyY2Uva3NyYy9udWNsZXVz
L3BpcGUuYwkocmV2aXNpb24gMzU1NSkKKysrIGJyYW5jaGVzL01SX1hlbm9tYWkyXzQvc291cmNl
L2tzcmMvbnVjbGV1cy9waXBlLmMJKHJldmlzaW9uIDM1NTYpCkBAIC03MjksOCArNzI5LDggQEAK
IAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIHNzaXplX3QgeG5waXBlX3JlYWQoc3RydWN0IGZpbGUg
KmZpbGUsCi0JCQkgICBjaGFyICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQorc3Rh
dGljIHNzaXplX3QgeG5waXBlX3JlYWRfdl8oc3RydWN0IGZpbGUgKmZpbGUsIHZvaWQgKmJ1Zl9p
b3ZlYywgc2l6ZV90IGNvdW50LAorCQkJICAgICAgaW50IHYpCiB7CiAJc3RydWN0IHhucGlwZV9z
dGF0ZSAqc3RhdGUgPSBmaWxlLT5wcml2YXRlX2RhdGE7CiAJaW50IHNpZ3BlbmRpbmcsIGVyciA9
IDA7CkBAIC03MzksOSArNzM5LDEyIEBACiAJc3RydWN0IHhuaG9sZGVyICpoOwogCXNzaXplX3Qg
cmV0OwogCXNwbF90IHM7CisJY2hhciAqYnVmOworCXNpemVfdCB2ZWNfY291bnQ7CisJY29uc3Qg
c3RydWN0IGlvdmVjICp2ZWM7CiAKLQlpZiAoIWFjY2Vzc19vayhWRVJJRllfV1JJVEUsIGJ1Ziwg
Y291bnQpKQotCQlyZXR1cm4gLUVGQVVMVDsKKwlpZiAodikJdmVjID0gYnVmX2lvdmVjLCB2ZWNf
Y291bnQgPSBjb3VudCwgY291bnQgPSAwOworCWVsc2UJYnVmID0gYnVmX2lvdmVjOwogCiAJeG5s
b2NrX2dldF9pcnFzYXZlKCZua2xvY2ssIHMpOwogCkBAIC03ODEsOSArNzg0LDIwIEBACiAJICog
ZW50aXJlbHkuCiAJICovCiAKKwlyZXQgPQogCWluYnl0ZXMgPSAwOwogCiAJZm9yICg7Oykgewor
CQlpZiAodikgaWYgKGluYnl0ZXMgPT0gY291bnQpIGlmICh2ZWNfY291bnQpIHsKKwkJICAgIGJ1
ZiA9IHZlYy0+aW92X2Jhc2UsIGNvdW50ID0gdmVjKystPmlvdl9sZW4sIC0tdmVjX2NvdW50Owor
CQkgICAgaW5ieXRlcyA9IDA7CisJCSAgICBpZiAoIWFjY2Vzc19vayhWRVJJRllfV1JJVEUsIGJ1
ZiwgY291bnQpKSB7CisJCQllcnIgPSAtRUZBVUxUOyBicmVhazsKKwkJICAgIH0KKworCQkgICAg
Y29udGludWU7CisJCX0KKwogCQluYnl0ZXMgPSB4bnBpcGVfbV9zaXplKG1oKSAtIHhucGlwZV9t
X3Jkb2ZmKG1oKTsKIAogCQlpZiAobmJ5dGVzICsgaW5ieXRlcyA+IGNvdW50KQpAQCAtODA2LDEx
ICs4MjAsMTEgQEAKIAkJfQogCiAJCWluYnl0ZXMgKz0gbmJ5dGVzOworCQlyZXQgKz0gbmJ5dGVz
OwogCQl4bnBpcGVfbV9yZG9mZihtaCkgKz0gbmJ5dGVzOwogCX0KIAotCXN0YXRlLT5pb25yZCAt
PSBpbmJ5dGVzOwotCXJldCA9IGluYnl0ZXM7CisJc3RhdGUtPmlvbnJkIC09IHJldDsKIAogCWlm
ICh4bnBpcGVfbV9zaXplKG1oKSA+IHhucGlwZV9tX3Jkb2ZmKG1oKSkKIAkJcHJlcGVuZHEoJnN0
YXRlLT5vdXRxLCAmbWgtPmxpbmspOwpAQCAtODM3LDYgKzg1MSwyMSBAQAogCXJldHVybiBlcnIg
PyA6IHJldDsKIH0KIAorc3RhdGljIHNzaXplX3QgeG5waXBlX3JlYWQoc3RydWN0IGZpbGUgKmZp
bGUsCisJCQkgICBjaGFyICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQoreworCWlm
ICghYWNjZXNzX29rKFZFUklGWV9XUklURSwgYnVmLCBjb3VudCkpCisJCXJldHVybiAtRUZBVUxU
OworCisJcmV0dXJuIHhucGlwZV9yZWFkX3ZfKGZpbGUsIGJ1ZiwgY291bnQsIDApOworfQorCitz
dGF0aWMgc3NpemVfdCB4bnBpcGVfcmVhZHYoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IHN0cnVj
dCBpb3ZlYyAqaW92ZWMsCisJCQkgICAgdW5zaWduZWQgbG9uZyBjb3VudCwgbG9mZl90ICpwcG9z
KQoreworCXJldHVybiB4bnBpcGVfcmVhZF92XyhmaWxlLCBpb3ZlYywgY291bnQsIDEpOworfQor
CiBzdGF0aWMgc3NpemVfdCB4bnBpcGVfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsCiAJCQkgICAg
Y29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykKIHsKQEAgLTEwNjAs
NiArMTA4OSw3IEBACiBzdGF0aWMgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyB4bnBpcGVfZm9wcyA9
IHsKIAkub3duZXIgPSBUSElTX01PRFVMRSwKIAkucmVhZCA9IHhucGlwZV9yZWFkLAorCS5yZWFk
diA9IHhucGlwZV9yZWFkdiwKIAkud3JpdGUgPSB4bnBpcGVfd3JpdGUsCiAJLnBvbGwgPSB4bnBp
cGVfcG9sbCwKIAkuaW9jdGwgPSB4bnBpcGVfaW9jdGwsCg==

------_=_NextPart_001_01CC096A.41D32BDD--



