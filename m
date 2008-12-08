Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C95951.B542C0B6"
Date: Mon, 8 Dec 2008 17:26:22 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38482@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Xenomai-core] [PATCH] uClibc compile failure
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

------_=_NextPart_001_01C95951.B542C0B6
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

I have bumped on a compilation failure of Xenomai 2.4.6 with uClibc.
The mmap64/ftruncate64 functions may not be available, at all.
So here's an attached patch against 2.4.6, FWIW.

BTW, people stuck with a fascist pthread that lets only superuser use=20
SCHED_FIFO will need the following patch. Same discussion[1] applies.
[1] https://mail.gna.org/public/xenomai-help/2007-05/msg00330.html

--- src/skins/native/task.c     9 Jun 2008 09:38:14 -0000       1.5
+++ src/skins/native/task.c     8 Dec 2008 10:37:55 -0000
@@ -139,7 +139,13 @@

        pthread_attr_setinheritsched(&thattr, PTHREAD_EXPLICIT_SCHED);
        memset(&param, 0, sizeof(param));
-       if (prio > 0) {
+       /* There's a limitation in libpthread
+        * that returns EPERM upon SCHED_FIFO
+        * for non priviledged users.
+        * So workaround this for now.
+        * FIXME (in uClibc/pthread).
+        */
+       if (prio > 0 && geteuid() =3D=3D 0) {
                pthread_attr_setschedpolicy(&thattr, SCHED_FIFO);
                param.sched_priority =3D prio;
        } else

--=20
Stephane

------_=_NextPart_001_01C95951.B542C0B6
Content-Type: application/octet-stream;
	name="xeno-uclibc-link.patch"
Content-Transfer-Encoding: base64
Content-Description: xeno-uclibc-link.patch
Content-Disposition: attachment;
	filename="xeno-uclibc-link.patch"

LS0tIGNvbmZpZ3VyZS5pbgkxNyBOb3YgMjAwOCAxMDo0NzowOSAtMDAwMAkxLjkKKysrIGNvbmZp
Z3VyZS5pbgk4IERlYyAyMDA4IDEwOjExOjU2IC0wMDAwCkBAIC03MzMsNyArNzMzLDcgQEAKIAog
c2F2ZV9MSUJTPSIkTElCUyIKIExJQlM9IiRMSUJTIC1scnQiCi1BQ19DSEVDS19GVU5DUyhbc2ht
X29wZW4gc2htX3VubGlua10pCitBQ19DSEVDS19GVU5DUyhbc2htX29wZW4gc2htX3VubGluayBt
bWFwNjQgZnRydW5jYXRlNjRdKQogTElCUz0iJHNhdmVfTElCUyIKIAogZG5sCi0tLSBzcmMvc2tp
bnMvcG9zaXgvc2htLmMJMTcgTm92IDIwMDggMTA6NDc6MjAgLTAwMDAJMS4zCisrKyBzcmMvc2tp
bnMvcG9zaXgvc2htLmMJOCBEZWMgMjAwOCAxMDoxMTo1NiAtMDAwMApAQCAtMTYwLDggKzE2MCwx
MCBAQAogCWlmICghZXJyKQogCQlyZXR1cm4gMDsKIAorI2lmZGVmIEhBVkVfRlRSVU5DQVRFNjQK
IAlpZiAoZXJyID09IEVCQURGIHx8IGVyciA9PSBFTk9TWVMpCiAJCXJldHVybiBfX3JlYWxfZnRy
dW5jYXRlNjQoZmlsZGVzLCBsZW5ndGgpOworI2VuZGlmCiAKIAllcnJubyA9IGVycjsKIAlyZXR1
cm4gLTE7CkBAIC0xODUsOCArMTg3LDEwIEBACiAJCQkJICgodW5zaWduZWQgbG9uZyBsb25nKSBv
ZmYgPCBMT05HX01BWAogCQkJCSAgPyAobG9uZykgb2ZmIDogLTFMKSwgJm1hcCk7CiAKKyNpZmRl
ZiBIQVZFX01NQVA2NAogCWlmIChlcnIgPT0gRUJBREYgfHwgZXJyID09IEVOT1NZUykKIAkJcmV0
dXJuIF9fcmVhbF9tbWFwNjQoYWRkciwgbGVuLCBwcm90LCBmbGFncywgZmlsZGVzLCBvZmYpOwor
I2VuZGlmCiAKIAlpZiAoZXJyKQogCQlnb3RvIGVycm9yOwpAQCAtMTk2LDggKzIwMCwxMiBAQAog
CWlmIChlcnIpCiAJCWdvdG8gZXJyX21tYXBfZXBpbG9ndWU7CiAKKyNpZmRlZiBIQVZFX01NQVA2
NAogCS8qIG1hcCB0aGUgd2hvbGUgaGVhcC4gKi8KIAl1YWRkciA9IF9fcmVhbF9tbWFwNjQoTlVM
TCwgbWFwLm1hcHNpemUsIHByb3QsIGZsYWdzLCBmaWxkZXMsIDApOworI2Vsc2UKKwl1YWRkciA9
IE1BUF9GQUlMRUQ7CisjZW5kaWYKIAogCWlmICh1YWRkciA9PSBNQVBfRkFJTEVEKSB7CiAJICAg
ICAgZXJyX21tYXBfZXBpbG9ndWU6Cg==

------_=_NextPart_001_01C95951.B542C0B6--

